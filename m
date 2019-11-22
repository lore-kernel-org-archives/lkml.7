Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF19EC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC512071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419281;
	bh=YWaFJwHRcxWDbhkR+hZxM1T/r643o/UQYp0ATZ5LpZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cqQrz6KRuzgi55D33vnGN84/GJRz40d1Xz8p4aeRcb0CJOLXHBhfCJahFncSqxINo
	 Yosr+oJnTLnd6Lnr52mWbBJvrHlPuEwpfpl8xYr8iYy7tgdCokHfpbtJo9D9Cn8g67
	 Skr7aJ23K3puTjO3AiI80sOAsSOp2nd2wE9GoCXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfKVKlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:41:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728990AbfKVKlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:41:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE1C92073B;
        Fri, 22 Nov 2019 10:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419277;
        bh=YWaFJwHRcxWDbhkR+hZxM1T/r643o/UQYp0ATZ5LpZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZW02fS9omoaffFLeySYKAfl3VQv7hA5EbVGCXFX1vrJvwiR3vTitIs/oVBXtgvfc3
         cwRS7JB4r2X+KzxRcz8qOPhlBdSv7lyyYYFwhbHI8iNz2eslOcjSztHWnHZYT3FgeX
         mhsYGlCllEptgc9JZcIe/yU5aYbXwFnv2SI1gxVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Wilcox <matthew.wilcox@oracle.com>,
        George Kennedy <george.kennedy@oracle.com>,
        Mark Kanda <mark.kanda@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 056/222] scsi: sym53c8xx: fix NULL pointer dereference panic in sym_int_sir()
Date:   Fri, 22 Nov 2019 11:26:36 +0100
Message-Id: <20191122100856.772482212@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Kennedy <george.kennedy@oracle.com>

[ Upstream commit 288315e95264b6355e26609e9dec5dc4563d4ab0 ]

sym_int_sir() in sym_hipd.c does not check the command pointer for NULL before
using it in debug message prints.

Suggested-by: Matthew Wilcox <matthew.wilcox@oracle.com>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
Acked-by: Matthew Wilcox <matthew.wilcox@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/sym53c8xx_2/sym_hipd.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/sym53c8xx_2/sym_hipd.c b/drivers/scsi/sym53c8xx_2/sym_hipd.c
index c6425e3df5a04..f1c7714377524 100644
--- a/drivers/scsi/sym53c8xx_2/sym_hipd.c
+++ b/drivers/scsi/sym53c8xx_2/sym_hipd.c
@@ -4371,6 +4371,13 @@ static void sym_nego_rejected(struct sym_hcb *np, struct sym_tcb *tp, struct sym
 	OUTB(np, HS_PRT, HS_BUSY);
 }
 
+#define sym_printk(lvl, tp, cp, fmt, v...) do { \
+	if (cp)							\
+		scmd_printk(lvl, cp->cmd, fmt, ##v);		\
+	else							\
+		starget_printk(lvl, tp->starget, fmt, ##v);	\
+} while (0)
+
 /*
  *  chip exception handler for programmed interrupts.
  */
@@ -4416,7 +4423,7 @@ static void sym_int_sir(struct sym_hcb *np)
 	 *  been selected with ATN.  We do not want to handle that.
 	 */
 	case SIR_SEL_ATN_NO_MSG_OUT:
-		scmd_printk(KERN_WARNING, cp->cmd,
+		sym_printk(KERN_WARNING, tp, cp,
 				"No MSG OUT phase after selection with ATN\n");
 		goto out_stuck;
 	/*
@@ -4424,7 +4431,7 @@ static void sym_int_sir(struct sym_hcb *np)
 	 *  having reselected the initiator.
 	 */
 	case SIR_RESEL_NO_MSG_IN:
-		scmd_printk(KERN_WARNING, cp->cmd,
+		sym_printk(KERN_WARNING, tp, cp,
 				"No MSG IN phase after reselection\n");
 		goto out_stuck;
 	/*
@@ -4432,7 +4439,7 @@ static void sym_int_sir(struct sym_hcb *np)
 	 *  an IDENTIFY.
 	 */
 	case SIR_RESEL_NO_IDENTIFY:
-		scmd_printk(KERN_WARNING, cp->cmd,
+		sym_printk(KERN_WARNING, tp, cp,
 				"No IDENTIFY after reselection\n");
 		goto out_stuck;
 	/*
@@ -4461,7 +4468,7 @@ static void sym_int_sir(struct sym_hcb *np)
 	case SIR_RESEL_ABORTED:
 		np->lastmsg = np->msgout[0];
 		np->msgout[0] = M_NOOP;
-		scmd_printk(KERN_WARNING, cp->cmd,
+		sym_printk(KERN_WARNING, tp, cp,
 			"message %x sent on bad reselection\n", np->lastmsg);
 		goto out;
 	/*
-- 
2.20.1



