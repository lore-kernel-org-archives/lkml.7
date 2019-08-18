Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF510C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 06:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BD02146E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 06:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oi8aLfEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfHRGjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 02:39:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36574 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfHRGjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 02:39:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id w2so5308536pfi.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 23:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zCqVA49eqneZ2m8i7AB5nrFD+9hTmOgKjj/rZfQWzX0=;
        b=oi8aLfEb/J/Vp5htFuqiR7U6/N+MbOS04YvFpaw94cIWilEIWawE2gNEOSUfPufcoh
         MaHEsYEc+TXnDTQkKCFpIl61yAM0uqGINZGe0uH04TxbCReRIgkEr1Cb+Ryvu7ImEwsv
         b8wmqYW8N4Ht3lFtEc3uQgl8YCAXxYK9bkMp5SuxcnGJkGjMImHXFOW9xHQurTLrbnHh
         eyZcwgm1aC2OX/thGWG9Svx+FyD4aBJIg9pNTRBKQYocjVQ/qRM4ges/H4D/Vq2Y+0Ln
         w6YZsXtNRT/RA92bfCwN9iPxWVknEPII7TyG8FNAvvnfmI/fALntan+3IIOVzAXcPeZT
         UeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zCqVA49eqneZ2m8i7AB5nrFD+9hTmOgKjj/rZfQWzX0=;
        b=FMqPZ3ydbKVXsjTjC8S+9fg+PKWvuFffOckVgO1M3huiY5x5ZildS11gQAOc8LwTOl
         lvkLlYTp/8jYln1nS6cbxHNAxhXqOgenTXZtcoV/gYn9Wg02lqxv+OM27BEp9HtFcJ8T
         /RjBn++Y3nlvn0FdsS+JZpCCnInggLNzUpLOhQHBicduAIpVypnXTFVwz4qHlSyMiW60
         qjdPGO8tdtP/rnMok7CYdQC5XUiS4b7T7AxsQZi216kDDLkGw62ulM0Sj/GfG9ihktHQ
         W9tdlUExWbq84a9G7zvWdo2TkjQ6w9A6T3vcvdWwBrVipWOmcsLocIXmcqnuE77Ha0Cq
         FOYA==
X-Gm-Message-State: APjAAAW7j985MusjYWiSdV/I1AMSy4QStk/OaJQFEf7UGpwXHRfZRt5s
        ztpzjPdwXGIgkbkWdIZHNaE=
X-Google-Smtp-Source: APXvYqyCJNtGzWq+OsOaRgmYJDr/MV9lWoNlzMQ2TFZOJMaTmnA5c+sdFd9u9/3+Bc1M2ZZ1qrIBzg==
X-Received: by 2002:a63:4823:: with SMTP id v35mr14719638pga.138.1566110379635;
        Sat, 17 Aug 2019 23:39:39 -0700 (PDT)
Received: from localhost.localdomain ([106.51.109.255])
        by smtp.gmail.com with ESMTPSA id t23sm12020349pfl.154.2019.08.17.23.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 23:39:39 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     jonathan@buzzard.org.uk
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH] toshiba: Add correct printk log level while emitting error log
Date:   Sun, 18 Aug 2019 12:09:28 +0530
Message-Id: <1566110368-30133-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

printk function is invoked without specifying KERN_ERR log
level when printing error messages. This commit fixes this.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
 drivers/char/toshiba.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/toshiba.c b/drivers/char/toshiba.c
index 0bdc602..3ad6b18 100644
--- a/drivers/char/toshiba.c
+++ b/drivers/char/toshiba.c
@@ -373,7 +373,7 @@ static int tosh_get_machine_id(void __iomem *bios)
 		   value. This has been verified on a Satellite Pro 430CDT,
 		   Tecra 750CDT, Tecra 780DVD and Satellite 310CDT. */
 #if TOSH_DEBUG
-		printk("toshiba: debugging ID ebx=0x%04x\n", regs.ebx);
+		printk(KERN_DEBUG "toshiba: debugging ID ebx=0x%04x\n", regs.ebx);
 #endif
 		bx = 0xe6f5;
 
@@ -417,7 +417,7 @@ static int tosh_probe(void)
 
 	for (i=0;i<7;i++) {
 		if (readb(bios+0xe010+i)!=signature[i]) {
-			printk("toshiba: not a supported Toshiba laptop\n");
+			printk(KERN_ERR "toshiba: not a supported Toshiba laptop\n");
 			iounmap(bios);
 			return -ENODEV;
 		}
@@ -433,7 +433,7 @@ static int tosh_probe(void)
 	/* if this is not a Toshiba laptop carry flag is set and ah=0x86 */
 
 	if ((flag==1) || ((regs.eax & 0xff00)==0x8600)) {
-		printk("toshiba: not a supported Toshiba laptop\n");
+		printk(KERN_ERR "toshiba: not a supported Toshiba laptop\n");
 		iounmap(bios);
 		return -ENODEV;
 	}
-- 
2.7.4

