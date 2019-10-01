Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7659ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F98D21924
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569933493;
	bh=RP+vRkvxXXi+nz/MV7q6juabjTRuWT6mrhD2UR8v/8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iZZ2XCV3HtDSTh6ntkaAB8WAwmyE1sxrJOIbToUqOfi6X2HDm/EOtqptJolAgUUdb
	 sorhs5/YaWdGrNBF3GFMW+uYu81NqEgr0xBq7t0tVbA74fzYYZCBsSGCxzxPYEF80P
	 UCWveoLRTAjYCyQ7A1H3kH4DtRFDXw5mzEY4Lpd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbfJAMiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:38:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfJAMiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:38:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2C6121920;
        Tue,  1 Oct 2019 12:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569933491;
        bh=RP+vRkvxXXi+nz/MV7q6juabjTRuWT6mrhD2UR8v/8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JEO7CUi5tr2iA3WvDbwoongsf0mgcRS+4ufxh3PtcwYNdz8XQVjP4dVCQP3/gd2DY
         3VpownEzZ6GT06OALB/2nbrUuGbX+tgPKTkt8R4kOB5eFXez8e642tZOTjWL/pOPQX
         tiiZPWhqNyi8qlDEvGqe7o1b7yrif2MvalTNT+eM=
Date:   Tue, 1 Oct 2019 14:38:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-usb@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Lukas Wunner <lukas@wunner.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 06/22] thunderbolt: Add support for lane bonding
Message-ID: <20191001123808.GA2954373@kroah.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-7-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001113830.13028-7-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 02:38:14PM +0300, Mika Westerberg wrote:
> Lane bonding allows aggregating the two 10/20 Gb/s (depending on the
> generation) lanes into a single 20/40 Gb/s bonded link. This allows
> sharing the full bandwidth more efficiently. In order to establish lane
> bonding we need to check that the lane bonding is possible through LC
> and that both end of the link actually supports 2x widths. This also
> means that all the paths should be established through the primary port
> so update tb_path_alloc() to handle this as well.
> 
> Lane bonding is supported starting from Falcon Ridge (2nd generation)
> controllers.

Are we only going to be allowed to "bond" two links together?  Or will
we be doing more than 2 in the future?  If more, then we might want to
think of a different way to specify these...

Anyway, one tiny nit below:

> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  .../ABI/testing/sysfs-bus-thunderbolt         |  17 ++
>  drivers/thunderbolt/icm.c                     |  18 +-
>  drivers/thunderbolt/lc.c                      |  28 ++
>  drivers/thunderbolt/path.c                    |  30 +-
>  drivers/thunderbolt/switch.c                  | 274 ++++++++++++++++++
>  drivers/thunderbolt/tb.c                      |  21 ++
>  drivers/thunderbolt/tb.h                      |  10 +
>  drivers/thunderbolt/tb_msgs.h                 |   2 +
>  drivers/thunderbolt/tb_regs.h                 |  20 ++
>  drivers/thunderbolt/tunnel.c                  |  19 +-
>  10 files changed, 429 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt b/Documentation/ABI/testing/sysfs-bus-thunderbolt
> index b21fba14689b..2c9166f6fa97 100644
> --- a/Documentation/ABI/testing/sysfs-bus-thunderbolt
> +++ b/Documentation/ABI/testing/sysfs-bus-thunderbolt
> @@ -104,6 +104,23 @@ Contact:	thunderbolt-software@lists.01.org
>  Description:	This attribute contains name of this device extracted from
>  		the device DROM.
>  
> +What:		/sys/bus/thunderbolt/devices/.../link_speed
> +Date:		Apr 2020
> +KernelVersion:	5.6
> +Contact:	Mika Westerberg <mika.westerberg@linux.intel.com>
> +Description:	This attribute reports the current upstream link speed
> +		in Gb/s per lane. If there are two lanes they both are
> +		running at the same speed. Use link_width to determine
> +		whether the two lanes are bonded or not.
> +
> +What:		/sys/bus/thunderbolt/devices/.../link_width
> +Date:		Apr 2020
> +KernelVersion:	5.6
> +Contact:	Mika Westerberg <mika.westerberg@linux.intel.com>
> +Description:	This attribute reports the current upstream link width.
> +		It is 1 for single lane link (or two single lane links)
> +		and 2 for bonded dual lane link.
> +
>  What:		/sys/bus/thunderbolt/devices/.../vendor
>  Date:		Sep 2017
>  KernelVersion:	4.13
> diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
> index 6550f68f92ce..9c9c6ea2b790 100644
> --- a/drivers/thunderbolt/icm.c
> +++ b/drivers/thunderbolt/icm.c
> @@ -567,7 +567,8 @@ static struct tb_switch *add_switch(struct tb_switch *parent_sw, u64 route,
>  				    size_t ep_name_size, u8 connection_id,
>  				    u8 connection_key, u8 link, u8 depth,
>  				    enum tb_security_level security_level,
> -				    bool authorized, bool boot)
> +				    bool authorized, bool boot, bool dual_lane,
> +				    bool speed_gen3)

