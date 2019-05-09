Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321A3C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F302173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mwp57xtW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfEIIJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 04:09:42 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14771 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfEIIJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 04:09:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd3e0200001>; Thu, 09 May 2019 01:09:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 09 May 2019 01:09:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 09 May 2019 01:09:40 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 May
 2019 08:09:39 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 9 May 2019 08:09:39 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cd3e0400002>; Thu, 09 May 2019 01:09:39 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <linus.walleij@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <pdeschrijver@nvidia.com>, <josephl@nvidia.com>,
        <smangipudi@nvidia.com>, <ldewangan@nvidia.com>,
        <vidyas@nvidia.com>, Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch-V2 4/4] soc/tegra: select pinctrl for Tegra194
Date:   Thu, 9 May 2019 13:38:16 +0530
Message-ID: <1557389296-10257-4-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557389296-10257-1-git-send-email-kyarlagadda@nvidia.com>
References: <1557389296-10257-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557389344; bh=vZPeMulyG2M0BcsrWsBCmVEo9iVP+aStJoSJsHmSI2c=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=mwp57xtWIpxNBSQE8ikeX1AHF7uCddS8NC+nbAirV61E/j27vdK3zhHBgozbwztLi
         gdaJ8QLKEtJlJdhmbtGRkr55FKXhLbwJPa9VvpqcCv2ruCS/klLAQ0NehgwNaB4Q+N
         MVqBaItfyCA5+aSxLpx44nu5AUuFc5XgdXLzEfkVQ5RPLA02vLDsX+RW9N9tKwmHJT
         dFvMHwyuaCwkE2oRqIKnpSYaomyaWB0qUwm6QOdoWPcZNpjCCFVaaCSuAh0Jjkrro5
         R+PwxJHaucAg0s+po+pXRddC/yE0/Z5SLxIE0dDzyj8Gl4QnvdiJtBZs2Nab9uL9Hk
         6NSmco929F2Aw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select PINCTRL_TEGRA194 by default for Tegra194 SOC needed
for dynamically controlling PCIe pins

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/soc/tegra/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index a0b0344..6f0df55 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -108,6 +108,7 @@ config ARCH_TEGRA_186_SOC
 config ARCH_TEGRA_194_SOC
 	bool "NVIDIA Tegra194 SoC"
 	select MAILBOX
+	select PINCTRL_TEGRA194
 	select TEGRA_BPMP
 	select TEGRA_HSP_MBOX
 	select TEGRA_IVC
-- 
2.7.4

