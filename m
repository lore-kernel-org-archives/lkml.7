Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10478C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36892082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QNvrF6HQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfDDOns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:43:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53083 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbfDDOnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:43:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id a184so3368479wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 07:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+5EPK1jLpp1DksFX6bDHdB7cQlJWLKrS9nTZJnBqEYc=;
        b=QNvrF6HQaCAuJc0hO6t/mmraaYs2X3kCub+Sy87sKJCIWIgsJZxOdejgqtEAMmGAfq
         9BBjUQbsnuvfPMiBrqZiRlSEexTz5bpxz9jhv1FwqNAFuRceZee6a4+GofKw3gh8pHzG
         jRajnK/Si04AuLxvJGjtizm/oLL/VHqQPmMY7iZ0Ua7jio4NhstOH5GAuUaPpNRgJ8Tz
         frX9Z64X8aZZ9bONK/oS0lJXXLF4qWBmRUECfvIjrZAz9VeQo15q7a53kS0cWiv9IJbW
         lRHL5l7NOhNXx1zMbZVifFHruSTKIJfCMy7maLUyIy+rMVUjiF4op2pP/TiSVF7w02/r
         aVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+5EPK1jLpp1DksFX6bDHdB7cQlJWLKrS9nTZJnBqEYc=;
        b=sB9FCHKKf69VNIuWv2RQLfiD2zmYAMlaxhmKLS35Mr40gPDYqZar6lRzvACEJryBTY
         iPlh3GBbYKekOvxUI5xXHLnQo23Wk0w0PRMSVDYo+hhQk4E55EghdEJDtGIHi3SIckQz
         II8eD+NFN9nnFIm1jeA+S+Jb4qx6vzE9eFLoA1oAcsA/XGSRFijO1axAzu/anEKHpdVj
         uGmmLb3CIYmsO0s94gBh1FJAgK56fIxKyHdvVHRGdCvPY09RB+FiEEtsBBFnXTWxTFqq
         M5oG+FdQoc7TA+qU5DVnQvRULAd5vYEP5H3A9tn+wWzt0DkaMs6HsLcXzfleuB1Nm770
         RHDA==
X-Gm-Message-State: APjAAAXAgzdIv7zl0XKt5cxnODRkzzF2e1J91OqD0zOxGtU2XLgecw1v
        Y+ftnjPo+MIoFS93Zrga+otCbA==
X-Google-Smtp-Source: APXvYqw0RJ8pMlQrVgU8wXu8DYAVveOzRKB24ciGiiHemHod/LoGVdeX5yWbja/mtWVROS4xOeWn4A==
X-Received: by 2002:a1c:9d8f:: with SMTP id g137mr4631387wme.26.1554389025446;
        Thu, 04 Apr 2019 07:43:45 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id g12sm17848575wrw.40.2019.04.04.07.43.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 07:43:44 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     sean@poorly.run, dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "Documentation/gpu/meson: Remove link to meson_canvas.c"
Date:   Thu,  4 Apr 2019 16:43:42 +0200
Message-Id: <20190404144342.15238-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a3f98bb22cbfaaf67717e156f79e2bfeb42d4cac.

Patch "Documentation/gpu/meson: Remove link to meson_canvas.c" was
incorrectly applied on the wrong branch not containing the fixed
commit 2bf6b5b0e374 ("drm/meson: exclusively use the canvas provider module")

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/gpu/meson.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/gpu/meson.rst b/Documentation/gpu/meson.rst
index b9e2f9aa3bd8..479f6f51a13b 100644
--- a/Documentation/gpu/meson.rst
+++ b/Documentation/gpu/meson.rst
@@ -42,6 +42,12 @@ Video Encoder
 .. kernel-doc:: drivers/gpu/drm/meson/meson_venc.c
    :doc: Video Encoder
 
+Video Canvas Management
+=======================
+
+.. kernel-doc:: drivers/gpu/drm/meson/meson_canvas.c
+   :doc: Canvas
+
 Video Clocks
 ============
 
-- 
2.21.0

