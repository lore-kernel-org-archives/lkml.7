Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6577C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 04:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A232184B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 04:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsFhtGys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfHYECg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 00:02:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40321 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfHYECd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 00:02:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id c3so12101254wrd.7;
        Sat, 24 Aug 2019 21:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nS5ZdwaXnWLnup1daWCQzgoGPiOKricQ3p0EiljFPek=;
        b=YsFhtGysGFaBx0FpoKJiH+kDHGWWH2ZTZCvrxYciZu6TGElkD8hmOBYdl1IrsqJw1H
         bVnOr8TKC6t2jdWvfxVtI60Hi+53O1WRnEjXDkHQjfQzZzMtC74DMR423jRtUF7UL/BQ
         Gpdf15fJoQmY/1H/t0NN78HNREdCRlionQg3jCc8sqaJJkobwfX8woxGfE3WM7DILeeL
         QRB7hguPsEUlBLcBjt9+xflN7mdD1O5llbV+XFbR6aAWko9FKtgXZQSs0AxvaZm1Mx+k
         RxA0OO+p4sFltJtp+7Fg/3YlopTfKhUaF1s8vgoFKN5v2mvFn/mI5vSFhnnCPTCBCfio
         Telw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nS5ZdwaXnWLnup1daWCQzgoGPiOKricQ3p0EiljFPek=;
        b=dCCukjZX+9Qrw7/txOblIg47nZyFXvFLRRN4lzh2AC6qVRGgSNYOqNPGGykkyNmKxA
         3p5fldqXnLlA93WXUin3wRkH0hXIlvG8XnuF90BqnX4OTWTyVqu4Ue0A53Jf3WThqJjW
         uE3fzfGJgKfZMICdofEn30p9jp6ecLNpz6UZhNuGXgvncwGCUyJOQPtyMHbXcfmgbO/G
         e+11ZOrvMf7faJb3YhepSC6UmCVNo1ymJIdagGBIcTEvdZ4FRdAliAlG2PjFvstVerhG
         iosDvEwkoFQN4oY5w//2Iy/pwYdp7Vt/pCxQgmuPVCWtO5VyK3vqPLIzZlPLyIgsJzon
         AYWg==
X-Gm-Message-State: APjAAAV6VVFwXia/Rjs07ETKNI7qmiAI9bltTjaJhJe/+OO/1WMk6T1w
        iAqbyL6URIE5pLfmhaUApvs=
X-Google-Smtp-Source: APXvYqzpbvks94RUaUaHxbIcLp4EI33cVGxO4/18OYAgWCn3juOpT/w3h/KFPUXwRVDgDJmS/myrJA==
X-Received: by 2002:a5d:63d1:: with SMTP id c17mr10502168wrw.3.1566705751398;
        Sat, 24 Aug 2019 21:02:31 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id a6sm6820985wmj.15.2019.08.24.21.02.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Aug 2019 21:02:30 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 5/7] arm64: dts: meson-gxl-s905x-khadas-vim: use rc-khadas keymap
Date:   Sun, 25 Aug 2019 08:01:26 +0400
Message-Id: <1566705688-18442-6-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566705688-18442-1-git-send-email-christianshewitt@gmail.com>
References: <1566705688-18442-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Swap to the rc-khadas keymap that maps the mouse button to KEY_MUTE.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index 5499e8d..2a5cd30 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -110,7 +110,7 @@
 };
 
 &ir {
-	linux,rc-map-name = "rc-geekbox";
+	linux,rc-map-name = "rc-khadas";
 };
 
 &gpio_ao {
-- 
2.7.4

