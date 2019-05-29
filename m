Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490F5C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 05:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071F4208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 05:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QfJALDn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfE2FfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 01:35:19 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:11635 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfE2FfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 01:35:18 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190529053517epoutp047a566939eef4b4cfc325c964f8d3c47f~jEJJrQpZD1955619556epoutp04R
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 05:35:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190529053517epoutp047a566939eef4b4cfc325c964f8d3c47f~jEJJrQpZD1955619556epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559108117;
        bh=2s6Oe+gsFNiN+ImRl7C8UouIiq0O4ZmyklQfAC8Zd6g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QfJALDn9TYmO2djODMyMNT2el3ZPvfdAAcr0/nWHUk8Jh1g2R+zaiaHmtGfdnLmvP
         9ycpprbtTLmfIQG/kFkcUW1BX5zmc811LtKiZxZ85nWyB1xSYfFcGZS9lC5iUI9VMx
         eYvftoExLyhaTQXS5u2Kd3kT1L+ff4VtJ86Tp6Bw=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190529053514epcas1p34e3dea5f8d76c3dfa1e359ab7bff523d~jEJHLWum10672706727epcas1p3P;
        Wed, 29 May 2019 05:35:14 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.6E.04142.E0A1EEC5; Wed, 29 May 2019 14:35:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190529053509epcas1p2fbd4b2bef8879e722fdbbeb46ff4b179~jEJDDNRx41192811928epcas1p2P;
        Wed, 29 May 2019 05:35:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190529053509epsmtrp146e7c904b91c4281ac059ce604c7fc5e~jEJDCfSBl3032030320epsmtrp1W;
        Wed, 29 May 2019 05:35:09 +0000 (GMT)
X-AuditID: b6c32a36-cf9ff7000000102e-42-5cee1a0e00c6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.BC.03692.D0A1EEC5; Wed, 29 May 2019 14:35:09 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190529053509epsmtip1bf2e104ab0980517cbfc096b5f5a15b3~jEJC52aHh2112821128epsmtip1Q;
        Wed, 29 May 2019 05:35:09 +0000 (GMT)
Subject: Re: [PATCH] extcon: arizona: Correct error handling on
 regmap_update_bits_check
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     myungjoo.ham@samsung.com, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <92a28c6f-9c58-d762-f635-f5a93e602843@samsung.com>
Date:   Wed, 29 May 2019 14:37:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528165020.10320-1-ckeepax@opensource.cirrus.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTURjHObvb9c5anqbW48CyG5UKU69rtqSFppWklFBQmLEuepni3tjd
        ovSLkeVLpfYC5XJkhWFWZLZMRRktqSyzohdKs4IislIpUYSy2vUu8tvveTv/53/OoQjlYVJF
        FVocnN3CmmgyWNp2J0atnqcazU3wTa/QPT/YinTPOutJ3eD+JlI3PuaVpUgzTtX/QRnVnmaU
        Md66KJvIKVpTwLH5nD2Ks+RZ8wstRj2dudWQZtAmJTBqZrVuFR1lYc2cnk7PylZvKDT51eio
        PazJ6U9lszxPx69dY7c6HVxUgZV36GnOlm+yrbbF8ayZd1qMcXlWczKTkJCo9TfuLiq4PPJY
        ZusP3Ts9OoxK0URIFZJTgFfCy4kRVIWCKSVuR/Cyr4UUgx8IHg31BInBJILq42VB/0YqL7YF
        Ct0IXJMeUigo8RiC2q9bBA7FOdB99srMQBhOhO/3BiQCE3gnNIxfnOkncSx4P7+a4RC8BF5M
        ffDvQVEKvBaO9mYJaSleBtc7fYTA4XgHvLvbIhNYgedDb91HqcBynAYn33QS4vELYeDj2YDU
        Yjhw8wwh7Am4j4SHrl4kGkiHjqtTATOh8OWeJ8AqGK45FOASuNTbQ4rDFQg83icysaABb+MJ
        ibAogWPgWme8mF4CHT/dSBSeB6MTR2RCC2AFVBxSii1L4dn7IYnIEXChvJKsRbRrlh3XLAuu
        WRZc/8UakLQZLeBsvNnI8YwtcfZjt6KZjxib1I7O92f5EKYQPVexO2IkVylj9/D7zD4EFEGH
        KfQnv+UqFfnsvmLObjXYnSaO9yGt/7aPEarwPKv/W1scBkabqNFodCuZJC3D0AsVhjmvc5XY
        yDq4Io6zcfZ/cxJKripF0Z8a0YP1+5tKBxXbUNyNyMOa6I4Wt3P69lRNZMz2vuRzm7A7ODXb
        Ubf5rXGBtwtSWivPR7ie6uPKr5W8jZy0br6lLtsmp4qHvp0eLGvqKX+6rqokSJka07Bc9erL
        rojxVKIytXhMklwx8nusrMmjTRtIn5Rv3G7r+tXDuDPvX6elfAHLxBJ2nv0LmOjWHZ4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSnC6v1LsYg3/TTS2utG5itLi8aw6b
        xe3GFWwWn9/vZ3Vg8Zg+5z+jR9+WVYwenzfJBTBHcdmkpOZklqUW6dslcGWsfnueteCccMXf
        dy8ZGxi/8ncxcnJICJhIdC7bxt7FyMUhJLCbUeJn12J2iISkxLSLR5m7GDmAbGGJw4eLIWre
        Mkps2PyLCaRGWCBKYu/8NWD1IgJGEh+P3wKLMwtES1zq/8oC0TCNUaJz9mtmkASbgJbE/hc3
        2EBsfgFFias/HjOCLOAVsJPoPekDEmYRUJXYuOsQWLmoQITEmfcrWEBsXgFBiZMzn4DZnALO
        ElPu7GKG2KUu8WfeJShbXOLWk/lQN8hLNG+dzTyBUXgWkvZZSFpmIWmZhaRlASPLKkbJ1ILi
        3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4NjQ0tzBeHlJ/CFGAQ5GJR7eBMm3MUKsiWXFlbmH
        GCU4mJVEeG2nvIkR4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvs071ikkEB6YklqdmpqQWoRTJaJ
        g1OqgTHz+on09lxZ/p/8xw6q62481qs8I9Oi0VZu2f3O+w2CO0NWLL4ldDnifXKv/4nQux6P
        dl7dyn2N7/HRrop+7xirgKTO242r94b92j/rlGuQi4KLYomvbrsJQ+aF5EMHpirazp3JEuf+
        pHObW3V0osBcj5mGswvyNxbvmuwye88LA4nVU+3FpiqxFGckGmoxFxUnAgD1WmSsiQIAAA==
