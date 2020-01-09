Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3C1C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CFE206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="YJV0pzx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbgAINwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:52:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46502 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731370AbgAINwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:52:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so7400532wrl.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 05:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cY7VEq1SDPcCbR2gLted+yBjAeKIqKC5FGvxBvtyOjU=;
        b=YJV0pzx6ld6r0Ittxt8eGiqDQWelxWmJaXiOraeu7kqgy6yUKEl5CjC6krtJ4rrrxp
         4houNQ8Q8UXHox536aXCM7bWjnJil2sW4Ifwt+ACXDVydt8XuYEkC39UKfu0kzF+FufS
         a7g15u0+b0YHpt7dOUYfYHYD9xA5DZpLdHpNvgf6yEZzC8ttI2NzhYTjJyAOiloqwbaj
         bPWnY4DxpIgqUaZwfq9y210ggcbkH6fn+qB9lXXlVSK68lp3bFhfX08XzhhjgVZ3q8r6
         30Q/n6atlyOxZY/9UzXlCX2VifEXBhYnOQqhehai/Oesy1RbkJkDpih43bF3FMS6g507
         pd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cY7VEq1SDPcCbR2gLted+yBjAeKIqKC5FGvxBvtyOjU=;
        b=oBcwU1P1CqAw2qLEYJcBSEZf8fWcCrMwet2tTIyGv7p8I0O8j2EzlQy7x2DigS0rOp
         fCWXDU4r0zcxFd/OGT6xEXi+vYvmtI57VUMBGFsxXvNEf6wsagmAfgPNd0j+mP4qL6bF
         uusoDB9ekeE0iDS69StH7K1QWsrgEpNSfdDjcJdt9dMv8s9ewIbT9neaEMlccL3MOV9Q
         JHF5JlLUoplZyqyqOOFGoAu1Pe7BHNiXk9+WpYzKihgwdaIsIVjmyTZA8oFbuD6ezAyP
         l1emZloL7NbJlyL9fx57AJatHc+7ZX/3x8gFTzH1U0CpheT2yG8J3w4Qegu+wMd2S1g5
         p2cg==
X-Gm-Message-State: APjAAAUdZ11pt6sRsg3i1CyZ8NJrfLptMj9h4pANzo+JJIyi1vZu5Hko
        20QNVA/NHcbGZ2mHFyTEYorIwA==
X-Google-Smtp-Source: APXvYqxIdhdkFDDM3qDOhD9CTVBp8Wso36d/Vi3BKD/mngqoG1YAwUgO6ZuEWuzzKIDn2YcQz8XRbw==
X-Received: by 2002:a5d:6ca1:: with SMTP id a1mr10795256wra.36.1578577955315;
        Thu, 09 Jan 2020 05:52:35 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id e6sm8476868wru.44.2020.01.09.05.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 05:52:34 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-arm-kernel@lists.infradead.org, git@xilinx.com
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] arm64: zynqmp: Remove broken-cd from zcu100-revC
Date:   Thu,  9 Jan 2020 14:52:21 +0100
Message-Id: <b068e60d4058ccb0d784a0cc35e8aecf5ffb98fd.1578577931.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1578577931.git.michal.simek@xilinx.com>
References: <cover.1578577931.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Card detect bit was broken on revA and it is working fine with revC
board that's why this property can be removed.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index dd60f7d85cc8..2b3757dd74cc 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -226,7 +226,6 @@ &rtc {
 &sdhci0 {
 	status = "okay";
 	no-1-8-v;
-	broken-cd; /* CD has to be enabled by default */
 	disable-wp;
 };
 
-- 
2.24.0

