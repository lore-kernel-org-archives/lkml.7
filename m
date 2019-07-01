Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC47C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20929206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Gb4mxEWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfGAKgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:36:19 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55505 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGAKgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:36:19 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190701103617euoutp01e4279bae0e4aea2824a6b58c7191685a~tQiYT2-HR0479804798euoutp01S
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2019 10:36:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190701103617euoutp01e4279bae0e4aea2824a6b58c7191685a~tQiYT2-HR0479804798euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561977377;
        bh=97CcTl+Xf2thSNnnXc3pgljpPmedh9J3aow4zG2wFwg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Gb4mxEWnF87Ad5nqS5yzAMpbveh1fluXDVN3CXtiCLJWCsPBYUVXfemr1l3t3KNrr
         prQaeKxe+SOY/7/nOaYsTAL0nONEdWfk7LpZygXr/Id5XfxaupJBEd9c2kTQ09NElm
         ix7S8VmWPGqSttbADx/H9499PhcfLPnB2su8xSCI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190701103616eucas1p287ddef51fa0a1b2ce28fe3ea9eea054b~tQiXoc0Ps1535715357eucas1p2m;
        Mon,  1 Jul 2019 10:36:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FE.B3.04298.F12E91D5; Mon,  1
        Jul 2019 11:36:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190701103615eucas1p289b14407a9ee7cd94151156ea859959a~tQiW4iUAj2824628246eucas1p2K;
        Mon,  1 Jul 2019 10:36:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190701103615eusmtrp1ce373631df731aa64d29fd0a761500c6~tQiWqcTFI1747117471eusmtrp10;
        Mon,  1 Jul 2019 10:36:15 +0000 (GMT)
X-AuditID: cbfec7f2-3615e9c0000010ca-ef-5d19e21f6877
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 86.55.04140.F12E91D5; Mon,  1
        Jul 2019 11:36:15 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190701103614eusmtip1a8a3f86bd7814c1be7dbf4305c6ef88b~tQiWN4CMB2960229602eusmtip1c;
        Mon,  1 Jul 2019 10:36:14 +0000 (GMT)
