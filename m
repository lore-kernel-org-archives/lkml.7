Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C6BC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A1B21D71
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="PFe9zeM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfJCKQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:16:45 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:15750 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726070AbfJCKQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:16:44 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x93A1YhG005393;
        Thu, 3 Oct 2019 12:16:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=L4LLR9A842To83iMCr2kJJo+nQXIiFznTI7PhQwWL6M=;
 b=PFe9zeM2Zoy1K7RCpNUac4jSDN/qZtCabQVNCg/lYvXkJTRfa2Urog1hqg/aPyduHn8w
 MndtdtMz929onq4Rl3dbaFLli/rBuv/P/EZR6XvsdAJ1rMchgHJg3zvQNrocnJcmYtWN
 LbJEXZvBrQ/TKtzJHzULUkJnDEA/uw3N8AZi3hr6Cje012lbHwT+DAtYV1dfuSUgqMpu
 m1plOZpHDWATmcEigXunX2TEIHNsPIpoBrN2Z2pdeuSj1Dd5gbJZ+IfT2z5QEe5j2low
 05hPwvGKQpwo5bCPf0PqOQFtFFKWpVkxqwG7oWrsJ+1Pt7i3w11boqtPDguVugdvBkSH qg== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vcem38uxw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 03 Oct 2019 12:16:29 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 43A0322;
        Thu,  3 Oct 2019 10:16:26 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 978052B7B2E;
        Thu,  3 Oct 2019 12:16:25 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 3 Oct
 2019 12:16:24 +0200
Subject: Re: [PATCH 0/5] net: ethernet: stmmac: some fixes and optimization
To:     Christophe Roullier <christophe.roullier@st.com>,
        <robh@kernel.org>, <davem@davemloft.net>, <joabreu@synopsys.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <peppe.cavallaro@st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>
References: <20190920053817.13754-1-christophe.roullier@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <7575369f-0f42-9afa-4212-bb82100a7a1b@st.com>
Date:   Thu, 3 Oct 2019 12:16:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920053817.13754-1-christophe.roullier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-03_04:2019-10-01,2019-10-03 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe

On 9/20/19 7:38 AM, Christophe Roullier wrote:
> Some improvements (manage syscfg as optional clock, update slew rate of
> ETH_MDIO pin, Enable gating of the MAC TX clock during TX low-power mode)
> Fix warning build message when W=1
> 
> Christophe Roullier (5):
>    net: ethernet: stmmac: Add support for syscfg clock
>    net: ethernet: stmmac: fix warning when w=1 option is used during
>      build
>    ARM: dts: stm32: remove syscfg clock on stm32mp157c ethernet
>    ARM: dts: stm32: adjust slew rate for Ethernet
>    ARM: dts: stm32: Enable gating of the MAC TX clock during TX low-power
>      mode on stm32mp157c
> 

DT patches will be applied on stm32-next after dwmac-stm32 patches merge 
in net-next.

>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi     |  9 +++-
>   arch/arm/boot/dts/stm32mp157c.dtsi            |  7 ++--
>   .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 42 ++++++++++++-------
>   3 files changed, 38 insertions(+), 20 deletions(-)
> 
