Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146E5C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60FE20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jRuI5ozt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbfCFMAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 07:00:10 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16028 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfCFMAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 07:00:09 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7fb6480001>; Wed, 06 Mar 2019 04:00:08 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 06 Mar 2019 04:00:09 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 06 Mar 2019 04:00:09 -0800
Received: from [10.26.11.158] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 Mar
 2019 12:00:05 +0000
Subject: Re: [PATCH 3/3] irqchip/gic-pm: use devm_clk_*() helpers
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Sameer Pujar <spujar@nvidia.com>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>
CC:     <thierry.reding@gmail.com>, <ldewangan@nvidia.com>,
        <mkumard@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
References: <1551868878-1131-1-git-send-email-spujar@nvidia.com>
 <1551868878-1131-3-git-send-email-spujar@nvidia.com>
 <487578fe-fa14-f1c4-fad9-ff47ebde2273@arm.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <573022cf-e2e3-0e12-d16c-6d465b8af2ce@nvidia.com>
Date:   Wed, 6 Mar 2019 12:00:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <487578fe-fa14-f1c4-fad9-ff47ebde2273@arm.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551873608; bh=wtxcN7HqwIEzsoRUV3KQcp8qR8MUNuxh0LLKXkxrkTU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jRuI5oztX65yQkvppdckPVCK/y8JlmSuMDBNTMw7SUprrDt68RJXuZw2wzznPV053
         Tn/bmwY8tJG7xw1RPwN3y9NZTPIOHMxabBdDtx9sNF2xLUjV6FfUwo/X33KBm/Te6O
         xR8ywgH3tI3O8Qm4sNOSstDfvtmWdcSTiZ1fVwyoUrYkwSwnWKG08zhEg72mmrZsJN
         7E9kwd+l3x5Ts8ubmNqKEqZszvlLY1YVY0jHB9IZqFQOOutxiYeTEWf3925Vpw43Ul
         8f4ral8UHXwXZYcA7hBGCO3D24WhzbDbJS2KRql6ERuFLfYj8CXS1gHho0SdDgdpoU
         O8Q1BR7GqGd5g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/03/2019 11:31, Marc Zyngier wrote:
> Hi Sameer,
> 
> [unrelated to this email: anything that comes from NVIDIA reaches me
>  encrypted with my public key. Not a big deal, but it'd be good if
>  someone could fix that.]
> 
> On 06/03/2019 10:41, Sameer Pujar wrote:
>> With pm_clk_*() usage, it is seen that clocks always remain ON. This
>> happens because clocks are managed by BPMP on Tegra devices and clock
>> enable/disable happens during prepare/unprepare phase. This patch
>> avoids use of pm_clk_*() and replaces it with devm_clk_*() helpers.
>>
>> Suggested-by: Mohan Kumar D <mkumard@nvidia.com>
>> Reviewed-by: Jonathan Hunter <jonathanh@nvidia.com>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> 
> On its own, I'm not opposed to that patch.
> 
> But given that there is no in-tree platform using this, despite the code
> sitting here for more than 2.5 years, this is just updating dead code.
> 
> Am I missing anything?

Nope, but we are working to fix that at long last. I hope in the next
few months it will not longer be dormant! This driver is still very much
important to our audio support for newer Tegra devices.

Cheers
Jon

-- 
nvpublic
