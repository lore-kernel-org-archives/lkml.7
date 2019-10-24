Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E538ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD4320650
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571920537;
	bh=Pyk5Hdml7dEwYCJoG3iYum5gsiH/lw56y4vp64M1quY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E6wpMi9aPZShHPifzik6J/kWI8lFxZDvDNipZi7WBoFLhVbHDdvJ9+IJjL/JRise/
	 oJtrTpv91RxpKoWMRrXNn9FgZISp9c2NVX4XdxUsARZ75d48ggf24DKoGfPf8rJd0g
	 Xkv6o9YBUSONzLi6Qa2HGv8yF67nrx19UQBdNOcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439704AbfJXMfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 08:35:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41995 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439577AbfJXMfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 08:35:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id a21so2133467ljh.9;
        Thu, 24 Oct 2019 05:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bqFcodUvMP2nbH6/QgA1fTSJxFcDzJHqpohowyN9g7s=;
        b=omij448W9U+5sXMQjog8d+7Go24csgnX/d/UNcN0VR4T0jXaeuCJJDzvaNr7vWAhlj
         In1UdUOiOkiROg87xxSAlNc07rW7eKUoF2TxRiVJfRbWTHtQ/eXXlfO6hPcV0obPh5f+
         q8TGojglScrfqiPgApjbHMTCIPvh6CugqpROmkwj4DoroDa2CUw2olCp3ncqPWNDRccj
         oNSV0IYqY/rcmWQMBOeUcwYME9LZHxZsr+OUr+O1QQgY8IlWm+RVzhbNz5KRFmm40zT0
         A0iJ5WCkE2L4+/94CfuJW+LhvtVb1H6an9FOAlG6s8uWO6eIAmEQ7v+paE/WX8LX6G3I
         M0Vg==
X-Gm-Message-State: APjAAAXq50KmHO2dOXiSn0D4KtfE91sNZh0aW9cVOoTzmarbmNtoi+oj
        vDMl/homJUDbqxFNs+znXOU=
X-Google-Smtp-Source: APXvYqzgKkj078leF9cTw39m/zagH611zNCYLuH3fEK/X5CwPhbpGrnQEA2r5AgjEnWwQ1lbQTbyoQ==
X-Received: by 2002:a05:651c:1023:: with SMTP id w3mr9720501ljm.79.1571920531380;
        Thu, 24 Oct 2019 05:35:31 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id 30sm3063545lju.52.2019.10.24.05.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 05:35:30 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH v2] v4l2-compliance: Allow all the selection targets for subdevs
Date:   Thu, 24 Oct 2019 14:35:26 +0200
Message-Id: <20191024123526.4778-2-ribalda@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024123526.4778-1-ribalda@kernel.org>
References: <20191024123526.4778-1-ribalda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subdev can also have non-active pixels, and using the _DEFAULT targets
we can capture only the active pixels.

Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
---
 utils/v4l2-compliance/v4l2-test-subdevs.cpp | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/utils/v4l2-compliance/v4l2-test-subdevs.cpp b/utils/v4l2-compliance/v4l2-test-subdevs.cpp
index 29987b31..c3979404 100644
--- a/utils/v4l2-compliance/v4l2-test-subdevs.cpp
+++ b/utils/v4l2-compliance/v4l2-test-subdevs.cpp
@@ -395,11 +395,11 @@ struct target_info {
 
 static target_info targets[] = {
 	{ V4L2_SEL_TGT_CROP, true },
-	{ V4L2_SEL_TGT_CROP_DEFAULT, false, true },
+	{ V4L2_SEL_TGT_CROP_DEFAULT, true, true },
 	{ V4L2_SEL_TGT_CROP_BOUNDS, true, true },
 	{ V4L2_SEL_TGT_NATIVE_SIZE, true },
 	{ V4L2_SEL_TGT_COMPOSE, true },
-	{ V4L2_SEL_TGT_COMPOSE_DEFAULT, false, true },
+	{ V4L2_SEL_TGT_COMPOSE_DEFAULT, true, true },
 	{ V4L2_SEL_TGT_COMPOSE_BOUNDS, true, true },
 	{ V4L2_SEL_TGT_COMPOSE_PADDED, false, true },
 	{ ~0U },
-- 
2.23.0

