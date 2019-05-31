Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D21CC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361EB26B30
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="A0g3YKJa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfEaO7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 10:59:03 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18680 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfEaO7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 10:59:03 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf141300000>; Fri, 31 May 2019 07:58:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 31 May 2019 07:58:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 31 May 2019 07:58:57 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 May
 2019 14:58:55 +0000
Subject: Re: [PATCH] clk: tegra210: Fix default rates for HDA clocks
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
References: <1559121501-8566-1-git-send-email-jonathanh@nvidia.com>
 <20190529134625.GD17223@ulmo>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <5f2b8f8d-f3e5-fab8-8cf0-fa8a3e917845@nvidia.com>
Date:   Fri, 31 May 2019 15:58:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529134625.GD17223@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559314736; bh=09b8Hj8gT+YozScXT2vWayl8rWGsou6vOfDDno+ASS4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=A0g3YKJa/+HLaNBx+m+VrU8EYVw4tfLuSwscYdhmFJYQjvazlnZdrcrz0pk1L/uWP
         9W03XicTcq9hvnaJr0voPnHYTPpQV8+JmYFP4YjFiDmuPEyNhbf8RkDjdmxsSabks3
         59+mI4npWajCtrpHnLg650pHmzfupvK8TxEx6oowcmyRX1ISnIXtzZuzygaSZbqk4w
         9YSGxeeRrDrt8M16zpD1qyAWbtY5G4bkacH/sFGArHuXtlD82ck4NKIeh0pkmnc4Iw
         nDgNAVAwYAaXu5BUTKjVOlJ2h1M5D6L2a6iSI2RpF23bDtij4VfKg1C1JyBzh6PP+m
         a3/yaIpYEzg9Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/05/2019 14:46, Thierry Reding wrote:
> On Wed, May 29, 2019 at 10:18:21AM +0100, Jon Hunter wrote:
>> Currently the default clock rates for the HDA and HDA2CODEC_2X clocks
>> are both 19.2MHz. However, the default rates for these clocks should
>> actually be 51MHz and 48MHz, respectively. Correct the default clock
>> rates for these clocks by specifying them in the clock init table for
>> Tegra210.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  drivers/clk/tegra/clk-tegra210.c | 2 ++
>>  1 file changed, 2 insertions(+)
> 
> Does this fix anything? Should this be backported to stable releases?

Good point. We are aligning the clock configuration with what we ship.
So I thought for completeness it would be good to test HDA playback
across the various sample-rates we support (32kHz to 192kHz) but with or
without this patch I am not hearing anything. Let me check on this with
Sameer as I would like to see if we need to mark this for stable or not.

> Acked-by: Thierry Reding <treding@nvidia.com>

Thanks
Jon

-- 
nvpublic
