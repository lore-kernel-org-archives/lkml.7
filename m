Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D4CC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4952054F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iOat0pfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbfFXQ7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 12:59:24 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35385 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfFXQ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:59:24 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190624165922euoutp0283aa14f6d68c5a1f10b665ddc66e3707~rMP26SbGQ0747807478euoutp02T
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 16:59:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190624165922euoutp0283aa14f6d68c5a1f10b665ddc66e3707~rMP26SbGQ0747807478euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561395562;
        bh=kKbJkzdhBU9lOffCTViCp1aEU1TW8YWN8Y4kXn1ZRL4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=iOat0pfRkwf6Iy+PoI4VeMCgYRdivwnlPVPrrmVdoPHVUvsflpZs2NTUTY4kbDDOC
         72Tz2lSy/foDm1UUNoxvUeoYAXP5WTsHhu9x0jGy80seHJCVgHEZ4KBcZbXXr9s/2K
         7WfO1tnxEN82zZbqvvwaAQCmH/Zmeui4Xr01IEZw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190624165921eucas1p16a47a6a7040ca2ea49be7dddc544b695~rMP2OhDNb0345903459eucas1p1q;
        Mon, 24 Jun 2019 16:59:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 93.31.04325.961011D5; Mon, 24
        Jun 2019 17:59:21 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190624165920eucas1p2ba62121bbb0242e38194d906a1511b61~rMP1IaHAP1830118301eucas1p2w;
        Mon, 24 Jun 2019 16:59:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190624165919eusmtrp12e8a2919976610699a44a22fd2971452~rMP06VFsl2683826838eusmtrp1T;
        Mon, 24 Jun 2019 16:59:19 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-87-5d110169b299
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E9.4A.04140.761011D5; Mon, 24
        Jun 2019 17:59:19 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190624165919eusmtip1d5fa48fb01e17b2fd3abf44e76e35174~rMP0RXp0k3028730287eusmtip1h;
        Mon, 24 Jun 2019 16:59:19 +0000 (GMT)
