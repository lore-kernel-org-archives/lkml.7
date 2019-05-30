Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF316C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DA4243C7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SWUmxFsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfE3BDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 21:03:52 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:40298 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE3BDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 21:03:51 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190530010349epoutp03f667d6e7da35a3ecafdfca1039f47104~jUFam3U8N1181611816epoutp035
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 01:03:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190530010349epoutp03f667d6e7da35a3ecafdfca1039f47104~jUFam3U8N1181611816epoutp035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559178229;
        bh=WU7NjXvms7IJ51rdPPyc3YgEvtiF8en+bDubhF/CN+w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SWUmxFsFNjBxp7P19xFuOxP0Ct71gdErtAYDuDGARkmsSoaGTFEHV2HSPch6PHdyZ
         aFM/vwu4yKuLrtKCD4AgvkxP/PVY09/Q7VK2NZaJHAowqpu28Nn3qobHw6Oe0wzGPy
         zt/e4A7Vx6Dc28gKI/Qxs+cAFL2Het1urULYryZM=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190530010346epcas1p440541c66431e5b7bb49d00c8e3d6bcb9~jUFX4Y77k0805908059epcas1p4F;
        Thu, 30 May 2019 01:03:46 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.60.04143.EEB2FEC5; Thu, 30 May 2019 10:03:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190530010342epcas1p35c4fb5686a2f124e43b651afa2cd0efd~jUFUCXkAn1055610556epcas1p3Q;
        Thu, 30 May 2019 01:03:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190530010342epsmtrp294e0fea086653ae83c2dd0cf786f0aa6~jUFUBk-Me2307923079epsmtrp2W;
        Thu, 30 May 2019 01:03:42 +0000 (GMT)
X-AuditID: b6c32a37-f19ff7000000102f-fa-5cef2beeb685
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.39.03692.DEB2FEC5; Thu, 30 May 2019 10:03:41 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190530010341epsmtip1a43dcab5cf6582820ee829c1c341b378~jUFT3QDKj0633606336epsmtip1x;
        Thu, 30 May 2019 01:03:41 +0000 (GMT)
