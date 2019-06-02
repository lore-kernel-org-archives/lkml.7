Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94405C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 21:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EFC279EC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 21:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYQU0i5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfFBVpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 17:45:10 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37425 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbfFBVon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 17:44:43 -0400
Received: by mail-lj1-f193.google.com with SMTP id 131so1760869ljf.4;
        Sun, 02 Jun 2019 14:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NPHUAZZIdahQ/rcokwzfDEN4AgIFxox/+5UQQJnBiAA=;
        b=DYQU0i5vx96+vx/RM/i5VKGnJ/ksBoBWuGULPg39/P89lS2avRvim/zuXoyzfjcwHm
         gzayjijDAuflnojX3XHUFmGKXeC64ZeLEpOMcsi81/tlzBXC6t/7KwxffWEaKFUOAMOn
         06PJmjgmugDftQCUflHvESEgQgTpfrrGdJB8ysTiDaasazSBKrvaDfmm339APW14TzmL
         BVYy7zwry5S631Ny51G+ZJzL2GAEXW8z2gpXWYsVsb6T7Wkvow+vUpEBWyTYQ2qRE1KQ
         a0IyqzGe/EA28qE6ADrtzFRBIEUar2AkFF9GCmDKvx9sJcR55I2XAY5YquzcsUiveB9z
         XnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NPHUAZZIdahQ/rcokwzfDEN4AgIFxox/+5UQQJnBiAA=;
        b=iVrWczEdTUQGzhfEQAyMCXe5C2dWoyqtIj9xICX9VEvt+ri8aNLwqoDSGHZQL94Shl
         HjZfzDjwsO8W6M/EznGPWDC02SWveRGD2qG5/7PCTz5FXMZDyT39DPWXDn+n3ejvpSpl
         +dLhCeG3QggTMYa8tepCEbvRAW4Cu/ikSG7GxIpzZp9sG9GITI+vSt6uEuC3PGBIK7Wb
         +++I8FqpFYNRAzxaKQZoxsyWgDDD97epuydj+8pyY0PBqtTbp8lzCmQTfwA5MHRWQvSm
         PlvBqEGZmlKKvJSKZ4YFN7H2lARgrNB+ju+vQcm1ElqXtdr/kXmZg4RWKGKv01YEh2iu
         Rq2g==
X-Gm-Message-State: APjAAAXHajBOsk1/aPYqNwlsFqhSS8/94h8Jmwnc039OH3ATjltfuzUM
        L0NHjw8G5OX8wobMFbmjs3g=
X-Google-Smtp-Source: APXvYqzBK6bljogfBYdpYcKn3VWUQ2+By56df1hY7cqOQLgGiV0o9yL26EPdnZBLerrtdds/a482TQ==
X-Received: by 2002:a2e:7216:: with SMTP id n22mr12360907ljc.42.1559511880831;
        Sun, 02 Jun 2019 14:44:40 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id g22sm2803653lje.43.2019.06.02.14.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 14:44:39 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] media: dt: bindings: tegra-vde: Document new optional IOMMU property
Date:   Mon,  3 Jun 2019 00:37:08 +0300
Message-Id: <20190602213712.26857-4-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190602213712.26857-1-digetx@gmail.com>
References: <20190602213712.26857-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All NVIDIA Tegra SoC generations provide IOMMU support for the video
decoder engine. Document new optional device-tree property that connects
VDE with the IOMMU provider.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/media/nvidia,tegra-vde.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/nvidia,tegra-vde.txt b/Documentation/devicetree/bindings/media/nvidia,tegra-vde.txt
index 7302e949e662..602169b8aa19 100644
--- a/Documentation/devicetree/bindings/media/nvidia,tegra-vde.txt
+++ b/Documentation/devicetree/bindings/media/nvidia,tegra-vde.txt
@@ -35,6 +35,7 @@ Optional properties:
 - resets : Must contain an entry for each entry in reset-names.
 - reset-names : Must include the following entries:
   - mc
+- iommus: Must contain phandle to the IOMMU device node.
 
 Example:
 
@@ -59,4 +60,5 @@ video-codec@6001a000 {
 	clocks = <&tegra_car TEGRA20_CLK_VDE>;
 	reset-names = "vde", "mc";
 	resets = <&tegra_car 61>, <&mc TEGRA20_MC_RESET_VDE>;
+	iommus = <&mc TEGRA_SWGROUP_VDE>;
 };
-- 
2.21.0

