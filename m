Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568C1C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F8A20674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vNCRzsif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbfFXPt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:49:56 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57927 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfFXPt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:49:56 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190624154953euoutp01c3a80533c6e747efe0506325f102df43~rLTM931N-1999519995euoutp01v
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 15:49:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190624154953euoutp01c3a80533c6e747efe0506325f102df43~rLTM931N-1999519995euoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561391393;
        bh=HorVpcJ3wRcGowxW+uhZShsnFi7Zo7uF0JvdeCNFwKI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=vNCRzsifSosG0nTKTPgrhWm8EXbW+KvcJh32M0Vx0S6xK+nohua+rHbNR4aQ6FPdO
         gF7h6mR6g9Bh+mapk8+nme0OIUZZ3YwtU8jX0GAumOOyymhWGLE/mZPlBDVNO930Pz
         kzQPk1b80OZlqPbxAKp7JMBlXVauP8eaxyvcRJCI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190624154952eucas1p25efcc84f1a486311863e4536eaf35a7c~rLTMC7YZz0417304173eucas1p2G;
        Mon, 24 Jun 2019 15:49:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B7.7F.04298.021F01D5; Mon, 24
        Jun 2019 16:49:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190624154952eucas1p28845763ad33d6c964169c257cfbeff3b~rLTLUOHsJ2657526575eucas1p2d;
        Mon, 24 Jun 2019 15:49:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190624154952eusmtrp1a3dbb974ea0ec250a82fe9bf893166b1~rLTLTnzD51668516685eusmtrp1I;
        Mon, 24 Jun 2019 15:49:52 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-6a-5d10f120d3d7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 77.D5.04140.021F01D5; Mon, 24
        Jun 2019 16:49:52 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190624154951eusmtip1a6ffc41fbe83da95dfa119fdf481022d~rLTKxuLsE2387023870eusmtip1u;
        Mon, 24 Jun 2019 15:49:51 +0000 (GMT)
Subject: Re: [PATCH 4/4] drm/sun4i: Enable DRM InfoFrame support on H6
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@siol.net>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "zhengyang@rock-chips.com" <zhengyang@rock-chips.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "wens@csie.org" <wens@csie.org>,
        "hjc@rock-chips.com" <hjc@rock-chips.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <3f9e51d5-8ca5-a439-943c-26de92dd52fe@samsung.com>
Date:   Mon, 24 Jun 2019 17:49:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6819050.kFKQ8T6p8H@jernej-laptop>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7djPc7oKHwViDQ7uV7O48vU9m8X/R69Z
        LeZOqrW4+v0ls8XJN1dZLH62b2Gy6Jy4hN3i8q45bBYPXu5ntDjUF23x89B5Jov1LfoOPB7v
        b7Sye8xbU+2x4dFqVo/ZHTNZPU5MuMTkcb/7OJPH31n7WTwO9E5m8dh+bR6zx+dNcgFcUVw2
        Kak5mWWpRfp2CVwZCx9eYSlYJVrxa5p2A+NOwS5GTg4JAROJg+8+s4HYQgIrGCXm307sYuQC
        sr8wSrzZ9ZYJwvnMKHH+7z8mmI57R7YwQySWM0osudnMAuG8ZZS4sqmbHaRKWMBNYuOqpWC2
        iICtxPdJc8CKmAWOskic2biXFSTBJqAp8XfzTbDlvAJ2Ek9Xv2IBsVkEVCX+7WtnBLFFBSIk
        vuzcxAhRIyhxcuYTsBpOAX2JH+dnMoPYzALyEs1bZ0PZ4hK3nswHu1tC4Cu7xOsJT1kg7naR
        mLZrIZQtLPHq+BZ2CFtG4vTkHqh4vcT9FS3MEM0djBJbN+xkhkhYSxw+fhHoag6gDZoS63fp
        Q4QdJVr+n2QCCUsI8EnceCsIcQOfxKRt05khwrwSHW1CENWKEvfPboUaKC6x9MJXtgmMSrOQ
        fDYLyTezkHwzC2HvAkaWVYziqaXFuempxYZ5qeV6xYm5xaV56XrJ+bmbGIHp7fS/4592MH69
        lHSIUYCDUYmHd8ERgVgh1sSy4srcQ4wSHMxKIrxLE4FCvCmJlVWpRfnxRaU5qcWHGKU5WJTE
        easZHkQLCaQnlqRmp6YWpBbBZJk4OKUaGNevfuVaOKHvzMumuWZ1cyxa9l4OsP4g9Dggh0v0
        92ensIMhBf6PnNnWfDupwDRbbYW0j5zD6sRI/c82HO2rt+peD5k0//r/ew+LhGqZF+5ZG/FN
        lmeL8UV7wy0LmI5GtraqzS5ya65tCldLu7NDbOVGv4tRxjO+vGzX90u5UpeymCvtgFCvsRJL
        cUaioRZzUXEiAKcrr8BrAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsVy+t/xu7oKHwViDba3s1hc+fqezeL/o9es
        FnMn1Vpc/f6S2eLkm6ssFj/btzBZdE5cwm5xedccNosHL/czWhzqi7b4eeg8k8X6Fn0HHo/3
        N1rZPeatqfbY8Gg1q8fsjpmsHicmXGLyuN99nMnj76z9LB4HeiezeGy/No/Z4/MmuQCuKD2b
        ovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MhQ+vsBSs
        Eq34NU27gXGnYBcjJ4eEgInEvSNbmLsYuTiEBJYySuyYu5MJIiEusXv+W2YIW1jiz7UuNoii
        14wSe9oOsoIkhAXcJDauWsoOYosI2Ep8nzSHBaSIWeA4i8SdE2+gxt5lkmjav54NpIpNQFPi
        7+abYDavgJ3E09WvWEBsFgFViX/72hlBbFGBCInZuxpYIGoEJU7OfAJmcwroS/w4PxPsJGYB
        dYk/8y5B2fISzVtnQ9niEreezGeawCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGRXnFi
        bnFpXrpecn7uJkZgTG879nPLDsaud8GHGAU4GJV4eBccEYgVYk0sK67MPcQowcGsJMK7NBEo
        xJuSWFmVWpQfX1Sak1p8iNEU6LmJzFKiyfnAdJNXEm9oamhuYWlobmxubGahJM7bIXAwRkgg
        PbEkNTs1tSC1CKaPiYNTqoGxc8bdjfEl+Vfnp/EaXZMyfjVPSqzceoVLVp6E/9ZHnXuNHln+
        EdGuvlHiHu83u9/cz2rOgdfhm87dOybyZrLW/rQ/KYaHawT21rm9V5fX+BhzqIidv6XOyJav
        eNPey9NvJN15fmfZhlTto5eusuUKJp7e89daKdfAKmvWJOaQze7Mx1baqP5VYinOSDTUYi4q
        TgQAE1zP+v8CAAA=
