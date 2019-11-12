Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A63FC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB9120679
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vb1PBepH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKLQB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:01:56 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41600 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLQBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:01:55 -0500
Received: by mail-lj1-f194.google.com with SMTP id d22so6879131lji.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 08:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4kdtfZv1UWGs4z6mZX1Xj2hNLNvOhEkV9MFCDyUM5WY=;
        b=Vb1PBepHxX3U8dmOFv17pjejpZizz7XnsepoMKFySZxszgEZoBT3aII0a7WvybC8EL
         jn7pvOgzymp7/xN46tuKOiNL33sfWFhTAO4NnVtdbeKd3DZ4+Kjbomt31ocY6v3PulLZ
         w7HFQPiV8MZ5oulC2anS8lGnKusuGZme/ldc3KmWuaRIMYfFsww/O9yoa69voPa7ssJx
         0wZoZvJPD/2JYo0UQDTUV94lukvVKDeUMyq4d1f6ByiaFyGbcQwzlKgBk58jMNjSBcCL
         dsBjjId+R+R7t7dghP0ljBOMGWvWVY78IKWcPH38+OtyjyB1eAvNqsUvjM2XsROzJmVS
         2KSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4kdtfZv1UWGs4z6mZX1Xj2hNLNvOhEkV9MFCDyUM5WY=;
        b=AR+VmLKD56qzaFohnoVuv2cg29kKg8ZsXngFdCmkEtDlck/Vgf680iG7B4jaOL40bm
         9TPrn0kpN22ESAIbkemHLkFLqcQr7JJNbS+hYpwNfhVME6hAIGZfHlJLwIvqPQzJo+VD
         UNQe0EcfK3jcuq+UW9wzxrZBHmpnPEWXQQVdytnJLzdeE4lLKRwy/RL8BXKO0tW9jb6h
         2Qib5KzAPtr8g5rgrHhmVC0wGZfx1bBlcmbU8D3irwevPM5qHvcuDRGgif4acai74XV3
         E4qUfa6pkNMdYgrprgOCmP97kkx3dncEudJzMAWLuzOwOnOu7Ksvq/KaWF5cO+lpdM5K
         kkGw==
X-Gm-Message-State: APjAAAX/2PR4EoF2pV3iZVvejT1omIkTCiY3eQaHy5QOSCSw/eL/r82v
        ngSH13x+6oVw5GacnEbLXtfM3w==
X-Google-Smtp-Source: APXvYqxN/R60ymZE5BgyfVYlnYrvwIMdBjJapz4sBo4B+ExwAHn5hXfIq+WgqZCPqVQMVlWLa5VvyA==
X-Received: by 2002:a05:651c:1025:: with SMTP id w5mr9990594ljm.68.1573574513469;
        Tue, 12 Nov 2019 08:01:53 -0800 (PST)
Received: from localhost (c-413e70d5.07-21-73746f28.bbcust.telenor.se. [213.112.62.65])
        by smtp.gmail.com with ESMTPSA id v21sm8394109lfe.68.2019.11.12.08.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 08:01:52 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     catalin.marinas@arm.com
Cc:     will@kernel.org, john.garry@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] arm64: Kconfig: add a choice for endianess
Date:   Tue, 12 Nov 2019 17:01:44 +0100
Message-Id: <20191112160144.8357-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building allmodconfig KCONFIG_ALLCONFIG=$(pwd)/arch/arm64/configs/defconfig
CONFIG_CPU_BIG_ENDIAN gets enabled. Which tends not to be what most
people wants. Another concern that thas come up is that ACPI in't built
for an allmodconfig kernel today since that also depends on !CPU_BIG_ENDIAN.

Rework so that we introduce a 'choice' and default the choice to
CPU_LITTLE_ENDIAN. That means that when we build an allmodconfig kernel
it will default to CPU_LITTLE_ENDIAN that most people tends to want.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 64764ca92fca..62f83c234a61 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -877,11 +877,24 @@ config ARM64_PA_BITS
 	default 48 if ARM64_PA_BITS_48
 	default 52 if ARM64_PA_BITS_52
 
+choice
+	prompt "Endianess"
+	default CPU_LITTLE_ENDIAN
+	help
+	  Choose what mode you plan on running your kernel in.
+
 config CPU_BIG_ENDIAN
        bool "Build big-endian kernel"
        help
          Say Y if you plan on running a kernel in big-endian mode.
 
+config CPU_LITTLE_ENDIAN
+	bool "Build little-endian kernel"
+	help
+	  Say Y if you plan on running a kernel in little-endian mode.
+
+endchoice
+
 config SCHED_MC
 	bool "Multi-core scheduler support"
 	help
-- 
2.20.1

