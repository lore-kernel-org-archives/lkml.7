Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D73FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC1D2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wSulFOfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfCDLou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 06:44:50 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44154 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfCDLou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 06:44:50 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x24BiQvX057296;
        Mon, 4 Mar 2019 05:44:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551699866;
        bh=V3kgIuSWnEvtfqPkX44tTeFC5VFR47wme3mhOcRjuJ0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wSulFOfeZd4hL5M1jIjig3ysJwYczQ30m64fyUzqC/eAx5K8F/7MV8RzMxMAUqgrv
         I2UVcCWmeaMpSWO4sOQKh5nJKjNZjsE7jkJUn0jlCLK9bgQTJW+Tsfsq2xQiKNi1WN
         X43eRiDeXThNUtxyhXcHwLKDVVi8uyUxsHeRcGoE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x24BiQUU105510
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Mar 2019 05:44:26 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Mar 2019 05:44:24 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Mar 2019 05:44:24 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x24BiMPt017639;
        Mon, 4 Mar 2019 05:44:23 -0600
Subject: Re: [PATCH v2] ASoC: tlv320aic3x: fix reset gpio reference counting
To:     Philipp Puschmann <philipp.puschmann@emlix.com>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20190227151733.4419-1-philipp.puschmann@emlix.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <860b91b9-0131-323b-fa62-f37ff2c9d23b@ti.com>
Date:   Mon, 4 Mar 2019 13:45:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227151733.4419-1-philipp.puschmann@emlix.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/02/2019 17.17, Philipp Puschmann wrote:
> This patch fixes a bug that prevents freeing the reset gpio on unloading
> the module.
> 
> aic3x_i2c_probe is called when loading the module and it calls list_add
> with a probably uninitialized list entry aic3x->list (next = prev = NULL)).
> So even if list_del is called it does nothing and in the end the gpio_reset
> is not freed. Then a repeated module probing fails silently because
> gpio_request fails.
> 
> When moving INIT_LIST_HEAD to aic3x_i2c_probe we also have to move
> list_del to aic3x_i2c_remove because aic3x_remove may be called
> multiple times without aic3x_i2c_remove being called which leads to
> a NULL pointer dereference.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> 
> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
> ---
> Changes in v2: Fix typo in title tlv320aix3x -> tlv320aic3x
> 
>  sound/soc/codecs/tlv320aic3x.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
> index 6aa0edf8c5ef..cea3ebecdb12 100644
> --- a/sound/soc/codecs/tlv320aic3x.c
> +++ b/sound/soc/codecs/tlv320aic3x.c
> @@ -1609,7 +1609,6 @@ static int aic3x_probe(struct snd_soc_component *component)
>  	struct aic3x_priv *aic3x = snd_soc_component_get_drvdata(component);
>  	int ret, i;
>  
> -	INIT_LIST_HEAD(&aic3x->list);
>  	aic3x->component = component;
>  
>  	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++) {
> @@ -1692,7 +1691,6 @@ static void aic3x_remove(struct snd_soc_component *component)
>  	struct aic3x_priv *aic3x = snd_soc_component_get_drvdata(component);
>  	int i;
>  
> -	list_del(&aic3x->list);
>  	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
>  		regulator_unregister_notifier(aic3x->supplies[i].consumer,
>  					      &aic3x->disable_nb[i].nb);
> @@ -1890,6 +1888,7 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
>  	if (ret != 0)
>  		goto err_gpio;
>  
> +	INIT_LIST_HEAD(&aic3x->list);
>  	list_add(&aic3x->list, &reset_list);
>  
>  	return 0;
> @@ -1906,6 +1905,8 @@ static int aic3x_i2c_remove(struct i2c_client *client)
>  {
>  	struct aic3x_priv *aic3x = i2c_get_clientdata(client);
>  
> +	list_del(&aic3x->list);
> +
>  	if (gpio_is_valid(aic3x->gpio_reset) &&
>  	    !aic3x_is_shared_reset(aic3x)) {
>  		gpio_set_value(aic3x->gpio_reset, 0);
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
