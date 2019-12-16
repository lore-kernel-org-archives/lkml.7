Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09763C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FA920665
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jS7jD2bC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfLPPtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:49:39 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35023 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbfLPPti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:49:38 -0500
Received: by mail-lf1-f65.google.com with SMTP id 15so4611917lfr.2;
        Mon, 16 Dec 2019 07:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XLefccWn9eLOZQVYfFnGLvT38QOza41B05dCschHmWs=;
        b=jS7jD2bCBBvJFfInfLsysA2/SacydhvAKRLPbaCZm9kCX3pEbkU+DyscpMbKooRhZs
         h544dWURUQyOXo0/bQwEhellGMd/VlQ1/IcSyTS+qUgsTb+ammoM8tYoeKcpP14K50cn
         CzG2pZnRX/+R+VKhQoR92F2AE926B49SvZBkZK41mZIrcGzX/zczjvwddjAc4tGGr4dE
         c1SEq/1MlAViqx+mT2+xxjepaaXMZ+LrVn663Yd1HFRTJmq/WpoMUzxo8sUBoxd9sUPk
         kjNxn2YRCiNFR2aiDMxWrTf0OaHZMHPTKCCcxJpJL5FKJFm3zCmoTjWWQzCfll95dnS+
         otdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XLefccWn9eLOZQVYfFnGLvT38QOza41B05dCschHmWs=;
        b=I8CCwJ1Aj6DQrFSgXEnoTrZECWLE5cYS/WJzXxqNo1/xYQOrREPt6mTLVCaoIK6s5R
         3MoN6ICTyIwaQ45GSSaBngT2moPwsMaBxtpnEawN6wK83kP6n/XG3raOogO4pX5zgQqV
         Ok+ni9hj9W8k869x9XfC+odgBJ2RW3sBN44GQGELcLVjgkGNeylQAGLCp7gVrxwLfdn0
         mYk9awcE9BXbhncFiXVdPuxrf18HWWY7z47VyEOOevKG3N4B8LMivxOm4COFOd1HDui3
         U4i5w6G9ZLWnKEr6stW32KJkDEOcS2dXWCmiww+2RfsFG8N0Zp+k658Q9r/tqHjAqOJ7
         ql9g==
X-Gm-Message-State: APjAAAUR2J+irtFut7MlbRUO4heQih639J/O4eRHmvGOARDe0KjUas6X
        33BTmuzXMvUYNbmrnnLSkAQ=
X-Google-Smtp-Source: APXvYqwgxkuXc185DH64gccxf2DghtR89KC9lp7fJkIdwOQboVqZO5SyW248v+/giOL9Y7/LPT5P3A==
X-Received: by 2002:a19:c210:: with SMTP id l16mr17999700lfc.35.1576511375718;
        Mon, 16 Dec 2019 07:49:35 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id n13sm10730783lji.91.2019.12.16.07.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 07:49:34 -0800 (PST)
Subject: Re: [PATCH v3 03/15] soc: tegra: Add Tegra PMC clock registrations
 into PMC driver
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, allison@lohutok.net, pgaikwad@nvidia.com,
        mturquette@baylibre.com, horms+renesas@verge.net.au,
        Jisheng.Zhang@synaptics.com, krzk@kernel.org, arnd@arndb.de,
        spujar@nvidia.com, josephl@nvidia.com, vidyas@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alexios.zavras@intel.com, alsa-devel@alsa-project.org
References: <ccb715cc-c927-ea91-a26e-24d6eeeeef1a@gmail.com>
 <ee1d39d4-9a57-da9b-fce6-8130dac1d2fd@nvidia.com>
 <49da77dc-b346-68eb-9ef8-42cfb3221489@nvidia.com>
 <3f1c9325-3017-62be-1e3b-82fd28540fdf@nvidia.com>
 <6fcbff3d-8695-7cd0-60de-6eb523b6964c@gmail.com>
 <20191211151028.GZ28289@pdeschrijver-desktop.Nvidia.com>
 <0930a710-174b-859b-294c-e9f81f6a3b5e@gmail.com>
 <20191216122005.GB28289@pdeschrijver-desktop.Nvidia.com>
 <53653719-f8e5-f6d1-a1d1-e53c7ccd7636@gmail.com>
 <20191216151132.GC28289@pdeschrijver-desktop.Nvidia.com>
 <20191216152435.GD28289@pdeschrijver-desktop.Nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fa538845-cb8e-cf88-34be-3ceb2daa63c2@gmail.com>
Date:   Mon, 16 Dec 2019 18:49:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191216152435.GD28289@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.12.2019 18:24, Peter De Schrijver пишет:
> On Mon, Dec 16, 2019 at 05:11:32PM +0200, Peter De Schrijver wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Mon, Dec 16, 2019 at 05:23:23PM +0300, Dmitry Osipenko wrote:
>>>>> Could you please clarify what do you mean by the "existing users"?
>>>>> AFAIK, nothing in kernel uses mux clocks.
>>>>
>>>> The DT clk bindings allow for parent initialization, so it's certainly
>>>> possible there are some DTs which rely on this. We promised to never
>>>> break the bindings, which changing to 1 clock would do.
>>>
>>> What about this variant:
>>>
>>>   1. Keep the old CaR code in place.
>>>
>>>   2. Make CaR driver to scan whole device-tree for the legacy PMC clocks.
>>>
>>>   3. If legacy clock is found, then register PMC clocks from CaR.
>>>
>>>   4. If legacy clocks are not found, then don't register PMC clocks from
>>> CaR.
>>>
>>>   5. Add clocks support to the PMC driver and only register them if
>>> legacy clocks are not registered by CaR.
>>>
>>> Now both old and new DTBs can co-exist and work, everyone happy.
>>
>> That seems even more work.. Today the only upstream user is audio.
>> Currently these clocks are setup by the CAR clock driver. However
>> as they will move to the PMC driver, this mechanism cannot be used.
>> Hence the plan is to modify the audio driver to check for the PMC clocks
>> in DT and if they are not available use the CAR clocks as fallback.
>> The whole reason the clocks move to the PMC driver, is that when PMC
>> becomes secure, all accesses have to go via an SMC. Given that we don't
>> want SMCs all over the Tegra drivers, it's a good opportunity to move
>> the PMC clock handling into the PMC driver. PMC can be secure with both
>> 'new' and old DTs, so just registering the PMC clocks in the CAR driver
>> if legacy clocks are found in the DT, won't always work.
>>
> 
> Given the audio driver needs to change anyway, we can indeed use 1 clock
> per PMC clk_out_ rather than 2 as we have today. As this models the hw
> slightly better, I think we should do that as you suggested.
> 
> Peter.
> 

Okay, let's try and see how it will go.
