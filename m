Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395C2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D7920684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfCHIpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:45:06 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54394 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725789AbfCHIpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:45:06 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x288a82D016023;
        Fri, 8 Mar 2019 09:44:43 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qyhknmfsx-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 08 Mar 2019 09:44:43 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 475A731;
        Fri,  8 Mar 2019 08:44:42 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E81582B22;
        Fri,  8 Mar 2019 08:44:41 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.47) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 8 Mar
 2019 09:44:41 +0100
Subject: Re: [PATCH V2 6/6] mmc: mmci: replace blksz_datactrlXX by
 get_datactrl_cfg callback
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <1551976742-4358-1-git-send-email-ludovic.Barre@st.com>
 <1551976742-4358-7-git-send-email-ludovic.Barre@st.com>
 <20190307164649.ywhgdikxf4nhb2sd@shell.armlinux.org.uk>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <eb213e3e-a574-b11e-ad4f-dd270d964707@st.com>
Date:   Fri, 8 Mar 2019 09:44:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190307164649.ywhgdikxf4nhb2sd@shell.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-08_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Russell, Ulf

On 3/7/19 5:46 PM, Russell King - ARM Linux admin wrote:
> On Thu, Mar 07, 2019 at 05:39:02PM +0100, Ludovic Barre wrote:
>> -	if (data->flags & MMC_DATA_READ)
>> -		datactrl |= MCI_DPSM_DIRECTION;
> 
> Given that this is currently an invariant between all, it doesn't make
> sense to have a separate public function and combine it into the
> get_datactrl_cfg() implementations.  You may as well leave it in place
> here, after you call get_datactrl_cfg().
> 
>> +	datactrl = host->ops->get_datactrl_cfg(host);
> 
> Otherwise, I don't see a problem with this, although it would be nice to
> avoid the overhead of so many public functions, which could be done by
> adding them as inline functions in mmci.h
> 

To combine your comments (above and https://lkml.org/lkml/2019/3/6/318).
I could regroup mmci_dctrl_dir & mmci_dctrl_ddr & mmci_dctrl_sdio in a
common function mmci_dctrl_common and call by:
-Each get_datactrl_cfg variant
-Or in mmci_start_data

What do you prefer ?

Regards,
Ludo
