Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F5CC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD972080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfFZPdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 11:33:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37694 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZPdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 11:33:06 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id ED64C28528D
Message-ID: <7a205885f0599f04da067a7f41a14ee0b0d759f5.camel@collabora.com>
Subject: Re: [PATCH v2] phy: rockchip-inno-usb2: allow to force the B-Device
 Session Valid bit.
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     =?ISO-8859-1?Q?Ga=EBl?= PORTAY <gael.portay@collabora.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        kernel@collabora.com
Date:   Wed, 26 Jun 2019 12:32:55 -0300
In-Reply-To: <20190515222050.15075-1-gael.portay@collabora.com>
References: <20190515222050.15075-1-gael.portay@collabora.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-15 at 18:20 -0400, Gaël PORTAY wrote:
> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> The OTG disconnection event is generated after the presence/absence of
> an ID connection, but some platforms don't have the ID pin connected, so
> the event is not generated. In such case, for detecting the
> disconnection event, we can get the cable state from an extcon driver.
> We need, though, to force to set the B-Device Session Valid bit on the
> PHY to have the device respond to the setup address. Otherwise, the
> following error is shown:
> 
>     usb 2-2: Device not responding to setup address.
>     usb 2-2: device not accepting address 14, error -71
>     usb usb2-port2: unable to enumerate USB device
> 
> The patch tells the PHY to force the B-Device Session Valid bit when the
> OTG role is device and clear that bit if the OTG role is host, when an
> extcon is available.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
> ---
> 
> Hi all,
> 
> The main purpose of this patch is have the Type-C port on the Samsung
> Chromebook Plus work as a device or in OTG mode.
> 
> That patch was originally a part of that patchset[1]; all other patches
> was merged recently in master.
> 
> The patch was tested on a Samsung Chromebook Plus by configuring one
> port to work as device, configure a cdc ethernet gadget and communicate
> via ethernet gadget my workstation with the chromebook through a usb-a
> to type-c cable.
> 
> Best regards,
> Gaël
> 
> [1]: https://lkml.org/lkml/2018/8/15/141
> 
> Changes since v1:
>  - [PATCH 3/4] Remove introduction of dt property "rockchip,force-bvalid"
>                and replace cable state using extcon instead (if set).
> 
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index ba07121c3eff..5e9d50b5ae16 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -125,6 +125,7 @@ struct rockchip_chg_det_reg {
>   * @bvalid_det_en: vbus valid rise detection enable register.
>   * @bvalid_det_st: vbus valid rise detection status register.
>   * @bvalid_det_clr: vbus valid rise detection clear register.
> + * @bvalid_session: force B-device session valid register.
>   * @ls_det_en: linestate detection enable register.
>   * @ls_det_st: linestate detection state register.
>   * @ls_det_clr: linestate detection clear register.
> @@ -138,6 +139,7 @@ struct rockchip_usb2phy_port_cfg {
>  	struct usb2phy_reg	bvalid_det_en;
>  	struct usb2phy_reg	bvalid_det_st;
>  	struct usb2phy_reg	bvalid_det_clr;
> +	struct usb2phy_reg	bvalid_session;
>  	struct usb2phy_reg	ls_det_en;
>  	struct usb2phy_reg	ls_det_st;
>  	struct usb2phy_reg	ls_det_clr;
> @@ -169,6 +171,7 @@ struct rockchip_usb2phy_cfg {
>   * @port_id: flag for otg port or host port.
>   * @suspended: phy suspended flag.
>   * @vbus_attached: otg device vbus status.
> + * @force_bvalid: force the control of the B-device session valid bit.
>   * @bvalid_irq: IRQ number assigned for vbus valid rise detection.
>   * @ls_irq: IRQ number assigned for linestate detection.
>   * @otg_mux_irq: IRQ number which multiplex otg-id/otg-bvalid/linestate
> @@ -187,6 +190,7 @@ struct rockchip_usb2phy_port {
>  	unsigned int	port_id;
>  	bool		suspended;
>  	bool		vbus_attached;
> +	bool		force_bvalid;
>  	int		bvalid_irq;
>  	int		ls_irq;
>  	int		otg_mux_irq;
> @@ -553,6 +557,13 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
>  	switch (rport->state) {
>  	case OTG_STATE_UNDEFINED:
>  		rport->state = OTG_STATE_B_IDLE;
> +		if (rport->force_bvalid) {
> +			property_enable(rphy->grf,
> +					&rport->port_cfg->bvalid_session,
> +					true);
> +			dev_dbg(&rport->phy->dev,
> +				"set the B-Device Session Valid\n");
> +		}
>  		if (!vbus_attach)
>  			rockchip_usb2phy_power_off(rport->phy);
>  		/* fall through */
> @@ -560,6 +571,14 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
>  		if (extcon_get_state(rphy->edev, EXTCON_USB_HOST) > 0) {
>  			dev_dbg(&rport->phy->dev, "usb otg host connect\n");
>  			rport->state = OTG_STATE_A_HOST;
> +			/* When leaving device mode force end the session */
> +			if (rport->force_bvalid) {
> +				property_enable(rphy->grf,
> +					&rport->port_cfg->bvalid_session,
> +					false);
> +				dev_dbg(&rport->phy->dev,
> +					"clear the B-Device Session Valid\n");
> +			}
>  			rockchip_usb2phy_power_on(rport->phy);
>  			return;
>  		} else if (vbus_attach) {
> @@ -634,6 +653,14 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
>  		if (extcon_get_state(rphy->edev, EXTCON_USB_HOST) == 0) {
>  			dev_dbg(&rport->phy->dev, "usb otg host disconnect\n");
>  			rport->state = OTG_STATE_B_IDLE;
> +			/* When leaving host mode force start the session */
> +			if (rport->force_bvalid) {
> +				property_enable(rphy->grf,
> +					&rport->port_cfg->bvalid_session,
> +					true);
> +				dev_dbg(&rport->phy->dev,
> +					"set the B-Device Session Valid\n");
> +			}
>  			rockchip_usb2phy_power_off(rport->phy);
>  		}
>  		break;
> @@ -1016,6 +1043,28 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
>  	INIT_DELAYED_WORK(&rport->chg_work, rockchip_chg_detect_work);
>  	INIT_DELAYED_WORK(&rport->otg_sm_work, rockchip_usb2phy_otg_sm_work);
>  
> +	/*
> +	 * Some platforms doesn't have the ID pin connected to the phy, hence
> +	 * the OTD ID event is not generated, but in some cases we can get the
> +	 * cable state from an extcon driver. In such case we can force to set
> +	 * the B-Device Session Valid bit on the PHY to have the device working
> +	 * as a OTG.
> +	 */
> +	if (rphy->edev) {
> +		/*
> +		 * Check if bvalid_session register is set in the structure
> +		 * rockchip_usb2phy_cfg for this SoC.
> +		 */
> +		if (rport->port_cfg->bvalid_session.offset == 0x0) {
> +			rport->force_bvalid = false;
> +			dev_err(rphy->dev,
> +				"cannot force B-device session, the register is not set for that SoC\n");
> +		} else {
> +			rport->force_bvalid = true;
> +			dev_info(rphy->dev, "force B-device session enabled\n");
> +		}
> +	}
> +
>  	/*
>  	 * Some SoCs use one interrupt with otg-id/otg-bvalid/linestate
>  	 * interrupts muxed together, so probe the otg-mux interrupt first,
> @@ -1338,6 +1387,7 @@ static const struct rockchip_usb2phy_cfg rk3399_phy_cfgs[] = {
>  				.bvalid_det_en	= { 0xe3c0, 3, 3, 0, 1 },
>  				.bvalid_det_st	= { 0xe3e0, 3, 3, 0, 1 },
>  				.bvalid_det_clr	= { 0xe3d0, 3, 3, 0, 1 },
> +				.bvalid_session = { 0x4498, 4, 4, 0, 1 },
>  				.utmi_avalid	= { 0xe2ac, 7, 7, 0, 1 },
>  				.utmi_bvalid	= { 0xe2ac, 12, 12, 0, 1 },
>  			},
> @@ -1373,6 +1423,7 @@ static const struct rockchip_usb2phy_cfg rk3399_phy_cfgs[] = {
>  				.bvalid_det_en  = { 0xe3c0, 8, 8, 0, 1 },
>  				.bvalid_det_st  = { 0xe3e0, 8, 8, 0, 1 },
>  				.bvalid_det_clr = { 0xe3d0, 8, 8, 0, 1 },
> +				.bvalid_session = { 0x4518, 4, 4, 0, 1 },
>  				.utmi_avalid	= { 0xe2ac, 10, 10, 0, 1 },
>  				.utmi_bvalid    = { 0xe2ac, 16, 16, 0, 1 },
>  			},
> -- 
> 2.21.0
> 
> 

It's been more than a month without any activity here.

Any news?

Thanks,
Ezequiel


