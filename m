Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67058C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8272063F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eNChcKNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfFXOsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:48:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53940 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbfFXOsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:48:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so13074108wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 07:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:references:reply-to:message-id:mime-version;
        bh=xaKJDnae1EFjh86fZ1Qltct9/8V3S9KXOq3PYZYvyHI=;
        b=eNChcKNO7dQANYLf2uCgCftyZNvelvdSK9R+1wtb/lP9OqVCiyaG3OIdIrJvfY5CIT
         UY6txHTM80Vo8+OFktdSz6aeq0tQrXNrcH9S8vrofzKfN4JIMdEv0cjGK/tg1Xnf5J9r
         LGTDyFDGYPkJYSN3BL2uLc7MFCMZj8qFjO4wv/q1Z4WP5PJZaNPa1Quw7jUcK5mZwsCw
         bxOKPjYmtLYt6DMV9GRNb1VFVsyCrJseC+dwSBZLumuyrzMfUcaYhy/ugT8CsDxtM99h
         kr+/TsVx7bAyAIowCC2Iuo0mz79kTiaBTIQgYSf7LmCriUKVmfYEcTchX22VzgZR06tj
         3XcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:reply-to
         :message-id:mime-version;
        bh=xaKJDnae1EFjh86fZ1Qltct9/8V3S9KXOq3PYZYvyHI=;
        b=leQ7wX8GUV2S58yjERvxHnpr7MrM6us+VKqyj01MPG6L5se9oMUUun77JqOVhDj11H
         0QoTydV4hG8tAO2FUdErKyGD9c9TcGvES0EW+2qkDwTrd9KTteMf1FtqgAD5PJGrbMh1
         6OHdtl8OzYfqGKYZCoTRcz8nUw70N4x/tT5nrsLORKP8rEiYPc4Bv4Lye/o4RiJJcPJ/
         ogCOap7n4yMhv16I+rh56awPIX5iSIRGt7PI1P4FaI5nMZ7D4S/AqQhPF+WRsCRTlNHb
         4R8SI9vOmwCFjK0D5n7yxCIl5N6AbhG3WP/tfu8aBNzRR7fQHJj0RqtRFQM7lzQ+d6Kj
         sV/A==
X-Gm-Message-State: APjAAAW2fgow6R5vDAmh19aUgWTtz0UN1J37fl5OWnS4aU29Uss+hWRH
        dteLbBpT/Tm4RgOhJYZMClXggw==
X-Google-Smtp-Source: APXvYqxMhHyWV9UpqhUB/TjiFBls09nQ4ITZssbVwFmGLt+2Qeug/pb+O9Tv3bAeSgwK1fKA3bQl0g==
X-Received: by 2002:a1c:21c6:: with SMTP id h189mr10837205wmh.79.1561387692414;
        Mon, 24 Jun 2019 07:48:12 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v65sm18451669wme.31.2019.06.24.07.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 07:48:12 -0700 (PDT)
From:   Julien Masson <jmasson@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Julien Masson <jmasson@baylibre.com>
Subject: [PATCH 1/9] drm: meson: mask value when writing bits relaxed
Date:   Mon, 24 Jun 2019 16:47:56 +0200
References: <86zhm782g5.fsf@baylibre.com>
Reply-To: <86zhm782g5.fsf@baylibre.com>
Message-ID: <86y31r82fo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value used in the macro writel_bits_relaxed has to be masked since
we don't want change the bits outside the mask.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
---
 drivers/gpu/drm/meson/meson_registers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_registers.h b/drivers/gpu/drm/meson/meson_registers.h
index cfaf90501bb1..c7dfbd7454e5 100644
--- a/drivers/gpu/drm/meson/meson_registers.h
+++ b/drivers/gpu/drm/meson/meson_registers.h
@@ -20,7 +20,7 @@
 #define _REG(reg)	((reg) << 2)
 
 #define writel_bits_relaxed(mask, val, addr) \
-	writel_relaxed((readl_relaxed(addr) & ~(mask)) | (val), addr)
+	writel_relaxed((readl_relaxed(addr) & ~(mask)) | ((val) & (mask)), addr)
 
 /* vpp2 */
 #define VPP2_DUMMY_DATA 0x1900
-- 
2.17.1

