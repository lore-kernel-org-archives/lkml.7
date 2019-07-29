Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08EEC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92814214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="S1PU0dbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387554AbfG2LDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:03:51 -0400
Received: from gateway30.websitewelcome.com ([192.185.148.2]:27624 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387424AbfG2LDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:03:51 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id A561B4100
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 06:03:49 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id s3RVhoHoR90ons3RVhfwl0; Mon, 29 Jul 2019 06:03:49 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Qp3MYjU9xtCwvEwflfo80+6YQEhXbF1QhokUUB+6Gsk=; b=S1PU0dbz4bGQhEq57U7f2EIUcz
        LKPhyyl6P5P2B3STh+EXR56EnwgWJv5snTRwnnA3CTcaALZJY2QDesZzVe7yvaVyzkBSMfB9PDApM
        5/SrSc74+9NwlZI4GAHGwImsvurL7c+MXyxM8dw/KHOfZ9eoh8HGn50lFHvCWbbi8Gj2u/wYgNoJU
        032qTcs0Eof1R6LCEG6bSShdD5BWzVfc8wAj18vcYFNapJ5IEY+BNtwo8yy/YB8OW14PS7EEoEVfV
        3wVdEEA9plXOJqt+9mQQdfNoYSa+SYxKO00bgZ0R3jf4Vx27vxd0Pol1oprdr1Tjvf0EAPBKUdJx3
        ae/kQHhA==;
Received: from [187.192.11.120] (port=46236 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hs3RU-0007bm-EP; Mon, 29 Jul 2019 06:03:48 -0500
Date:   Mon, 29 Jul 2019 06:03:45 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] scsi: qlogicpti: Mark expected switch fall-throughs
Message-ID: <20190729110345.GA2603@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hs3RU-0007bm-EP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:46236
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warnings (Building: sparc defconfig):

drivers/scsi/qlogicpti.c: In function 'qlogicpti_mbox_command':
drivers/scsi/qlogicpti.c:202:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
  case 6: sbus_writew(param[5], qpti->qregs + MBOX5);
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/qlogicpti.c:203:2: note: here
  case 5: sbus_writew(param[4], qpti->qregs + MBOX4);
  ^~~~
drivers/scsi/qlogicpti.c:203:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
  case 5: sbus_writew(param[4], qpti->qregs + MBOX4);
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/qlogicpti.c:204:2: note: here
  case 4: sbus_writew(param[3], qpti->qregs + MBOX3);
  ^~~~
drivers/scsi/qlogicpti.c:204:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
  case 4: sbus_writew(param[3], qpti->qregs + MBOX3);
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/qlogicpti.c:205:2: note: here
  case 3: sbus_writew(param[2], qpti->qregs + MBOX2);
  ^~~~
drivers/scsi/qlogicpti.c:205:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
  case 3: sbus_writew(param[2], qpti->qregs + MBOX2);
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/qlogicpti.c:206:2: note: here
  case 2: sbus_writew(param[1], qpti->qregs + MBOX1);
  ^~~~
drivers/scsi/qlogicpti.c:206:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
  case 2: sbus_writew(param[1], qpti->qregs + MBOX1);
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/qlogicpti.c:207:2: note: here
  case 1: sbus_writew(param[0], qpti->qregs + MBOX0);
  ^~~~
drivers/scsi/qlogicpti.c:256:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
  case 6: param[5] = sbus_readw(qpti->qregs + MBOX5);
          ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/qlogicpti.c:257:2: note: here
  case 5: param[4] = sbus_readw(qpti->qregs + MBOX4);
  ^~~~
drivers/scsi/qlogicpti.c:257:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
  case 5: param[4] = sbus_readw(qpti->qregs + MBOX4);
          ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/qlogicpti.c:258:2: note: here
  case 4: param[3] = sbus_readw(qpti->qregs + MBOX3);
  ^~~~
drivers/scsi/qlogicpti.c:258:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
  case 4: param[3] = sbus_readw(qpti->qregs + MBOX3);
          ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/qlogicpti.c:259:2: note: here
  case 3: param[2] = sbus_readw(qpti->qregs + MBOX2);
  ^~~~
drivers/scsi/qlogicpti.c:259:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
  case 3: param[2] = sbus_readw(qpti->qregs + MBOX2);
          ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/qlogicpti.c:260:2: note: here
  case 2: param[1] = sbus_readw(qpti->qregs + MBOX1);
  ^~~~
drivers/scsi/qlogicpti.c:260:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
  case 2: param[1] = sbus_readw(qpti->qregs + MBOX1);
          ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/qlogicpti.c:261:2: note: here
  case 1: param[0] = sbus_readw(qpti->qregs + MBOX0);
  ^~~~

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/qlogicpti.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 9335849f6bea..d539beef3ce8 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -200,10 +200,15 @@ static int qlogicpti_mbox_command(struct qlogicpti *qpti, u_short param[], int f
 	/* Write mailbox command registers. */
 	switch (mbox_param[param[0]] >> 4) {
 	case 6: sbus_writew(param[5], qpti->qregs + MBOX5);
+		/* Fall through */
 	case 5: sbus_writew(param[4], qpti->qregs + MBOX4);
+		/* Fall through */
 	case 4: sbus_writew(param[3], qpti->qregs + MBOX3);
+		/* Fall through */
 	case 3: sbus_writew(param[2], qpti->qregs + MBOX2);
+		/* Fall through */
 	case 2: sbus_writew(param[1], qpti->qregs + MBOX1);
+		/* Fall through */
 	case 1: sbus_writew(param[0], qpti->qregs + MBOX0);
 	}
 
@@ -254,10 +259,15 @@ static int qlogicpti_mbox_command(struct qlogicpti *qpti, u_short param[], int f
 	/* Read back output parameters. */
 	switch (mbox_param[param[0]] & 0xf) {
 	case 6: param[5] = sbus_readw(qpti->qregs + MBOX5);
+		/* Fall through */
 	case 5: param[4] = sbus_readw(qpti->qregs + MBOX4);
+		/* Fall through */
 	case 4: param[3] = sbus_readw(qpti->qregs + MBOX3);
+		/* Fall through */
 	case 3: param[2] = sbus_readw(qpti->qregs + MBOX2);
+		/* Fall through */
 	case 2: param[1] = sbus_readw(qpti->qregs + MBOX1);
+		/* Fall through */
 	case 1: param[0] = sbus_readw(qpti->qregs + MBOX0);
 	}
 
-- 
2.22.0

