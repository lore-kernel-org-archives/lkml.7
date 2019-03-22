Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E64C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD3E21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="k6y5ZOvq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfCVFSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 01:18:22 -0400
Received: from tomli.me ([153.92.126.73]:58774 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfCVFSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 01:18:20 -0400
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id bb710996;
        Fri, 22 Mar 2019 05:18:17 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:dddb:8cda)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Fri, 22 Mar 2019 05:18:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=7ltqg8+7zIPf/AJ9ObdCJj16r01sZ0GKTZoaxG1SW/Y=; b=k6y5ZOvqD5JbOq7Wk37InG7q3uDzKKUnMDf8M2W16sAZgdQXUxJvFbsnkO86hjqBrk1wMqyCziURXQbgqwu1qMEHdgtPyUx+HfNS7F6m1oTSKyk+H8XjSAEJPHFkXaPeLR162AVuHUw+zphFBXcqFxqYpXWCwNPWWD0nrUJXpagZIq7GnxdaL24Bh1ayJCk5r26N4wc0Wlg8GCLFfNXhI9+o54UfU3sryF/gdy669yU1emSDvEZET1YlHqiL8EQW3kTfKcJ/L8LMEz4ivGHDofEak11lHxGd/bAdA82hoq7jcoRiPvKunHyP+hWq7sgpy2LoVkAY1PA2pRt1n11miQ==
From:   Yifeng Li <tomli@tomli.me>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Yifeng Li <tomli@tomli.me>
Subject: [PATCH v2 1/7] fbdev: sm712fb: use type "u8" for 8-bit I/O.
Date:   Fri, 22 Mar 2019 13:17:53 +0800
Message-Id: <20190322051759.15007-2-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322051759.15007-1-tomli@tomli.me>
References: <20190322051759.15007-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit converts "unsigned int" and "int" in I/O wrappers
to "u8". It improves readability since it's consistent with
the prototypes of readb() and writeb(). More importantly, it
reduces readers' confusion, since the upcoming 2D acceleration
code will use a different wordsize.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 drivers/video/fbdev/sm712.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/sm712.h b/drivers/video/fbdev/sm712.h
index bb144f038267..89e446db2ac7 100644
--- a/drivers/video/fbdev/sm712.h
+++ b/drivers/video/fbdev/sm712.h
@@ -59,19 +59,19 @@ extern void __iomem *smtc_regbaseaddress;
 #define SIZE_CR30_CR4D      (0x4D - 0x30 + 1)
 #define SIZE_CR90_CRA7      (0xA7 - 0x90 + 1)
 
-static inline void smtc_crtcw(int reg, int val)
+static inline void smtc_crtcw(u8 reg, u8 val)
 {
 	smtc_mmiowb(reg, 0x3d4);
 	smtc_mmiowb(val, 0x3d5);
 }
 
-static inline void smtc_grphw(int reg, int val)
+static inline void smtc_grphw(u8 reg, u8 val)
 {
 	smtc_mmiowb(reg, 0x3ce);
 	smtc_mmiowb(val, 0x3cf);
 }
 
-static inline void smtc_attrw(int reg, int val)
+static inline void smtc_attrw(u8 reg, u8 val)
 {
 	smtc_mmiorb(0x3da);
 	smtc_mmiowb(reg, 0x3c0);
@@ -79,13 +79,13 @@ static inline void smtc_attrw(int reg, int val)
 	smtc_mmiowb(val, 0x3c0);
 }
 
-static inline void smtc_seqw(int reg, int val)
+static inline void smtc_seqw(u8 reg, u8 val)
 {
 	smtc_mmiowb(reg, 0x3c4);
 	smtc_mmiowb(val, 0x3c5);
 }
 
-static inline unsigned int smtc_seqr(int reg)
+static inline u8 smtc_seqr(u8 reg)
 {
 	smtc_mmiowb(reg, 0x3c4);
 	return smtc_mmiorb(0x3c5);
-- 
2.20.1