X-CMS-MailID: 20190529053509epcas1p2fbd4b2bef8879e722fdbbeb46ff4b179
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190528165025epcas5p41d2a0c9b244532709135ab96da73e27c
References: <CGME20190528165025epcas5p41d2a0c9b244532709135ab96da73e27c@epcas5p4.samsung.com>
        <20190528165020.10320-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 5. 29. 오전 1:50, Charles Keepax wrote:
> Ensure the case when regmap_update_bits_check fails and the change
> variable is not updated is handled correctly.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/extcon/extcon-arizona.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
> index 9327479c719c2..ba2d16de161f8 100644
> --- a/drivers/extcon/extcon-arizona.c
> +++ b/drivers/extcon/extcon-arizona.c
> @@ -335,10 +335,12 @@ static void arizona_start_mic(struct arizona_extcon_info *info)
>  
>  	arizona_extcon_pulse_micbias(info);
>  
> -	regmap_update_bits_check(arizona->regmap, ARIZONA_MIC_DETECT_1,
> -				 ARIZONA_MICD_ENA, ARIZONA_MICD_ENA,
> -				 &change);
> -	if (!change) {
> +	ret = regmap_update_bits_check(arizona->regmap, ARIZONA_MIC_DETECT_1,
> +				       ARIZONA_MICD_ENA, ARIZONA_MICD_ENA,
> +				       &change);
> +	if (ret < 0) {
> +		dev_err(arizona->dev, "Failed to enable micd: %d\n", ret);
> +	} else if (!change) {
>  		regulator_disable(info->micvdd);
>  		pm_runtime_put_autosuspend(info->dev);
>  	}
> @@ -350,12 +352,14 @@ static void arizona_stop_mic(struct arizona_extcon_info *info)
>  	const char *widget = arizona_extcon_get_micbias(info);
>  	struct snd_soc_dapm_context *dapm = arizona->dapm;
>  	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
> -	bool change;
> +	bool change = false;
>  	int ret;
>  
> -	regmap_update_bits_check(arizona->regmap, ARIZONA_MIC_DETECT_1,
> -				 ARIZONA_MICD_ENA, 0,
> -				 &change);
> +	ret = regmap_update_bits_check(arizona->regmap, ARIZONA_MIC_DETECT_1,
> +				       ARIZONA_MICD_ENA, 0,
> +				       &change);
> +	if (ret < 0)
> +		dev_err(arizona->dev, "Failed to disable micd: %d\n", ret);
>  
>  	ret = snd_soc_component_disable_pin(component, widget);
>  	if (ret != 0)
> @@ -1726,7 +1730,7 @@ static int arizona_extcon_remove(struct platform_device *pdev)
>  	struct arizona_extcon_info *info = platform_get_drvdata(pdev);
>  	struct arizona *arizona = info->arizona;
>  	int jack_irq_rise, jack_irq_fall;
> -	bool change;
> +	bool change = false;
>  
>  	regmap_update_bits_check(arizona->regmap, ARIZONA_MIC_DETECT_1,
>  				 ARIZONA_MICD_ENA, 0,

You better to check the return value as the part of this patch.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
