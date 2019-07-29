Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E71DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055C6216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3pnYq2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfG2POk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:14:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33386 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbfG2POk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:14:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id f20so19189616pgj.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 08:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sUVkkxLiBOcjL7n7m2BTsdx1XezFFxcHFs8k7F4fZcU=;
        b=a3pnYq2HvbzV3N1fLUfDjj/WuSmDB3T5OEDMUflJXTsZVpwGOQTIiV7N3Rgnf8nusL
         WHpm3jCneh6MtkrRDy23dSvWawKl7hxll8NTe+JDPO/a0cndb9b5prRyrWLgOOskAute
         IFjN1DcNR8PzuRtYiGZ8HjlAhM1qC421yelHKele7dP8QduDKh2K56tNOsxcMbHelbOs
         F1iq5CMufTj6EHXMap3BRpxGtkQXCd6eV/KmokHrJ+nzWgrd7rn+U78xPOWtC4yBBw2U
         hd06zf9au5VW35x6pFJMUD49qfJBSEDFgane71XvUfPEg+y3SyM3W+D1dcAo6OBUO1Yr
         yXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sUVkkxLiBOcjL7n7m2BTsdx1XezFFxcHFs8k7F4fZcU=;
        b=WPs7ycI504jadK/clmwMAJhUiGbXIrDWqekVSprXKDO/zpnBqvcGDKVDr+hNCr3OXO
         hcfd2epvHgGU59CAGiQLy+rV0wC7imMu1KgTb9fJE7/b4F8k7nDXt26fHHsuz3k/XvVm
         fYA70EwhdSHiGDhpL7dDRhbUSx2wvxDGkHw2BkJMsbKo9RT611cjDca9TDWz74ipvszx
         hulp0pE2WWdLTCfUke/md242Kgf9983UZHfCLr4Ub0jOQ3S6Jxr8+4AgFVqvN8h2MvbW
         ANvIakiW6GnEUljVfNEMBtZLAVXQSHYqV5s+rFWhXf1b2/txvBOrg/ZqQEctga64Ilo1
         3LDw==
X-Gm-Message-State: APjAAAWQiDWOUodIx1S7Iigc72nRIKZ7Ax9sVMoIy+kcWKbkC+3P6KeG
        CgBMGkap6ohvhQ+HeyZIXkbFVWTKzl4=
X-Google-Smtp-Source: APXvYqxRg6/ZfQqaghfZj/a90EdRN0IeqH/XobunqyB1g5Uik17obS/mnb0/EMuQBKGMvQ8o7SdHnw==
X-Received: by 2002:a17:90a:9905:: with SMTP id b5mr1800954pjp.70.1564413279515;
        Mon, 29 Jul 2019 08:14:39 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id y194sm29688557pfg.116.2019.07.29.08.14.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 08:14:38 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 05/12] genirq/debugfs: Replace strncmp with str_has_prefix
Date:   Mon, 29 Jul 2019 23:14:34 +0800
Message-Id: <20190729151435.9498-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncmp(str, const, len) is error-prone.
We had better use newly introduced
str_has_prefix() instead of it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 kernel/irq/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index c1eccd4f6520..85d1e9aeb8ea 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -188,7 +188,7 @@ static ssize_t irq_debug_write(struct file *file, const char __user *user_buf,
 	if (copy_from_user(buf, user_buf, size))
 		return -EFAULT;
 
-	if (!strncmp(buf, "trigger", size)) {
+	if (str_has_prefix(buf, "trigger")) {
 		unsigned long flags;
 		int err;
 
-- 
2.20.1

