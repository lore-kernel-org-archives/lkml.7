Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A27CC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C778D2089E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="E9YWSkHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfEHTd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 15:33:28 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:52574 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726992AbfEHTd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 15:33:28 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DF310C00C8;
        Wed,  8 May 2019 19:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557344001; bh=ztFMfhsWk+R9Wqg05l9EntjjEp+UDTLM4bqHuw/HicU=;
        h=From:To:CC:Subject:Date:References:From;
        b=E9YWSkHYcfEHzjDr19V1UHlqsB1jMUU92vbj4SBFN3w6mdfdUTe1Yp9AMiyTo8pLT
         kukhRX7KQFw3ZYj3e9t9C5s9ebmEWcgJG4QfzGNFMPkuIAxYc+3kANB/WZVj8KGEu/
         PKlipMf7Q0P2gmz68uZPs90wJPO5D+u8wm+eyfuDWYebePJ67P/dM3/78Zbc4qUoEJ
         i/QY1TWqgQohx+Smt6Zjw5Z6UVkUedAA3qTuUrcdjBP/axnvRWzKA9moQ+0PExZqY4
         szC5S3xWvLSQY7fKUSzxyLys8yODPyu1hCkBSyoOrj8TzGQ/Enu5Hm0JNP8MlZp2x5
         ma2HxUsqk31tg==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0D4C4A0097;
        Wed,  8 May 2019 19:33:27 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.223]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Wed, 8 May 2019 12:33:26 -0700
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "Claus H. Stovgaard" <cst@phaseone.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>
Subject: Re: [PATCH v2 3/3] usb: dwc3: gadget: Add support for disabling U1
 and U2 entries
Thread-Topic: [PATCH v2 3/3] usb: dwc3: gadget: Add support for disabling U1
 and U2 entries