Subject: Re: [PATCH] drm/bridge: dw-hdmi: Use automatic CTS generation mode
 when using non-AHB audio
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent.pinchart@ideasonboard.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Jerome Brunet <jbrunet@baylibre.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <7d4404b2-a5d1-82ba-6016-41b4f780ae98@samsung.com>
Date:   Mon, 1 Jul 2019 12:36:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190612085147.26971-1-narmstrong@baylibre.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7djP87oKjyRjDbpqLa58fc9m8f/Ra1aL
        N4+OMFtc/f6S2eLkm6ssFp0Tl7BbXN41h83iwcv9jBaH+qIdOD3e32hl95i3ptpjdsdMVo8T
        Ey4xedzvPs7kcaB3MovH9mvzmD0+b5IL4IjisklJzcksSy3St0vgypj59gRzwW+5ips7P7M2
        MG6Q6GLk5JAQMJH4uvgvI4gtJLCCUWLGPpsuRi4g+wujxMm1k1ghEp8ZJVpneME0THu/lB2i
        aDmjxO/Hs1ghnLeMEks/3WIDqRIWSJP4P/0g2FgRgUCJ473bGEGKmAVamSTuzv4JNpZNQFPi
        7+abYA28AnYSs5btBLNZBFQkLj/5wQ5iiwpESFzesosRokZQ4uTMJywgNqeArcSnz7vA6pkF
        5CW2v53DDGGLS9x6Mp8JZJmEwDV2ibVP/jNB3O0isXP7SUYIW1ji1fEt7BC2jMTpyT0sEHa9
        xP0VLcwQzR2MEls37GSGSFhLHD5+EehqDqANmhLrd+lDhB0lOu/9YwYJSwjwSdx4KwhxA5/E
        pG3TocK8Eh1tQhDVihL3z26FGigusfTCV7YJjEqzkHw2C8k3s5B8Mwth7wJGllWM4qmlxbnp
        qcWGeanlesWJucWleel6yfm5mxiB6er0v+OfdjB+vZR0iFGAg1GJh7fhjkSsEGtiWXFl7iFG
        CQ5mJRHe/SskY4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzVjM8iBYSSE8sSc1OTS1ILYLJMnFw
        SjUwci6fncSwt144cErxru53OrqBc8SXr1n4UHKZ37vXBsm8E+78jmT86JpVeT36z4bGFMu3
        nQ0mDQzT11sZGB4OqpdftyjLc8PLX7OLqgX8nnPHbdrwyY+pMsDIwHvGg6/NYrvupHlH+7hv
        bYv4cGr+02/ztgR9OvbO2eRn6z6Dr3tfzOK5VnW0W4mlOCPRUIu5qDgRAMVKOV9TAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xu7ryjyRjDXp+8lpc+fqezeL/o9es
        Fm8eHWG2uPr9JbPFyTdXWSw6Jy5ht7i8aw6bxYOX+xktDvVFO3B6vL/Ryu4xb021x+yOmawe
        JyZcYvK4332cyeNA72QWj+3X5jF7fN4kF8ARpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKp
        Z2hsHmtlZKqkb2eTkpqTWZZapG+XoJcx8+0J5oLfchU3d35mbWDcINHFyMkhIWAiMe39UvYu
        Ri4OIYGljBJTT21kgkiIS+ye/5YZwhaW+HOtiw3EFhJ4zSix9qIqiC0skCbxf/pBRhBbRCBQ
        YlHvAmaQQcwCrUwS/1qus0BMncAosXHZGxaQKjYBTYm/m2+CTeIVsJOYtWwnmM0ioCJx+ckP
        dhBbVCBCoq9tNlSNoMTJmU/AejkFbCU+fd4FFmcWUJf4M+8SM4QtL7H97RwoW1zi1pP5TBMY
        hWYhaZ+FpGUWkpZZSFoWMLKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIzSbcd+btnB2PUu
        +BCjAAejEg+vxi2JWCHWxLLiytxDjBIczEoivPtXSMYK8aYkVlalFuXHF5XmpBYfYjQFem4i
        s5Rocj4wgeSVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamDM9755
        5jRPXL2WypWZXgcmbnE74JpVoejdsp/H49aPD2L3dv3bEtLZfVDgQemu2vkRqZU8s2q2JcxY
        4Jkl77nvwC+tPzP5Y47uuFfi5SbZcEssduf2IytXn1Fdsq1yXoZOhPbaj5rbIp89yuOofcra
        8Df+xY8nYvuy3DQb9dg9vgmmLznYqFekxFKckWioxVxUnAgANeWCp+gCAAA=
X-CMS-MailID: 20190701103615eucas1p289b14407a9ee7cd94151156ea859959a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190612085155epcas1p14ea44ab7c6cf6309a1e25a6e8b5f36ed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190612085155epcas1p14ea44ab7c6cf6309a1e25a6e8b5f36ed
References: <CGME20190612085155epcas1p14ea44ab7c6cf6309a1e25a6e8b5f36ed@epcas1p1.samsung.com>
        <20190612085147.26971-1-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.06.2019 10:51, Neil Armstrong wrote:
> When using an I2S source using a different clock source (usually the I2S
> audio HW uses dedicated PLLs, different from the HDMI PHY PLL), fixed
> CTS values will cause some frequent audio drop-out and glitches as
> reported on Amlogic, Allwinner and Rockchip SoCs setups.
>
> Setting the CTS in automatic mode will let the HDMI controller generate
> automatically the CTS value to match the input audio clock.
>
> The DesignWare DW-HDMI User Guide explains:
>   For Automatic CTS generation
>   Write "0" on the bit field "CTS_manual", Register 0x3205: AUD_CTS3
>
> The DesignWare DW-HDMI Databook explains :
>   If "CTS_manual" bit equals 0b this registers contains "audCTS[19:0]"
>   generated by the Cycle time counter according to specified timing.
>
> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>


