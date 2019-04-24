Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A5FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4162E214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l28v26On"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387742AbfDXXbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:31:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34944 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbfDXX3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:29:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id t21so10135701pfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TK95yJtjV2AI98D1vLaC30czW/MbAAXLzKXN971YzRM=;
        b=l28v26On6rIJCdjREyVjKQjgPcoV6t7Bv6ZiXZVLJO4+p6ja1KK7wrPeSTpb2FggWI
         E5uWY5eRauvPTyWmzX+Q2EuDdTraIEpfToecgsZBI6RRI0cnIgp8gtcAwsB6rRgEaZD1
         7q2Ak2D2geyC2izHc5QLCEC+1D8UqU301V5W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TK95yJtjV2AI98D1vLaC30czW/MbAAXLzKXN971YzRM=;
        b=qOuSVTipxeIPgEBi5WLRxqvI5l37PFIxjcZCx0BJYeWxg0mYTV6lMkK0d1oomWS4Ep
         ENt+qESkDj1KRflsw/RdVKVA8rJn+ZKcWn62XPYByznRa89eRixU2cShcZWl4P7PFHMa
         6kxiCaK58nqqw1+UV08M0kel5DdaQfqu3RSQuw/+Ak6B7P1+J58c2GWdhcgi++FfSAGE
         9wqKPodpmwdQ6p5CDw50GG1YpD1NYiDFZOyF0hmoC1nJKwtYeEOAfrLEj/+OnaanLbXp
         YVY2jMva3J+VjnMT0eeCh+oP9Ep4faVst9dgYzak239hr8uOVJ0J4vTVYjLwacbV12QJ
         YHVw==
X-Gm-Message-State: APjAAAVO6Sk3Tfym8wSXE3FX9e9MjKVnNeOI8JY6z29fBuiJ64fCj0ut
        gThWXuhVV+2fBIN/2Jot6zKYyQEQMoU=
X-Google-Smtp-Source: APXvYqwohx5TIpzSOd53dRpeMF1F7XnEdNYKoWhxQQy/7uHF9W2fRzG2qP0yPRLZx+hLhS8BBu4jmw==
X-Received: by 2002:a62:ee09:: with SMTP id e9mr197375pfi.247.1556148585307;
        Wed, 24 Apr 2019 16:29:45 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id 6sm32498747pft.64.2019.04.24.16.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:29:44 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 13/30] mfd: cros_ec: Expand hash API
Date:   Wed, 24 Apr 2019 16:29:01 -0700
Message-Id: <20190424232918.243308-14-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190424232918.243308-1-gwendal@chromium.org>
References: <20190424232918.243308-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve API to verify EC image signature.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index d55f155eb735..29a996832af0 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1988,8 +1988,15 @@ enum ec_vboot_hash_status {
  * If one of these is specified, the EC will automatically update offset and
  * size to the correct values for the specified image (RO or RW).
  */
-#define EC_VBOOT_HASH_OFFSET_RO 0xfffffffe
-#define EC_VBOOT_HASH_OFFSET_RW 0xfffffffd
+#define EC_VBOOT_HASH_OFFSET_RO		0xfffffffe
+#define EC_VBOOT_HASH_OFFSET_ACTIVE	0xfffffffd
+#define EC_VBOOT_HASH_OFFSET_UPDATE	0xfffffffc
+
+/*
+ * 'RW' is vague if there are multiple RW images; we mean the active one,
+ * so the old constant is deprecated.
+ */
+#define EC_VBOOT_HASH_OFFSET_RW EC_VBOOT_HASH_OFFSET_ACTIVE
 
 /*****************************************************************************/
 /*
-- 
2.21.0.593.g511ec345e18-goog

