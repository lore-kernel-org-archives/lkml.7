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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2F5C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 18:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC22720700
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 18:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaZNIuiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfJLSGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 14:06:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33903 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbfJLSGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 14:06:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id k20so294730pgi.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 11:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5j1A1CJrFknhucKXV20++wcqTBT5ww2z/OD9tkaD26o=;
        b=SaZNIuiDrKEnNoZYIo7lCHmujsACa2amAfuBhsTaGm7KVwYD3hUK40BRG+dmaeJtBI
         S5rHTr9oMIdsF2VoFMgaHWbNUgA4Ua4PWwkIzbWW9qWJoIDO0hNgUDUs00Ckah8WBfFc
         N/fa8bMtUsG+QcmliDMGU64r+7v1NXMQIXkKYxzPB40JPv3OHt4rJT91zXz4H6CwjaLT
         ZiL6Qq8TtnZJqy3/gkG3WwApo2EbVenrufjKeBq3H5SNbk0RFVgGM9T2E35Odc2YSL3Z
         VhNvT010sCWmWdbFtVp/XOILfp0a6ouMb57lDfh/xQjZEUTE9dzOhVxgJpPJ7o0/cIj6
         ksCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5j1A1CJrFknhucKXV20++wcqTBT5ww2z/OD9tkaD26o=;
        b=PWJF/qR3v2pDTzaA9X8BufY/K06G84FV45X0LYrVVDRNW5iwozudYanqNT7+ySllBG
         kRbGAwVLIGpAm0jcFWLPtrVEkcILr7v5Dn5IOyfZ3gz7s8zGFnDPT5XVd9unpdJ/tZqq
         PxcjurhAWhjzOenrrw4Vy1yGF9bxMt0Y/Nhdi3k/pAmKsr1cCyUGNOGTeIjA/4QkT47e
         VoMNhnC9LQsg00EjNO0plHnjLvX0J/69FO0knfPGMoRQTkfuQgUGSu/iwXhk2fDmDejK
         Os+Q8j2+doVKAOFan9AH1StydZNphAKIIHH6LXRB+BRfd/HqE/AxhBPzuNo3J3ka6aFE
         oJ0A==
X-Gm-Message-State: APjAAAWIj5wSU+BxolpXDluTKDjOExE8SlMo13IMBMN0yqt14bt5XTzg
        V7sAK9bB8bzKBlFjev4Zyes=
X-Google-Smtp-Source: APXvYqwBV347Nx/aSoHRscUq8iPnAExlrRI25Dz7W2NV+WG/Bz8qcKiASHZXBnHMxQQfGhKR9a664g==
X-Received: by 2002:a17:90a:a411:: with SMTP id y17mr25941035pjp.116.1570903582596;
        Sat, 12 Oct 2019 11:06:22 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id p17sm12183475pfn.50.2019.10.12.11.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 11:06:22 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: [PATCH v2 5/5] staging: octeon: remove typedef declaration for cvmx_fau_op_size
Date:   Sat, 12 Oct 2019 21:04:35 +0300
Message-Id: <0130bbbffd4c3c9e0e2ab0fc02cb7fa704ee410c.1570821661.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570821661.git.wambui.karugax@gmail.com>
References: <cover.1570821661.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove addition of new typedef for enum cvmx_fau_op_size.
Issue found by checkpatch.pl

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/staging/octeon/octeon-stubs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index db2d6f64b666..1b72f02a361f 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -205,12 +205,12 @@ enum cvmx_fau_reg_32 {
 	CVMX_FAU_REG_32_START	= 0,
 };
 
-typedef enum {
+enum cvmx_fau_op_size {
 	CVMX_FAU_OP_SIZE_8 = 0,
 	CVMX_FAU_OP_SIZE_16 = 1,
 	CVMX_FAU_OP_SIZE_32 = 2,
 	CVMX_FAU_OP_SIZE_64 = 3
-} cvmx_fau_op_size_t;
+};
 
 typedef enum {
 	CVMX_SPI_MODE_UNKNOWN = 0,
-- 
2.23.0

