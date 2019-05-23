Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17F1C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 01:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9227C2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 01:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+MViJB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbfEWBjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 21:39:25 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42727 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfEWBjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 21:39:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id l25so6616368eda.9;
        Wed, 22 May 2019 18:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NKATGLeNnniTBFpU50i8agrrLlqQcy95+OH3gC4PMT8=;
        b=u+MViJB9B2kgG2a4MaeIpZL8gjHhUl3RRaTjXuleISXPUcVyDs3nCGV2mrkUU0Gfli
         qPYh1LjGdRzRwfbeqGoBKFGcQtYAVC6NtwqsaIKwqRyKWSE/kQMp2JS38KM4rLrNCm81
         ABu9HRv1b0m+D/4QZEovMWQlVwhw20GIKTmCZ1dGLSYcggRXVQQEM4YUjEvdYx42HGXg
         C16zi8KgabNgzFjbl3h+6ajnbz/pvoD3scaZEXC/tNjYQEhS8+eF1aFMWaUmu+1FHctu
         MgT5xxVDVlOANgkBuz+3lf0oVOIk/ZneZ1emQyJhCgJtUKRP1iIBtKszftz6YiCUdMeG
         9ZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NKATGLeNnniTBFpU50i8agrrLlqQcy95+OH3gC4PMT8=;
        b=CCMXREslL2uONO32eKv1zZ/khnB/HARNj2bJ3C8DrQ3loyW+pRTmJk22czTVuuF2Tn
         9/b0EdjLBFeBbiusDb2PTaiRdjDhwj30927rDg1wHsok5RZ2p6blp7mh8vDBBah9big8
         4lJAtbM7drA2SN5Mr1pADtuMo8L5QAHAbJ+V73TZvdZT5uCHVaF17xpaqtkcG7zPHIkG
         8WE7rO7REKgQB/9FXXPD88VHFUjCMRq7RKLUxSV3rOOVqqik8sTwHje7z4aPQpKNFhS8
         5PVEDLZn6gEhHflGqbp3xsZZ+aBJrB5p9Ic8LE10xvXQxf2alhWHZ+zw7kavWYEaxRjb
         IDCw==
X-Gm-Message-State: APjAAAWSuok92QiX9iqGPEM4gIpaqxK3hlUFZkjeTvvfd45mgIx1licd
        wY/NdagCZZauPrt3+nNLv9A=
X-Google-Smtp-Source: APXvYqzFHrp2yRn2Vtm3VTNZBtFzuYr2Gy7RFeF6eg84Z8+woNf2GoaXkYvzJTM1q8Zzou7UWB4yfw==
X-Received: by 2002:a50:ce06:: with SMTP id y6mr93652104edi.160.1558575562868;
        Wed, 22 May 2019 18:39:22 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id w5sm7725340edd.19.2019.05.22.18.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 18:39:21 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Don Brace <don.brace@microsemi.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] scsi: hpsa: Avoid using dev uninitialized in hpsa_eh_device_reset_handler
Date:   Wed, 22 May 2019 18:38:59 -0700
Message-Id: <20190523013859.14778-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0.rc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/scsi/hpsa.c:5964:6: warning: variable 'dev' is used
uninitialized whenever 'if' condition is true
[-Wsometimes-uninitialized]
        if (lockup_detected(h)) {
            ^~~~~~~~~~~~~~~~~~
drivers/scsi/hpsa.c:6042:6: note: uninitialized use occurs here
        if (dev)
            ^~~
drivers/scsi/hpsa.c:5964:2: note: remove the 'if' if its condition is
always false
        if (lockup_detected(h)) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/hpsa.c:5950:29: note: initialize the variable 'dev' to
silence this warning
        struct hpsa_scsi_dev_t *dev;
                                   ^
                                    = NULL
1 warning generated.

dev is potentially used uninitialized in the return_reset_status block
for a NULL check if the first 'if (lockup_detected(h))' is taken, as
dev is initialized right after that block. Initialize dev to NULL in
its declaration so that it can be safely checked within the
return_reset_status block.

Fixes: 14991a5bade5 ("scsi: hpsa: correct device resets")
Link: https://github.com/ClangBuiltLinux/linux/issues/492
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/scsi/hpsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index c560a4532733..ac8338b0571b 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -5947,7 +5947,7 @@ static int hpsa_eh_device_reset_handler(struct scsi_cmnd *scsicmd)
 	int rc = SUCCESS;
 	int i;
 	struct ctlr_info *h;
-	struct hpsa_scsi_dev_t *dev;
+	struct hpsa_scsi_dev_t *dev = NULL;
 	u8 reset_type;
 	char msg[48];
 	unsigned long flags;
-- 
2.22.0.rc1

