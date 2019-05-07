Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022F3C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD75821479
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GMDgcfRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfEGJqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 05:46:38 -0400
Received: from mail-eopbgr680049.outbound.protection.outlook.com ([40.107.68.49]:15589
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726249AbfEGJqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 05:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vS1FBy1HfvICv2oRhWVwoE/nFMY0TxpJ7XumOWqO7UM=;
 b=GMDgcfRdrVxo1MVTTVSmHOzsyl5k8gsyEOrBMsMJBL/81V+FpvK3u6o9mWhG3W2YRwxfYYHWDRyMrJBBnKznKnANNIOrZ+qEq9U1c/8q/Lh+cxpt1NxrMGISHVWNRcXkaQ68C3p9AgT90bkspRu1hLsy8hN9DWG2HpnuZZpftiU=
Received: from BYAPR02MB5591.namprd02.prod.outlook.com (20.177.230.89) by
 BYAPR02MB5656.namprd02.prod.outlook.com (20.177.230.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Tue, 7 May 2019 09:46:33 +0000
Received: from BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::4158:f3a1:5e61:54a2]) by BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::4158:f3a1:5e61:54a2%2]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 09:46:33 +0000
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
Subject: RE: [PATCH 3/3] usb: dwc3: gadget: Add support for disabling U1 and
 U2 entries
Thread-Topic: [PATCH 3/3] usb: dwc3: gadget: Add support for disabling U1 and
 U2 entries
Thread-Index: AQHVANDAIuHRsUnR3UyEXTsOibIOSaZfRnRg
Date:   Tue, 7 May 2019 09:46:33 +0000
Message-ID: <BYAPR02MB5591A7858831136D1C2DA618A7310@BYAPR02MB5591.namprd02.prod.outlook.com>
References: <1556792423-4833-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1556792423-4833-4-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <30102591E157244384E984126FC3CB4F639E7BA8@us01wembx1.internal.synopsys.com>
In-Reply-To: <30102591E157244384E984126FC3CB4F639E7BA8@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: effe28a9-90ed-4042-edfd-08d6d2d0e3e5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR02MB5656;
x-ms-traffictypediagnostic: BYAPR02MB5656:
x-ms-exchange-purlcount: 1
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB5656DA8246B718B200F9FF78A7310@BYAPR02MB5656.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(396003)(376002)(13464003)(189003)(199004)(7696005)(5660300002)(6436002)(71200400001)(71190400001)(76176011)(81156014)(81166006)(52536014)(8676002)(86362001)(486006)(7736002)(64756008)(476003)(305945005)(66476007)(73956011)(76116006)(110136005)(66446008)(66556008)(54906003)(66946007)(33656002)(68736007)(99286004)(7416002)(316002)(66066001)(53936002)(14444005)(74316002)(256004)(26005)(8936002)(446003)(3846002)(229853002)(102836004)(478600001)(11346002)(186003)(6306002)(6116002)(14454004)(55016002)(6246003)(9686003)(25786009)(4326008)(6506007)(2906002)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5656;H:BYAPR02MB5591.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N/U3i09CaIRuZnD8oeYaEoOnTLS+L39Sn7BRAusHo5Dd/FypkKqGfVTI+GeDbLHoMPXAhMBXVRCnMreKULSkDGbMizCrXI+wC4x1BAEug8/awbHo81DBaljgc9rQSDf2HgIHdLjqkTLMO0Ruzp6ZDpVIdcY5YmYmcXxb5V/unr0k+MVb6YqcmHU9N0ysoRYmdHgk633W47BAX0LQfWICbzoyFYkE9WJR4pKrhZ9d+XtELlKfZDiPypoX/X+sbiLI1WylHysRHPi6+vFwQ0qNMFLUOx32P1gRyAwkSNbyD+oR9OH8bRkokCo38XYPq06Os7HswvnsVK1ewKDSSB7N/fBmMwNOJc8afJ8KSowbSJZuv1kWYpjl/EVEm0Fq9oL/u3/ZFHRLY2fmZBRvFQp15vzKH8SqNrfVl7OODs9Tvhk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: effe28a9-90ed-4042-edfd-08d6d2d0e3e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 09:46:33.6049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5656
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