X-CMS-MailID: 20190624154952eucas1p28845763ad33d6c964169c257cfbeff3b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190624150546epcas1p1da19043e13dd3604a546f7983fc089b9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190624150546epcas1p1da19043e13dd3604a546f7983fc089b9
References: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
        <VI1PR03MB4206740285A775280063E303AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
        <baf95e6b-bfcf-27e7-1a00-ca877ae6f82d@samsung.com>
        <CGME20190624150546epcas1p1da19043e13dd3604a546f7983fc089b9@epcas1p1.samsung.com>
        <6819050.kFKQ8T6p8H@jernej-laptop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.06.2019 17:05, Jernej Škrabec wrote:
> Dne ponedeljek, 24. junij 2019 ob 17:03:31 CEST je Andrzej Hajda napisal(a):
>> On 26.05.2019 23:20, Jonas Karlman wrote:
>>> This patch enables Dynamic Range and Mastering InfoFrame on H6.
>>>
>>> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
>>> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>
>>>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 2 ++
>>>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h | 1 +
>>>  2 files changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
>>> b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c index 39d8509d96a0..b80164dd8ad8
>>> 100644
>>> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
>>> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
>>> @@ -189,6 +189,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev,
>>> struct device *master,> 
>>>  	sun8i_hdmi_phy_init(hdmi->phy);
>>>  	
>>>  	plat_data->mode_valid = hdmi->quirks->mode_valid;
>>>
>>> +	plat_data->drm_infoframe = hdmi->quirks->drm_infoframe;
>>>
>>>  	sun8i_hdmi_phy_set_ops(hdmi->phy, plat_data);
>>>  	
>>>  	platform_set_drvdata(pdev, hdmi);
>>>
>>> @@ -255,6 +256,7 @@ static const struct sun8i_dw_hdmi_quirks
>>> sun8i_a83t_quirks = {> 
>>>  static const struct sun8i_dw_hdmi_quirks sun50i_h6_quirks = {
>>>  
>>>  	.mode_valid = sun8i_dw_hdmi_mode_valid_h6,
>>>
>>> +	.drm_infoframe = true,
>>>
>>>  };
>>>  
>>>  static const struct of_device_id sun8i_dw_hdmi_dt_ids[] = {
>>>
>>> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
>>> b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h index 720c5aa8adc1..2a0ec08ee236
>>> 100644
>>> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
>>> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
>>> @@ -178,6 +178,7 @@ struct sun8i_dw_hdmi_quirks {
>>>
>>>  	enum drm_mode_status (*mode_valid)(struct drm_connector 
> *connector,
>>>  	
>>>  					   const struct 
> drm_display_mode *mode);
>>>  	
>>>  	unsigned int set_rate : 1;
>>>
>>> +	unsigned int drm_infoframe : 1;
>> Again, drm_infoframe suggests it contains inforframe, but in fact it
>> just informs infoframe can be used, so again my suggestion
>> use_drm_infoframe.
>>
>> Moreover bool type seems more appropriate here.
> checkpatch will give warning if bool is used.


Then I would say "fix/ignore checkpatch" :)

But maybe there is a reason.

Anyway I've tested and I do not see the warning, could you elaborate it.


Regards

Andrzej



>
> Best regards,
> Jernej
>
>> Beside this:
>>
>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
>>
>>  --
>> Regards
>> Andrzej
>>
>>>  };
>>>  
>>>  struct sun8i_dw_hdmi {
>
>
>
>
>

