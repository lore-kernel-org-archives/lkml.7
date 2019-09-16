Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D569C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD17206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XuOht1zH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390867AbfIPTUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 15:20:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:40957 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbfIPTUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 15:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568661560;
        bh=elXS+SmHE51BtQRYUS0Y0LeS8kJdvoe3N4Rug07ce1w=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XuOht1zHPZkqfNe7zeJVPJ4l+uC33wWJSiK6CDliiI61xb/jzJGxW29g3MC2ATvjE
         mhSeiUkcAKuzykGJnDHdBrHxXV+vV8UaPeeHFcuuWWwEBDsKN3/RPg3q0DViLj1WUO
         E7j/hddgO7Kml9x6pF9BiKyrkH75JXbsl9B8VDXU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.90]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeU0k-1ihuN22rmW-00aU4l; Mon, 16
 Sep 2019 21:19:20 +0200
Subject: Re: [PATCH v5 0/4] Raspberry Pi 4 DMA addressing support
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Matthias Brugger <mbrugger@suse.com>, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, linux-rpi-kernel@lists.infradead.org,
        phil@raspberrypi.org, linux-kernel@vger.kernel.org
References: <20190909095807.18709-1-nsaenzjulienne@suse.de>
 <5a8af6e9-6b90-ce26-ebd7-9ee626c9fa0e@gmx.net>
 <3f9af46e-2e1a-771f-57f2-86a53caaf94a@suse.com>
 <09f82f88-a13a-b441-b723-7bb061a2f1e3@gmail.com>
 <2c3e1ef3-0dba-9f79-52e2-314b6b500e14@gmx.net>
 <4a6f965b-c988-5839-169f-9f24a0e7a567@suse.com>
 <48a6b72d-d554-b563-5ed6-9a79db5fb4ab@gmx.net>
 <2fcc5ad6-fa90-6565-e75c-d20b46965733@suse.com>
 <3163f80b-72e5-5da8-0909-a8950d3669f7@gmx.net>
 <a5073e16-c017-216c-72b4-0e861102c4e8@gmail.com>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <c7e6ab89-aaae-debc-5f63-2e091efcf76f@gmx.net>
Date:   Mon, 16 Sep 2019 21:19:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a5073e16-c017-216c-72b4-0e861102c4e8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:OKdN1LqiR0I/Vb3hGfOwOac9GhdZhNItN4IibDlWnd1VUG1cA2d
 X8pKcRXWojQ/gaG5LixeZeR+RyMTGUNgQhB6sNeYZ28h4U+wAoQvjJVYAfoARzq3aMwPfiu
 w7K6w7ETmJPmYbLvPSpnikvN3Fb2J44lZRfQdm0Aaf3Jy5zP4wK4Jo7V3+qPDut1GaOGZIp
 5CXznjnea620TlDuVyfKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NkpHWCY5Y24=:Dm55ePhqeTCGkcupxp6T1H
 74dL64T5m4DwP/d3xvMA4lYMOgurPTUn2kJd/52gmAn7aQRoI50ModNJuI0NOqAWEwpNK/i/d
 EjC2I+0UMKqHJxziTCUy7tJIyOXPQVROJQg3hYn4dP6knJrOZAqCUiceC8JDpCwcnb0UuIzPb
 /Ow2BcpCEDxqpbKvc/peoMzfNEKqrdl4EbLKrSEDwzpODajrsIxh6nNaojAWslyuw/Ebk9GdQ
 x8mI+3hCJNODNRH7/ZPZj0Tdnj1/DIPUHc6ywCWzCmCiSkjsuoZKKl2/NTQ5CK/4MU4AOkwAQ
 q/zX0alDCQaYBWGgw8I+jDcs6WakhcJXtZnXSqqyCuVjx8yNQaOzpwSVe+kCaCAmekthItqEP
 uPczGh0VBbbvOS/ruIc7mZJO4SYqqlGIby3/z543BxBgaY4tbEyiOFzjIm+SJJA8jIqvClWf4
 IhquphBEuBxi8mYyh0CXzMt5yu5ywjPY1lzF0+Q5wfn7PgYBdizMTz+ltB1uALe9zXf0OTM+J
 SNgVTq82umz6v7OHIPVzAwKA6yeqhpwYYUg3Vcd89/HdNpbKXwFpjaIUMgt8ki4i+CtnSJoAu
 lL0vDdOPeDzrykFKJuH8Avl0mWjSfGgZ4oCjxOBVLCVdCvoNgUYc7vYVLoZbRBFA1b1LNpFie
 vYrtezk3OGGEpbPxyejiPdNDUn4juj+kTSRT5cUnJ0McpPZNzwq8BneOmLzZ04Gun/Df2wLxZ
 A8PVroOx/nxQvu8wUOjtlw6VNJptibD41O7/WRoqFMLZhh33qGcYvjVaH4/EDSv28V7Iw3Eb5
 vYhE1KEKoudwM/29yLxrCPjMJw+M+WA+TXTNk9oAaRc4rTIK0uNoCiFekmNIulk3OpscmSEOl
 hfQjHxMgXcB/+g/JoSrA/LGd1vxjzPcwshvGT5PNDITTkjtqwme5zemVQ+lyrVarh7tvy/HAs
 G33+ddPZoFe/sEQC4bI1LIyr0kiMMVeDYkssaKt/NpXbodN0dlIkqZH+xzCzrJSTtg+2UKgM7
 mMwn3+51ZpW2VrjafRy8VDhbzVI94yqK9GjEus/xBUTRqwHPVEc+HtJIQBXLU11o3bGOsdaei
 F4KY9bV1CVIAnnA643t+qp/cIjayAZzm7a5hA+OM1x+5NJpGDWq7VKBIlPIzMtZZCYcCrdLt6
 xd85OtUNBALmpQARyZnG7v/mk0oyRSla8dHmvJsgqy00ouXksUspVj61pcR9El3Ry/DI8/bBr
 jD9OAE66DVTw1J1vejHFbcpXCCSWlPm6+8+2SqXsZ847MWBR4nnCKuvUmsBk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