That's just a crazy amount of function parameters, with no way of
remembering what is what, especially when you add 2 more booleans at the
end.

It's your code, but ugh, that's going to be hard to maintain over time
:(

>  {
>  	const struct intel_vss *vss;
>  	struct tb_switch *sw;
> @@ -592,6 +593,8 @@ static struct tb_switch *add_switch(struct tb_switch *parent_sw, u64 route,
>  	sw->authorized = authorized;
>  	sw->security_level = security_level;
>  	sw->boot = boot;
> +	sw->link_speed = speed_gen3 ? 20 : 10;
> +	sw->link_width = dual_lane ? 2 : 1;
>  	init_completion(&sw->rpm_complete);
>  
>  	vss = parse_intel_vss(ep_name, ep_name_size);
> @@ -697,11 +700,11 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
>  		(const struct icm_fr_event_device_connected *)hdr;
>  	enum tb_security_level security_level;
>  	struct tb_switch *sw, *parent_sw;
> +	bool boot, dual_lane, speed_gen3;
>  	struct icm *icm = tb_priv(tb);
>  	bool authorized = false;
>  	struct tb_xdomain *xd;
>  	u8 link, depth;
> -	bool boot;
>  	u64 route;
>  	int ret;
>  
> @@ -714,6 +717,8 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
>  	security_level = (pkg->hdr.flags & ICM_FLAGS_SLEVEL_MASK) >>
>  			 ICM_FLAGS_SLEVEL_SHIFT;
>  	boot = pkg->link_info & ICM_LINK_INFO_BOOT;
> +	dual_lane = pkg->hdr.flags & ICM_FLAGS_DUAL_LANE;
> +	speed_gen3 = pkg->hdr.flags & ICM_FLAGS_SPEED_GEN3;
>  
>  	if (pkg->link_info & ICM_LINK_INFO_REJECTED) {
>  		tb_info(tb, "switch at %u.%u was rejected by ICM firmware because topology limit exceeded\n",
> @@ -814,7 +819,7 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
>  	add_switch(parent_sw, route, &pkg->ep_uuid, (const u8 *)pkg->ep_name,
>  		   sizeof(pkg->ep_name), pkg->connection_id,
>  		   pkg->connection_key, link, depth, security_level,
> -		   authorized, boot);
> +		   authorized, boot, dual_lane, speed_gen3);
>  
>  	tb_switch_put(parent_sw);
>  }
> @@ -1142,10 +1147,10 @@ __icm_tr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr,
>  {
>  	const struct icm_tr_event_device_connected *pkg =
>  		(const struct icm_tr_event_device_connected *)hdr;
> +	bool authorized, boot, dual_lane, speed_gen3;
>  	enum tb_security_level security_level;
>  	struct tb_switch *sw, *parent_sw;
>  	struct tb_xdomain *xd;
> -	bool authorized, boot;
>  	u64 route;
>  
>  	icm_postpone_rescan(tb);
> @@ -1163,6 +1168,8 @@ __icm_tr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr,
>  	security_level = (pkg->hdr.flags & ICM_FLAGS_SLEVEL_MASK) >>
>  			 ICM_FLAGS_SLEVEL_SHIFT;
>  	boot = pkg->link_info & ICM_LINK_INFO_BOOT;
> +	dual_lane = pkg->hdr.flags & ICM_FLAGS_DUAL_LANE;
> +	speed_gen3 = pkg->hdr.flags & ICM_FLAGS_SPEED_GEN3;
>  
>  	if (pkg->link_info & ICM_LINK_INFO_REJECTED) {
>  		tb_info(tb, "switch at %llx was rejected by ICM firmware because topology limit exceeded\n",
> @@ -1207,7 +1214,8 @@ __icm_tr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr,
>  
>  	sw = add_switch(parent_sw, route, &pkg->ep_uuid, (const u8 *)pkg->ep_name,
>  			sizeof(pkg->ep_name), pkg->connection_id, 0, 0, 0,
> -			security_level, authorized, boot);
> +			security_level, authorized, boot, dual_lane,
> +			speed_gen3);
>  	if (!IS_ERR(sw) && force_rtd3)
>  		sw->rpm = true;
>  
> diff --git a/drivers/thunderbolt/lc.c b/drivers/thunderbolt/lc.c
> index af38076088f6..df56523eb822 100644
> --- a/drivers/thunderbolt/lc.c
> +++ b/drivers/thunderbolt/lc.c
> @@ -177,3 +177,31 @@ int tb_lc_set_sleep(struct tb_switch *sw)
>  
>  	return 0;
>  }
> +
> +/**
> + * tb_lc_lane_bonding_possible() - Is lane bonding possible towards switch
> + * @sw: Switch to check
> + *
> + * Checks whether conditions for lane bonding from parent to @sw are
> + * possible.
> + */
> +bool tb_lc_lane_bonding_possible(struct tb_switch *sw)
> +{
> +	struct tb_port *up;
> +	int cap, ret;
> +	u32 val;
> +
> +	if (sw->generation < 2)
> +		return false;
> +
> +	up = tb_upstream_port(sw);
> +	cap = find_port_lc_cap(up);
> +	if (cap < 0)
> +		return false;
> +
> +	ret = tb_sw_read(sw, &val, TB_CFG_SWITCH, cap + TB_LC_PORT_ATTR, 1);
> +	if (ret)
> +		return false;
> +
> +	return !!(val & TB_LC_PORT_ATTR_BE);
> +}
> diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
> index afe5f8391ebf..6cf66597d5d8 100644
> --- a/drivers/thunderbolt/path.c
> +++ b/drivers/thunderbolt/path.c
> @@ -220,7 +220,8 @@ struct tb_path *tb_path_discover(struct tb_port *src, int src_hopid,
>   * Creates path between two ports starting with given @src_hopid. Reserves
>   * HopIDs for each port (they can be different from @src_hopid depending on
>   * how many HopIDs each port already have reserved). If there are dual
> - * links on the path, prioritizes using @link_nr.
> + * links on the path, prioritizes using @link_nr but takes into account
> + * that the lanes may be bonded.
>   *
>   * Return: Returns a tb_path on success or NULL on failure.
>   */
> @@ -259,7 +260,9 @@ struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
>  		if (!in_port)
>  			goto err;
>  
> -		if (in_port->dual_link_port && in_port->link_nr != link_nr)
> +		/* When lanes are bonded primary link must be used */
> +		if (!in_port->bonded && in_port->dual_link_port &&
> +		    in_port->link_nr != link_nr)
>  			in_port = in_port->dual_link_port;
>  
>  		ret = tb_port_alloc_in_hopid(in_port, in_hopid, in_hopid);
> @@ -271,8 +274,27 @@ struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
>  		if (!out_port)
>  			goto err;
>  
> -		if (out_port->dual_link_port && out_port->link_nr != link_nr)
> -			out_port = out_port->dual_link_port;
> +		/*
> +		 * Pick up right port when going from non-bonded to
> +		 * bonded or from bonded to non-bonded.
> +		 */
> +		if (out_port->dual_link_port) {
> +			if (!in_port->bonded && out_port->bonded &&
> +			    out_port->link_nr) {
> +				/*
> +				 * Use primary link when going from
> +				 * non-bonded to bonded.
> +				 */
> +				out_port = out_port->dual_link_port;
> +			} else if (!out_port->bonded &&
> +				   out_port->link_nr != link_nr) {
> +				/*
> +				 * If out port is not bonded follow
> +				 * link_nr.
> +				 */
> +				out_port = out_port->dual_link_port;
> +			}
> +		}
>  
>  		if (i == num_hops - 1)
>  			ret = tb_port_alloc_out_hopid(out_port, dst_hopid,
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index cc2670dd2698..2b00ea7a979a 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -775,6 +775,132 @@ struct tb_port *tb_next_port_on_path(struct tb_port *start, struct tb_port *end,
>  	return next;
>  }
>  
> +static int tb_port_get_link_speed(struct tb_port *port)
> +{
> +	u32 val, speed;
> +	int ret;
> +
> +	if (!port->cap_phy)
> +		return -EINVAL;
> +
> +	ret = tb_port_read(port, &val, TB_CFG_PORT,
> +			   port->cap_phy + LANE_ADP_CS_1, 1);
> +	if (ret)
> +		return ret;
> +
> +	speed = (val & LANE_ADP_CS_1_CURRENT_SPEED_MASK) >>
> +		LANE_ADP_CS_1_CURRENT_SPEED_SHIFT;
> +	return speed == LANE_ADP_CS_1_CURRENT_SPEED_GEN3 ? 20 : 10;
> +}
> +
> +static int tb_port_get_link_width(struct tb_port *port)
> +{
> +	u32 val;
> +	int ret;
> +
> +	if (!port->cap_phy)
> +		return -EINVAL;
> +
> +	ret = tb_port_read(port, &val, TB_CFG_PORT,
> +			   port->cap_phy + LANE_ADP_CS_1, 1);
> +	if (ret)
> +		return ret;
> +
> +	return (val & LANE_ADP_CS_1_CURRENT_WIDTH_MASK) >>
> +		LANE_ADP_CS_1_CURRENT_WIDTH_SHIFT;
> +}
> +
> +static bool tb_port_is_width_supported(struct tb_port *port, int width)
> +{
> +	u32 phy, widths;
> +	int ret;
> +
> +	if (!port->cap_phy)
> +		return false;
> +
> +	ret = tb_port_read(port, &phy, TB_CFG_PORT,
> +			   port->cap_phy + LANE_ADP_CS_0, 1);
> +	if (ret)
> +		return ret;
> +
> +	widths = (phy & LANE_ADP_CS_0_SUPPORTED_WIDTH_MASK) >>
> +		LANE_ADP_CS_0_SUPPORTED_WIDTH_SHIFT;
> +
> +	return !!(widths & width);
> +}
> +
> +static int tb_port_set_link_width(struct tb_port *port, unsigned int width)
> +{
> +	u32 val;
> +	int ret;
> +
> +	if (!port->cap_phy)
> +		return -EINVAL;
> +
> +	ret = tb_port_read(port, &val, TB_CFG_PORT,
> +			   port->cap_phy + LANE_ADP_CS_1, 1);
> +	if (ret)
> +		return ret;
> +
> +	val &= ~LANE_ADP_CS_1_TARGET_WIDTH_MASK;
> +	switch (width) {
> +	case 1:
> +		val |= LANE_ADP_CS_1_TARGET_WIDTH_SINGLE <<
> +			LANE_ADP_CS_1_TARGET_WIDTH_SHIFT;
> +		break;
> +	case 2:
> +		val |= LANE_ADP_CS_1_TARGET_WIDTH_DUAL <<
> +			LANE_ADP_CS_1_TARGET_WIDTH_SHIFT;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	val |= LANE_ADP_CS_1_LB;
> +
> +	return tb_port_write(port, &val, TB_CFG_PORT,
> +			     port->cap_phy + LANE_ADP_CS_1, 1);
> +}
> +
> +static int tb_port_lane_bonding_enable(struct tb_port *port)
> +{
> +	int ret;
> +
> +	/*
> +	 * Enable lane bonding for both links if not already enabled by
> +	 * for example the boot firmware.
> +	 */
> +	ret = tb_port_get_link_width(port);
> +	if (ret == 1) {
> +		ret = tb_port_set_link_width(port, 2);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = tb_port_get_link_width(port->dual_link_port);
> +	if (ret == 1) {
> +		ret = tb_port_set_link_width(port->dual_link_port, 2);
> +		if (ret) {
> +			tb_port_set_link_width(port, 1);
> +			return ret;
> +		}
> +	}
> +
> +	port->bonded = true;
> +	port->dual_link_port->bonded = true;
> +
> +	return 0;
> +}
> +
> +static void tb_port_lane_bonding_disable(struct tb_port *port)
> +{
> +	port->dual_link_port->bonded = false;
> +	port->bonded = false;
> +
> +	tb_port_set_link_width(port->dual_link_port, 1);
> +	tb_port_set_link_width(port, 1);
> +}
> +
>  /**
>   * tb_port_is_enabled() - Is the adapter port enabled
>   * @port: Port to check
> @@ -1166,6 +1292,26 @@ static ssize_t key_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR(key, 0600, key_show, key_store);
>  
> +static ssize_t link_speed_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct tb_switch *sw = tb_to_switch(dev);
> +
> +	return sprintf(buf, "%u.0 Gb/s\n", sw->link_speed);

Why units?  ".0" is implied as it always will be the case, so why not
just have the units be Gb in the sysfs documentation file and then just
report link_speed here with nothing else?  Makes it much easier for
userspace to parse as well.

Otherwise, looks sane to me, nice job.

greg k-h
