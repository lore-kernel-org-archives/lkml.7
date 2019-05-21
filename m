Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB15AC46470
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4AC217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="bRe5RYF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfEUJJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:09:53 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:5894 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726289AbfEUJJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:09:53 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4L97hoe017768;
        Tue, 21 May 2019 11:09:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=lanOOaJJhF0ZBJh2G1RjFUX4Qzrh7K+TLtAOvfetblM=;
 b=bRe5RYF7j5mqLmuY9w5O4gw2YTeWuQsf0Yas7I8oqr5kIb/Afh3Tb2KdNndOsQ0c9jZ6
 YxvrwN0FJ1LquPYJZZA8u4T79Y0uMMv0Ec8dehaccLUDmAgXIvy0n5bMwZ/A+sRIUxjo
 u9pLG3l9p3NRyxT16VfNwX5vtUxC4vYp0cgBgqKZClFi57CeufA3uwPWMw7FcyWqJgaw
 BpLteRODvp+WvY1T3GvDdAX0DEsEA2SF7Tr7NHjI/nPqb5KMCbhYjUW0L6ES/uANOQjr
 vfH7tCyzqNN74F7vA/Jugg6Ko1ytcrbIf1YnUpnLqauMurEEAv0lmiWtBzngS1LN9iJG hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sj7740qgk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 21 May 2019 11:09:38 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 44ADA38;
        Tue, 21 May 2019 09:09:37 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CFB4824D3;
        Tue, 21 May 2019 09:09:36 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 21 May
 2019 11:09:36 +0200
Subject: Re: [RESEND v2 0/3] Add Vivante GPU support on STM32MP157c
To:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1558082528-12889-1-git-send-email-pierre-yves.mordret@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <c565693a-a7fe-4361-0e1f-6bf09e2d8b84@st.com>
Date:   Tue, 21 May 2019 11:09:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558082528-12889-1-git-send-email-pierre-yves.mordret@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-21_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre-Yves,

On 5/17/19 10:42 AM, Pierre-Yves MORDRET wrote:
> Add and enable Vivante GPU on stm32mp157c for ED1, DK1 and DK2 boards.
> ---
>    Version history:
>      v2:
>         * move GPU reserved memeory out of bottom DDR to let free this area for
>           U-Boot
>      v1:
>         * Initial
> ---
> Pierre-Yves MORDRET (3):
>    ARM: dts: stm32: Add Vivante GPU support on STM32MP157c
>    ARM: dts: stm32: enable Vivante GPU support on stm32mp157c-ed1 board
>    ARM: dts: stm32: enable Vivante GPU support on stm32mp157a-dk1 board
> 
>   arch/arm/boot/dts/stm32mp157a-dk1.dts | 16 ++++++++++++++++
>   arch/arm/boot/dts/stm32mp157c-ed1.dts | 16 ++++++++++++++++
>   arch/arm/boot/dts/stm32mp157c.dtsi    | 10 ++++++++++
>   3 files changed, 42 insertions(+)
> 

Series applied on stm32-next.

Thanks
Alex