Queued to drm-misc-next.


Regards

Andrzej


> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 44 +++++++++++++++--------
>  1 file changed, 29 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index c68b6ed1bb35..6458c3a31d23 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -437,8 +437,14 @@ static void hdmi_set_cts_n(struct dw_hdmi *hdmi, unsigned int cts,
>  	/* nshift factor = 0 */
>  	hdmi_modb(hdmi, 0, HDMI_AUD_CTS3_N_SHIFT_MASK, HDMI_AUD_CTS3);
>  
> -	hdmi_writeb(hdmi, ((cts >> 16) & HDMI_AUD_CTS3_AUDCTS19_16_MASK) |
> -		    HDMI_AUD_CTS3_CTS_MANUAL, HDMI_AUD_CTS3);
> +	/* Use automatic CTS generation mode when CTS is not set */
> +	if (cts)
> +		hdmi_writeb(hdmi, ((cts >> 16) &
> +				   HDMI_AUD_CTS3_AUDCTS19_16_MASK) |
> +				  HDMI_AUD_CTS3_CTS_MANUAL,
> +			    HDMI_AUD_CTS3);
> +	else
> +		hdmi_writeb(hdmi, 0, HDMI_AUD_CTS3);
>  	hdmi_writeb(hdmi, (cts >> 8) & 0xff, HDMI_AUD_CTS2);
>  	hdmi_writeb(hdmi, cts & 0xff, HDMI_AUD_CTS1);
>  
> @@ -508,24 +514,32 @@ static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
>  {
>  	unsigned long ftdms = pixel_clk;
>  	unsigned int n, cts;
> +	u8 config3;
>  	u64 tmp;
>  
>  	n = hdmi_compute_n(sample_rate, pixel_clk);
>  
> -	/*
> -	 * Compute the CTS value from the N value.  Note that CTS and N
> -	 * can be up to 20 bits in total, so we need 64-bit math.  Also
> -	 * note that our TDMS clock is not fully accurate; it is accurate
> -	 * to kHz.  This can introduce an unnecessary remainder in the
> -	 * calculation below, so we don't try to warn about that.
> -	 */
> -	tmp = (u64)ftdms * n;
> -	do_div(tmp, 128 * sample_rate);
> -	cts = tmp;
> +	config3 = hdmi_readb(hdmi, HDMI_CONFIG3_ID);
>  
> -	dev_dbg(hdmi->dev, "%s: fs=%uHz ftdms=%lu.%03luMHz N=%d cts=%d\n",
> -		__func__, sample_rate, ftdms / 1000000, (ftdms / 1000) % 1000,
> -		n, cts);
> +	/* Only compute CTS when using internal AHB audio */
> +	if (config3 & HDMI_CONFIG3_AHBAUDDMA) {
> +		/*
> +		 * Compute the CTS value from the N value.  Note that CTS and N
> +		 * can be up to 20 bits in total, so we need 64-bit math.  Also
> +		 * note that our TDMS clock is not fully accurate; it is
> +		 * accurate to kHz.  This can introduce an unnecessary remainder
> +		 * in the calculation below, so we don't try to warn about that.
> +		 */
> +		tmp = (u64)ftdms * n;
> +		do_div(tmp, 128 * sample_rate);
> +		cts = tmp;
> +
> +		dev_dbg(hdmi->dev, "%s: fs=%uHz ftdms=%lu.%03luMHz N=%d cts=%d\n",
> +			__func__, sample_rate,
> +			ftdms / 1000000, (ftdms / 1000) % 1000,
> +			n, cts);
> +	} else
> +		cts = 0;
>  
>  	spin_lock_irq(&hdmi->audio_lock);
>  	hdmi->audio_n = n;


