Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A62C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB022147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VuNZpDwC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AcChao4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfCMVTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:19:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47138 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbfCMVTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:19:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7A26E611BE; Wed, 13 Mar 2019 21:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552511953;
        bh=IR/RvKV63GjvxSyY1/+b3UeuswQOhwUKaP7x3fj+HI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VuNZpDwCF0IuyO2wciRclpQP2Iwkk/bsavm4/3XBLwrcthotVoIdlptoxf2Cw1tMP
         JjWVPSbq+B2uvPTKNyHIVJtBTZp6yHeWERNHak69aMMEjk0KAoFI1Uy2IdRIW16go2
         qR6l0B587451eH9BVwAlFFt50bu5knpt7439QQZs=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F862611FC;
        Wed, 13 Mar 2019 21:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552511951;
        bh=IR/RvKV63GjvxSyY1/+b3UeuswQOhwUKaP7x3fj+HI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AcChao4cJLG6swa6E0sZErqsVXqS4jj7JpOeeWOrTEkzjgeQ0DMt856dQyeoeT6YZ
         +/22DtYiGSrFO/K9MccOFtOqd9Nfa9ETCgxgcAccrAuVsTyPLq2EGFoxOZ3UqWAg6b
         aZyRhpP6TF8pS9ppyh4Ka07JUx64B5t5WayBOQ5s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F862611FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     swboyd@chromium.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v4 10/10] arm64: defconfig: enable PDC interrupt controller for Qualcomm SDM845
Date:   Wed, 13 Mar 2019 15:18:44 -0600
Message-Id: <20190313211844.29416-11-ilina@codeaurora.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190313211844.29416-1-ilina@codeaurora.org>
References: <20190313211844.29416-1-ilina@codeaurora.org>
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
index c8432e24207e..943f312772ee 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -656,6 +656,7 @@ CONFIG_QCOM_SMEM=y
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

