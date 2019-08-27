Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223E0C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1F3217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jnY2BHM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733100AbfH0IG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:06:59 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:40246 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732698AbfH0IGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:06:54 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1B3BA2F0;
        Tue, 27 Aug 2019 10:06:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1566893211;
        bh=TYzbvq3HQyXQCy+chmc0kIiEPmcvqNHWM1+j+bH3U2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jnY2BHM7PMYTJCBh0Qj2WCNKLN2BVE3olRJ7v3X/4eezUfgdPOKGFbCpxjmsa4Z1G
         6D38H1w0UBpfMoGTNmBHDMXi2TOjZenZ5O/4j4+E+Qn1DFawwh48Ybbvf23XI9mfDP
         68E1IVgiLl+W+7yP8E1X3xQwSvbBP0onhQ+dWtlA=
Date:   Tue, 27 Aug 2019 11:06:44 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/bridge: tc358767: Expose test mode functionality via
 debugfs
Message-ID: <20190827080644.GF5054@pendragon.ideasonboard.com>
References: <20190826182524.5064-1-andrew.smirnov@gmail.com>
 <20190826220807.GK5031@pendragon.ideasonboard.com>
 <CAHQ1cqHuJNTH=HDfEP9de0Df_D45VV034riH4J3+ix23v=aM4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHQ1cqHuJNTH=HDfEP9de0Df_D45VV034riH4J3+ix23v=aM4Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Mon, Aug 26, 2019 at 09:24:57PM -0700, Andrey Smirnov wrote:
> On Mon, Aug 26, 2019 at 3:08 PM Laurent Pinchart wrote:
> > On Mon, Aug 26, 2019 at 11:25:24AM -0700, Andrey Smirnov wrote:
> > > Presently, the driver code artificially limits test pattern mode to a
> > > single pattern with fixed color selection. It being a kernel module
> > > parameter makes switching "test patter" <-> "proper output" modes
> > > on-the-fly clunky and outright impossible if the driver is built into
> > > the kernel.
> > >
> > > To improve the situation a bit, convert current test pattern code to
> > > use debugfs instead by exposing "TestCtl" register. This way old
> > > "tc_test_pattern=1" functionality can be emulated via:
> > >
> > >     echo -n 0x78146312 > tstctl
> > >
> > > and switch back to regular mode can be done with:
> > >
> > >     echo -n 0x78146310 > tstctl
> >
> > Can't we make this more userfriendly by exposing either a test pattern
> > index, or a string ?
> 
> We could, but then a) it would require more code in the driver b) the
> files wouldn't correspond directly to something described in the
> part's datasheet. Just didn't seem worth it to me.

Could you then provide me with the datasheet ? :-) The whole point of a
driver is to avoid needing detailed knowledge of the device's internals
in userspace.

