Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDD9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5F721734
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901673;
	bh=xo/aSHFm+/h8RTG8CkNYZ5BHIkHszApkz7/t/ZSm4gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=chZMiJBr/yfrB4cse2JqP9G7E2oebYZlh2RF6mUlWb7e2pws9QdNaNZ0hliUPsp67
	 QNHICc67qOVEvO7HjG2tUj6EG5AeeJA/Mw0xy2Lrdm6RMaIu6lXFG3N4LGky5nOvo8
	 pcNO6uq6bZVJObLjlROJbJ1/BnZgFS0TEN6jvi/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387416AbfCRJec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:34:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387401AbfCRJea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:34:30 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91E092083D;
        Mon, 18 Mar 2019 09:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901670;
        bh=xo/aSHFm+/h8RTG8CkNYZ5BHIkHszApkz7/t/ZSm4gM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SGEmWjkRPEGhrIastiXIQYfW24eme2sQi0fHg9fF+whdm/wjGlYE6uEUWmaAztovF
         sWd+HuWX1c6qXAeUqMtFwdworVtDI8UU+SGEvlHMPz4XpEb95pkLCmPEwaBCIFnHWb
         Beg9BFZg5LcXM6CMZHZfntH0iGskQg+scDAILOAA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Maxwell <jmaxwell37@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 13/34] route: set the deleted fnhe fnhe_daddr to 0 in ip_del_fnhe to fix a race
Date:   Mon, 18 Mar 2019 10:25:37 +0100
Message-Id: <20190318084146.508325070@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084144.657740413@linuxfoundation.org>
References: <20190318084144.657740413@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit ee60ad219f5c7c4fb2f047f88037770063ef785f ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/route.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1315,6 +1315,10 @@ static void ip_del_fnhe(struct fib_nh *n
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


