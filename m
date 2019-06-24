Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD9DC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC9020656
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mnrc7AJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfFXOtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:49:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39811 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbfFXOtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:49:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so13687074wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 07:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:references:reply-to:message-id:mime-version;
        bh=qICt3tvrDEjsshgOgeqB9NCEtKIKhDes2GEOtGUCIpo=;
        b=mnrc7AJREizTtyko4LB8qv6Cg5B7WxC4INlkHs9Ks4iSd2+apictmURS40KuI0t5Tn
         IB2Vnf/t+LVnP+tv1JvqK0FMsszntab9bsBVDhaq6iH/5dr9u7y6ngMLni2/8v8/KD3I
         1RNcMErB5MGZrpdrKROpddh54ZDHRNg8rOMycQTJexvvjS09bSP+7duvAXFZuxYnmwGn
         Wpgf31NfM9CwuosNa95m1z+0d2TNHFTO5beH//s/fat/KCaC+gG8C9eFd8v7zvt8OC3u
         asoDvcItzT1/rBmW1y+Ab6G7mIjNAxdR7PXNNpiCVmsN1jFfPqU98sGJajv6Icl+rVEt
         2jCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:reply-to
         :message-id:mime-version;
        bh=qICt3tvrDEjsshgOgeqB9NCEtKIKhDes2GEOtGUCIpo=;
        b=Amc7AcsmxA3mzmO5dajHi+jKsxKF4byzAFNh53eb8XRtzh04v90Ofkek0cYZ+fk8a/
         g0fXhaa7z+3bw6A+mC3yXX6Ouvr1q5ZEuwx0g6fRXHwYIpEE9rA0uay3l9BUdndBFJnM
         XkC5ewBaze8sEdr5mXyAvp0K/M1eyXCwrS3AqJTRMIaIGP74LypDcjVoQM1deGuCdcYg
         zbDBfjVYdN2tiHeyxhyg8vllQPgUNKZnxGSUdXzRayuBdX46nAoeRNR9YM7tPXvteFYB
         FlX8Sa6GURleKaAxi4f6T8n4MNQs1JuASYrTKFUwPx7meuBIztR05smzb1g7LskryliY
         ZfYg==
X-Gm-Message-State: APjAAAUyaCzN2/6NRs4tBK3vJwhVObys5xCPo2Ae2Ju8rJ1U2vsC+fRl
        VazJLvjUdT36+ahf5O3SjWmz61b0ruY=
X-Google-Smtp-Source: APXvYqyo+n4FXVEBememSCgVf3nyfXvEm0+s6OodWbZ0mTPQMuiNLuOddy70bQx8iLDOUizpxuJGKg==
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr15799778wmb.119.1561387759831;
        Mon, 24 Jun 2019 07:49:19 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t63sm11204083wmt.6.2019.06.24.07.49.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 07:49:19 -0700 (PDT)
From:   Julien Masson <jmasson@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Julien Masson <jmasson@baylibre.com>
Subject: [PATCH 9/9] drm: meson: venc: set the correct macrovision max
 amplitude value
Date:   Mon, 24 Jun 2019 16:49:12 +0200
References: <86zhm782g5.fsf@baylibre.com>
Reply-To: <86zhm782g5.fsf@baylibre.com>
Message-ID: <86mui782dt.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the register description of ENCI_MACV_MAX_AMP, the
macrovision max amplitude value should be:
- hdmi 480i => 0xb
- hdmi 576i => 0x7

The max value is 0x7ff (10 bits).

Signed-off-by: Julien Masson <jmasson@baylibre.com>
---
 drivers/gpu/drm/meson/meson_venc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index 2835133ab676..acad16ff7371 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -192,7 +192,7 @@ union meson_hdmi_venc_mode meson_hdmi_enci_mode_480i = {
 		.hso_end = 129,
 		.vso_even = 3,
 		.vso_odd = 260,
-		.macv_max_amp = 0x810b,
+		.macv_max_amp = 0xb,
 		.video_prog_mode = 0xf0,
 		.video_mode = 0x8,
 		.sch_adjust = 0x20,
@@ -212,7 +212,7 @@ union meson_hdmi_venc_mode meson_hdmi_enci_mode_576i = {
 		.hso_end = 129,
 		.vso_even = 3,
 		.vso_odd = 260,
-		.macv_max_amp = 8107,
+		.macv_max_amp = 0x7,
 		.video_prog_mode = 0xff,
 		.video_mode = 0x13,
 		.sch_adjust = 0x28,
-- 
2.17.1