> > Do all bits in the register need to be controlled
> > from userspace ?
> 
> Pretty much, yes. It's formatted as RR_GG_BB_X_M, where R, G, B
> specifies color used for various patterns, X is irrelevant and M
> specifies test pattern to use.
> 
> > > Note that switching to any of the test patterns, will NOT trigger link
> > > re-establishment whereas switching to normal operation WILL. This is
> > > done so:
> > >
> > > a) we can isolate and verify (e)DP link functionality by switching to
> > >    one of the test patters
> > >
> > > b) trigger a link re-establishment by switching back to normal mode
> > >
> > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > > Cc: Andrzej Hajda <a.hajda@samsung.com>
> > > Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> > > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > > Cc: Cory Tusar <cory.tusar@zii.aero>
> > > Cc: Chris Healy <cphealy@gmail.com>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: linux-kernel@vger.kernel.org
> > > ---
> > >  drivers/gpu/drm/bridge/tc358767.c | 137 ++++++++++++++++++++++--------
> > >  1 file changed, 101 insertions(+), 36 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> > > index 6308d93ad91d..7a795b613ed0 100644
> > > --- a/drivers/gpu/drm/bridge/tc358767.c
> > > +++ b/drivers/gpu/drm/bridge/tc358767.c
> > > @@ -17,6 +17,7 @@
> > >
> > >  #include <linux/bitfield.h>
> > >  #include <linux/clk.h>
> > > +#include <linux/debugfs.h>
> > >  #include <linux/device.h>
> > >  #include <linux/gpio/consumer.h>
> > >  #include <linux/i2c.h>
> > > @@ -222,11 +223,10 @@
> > >  #define COLOR_B                      GENMASK(15, 8)
> > >  #define ENI2CFILTER          BIT(4)
> > >  #define COLOR_BAR_MODE               GENMASK(1, 0)
> > > +#define COLOR_BAR_MODE_NORMAL        0
> > >  #define COLOR_BAR_MODE_BARS  2
> > > -#define PLL_DBG                      0x0a04
> > >
> > > -static bool tc_test_pattern;
> > > -module_param_named(test, tc_test_pattern, bool, 0644);
> >
> > I assume that his being a debug feature there's no system relying on the
> > module parameter that would break if you remove it ?
> 
> Yeah, I don't know of any system that needs that parameter. It seems
> pretty useless for anything but basic debugging.
> 
> > > +#define PLL_DBG                      0x0a04
> > >
> > >  struct tc_edp_link {
> > >       struct drm_dp_link      base;
> > > @@ -789,16 +789,6 @@ static int tc_set_video_mode(struct tc_data *tc,
> > >       if (ret)
> > >               return ret;
> > >
> > > -     /* Test pattern settings */
> > > -     ret = regmap_write(tc->regmap, TSTCTL,
> > > -                        FIELD_PREP(COLOR_R, 120) |
> > > -                        FIELD_PREP(COLOR_G, 20) |
> > > -                        FIELD_PREP(COLOR_B, 99) |
> > > -                        ENI2CFILTER |
> > > -                        FIELD_PREP(COLOR_BAR_MODE, COLOR_BAR_MODE_BARS));
> > > -     if (ret)
> > > -             return ret;
> > > -
> > >       /* DP Main Stream Attributes */
> > >       vid_sync_dly = hsync_len + left_margin + mode->hdisplay;
> > >       ret = regmap_write(tc->regmap, DP0_VIDSYNCDELAY,
> > > @@ -1150,14 +1140,6 @@ static int tc_stream_enable(struct tc_data *tc)
> > >
> > >       dev_dbg(tc->dev, "enable video stream\n");
> > >
> > > -     /* PXL PLL setup */
> > > -     if (tc_test_pattern) {
> > > -             ret = tc_pxl_pll_en(tc, clk_get_rate(tc->refclk),
> > > -                                 1000 * tc->mode.clock);
> > > -             if (ret)
> > > -                     return ret;
> > > -     }
> > > -
> > >       ret = tc_set_video_mode(tc, &tc->mode);
> > >       if (ret)
> > >               return ret;
> > > @@ -1186,12 +1168,8 @@ static int tc_stream_enable(struct tc_data *tc)
> > >       if (ret)
> > >               return ret;
> > >       /* Set input interface */
> > > -     value = DP0_AUDSRC_NO_INPUT;
> > > -     if (tc_test_pattern)
> > > -             value |= DP0_VIDSRC_COLOR_BAR;
> > > -     else
> > > -             value |= DP0_VIDSRC_DPI_RX;
> > > -     ret = regmap_write(tc->regmap, SYSCTRL, value);
> > > +     ret = regmap_write(tc->regmap, SYSCTRL,
> > > +                        DP0_AUDSRC_NO_INPUT | DP0_VIDSRC_DPI_RX);
> > >       if (ret)
> > >               return ret;
> > >
> > > @@ -1220,39 +1198,44 @@ static void tc_bridge_pre_enable(struct drm_bridge *bridge)
> > >       drm_panel_prepare(tc->panel);
> > >  }
> > >
> > > -static void tc_bridge_enable(struct drm_bridge *bridge)
> > > +static int __tc_bridge_enable(struct tc_data *tc)
> > >  {
> > > -     struct tc_data *tc = bridge_to_tc(bridge);
> > >       int ret;
> > >
> > >       ret = tc_get_display_props(tc);
> > >       if (ret < 0) {
> > >               dev_err(tc->dev, "failed to read display props: %d\n", ret);
> > > -             return;
> > > +             return ret;
> > >       }
> > >
> > >       ret = tc_main_link_enable(tc);
> > >       if (ret < 0) {
> > >               dev_err(tc->dev, "main link enable error: %d\n", ret);
> > > -             return;
> > > +             return ret;
> > >       }
> > >
> > >       ret = tc_stream_enable(tc);
> > >       if (ret < 0) {
> > >               dev_err(tc->dev, "main link stream start error: %d\n", ret);
> > >               tc_main_link_disable(tc);
> > > -             return;
> > >       }
> > >
> > > -     drm_panel_enable(tc->panel);
> > > +     return ret;
> > >  }
> > >
> > > -static void tc_bridge_disable(struct drm_bridge *bridge)
> > > +static void tc_bridge_enable(struct drm_bridge *bridge)
> > >  {
> > >       struct tc_data *tc = bridge_to_tc(bridge);
> > > -     int ret;
> > >
> > > -     drm_panel_disable(tc->panel);
> > > +     if (__tc_bridge_enable(tc) < 0)
> > > +             return;
> > > +
> > > +     drm_panel_enable(tc->panel);
> > > +}
> > > +
> > > +static int __tc_bridge_disable(struct tc_data *tc)
> > > +{
> > > +     int ret;
> > >
> > >       ret = tc_stream_disable(tc);
> > >       if (ret < 0)
> > > @@ -1261,6 +1244,16 @@ static void tc_bridge_disable(struct drm_bridge *bridge)
> > >       ret = tc_main_link_disable(tc);
> > >       if (ret < 0)
> > >               dev_err(tc->dev, "main link disable error: %d\n", ret);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static void tc_bridge_disable(struct drm_bridge *bridge)
> > > +{
> > > +     struct tc_data *tc = bridge_to_tc(bridge);
> > > +
> > > +     drm_panel_disable(tc->panel);
> > > +     __tc_bridge_disable(tc);
> > >  }
> > >
> > >  static void tc_bridge_post_disable(struct drm_bridge *bridge)
> > > @@ -1372,6 +1365,77 @@ static enum drm_connector_status tc_connector_detect(struct drm_connector *conne
> > >               return connector_status_disconnected;
> > >  }
> > >
> > > +static int tc_tstctl_set(void *data, u64 val)
> > > +{
> > > +     struct tc_data *tc = data;
> > > +     int ret;
> > > +
> > > +     if (FIELD_GET(COLOR_BAR_MODE, val) == COLOR_BAR_MODE_NORMAL) {
> > > +             ret = regmap_write(tc->regmap, SYSCTRL, DP0_VIDSRC_DPI_RX);
> > > +             if (ret) {
> > > +                     dev_err(tc->dev,
> > > +                             "failed to select dpi video stream\n");
> > > +                     return ret;
> > > +             }
> > > +
> > > +             ret = regmap_write(tc->regmap, TSTCTL, val | ENI2CFILTER);
> > > +             if (ret) {
> > > +                     dev_err(tc->dev, "failed to set TSTCTL\n");
> > > +                     return ret;
> > > +             }
> > > +
> > > +             ret = tc_pxl_pll_dis(tc);
> > > +             if (ret) {
> > > +                     dev_err(tc->dev, "failed to disable PLL\n");
> > > +                     return ret;
> > > +             }
> > > +
> > > +             /*
> > > +              * Re-establish DP link
> > > +              */
> > > +             ret = __tc_bridge_disable(tc);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > > +             ret = __tc_bridge_enable(tc);
> > > +             if (ret)
> > > +                     return ret;
> >
> > If the bridge is currently disabled you should not enable it. I think
> > you need to guard against race conditions with the enable/disable
> > functions, as well as delay writes until the bridge gets enabled if it
> > is currently disabled.
> 
> OK, will do in v2.
> 
> > > +     } else {
> > > +             ret = tc_pxl_pll_en(tc, clk_get_rate(tc->refclk),
> > > +                                 1000 * tc->mode.clock);
> > > +             if (ret) {
> > > +                     dev_err(tc->dev, "failed to enable PLL\n");
> > > +                     return ret;
> > > +             }
> > > +
> > > +             ret = regmap_write(tc->regmap, TSTCTL, val | ENI2CFILTER);
> > > +             if (ret) {
> > > +                     dev_err(tc->dev, "failed to set TSTCTL\n");
> > > +                     return ret;
> > > +             }
> > > +
> > > +             ret = regmap_write(tc->regmap, SYSCTRL, DP0_VIDSRC_COLOR_BAR);
> > > +             if (ret) {
> > > +                     dev_err(tc->dev, "failed to color bar video stream\n");
> > > +                     return ret;
> > > +             }
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +DEFINE_SIMPLE_ATTRIBUTE(tc_tstctl_fops, NULL, tc_tstctl_set, "%llu\n");
> >
> > Shouldn't you also provide a get handler ?
> 
> There really isn't a use-case for reading the value of TestCtl AFAICT,
> so, I skipped it to avoid having extra code.
> 
> > > +static int tc_late_register(struct drm_connector *connector)
> > > +{
> > > +     if (connector->debugfs_entry)
> > > +             debugfs_create_file_unsafe("tstctl", 0644,
> > > +                                        connector->debugfs_entry,
> > > +                                        connector_to_tc(connector),
> > > +                                        &tc_tstctl_fops);
> > > +     return 0;
> > > +}
> >
> > Why a .late_register() handler, can't you do this at probe time ?
> 
> .late_register() happens after drm_debugfs_connector_add() where
> connector->debugfs_entry gets initialized. AFAICT, I could move that
> code to probe, but then I'd have create a separate debugfs root
> directory as well as add code to clean it up (currently I rely on
> drm_debugfs_connector_remove() removing everything recursively.

The usual approach for this kind of debug feature is to create a
directory named after dev_name() in order to guarantee uniqueness. I
feel that could be better, but have no strong preference.

-- 
Regards,

Laurent Pinchart
