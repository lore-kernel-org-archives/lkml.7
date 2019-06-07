Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DACC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F23208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BhKxYUCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfFGGNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 02:13:36 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54382 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfFGGNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:13:36 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190607061334euoutp022faadaf2edfc4e39476ac7d01de5876c~l1eJ3vW6d2914529145euoutp02X
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2019 06:13:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190607061334euoutp022faadaf2edfc4e39476ac7d01de5876c~l1eJ3vW6d2914529145euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559888014;
        bh=rY1LsFvS8wHdYvQgg3J28EeOngDObvqh8vabpmaHDEE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BhKxYUCXikFGilgRAlYQ4xx+flCzIgGh+qmpVc+gNLOv18/9frJUonl1YfjZ37eg6
         2ea7oOxJJ7hWZBA4vywc3DI/5dZLCijVAyDSl6+ephYUGSfjmgXuVmGc4dzCE7Duk0
         1aM32DkiBqm/8/tdaX3Yulvar4dz5RKQUk6TgJSw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190607061333eucas1p272a5a2820d275b3184631fd6a01e3ca2~l1eJJ_4Md0641406414eucas1p2U;
        Fri,  7 Jun 2019 06:13:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 36.2D.04377.D800AFC5; Fri,  7
        Jun 2019 07:13:33 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190607061332eucas1p2c4290d1bbd0970a34db5114ede6bb7ce~l1eIYI75b0641406414eucas1p2T;
        Fri,  7 Jun 2019 06:13:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190607061332eusmtrp1f1ffcc682274f1ebc98b9fb1f1e2384a~l1eIIdZ1H0381503815eusmtrp1k;
        Fri,  7 Jun 2019 06:13:32 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-83-5cfa008da2fb
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 37.D5.04140.C800AFC5; Fri,  7
        Jun 2019 07:13:32 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190607061331eusmtip1638d4530bab6b44407d46d2f883ecdad~l1eHY7X1j3106031060eusmtip1j;
        Fri,  7 Jun 2019 06:13:31 +0000 (GMT)
Subject: Re: [PATCH v4 10/15] drm/bridge: tc358767: Add support for
 address-only I2C transfers
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <471cea60-0eb6-920d-bf2f-c34bc3a0b272@samsung.com>
Date:   Fri, 7 Jun 2019 08:13:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607044550.13361-11-andrew.smirnov@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRj1d1+7jibXaezLJGlJklCujLpimkHEKIIeBllSLr1Ma1uymzOL
        aEyx5QMzezkNhRQtRc3HzOUfupHTTDMrNPNFSdDDjErS0sx5lfzvfOec7/edAz8al7aRPnSC
        7hyn16k0ckpMWNumn2/MdvsdrfiW5summsNYk91IslOvHATb2uzE2FeTExQ7evcNxl7NLRGx
        L22FFDs03E6w1UUDVIRYOXpzDlM2WYZEygJzPqkcyXRiypxZhdLZ34gpf9SuUXbf7MIO0MfE
        O+I4TYKB0weFx4jjczPbycQWON96v4o0omdeGcidBmYr5AwW4RlITEuZcgS/zR+QMPxEMFs5
        RwrDDwSVtTNoaeVWxT2RC0uZMgQfSg4LpnEEpvwv8wJNezExYC1Z8HszB+C7qYlyeXCmE4Mr
        tre4S6CYDTBb94ZyYQkTDkNPrAs8wfhDl71mYXklcxRG2mpIweMJHfljhAu7MzsheyxnIQTO
        +EFqQwEuYBkMjBVhrmPADIvgc08jJaTeDRMlTxcbeMEnZ71IwL7QmZdFCPgyjJSn4cKyGUFD
        TRMuCKHgcL4gXc3w+dTVtiCB3gXvjfXIRQPjAf3jnkIGD7huvY0LtATM6VLBvRZGuhoWH5RB
        ac8kdQ3JLcuaWZa1sSxrY/l/txgRD5CMS+K1ao7fouOSN/EqLZ+kU2+KPautRfO/q/Ov8+cj
        ZJs5ZUcMjeQrJBFu09FSUmXgU7R2BDQu95YYeqaipZI4VcoFTn/2pD5Jw/F2tJom5DLJRbfR
        41JGrTrHneG4RE6/pGK0u48RQWSFOjTZ5vfLnr49oeV0gNSfn9DsJcgow9fJXsq79J1nQCu6
        NHli1Yq4qPRDirmPmcmYBm7IoquCI73+KIYNxWErra2V6wpf1/f17WupC9GnDW58VnEnb33W
        kS7H42CzKLDYsdWxP7LMh91j0m7rduuItXFW3cPIg8G9g80hcoKPV20OxPW86h8CSd7/WQMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xu7o9DL9iDPomalo0d9haNB1qYLX4
        ceUwi8XBPceZLK58fc9m8WDuTSaLzolL2C0u75rDZnH33gkWi/Xzb7E5cHk8mPqfyWPnrLvs
        HrM7ZrJ63O8+zuTR/9fA4/iN7UwenzfJeZybepYpgCNKz6Yov7QkVSEjv7jEVina0MJIz9DS
        Qs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2Ni9wnWggMSFQdXrmNtYDwj3MXIySEhYCIx
        bfVi9i5GLg4hgaWMEr9afjJDJMQlds9/C2ULS/y51sUGYgsJvGaU6Ntr2cXIwSEskCCxbQkj
        SFhEwE+ia94BJpA5zAJnmSR+797JBjH0GKPE0reT2EGq2AQ0Jf5uvgk2iFfATuLu0W1gC1gE
        VCTOHtoANklUIELizPsVLBA1ghInZz4BszkF7CV6n/SDzWEWUJf4M+8SM4QtL9G8dTaULS5x
        68l8pgmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBEbrtmM/
        t+xg7HoXfIhRgINRiYd3BtPPGCHWxLLiytxDjBIczEoivGUXfsQI8aYkVlalFuXHF5XmpBYf
        YjQFem4is5Rocj4wkeSVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCU
        amC0cr8fo3pltv1+/sm8i7gzLGI7mB8cmLSUN3q/kYaxQLZwv3zdya6DPAYdMzezfrvyarOG
        8Zcm5ddRAtnp1/dnHee+t9y4mfnfK59ld2eZlzI9SLA9yq/y+PmjV/MFGSTef+s765nlkzp9
        6nLN+pCb22XcdYyK8zxPmgdtO6Y8/9WK6DvvWQ4osRRnJBpqMRcVJwIAcivIAuwCAAA=
