Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B672EC19759
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D07D217F4
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2pdqvmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388816AbfHBBrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 21:47:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39260 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731827AbfHBBrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 21:47:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so31115069pfn.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 18:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HJYoXfP1sld8oyBvXEQKsOFywLwHaVUeYYSFlTyLW0w=;
        b=L2pdqvmryJUIlSeZim+ADKnKE/zor5HY5Uz992lsc2pWXUUATZJ4gIw9YuZRdhWLd7
         CBjjYuhRYwe8DpSFhqGjZha4PApGyQNDy+BiiF0ytexD2JGFgVbmz/heBLdBOqeAO7J/
         HQDCiHAS2t32YoHM22TMAokv6XpzkTpVGMEz43c5Se4qvEVp1lKt2jYkktw7ubYMRIsk
         IJcpyyOFcB2WeXr1g2Cslh6X4I5Mfnle9UfHtG8FN7NQNH1OzspWnuGqBVanrzOnnrTx
         2Yv1eVmlWIcCW2FU+apEGzEJnL5M3rbXrFBggqE7+TUds9MiJq2YJBWGTfzoQ3i92Ax2
         lofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HJYoXfP1sld8oyBvXEQKsOFywLwHaVUeYYSFlTyLW0w=;
        b=nAOqGIL1+nfzB3535R6nngLQXm96sMfLRKqxafLUj05owVSFx6oQyEhi1WuN5MOzEl
         7OF2U3hPAdsCuG42hXw9CCu1VwGxrsLlYb46NClEf6mhnnofBQJ9sGOiFl4ZMZzYoN7k
         InZYh62m/FGTjeFLB9/wRXxkuJpxnGFDuClUUl9EBbntAriWXcOaKwahtuXyHIpcfQ9c
         sjpJd2d9uwko88agm7diIoSGMI+JvfXB+gbMicSQr8jTBDlX6qXyee1ifrMtXCkpe747
         EGWlSetLDx0OJ8iXS28qrOBbLRwIGhKcR21DQqU+Q8NxaS864+qPwxX0unijPHn343MK
         XFuA==
X-Gm-Message-State: APjAAAUmUhVd3Kzp9BfyQzNct/voZYSCq57mUlzq+3k1DRUMn1r0fEvf
        1ysnABg+arbz+UphaWcvGzaC3lzewE5jlA==
X-Google-Smtp-Source: APXvYqymZA5z+XLOvtyLGQb4UzYWB98ril1RmMaOp8iPCFbX9iqlGTsf8/iSfsMp9f3o5cYO+4XZWw==
X-Received: by 2002:a17:90a:a489:: with SMTP id z9mr1750798pjp.24.1564710427209;
        Thu, 01 Aug 2019 18:47:07 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id p2sm100657606pfb.118.2019.08.01.18.47.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 18:47:06 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2 04/10] module: Replace strncmp with str_has_prefix
Date:   Fri,  2 Aug 2019 09:47:03 +0800
Message-Id: <20190802014703.8844-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncmp(str, const, len) is error-prone because len
is easy to have typo.
The example is the hard-coded len has counting error
or sizeof(const) forgets - 1.
So we prefer using newly introduced str_has_prefix
to substitute such strncmp.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Revise the description.

 kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index 5933395af9a0..7defa2a4a701 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2251,7 +2251,7 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
 		switch (sym[i].st_shndx) {
 		case SHN_COMMON:
 			/* Ignore common symbols */
-			if (!strncmp(name, "__gnu_lto", 9))
+			if (str_has_prefix(name, "__gnu_lto"))
 				break;
 
 			/* We compiled with -fno-common.  These are not
-- 
2.20.1

