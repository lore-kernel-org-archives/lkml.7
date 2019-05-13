Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA871C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8248420862
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="uGAbkFYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbfEMOPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:15:13 -0400
Received: from mail-eopbgr810079.outbound.protection.outlook.com ([40.107.81.79]:44112
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726274AbfEMOPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slQVvJZG7QeySqlRadxAtHyxYd/B7bliewWncjPkULE=;
 b=uGAbkFYCelywDXRlfLHw29DRntk6APFfB3w3K04oRubs3r+jhOeYcf5BPVSssj6MG2o7m2sH7mMIV3KRbYdaLKGdmZppla1mWe/vsTdwjIZo+ixwIo2akzGycD/jK9ETtzTI7EFnfDntVl9CcFhp2tEu2v6Du0nYaw124z74a/M=
Received: from BYAPR02MB5591.namprd02.prod.outlook.com (20.177.230.89) by
 BYAPR02MB5125.namprd02.prod.outlook.com (20.176.254.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Mon, 13 May 2019 14:15:07 +0000
Received: from BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::2c0d:4fbd:2c4:31b6]) by BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::2c0d:4fbd:2c4:31b6%5]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 14:15:07 +0000
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
Thread-Index: AQHVBXNeXBGr58NUnEy04Lh8niwnw6ZpIN9Q
Date:   Mon, 13 May 2019 14:15:07 +0000
Message-ID: <BYAPR02MB5591B928413B5118142841BDA70F0@BYAPR02MB5591.namprd02.prod.outlook.com>
References: <1557302091-7455-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1557302091-7455-4-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <30102591E157244384E984126FC3CB4F639E9823@us01wembx1.internal.synopsys.com>
 <BL0PR02MB5587B28B6CCAC0FD790F8335A7330@BL0PR02MB5587.namprd02.prod.outlook.com>
 <30102591E157244384E984126FC3CB4F639E9E8F@us01wembx1.internal.synopsys.com>
 <BYAPR02MB55913E2D6F6865202DE88514A70C0@BYAPR02MB5591.namprd02.prod.outlook.com>
 <30102591E157244384E984126FC3CB4F639EA444@us01wembx1.internal.synopsys.com>
In-Reply-To: <30102591E157244384E984126FC3CB4F639EA444@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 152adb53-0e11-4ef4-4fd1-08d6d7ad6719
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR02MB5125;
x-ms-traffictypediagnostic: BYAPR02MB5125:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB5125E5EE475E67DAD883C376A70F0@BYAPR02MB5125.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(136003)(376002)(346002)(13464003)(199004)(189003)(186003)(76116006)(4326008)(256004)(3846002)(26005)(14444005)(446003)(74316002)(2906002)(476003)(86362001)(11346002)(486006)(25786009)(6116002)(68736007)(14454004)(53936002)(33656002)(5660300002)(305945005)(66946007)(73956011)(7736002)(8936002)(102836004)(66476007)(66556008)(64756008)(66446008)(66066001)(7416002)(6506007)(53546011)(81166006)(478600001)(52536014)(76176011)(81156014)(6246003)(8676002)(99286004)(6436002)(7696005)(55016002)(316002)(9686003)(71200400001)(71190400001)(54906003)(110136005)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5125;H:BYAPR02MB5591.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s5ozpolqEg/6xD2fAHE2v2ARkSTKkMmy80LQHiW2zFwJPTnb5c4TFNdTf6f8LkTUrDT5aifXR/AyiEU/6hT+xWiwf7/ICeXsVK8cvm/sOaU65Ifkfm1EPT6Jh8AmPQvwqN7kpnLlXEZbj7Wh14st5RQeCkwx48inUCjzUYCAgjfdrXh9/V7Zluk/Ys3bU5b3ISUnTU4PgBb/kSKwZXBOV8EMHOnvZ5yiGCp+FAyR8R3UsF4hkC3exrWk/Jda687tbma324CUgTEeht00FWJ0VcxzW+6pRchZqtwUDdcalorFZIyGiw8uy/BCnsSGvNe0ESdgkfom60xbrTTN/cZ0v7d9iXQ4F7t6XnaycRj39wp8U5kR3ePk0UU4G6MAAxwACLaMqKvd3L0Cw1Tzb0Tku3cY0S3JF8vRjDz42kOPj5E=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152adb53-0e11-4ef4-4fd1-08d6d7ad6719
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 14:15:07.7250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