Subject: Re: [PATCH 4/4] drm/sun4i: Enable DRM InfoFrame support on H6
To:     Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@siol.net>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "zhengyang@rock-chips.com" <zhengyang@rock-chips.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "hjc@rock-chips.com" <hjc@rock-chips.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <025bb8b2-8e0d-65ba-a7cc-4d8078f90428@samsung.com>
Date:   Mon, 24 Jun 2019 18:59:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAGb2v67T-nOqxkjekcc1ze9otVrzJb5KEtdJuMMk+dEGgAn1pQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsWy7djPc7qZjIKxBo+/s1tc+fqezeL/o9es
        FnMn1Vpc/f6S2eLkm6ssFj/btzBZdE5cwm5xedccNosHL/czWhzqi7b4eeg8k8X6Fn0HHo/3
        N1rZPeatqfbY8Gg1q8fsjpmsHicmXGLyuN99nMnj76z9LB4HeiezeGy/No/Z4/MmuQCuKC6b
        lNSczLLUIn27BK6M3R9eMRUcU6x4fVGjgfGGdBcjJ4eEgInEvmONTF2MXBxCAisYJS7uv8QG
        4XxhlPix8y4LhPOZUeLc9W1AZRxgLQuvJ0DElzNK/L/zEaroLaPEtgc72EDmCgu4SWxctZS9
        i5GdQ0QgVuJOLkgJs8ASFomuxl5WkBI2AU2Jv5tvgpXzCthJrFuwAsxmEVCVOLVlNguILSoQ
        IfFl5yZGiBpBiZMzn4DFOQUCJWbPWQxWzywgL9G8dTYzhC0ucevJfLB3JAT+sks0vpnPAvGn
        i8Scnm9sELawxKvjW9ghbBmJ05N7oGrqJe6vaGGGaO5glNi6YSczRMJa4vDxi6wg3zMDXb1+
        lz5E2FFixyFQCIEChU/ixltBiBv4JCZtm84MEeaV6GgTgqhWlLh/divUQHGJpRe+sk1gVJqF
        5LNZSL6ZheSbWQh7FzCyrGIUTy0tzk1PLTbOSy3XK07MLS7NS9dLzs/dxAhMbaf/Hf+6g3Hf
        n6RDjAIcjEo8vAuOCMQKsSaWFVfmHmKU4GBWEuFdmggU4k1JrKxKLcqPLyrNSS0+xCjNwaIk
        zlvN8CBaSCA9sSQ1OzW1ILUIJsvEwSnVwJhuZxt15vqFD2ejHT/22E+Zcfl4aUX4lxtcHapO
        70st9k88sy4p5PNu6zCfZSF/LJad2hfEv2Dn+dXBLWlSXlbSSSvFn92tZAsxr/uUol4e/Wj7
        zEvCTd1ZN043/d24ttdS+VnT7J36rcfu6k92yyld3sSj5Nm/p4RVUyftgI5Usvrmd10/9yqx
        FGckGmoxFxUnAgCXz8+raQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsVy+t/xu7rpjIKxBnN3Wlhc+fqezeL/o9es
        FnMn1Vpc/f6S2eLkm6ssFj/btzBZdE5cwm5xedccNosHL/czWhzqi7b4eeg8k8X6Fn0HHo/3
        N1rZPeatqfbY8Gg1q8fsjpmsHicmXGLyuN99nMnj76z9LB4HeiezeGy/No/Z4/MmuQCuKD2b
        ovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M3R9eMRUc
        U6x4fVGjgfGGdBcjB4eEgInEwusJXYxcHEICSxkllu46z9TFyAkUF5fYPf8tM4QtLPHnWhcb
        RNFrRol/01+CFQkLuElsXLWUHcQWEYiVOPlmLitIEbPAMhaJJ6dXMkJ0zGSWWLD9ICNIFZuA
        psTfzTfZQGxeATuJdQtWgNksAqoSp7bMZgGxRQUiJGbvamCBqBGUODnzCZjNKRAoMXvOYrB6
        ZgF1iT/zLjFD2PISzVtnQ9niEreezGeawCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGR
        XnFibnFpXrpecn7uJkZgRG879nPLDsaud8GHGAU4GJV4eBccEYgVYk0sK67MPcQowcGsJMK7
        NBEoxJuSWFmVWpQfX1Sak1p8iNEU6LmJzFKiyfnAZJNXEm9oamhuYWlobmxubGahJM7bIXAw
        RkggPbEkNTs1tSC1CKaPiYNTqoFxe535fFGpjVNPz2C8Gy7++tzPC5KlLGcD+A7r/bMSKni3
        uF/o7Gxe+3WvP99+vK5Ubd3T8CPfG6b81pt0V3T7y8+H5pkdt15xpS1+jdI+3pQrc8VW7TVe
        tGmz1xT356oZC1adbP/ys+842/bUF0sPszxSZoy4X/NW0vJQXPvlrilH1qqrTtlkHqjEUpyR
        aKjFXFScCAB4lZGZ/gIAAA==
X-CMS-MailID: 20190624165920eucas1p2ba62121bbb0242e38194d906a1511b61
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190624160742epcas3p291e57fd4a47043c67cb4fbe1ed301e2f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190624160742epcas3p291e57fd4a47043c67cb4fbe1ed301e2f
References: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
        <3f9e51d5-8ca5-a439-943c-26de92dd52fe@samsung.com>
        <CAGb2v67FF3k9wZu7K+Z5yKFFeh8A_4iuEXfh+tO65UvVRfY-sA@mail.gmail.com>
        <44611965.cJa5QBey4U@jernej-laptop>
        <CGME20190624160742epcas3p291e57fd4a47043c67cb4fbe1ed301e2f@epcas3p2.samsung.com>
        <CAGb2v67T-nOqxkjekcc1ze9otVrzJb5KEtdJuMMk+dEGgAn1pQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.06.2019 18:07, Chen-Yu Tsai wrote:
