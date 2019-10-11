Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17DFECE58E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9788521D6C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCsQiH4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfJKGDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 02:03:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42067 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbfJKGD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 02:03:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so3944464pls.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 23:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZhH7y9bWqrYq0GkntR2sqe3cFWsNeqnTiNZ167qd4Ww=;
        b=QCsQiH4zWuKHwsrNSls2v4R+pgugagGbeWEx0Jxi05GUkcoh3J8oTImD/N5SqDx11B
         DKgkcanC09fKw+B+TmxVc8a5cEBEg75rnu47ckfW3U/ariFlcLaSfcKay4RdHgc71Sv7
         UyPem8oI1w5WSHT+6pdXHHOGLoqcb1S+93dT1rlBWr5NcLznYSzaiRmTbwfnICVl3pUe
         RSsLpBCAHFmNC0rKM4Hiy8eevrSCU4G/FS4D402e8pJ8qa6swip9P/UsRmtLa3kXGJ5a
         VBJfiBa62PBLkawRSn/QA7A2POcOhqMprIz7xU5cpGj5boKYxe4vUF9/jD7Uilm83BuX
         Vpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZhH7y9bWqrYq0GkntR2sqe3cFWsNeqnTiNZ167qd4Ww=;
        b=gI2ykOqdV2EKrf4T63C/dpdrR+rbClT9KgqGx+8Irh7uF0t2EjrdmYMkLNoRq/63Od
         jiB5o0PE6Z+SiEZK/FDm3UeoR1VxlQivIrT5clzLODmitpmowY0f5iwB4xzi+ztmZRsc
         HcxHJsmyhVElekAF0dW+eo+dSF2MsL1E6zAhFwqn4VI/ucHPZVKQFtS79fPKGoHXgPHE
         abG1o/gxdm7qrgQV2Psd7kIc4lA85KB8oRbG1tTi5cPtmnQ9HTyYNNmPGqgM5u8aMVNv
         wH14OieWAhN2Ote16RwGFolNiweACCAPG8X6ZEC/HEQshE4+7vgDpG/GN5aUnHTnLVRL
         bKzA==
X-Gm-Message-State: APjAAAVNost9+Y/QBYFdF4HsJcQkeA0Ptt1NsIfnIUsH6WueTztn5It4
        DItNej3jLoaIx/CrnNOYFYA=
X-Google-Smtp-Source: APXvYqznc/4K8eKHZ0HdkF8LED+YFxKkZxoms/0qMxEZcPi6+7/VNjd9bd2jMFWr/6i33HKwFK1QTA==
X-Received: by 2002:a17:902:aa07:: with SMTP id be7mr13517839plb.242.1570773809093;
        Thu, 10 Oct 2019 23:03:29 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id p11sm9395715pgb.1.2019.10.10.23.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 23:03:28 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: [PATCH 3/5] staging: octeon: remove typedef declaration for cvmx_fau_reg_32_t
Date:   Fri, 11 Oct 2019 09:02:40 +0300
Message-Id: <b4ac58c4f17ec98e014980ae7084db16ffd9d97c.1570773209.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570773209.git.wambui.karugax@gmail.com>
References: <cover.1570773209.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove typedef declaration for enum cvmx_fau_reg_32_t in
drivers/staging/octeon/octeon-stubs.h.
Also replace its previous uses with new declaration format.
Issue found by checkpatch.pl

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/staging/octeon/octeon-stubs.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 78f42597cee5..1725d54523de 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -201,9 +201,9 @@ union cvmx_helper_link_info_t {
 	} s;
 };
 
-typedef enum {
+enum cvmx_fau_reg_32_t {
 	CVMX_FAU_REG_32_START	= 0,
-} cvmx_fau_reg_32_t;
+};
 
 typedef enum {
 	CVMX_FAU_OP_SIZE_8 = 0,
@@ -1178,16 +1178,18 @@ union cvmx_gmxx_rxx_rx_inbnd {
 	} s;
 };
 
-static inline int32_t cvmx_fau_fetch_and_add32(cvmx_fau_reg_32_t reg,
+static inline int32_t cvmx_fau_fetch_and_add32(enum cvmx_fau_reg_32_t reg,
 					       int32_t value)
 {
 	return value;
 }
 
-static inline void cvmx_fau_atomic_add32(cvmx_fau_reg_32_t reg, int32_t value)
+static inline void cvmx_fau_atomic_add32(enum cvmx_fau_reg_32_t reg,
+					 int32_t value)
 { }
 
-static inline void cvmx_fau_atomic_write32(cvmx_fau_reg_32_t reg, int32_t value)
+static inline void cvmx_fau_atomic_write32(enum cvmx_fau_reg_32_t reg,
+					   int32_t value)
 { }
 
 static inline uint64_t cvmx_scratch_read64(uint64_t address)
@@ -1364,7 +1366,7 @@ static inline int cvmx_spi_restart_interface(int interface,
 }
 
 static inline void cvmx_fau_async_fetch_and_add32(uint64_t scraddr,
-						  cvmx_fau_reg_32_t reg,
+						  enum cvmx_fau_reg_32_t reg,
 						  int32_t value)
 { }
 
-- 
2.23.0

