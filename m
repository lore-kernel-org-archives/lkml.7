Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A84C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 07:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6EF216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 07:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="gx4qlp2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfEIHdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 03:33:53 -0400
Received: from mail-eopbgr690055.outbound.protection.outlook.com ([40.107.69.55]:37889
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbfEIHdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 03:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8MZZk28Mt75KbHEhXaxA09nUWxCk4RvpYQI/2ot/Xk=;
 b=gx4qlp2r9uCkvDyv6k0bxGz/yRKGjeIY1K/YjZZu3TsMsy/GQsx+slQrF6LRpTUOxk70rE2e2inOWugKraUJ30d/isu2H2OKzREOYXMGfpQKwz3ojtZvs0+ZAuZ/mMO76shX5tacA0WCdQJCcWRdJElAbRIs1uAINvbqFRSK9ws=
Received: from BL0PR02MB5587.namprd02.prod.outlook.com (20.177.241.30) by
 BL0PR02MB4419.namprd02.prod.outlook.com (10.167.179.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.14; Thu, 9 May 2019 07:33:46 +0000
Received: from BL0PR02MB5587.namprd02.prod.outlook.com
 ([fe80::50eb:f7a2:d218:3aad]) by BL0PR02MB5587.namprd02.prod.outlook.com
 ([fe80::50eb:f7a2:d218:3aad%7]) with mapi id 15.20.1856.012; Thu, 9 May 2019
 07:33:46 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Claus H. Stovgaard" <cst@phaseone.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>
Subject: RE: [PATCH v2 3/3] usb: dwc3: gadget: Add support for disabling U1
 and U2 entries
Thread-Topic: [PATCH v2 3/3] usb: dwc3: gadget: Add support for disabling U1
 and U2 entries
Thread-Index: AQHVBXNeXBGr58NUnEy04Lh8niwnw6ZiY1Lg
Date:   Thu, 9 May 2019 07:33:46 +0000
Message-ID: <BL0PR02MB5587B28B6CCAC0FD790F8335A7330@BL0PR02MB5587.namprd02.prod.outlook.com>
References: <1557302091-7455-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1557302091-7455-4-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <30102591E157244384E984126FC3CB4F639E9823@us01wembx1.internal.synopsys.com>
In-Reply-To: <30102591E157244384E984126FC3CB4F639E9823@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8f70e76-6a49-4cba-0371-08d6d450ac02
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BL0PR02MB4419;
x-ms-traffictypediagnostic: BL0PR02MB4419:
x-ms-exchange-purlcount: 1
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BL0PR02MB44197E47F56841EE51B9AC4FA7330@BL0PR02MB4419.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(39860400002)(346002)(199004)(189003)(13464003)(7416002)(4326008)(81156014)(81166006)(33656002)(486006)(8676002)(14444005)(476003)(71200400001)(71190400001)(186003)(966005)(11346002)(229853002)(25786009)(6436002)(446003)(74316002)(68736007)(6506007)(256004)(6306002)(14454004)(55016002)(478600001)(73956011)(6246003)(66946007)(305945005)(7696005)(86362001)(76176011)(76116006)(53936002)(7736002)(102836004)(26005)(316002)(66066001)(52536014)(2906002)(66556008)(64756008)(66446008)(66476007)(8936002)(54906003)(99286004)(6116002)(3846002)(110136005)(5660300002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4419;H:BL0PR02MB5587.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: shj21ZzbbwNTfnRp8VBz1NdMTxC3TTWWXU9AfNLOBftG9wx3ViPQ4kVZGyywmL4iPLP9HP0gg8wfvFS7EiphJDM6OuQ7lHlcI83LlVPiALvwH9kPUWGn5ZcAoJzwiWbEnCeXAvJQ9sLiSoZvyettAn+NhfQt0BUDCu0WqN5jgTgjxKtwzWY7M7aAzfbHCYTCQLzlRHIygHVEbHmAPPeQqOlpTgrlPz2ov/bk+w9Bf0h08MUUIyiYqlClz7nk+ingtpESDFgjqtfjbGVzGuJicF0zeNFFXO8C/1+fy2LLftdd+vD3lsFCqJ90dkUHSoI8x8jkgNyuHp2ZsmSEeSMHEpB6DndCPFM3UkNAtqaTdBtvPTZ4Z6s0qXaxgdBUSOL1XakuYI74n5jv+BEOt7pEFYPtOfLT1uX0ahmoSFbckTA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f70e76-6a49-4cba-0371-08d6d450ac02
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 07:33:46.6100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4419
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thinh,

>-----Original Message-----
>From: Thinh Nguyen [mailto:Thinh.Nguyen@synopsys.com]
>Sent: Thursday, May 09, 2019 1:03 AM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>; Rob Herring <robh+dt@kernel.org>; Mark Rutla=
nd
><mark.rutland@arm.com>; Felipe Balbi <balbi@kernel.org>; Thinh Nguyen
><Thinh.Nguyen@synopsys.com>; Claus H. Stovgaard <cst@phaseone.com>
>Cc: linux-usb@vger.kernel.org; devicetree@vger.kernel.org; linux-
>kernel@vger.kernel.org; v.anuragkumar@gmail.com
>Subject: Re: [PATCH v2 3/3] usb: dwc3: gadget: Add support for disabling U=
1 and U2
>entries
>
>Hi Anurag,
>
>Anurag Kumar Vulisha wrote:
>> Gadget applications may have a requirement to disable the U1 and U2
>> entry based on the usecase. Below are few usecases where the disabling
>> U1/U2 entries may be possible.
>>
>> Usecase 1:
>> When combining dwc3 with an redriver for a USB Type-C device solution, i=
t
>> sometimes have problems with leaving U1/U2 for certain hosts, resulting =
in
>> link training errors and reconnects. For this U1/U2 state entries may be
>> avoided.
>>
>> Usecase 2:
>> When performing performance benchmarking on mass storage gadget the
>> U1 and U2 entries can be disabled.
>>
>> Usecase 3:
>> When periodic transfers like ISOC transfers are used with bInterval
>> of 1 which doesn't require the link to enter into U1 or U2 state entry
>> (since ping is issued from host for every uframe interval). In this
>> case the U1 and U2 entry can be disabled.
>>
>> Disablement of U1/U2 can be done by setting U1DevExitLat and U2DevExitLa=
t
>> values to 0 in the BOS descriptor. Host on seeing 0 value for U1DevExitL=
at
>> and U2DevExitLat, it doesn't send SET_SEL requests to the gadget. There
>> may be some hosts which may send SET_SEL requests even after seeing 0 in
>> the UxDevExitLat of BOS descriptor. To aviod U1/U2 entries for these typ=
e
>> of hosts, dwc3 controller can be programmed to reject those U1/U2 reques=
ts
>> by not enabling ACCEPTUxENA bits in DCTL register.
>>
>> This patch updates the same.
>>
>> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>> Signed-off-by: Claus H. Stovgaard <cst@phaseone.com>
>> ---
>>  Changes in v2
>> 	1. As suggested by Thinh Nguyen changed the "snps,dis_u1_entry_quirk"
>> 	   to "snps,dis-u1-entry-quirk"
>> 	2. Merged the changes done by Claus H. Stovgaard in ep0.c for rejecting
>> 	   U1/U2 requests into this patch. Changes done by Claus can be found
>> 	   here https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__marc.inf=
o_-
>3Fl-3Dlinux-2Dkernel-26m-3D155722068820568-26w-
>3D2&d=3DDwIBAg&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3Du9FYoxKtyhjrGFcyixFYqTjw1ZX0=
Vs
>G2d8FCmzkTY-
>w&m=3DdJMdvubLsepuGRDdkLZNJ00bhu52jPV7TZaFkDGD0Vs&s=3DwT7eyWpRKPAqXmLf
>dfiArbnZ7vE9Vi8DOfRdULmeIqY&e=3D
>> 	3. Changed the commit message.
>> ---
>>  drivers/usb/dwc3/core.c   |  4 ++++
>>  drivers/usb/dwc3/core.h   |  4 ++++
>>  drivers/usb/dwc3/ep0.c    |  9 ++++++++-
>>  drivers/usb/dwc3/gadget.c | 19 +++++++++++++++++++
>>  drivers/usb/dwc3/gadget.h |  6 ++++++
>>  5 files changed, 41 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index a1b126f..180239b 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1285,6 +1285,10 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>>  				"snps,dis_u2_susphy_quirk");
>>  	dwc->dis_enblslpm_quirk =3D device_property_read_bool(dev,
>>  				"snps,dis_enblslpm_quirk");
>> +	dwc->dis_u1_entry_quirk =3D device_property_read_bool(dev,
>> +				"snps,dis-u1-entry-quirk");
>> +	dwc->dis_u2_entry_quirk =3D device_property_read_bool(dev,
>> +				"snps,dis-u2-entry-quirk");
>>  	dwc->dis_rxdet_inp3_quirk =3D device_property_read_bool(dev,
>>  				"snps,dis_rxdet_inp3_quirk");
>>  	dwc->dis_u2_freeclk_exists_quirk =3D device_property_read_bool(dev,
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index 1528d39..fa398e2 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -1015,6 +1015,8 @@ struct dwc3_scratchpad_array {
>>   * @dis_u2_susphy_quirk: set if we disable usb2 suspend phy
>>   * @dis_enblslpm_quirk: set if we clear enblslpm in GUSB2PHYCFG,
>>   *                      disabling the suspend signal to the PHY.
>> + * @dis_u1_entry_quirk: set if link entering into U1 state needs to be =
disabled.
>> + * @dis_u2_entry_quirk: set if link entering into U2 state needs to be =
disabled.
>>   * @dis_rxdet_inp3_quirk: set if we disable Rx.Detect in P3
>>   * @dis_u2_freeclk_exists_quirk : set if we clear u2_freeclk_exists
>>   *			in GUSB2PHYCFG, specify that USB2 PHY doesn't
>> @@ -1206,6 +1208,8 @@ struct dwc3 {
>>  	unsigned		dis_u3_susphy_quirk:1;
>>  	unsigned		dis_u2_susphy_quirk:1;
>>  	unsigned		dis_enblslpm_quirk:1;
>> +	unsigned		dis_u1_entry_quirk:1;
>> +	unsigned		dis_u2_entry_quirk:1;
>>  	unsigned		dis_rxdet_inp3_quirk:1;
>>  	unsigned		dis_u2_freeclk_exists_quirk:1;
>>  	unsigned		dis_del_phy_power_chg_quirk:1;
>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>> index 8efde17..8e94efc 100644
>> --- a/drivers/usb/dwc3/ep0.c
>> +++ b/drivers/usb/dwc3/ep0.c
>> @@ -379,6 +379,8 @@ static int dwc3_ep0_handle_u1(struct dwc3 *dwc, enum
>usb_device_state state,
>>  	if ((dwc->speed !=3D DWC3_DSTS_SUPERSPEED) &&
>>  			(dwc->speed !=3D DWC3_DSTS_SUPERSPEED_PLUS))
>>  		return -EINVAL;
>> +	if (dwc->dis_u1_entry_quirk)
>
>We only need to reject on SET_FEATURE(enable U1/U2) and not
>SET_FEATURE(disable U1/U2).
>
>Let's change the if condition to if (set && dis_u1_entry_quirk).
>

Thanks for reviewing the patch.
I agree. Will correct it in the next series.

>> +		return -EINVAL;
>>
>>  	reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);
>>  	if (set)
>> @@ -401,6 +403,8 @@ static int dwc3_ep0_handle_u2(struct dwc3 *dwc, enum
>usb_device_state state,
>>  	if ((dwc->speed !=3D DWC3_DSTS_SUPERSPEED) &&
>>  			(dwc->speed !=3D DWC3_DSTS_SUPERSPEED_PLUS))
>>  		return -EINVAL;
>> +	if (dwc->dis_u2_entry_quirk)
>
>Same comment as previous.
>

Will fix it in the next series

>> +		return -EINVAL;
>>
>>  	reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);
>>  	if (set)
>> @@ -626,7 +630,10 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, st=
ruct
>usb_ctrlrequest *ctrl)
>>  			 * nothing is pending from application.
>>  			 */
>>  			reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);
>> -			reg |=3D (DWC3_DCTL_ACCEPTU1ENA |
>DWC3_DCTL_ACCEPTU2ENA);
>> +			if (!dwc->dis_u1_entry_quirk)
>> +				reg |=3D DWC3_DCTL_ACCEPTU1ENA;
>> +			if (!dwc->dis_u2_entry_quirk)
>> +				reg |=3D DWC3_DCTL_ACCEPTU2ENA;
>>  			dwc3_writel(dwc->regs, DWC3_DCTL, reg);
>>  		}
>>  		break;
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index e293400..f2d3112 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2073,6 +2073,24 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
>>  	return 0;
>>  }
>>
>> +static void dwc3_gadget_config_params(struct usb_gadget *g,
>> +				      struct usb_dcd_config_params *params)
>> +{
>> +	struct dwc3		*dwc =3D gadget_to_dwc(g);
>> +
>> +	/* U1 Device exit Latency */
>> +	if (dwc->dis_u1_entry_quirk)
>> +		params->bU1devExitLat =3D 0;
>
>It doesn't make sense to have exit latency of 0. Rejecting
>SET_FEATURE(enable U1/U2) should already let the host know that the
>device doesn't support U1/U2.
>
I am okay to remove this, but I feel that it is better to report zero value=
 instead
of a non-zero value in exit latency of BOS when U1 or U2 entries are not su=
pported.=20
Advantage of reporting 0 is that some hosts doesn't even send SET_FEATURE(U=
1/U2)
requests on seeing zero value in BOS descriptor. Also there can be cases wh=
ere U1 is
disabled and U2 entry is allowed or vice versa, for these kind of cases the=
 driver can
set zero exit latency value for U1 and non-zero exit latency value for U2 .=
 Based on this
I think it would be better to report 0 when U1/U2 states are not enabled. P=
lease provide
your opinion on this.

>> +	else
>> +		params->bU1devExitLat =3D DWC3_DEFAULT_U1_DEV_EXIT_LAT;
>> +
>> +	/* U2 Device exit Latency */
>> +	if (dwc->dis_u2_entry_quirk)
>> +		params->bU2DevExitLat =3D 0;
>> +	else
>> +		params->bU2DevExitLat =3D DWC3_DEFAULT_U2_DEV_EXIT_LAT;
>
>This is a le16 value. Assign it with cpu_to_le16().
>
Sure, will correct this in next series

Thanks,
Anurag Kumar Vulisha

>> +}
>> +
>>  static void dwc3_gadget_set_speed(struct usb_gadget *g,
>>  				  enum usb_device_speed speed)
>>  {
>> @@ -2142,6 +2160,7 @@ static const struct usb_gadget_ops dwc3_gadget_ops=
 =3D {
>>  	.udc_start		=3D dwc3_gadget_start,
>>  	.udc_stop		=3D dwc3_gadget_stop,
>>  	.udc_set_speed		=3D dwc3_gadget_set_speed,
>> +	.get_config_params	=3D dwc3_gadget_config_params,
>>  };
>>
>>  /* --------------------------------------------------------------------=
------ */
>> diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
>> index 3ed738e..5faf4d1 100644
>> --- a/drivers/usb/dwc3/gadget.h
>> +++ b/drivers/usb/dwc3/gadget.h
>> @@ -48,6 +48,12 @@ struct dwc3;
>>  /* DEPXFERCFG parameter 0 */
>>  #define DWC3_DEPXFERCFG_NUM_XFER_RES(n)	((n) & 0xffff)
>>
>> +/* U1 Device exit Latency */
>> +#define DWC3_DEFAULT_U1_DEV_EXIT_LAT	0x0A	/* Less then 10 microsec */
>> +
>> +/* U2 Device exit Latency */
>> +#define DWC3_DEFAULT_U2_DEV_EXIT_LAT	0x1FF	/* Less then 511 microsec
>*/
>> +
>>  /* --------------------------------------------------------------------=
------ */
>>
>>  #define to_dwc3_request(r)	(container_of(r, struct dwc3_request, reques=
t))
>
>BR,
>Thinh
