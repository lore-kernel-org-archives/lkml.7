Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12CFC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E49225855
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UA9Qb3+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfE3Ldq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 07:33:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44733 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfE3Ldq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 07:33:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so1849841pgp.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 04:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=uHUXjMAxZ7f333Sg3vEFlgpoxeG65zBCwY0OPq6Zo+E=;
        b=UA9Qb3+onXN9DfXKGJbKzo+8eEwp5c/WM6aaU5+cPTOH2z8CCpCkPaZaGjeRtCBWpm
         qqIdRAp4vsLorCov67VVFrnBIvtuseEm4MS1lbBy0tgsnAmtYkTPl0SxCkgDEKA0MxTn
         sBOFCUQsGsXIlaLJ4xk8dEhlJmWLHjsh2NWEyYBPxhTIOEBnazitt4jHPoIFc9oVe/EX
         8+03Haum8GOOsPuxCMP8aaopsCnBUrs2zO4YUyLhtKVm8t5S//xVfXujs3xVgRp9ZiJY
         6bh6GqhgDiW4i4+cSvUlf8GHlhlA5V4zZBD9PFrlcwp0V6MWKv0fwl9WuL+c4k6RpPRj
         iDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=uHUXjMAxZ7f333Sg3vEFlgpoxeG65zBCwY0OPq6Zo+E=;
        b=CMpCP8EgRd6CMTF6mdj/21KloWxIIs+ji9wzenIZFExTnFOeb1GnmT5D1VhBb1ph0j
         Z7qdrjxaZ0O8KzBO3KwyhQmTSC+2hRsbTAY5P1otzyg50YemhNOLNEqyX31DYMEzxkPB
         kz2NOmCp+h9XewkdO2+vgcNgdMxU4x7o9NVw7T7YQSiMzlK2KTaHeX95HF+4URMKHL5f
         2k4ZiC0d8rw+W7TMY9s4jxpzCwJ8XiHCWFaL9WrAl07txH+WanVdq6OUFggyHm/jaWU/
         sqnbfv6jPyfdD7Ly1b+XP7UFJVVRt7CBafmYNqA58ZMv8/oqNcuPRnseheD6+XYm1Qck
         iDyQ==
X-Gm-Message-State: APjAAAVSxSW/yRbwdxjYqOjNhyO0wOCOK0HPLDtBQfaAd2V8Yrv5KDF3
        HN2el0KvA9jj3XT+hqKy0+BF+Gps
X-Google-Smtp-Source: APXvYqyhYJGrTjocqyHSUYlQlckWxxyWSNYTDPqcXq/sUyBIJyx4S0nWLmYDjFWxUf3adWf78uuM9Q==
X-Received: by 2002:aa7:8a95:: with SMTP id a21mr3273783pfc.215.1559216025909;
        Thu, 30 May 2019 04:33:45 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z9sm2170387pgc.82.2019.05.30.04.33.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 04:33:44 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matt Sickler <Matt.Sickler@daktronics.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] staging: kpc2000: Fix build failure caused by wrong include file
Date:   Thu, 30 May 2019 04:33:42 -0700
Message-Id: <1559216022-644-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xtensa:allmodconfig fails to build.

arch/xtensa/include/asm/uaccess.h: In function 'clear_user':
arch/xtensa/include/asm/uaccess.h:40:22: error:
	implicit declaration of function 'uaccess_kernel'

uaccess_kernel() is declared in linux/uaccess.h, not asm/uaccess.h.

Fixes: 7df95299b94a ("staging: kpc2000: Add DMA driver")
Cc: Matt Sickler <Matt.Sickler@daktronics.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index 5741d2b49a7d..e741fa753ca1 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -8,7 +8,7 @@
 #include <linux/errno.h>    /* error codes */
 #include <linux/types.h>    /* size_t */
 #include <linux/cdev.h>
-#include <asm/uaccess.h>    /* copy_*_user */
+#include <linux/uaccess.h>    /* copy_*_user */
 #include <linux/aio.h>      /* aio stuff */
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
-- 
2.7.4

