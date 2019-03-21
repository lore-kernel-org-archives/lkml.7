Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53D4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5219218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfCUSAr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:00:47 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:56096 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfCUSAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:00:47 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 2C02914CEB; Thu, 21 Mar 2019 18:00:45 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: hdmi: add support for ddc-i2c-bus property
References: <20190311134713.25876-1-mans@mansr.com>
        <20190311154702.eslw5ccol44vxcmy@flea> <yw1xef7d4cit.fsf@mansr.com>
        <20190314154105.o6r7hzeuiyajxh7v@flea> <yw1xk1h130ba.fsf@mansr.com>
        <20190318155013.lge2x2cp5hvyz52f@flea> <yw1xh8c0178j.fsf@mansr.com>
        <20190319123445.w6q7vzr3qtgkejwj@flea> <yw1xva0fyqr0.fsf@mansr.com>
        <20190321154452.noq3l44x3mshljvy@flea>
Date:   Thu, 21 Mar 2019 18:00:45 +0000
In-Reply-To: <20190321154452.noq3l44x3mshljvy@flea> (Maxime Ripard's message
        of "Thu, 21 Mar 2019 16:44:52 +0100")
Message-ID: <yw1xef70yunm.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <maxime.ripard@bootlin.com> writes:

> On Tue, Mar 19, 2019 at 12:48:19PM +0000, Måns Rullgård wrote:
>> Maxime Ripard <maxime.ripard@bootlin.com> writes:
>>
>> > On Mon, Mar 18, 2019 at 04:23:56PM +0000, Måns Rullgård wrote:
>> >> Maxime Ripard <maxime.ripard@bootlin.com> writes:
>> >>
>> >> > On Thu, Mar 14, 2019 at 04:09:13PM +0000, Måns Rullgård wrote:
>> >> >> Maxime Ripard <maxime.ripard@bootlin.com> writes:
>> >> >>
>> >> >> > On Mon, Mar 11, 2019 at 04:11:06PM +0000, Måns Rullgård wrote:
>> >> >> >> Maxime Ripard <maxime.ripard@bootlin.com> writes:
>> >> >> >>
>> >> >> >> > Hi!
>> >> >> >> >
>> >> >> >> > On Mon, Mar 11, 2019 at 01:47:13PM +0000, Mans Rullgard wrote:
>> >> >> >> >> Sometimes it is desirabled to use a separate i2c controller for ddc
>> >> >> >> >> access.  This adds support for the ddc-i2c-bus property of the
>> >> >> >> >> hdmi-connector node, using the specified controller if provided.
>> >> >> >> >>
>> >> >> >> >> Signed-off-by: Mans Rullgard <mans@mansr.com>
>> >> >> >> >> ---
>> >> >> >> >>  drivers/gpu/drm/sun4i/sun4i_hdmi.h     |  1 +
>> >> >> >> >>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 37 +++++++++++++++++++++++---
>> >> >> >> >>  2 files changed, 35 insertions(+), 3 deletions(-)
>> >> >> >> >>
>> >> >> >> >> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi.h b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
>> >> >> >> >> index b685ee11623d..b08c4453d47c 100644
>> >> >> >> >> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi.h
>> >> >> >> >> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
>> >> >> >> >> @@ -269,6 +269,7 @@ struct sun4i_hdmi {
>> >> >> >> >>  	struct clk		*tmds_clk;
>> >> >> >> >>
>> >> >> >> >>  	struct i2c_adapter	*i2c;
>> >> >> >> >> +	struct i2c_adapter	*ddc_i2c;
>> >> >> >> >>
>> >> >> >> >>  	/* Regmap fields for I2C adapter */
>> >> >> >> >>  	struct regmap_field	*field_ddc_en;
>> >> >> >> >> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
>> >> >> >> >> index 061d2e0d9011..5b2fac79f5d6 100644
>> >> >> >> >> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
>> >> >> >> >> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
>> >> >> >> >> @@ -212,7 +212,7 @@ static int sun4i_hdmi_get_modes(struct drm_connector *connector)
>> >> >> >> >>  	struct edid *edid;
>> >> >> >> >>  	int ret;
>> >> >> >> >>
>> >> >> >> >> -	edid = drm_get_edid(connector, hdmi->i2c);
>> >> >> >> >> +	edid = drm_get_edid(connector, hdmi->ddc_i2c ?: hdmi->i2c);
>> >> >> >> >
>> >> >> >> > You can't test whether ddc_i2c is NULL or not...
>> >> >> >> >
>> >> >> >> >>  	if (!edid)
>> >> >> >> >>  		return 0;
>> >> >> >> >>
>> >> >> >> >> @@ -228,6 +228,28 @@ static int sun4i_hdmi_get_modes(struct drm_connector *connector)
>> >> >> >> >>  	return ret;
>> >> >> >> >>  }
>> >> >> >> >>
>> >> >> >> >> +static struct i2c_adapter *sun4i_hdmi_get_ddc(struct device *dev)
>> >> >> >> >> +{
>> >> >> >> >> +	struct device_node *phandle, *remote;
>> >> >> >> >> +	struct i2c_adapter *ddc;
>> >> >> >> >> +
>> >> >> >> >> +	remote = of_graph_get_remote_node(dev->of_node, 1, -1);
>> >> >> >> >> +	if (!remote)
>> >> >> >> >> +		return ERR_PTR(-EINVAL);
>> >> >> >> >> +
>> >> >> >> >> +	phandle = of_parse_phandle(remote, "ddc-i2c-bus", 0);
>> >> >> >> >> +	of_node_put(remote);
>> >> >> >> >> +	if (!phandle)
>> >> >> >> >> +		return NULL;
>> >> >> >> >> +
>> >> >> >> >> +	ddc = of_get_i2c_adapter_by_node(phandle);
>> >> >> >> >> +	of_node_put(phandle);
>> >> >> >> >> +	if (!ddc)
>> >> >> >> >> +		return ERR_PTR(-EPROBE_DEFER);
>> >> >> >> >> +
>> >> >> >> >> +	return ddc;
>> >> >> >> >
>> >> >> >> > ... Since even in (most) error cases you're returning a !NULL pointer.
>> >> >> >> >
>> >> >> >> >> +}
>> >> >> >> >> +
>> >> >> >> >>  static const struct drm_connector_helper_funcs sun4i_hdmi_connector_helper_funcs = {
>> >> >> >> >>  	.get_modes	= sun4i_hdmi_get_modes,
>> >> >> >> >>  };
>> >> >> >> >> @@ -575,6 +597,12 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
>> >> >> >> >>  		goto err_disable_mod_clk;
>> >> >> >> >>  	}
>> >> >> >> >>
>> >> >> >> >> +	hdmi->ddc_i2c = sun4i_hdmi_get_ddc(dev);
>> >> >> >> >> +	if (IS_ERR(hdmi->ddc_i2c)) {
>> >> >> >>
>> >> >> >> ... which is checked here.
>> >> >> >>
>> >> >> >> The property is optional, so the idea was to return null in that case
>> >> >> >> and use the built-in controller.  If the property exists but some error
>> >> >> >> occurs, we want to abort rather than proceed with the fallback which
>> >> >> >> almost certainly won't work.
>> >> >> >>
>> >> >> >> Maybe I got something wrong in that logic.
>> >> >> >
>> >> >> > Indeed, I just got confused. I guess returning ENODEV in such a case,
>> >> >> > and testing for that, would make things more obvious.
>> >> >>
>> >> >> There's also a case I hadn't thought of: property exists but isn't a
>> >> >> valid phandle.  What do you think is the correct action in that case?
>> >> >
>> >> > I think we would have that one covered. of_parse_phandle will return
>> >> > !NULL, but then of_get_i2c_adapter_by_node will return NULL since we
>> >> > wouldn't have an associated i2c adapter to the bogus phandle, and you
>> >> > are checking for that already.
>> >>
>> >> of_parse_phandle() doesn't differentiate between a missing property and
>> >> an existing non-phandle value.  The following cases are possible with
>> >> this patch:
>> >>
>> >> - ddc-i2c-bus points to valid i2c controller node: use this for ddc
>> >> - no ddc-i2c-bus property: return NULL, use internal i2c
>> >> - ddc-i2c-bus exists but isn't a phandle: likewise
>> >> - ddc-i2c-bus points to a non-i2c-controller node: EPROBE_DEFER
>> >>
>> >> The last two cases obviously mean the devicetree is invalid, so perhaps
>> >> it doesn't matter much what happens then.  I don't think it's possible
>> >> to distinguish between a well-formed phandle pointing to some bogus node
>> >> and a good one where the i2c driver hasn't been probed yet.
>> >
>> > Ah, I see what you mean now. Yeah, there's not much we can do against
>> > a wrong / corrupted DT. The DT validation would help prevent the third
>> > case, and possibly the fourth, but that's basically the only thing we
>> > can do.
>>
>> We need to return -EPROBE_DEFER in the case that everything is fine but
>> the i2c driver hasn't been probed yet.  From here, that is
>> indistinguishable from of_parse_phandle() returning a completely bogus
>> node.
>
> That's unfortunate, but if we start to not trust the DT content, we
> have far worse to deal with.
>
>> If the ddc-i2c-bus property doesn't contain a phandle at all, we could
>> either return an error or fall back to the internal i2c.  The patch does
>> the latter because that's less code.  I don't think that's any worse
>> than aborting entirely in terms of user experience.
>
> I'm totally fine with the latter behaviour as well. And like I said,
> the DT validation can help us prevent that case from happening
> entirely at compilation time.

Well, do you want any changes to the patch or not?

-- 
Måns Rullgård
