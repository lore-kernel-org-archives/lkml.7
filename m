Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE76C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDD52075D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfCVFX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 01:23:26 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45684 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727545AbfCVFXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 01:23:16 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1h7Ce9-00015x-Mp; Fri, 22 Mar 2019 05:23:13 +0000
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1h7Ce9-0001ob-He; Fri, 22 Mar 2019 05:23:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Willy Tarreau" <w@1wt.eu>, "Jann Horn" <jannh@google.com>
Date:   Fri, 22 Mar 2019 05:20:18 +0000
Message-ID: <lsq.1553232018.988169987@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 06/16] net/appletalk: fix minor pointer leak to
 userspace in SIOCFINDIPDDPRT
In-Reply-To: <lsq.1553232017.771830163@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.64-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Willy Tarreau <w@1wt.eu>

commit 9824dfae5741275473a23a7ed5756c7b6efacc9d upstream.

Fields ->dev and ->next of struct ipddp_route may be copied to
userspace on the SIOCFINDIPDDPRT ioctl. This is only accessible
to CAP_NET_ADMIN though. Let's manually copy the relevant fields
instead of using memcpy().

BugLink: http://blog.infosectcbr.com.au/2018/09/linux-kernel-infoleaks.html
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/appletalk/ipddp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/net/appletalk/ipddp.c
+++ b/drivers/net/appletalk/ipddp.c
@@ -284,8 +284,12 @@ static int ipddp_ioctl(struct net_device
                 case SIOCFINDIPDDPRT:
 			spin_lock_bh(&ipddp_route_lock);
 			rp = __ipddp_find_route(&rcp);
-			if (rp)
-				memcpy(&rcp2, rp, sizeof(rcp2));
+			if (rp) {
+				memset(&rcp2, 0, sizeof(rcp2));
+				rcp2.ip    = rp->ip;
+				rcp2.at    = rp->at;
+				rcp2.flags = rp->flags;
+			}
 			spin_unlock_bh(&ipddp_route_lock);
 
 			if (rp) {

