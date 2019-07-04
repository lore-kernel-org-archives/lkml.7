Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B502C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5B521882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="up7Bnca1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfGDJIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 05:08:51 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37534 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbfGDJIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:08:51 -0400
Received: by mail-ed1-f68.google.com with SMTP id w13so4743039eds.4;
        Thu, 04 Jul 2019 02:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8q8DkGNrfD4Xi3IczgdLormMM6nLc6XqC3dSoMzfAWk=;
        b=up7Bnca1rT3o22OHI2C2t52VCOIojXdPdRI219jXAZV4DaHZm1HeyrZB3WkGYjBJxl
         U65+8Iw/occqMJ/27O6cZnsmKbajBt7bMZPbA3tx/GsJNzaLddo4OVStCRRpPJH0x5NJ
         NUDqKHLCbRsqIce0PnKKiI9J7fhBiKP90N8cf7+3Vj+jC+FtqdWZUqx5ubu+Rg6od0g/
         UuzRRTZN9ZUp3rWcyKs0UWiAVEf48pgc2Rp0tIR7ALFlOXEUaqjGrdYZfn48i7VOTsjD
         eKHBDcJPAPSes7SIA8oAdR1Kned7LCdlI9QzR3l9r4XAcdTsMPdlGKkBlD2oFAMXdQxP
         CK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8q8DkGNrfD4Xi3IczgdLormMM6nLc6XqC3dSoMzfAWk=;
        b=RfdiZQYsnB3OOyeN5EA7hkXZAvErLZbzlfsOSVsrgO3A4Ysw3kd5lwcG7DUKNCyYYj
         Siy6rHIavc0G1x60AzrG7JMiyvGnCLoblxQUPqGzvsNz47ESol9mgUm5kZ1i/Dq7ADQ3
         nm6+gdL06dYTc0rKx2sVYGXBmXg6KAcXVSjcI0J1ICQNEBSCxIq5EoDmOGbkBE5qW3wf
         7qiM/95WaToJlpKBhOlXZiUdojB5kO7Ave4xEl9PJzwBfpfgAJv2fWlgdtHZrVIl7/YQ
         EjqQNwdmyh8SxahMXORG9BZB/MFGjL6SghbLt4A9EnHaS0I/vYwWlRUB1i4Nfijpohbx
         gc6A==
X-Gm-Message-State: APjAAAUQsOxmvuufbeAohTdroj5Lt3/GxIMeo0wMbM656hmSH0Z3OGoK
        kobjrTtwOP5/ga7/Sqp4aZU=
X-Google-Smtp-Source: APXvYqw4GdkNSDA1K7C3X7bNZpgbd35nz1D+f/GWGJssYEK1POlniMr0ebfij+JXK78rmDJCmyQMnw==
X-Received: by 2002:a17:906:6557:: with SMTP id u23mr22844136ejn.186.1562231328597;
        Thu, 04 Jul 2019 02:08:48 -0700 (PDT)
Received: from ziggy.stardust ([37.223.141.54])
        by smtp.gmail.com with ESMTPSA id e43sm1497090ede.62.2019.07.04.02.08.46
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 02:08:48 -0700 (PDT)
Subject: Re: [PATCH v5 08/12] dt-bindings: mediatek: Change the binding for
 mmsys clocks
To:     CK Hu <ck.hu@mediatek.com>, Matthias Brugger <mbrugger@suse.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ulrich Hecht <ulrich.hecht+renesas@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "matthias.bgg@kernel.org" <matthias.bgg@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
 <20181116125449.23581-9-matthias.bgg@kernel.org>
 <20181116231522.GA18006@bogus>
 <2a23e407-4cd4-2e2b-97a5-4e2bb96846e0@gmail.com>
 <CAL_JsqKJQwfDJbpmwW+oCxiDkSp5+6mG-uoURmCQVEMP_jFOEg@mail.gmail.com>
 <154281878765.88331.10581984256202566195@swboyd.mtv.corp.google.com>
 <458178ac-c0fc-9671-7fc8-ed2d6f61424c@suse.com>
 <154356023767.88331.18401188808548429052@swboyd.mtv.corp.google.com>
 <a229bfc7-683f-5b0d-7b71-54f934de6214@suse.com>
 <1561953318.25914.9.camel@mtksdaap41>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 jrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <84d1c444-d6cb-9537-1bf5-b4e736443239@gmail.com>
Date:   Thu, 4 Jul 2019 11:08:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1561953318.25914.9.camel@mtksdaap41>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi CK-Hu,

