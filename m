Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392B1C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077B021773
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="h/k0chIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfDWNg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:36:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35334 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbfDWNgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:36:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so121828wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 06:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VQSrVwDmr1HQ9kqxMmTwk0XWGEyd+c093hBjiuVx8bc=;
        b=h/k0chIlrjXZFfVJZKzNRU/7VBPvmFG9hAc5gMMfpvxauD7MWhes4IPd7aNUpCqiuX
         UIqiNilu0rFTR84vow/iSOghmYHt5pjC1batpLbDTxiCh4hFsdHpYsH4mVTwYcKbTe+J
         kK6eElSduZr0YbsGgNy28tqk7jb91hvIoV3CfySgdDZwD4LFeDTvEgu4tjJ4ffpedPFs
         Ln5tr4zyZy1mxjnFydoZDhSNr4ChimkWKvztgrrdCjLf5Y7yst0YTIWgRCNL+Usnngv8
         Pp4vaTnbr4EEAZ94zZkuTvohrOYg0ySFm+XlPqhENoxLrHdUuzVfaQMDxz+o47KtxxUT
         j0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VQSrVwDmr1HQ9kqxMmTwk0XWGEyd+c093hBjiuVx8bc=;
        b=qPFd31kunP+HcvWXCsvZD13oUQo62MX7uVhYGYxecY8Bk8OZILUn6dIysdBRx20uJO
         UJ8U/7rfdf5RV2V0OZjLtT0dlTL6u6i5TX4xM1DHymLQtw9bMw8jW46gBcInzLxeFcfv
         EFRng8Xn2PMrN1eQZdGM2SbEjSeESmCVZ5uSR+XF5w2z9k8qPvv9by0ckRH2UvsKytcw
         o3psAQ7lamAgzgLW6jZJWpdp3LeuO1CIvw+th0hPP0nyqnoMEQ9Jl+L6QM8lBmrU8ufj
         P/0/bgVaGx01fiy8/wXVBYYha/W87mImnJtWlioIYgqAjxkfxZV6hmU6wpBuh7RWOJuy
         9WkQ==
X-Gm-Message-State: APjAAAWhn6sSYmUcMDMkQxSUiIW+gzV3PWkwjCSFDTi+UZNwlh4VttQf
        QEfTEglN8CExTTt+RQMaQRboAg==
X-Google-Smtp-Source: APXvYqwXBniYbjKTahnNsFqXrgbfaflk3GyG8hY1CXhuQ0SZHSCMjNvpkF3z2GsuVULZicC6rUWdcg==
X-Received: by 2002:a7b:ca51:: with SMTP id m17mr2129980wml.25.1556026612681;
        Tue, 23 Apr 2019 06:36:52 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z20sm13509543wmf.34.2019.04.23.06.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 06:36:51 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com, devicetree@vger.kernel.org
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: pwm: Update bindings for the Meson G12A Family
Date:   Tue, 23 Apr 2019 15:36:44 +0200
Message-Id: <20190423133646.5705-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423133646.5705-1-narmstrong@baylibre.com>
References: <20190423133646.5705-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the doc to explicitly support Meson G12A Family.
The 2 first (A & B) AO PWM uses different clock source than the last 2
(C & D) AO PWM modules, thus we need to differentiate them.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/pwm-meson.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-meson.txt b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
index 1fa3f7182133..891632354065 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-meson.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
@@ -7,6 +7,9 @@ Required properties:
                          or "amlogic,meson-gxbb-ao-pwm"
                          or "amlogic,meson-axg-ee-pwm"
                          or "amlogic,meson-axg-ao-pwm"
+                         or "amlogic,meson-g12a-ee-pwm"
+                         or "amlogic,meson-g12a-ao-pwm-ab"
+                         or "amlogic,meson-g12a-ao-pwm-cd"
 - #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
   the cells format.
 
-- 
2.21.0

