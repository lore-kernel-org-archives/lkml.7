Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F4AC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E002087B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KQy8WXqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbfHENpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:45:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37043 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730433AbfHENn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:43:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so73047335wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 06:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGMV7QhC8DNNZSd4DygDFTwAShSfi/80pVWOD2ZlzJ4=;
        b=KQy8WXqzt+GT9Ms3PweAVyKX7a6Hz4OupUPGYZHWgTfDcqep0bpg+Ae519mvu3I1hg
         e7D3VkMTXiDn6NYIBOHYnO98ca4Un2PjNk4qlQGrPJmMjCssBy4fnjw1zMBLLVi4o03t
         UoSPskgV31NkcygwDhsvZJLmfTwD1XQOCdxLp6plgpCUgL3Bgqh68dfiHOCZ8/6dBoN+
         kvHN3X/WTRCXQX552Cg9EIV5FM80awl2WLwGgAnRA+3tTtMRBYQ+GSuZknWw76zvdVFo
         4L4qGFV/M2HNbRXP+0ZYaAWfuLPYsR8W/ACFQaq6f8r3IqsnmGp58pjlpV28OaAKLLCz
         XrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGMV7QhC8DNNZSd4DygDFTwAShSfi/80pVWOD2ZlzJ4=;
        b=nWp1uIrLxNPQHJvhTXaAsMA8R9ZwWYpBvDOTaGWB8YRe0RmKe4zNWb9lAQ4FYlno9p
         C/96ceeOkrKtjWSBVygtPSDhiIcbabv1o1v+7EcFjwJ3GpYpxuxo1jkEBSF4Bq23Pd9o
         E2stUcz2nyrXbl4cXub6fjA15ehiRByBwtTE18d3bsqJFAIhRcNHjO3BhMBHJmilq/es
         H5kHbeD05+ZEB2OPed1hCKhONfRAKyNLfa0KLCWVfrQJTz9lMYMw1rJA5+lp8mv7uhdy
         Jv03y2dGRSszINR9Rn1XCNi/hlVT0ZI3MCZoa81MQXMGliDaeV6kll6TYhIgD+83+VM5
         03lg==
X-Gm-Message-State: APjAAAXdzHVN7nQbwePrEuIE/eDSZFv+Fn9iFRL9GW3t3Pnu6d2ygoVB
        a4r1+ZjoOYpLgZcsE/cH9Zgn5mM2BVkv1g==
X-Google-Smtp-Source: APXvYqwwWryXK9vXOEQg9N4QQcQMr9Yj0vLdZlzKaPKS8EdfFo7G7Jmuqo5lcERdhsA70RGznVFIiw==
X-Received: by 2002:a1c:cfc7:: with SMTP id f190mr17881896wmg.85.1565012608012;
        Mon, 05 Aug 2019 06:43:28 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t3sm67835842wmi.6.2019.08.05.06.43.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 06:43:27 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh+dt@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] MAINTAINERS: Update with Amlogic DRM bindings converted as YAML
Date:   Mon,  5 Aug 2019 15:43:19 +0200
Message-Id: <20190805134319.737-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805134319.737-1-narmstrong@baylibre.com>
References: <20190805134319.737-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The amlogic,meson-dw-hdmi.txt and amlogic,meson-vpu.txt has been
converted to YAML schemas, update MAINTAINERS to match them again.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6426db5198f0..c55c18531cd1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5318,8 +5318,8 @@ L:	linux-amlogic@lists.infradead.org
 W:	http://linux-meson.com/
 S:	Supported
 F:	drivers/gpu/drm/meson/
-F:	Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
-F:	Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
+F:	Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
+F:	Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
 F:	Documentation/gpu/meson.rst
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 
-- 
2.22.0