[drop uninvolved receiver]

Am 13.09.19 um 12:39 schrieb Matthias Brugger:
>
>>>>>  If you talk about the
>>>>> downstream kernel, I suppose you mean we should change this in the FW DT blob
>>>>> and in the downstream kernel. That would work for me.
>>>>>
>>>>> Did I understand you correctly?
>>>> Yes
>>>>
>>>> So i suggest to add the upstream compatibles into the repo mentioned above.
>>>>
>>>> Sorry, but in case you decided as a U-Boot developer to be compatible
>>>> with a unreviewed DT, we also need to make U-Boot compatible with
>>>> upstream and downstream DT blobs.
>>>>
>>> Well RPi3 is working with the DT blob provided by the FW, as I mentioned earlier
>>> if we can use this DTB we can work towards one binary that can boot both RPi3
>>> and RPi4. On the other hand we can rely on the FW to detect the amount of memory
>>> our RPi4 has.
>>>
>>> That said, I agree that we should make sure that U-Boot can boot with both DTBs,
>>> the upstream one and the downstream. Now the question is how to get to this. I'm
>>> a bit puzzled that by talking about "unreviewed DT" you insinuate that bcm2711
>>> compatible is already reviewed and can't be changed. From what I can see none of
>>> these compatibles got merged for now, so we are still at time to change them.
>> Stephen Boyd was okay with clk changes except of a small nit. So i fixed
>> this is as he suggested in a separate series. Unfortunately this hasn't
>> be applied yet [1].
>>
>> The i2c, pinctrl and the sdhci changes has been applied yet.
>>
>> In my opinion it isn't the job of the mainline kernel to adapt to a
>> vendor device tree. It's the vendor device tree which needs to be fixed.
>>
> I agree with that. But if we can make this easier by choosing a compatible which
> fits downstream without violating upstream and it makes sense with the naming
> scheme of the RPi, I think that's a good argument.

i spend a lot of my spare time to prepare these patch series in order to
get a clean solution.

Either mixing bcm2711/bcm2838 or changing everything to bcm2838 in the
upstream tree has the following drawbacks:

- additional review time and delay of the Raspberry Pi 4 support
- harder to understand for developer/reviewer without RPi knowledge

Btw currently u-boot only uses bcm2711, so it would be nice to keep that.

So my suggestion is to add bcm2711 compatibles in the downstream tree.

Best regards
Stefan

>
>> Sorry, but this is my holiday. I will back after the weekend.
>>
> Sure, enjoy. I'll be on travel for the next two weeks but will try to keep up
> with emails.
>
> Regards,
> Matthias
>
>> Best regards
>> Stefan
>>
>> [1] - https://www.spinics.net/lists/linux-clk/msg40534.html
>>
>>> Apart from the point Florian made, to stay consistent with the RPi SoC naming,
>>> it will save us work, both in the kernel and in U-Boot, as we would need to add
>>> both compatibles to the code-base.
>>>
>>> Regards,
>>> Matthias
>>>
>>>>>>> Regards,
>>>>>>> Matthias
>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Matthias
>>>>>>>>
>>>>>>>>> Are there any config.txt tweaks necessary?
>>>>>>>>>
>>>>>>>>>
>>>>>>>> _______________________________________________
>>>>>>>> linux-arm-kernel mailing list
>>>>>>>> linux-arm-kernel@lists.infradead.org
>>>>>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> linux-arm-kernel mailing list
>>>>>>> linux-arm-kernel@lists.infradead.org
>>>>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
