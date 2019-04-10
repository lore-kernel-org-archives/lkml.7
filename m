Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C154FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8454C2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eIf49my9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbfDJJlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:41:06 -0400
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:53373
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726699AbfDJJlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zynkMfCsns+/mIKPUxlc5A89I9aL7xUDpAfSkNX77o=;
 b=eIf49my9oiO8Uv4y9385jtftawXTEghX2EVgqeeZPBRkCE1Sk4CEu8/eEljN+rqkoqrsIMrdz4DgGeBGYBgS3BIrnSrMmvVh/UoQe0Bz5pYRakdzigSLoozh3y4UMn/GPbFb38JLAR0fqGZF15uG4nfgXFiXFHOfjAknV71XbY8=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2836.eurprd04.prod.outlook.com (10.175.41.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Wed, 10 Apr 2019 09:40:59 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::d017:34d9:4a70:bb8]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::d017:34d9:4a70:bb8%11]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 09:40:59 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yang Li <pku.leo@gmail.com>
Subject: RE: [PATCH v3 2/2] usb: dwc3: Add workaround for host mode VBUS
 glitch when boot
Thread-Topic: [PATCH v3 2/2] usb: dwc3: Add workaround for host mode VBUS
 glitch when boot
Thread-Index: AQHUzaDPFcJ4hglFSU2evLYpi8IQf6Y1ZsZg
Date:   Wed, 10 Apr 2019 09:40:59 +0000
Message-ID: <AM5PR0402MB2865B9A93B90BD742EC1AC54F12E0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20190226070016.27372-1-ran.wang_1@nxp.com>
 <20190226070016.27372-2-ran.wang_1@nxp.com>
