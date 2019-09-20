Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6789EC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 12:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219B420644
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 12:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EMtxKU5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408857AbfITMKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 08:10:05 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:47636 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408844AbfITMKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 08:10:05 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6A22E2F9;
        Fri, 20 Sep 2019 14:10:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1568981401;
        bh=/8c8aJvwEYFTv+9okLcngO4esqYPdEI/P3khmo6P1kE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EMtxKU5G2BBw6L1K6WnviBgmY09mAyleywNIrJPxf4lBt7SNdROn9H4mjyHTjzffu
         egtd3BPMLVBWiGttQVSWGuelPZbI3H7fiuG0ubII2JBN1FEnizGxXAPZjP5PyqQ6rz
         F41i4SPQFChC/lPYjRwdqBKcgO8jg0ZXifx6Rgac=
Date:   Fri, 20 Sep 2019 15:09:52 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Brian Masney <masneyb@onstation.org>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        enric.balletbo@collabora.com
Subject: Re: [PATCH v2] drm/bridge: analogix-anx78xx: add support for 7808
 addresses
Message-ID: <20190920120952.GG12950@pendragon.ideasonboard.com>
References: <20190920101438.6912-1-masneyb@onstation.org>
 <20190920104945.GC12950@pendragon.ideasonboard.com>
 <20190920112859.GA32015@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190920112859.GA32015@onstation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

On Fri, Sep 20, 2019 at 07:28:59AM -0400, Brian Masney wrote:
> On Fri, Sep 20, 2019 at 01:49:45PM +0300, Laurent Pinchart wrote:
> > On Fri, Sep 20, 2019 at 06:14:38AM -0400, Brian Masney wrote:
> >> According to the downstream Android sources, the anx7808 variants use
> >> address 0x78 for TX_P0 and the anx781x variants use address 0x70. Since
> >> the datasheets aren't available for these devices, and we only have the
> >> downstream kernel sources to look at, let's assume that these addresses
> >> are fixed based on the model, and pass the i2c addresses to the data
> >> pointer in the driver's of_match_table.
> >> 
> >> Signed-off-by: Brian Masney <masneyb@onstation.org>
> >> ---
> >> V1 of this patch with some discussion:
> >> https://lore.kernel.org/lkml/20190815004854.19860-6-masneyb@onstation.org/
> >> 
> >>  drivers/gpu/drm/bridge/analogix-anx78xx.c | 36 +++++++++++++++--------
> >>  drivers/gpu/drm/bridge/analogix-anx78xx.h |  7 -----
> >>  2 files changed, 23 insertions(+), 20 deletions(-)
> >> 
> >> diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix-anx78xx.c
> >> index 48adf010816c..e25fae36dbe1 100644
> >> --- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
> >> +++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
> >> @@ -38,12 +38,20 @@
> >>  #define AUX_CH_BUFFER_SIZE	16
> >>  #define AUX_WAIT_TIMEOUT_MS	15
> >>  
> >> -static const u8 anx78xx_i2c_addresses[] = {
> >> -	[I2C_IDX_TX_P0] = TX_P0,
> >> -	[I2C_IDX_TX_P1] = TX_P1,
> >> -	[I2C_IDX_TX_P2] = TX_P2,
> >> -	[I2C_IDX_RX_P0] = RX_P0,
> >> -	[I2C_IDX_RX_P1] = RX_P1,
> >> +static const u8 anx7808_i2c_addresses[] = {
> >> +	[I2C_IDX_TX_P0] = 0x78,
> >> +	[I2C_IDX_TX_P1] = 0x7a,
> >> +	[I2C_IDX_TX_P2] = 0x72,
> >> +	[I2C_IDX_RX_P0] = 0x7e,
> >> +	[I2C_IDX_RX_P1] = 0x80,
> >> +};
> >> +
> >> +static const u8 anx781x_i2c_addresses[] = {
> >> +	[I2C_IDX_TX_P0] = 0x70,
> >> +	[I2C_IDX_TX_P1] = 0x7a,
> >> +	[I2C_IDX_TX_P2] = 0x72,
> >> +	[I2C_IDX_RX_P0] = 0x7e,
> >> +	[I2C_IDX_RX_P1] = 0x80,
> >>  };
> > 
> > If those addresses are really fixed they should have been added to DT,
> > in order for all fixed I2C addresses used on an I2C bus to be reported
> > in DT. I guess it's too late now :-/ This seems to be the best we can do
> > to solve the problem with existing DT. Updating the bindings could
> > however still be a good idea to make this clear moving forward.
> 
> One thing to be aware of is that these addresses are actually divided by
> two in order to get the real i2c address.
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/bridge/analogix-anx78xx.c#L1353
> 
> I'm not sure why the addresses are represented this way but downstream
> does this as well. If I recall correctly, 0x77 is the maximum i2c
> address on a bus, and there's a 0x80 above.

Sure, the addresses in DT would be half of the above values :-)