On 01/07/2019 05:55, CK Hu wrote:
> Hi, Matthias:
> 
> On Fri, 2018-11-30 at 16:59 +0800, Matthias Brugger wrote:
>>
>> On 30/11/2018 07:43, Stephen Boyd wrote:
>>> Quoting Matthias Brugger (2018-11-21 09:09:52)
>>>>
>>>>
>>>> On 21/11/2018 17:46, Stephen Boyd wrote:
>>>>> Quoting Rob Herring (2018-11-19 11:15:16)
>>>>>> On Sun, Nov 18, 2018 at 11:12 AM Matthias Brugger
>>>>>> <matthias.bgg@gmail.com> wrote:
>>>>>>> On 11/17/18 12:15 AM, Rob Herring wrote:
>>>>>>>> On Fri, Nov 16, 2018 at 01:54:45PM +0100, matthias.bgg@kernel.org wrote:
>>>>>>>>> -    #clock-cells = <1>;
>>>>>>>>> +
>>>>>>>>> +    mmsys_clk: clock-controller@14000000 {
>>>>>>>>> +            compatible = "mediatek,mt2712-mmsys-clk";
>>>>>>>>> +            #clock-cells = <1>;
>>>>>>>>
>>>>>>>> This goes against the general direction of not defining separate nodes
>>>>>>>> for providers with no resources.
>>>>>>>>
>>>>>>>> Why do you need this and what does it buy if you have to continue to
>>>>>>>> support the existing chips?
>>>>>>>>
>>>>>>>
>>>>>>> It would show explicitly that the mmsys block is used to probe two
>>>>>>> drivers, one for the gpu and one for the clocks. Otherwise that is
>>>>>>> hidden in the drm driver code. I think it is cleaner to describe that in
>>>>>>> the device tree.
>>>>>>
>>>>>> No, that's maybe cleaner for the driver implementation in the Linux
>>>>>> kernel. What about other OS's or when Linux drivers and subsystems
>>>>>> needs change? Cleaner for DT is design bindings that reflect the h/w.
>>>>>> Hardware is sometimes just messy.
>>>>>>
>>>>>
>>>>> I agree. I fail to see what this patch series is doing besides changing
>>>>> driver probe and device creation methods and making a backwards
>>>>> incompatible change to DT. Is there any other benefit here?
>>>>>
>>>>
>>>> You are referring whole series?
>>>> Citing the cover letter:
>>>> "MMSYS in Mediatek SoCs has some registers to control clock gates (which is
>>>> used in the clk driver) and some registers to set the routing and enable
>>>> the differnet (sic!) blocks of the display subsystem.
>>>>
>>>> Up to now both drivers, clock and drm are probed with the same device tree
>>>> compatible. But only the first driver get probed, which in effect breaks
>>>> graphics on mt8173 and mt2701.
>>>
>>> Ouch!
>>>
>>
>> Yes :)
>>
>>>>
>>>> This patch uses a platform device registration in the DRM driver, which
>>>> will trigger the probe of the corresponding clock driver. It was tested on the
>>>> bananapi-r2 and the Acer R13 Chromebook."
>>>
>>> Alright, please don't add nodes in DT just to make device drivers probe.
>>> Instead, register clks from the drm driver or create a child platform
>>> device for the clk bits purely in the drm driver and have that probe the
>>> associated clk driver from there.
>>>
>>
>> I'll make the other SoCs probe via a child platform device from the drm driver,
>> as already done in 2/12 and 3/12.
> 
> This series have been pending for half an year, would you keep going on
> this series? If you're busy, I could complete this series, but I need to
> know what you have plan to do.
> 

You are right, it took far too long for me to respond with a new version of the
series. The problem I face is, that I use my mt8173 based chromebook for
testing. It needs some downstream patches and broke somewhere between my last
email and a few month ago. I wasn't able to get serial console to work, which
made things even more complicated. Anyway, long story short, I got sidetracked
with other stuff and didn't send a new version.

If you have time to work on this, I'd happy to see things being pushed forward
by you :)

> I guess that 1/12 ~ 5/12 is for MT2701/MT8173 and that patches meet this
> discussion. 6/12 ~ 12/12 is for MT2712/MT6797 but that patches does not
> meet this discussion. So the unfinished work is to make MT2712/MT6797 to
> align MT2701/MT8173, is this right?

After re-reading the emails I think the missing part is, to probe the clocks
from the DRM driver instead of adding a new devicetree binding for them.

Regards,
Matthias

> 
> Regards,
> CK
> 
>>
>> Regards,
>> Matthias
>>
>>>>
>>>> DT is broken right now, because two drivers rely on the same node, which gets
>>>> consumed just once. The new DT introduced does not break anything because it is
>>>> only used for boards that: "[..] are not available to the general public
>>>> (mt2712e) or only have the mmsys clock driver part implemented (mt6797)."
>>>
>>> Ok, so backwards compatibility is irrelevant then. Sounds fine to me.
>>>
>>>
>>
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
> 