>-----Original Message-----
>From: Thinh Nguyen [mailto:Thinh.Nguyen@synopsys.com]
>Sent: Tuesday, May 07, 2019 12:51 AM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>; Rob Herring <robh+dt@kernel.org>; Mark Rutla=
nd
><mark.rutland@arm.com>; Felipe Balbi <balbi@kernel.org>
>Cc: linux-usb@vger.kernel.org; devicetree@vger.kernel.org; linux-
>kernel@vger.kernel.org; v.anuragkumar@gmail.com
>Subject: Re: [PATCH 3/3] usb: dwc3: gadget: Add support for disabling U1 a=
nd U2
>entries
>
>Hi Anurag,
>
>Anurag Kumar Vulisha wrote:
>> Gadget applications may have a requirement to disable the U1 and U2
>> entry based on the usecase. For example, when performing performance
>> benchmarking on mass storage gadget the U1 and U2 entries can be disable=
d.
>> Another example is when periodic transfers like ISOC transfers are
>> used with bInterval of 1 which doesn't require the link to enter into
>> U1 or U2 state (since ping is issued from host for every uframe
>> interval). In this case the U1 and U2 entry can be disabled. This can
>> be done by setting U1DevExitLat and U2DevExitLat values to 0 in the
>> BOS descriptor. Host on seeing 0 value for U1DevExitLat and
>> U2DevExitLat, it doesn't send SET_SEL commands to the gadget. Thus entry=
 of U1
>and U2 states can be avioded.
>> This patch updates the same
>
>I don't think we should assume that's the case for every host driver.

I agree with you, as Claus already mentioned, observed that windows 10
issues SET_SEL commands even after UxDevExitLat are zero.=20
 =20
>
>>
>> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>> ---
>>  drivers/usb/dwc3/core.c   |  4 ++++
>>  drivers/usb/dwc3/core.h   |  4 ++++
>>  drivers/usb/dwc3/gadget.c | 19 +++++++++++++++++++
>> drivers/usb/dwc3/gadget.h |  6 ++++++
>>  4 files changed, 33 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c index
>> a1b126f..4f0912c 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1285,6 +1285,10 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>>  				"snps,dis_u2_susphy_quirk");
>>  	dwc->dis_enblslpm_quirk =3D device_property_read_bool(dev,
>>  				"snps,dis_enblslpm_quirk");
>> +	dwc->dis_u1_entry_quirk =3D device_property_read_bool(dev,
>> +				"snps,dis_u1_entry_quirk");
>> +	dwc->dis_u2_entry_quirk =3D device_property_read_bool(dev,
>> +				"snps,dis_u2_entry_quirk");
>
>Please use "-" rather than "_" in the property names.
>

Okay , will change this

>>  	dwc->dis_rxdet_inp3_quirk =3D device_property_read_bool(dev,
>>  				"snps,dis_rxdet_inp3_quirk");
>>  	dwc->dis_u2_freeclk_exists_quirk =3D device_property_read_bool(dev,
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h index
>> 1528d39..fa398e2 100644
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
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index e293400..f2d3112 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2073,6 +2073,24 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
>>  	return 0;
>>  }
>>
>> +static void dwc3_gadget_config_params(struct usb_gadget *g,
>> +				      struct usb_dcd_config_params *params) {
>> +	struct dwc3		*dwc =3D gadget_to_dwc(g);
>> +
>> +	/* U1 Device exit Latency */
>> +	if (dwc->dis_u1_entry_quirk)
>> +		params->bU1devExitLat =3D 0;
>> +	else
>> +		params->bU1devExitLat =3D DWC3_DEFAULT_U1_DEV_EXIT_LAT;
>> +
>> +	/* U2 Device exit Latency */
>> +	if (dwc->dis_u2_entry_quirk)
>> +		params->bU2DevExitLat =3D 0;
>> +	else
>> +		params->bU2DevExitLat =3D DWC3_DEFAULT_U2_DEV_EXIT_LAT; }
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
>>  /*
>> ----------------------------------------------------------------------
>> ---- */ diff --git a/drivers/usb/dwc3/gadget.h
>> b/drivers/usb/dwc3/gadget.h index 3ed738e..5faf4d1 100644
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
>>  /*
>> ----------------------------------------------------------------------
>> ---- */
>>
>>  #define to_dwc3_request(r)	(container_of(r, struct dwc3_request, reques=
t))
>
>Setting the exit latency for U1/U2 to 0 to prevent U1/U2 entry looks more =
like a
>workaround than actually disabling U1/U2. There are DCTL.INITU1/2ENA and
>DCTL.ACCEPTU1/2ENA for that.
>
>Also, if these properties are set, then the device should rejects
>SET_FEATURE(U1/U2) requests.
>
>You can review Felipe's little code snippet from here to disable U1/U2:
>https://marc.info/?l=3Dlinux-usb&m=3D155419284426942&w=3D2
>

As there are some host platforms (like windows 10) which initiates U1/U2 st=
ates
even after sending zero in UxExitLat of BOS descriptor, I agree with you th=
at the
dwc3 controller should reject the U1/U2 requests from host by configuring D=
CTL.
Along with DCTL changes, I think the changes required for sending zero valu=
e in
UxExitLat field reported in the BOSDescriptor are also required (there is n=
o point
in sending non-zero exit latencies when U1/U2 state entries are disabled). =
So, this
patch changes should be added along with the changes reported by Claus.
Please provide your suggestion on this

Thanks,
Anurag Kumar Vulisha
