Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9837CC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 00:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB3520679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 00:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="pYyEwi+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbfG3ARW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 20:17:22 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.35]:43186 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728195AbfG3ARV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 20:17:21 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 5DF3947094
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 19:17:20 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sFpQhlGCs3Qi0sFpQhW0kN; Mon, 29 Jul 2019 19:17:20 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=D7kzJNqVG7VZ9ECv09vvZ/hGrMRr3ZR7WMVFb+PMcAU=; b=pYyEwi+P+3UMsPlfgyR2FChKCk
        gourTHd7j8AhnZdrB+GACI8F3KTDJKSQIYqWejMjRn8Qdzpv6wzBf3CPHS65GwDGILgxKy7QPcoeQ
        Ff+A9NFoCbVGOOmizE/NTE07bYGLi5vylDAvpbIY1KaGstNlqc1qNnLi4A4nZ5a2hBMYWWCo01NO+
        /+E9z/aB50rkfga7R2ilkVZoTKP6NZ3TPRomQIo5nVY2l+V6hDGe9K74lWp9zAFNKFjwHrqfP+Hxw
        0IjY+Rfs1QUN98+jsKgRJhOkXg0Bc08Rm/3wF/OQfu+tm3FnGbhf975nFO+rXy6Mze8tkS4E5L3t8
        dG5+EAkw==;
Received: from [187.192.11.120] (port=35326 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hsFpP-002utY-40; Mon, 29 Jul 2019 19:17:19 -0500
Date:   Mon, 29 Jul 2019 19:17:15 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Julian Wiedmann <jwi@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] s390/net: Mark expected switch fall-throughs
Message-ID: <20190730001715.GA20706@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hsFpP-002utY-40
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:35326
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warnings (Building: s390):

drivers/s390/net/ctcm_fsms.c: In function ‘ctcmpc_chx_attnbusy’:
drivers/s390/net/ctcm_fsms.c:1703:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (grp->changed_side == 1) {
      ^
drivers/s390/net/ctcm_fsms.c:1707:2: note: here
  case MPCG_STATE_XID0IOWAIX:
  ^~~~

drivers/s390/net/ctcm_mpc.c: In function ‘ctc_mpc_alloc_channel’:
drivers/s390/net/ctcm_mpc.c:358:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (callback)
      ^
drivers/s390/net/ctcm_mpc.c:360:2: note: here
  case MPCG_STATE_XID0IOWAIT:
  ^~~~

drivers/s390/net/ctcm_mpc.c: In function ‘mpc_action_timeout’:
drivers/s390/net/ctcm_mpc.c:1469:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if ((fsm_getstate(rch->fsm) == CH_XID0_PENDING) &&
      ^
drivers/s390/net/ctcm_mpc.c:1472:2: note: here
  default:
  ^~~~~~~
drivers/s390/net/ctcm_mpc.c: In function ‘mpc_send_qllc_discontact’:
drivers/s390/net/ctcm_mpc.c:2087:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (grp->estconnfunc) {
      ^
drivers/s390/net/ctcm_mpc.c:2092:2: note: here
  case MPCG_STATE_FLOWC:
  ^~~~

drivers/s390/net/qeth_l2_main.c: In function ‘qeth_l2_process_inbound_buffer’:
drivers/s390/net/qeth_l2_main.c:328:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (IS_OSN(card)) {
       ^
drivers/s390/net/qeth_l2_main.c:337:3: note: here
   default:
   ^~~~~~~

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/s390/net/ctcm_fsms.c    | 1 +
 drivers/s390/net/ctcm_mpc.c     | 3 +++
 drivers/s390/net/qeth_l2_main.c | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/ctcm_fsms.c b/drivers/s390/net/ctcm_fsms.c
index 1b4ee570b712..4a8a5373cb35 100644
--- a/drivers/s390/net/ctcm_fsms.c
+++ b/drivers/s390/net/ctcm_fsms.c
@@ -1704,6 +1704,7 @@ static void ctcmpc_chx_attnbusy(fsm_instance *fsm, int event, void *arg)
 			grp->changed_side = 2;
 			break;
 		}
+		/* Else, fall through */
 	case MPCG_STATE_XID0IOWAIX:
 	case MPCG_STATE_XID7INITW:
 	case MPCG_STATE_XID7INITX:
diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
index e02f295d38a9..1534420a0243 100644
--- a/drivers/s390/net/ctcm_mpc.c
+++ b/drivers/s390/net/ctcm_mpc.c
@@ -357,6 +357,7 @@ int ctc_mpc_alloc_channel(int port_num, void (*callback)(int, int))
 		/*fsm_newstate(grp->fsm, MPCG_STATE_XID2INITW);*/
 		if (callback)
 			grp->send_qllc_disc = 1;
+		/* Else, fall through */
 	case MPCG_STATE_XID0IOWAIT:
 		fsm_deltimer(&grp->timer);
 		grp->outstanding_xid2 = 0;
@@ -1469,6 +1470,7 @@ static void mpc_action_timeout(fsm_instance *fi, int event, void *arg)
 		if ((fsm_getstate(rch->fsm) == CH_XID0_PENDING) &&
 		   (fsm_getstate(wch->fsm) == CH_XID0_PENDING))
 			break;
+		/* Else, fall through */
 	default:
 		fsm_event(grp->fsm, MPCG_EVENT_INOP, dev);
 	}
@@ -2089,6 +2091,7 @@ static int mpc_send_qllc_discontact(struct net_device *dev)
 			grp->estconnfunc = NULL;
 			break;
 		}
+		/* Else, fall through */
 	case MPCG_STATE_FLOWC:
 	case MPCG_STATE_READY:
 		grp->send_qllc_disc = 2;
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index fd64bc3f4062..cbead3d1b2fd 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -333,7 +333,7 @@ static int qeth_l2_process_inbound_buffer(struct qeth_card *card,
 				card->osn_info.data_cb(skb);
 				break;
 			}
-			/* else unknown */
+			/* Else, fall through */
 		default:
 			dev_kfree_skb_any(skb);
 			QETH_CARD_TEXT(card, 3, "inbunkno");
-- 
2.22.0