Subject: Re: [PATCH v2] extcon: arizona: Correct error handling on
 regmap_update_bits_check
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     myungjoo.ham@samsung.com, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a67dc2eb-a8ce-9720-3cf9-fe179aa8c8a1@samsung.com>
Date:   Thu, 30 May 2019 10:05:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529094605.9838-1-ckeepax@opensource.cirrus.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHOXtcr+byNl8/RdRdicgyvW6zlQ/CSgYZGdKDUtdFTyruxe4m
        WQSWZTqijAjJrKSXZkWyTEuK1bLEQZFokJoVNOhF01pmL6jdXSP/+5zf+ZzzO99zDimWNxKx
        ZKXRii1GVk8TIZKeB4tTU7xLJovSHIMKzchBB9IM97USmvF9HYTGN+mUrpJom1v/IO2R7k6k
        9TniC8TbqrIqMFuGLYnYWGoqqzSWZ9PrCnWrdeqMNCaFWaFZTicaWQPOptfkF6TkVer93ejE
        alZv85cKWI6jU3OyLCabFSdWmDhrNo3NZXrzCvMyjjVwNmP5slKTYSWTlpau9os7qiquXWwK
        Mj+O2vXSfUVai/bL7YgkgVLBGXehHQWTcuoWgk/uLDsK8fMXBFebvUHCxDcEk700z7zvOjcl
        EqS7CKZudEqEwSSCrw+9BG+FU8Xws3cG8RxBpcPngTERz2JqO7T5LgUcgkoG57vnAQ6jFPDs
        +5uAL6Ny4EDPUMCXUAvh98wxKc+R1FZ49ahLKjgLYPCkR8JzMJUL7on3s/tHw5jn7CwnQN3N
        U2L+cED1E9DsGw8SIq+BvuEaIU04fBjoDhI4Fnzeu4TAe+DyYD8hrG1A0O18KhUmlOC8eFzE
        7yOmFsP1vlShrIDbv04joe988E4flgqtZNBQLxeUJBh+PSESOAbOH2okmhDdMidNy5wELXMS
        tPxv1oYknSgKmzlDOeYYs3LuUztQ4BsmL7+Fup7kuxBFIjpU1mTyFsmlbDVXY3AhIMV0hOxH
        u78kK2NrdmOLSWex6THnQmr/ZR8Tx0aWmvyf2mjVMep0pVKpUTEZaoaho2W6eaNFcqqcteIq
        jM3Y8m+diAyOrUVJI+EqlfP8xIbQhEX18W/thSfaVFf31g/XbYifjpoJ3kR4bUTxUjYmTKFe
        u+VCbqO7ObMyA48mRYfEcR+rXt7uOLXRcf91aEluXMO89T+b0h/bj1p6FDaM8zzO/JTB6pj2
        OxqPYYloiIwO3XO0ZKf2Rdbqe3HvWjNnrBGpns0uWsJVsEyy2MKxfwHorHQpnAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSnO5b7fcxBqeOW1pcad3EaHF51xw2
        i9uNK9gsPr/fz+rA4jF9zn9Gj74tqxg9Pm+SC2CO4rJJSc3JLEst0rdL4MpYu3QCe8FZsYp7
        p1azNjA2CXUxcnJICJhIHFr0gQnEFhLYzShxdZohRFxSYtrFo8xdjBxAtrDE4cPFXYxcQCVv
        gUoufGAEqREWiJX4tf07mC0iYCTx8fgtsDnMAtESl/q/skA0TGWUOL7gCFiCTUBLYv+LG2wg
        Nr+AosTVH4/BmnkF7CRatl0Eq2ERUJX4830iK4gtKhAhceb9ChaIGkGJkzOfgNmcAk4Sp+6+
        hFqmLvFn3iVmCFtc4taT+VBxeYnmrbOZJzAKz0LSPgtJyywkLbOQtCxgZFnFKJlaUJybnlts
        WGCYl1quV5yYW1yal66XnJ+7iREcG1qaOxgvL4k/xCjAwajEwzsh/12MEGtiWXFl7iFGCQ5m
        JRHen8uBQrwpiZVVqUX58UWlOanFhxilOViUxHmf5h2LFBJITyxJzU5NLUgtgskycXBKNTDm
        b9z0LqfRsi8lbu2HpR5/7v/6sc5xR0RW/4mDd7cf2xFyKJr19jqmx3K6cRo+PzJVmDcvFghU
        zd1x6L6FXofe244y9eObn75efrbJZ+a8DQ9ZQyRNf/65/Cray2Gp78Pgou0/p/oEp7nHCxxT
        r9vd9X/edDfv+4umJJlHLAlrl552/kM1m7mZEktxRqKhFnNRcSIA6X8QzYkCAAA=
X-CMS-MailID: 20190530010342epcas1p35c4fb5686a2f124e43b651afa2cd0efd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190529094610epcas5p35754e16753663dfa2ecadf0e410d619a
References: <CGME20190529094610epcas5p35754e16753663dfa2ecadf0e410d619a@epcas5p3.samsung.com>
        <20190529094605.9838-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

On 19. 5. 29. 오후 6:46, Charles Keepax wrote:
> Ensure the case when regmap_update_bits_check fails and the change
> variable is not updated is handled correctly.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Changes since v1:
>  - Print error message in driver remove
> 
> Thanks,
> Charles
> 
>  drivers/extcon/extcon-arizona.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
> index 9327479c719c2..519e89aedd4a0 100644
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
> @@ -1727,12 +1731,15 @@ static int arizona_extcon_remove(struct platform_device *pdev)
>  	struct arizona *arizona = info->arizona;
>  	int jack_irq_rise, jack_irq_fall;
>  	bool change;
> +	int ret;
>  
> -	regmap_update_bits_check(arizona->regmap, ARIZONA_MIC_DETECT_1,
> -				 ARIZONA_MICD_ENA, 0,
> -				 &change);
> -
> -	if (change) {
> +	ret = regmap_update_bits_check(arizona->regmap, ARIZONA_MIC_DETECT_1,
> +				       ARIZONA_MICD_ENA, 0,
> +				       &change);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to disable micd on remove: %d\n",
> +			ret);
> +	} else if (change) {
>  		regulator_disable(info->micvdd);
>  		pm_runtime_put(info->dev);
>  	}
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