>-----Original Message-----
>From: Thinh Nguyen [mailto:Thinh.Nguyen@synopsys.com]
>Sent: Saturday, May 11, 2019 7:18 AM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>; Thinh Nguyen
><Thinh.Nguyen@synopsys.com>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>; Rob Herring <robh+dt@kernel.org>; Mark Rutla=
nd
><mark.rutland@arm.com>; Felipe Balbi <balbi@kernel.org>; Claus H. Stovgaar=
d
><cst@phaseone.com>
>Cc: linux-usb@vger.kernel.org; devicetree@vger.kernel.org; linux-
>kernel@vger.kernel.org; v.anuragkumar@gmail.com
>Subject: Re: [PATCH v2 3/3] usb: dwc3: gadget: Add support for disabling U=
1 and U2
>entries
>
>Hi,
>
>Anurag Kumar Vulisha wrote:
>> Hi Thinh,
>>
>>> -----Original Message-----
>>> From: Thinh Nguyen [mailto:Thinh.Nguyen@synopsys.com]
>>> Sent: Friday, May 10, 2019 5:30 AM
>>> To: Anurag Kumar Vulisha <anuragku@xilinx.com>; Thinh Nguyen
>>> <Thinh.Nguyen@synopsys.com>; Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org>; Rob Herring <robh+dt@kernel.org>; Mark Ru=
tland
>>> <mark.rutland@arm.com>; Felipe Balbi <balbi@kernel.org>; Claus H. Stovg=
aard
>>> <cst@phaseone.com>
>>> Cc: linux-usb@vger.kernel.org; devicetree@vger.kernel.org; linux-
>>> kernel@vger.kernel.org; v.anuragkumar@gmail.com
>>> Subject: Re: [PATCH v2 3/3] usb: dwc3: gadget: Add support for disablin=
g U1 and
>U2
>>> entries
>>>
>>> Hi Anurag,
>>>
>>> Anurag Kumar Vulisha wrote:
>>>>>> +		return -EINVAL;
>>>>>>
>>>>>>  	reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);
>>>>>>  	if (set)
>>>>>> @@ -626,7 +630,10 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc=
,
>>> struct
>>>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>>>> index e293400..f2d3112 100644
>>>>>> --- a/drivers/usb/dwc3/gadget.c
>>>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>>>> @@ -2073,6 +2073,24 @@ static int dwc3_gadget_stop(struct usb_gadget=
 *g)
>>>>>>  	return 0;
>>>>>>  }
>>>>>>
>>>>>> +static void dwc3_gadget_config_params(struct usb_gadget *g,
>>>>>> +				      struct usb_dcd_config_params *params)
>>>>>> +{
>>>>>> +	struct dwc3		*dwc =3D gadget_to_dwc(g);
>>>>>> +
>>>>>> +	/* U1 Device exit Latency */
>>>>>> +	if (dwc->dis_u1_entry_quirk)
>>>>>> +		params->bU1devExitLat =3D 0;
>>>>> It doesn't make sense to have exit latency of 0. Rejecting
>>>>> SET_FEATURE(enable U1/U2) should already let the host know that the
>>>>> device doesn't support U1/U2.
>>>>>
>>>> I am okay to remove this, but I feel that it is better to report zero =
value instead
>>>> of a non-zero value in exit latency of BOS when U1 or U2 entries are n=
ot
>supported.
>>>> Advantage of reporting 0 is that some hosts doesn't even send
>>> SET_FEATURE(U1/U2)
>>>> requests on seeing zero value in BOS descriptor. Also there can be cas=
es where
>U1 is
>>>> disabled and U2 entry is allowed or vice versa, for these kind of case=
s the driver
>can
>>>> set zero exit latency value for U1 and non-zero exit latency value for=
 U2 . Based
>on
>>> this
>>>> I think it would be better to report 0 when U1/U2 states are not enabl=
ed. Please
>>> provide
>>>> your opinion on this.
>>> Hm... I assume you're testing against linux usb stack and xhci host. If
>>> that's the case, it looks like host will still request the device to
>>> enter U1/U2 despite the device rejecting SET_FEATURE(enable U1/U2). Thi=
s
>>> needs to be fixed. I think what you have is fine to workaround this iss=
ue.
>> Thanks . Will send the next series with the other fixes that you have su=
ggested
>>
>> Best Regards,
>> Anurag Kumar Vulisha
>>
>
>I want to try something. Can you see if this helps with your performance
>test without setting the U1/U2 exit latency to 0?
>(No need to change what you have in your patch. This is just for testing).
>

With your patch , the link doesn't enter into U1/U2 and I am also getting
better performance

Thanks,
Anurag Kumar Vulisha

>diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>index 2f94568ba385..619351c581cf 100644
>--- a/drivers/usb/core/hub.c
>+++ b/drivers/usb/core/hub.c
>@@ -4057,8 +4057,18 @@ static void usb_enable_link_state(struct usb_hcd
>*hcd, struct usb_device *udev,
>                /* Only a configured device will accept the Set Feature
>                 * U1/U2_ENABLE
>                 */
>-               if (udev->actconfig)
>-                       usb_set_device_initiated_lpm(udev, state, true);
>+               if (udev->actconfig) {
>+                       if (usb_set_device_initiated_lpm(udev, state,
>true)) {
>+                               /*
>+                                * Don't request U1/U2 entry if the device
>+                                * cannot enable U1/U2.
>+                                */
>+                               usb_set_lpm_timeout(udev, state, 0);
>+
>hcd->driver->disable_usb3_lpm_timeout(hcd, udev,
>+
>state);
>+                               return;
>+                       }
>+               }
>
>                /* As soon as usb_set_lpm_timeout(timeout) returns 0, the
>                 * hub-initiated LPM is enabled. Thus, LPM is enabled no
>
>
