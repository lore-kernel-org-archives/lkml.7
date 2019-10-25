Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B994DCA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9173521D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="aMwI8klD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408889AbfJYJuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:50:55 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:7018 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394402AbfJYJuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:50:55 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9P9kDaV017184;
        Fri, 25 Oct 2019 11:50:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=QLmQ7NG6Rb6GQwzM3It23TN1eLiUzLgrVwcFTuDKfVY=;
 b=aMwI8klDD8OHXRbQDkKmUSJYL1BJAGOs/xEFuqPNo0MHhZVqVd1mu45I1V+MPcaY7Gig
 KJCqbeKu/FLKDH9m6ZImsPIFY/KbfIS+/B75CvqmQXBIUHlcYyG8R4hSPVPzVUDbGCV9
 h89gL+XE38aFBQiBf3gX3vRxGdoTGhpUYBDaDG22R6r1+8aPS61e7PcI7fIpD6FOcV3O
 TCukUg4kLi74WfgFHoVSMAdsiXbPawYEQJS0tpfuGLXeujT2CdeWZWj4pta3xL7QMIAQ
 IpUA+evHHgEjD0dOPCCAUv4aRZHlxb73Tmvkj1upqdxUmH8Q55l5AK8UrP1P2vkLY0k2 Gg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vt9s56xa7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Oct 2019 11:50:45 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7AE4610002A;
        Fri, 25 Oct 2019 11:50:41 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 484B52BF6B3;
        Fri, 25 Oct 2019 11:50:41 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.46) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 25 Oct
 2019 11:50:40 +0200
Subject: Re: [PATCH 0/2] Add support for DAC on stm32mp157c-ed1
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1570630372-24579-1-git-send-email-fabrice.gasnier@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <28a4fc8c-9dd7-3139-c569-4749a6a47664@st.com>
Date:   Fri, 25 Oct 2019 11:50:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1570630372-24579-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-25_05:2019-10-23,2019-10-25 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi fabrice

On 10/9/19 4:12 PM, Fabrice Gasnier wrote:
> This series adds support for digital-to-analog converter on
> stm32mp157c-ed1 board:
> - define pins that can be used for DAC
> - configure DAC channels to use these
> 
> Fabrice Gasnier (2):
>    ARM: dts: stm32: Add DAC pins used on stm32mp157c-ed1
>    ARM: dts: stm32: Add DAC support to stm32mp157c-ed1
> 
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 12 ++++++++++++
>   arch/arm/boot/dts/stm32mp157c-ed1.dts     | 13 +++++++++++++
>   2 files changed, 25 insertions(+)
> 

Series applied on stm32-next.

Regards
Alex