> On Tue, Jun 25, 2019 at 12:03 AM Jernej Škrabec <jernej.skrabec@siol.net> wrote:
>> Dne ponedeljek, 24. junij 2019 ob 17:56:30 CEST je Chen-Yu Tsai napisal(a):
>>> On Mon, Jun 24, 2019 at 11:49 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>>>> On 24.06.2019 17:05, Jernej Škrabec wrote:
>>>>> Dne ponedeljek, 24. junij 2019 ob 17:03:31 CEST je Andrzej Hajda
>> napisal(a):
>>>>>> On 26.05.2019 23:20, Jonas Karlman wrote:
>>>>>>> This patch enables Dynamic Range and Mastering InfoFrame on H6.
>>>>>>>
>>>>>>> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
>>>>>>> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
>>>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>>>>> ---
>>>>>>>
>>>>>>>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 2 ++
>>>>>>>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h | 1 +
>>>>>>>  2 files changed, 3 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
>>>>>>> b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c index
>>>>>>> 39d8509d96a0..b80164dd8ad8
>>>>>>> 100644
>>>>>>> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
>>>>>>> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
>>>>>>> @@ -189,6 +189,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev,
>>>>>>> struct device *master,>
>>>>>>>
>>>>>>>     sun8i_hdmi_phy_init(hdmi->phy);
>>>>>>>
>>>>>>>     plat_data->mode_valid = hdmi->quirks->mode_valid;
>>>>>>>
>>>>>>> +   plat_data->drm_infoframe = hdmi->quirks->drm_infoframe;
>>>>>>>
>>>>>>>     sun8i_hdmi_phy_set_ops(hdmi->phy, plat_data);
>>>>>>>
>>>>>>>     platform_set_drvdata(pdev, hdmi);
>>>>>>>
>>>>>>> @@ -255,6 +256,7 @@ static const struct sun8i_dw_hdmi_quirks
>>>>>>> sun8i_a83t_quirks = {>
>>>>>>>
>>>>>>>  static const struct sun8i_dw_hdmi_quirks sun50i_h6_quirks = {
>>>>>>>
>>>>>>>     .mode_valid = sun8i_dw_hdmi_mode_valid_h6,
>>>>>>>
>>>>>>> +   .drm_infoframe = true,
>>>>>>>
>>>>>>>  };
>>>>>>>
>>>>>>>  static const struct of_device_id sun8i_dw_hdmi_dt_ids[] = {
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
>>>>>>> b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h index
>>>>>>> 720c5aa8adc1..2a0ec08ee236
>>>>>>> 100644
>>>>>>> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
>>>>>>> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
>>>>>>> @@ -178,6 +178,7 @@ struct sun8i_dw_hdmi_quirks {
>>>>>>>
>>>>>>>     enum drm_mode_status (*mode_valid)(struct drm_connector
>>>>> *connector,
>>>>>
>>>>>>>                                        const struct
>>>>> drm_display_mode *mode);
>>>>>
>>>>>>>     unsigned int set_rate : 1;
>>>>>>>
>>>>>>> +   unsigned int drm_infoframe : 1;
>>>>>> Again, drm_infoframe suggests it contains inforframe, but in fact it
>>>>>> just informs infoframe can be used, so again my suggestion
>>>>>> use_drm_infoframe.
>>>>>>
>>>>>> Moreover bool type seems more appropriate here.
>>>>> checkpatch will give warning if bool is used.
>>>> Then I would say "fix/ignore checkpatch" :)
>>>>
>>>> But maybe there is a reason.
>>> Here's an old one from Linus: https://lkml.org/lkml/2013/9/1/154
>>>
>>> I'd say that bool in a struct is a waste of space compared to a 1 bit
>>> bitfield, especially when there already are other bitfields in the same
>>> struct.
>>>> Anyway I've tested and I do not see the warning, could you elaborate it.
>>> Maybe checkpatch.pl --strict?
>> It seems they removed that check:
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?
>> id=7967656ffbfa493f5546c0f1
>>
>> After reading that block of text, I'm not sure what would be prefered way for
>> this case.
> This:
>
> +If a structure has many true/false values, consider consolidating them into a
> +bitfield with 1 bit members, or using an appropriate fixed width type, such as
> +u8.
>
> would suggest using a bitfield, or flags within a fixed width type?


OK, I have also guessed what kind of warning Jernej was writing about.
And IMO it rather does not fit here:

- no concurrent writes,

- no need for size/cache optimizations.

But since there are some controversies about bool in struct and file has
already convention of bitfield I do not insist on it, you can keep it as is.


Regards

Andrzej



>
> ChenYu
>
>

