Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F9BC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD3A205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSKs5fDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfLPOX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:23:28 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40662 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfLPOX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:23:28 -0500
Received: by mail-lf1-f66.google.com with SMTP id i23so4351203lfo.7;
        Mon, 16 Dec 2019 06:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SDz/eeiUYW00uzzbWG7DKDZnUYir/tuNRcDkO6zwBsY=;
        b=QSKs5fDuzVkdH3m7fH8YkBd2PodkArxmfGtpqkuhuHCEVIp44IPGrWiUNbPNyXUmLD
         oSHUzqxTaiFBb6jPo1aKzD2rTL9ojEqbf5svoH5nxZ3IXiNAytr/ZoFCSKwRMPjHK0AS
         VT53eJgj9gMFfhc8TrEZZmPCIY3/4aD5AEJnsnqtICB+d4kXxpkYChbX6m4gYHiNoNgN
         3lQBVP3TF/xAnM5T0HqA0Fl6XY2exCS26s/auhrVPYFHtIKP4Y/WWPB9PHeqB1tnTF7O
         vPP1joK9iNxxU2KYaly0vR3sCwNXTHtMkMPBFzwGHAEeHKQI7rxEnM/hpZqrhD5n/bLk
         3nrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SDz/eeiUYW00uzzbWG7DKDZnUYir/tuNRcDkO6zwBsY=;
        b=iPpByowVbXuG43bUgpFXJxytQwDsIFjcmm8cbhrKOEMy81HLXl+KX+oX/JA8WRbQmE
         O7GjIoYWDUF77BE8QYXv95PGnVXjAzk/cxOzbTzLH/fKXjn8SGw21+qzA2oigi/pgP2c
         +k9OcVQYrJNIyAXQAlNOiQKKhoxKYIBKOw4GiFTZQzMreoB+GWNvz3rYf5059FHxFl4Z
         MAMwtzjPf++QWT39pkt5tIWpklMwgmi8Nj1tC5NotgJ52TVwCASQf8W23FrbyUjjz6pF
         kfmXm9ba2TvYQgnMOmV7b9djVefdMHK6WOnaVhptYAYi2gMA9NNmRDObomsaRJV3+ySV
         e+4w==
X-Gm-Message-State: APjAAAXrLaTr3JfzfYFdGEYq/MG3Jt9b7IB1bvQC4JMMUHyEYnlg0N6a
        f8IlqZXzb3Y3vycR3k56Sxw=
X-Google-Smtp-Source: APXvYqzMOp3oG1zDPBMq6S4CYV0V+gLdClhVaX0UoySeNVrCOjjJid4LlJ3k7mjrc3KHQBTL0oZ4VA==
X-Received: by 2002:ac2:4194:: with SMTP id z20mr17309513lfh.20.1576506205560;
        Mon, 16 Dec 2019 06:23:25 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id q10sm10729440ljj.60.2019.12.16.06.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 06:23:24 -0800 (PST)
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
References: <288a1701-def6-d628-26bc-a305f817bdb1@gmail.com>
 <78644d45-2ae3-121f-99fc-0a46f205907d@nvidia.com>
 <b35916e1-c6ee-52ca-9111-5ae109437b6e@nvidia.com>
 <ccb715cc-c927-ea91-a26e-24d6eeeeef1a@gmail.com>
 <ee1d39d4-9a57-da9b-fce6-8130dac1d2fd@nvidia.com>
 <49da77dc-b346-68eb-9ef8-42cfb3221489@nvidia.com>
 <3f1c9325-3017-62be-1e3b-82fd28540fdf@nvidia.com>
 <6fcbff3d-8695-7cd0-60de-6eb523b6964c@gmail.com>
 <20191211151028.GZ28289@pdeschrijver-desktop.Nvidia.com>
 <0930a710-174b-859b-294c-e9f81f6a3b5e@gmail.com>
 <20191216122005.GB28289@pdeschrijver-desktop.Nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <53653719-f8e5-f6d1-a1d1-e53c7ccd7636@gmail.com>
Date:   Mon, 16 Dec 2019 17:23:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191216122005.GB28289@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.12.2019 15:20, Peter De Schrijver пишет:
> On Thu, Dec 12, 2019 at 04:43:53AM +0300, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 11.12.2019 18:10, Peter De Schrijver пишет:
>>> On Tue, Dec 10, 2019 at 08:41:56PM +0300, Dmitry Osipenko wrote:
>>>
>>> ..
>>>
>>>>>
>>>>> PMC clock gate is based on the state of CLKx_ACCEPT_REQ and FORCE_EN
>>>>> like explained above.
>>>>>
>>>>> CLKx_ACCEPT_REQ is 0 default and FORCE_EN acts as gate to enable/disable
>>>>> EXTPERIPH clock output to PMC CLK_OUT_1/2/3.
>>>>
>>>> [and to enable OSC as well]
>>>>
>>>>> So I believe we need to register as MUX and Gate rather than as a single
>>>>> clock. Please confirm.
>>>>
>>>> 1. The force-enabling is applied to both OSC and EXTERN sources of
>>>> PMC_CLK_OUT_x by PMC at once.
>>>>
>>>> 2. Both of PMC's force-enabling and OSC/EXTERN selection is internal to PMC.
>>>>
>>>> Should be better to define it as a single "pmc_clk_out_x". I don't see
>>>> any good reasons for differentiating PMC's Gate from the MUX, it's a
>>>> single hardware unit from a point of view of the rest of the system.
>>>>
>>>> Peter, do you have any objections?
>>>
>>> The reason to have separate gate and mux clocks, is to preserve compatibility
>>> with existing users.
>>> Otherwise the current users would need to figure out if there's a
>>> single clock or 2 clocks to configure. I don't think adding that code in
>>> each user is worth it only to have a sligthly nicer modelling of the
>>> hardware.
>>
>> Could you please clarify what do you mean by the "existing users"?
>> AFAIK, nothing in kernel uses mux clocks.
> 
> The DT clk bindings allow for parent initialization, so it's certainly
> possible there are some DTs which rely on this. We promised to never
> break the bindings, which changing to 1 clock would do. 

What about this variant:

  1. Keep the old CaR code in place.

  2. Make CaR driver to scan whole device-tree for the legacy PMC clocks.

  3. If legacy clock is found, then register PMC clocks from CaR.

  4. If legacy clocks are not found, then don't register PMC clocks from
CaR.

  5. Add clocks support to the PMC driver and only register them if
legacy clocks are not registered by CaR.

Now both old and new DTBs can co-exist and work, everyone happy.
