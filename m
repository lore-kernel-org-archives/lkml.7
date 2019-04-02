Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7192C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4CE20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbfDBLtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:49:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49564 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfDBLtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:49:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A982B374;
        Tue,  2 Apr 2019 04:49:39 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C34B73F59C;
        Tue,  2 Apr 2019 04:49:37 -0700 (PDT)
Subject: Re: [PATCH 1/2] stmmac: introduce flag to dynamically disable TX
 offload for rockchip devices
To:     Jose Abreu <jose.abreu@synopsys.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        =?UTF-8?Q?Christoph_M=c3=bcllner?= 
        <christoph.muellner@theobroma-systems.com>
Cc:     "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
References: <20190401181840.31255-1-papadakospan@gmail.com>
 <9d65a22a-2288-dc53-0059-ec4a31424dd8@arm.com> <2312344.mOsv7YkeBG@diego>
 <9EC67532-2D43-4AAD-BFA7-8B6797067427@theobroma-systems.com>
 <78EB27739596EE489E55E81C33FEC33A0B421348@de02wembxa.internal.synopsys.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4a9839d6-3d90-4354-7b64-78d5c1126e99@arm.com>
Date:   Tue, 2 Apr 2019 12:49:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <78EB27739596EE489E55E81C33FEC33A0B421348@de02wembxa.internal.synopsys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2019 08:59, Jose Abreu wrote:
> From: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> Date: Mon, Apr 01, 2019 at 20:12:21
> 
>> + Christoph.
>>
>>> On 01.04.2019, at 21:06, Heiko Stübner <heiko@sntech.de> wrote:
>>>
>>> Am Montag, 1. April 2019, 20:54:45 CEST schrieb Robin Murphy:
>>>> On 01/04/2019 19:18, Leonidas P. Papadakos wrote:
>>>>> From: =?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>
>>>>>
>>>>> Some rockchip boards exhibit an issue where tx checksumming does not work
>> with
>>>>> packets larger than 1498.
>>>>
>>>> Is it really a board-level problem? I'm no networking expert, but the
>>>> nature of the workaround suggests this is more likely to be some
>>>> inherent limitation of the IP block in the SoC, rather than something to
>>>> do with how the external pins get wired up. Does anyone have an RK3328
>>>> or RK3399 board that provably *does* checksum large packets correctly?
>>>
>>> I don't have that many rk3399-boards with actual ethernet and even only
>>> the rock64 from rk3328-land, but at least my rk3399-firefly also seems
>>> affected by this.
>>>
>>> But so far the rk3399-puma board from Theobroma did not show that ethernet
>>> issue for me, so I've added two Theobroma people who may or may not tell
>>> if they've also seen that issue.
>>>
>>>>
>>>>> This is bad for network stability.
>>>>>
>>>>> The previous approach was using force_thresh_dma_mode in the board dts,
>> which
>>>>> does more than we need.
>>>>
>>>> If indeed it is a SoC-level thing (or at least we want to treat it as
>>>> such), then couldn't we just hang it off the existing SoC-specific
>>>> compatibles in dwmac-rk.c and avoid the need for a new DT property at
>>>> all? After all, that's precisely why SoC-specific compatibles are a
>>>> thing in the first place.
>>>>
> 
> This can happen when FIFO size + PBL settings are not big enough for COE.
> 
> Can you please share the above settings ?

Can the FIFO size be discovered by dumping registers, or does someone 
from Rockchip need to look up the IP configuration details?

FWIW, taking a look at the RK3399 TRM, this (p788) jumps out:

"PBL
...
For TxFIFO, valid PBL range in full duplex mode and duplex mode is
128 or less.
For RxFIFO, valid PBL range in full duplex mode is all."


Does that suggest that it's worth fiddling with the "snps,txpbl" value 
in DT?

Thanks,
Robin.
