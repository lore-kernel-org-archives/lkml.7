Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA75FC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 18:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8963C20700
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 18:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKSczFSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbfJLSGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 14:06:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42406 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbfJLSGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 14:06:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id f14so2529075pgi.9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 11:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M0IO3QVHvP8iuWc7wMX3UeVoicJhBdbrs0nmaFfvgXI=;
        b=cKSczFSU2zV5NJoLOSzUVc9jLOqNZ8plp6l+JTG6mIKrUT0kLwwHdzrrqdTmW3K2Ap
         hTaONGQQWgN9MtghRVYKIM7ZR2wKtklibu2cBXCFAZTuMhXVQKGHyoJUdboogMsBLGkC
         +r5ra5fIwC0j2+2Y/8hkRITfOo4bEP49KYqy48Hbu5bMDC4JKneBvol2E7fU1ITtYF4A
         N/PL+xT1gzG9Fu4r3Bo4EaYZ5ptPrywgeJq5Do392d4087jSxu+nZMsOhoMakNmAZ5JI
         TZFSwxpy6sSXQmJ/KfBTEUaWwQru/rjLRtSHfCV+rvXplG9m7wWu5DWmntDbGAfpJlod
         NcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M0IO3QVHvP8iuWc7wMX3UeVoicJhBdbrs0nmaFfvgXI=;
        b=FX17+gwUIP0Wb83yUmfp2Sk/O1dYb2UGGG7smaHqHT2V8Q8BExvHREhB99X5AsJGQK
         OMbdDM8Esk8F5wbiGJ9DRoRisAAmRP4kvNmChoCEB7LzYoQxzO12OskyAGjYmF1JENT3
         bwCjTn0Xxyz+HxDwd2FinXuzt8Bt3Y/jtgh5U/bWyiHefVhB0xXsqBflXcfqHcv1D1Lv
         sspxw+of8QTLC8ROhBRZc9ju2BVIdx2Ljkg6H5eRG3uo3DAlau2memvF1iBMCjz1Oef2
         +4OLeQVa8tjhGdbHRrC7ZIDQEPvL8huw/L1bqHBsdRubfefFVHMN92jbppremXmwoU2W
         HLjg==
X-Gm-Message-State: APjAAAUPD4BzLle5FKmcxCRuNV7moJM3ZDbL5hFhl8rIRMIeJk8wcMFF
        eXcP8gaMnalRxhgIl3oE5Hw=
X-Google-Smtp-Source: APXvYqzbJTU0Ww2dFcjbyWB0o9m7SWckZWm8DBQ53VOE0u2S5GqouzMos3qWH8ZEg81NQz9Ezw+yrg==
X-Received: by 2002:a62:870c:: with SMTP id i12mr23374694pfe.247.1570903563907;
        Sat, 12 Oct 2019 11:06:03 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id p17sm12183475pfn.50.2019.10.12.11.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 11:06:03 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: [PATCH v2 3/5] staging: octeon: remove typedef declaration for cvmx_fau_reg_32
Date:   Sat, 12 Oct 2019 21:04:33 +0300
Message-Id: <b7216f423d8e06b2ed7ac2df643a9215cd95be32.1570821661.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570821661.git.wambui.karugax@gmail.com>
References: <cover.1570821661.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove typedef declaration for enum cvmx_fau_reg_32.
Also replace its previous uses with new declaration format.
Issue found by checkpatch.pl

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/staging/octeon/octeon-stubs.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 0991be329139..40f0cfee0dff 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -201,9 +201,9 @@ union cvmx_helper_link_info {
 	} s;
 };
 
-typedef enum {
+enum cvmx_fau_reg_32 {
 	CVMX_FAU_REG_32_START	= 0,
-} cvmx_fau_reg_32_t;
+};
 
 typedef enum {
 	CVMX_FAU_OP_SIZE_8 = 0,
@@ -1178,16 +1178,18 @@ union cvmx_gmxx_rxx_rx_inbnd {
 	} s;
 };
 
-static inline int32_t cvmx_fau_fetch_and_add32(cvmx_fau_reg_32_t reg,
+static inline int32_t cvmx_fau_fetch_and_add32(enum cvmx_fau_reg_32 reg,
 					       int32_t value)
 {
 	return value;
 }
 
-static inline void cvmx_fau_atomic_add32(cvmx_fau_reg_32_t reg, int32_t value)
+static inline void cvmx_fau_atomic_add32(enum cvmx_fau_reg_32 reg,
+					 int32_t value)
 { }
 
-static inline void cvmx_fau_atomic_write32(cvmx_fau_reg_32_t reg, int32_t value)
+static inline void cvmx_fau_atomic_write32(enum cvmx_fau_reg_32 reg,
+					   int32_t value)
 { }
 
 static inline uint64_t cvmx_scratch_read64(uint64_t address)
@@ -1364,7 +1366,7 @@ static inline int cvmx_spi_restart_interface(int interface,
 }
 
 static inline void cvmx_fau_async_fetch_and_add32(uint64_t scraddr,
-						  cvmx_fau_reg_32_t reg,
+						  enum cvmx_fau_reg_32 reg,
 						  int32_t value)
 { }
 
-- 
2.23.0