In-Reply-To: <20190226070016.27372-2-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b8231df-ff1e-415d-8170-08d6bd98a3b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM5PR0402MB2836;
x-ms-traffictypediagnostic: AM5PR0402MB2836:
x-microsoft-antispam-prvs: <AM5PR0402MB2836807CD1ED0BAB0C33DAD7F12E0@AM5PR0402MB2836.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(256004)(110136005)(81166006)(76176011)(8936002)(6246003)(6436002)(229853002)(316002)(97736004)(4326008)(8676002)(6506007)(102836004)(33656002)(53546011)(81156014)(186003)(53936002)(74316002)(25786009)(305945005)(7736002)(99286004)(54906003)(52536014)(106356001)(105586002)(2906002)(446003)(5660300002)(68736007)(476003)(6116002)(11346002)(7696005)(3846002)(26005)(71190400001)(508600001)(14454004)(71200400001)(86362001)(66066001)(9686003)(55016002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2836;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ybnTwflFy7MXfZXbXkr4naMygbeVscgfOOikAWUex86PScQm0QIhL5Vy91rJLkl4vfmwvgtO+ugXMzaffyR1hXGpEg2bAf2iu8qT+WLQJpeGL/1qCsbtkUA3R+L2gQmFxIQ9XOplgrwuh1uCZe1y8xH2GfFv9qazgehCcr+3o9lgFm9ar9ePetMCoJtbN1hbq33HYaEJEEe5baFb6lhfjNE+hPLm+k6TI+3B39H4HrRQe7yNs4PnnSOtviVu5of+f96m7yDBHwwJ2gRA+5r7A12c9QZgMhiKlS61W04YLTQuy9voZ2+j4TkENDEPyC2gdLA5sKBAA3aDENZrBGsJiCqX9vxWDPXT99e1nz5qN8FcSOLnXacs41OTRhQY+Mg6gsKqUmtMq+xKq9JWUfhTL4G0ltUaNuY7cskVw5k93dY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8231df-ff1e-415d-8170-08d6bd98a3b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 09:40:59.6900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2836
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sirs,
    May I have your comment on this version patch, please? Thanks.
Regards,
Ran

On Tuesday, February 26, 2019 14:59, Ran Wang wrote:
> When DWC3 is set to host mode by programming register DWC3_GCTL, VBUS
> (or its control signal) will be turned on immediately on related Root Hub=
 ports.
> Then, the VBUS is turned off for a little while(15us) when do xhci reset
> (conducted by xhci driver) and back to normal finally, we can observe a n=
egative
> glitch of related signal happen.
>=20
> This VBUS glitch might cause some USB devices enumeration fail if kernel =
boot
> with them connected. Such as LS1012AFWRY/LS1043ARDB/LX2160AQDS
> /LS1088ARDB with Kingston 16GB USB2.0/Kingston USB3.0/JetFlash Transcend
> 4GB USB2.0 drives. The fail cases include enumerated as full-speed device=
 or
> report wrong device descriptor, etc.
>=20
> One SW workaround which can fix this is by programing all xhci PORTSC[PP]=
 to 0
> to turn off VBUS immediately after setting host mode in DWC3 driver (per =
signal
> measurement result, it will be too late to do it in xhci-plat.c or xhci.c=
). Then,
> after xhci reset complete in xhci driver, PORTSC[PP]s' value will back to=
 1
> automatically and VBUS on at that time, no glitch happen and normal
> enumeration process has no impact.
>=20
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Changes in v3:
>   - Add macro PORT_REGS_SIZE to replace 0x10
>   - Change initial value of i to 0 for the for loop
>   - Cosmetic changes
>=20
> Changes in v2:
>   - Rename related property to 'snps,host-vbus-glitches'
>   - Rename related dwc member to 'host_vbus_glitches'
>   - Add member 'host_vbus_glitches' description in 'dwc3'
>=20
>  drivers/usb/dwc3/core.c |   48
> +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/dwc3/core.h |   12 +++++++++++
>  2 files changed, 60 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c index
> a1b126f..dd80e3d 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -100,6 +100,42 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
>  	return 0;
>  }
>=20
> +/*
> + * dwc3_power_of_all_roothub_ports - Power off all Root hub ports
> + * @dwc3: Pointer to our controller context structure  */ static void
> +dwc3_power_off_all_roothub_ports(struct dwc3 *dwc) {
> +	int i, port_num;
> +	u32 reg, op_regs_base, offset;
> +	void __iomem		*xhci_regs;
> +
> +	/* xhci regs is not mapped yet, do it temperary here */
> +	if (dwc->xhci_resources[0].start) {
> +		xhci_regs =3D ioremap(dwc->xhci_resources[0].start,
> +				DWC3_XHCI_REGS_END);
> +		if (IS_ERR(xhci_regs)) {
> +			dev_err(dwc->dev, "Failed to ioremap xhci_regs\n");
> +			return;
> +		}
> +
> +		op_regs_base =3D HC_LENGTH(readl(xhci_regs));
> +		reg =3D readl(xhci_regs + XHCI_HCSPARAMS1);
> +		port_num =3D HCS_MAX_PORTS(reg);
> +
> +		for (i =3D 0; i < port_num; i++) {
> +			offset =3D op_regs_base + XHCI_PORTSC_BASE +
> +				PORT_REGS_SIZE * i;
> +			reg =3D readl(xhci_regs + offset);
> +			reg &=3D ~PORT_POWER;
> +			writel(reg, xhci_regs + offset);
> +		}
> +
> +		iounmap(xhci_regs);
> +	} else
> +		dev_err(dwc->dev, "xhci base reg invalid\n"); }
> +
>  void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)  {
>  	u32 reg;
> @@ -109,6 +145,15 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
>  	reg |=3D DWC3_GCTL_PRTCAPDIR(mode);
>  	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>=20
> +	/*
> +	 * We have to power off all Root hub ports immediately after DWC3 set
> +	 * to host mode to avoid VBUS glitch happen when xhci get reset later.
> +	 */
> +	if (dwc->host_vbus_glitches) {
> +		if (mode =3D=3D DWC3_GCTL_PRTCAP_HOST)
> +			dwc3_power_off_all_roothub_ports(dwc);
> +	}
> +
>  	dwc->current_dr_role =3D mode;
>  }
>=20
> @@ -1306,6 +1351,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>  	dwc->dis_metastability_quirk =3D device_property_read_bool(dev,
>  				"snps,dis_metastability_quirk");
>=20
> +	dwc->host_vbus_glitches =3D device_property_read_bool(dev,
> +				"snps,host-vbus-glitches");
> +
>  	dwc->lpm_nyet_threshold =3D lpm_nyet_threshold;
>  	dwc->tx_de_emphasis =3D tx_de_emphasis;
>=20
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h index
> df87641..c2dee0b 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -606,6 +606,15 @@
>  #define DWC3_OSTS_VBUSVLD		BIT(1)
>  #define DWC3_OSTS_CONIDSTS		BIT(0)
>=20
> +/* Partial XHCI Register and Bit fields for quirk */
> +#define XHCI_HCSPARAMS1		0x4
> +#define XHCI_PORTSC_BASE	0x400
> +#define PORT_REGS_SIZE		0x10
> +#define PORT_POWER			(1 << 9)
> +#define HCS_MAX_PORTS(p)	(((p) >> 24) & 0x7f)
> +#define XHCI_HC_LENGTH(p)	(((p)>>00)&0x00ff)
> +#define HC_LENGTH(p)		XHCI_HC_LENGTH(p)
> +
>  /* Structures */
>=20
>  struct dwc3_trb;
> @@ -1024,6 +1033,8 @@ struct dwc3_scratchpad_array {
>   * 	2	- No de-emphasis
>   * 	3	- Reserved
>   * @dis_metastability_quirk: set to disable metastability quirk.
> + * @host-vbus-glitches: set to avoid vbus glitch during
> + *                      xhci reset.
>   * @imod_interval: set the interrupt moderation interval in 250ns
>   *                 increments or 0 to disable.
>   */
> @@ -1209,6 +1220,7 @@ struct dwc3 {
>  	unsigned		tx_de_emphasis:2;
>=20
>  	unsigned		dis_metastability_quirk:1;
> +	unsigned		host_vbus_glitches:1;
>=20
>  	u16			imod_interval;
>  };
> --
> 1.7.1

