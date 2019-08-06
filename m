Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BACC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABC1208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="VSLzJXXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732278AbfHFI3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:29:13 -0400
Received: from gateway36.websitewelcome.com ([192.185.195.25]:30405 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbfHFI3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:29:08 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 115B4400C7A51
        for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2019 02:53:40 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id uuqBh1jbk2qH7uuqBh2e7S; Tue, 06 Aug 2019 03:29:07 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WVAi0vZcLPXALGm+zh7ti9JDHwAnJCM0op5bLb/Mk3w=; b=VSLzJXXT7nHuLGrQFBFMGdZgZ3
        xcmZmZegT8ArbZCoOmm8NDGWYi27CDkR2icGD+btZlUoFGtTwFvUX1YTfnPjHkj7QDlbTRN6LQzIK
        wxmb4DRV0M2rXmLDSpAbkTsL5wCioyrbqeJrBkF0HYNeyxZbqc8wet05waMxiHzkz7XcCKnoTDeuQ
        19rAesSQ7qHGIOc9ivqKc5YJFzJ1JUEmy9GTEVxVwXPRR3K5Il/vLm24Nhdz82ruP3RrvgmxxkVqG
        VshRsgW1jXGJNBbGaPPOruhIIKATwSlxrh3vcXio44JisZmK5xJwLtVqoOMNltXXCFViF6HHcCpoC
        txBRGWvw==;
Received: from [187.192.11.120] (port=44456 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1huuq9-000v9N-Fr; Tue, 06 Aug 2019 03:29:05 -0500
Date:   Tue, 6 Aug 2019 03:29:02 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Russell King <linux@armlinux.org.uk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] scsi: fas216: Mark expected switch fall-throughs
Message-ID: <20190806082902.GA11122@embeddedor>
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
X-Exim-ID: 1huuq9-000v9N-Fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:44456
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

Fix the following warnings (Building: rpc_defconfig arm):

drivers/scsi/arm/fas216.c: In function ‘fas216_disconnect_intr’:
drivers/scsi/arm/fas216.c:913:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (fas216_get_last_msg(info, info->scsi.msgin_fifo) == ABORT) {
      ^
drivers/scsi/arm/fas216.c:919:2: note: here
  default:    /* huh?     */
  ^~~~~~~
drivers/scsi/arm/fas216.c: In function ‘fas216_kick’:
drivers/scsi/arm/fas216.c:1959:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   fas216_allocate_tag(info, SCpnt);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/arm/fas216.c:1960:2: note: here
  case TYPE_OTHER:
  ^~~~
drivers/scsi/arm/fas216.c: In function ‘fas216_busservice_intr’:
drivers/scsi/arm/fas216.c:1413:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   fas216_stoptransfer(info);
   ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/arm/fas216.c:1414:2: note: here
  case STATE(STAT_STATUS, PHASE_SELSTEPS):/* Sel w/ steps -> Status       */
  ^~~~
drivers/scsi/arm/fas216.c:1424:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   fas216_stoptransfer(info);
   ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/arm/fas216.c:1425:2: note: here
  case STATE(STAT_MESGIN, PHASE_COMMAND): /* Command -> Message In */
  ^~~~
drivers/scsi/arm/fas216.c: In function ‘fas216_funcdone_intr’:
drivers/scsi/arm/fas216.c:1573:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if ((stat & STAT_BUSMASK) == STAT_MESGIN) {
      ^
drivers/scsi/arm/fas216.c:1579:2: note: here
  default:
  ^~~~~~~
drivers/scsi/arm/fas216.c: In function ‘fas216_handlesync’:
drivers/scsi/arm/fas216.c:605:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
   info->scsi.phase = PHASE_MSGOUT_EXPECT;
   ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
drivers/scsi/arm/fas216.c:607:2: note: here
  case async:
  ^~~~

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/arm/fas216.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/arm/fas216.c b/drivers/scsi/arm/fas216.c
index aea4fd73c862..6c68c2303638 100644
--- a/drivers/scsi/arm/fas216.c
+++ b/drivers/scsi/arm/fas216.c
@@ -603,6 +603,7 @@ static void fas216_handlesync(FAS216_Info *info, char *msg)
 		msgqueue_flush(&info->scsi.msgs);
 		msgqueue_addmsg(&info->scsi.msgs, 1, MESSAGE_REJECT);
 		info->scsi.phase = PHASE_MSGOUT_EXPECT;
+		/* fall through */
 
 	case async:
 		dev->period = info->ifcfg.asyncperiod / 4;
@@ -915,6 +916,7 @@ static void fas216_disconnect_intr(FAS216_Info *info)
 			fas216_done(info, DID_ABORT);
 			break;
 		}
+		/* else, fall through */
 
 	default:				/* huh?					*/
 		printk(KERN_ERR "scsi%d.%c: unexpected disconnect in phase %s\n",
@@ -1411,6 +1413,8 @@ static void fas216_busservice_intr(FAS216_Info *info, unsigned int stat, unsigne
 	case STATE(STAT_STATUS, PHASE_DATAOUT): /* Data Out     -> Status       */
 	case STATE(STAT_STATUS, PHASE_DATAIN):  /* Data In      -> Status       */
 		fas216_stoptransfer(info);
+		/* fall through */
+
 	case STATE(STAT_STATUS, PHASE_SELSTEPS):/* Sel w/ steps -> Status       */
 	case STATE(STAT_STATUS, PHASE_MSGOUT):  /* Message Out  -> Status       */
 	case STATE(STAT_STATUS, PHASE_COMMAND): /* Command      -> Status       */
@@ -1422,6 +1426,8 @@ static void fas216_busservice_intr(FAS216_Info *info, unsigned int stat, unsigne
 	case STATE(STAT_MESGIN, PHASE_DATAOUT): /* Data Out     -> Message In   */
 	case STATE(STAT_MESGIN, PHASE_DATAIN):  /* Data In      -> Message In   */
 		fas216_stoptransfer(info);
+		/* fall through */
+
 	case STATE(STAT_MESGIN, PHASE_COMMAND):	/* Command	-> Message In	*/
 	case STATE(STAT_MESGIN, PHASE_SELSTEPS):/* Sel w/ steps -> Message In   */
 	case STATE(STAT_MESGIN, PHASE_MSGOUT):  /* Message Out  -> Message In   */
@@ -1575,6 +1581,7 @@ static void fas216_funcdone_intr(FAS216_Info *info, unsigned int stat, unsigned
 			fas216_message(info);
 			break;
 		}
+		/* else, fall through */
 
 	default:
 		fas216_log(info, 0, "internal phase %s for function done?"
@@ -1957,6 +1964,7 @@ static void fas216_kick(FAS216_Info *info)
 	switch (where_from) {
 	case TYPE_QUEUE:
 		fas216_allocate_tag(info, SCpnt);
+		/* fall through */
 	case TYPE_OTHER:
 		fas216_start_command(info, SCpnt);
 		break;
-- 
2.22.0

