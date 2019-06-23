Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8471BC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA152054F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="a79KMVYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfFXCGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:06:40 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:16170 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfFXCGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:06:39 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190623233638epoutp03e5f1304bb1fc195da44a3db830608be1~q_Bb_JHnk2176721767epoutp03W
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 23:36:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190623233638epoutp03e5f1304bb1fc195da44a3db830608be1~q_Bb_JHnk2176721767epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561332998;
        bh=gVdC7W3ldmM3ohxP3IShUQy55UMe0oYxTPCOE/6tAp4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=a79KMVYmCPbz5nwheKxRjHWOh5KSF712suwcwku5/tdnPGdRG8Etpic6jwCY0+Y3a
         vdKcEh6t/Fy3IPtGd3BgrIekJUt2n9YdKEqqFsXsK+7eiVomW5Kv0Ymfzo78Iuw8Uy
         s0o9s9OEQ2kQ2ZmwEuanvc7PgHLhnAKd4L4og3Pk=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190623233634epcas1p4fe5ea4b0f69ce7ab48e9fb322831f662~q_BYg_Xme3169831698epcas1p4D;
        Sun, 23 Jun 2019 23:36:34 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.9E.04108.20D001D5; Mon, 24 Jun 2019 08:36:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190623233633epcas1p16ab9635c74bd01f3a7b0828eedf1f9d2~q_BXxNr2T1082210822epcas1p1f;
        Sun, 23 Jun 2019 23:36:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190623233633epsmtrp192a9eade0fcbece0e6e69272d2ecd321~q_BXtjTUt1920219202epsmtrp1c;
        Sun, 23 Jun 2019 23:36:33 +0000 (GMT)
X-AuditID: b6c32a39-8b7ff7000000100c-4a-5d100d02d9e1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.12.03692.10D001D5; Mon, 24 Jun 2019 08:36:33 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190623233633epsmtip1364fbdd2bc629b95785e2adfcd77b4c0~q_BXdmHmE3204032040epsmtip1G;
        Sun, 23 Jun 2019 23:36:33 +0000 (GMT)
Subject: Re: [PATCH v3] arm64: defconfig: Enable Panfrost and Lima drivers
To:     Krzysztof Kozlowski <krzk@kernel.org>, cwchoi00@gmail.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Olof Johansson <olof@lixom.net>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <6edbe882-314c-85e1-4109-7c3b324dc7ab@samsung.com>
Date:   Mon, 24 Jun 2019 08:39:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcFFY08R1H-DrrzX2BC3L8x4NPJTP7nDn9yixAvmaiF9Q@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TbUxbVRjHc3p7b8tG3bFs8kiisKszAVPWO9ZxMLA5ZdsN8gGmH4yR1Ru4
        FkLf7G0X50yEbSLtlonxJdIN0FhRGASonTLY6ESGssUVQRHZqpgNsoEDkUkcM8S2t4t8+z/n
        +T3nn/95UVPaalWKusLqFB1Wwcwya5RffpOu1yk0uETf0ptB3hycRuRScE5J5puPITJ94XFy
        IdSrIG1X+hEZvvUnQ2776xgSCnWqyOfhBZr4r43RZLTnJEM+DPUpSPtAWEUmbwYRufjzIkNu
        BJLJkauGJ7V8+8JvNN/W2Ib4xraDfHfYh/gz3rCK97e6Gf7q2FmG/8L3Bv/jd4dovmuuW8Ef
        D7Qi/uSdJSW/6H+4SPNCZW65KJSJjjTRWmorq7Ca8thnnjU+bTRs03M6Lodks2lWwSLmsfmF
        RbrdFeZIQDZtv2B2RZaKBEliN2/PddhcTjGt3CY581jRXma259gzJcEiuaymzFKb5QlOr99i
        iIAvVZb7GkLIXodfXa7uRFXorMaDEtSAt8L4H26VB61Ra3E3gunmESQXfyHwnJ6l5WIJQftX
        /1L3Rj5evhSnziG4OOJj5GIeQcP344oolYQLYPn9KSaq1+M86D3RqIxCFB6kofXwmDLaYHAG
        BG+Mx6B1eCP89M81FNUavB1aPvOpolqJN8FSkye26Qb8PIwGeuLM/TBUfz22TwIuht/7FmMM
        hZNh4npTXKfC4dMnqKgx4Dsq+KC+FskZ8qH66IJC1kkw821AJesUuPl2TVwfhJahAUYerkUQ
        CA7TciMLgp++GxlWRxzSoaNns7y8Ec7cbUCy8X0w9/cxOooA1kBtjVZGHoHRyXDc9kH45C03
        U4dY76o43lURvKsieP83+wgpW9EDol2ymESJsxtW37cfxZ5/Rk43Grxc2I+wGrGJGty5rkRL
        C/ulA5Z+BGqKXa9JNCeWaDVlwoHXRIfN6HCZRakfGSKn/Q6VsqHUFvlMVqeRM2zJysoiW7lt
        Bo5jkzXGtb+8qMUmwSlWiqJddNybU6gTUqpQrnsomLqjq/7ro9N7dAXS5K1z54+YX96Vfmp0
        5+DePZP8SFfSTElOqklZUDz8Q3Yfcewr3l115W6+53Ldpp0Dex+1HXdXFSa80gtrm1+fWJk4
        RS3tqk3NdjVRs3O07teVYE3hQ8Nsl9QxFZ6lZh7LPH8bdwzsmD9k27fy1HNTzve0rFIqF7gM
        yiEJ/wHiKQPWFAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRiA+3bOzo7D4de09qmhtajQyLISvx8pkVaHMrILUYLYyINa21w7
        almQlhZ4QUZR1rSptXLKBrYsLEVxNjWFllka5iqvqKl5S8oScluB/x7e93l4/7w0If5G+tBJ
        yhRWrZTJpZSQfN4k9dsCRDB225hhO77ePAxwe8Mkib8/zgd42LoZW221PGz8ZAH47cQUhefM
        GgrbbFUCbLBP87F5oIuPO18WU/iurZ6HTa/sAvx1tAHgtu5ZCo9US3B2b8huMWOa/sJnjDoj
        YHTGy0yNXQ+YF1q7gDFX5lBMb1cdxTzVZzDvW6/xmSeTNTymoLoSMMW/5klm1uwXLYoR7opn
        5UlprHpr+Glhov6+Dag08OLC1SqQCepEucCNRnAnKltoB7lASIthLUDdDxsJ18Ib3emwLjG9
        xJ6oqYlzORMAGUp+kw7HEx5AC7eHKAd7wTBUW6QjHRIB2/joVv4o31U08tAjw5zTomAgahj5
        6GQPuA59+DkAHCyC4aiiXC9wMAk3oPmSXJ6DV8GTqOBGEeVyVqLX9wadl93gEdRXP+t0CLgJ
        /dG9I1wsQT2DJf/m/ijrWRGhAZ7aZbl2WaJdlmiXJaWArATerIpTJCi4YFWwkr0QxMkUXKoy
        IehMssIMnC8QGFADOvVxFgBpIHUXwSqPWDFflsalKywA0YTUS+Qud48Vi+Jl6ZdYdXKcOlXO
        chbgS5NSiWhI2XxKDBNkKew5llWx6v9bHu3mkwmM0rIx94iOEwcbVudFxB9uLRULKvyz+7P8
        80x7i49Hro2Ybpf0makoqiN6pu7KvjeqkLXjkVzhoYD9R8+P14RK1vRkLg57caRYgAsXo2YG
        IltI8+fsmJtEVFHYnpH6dF9NeYvQOrk+9IfEdKz/waQ9Y8eU/GzOvKRyY1j/CkGmlOQSZcGB
        hJqT/QXGKxu3/gIAAA==
