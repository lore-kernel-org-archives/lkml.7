Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A641EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E707206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfDCQMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:12:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44100 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfDCQMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:12:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48EBC80D;
        Wed,  3 Apr 2019 09:12:06 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77B1E3F68F;
        Wed,  3 Apr 2019 09:12:04 -0700 (PDT)
Subject: Re: [PATCH 1/2] stmmac: introduce flag to dynamically disable TX
 offload for rockchip devices
To:     "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Jose Abreu <jose.abreu@synopsys.com>
Cc:     Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        =?UTF-8?Q?Christoph_M=c3=bcllner?= 
        <christoph.muellner@theobroma-systems.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
References: <20190401181840.31255-1-papadakospan@gmail.com>
 <9d65a22a-2288-dc53-0059-ec4a31424dd8@arm.com> <2312344.mOsv7YkeBG@diego>
 <9EC67532-2D43-4AAD-BFA7-8B6797067427@theobroma-systems.com>
 <78EB27739596EE489E55E81C33FEC33A0B421348@de02wembxa.internal.synopsys.com>
 <4a9839d6-3d90-4354-7b64-78d5c1126e99@arm.com>
 <78EB27739596EE489E55E81C33FEC33A0B423811@de02wembxa.internal.synopsys.com>
 <c45d05f1-47b0-89d5-886d-d456d0111b7a@arm.com> <1554245296.1271.0@gmail.com>
 <78EB27739596EE489E55E81C33FEC33A0B4254A0@de02wembxa.internal.synopsys.com>
 <1554305721.1328.0@gmail.com> <1554306954.1328.1@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c863f88a-65e2-4093-7cc1-f37e4443b871@arm.com>
Date:   Wed, 3 Apr 2019 17:12:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1554306954.1328.1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2019 16:55, Leonidas P. Papadakos wrote:
> 
>> If snps,no-pbl-x8 does indeed have a performace hit, should the 
>> workaround be to
>> a) turn tx checksumming off or
>> b) snps,no-pbl-x8 set?
>>
>> I'll test to see the difference
> 
> Update: It really seems like snps,no-pbl-x8 is the better option.
> So I say, replace snps,force_thresh_dma_mode with it.

Yes, I would expect software checksumming to have a much more noticeable 
impact (in fact I've already been trying to get round to benchmarking 
some arm64 checksum optimisations on my RK3328 precisely because of this 
issue).

If I'm interpreting the register descriptions in the Rockchip TRMs 
correctly, it seems like no-pbl-x8 is a relatively big hammer and there 
should still be room to tune things a bit closer to the maximum limits - 
I'll have another play this evening to see if I've understood things right.

Robin.
