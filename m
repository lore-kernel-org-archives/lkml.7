Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855E4C48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 19:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6685320684
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 19:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfGGTls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 15:41:48 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:57826 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727641AbfGGTiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 15:38:14 -0400
Received: from 94.197.121.43.threembb.co.uk ([94.197.121.43] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hkCzC-0006jJ-HB; Sun, 07 Jul 2019 20:38:10 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hkCz8-0005fI-Ef; Sun, 07 Jul 2019 20:38:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Xin Long" <lucien.xin@gmail.com>,
        "Jon Maxwell" <jmaxwell37@gmail.com>,
        "David Ahern" <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 07 Jul 2019 17:54:17 +0100
Message-ID: <lsq.1562518457.887740004@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 110/129] route: set the deleted fnhe fnhe_daddr to 0
 in ip_del_fnhe to fix a race
In-Reply-To: <lsq.1562518456.876074874@decadent.org.uk>
X-SA-Exim-Connect-IP: 94.197.121.43
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.70-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

commit ee60ad219f5c7c4fb2f047f88037770063ef785f upstream.

The race occurs in __mkroute_output() when 2 threads lookup a dst:

  CPU A                 CPU B
  find_exception()
                        find_exception() [fnhe expires]
                        ip_del_fnhe() [fnhe is deleted]
  rt_bind_exception()

In rt_bind_exception() it will bind a deleted fnhe with the new dst, and
this dst will get no chance to be freed. It causes a dev defcnt leak and
consecutive dmesg warnings:

  unregister_netdevice: waiting for ethX to become free. Usage count = 1

Especially thanks Jon to identify the issue.

This patch fixes it by setting fnhe_daddr to 0 in ip_del_fnhe() to stop
binding the deleted fnhe with a new dst when checking fnhe's fnhe_daddr
and daddr in rt_bind_exception().

It works as both ip_del_fnhe() and rt_bind_exception() are protected by
fnhe_lock and the fhne is freed by kfree_rcu().

Fixes: deed49df7390 ("route: check and remove route cache when we get route")
Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/route.c | 4 ++++
 1 file changed, 4 insertions(+)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1279,6 +1279,10 @@ static void ip_del_fnhe(struct fib_nh *n
 		if (fnhe->fnhe_daddr == daddr) {
 			rcu_assign_pointer(*fnhe_p, rcu_dereference_protected(
 				fnhe->fnhe_next, lockdep_is_held(&fnhe_lock)));
+			/* set fnhe_daddr to 0 to ensure it won't bind with
+			 * new dsts in rt_bind_exception().
+			 */
+			fnhe->fnhe_daddr = 0;
 			fnhe_flush_routes(fnhe);
 			kfree_rcu(fnhe, rcu);
 			break;

