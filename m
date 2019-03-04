Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D59C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9250D2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="r9Bq7XRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfCDNHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:07:40 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9124 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfCDNHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:07:40 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7d231a0000>; Mon, 04 Mar 2019 05:07:38 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 04 Mar 2019 05:07:39 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 04 Mar 2019 05:07:39 -0800
Received: from [10.26.11.127] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 Mar
 2019 13:07:37 +0000
Subject: Re: Regression: ASoC: soc-core: clear platform pointers on error
To:     Curtis Malainey <cujomalainey@google.com>
CC:     Mark Brown <broonie@kernel.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <bbc0d37a-5a08-9ce0-58b6-c89d28c558ce@nvidia.com>
 <CAOReqxhYUASVFdrHzKEr8F_NA0CNnJ1Hx51L4ganvcrK=dSCCA@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <e4b5fe11-0351-ee0b-d093-2044c9b0475d@nvidia.com>
Date:   Mon, 4 Mar 2019 13:07:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAOReqxhYUASVFdrHzKEr8F_NA0CNnJ1Hx51L4ganvcrK=dSCCA@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551704858; bh=+l48uhph2Gs0SOvuWZTi7kJL2zT4n+ZpX+6rDd1IInM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=r9Bq7XRXkyYj02QjW0P4jBtQvhp72Gpr1l+B1cAwJAL+kYtPKSnEloex5/Tq1PP+w
         yU4H6ycq/cfjHpCzNRCoZp4KTYES8IObgYLdW5QacaSrZIB9YrV3EFMfqVxLc5Pzgw
         cIIUcYnCB1wFRVL6xOORX/O6v8wrfz/prM7uCpaDC/cPndhDU3VXatl/zvMCXLqXrQ
         XYavqRjWKX4wMPxUQJQRBdcOIbHegFKSsYHKG2AKkh2dX+h9U/Rqw2+yG8uaMQ1Hb1
         zDe0dL2u6L35Fmgwzkyp7PBIXQuE7bzRFU0HcIUW0aE/cKNYM1mVUrC8Ff2/LEshos
         75tZ7rd6YFc8A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/03/2019 17:28, Curtis Malainey wrote:
> On Fri, Mar 1, 2019 at 4:07 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>> Hi Mark, Curtis,
>>
>> I am seeing a regression on -next where the soundcard on one of our
>> Tegra boards fails to initialise following a probe deferral. The bisect
>> points to the commit 78a24e10cd94420f1b4e2dc5923ae7109e2aaba1 ('ASoC:
>> soc-core: clear platform pointers on error') and reverting this on top
>> of -next fixes the problem.
>>
>> Looking at the bootlog from the failure I see ...
>>
>>  tegra-snd-wm8903 sound: ASoC: failed to init link WM8903
>>
>>  tegra-snd-wm8903 sound: snd_soc_register_card failed (-517)
>>
>>  tegra30-i2s 70080400.i2s: DMA channels sourced from device 70080000.ahub
>>
>>  tegra-snd-wm8903 sound: ASoC: Both platform name/of_node are set for WM8903
>>
>>  tegra-snd-wm8903 sound: ASoC: failed to init link WM8903
>>
>>  tegra-snd-wm8903 sound: snd_soc_register_card failed (-22)
>>
>>  tegra-snd-wm8903: probe of sound failed with error -22
>>
>>
>> With the above change I see soc_cleanup_platform() is ever being called
>> when the probe is deferred and hence leads to the failure. Note that the
>> initial failure, "ASoC: failed to init link WM8903" occurs very early
>> in snd_soc_register_card() when initialising the prelinks.
>>
>> The following fixes it, but I have not scrutinised the code to see if
>> there are other exit points that we need to handle.
>>
> You are indeed correct. That should be there. I think I got confused
> when I was doing my initial debugging on our local 4.19 kernel as the
> cleanup code had changed when I was testing on -next and forgot to add
> this to my upstream patch and it wasn't caught in my testing. Thanks
> for catching this. I went back and looked and it appears that is the
> only call to soc_init_dai_link that is outside soc_instantiate_card
> and therefore not caught by the original patch's cleanup routine. Do
> you want to submit a patch and I'll add my signoff?

Thanks. I will send out a patch shortly.

Cheers
Jon

-- 
nvpublic