Thread-Index: AQHVBXNg9QMnfODDx0qS+2/7kcKJQQ==
Date:   Wed, 8 May 2019 19:33:26 +0000
Message-ID: <30102591E157244384E984126FC3CB4F639E9823@us01wembx1.internal.synopsys.com>
References: <1557302091-7455-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1557302091-7455-4-git-send-email-anurag.kumar.vulisha@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.19]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anurag,=0A=
=0A=
Anurag Kumar Vulisha wrote:=0A=
> Gadget applications may have a requirement to disable the U1 and U2=0A=
> entry based on the usecase. Below are few usecases where the disabling=0A=
> U1/U2 entries may be possible.=0A=
>=0A=
> Usecase 1:=0A=
> When combining dwc3 with an redriver for a USB Type-C device solution, it=
=0A=
> sometimes have problems with leaving U1/U2 for certain hosts, resulting i=
n=0A=
> link training errors and reconnects. For this U1/U2 state entries may be=
=0A=
> avoided.=0A=
>=0A=
> Usecase 2:=0A=
> When performing performance benchmarking on mass storage gadget the=0A=
> U1 and U2 entries can be disabled.=0A=
>=0A=
> Usecase 3:=0A=
> When periodic transfers like ISOC transfers are used with bInterval=0A=
> of 1 which doesn't require the link to enter into U1 or U2 state entry=0A=
> (since ping is issued from host for every uframe interval). In this=0A=
> case the U1 and U2 entry can be disabled.=0A=
>=0A=
> Disablement of U1/U2 can be done by setting U1DevExitLat and U2DevExitLat=
=0A=
> values to 0 in the BOS descriptor. Host on seeing 0 value for U1DevExitLa=
t=0A=
> and U2DevExitLat, it doesn't send SET_SEL requests to the gadget. There=
=0A=
> may be some hosts which may send SET_SEL requests even after seeing 0 in=
=0A=
> the UxDevExitLat of BOS descriptor. To aviod U1/U2 entries for these type=
=0A=
> of hosts, dwc3 controller can be programmed to reject those U1/U2 request=
s=0A=
> by not enabling ACCEPTUxENA bits in DCTL register.=0A=
>=0A=
> This patch updates the same.=0A=
>=0A=
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>=0A=
> Signed-off-by: Claus H. Stovgaard <cst@phaseone.com>=0A=
> ---=0A=
>  Changes in v2=0A=
> 	1. As suggested by Thinh Nguyen changed the "snps,dis_u1_entry_quirk"=0A=
> 	   to "snps,dis-u1-entry-quirk"=0A=
> 	2. Merged the changes done by Claus H. Stovgaard in ep0.c for rejecting=
=0A=
> 	   U1/U2 requests into this patch. Changes done by Claus can be found=0A=
> 	   here https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__marc.info=
_-3Fl-3Dlinux-2Dkernel-26m-3D155722068820568-26w-3D2&d=3DDwIBAg&c=3DDPL6_X_=
6JkXFx7AXWqB0tg&r=3Du9FYoxKtyhjrGFcyixFYqTjw1ZX0VsG2d8FCmzkTY-w&m=3DdJMdvub=
LsepuGRDdkLZNJ00bhu52jPV7TZaFkDGD0Vs&s=3DwT7eyWpRKPAqXmLfdfiArbnZ7vE9Vi8DOf=
RdULmeIqY&e=3D=0A=
> 	3. Changed the commit message.=0A=
> ---=0A=
>  drivers/usb/dwc3/core.c   |  4 ++++=0A=
>  drivers/usb/dwc3/core.h   |  4 ++++=0A=
>  drivers/usb/dwc3/ep0.c    |  9 ++++++++-=0A=
>  drivers/usb/dwc3/gadget.c | 19 +++++++++++++++++++=0A=
>  drivers/usb/dwc3/gadget.h |  6 ++++++=0A=
>  5 files changed, 41 insertions(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c=0A=
> index a1b126f..180239b 100644=0A=
> --- a/drivers/usb/dwc3/core.c=0A=
> +++ b/drivers/usb/dwc3/core.c=0A=
> @@ -1285,6 +1285,10 @@ static void dwc3_get_properties(struct dwc3 *dwc)=
=0A=
>  				"snps,dis_u2_susphy_quirk");=0A=
>  	dwc->dis_enblslpm_quirk =3D device_property_read_bool(dev,=0A=
>  				"snps,dis_enblslpm_quirk");=0A=
> +	dwc->dis_u1_entry_quirk =3D device_property_read_bool(dev,=0A=
> +				"snps,dis-u1-entry-quirk");=0A=
> +	dwc->dis_u2_entry_quirk =3D device_property_read_bool(dev,=0A=
> +				"snps,dis-u2-entry-quirk");=0A=
>  	dwc->dis_rxdet_inp3_quirk =3D device_property_read_bool(dev,=0A=
>  				"snps,dis_rxdet_inp3_quirk");=0A=
>  	dwc->dis_u2_freeclk_exists_quirk =3D device_property_read_bool(dev,=0A=
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h=0A=
> index 1528d39..fa398e2 100644=0A=
> --- a/drivers/usb/dwc3/core.h=0A=
> +++ b/drivers/usb/dwc3/core.h=0A=
> @@ -1015,6 +1015,8 @@ struct dwc3_scratchpad_array {=0A=
>   * @dis_u2_susphy_quirk: set if we disable usb2 suspend phy=0A=
>   * @dis_enblslpm_quirk: set if we clear enblslpm in GUSB2PHYCFG,=0A=
>   *                      disabling the suspend signal to the PHY.=0A=
> + * @dis_u1_entry_quirk: set if link entering into U1 state needs to be d=
isabled.=0A=
> + * @dis_u2_entry_quirk: set if link entering into U2 state needs to be d=
isabled.=0A=
>   * @dis_rxdet_inp3_quirk: set if we disable Rx.Detect in P3=0A=
>   * @dis_u2_freeclk_exists_quirk : set if we clear u2_freeclk_exists=0A=
>   *			in GUSB2PHYCFG, specify that USB2 PHY doesn't=0A=
> @@ -1206,6 +1208,8 @@ struct dwc3 {=0A=
>  	unsigned		dis_u3_susphy_quirk:1;=0A=
>  	unsigned		dis_u2_susphy_quirk:1;=0A=
>  	unsigned		dis_enblslpm_quirk:1;=0A=
> +	unsigned		dis_u1_entry_quirk:1;=0A=
> +	unsigned		dis_u2_entry_quirk:1;=0A=
>  	unsigned		dis_rxdet_inp3_quirk:1;=0A=
>  	unsigned		dis_u2_freeclk_exists_quirk:1;=0A=
>  	unsigned		dis_del_phy_power_chg_quirk:1;=0A=
> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c=0A=
> index 8efde17..8e94efc 100644=0A=
> --- a/drivers/usb/dwc3/ep0.c=0A=
> +++ b/drivers/usb/dwc3/ep0.c=0A=
> @@ -379,6 +379,8 @@ static int dwc3_ep0_handle_u1(struct dwc3 *dwc, enum =
usb_device_state state,=0A=
>  	if ((dwc->speed !=3D DWC3_DSTS_SUPERSPEED) &&=0A=
>  			(dwc->speed !=3D DWC3_DSTS_SUPERSPEED_PLUS))=0A=
>  		return -EINVAL;=0A=
> +	if (dwc->dis_u1_entry_quirk)=0A=
=0A=
We only need to reject on SET_FEATURE(enable U1/U2) and not=0A=
SET_FEATURE(disable U1/U2).=0A=
=0A=
Let's change the if condition to if (set && dis_u1_entry_quirk).=0A=
=0A=
> +		return -EINVAL;=0A=
>  =0A=
>  	reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);=0A=
>  	if (set)=0A=
> @@ -401,6 +403,8 @@ static int dwc3_ep0_handle_u2(struct dwc3 *dwc, enum =
usb_device_state state,=0A=
>  	if ((dwc->speed !=3D DWC3_DSTS_SUPERSPEED) &&=0A=
>  			(dwc->speed !=3D DWC3_DSTS_SUPERSPEED_PLUS))=0A=
>  		return -EINVAL;=0A=
> +	if (dwc->dis_u2_entry_quirk)=0A=
=0A=
Same comment as previous.=0A=
=0A=
> +		return -EINVAL;=0A=
>  =0A=
>  	reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);=0A=
>  	if (set)=0A=
> @@ -626,7 +630,10 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, str=
uct usb_ctrlrequest *ctrl)=0A=
>  			 * nothing is pending from application.=0A=
>  			 */=0A=
>  			reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);=0A=
> -			reg |=3D (DWC3_DCTL_ACCEPTU1ENA | DWC3_DCTL_ACCEPTU2ENA);=0A=
> +			if (!dwc->dis_u1_entry_quirk)=0A=
> +				reg |=3D DWC3_DCTL_ACCEPTU1ENA;=0A=
> +			if (!dwc->dis_u2_entry_quirk)=0A=
> +				reg |=3D DWC3_DCTL_ACCEPTU2ENA;=0A=
>  			dwc3_writel(dwc->regs, DWC3_DCTL, reg);=0A=
>  		}=0A=
>  		break;=0A=
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c=0A=
> index e293400..f2d3112 100644=0A=
> --- a/drivers/usb/dwc3/gadget.c=0A=
> +++ b/drivers/usb/dwc3/gadget.c=0A=
> @@ -2073,6 +2073,24 @@ static int dwc3_gadget_stop(struct usb_gadget *g)=
=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> +static void dwc3_gadget_config_params(struct usb_gadget *g,=0A=
> +				      struct usb_dcd_config_params *params)=0A=
> +{=0A=
> +	struct dwc3		*dwc =3D gadget_to_dwc(g);=0A=
> +=0A=
> +	/* U1 Device exit Latency */=0A=
> +	if (dwc->dis_u1_entry_quirk)=0A=
> +		params->bU1devExitLat =3D 0;=0A=
=0A=
It doesn't make sense to have exit latency of 0. Rejecting=0A=
SET_FEATURE(enable U1/U2) should already let the host know that the=0A=
device doesn't support U1/U2.=0A=
=0A=
> +	else=0A=
> +		params->bU1devExitLat =3D DWC3_DEFAULT_U1_DEV_EXIT_LAT;=0A=
> +=0A=
> +	/* U2 Device exit Latency */=0A=
> +	if (dwc->dis_u2_entry_quirk)=0A=
> +		params->bU2DevExitLat =3D 0;=0A=
> +	else=0A=
> +		params->bU2DevExitLat =3D DWC3_DEFAULT_U2_DEV_EXIT_LAT;=0A=
=0A=
This is a le16 value. Assign it with cpu_to_le16().=0A=
=0A=
> +}=0A=
> +=0A=
>  static void dwc3_gadget_set_speed(struct usb_gadget *g,=0A=
>  				  enum usb_device_speed speed)=0A=
>  {=0A=
> @@ -2142,6 +2160,7 @@ static const struct usb_gadget_ops dwc3_gadget_ops =
=3D {=0A=
>  	.udc_start		=3D dwc3_gadget_start,=0A=
>  	.udc_stop		=3D dwc3_gadget_stop,=0A=
>  	.udc_set_speed		=3D dwc3_gadget_set_speed,=0A=
> +	.get_config_params	=3D dwc3_gadget_config_params,=0A=
>  };=0A=
>  =0A=
>  /* ---------------------------------------------------------------------=
----- */=0A=
> diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h=0A=
> index 3ed738e..5faf4d1 100644=0A=
> --- a/drivers/usb/dwc3/gadget.h=0A=
> +++ b/drivers/usb/dwc3/gadget.h=0A=
> @@ -48,6 +48,12 @@ struct dwc3;=0A=
>  /* DEPXFERCFG parameter 0 */=0A=
>  #define DWC3_DEPXFERCFG_NUM_XFER_RES(n)	((n) & 0xffff)=0A=
>  =0A=
> +/* U1 Device exit Latency */=0A=
> +#define DWC3_DEFAULT_U1_DEV_EXIT_LAT	0x0A	/* Less then 10 microsec */=0A=
> +=0A=
> +/* U2 Device exit Latency */=0A=
> +#define DWC3_DEFAULT_U2_DEV_EXIT_LAT	0x1FF	/* Less then 511 microsec */=
=0A=
> +=0A=
>  /* ---------------------------------------------------------------------=
----- */=0A=
>  =0A=
>  #define to_dwc3_request(r)	(container_of(r, struct dwc3_request, request=
))=0A=
=0A=
BR,=0A=
Thinh=0A=
