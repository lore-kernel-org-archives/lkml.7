Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6780C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBF521734
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="JsisJ/fp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfGZQ1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:27:13 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:27616 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727554AbfGZQ1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:27:12 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6QG7fWq014148;
        Fri, 26 Jul 2019 18:27:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=n6HKe0PgjUg51eRmGPMx0Q+MwoGoF4rstkH/lFHzWaM=;
 b=JsisJ/fpUkrGVDfSbnAzLrhU0vpu091fbUaYeaRC1Do+Xg5R8AE1Wdflko+wosp4+R7F
 ya+MTVXY6X0yGUrx2znky65+IAwBMKRttphn0UXtGe3GuDxucpAACX+UQmTk3q3poqeC
 /DcYKUe81hr1OIfNwuVYApiAUVhWiMLl2SDq6d1fn6P/iPB0ORPk8iXb+1Hy1XIeQQA8
 gM2gLphuWIzte4rglgFqd7h56FKz+gcjVNe5DiVtVuYPCroIYfnHwgXM83CWu3yPYQGz
 X3sch1vB/47ieQ44MWFKSwACSBmJYcw/smxwLA/hkavoRMvNjBkqXJ9CtUS6zsD0HViW dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2tx60absu1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 26 Jul 2019 18:27:03 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 10B1231;
        Fri, 26 Jul 2019 16:27:03 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DF60D4FD0;
        Fri, 26 Jul 2019 16:27:02 +0000 (GMT)
Received: from lmecxl0912.lme.st.com (10.75.127.51) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 26 Jul
 2019 18:27:02 +0200
Subject: Re: [PATCH] ARM: dts: stm32: fix -Wall W=1 compilation warnings for
 can1_sleep pinctrl
To:     Erwan Le Ray <erwan.leray@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bich.hemon@st.com>
References: <1561972686-23281-1-git-send-email-erwan.leray@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <8cb628b9-dbbf-98d6-e09a-2ecc082315d4@st.com>
Date:   Fri, 26 Jul 2019 18:27:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1561972686-23281-1-git-send-email-erwan.leray@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-26_12:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Erwan		

On 7/1/19 11:18 AM, Erwan Le Ray wrote:
> Fix compilations warnings detected by -Wall W=1 compilation option:
> - node has a unit name, but no reg property
> 
> Signed-off-by: Erwan Le Ray <erwan.leray@st.com>
> 
> diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
> index 140a983..ce98fd8 100644
> --- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
> @@ -427,7 +427,7 @@
>   				};
>   			};
>   
> -			m_can1_sleep_pins_a: m_can1-sleep@0 {
> +			m_can1_sleep_pins_a: m_can1-sleep-0 {
>   				pins {
>   					pinmux = <STM32_PINMUX('H', 13, ANALOG)>, /* CAN1_TX */
>   						 <STM32_PINMUX('I', 9, ANALOG)>; /* CAN1_RX */
> 

Thanks for cleaning the STM32 DT. Applied on stm32-next. Note that I 
changed commit title to indicate which STM32 platform is targeted by 
this patch.

Regards
Alex