X-CMS-MailID: 20190607061332eucas1p2c4290d1bbd0970a34db5114ede6bb7ce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607044643epcas3p288c95d8f86c74056677b22b27ca2fe30
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607044643epcas3p288c95d8f86c74056677b22b27ca2fe30
References: <20190607044550.13361-1-andrew.smirnov@gmail.com>
        <CGME20190607044643epcas3p288c95d8f86c74056677b22b27ca2fe30@epcas3p2.samsung.com>
        <20190607044550.13361-11-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.2019 06:45, Andrey Smirnov wrote:
> Transfer size of zero means a request to do an address-only
> transfer. Since the HW support this, we probably shouldn't be just
> ignoring such requests. While at it allow DP_AUX_I2C_MOT flag to pass
> through, since it is supported by the HW as well.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/bridge/tc358767.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index 7d0fbb12195b..4bb9b15e1324 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -145,6 +145,8 @@
>  
>  /* AUX channel */
>  #define DP0_AUXCFG0		0x0660
> +#define DP0_AUXCFG0_BSIZE	GENMASK(11, 8)
> +#define DP0_AUXCFG0_ADDR_ONLY	BIT(4)
>  #define DP0_AUXCFG1		0x0664
>  #define AUX_RX_FILTER_EN		BIT(16)
>  
> @@ -327,6 +329,18 @@ static int tc_aux_read_data(struct tc_data *tc, void *data, size_t size)
>  	return size;
>  }
>  
> +static u32 tc_auxcfg0(struct drm_dp_aux_msg *msg, size_t size)
> +{
> +	u32 auxcfg0 = msg->request;
> +
> +	if (size)
> +		auxcfg0 |= FIELD_PREP(DP0_AUXCFG0_BSIZE, size - 1);
> +	else
> +		auxcfg0 |= DP0_AUXCFG0_ADDR_ONLY;
> +
> +	return auxcfg0;
> +}
> +
>  static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
>  			       struct drm_dp_aux_msg *msg)
>  {
> @@ -336,9 +350,6 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
>  	u32 auxstatus;
>  	int ret;
>  
> -	if (size == 0)
> -		return 0;
> -
>  	ret = tc_aux_wait_busy(tc, 100);
>  	if (ret)
>  		return ret;
> @@ -362,8 +373,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
>  	if (ret)
>  		return ret;
>  	/* Start transfer */
> -	ret = regmap_write(tc->regmap, DP0_AUXCFG0,
> -			   ((size - 1) << 8) | request);
> +	ret = regmap_write(tc->regmap, DP0_AUXCFG0, tc_auxcfg0(msg, size));
>  	if (ret)
>  		return ret;
>  
> @@ -377,8 +387,14 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
>  
>  	if (auxstatus & AUX_TIMEOUT)
>  		return -ETIMEDOUT;
> -
> -	size = FIELD_GET(AUX_BYTES, auxstatus);
> +	/*
> +	 * For some reason address-only DP_AUX_I2C_WRITE (MOT), still
> +	 * reports 1 byte transferred in its status. To deal we that
> +	 * we ignore aux_bytes field if we know that this was an
> +	 * address-only transfer
> +	 */
> +	if (size)
> +		size = FIELD_GET(AUX_BYTES, auxstatus);
>  	msg->reply = FIELD_GET(AUX_STATUS, auxstatus);
>  
>  	switch (request) {


