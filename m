Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DDDC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC5120693
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLSv5krM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbfDSTO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:14:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35446 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729768AbfDSTO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:14:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id o12so4650478wrn.2;
        Fri, 19 Apr 2019 12:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yg1VOoGGj2e9HUBUjH9P0F8HoxifiboWQ0NYHZZxQwU=;
        b=bLSv5krM3mOIHCeik1CsBD872udWfGjFF+0ZFvHsxAQMGy3cvznhh0w9qsG3NyFJOE
         ZyUGCBe+UVN4IKjq4k68bAi6w028q+QdswTdta5Sn3jmzv72fYF4TddE9N/jQ5SCwY/p
         ZYrguVhWtnTyb6vi0dHYt44gIvlIqo//5ia7yUYeH3F8dtj49q6/pHIjzwteybdXGP/F
         TWFx9HcgCiBBU/iXssNk0cn911Ntaga+j71eklrsTQIPkYlqKAr1fGolpgti3Bj5gBxA
         eXautKUiBrSXnBFBo99ibLZrlkGzRdJSg/5Oc5o9HSE7pBHZXHUIwOWl6nOlENNxOYHe
         2EUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yg1VOoGGj2e9HUBUjH9P0F8HoxifiboWQ0NYHZZxQwU=;
        b=obw6yl3lZK3bSDJ7WVPBjhSjaA16A5O2Km5DFvWCsh0By2ZrxPViJsoD4C2A0CHus8
         HV4EtlMDOKmRAYEMxGKC77hsSBpQtyKL6B4tqXjHVc9+bJUc2YJWGcg4rk3Fqf/g7P1d
         JbKbWQAiei8niqGD+UxcB80Pm/i4umsuddcN3TVr+0qkZ3UucPuYVh7WVaJydrqpE5m8
         R6fR8JtO58B6B7XaJCwTZX4oE4uxUvulVsZNbl7YK0Sn0xAA1YXBCKTqgeCFylJ2FIou
         cFYlUN/otxHHu7skCNK4q4UAmqw/7Nl6x64/WfLEm+xtbh0jZxD7X7AD/68BUPlX/bDo
         jr3Q==
X-Gm-Message-State: APjAAAWcvNDA8LF2S8oxiGn+78B6JSEub95E2JY9VS4UfvaNo8/PnMeE
        dwF4QPQdwwa8XzxLi6T5OdM=
X-Google-Smtp-Source: APXvYqz9eTSGdABGRaZjq5azDwlrz8fm9whlijjarIONZfiUZL4+Ix+OVWlK1RlaFJ5umpRfyUSw9Q==
X-Received: by 2002:a5d:638d:: with SMTP id p13mr3946296wru.202.1555701264320;
        Fri, 19 Apr 2019 12:14:24 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id z18sm8131149wrr.90.2019.04.19.12.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 12:14:23 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 5/5] arm64: defconfig: Enable Sun4i SPDIF module
Date:   Fri, 19 Apr 2019 21:17:30 +0200
Message-Id: <20190419191730.9437-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190419191730.9437-1-peron.clem@gmail.com>
References: <20190419191730.9437-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A64 and H6 use the Sun4i SPDIF driver.

Enable this to allow a proper support.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c39033c1a..423413768d79 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -531,6 +531,7 @@ CONFIG_SND_SOC_RK3399_GRU_SOUND=m
 CONFIG_SND_MESON_AXG_SOUND_CARD=m
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
+CONFIG_SND_SUN4I_SPDIF=m
 CONFIG_SND_SOC_AK4613=m
 CONFIG_SND_SOC_PCM3168A_I2C=m
 CONFIG_SND_SIMPLE_CARD=m
-- 
2.17.1