> >>  struct anx78xx_platform_data {
> >> @@ -1348,6 +1356,7 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
> >>  	struct anx78xx *anx78xx;
> >>  	struct anx78xx_platform_data *pdata;
> >>  	unsigned int i, idl, idh, version;
> >> +	const u8 *i2c_addresses;
> >>  	bool found = false;
> >>  	int err;
> >>  
> >> @@ -1387,15 +1396,16 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
> >>  	}
> >>  
> >>  	/* Map slave addresses of ANX7814 */
> >> +	i2c_addresses = device_get_match_data(&client->dev);
> >>  	for (i = 0; i < I2C_NUM_ADDRESSES; i++) {
> >>  		struct i2c_client *i2c_dummy;
> >>  
> >>  		i2c_dummy = i2c_new_dummy_device(client->adapter,
> >> -						 anx78xx_i2c_addresses[i] >> 1);
> >> +						 i2c_addresses[i] >> 1);
> >>  		if (IS_ERR(i2c_dummy)) {
> >>  			err = PTR_ERR(i2c_dummy);
> >>  			DRM_ERROR("Failed to reserve I2C bus %02x: %d\n",
> >> -				  anx78xx_i2c_addresses[i], err);
> >> +				  i2c_addresses[i], err);
> >>  			goto err_unregister_i2c;
> >>  		}
> >>  
> >> @@ -1405,7 +1415,7 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
> >>  		if (IS_ERR(anx78xx->map[i])) {
> >>  			err = PTR_ERR(anx78xx->map[i]);
> >>  			DRM_ERROR("Failed regmap initialization %02x\n",
> >> -				  anx78xx_i2c_addresses[i]);
> >> +				  i2c_addresses[i]);
> >>  			goto err_unregister_i2c;
> >>  		}
> >>  	}
> >> @@ -1504,10 +1514,10 @@ MODULE_DEVICE_TABLE(i2c, anx78xx_id);
> >>  
> >>  #if IS_ENABLED(CONFIG_OF)
> >>  static const struct of_device_id anx78xx_match_table[] = {
> >> -	{ .compatible = "analogix,anx7808", },
> >> -	{ .compatible = "analogix,anx7812", },
> >> -	{ .compatible = "analogix,anx7814", },
> >> -	{ .compatible = "analogix,anx7818", },
> >> +	{ .compatible = "analogix,anx7808", .data = anx7808_i2c_addresses },
> >> +	{ .compatible = "analogix,anx7812", .data = anx781x_i2c_addresses },
> >> +	{ .compatible = "analogix,anx7814", .data = anx781x_i2c_addresses },
> >> +	{ .compatible = "analogix,anx7818", .data = anx781x_i2c_addresses },
> >>  	{ /* sentinel */ },
> >>  };
> >>  MODULE_DEVICE_TABLE(of, anx78xx_match_table);
> >> diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.h b/drivers/gpu/drm/bridge/analogix-anx78xx.h
> >> index 25e063bcecbc..8697647709f7 100644
> >> --- a/drivers/gpu/drm/bridge/analogix-anx78xx.h
> >> +++ b/drivers/gpu/drm/bridge/analogix-anx78xx.h
> >> @@ -6,13 +6,6 @@
> >>  #ifndef __ANX78xx_H
> >>  #define __ANX78xx_H
> >>  
> >> -#define TX_P0				0x70
> >> -#define TX_P1				0x7a
> >> -#define TX_P2				0x72
> >> -
> >> -#define RX_P0				0x7e
> >> -#define RX_P1				0x80
> >> -
> >>  /***************************************************************/
> >>  /* Register definition of device address 0x7e                  */
> >>  /***************************************************************/
> > 
> > Should you also rename the headers to mention [RT]X P[012] instead of
> > the numerical addresses ?
> 
> Have #defines for ANX781X_TX_P0, ANX7808_TX_P0, etc in the header file?

No, I mean

-/* Register definition of device address 0x7e                  */
+/* Register definitions for RX P0                              */

or something similar (I'm not sure what P0 means).

> > Apart from that,
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
