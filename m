Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E568C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61C620449
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BEqPgVB2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BEqPgVB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfEGUlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 16:41:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53578 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfEGUlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:41:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BB8A56155F; Tue,  7 May 2019 20:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557261661;
        bh=4J3+oFqRtiIZEXV5p50Ysv+YGk04XmlmMAnX8bkmscs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BEqPgVB29tV2I+1B77xet5j4Tg8/yP+TY9yvuZhEZCvJeBPtHThCeqG98HZ/JUAmc
         D/6CEBFnQk+Lz4kI8i+wbjcZ6EAiNWfjM9Tyer+GW7mUop374SObyxMdXcKGehErkZ
         Z1rrBN37M9fv0UiGokow+KdHJFHWCo7NC/YKGhrw=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 20E6F6141B;
        Tue,  7 May 2019 20:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557261661;
        bh=4J3+oFqRtiIZEXV5p50Ysv+YGk04XmlmMAnX8bkmscs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BEqPgVB29tV2I+1B77xet5j4Tg8/yP+TY9yvuZhEZCvJeBPtHThCeqG98HZ/JUAmc
         D/6CEBFnQk+Lz4kI8i+wbjcZ6EAiNWfjM9Tyer+GW7mUop374SObyxMdXcKGehErkZ
         Z1rrBN37M9fv0UiGokow+KdHJFHWCo7NC/YKGhrw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20E6F6141B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     swboyd@chromium.org, evgreen@chromium.org, marc.zyngier@arm.com,
        linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v5 10/11] arm64: defconfig: enable PDC interrupt controller for Qualcomm SDM845
Date:   Tue,  7 May 2019 14:37:48 -0600
Message-Id: <20190507203749.3384-11-ilina@codeaurora.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190507203749.3384-1-ilina@codeaurora.org>
References: <20190507203749.3384-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PDC interrupt controller for SDM845 devices. The interrupt
controller can detect wakeup capable interrupts when the SoC is in a low
power state.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c39033c1a..4e5e681c4b11 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -685,6 +685,7 @@ CONFIG_QCOM_SMEM=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMP2P=y
 CONFIG_QCOM_SMSM=y
+CONFIG_QCOM_PDC=y
 CONFIG_ROCKCHIP_PM_DOMAINS=y
 CONFIG_ARCH_TEGRA_132_SOC=y
 CONFIG_ARCH_TEGRA_210_SOC=y
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

