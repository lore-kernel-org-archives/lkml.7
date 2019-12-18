Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9183C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCCC2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GIpbN7R+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfLRRTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:19:38 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41983 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfLRRTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:19:38 -0500
Received: by mail-pg1-f195.google.com with SMTP id x8so1606724pgk.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 09:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=H/hEuD7eWbjzcqhNaznrQpD/OcKDfv3itQBijN/o1Lk=;
        b=GIpbN7R+81t4ErlQljsRQyxaVLa3w4wV27QCc4PnyQ6ibdiyiThB89Y0zWclSKBVUS
         XaaBZwZozPK6vPEfUN58I4aqyrTEIIa9E7o9tUA37SXHSV8KfifXtFSzTrYyBktzxKym
         dUqZtg4Kna/7O0NK1DSDq3X3cgP5cC5M/raxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=H/hEuD7eWbjzcqhNaznrQpD/OcKDfv3itQBijN/o1Lk=;
        b=NuCTeTs+qcJymo9/h4vxBly3eaPKglzCkf2aD97ALLlwbn6wDz4XQOEyGKiHqg/15R
         aUwNpS64gfrXt5DGRlOrnzxXV0g64gj/0xwkMmeTYwqzvRpGlx8jfaIbi+LH8Qt2aPUs
         k1wt50kVzpfrmkGSfR1PisiTFbMGhRb0BqFlq1UO1bttAS2Gd3qDwY4/wOEmx/tKY2ix
         VepRwQbESu44u8spBh2oCSWdzkQ3nA54mLoSe23T61GvBXVgTO5q2pK42/2v79+i+KUG
         DqMOJJAhdfByGmjt53rabokn9eJXpntJeavQIiRSGydVL1C8HDB3kUzAOSQAdi5LBLkK
         9q0A==
X-Gm-Message-State: APjAAAUtvMVqDDt8Hc3vkknQt9DAesRIEcu2LoszeP6a0PWyTwpBGvCU
        Tz+83SH/0uxc5ehg5mOkv1PR0w==
X-Google-Smtp-Source: APXvYqy1bwshCedLsN4foC5mYKqDnmIuppMB2bZZ9cqKw0d6z0v+8dti5oLQMl7Ij9J3/zU55OwI4Q==
X-Received: by 2002:a63:551a:: with SMTP id j26mr4215527pgb.370.1576689577665;
        Wed, 18 Dec 2019 09:19:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b15sm3883901pft.58.2019.12.18.09.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 09:19:36 -0800 (PST)
Date:   Wed, 18 Dec 2019 09:19:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, ath11k@lists.infradead.org
Subject: [PATCH] ath11k: Use sizeof_field() instead of FIELD_SIZEOF()
Message-ID: <201912180919.2A471217@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FIELD_SIZEOF() macro was redundant, and is being removed from the
kernel. Since commit c593642c8be0 ("treewide: Use sizeof_field() macro")
this is one of the last users of the old macro, so replace it.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/ath/ath11k/wmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 4a518d406bc5..fd7cb07a9940 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -44,7 +44,7 @@ struct wmi_tlv {
 
 #define WMI_TLV_LEN	GENMASK(15, 0)
 #define WMI_TLV_TAG	GENMASK(31, 16)
-#define TLV_HDR_SIZE	FIELD_SIZEOF(struct wmi_tlv, header)
+#define TLV_HDR_SIZE	sizeof_field(struct wmi_tlv, header)
 
 #define WMI_CMD_HDR_CMD_ID      GENMASK(23, 0)
 #define WMI_MAX_MEM_REQS        32
-- 
2.17.1


-- 
Kees Cook
