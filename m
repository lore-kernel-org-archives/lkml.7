Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575BCC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDC4206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfKLNAj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:00:39 -0500
Received: from hermes.aosc.io ([199.195.250.187]:46121 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfKLNAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:00:38 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id DB3C040E63;
        Tue, 12 Nov 2019 13:00:36 +0000 (UTC)
Date:   Tue, 12 Nov 2019 20:59:56 +0800
In-Reply-To: <20191111123936.GM4345@gilmour.lan>
References: <BN8PR08MB57792366D78997180A698AF8897A0@BN8PR08MB5779.namprd08.prod.outlook.com> <20191111123936.GM4345@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] clk: sunxi-ng: v3s: Fix incorrect number of hw_clks.
To:     linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        Tian Yunhao <t123yh@outlook.com>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <1FA73EE3-CED2-4241-839D-51C8C02531F5@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2019年11月11日 GMT+08:00 下午8:39:36, Maxime Ripard <mripard@kernel.org> 写到:
>Hi,
>
>Thanks for your patch
>
>On Sat, Nov 09, 2019 at 03:19:09PM +0000, Tian Yunhao wrote:
>> The hws field of sun8i_v3s_hw_clks has only 74
>> members. However, the number specified by CLK_NUMBER
>> is 77 (= CLK_I2S0 + 1). This leads to runtime segmentation
>> fault that is not always reproducible.
>>
>> This patch adds a protective field [CLK_NUMBER] which ensures
>> ARRAY_SIZE(.hws) is always greater than .num, thus eliminates
>> this error.
>>
>> Signed-off-by: Yunhao Tian <t123yh@outlook.com>
>> ---
>>  drivers/clk/sunxi-ng/ccu-sun8i-v3s.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
>b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
>> index 5c779eec454b..de7fce7f32e6 100644
>> --- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
>> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
>> @@ -617,6 +617,7 @@ static struct clk_hw_onecell_data
>sun8i_v3s_hw_clks = {
>>  		[CLK_AVS]		= &avs_clk.common.hw,
>>  		[CLK_MBUS]		= &mbus_clk.common.hw,
>>  		[CLK_MIPI_CSI]		= &mipi_csi_clk.common.hw,
>> +		[CLK_NUMBER]    = NULL,
>>  	},
>>  	.num	= CLK_NUMBER,
>>  };
>> @@ -699,6 +700,7 @@ static struct clk_hw_onecell_data
>sun8i_v3_hw_clks = {
>>  		[CLK_AVS]		= &avs_clk.common.hw,
>>  		[CLK_MBUS]		= &mbus_clk.common.hw,
>>  		[CLK_MIPI_CSI]		= &mipi_csi_clk.common.hw,
>> +		[CLK_NUMBER]    = NULL,
>>  	},
>>  	.num	= CLK_NUMBER,
>
>I'd rather have the number of clocks (.num) being properly set.

However the maximum clock indices number is different on V3s and V3, because
on V3s the last clock is missing.

Should we define CLK_NUMBER_V3S here?

>
>Maxime
