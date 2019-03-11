Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697F3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38531206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfCKQLI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:11:08 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:34224 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbfCKQLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:11:07 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 3983314CEA; Mon, 11 Mar 2019 16:11:06 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: hdmi: add support for ddc-i2c-bus property
References: <20190311134713.25876-1-mans@mansr.com>
        <20190311154702.eslw5ccol44vxcmy@flea>
Date:   Mon, 11 Mar 2019 16:11:06 +0000
In-Reply-To: <20190311154702.eslw5ccol44vxcmy@flea> (Maxime Ripard's message
        of "Mon, 11 Mar 2019 16:47:02 +0100")
Message-ID: <yw1xef7d4cit.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <maxime.ripard@bootlin.com> writes:

> Hi!
>
> On Mon, Mar 11, 2019 at 01:47:13PM +0000, Mans Rullgard wrote:
>> Sometimes it is desirabled to use a separate i2c controller for ddc
>> access.  This adds support for the ddc-i2c-bus property of the
>> hdmi-connector node, using the specified controller if provided.
>> 
>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>> ---
>>  drivers/gpu/drm/sun4i/sun4i_hdmi.h     |  1 +
>>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 37 +++++++++++++++++++++++---
>>  2 files changed, 35 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi.h b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
>> index b685ee11623d..b08c4453d47c 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi.h
>> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
>> @@ -269,6 +269,7 @@ struct sun4i_hdmi {
>>  	struct clk		*tmds_clk;
>>  
>>  	struct i2c_adapter	*i2c;
>> +	struct i2c_adapter	*ddc_i2c;
>>  
>>  	/* Regmap fields for I2C adapter */
>>  	struct regmap_field	*field_ddc_en;
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
>> index 061d2e0d9011..5b2fac79f5d6 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
>> @@ -212,7 +212,7 @@ static int sun4i_hdmi_get_modes(struct drm_connector *connector)
>>  	struct edid *edid;
>>  	int ret;
>>  
>> -	edid = drm_get_edid(connector, hdmi->i2c);
>> +	edid = drm_get_edid(connector, hdmi->ddc_i2c ?: hdmi->i2c);
>
> You can't test whether ddc_i2c is NULL or not...
>
>>  	if (!edid)
>>  		return 0;
>>  
>> @@ -228,6 +228,28 @@ static int sun4i_hdmi_get_modes(struct drm_connector *connector)
>>  	return ret;
>>  }
>>  
>> +static struct i2c_adapter *sun4i_hdmi_get_ddc(struct device *dev)
>> +{
>> +	struct device_node *phandle, *remote;
>> +	struct i2c_adapter *ddc;
>> +
>> +	remote = of_graph_get_remote_node(dev->of_node, 1, -1);
>> +	if (!remote)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	phandle = of_parse_phandle(remote, "ddc-i2c-bus", 0);
>> +	of_node_put(remote);
>> +	if (!phandle)
>> +		return NULL;
>> +
>> +	ddc = of_get_i2c_adapter_by_node(phandle);
>> +	of_node_put(phandle);
>> +	if (!ddc)
>> +		return ERR_PTR(-EPROBE_DEFER);
>> +
>> +	return ddc;
>
> ... Since even in (most) error cases you're returning a !NULL pointer.
>
>> +}
>> +
>>  static const struct drm_connector_helper_funcs sun4i_hdmi_connector_helper_funcs = {
>>  	.get_modes	= sun4i_hdmi_get_modes,
>>  };
>> @@ -575,6 +597,12 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
>>  		goto err_disable_mod_clk;
>>  	}
>>  
>> +	hdmi->ddc_i2c = sun4i_hdmi_get_ddc(dev);
>> +	if (IS_ERR(hdmi->ddc_i2c)) {

... which is checked here.

The property is optional, so the idea was to return null in that case
and use the built-in controller.  If the property exists but some error
occurs, we want to abort rather than proceed with the fallback which
almost certainly won't work.

Maybe I got something wrong in that logic.

-- 
Måns Rullgård