X-CMS-MailID: 20190623233633epcas1p16ab9635c74bd01f3a7b0828eedf1f9d2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190623192007epcas4p2a3995bb00091b436562828fceb6ff790
References: <20190621180208.25361-7-krzk@kernel.org>
        <20190622191838.29850-1-krzk@kernel.org>
        <CAGTfZH2g6E2pCEtqjfCd+PjEzjwc2AB75LXJfCeO+PcYLiLTUw@mail.gmail.com>
        <CGME20190623192007epcas4p2a3995bb00091b436562828fceb6ff790@epcas4p2.samsung.com>
        <CAJKOXPcFFY08R1H-DrrzX2BC3L8x4NPJTP7nDn9yixAvmaiF9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 6. 24. 오전 4:16, Krzysztof Kozlowski wrote:
> On Sun, 23 Jun 2019 at 06:31, Chanwoo Choi <cwchoi00@gmail.com> wrote:
>>
>> Hi Krzysztof,
>>
>> 2019년 6월 23일 (일) 오전 4:20, Krzysztof Kozlowski <krzk@kernel.org>님이 작성:
>>>
>>> Enable support for Mali GPU with Panfrost and Lima drivers for:
>>> 1. Samsung Exynos5433 and Exynos7 (having Mali T760),
>>> 2. Allwiner A64 and H5 (Mali 400/450).
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>>
>>> ---
>>>
>>> Changes since v1:
>>> 1. Enable Lima driver
>>> ---
>>>  arch/arm64/configs/defconfig | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>> index fbbc065415d4..3d31611368af 100644
>>> --- a/arch/arm64/configs/defconfig
>>> +++ b/arch/arm64/configs/defconfig
>>> @@ -518,6 +518,8 @@ CONFIG_DRM_HISI_HIBMC=m
>>>  CONFIG_DRM_HISI_KIRIN=m
>>>  CONFIG_DRM_MESON=m
>>>  CONFIG_DRM_PL111=m
>>> +CONFIG_DRM_LIMA=m
>>> +CONFIG_DRM_PANFROST=m
>>>  CONFIG_FB=y
>>>  CONFIG_FB_MODE_HELPERS=y
>>>  CONFIG_BACKLIGHT_GENERIC=m
>>> @@ -718,7 +720,6 @@ CONFIG_ARCH_TEGRA_194_SOC=y
>>>  CONFIG_ARCH_K3_AM6_SOC=y
>>>  CONFIG_SOC_TI=y
>>>  CONFIG_TI_SCI_PM_DOMAINS=y
>>> -CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
>>
>> Exynos5433-tm2 board support the exynos-bus device which
>> used the simple_ondmenad governor of devfreq.
>> Why do you remove this configuration from the defconfig?
> 
> It is selected by default by DRM_PANFROST. The difference is that
> PANFROST selects it as module. The 'y' is chosen because of:
>   SCSI_UFSHCD [=y] && SCSI_LOWLEVEL [=y] && SCSI [=y] && SCSI_DMA [=y]

When I tried to find the history of CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND 
for defconfig, the following patch[1] added this configuration.
[1] b972ff75f2938c39e2205c23ea0e531d36b27f86
- "arm64: defconfig: Enable UFS on msm8996"

I think that this patch will affect the opration of 'USF on msm8998'.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
