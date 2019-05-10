Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C59C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 06:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2822175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 06:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="JhXbQ8tU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfEJG6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 02:58:16 -0400
Received: from mail-eopbgr680040.outbound.protection.outlook.com ([40.107.68.40]:44260
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726934AbfEJG6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 02:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKonITmOiVpBIyxc3sb4CaBSIyUv7AWMNxytSNrrruU=;
 b=JhXbQ8tU02edRJZW4rXWJPt/CLsMpAOMMzI39ln/TdexmgpyDkkGHSVIw58QuSgQPfSX6Dl4piQycoYNDmU0pqeelHuDe2DKSl+Y4u2ZBiVs5ef5gnX1AuMx5v1/e8TZFqa5uO376WLDH+fu1QeM9pzTWFsMOtvGZmTb6OA3hjU=
Received: from BYAPR02MB5591.namprd02.prod.outlook.com (20.177.230.89) by
 BYAPR02MB4134.namprd02.prod.outlook.com (20.176.249.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Fri, 10 May 2019 06:58:09 +0000
Received: from BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::2c0d:4fbd:2c4:31b6]) by BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::2c0d:4fbd:2c4:31b6%5]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 06:58:09 +0000
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
Thread-Index: AQHVBXNeXBGr58NUnEy04Lh8niwnw6Zj7/lw
Date:   Fri, 10 May 2019 06:58:09 +0000
Message-ID: <BYAPR02MB55913E2D6F6865202DE88514A70C0@BYAPR02MB5591.namprd02.prod.outlook.com>
References: <1557302091-7455-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1557302091-7455-4-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <30102591E157244384E984126FC3CB4F639E9823@us01wembx1.internal.synopsys.com>
 <BL0PR02MB5587B28B6CCAC0FD790F8335A7330@BL0PR02MB5587.namprd02.prod.outlook.com>
 <30102591E157244384E984126FC3CB4F639E9E8F@us01wembx1.internal.synopsys.com>
In-Reply-To: <30102591E157244384E984126FC3CB4F639E9E8F@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b754931-bda8-4b5c-0eaa-08d6d514dc62
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR02MB4134;
x-ms-traffictypediagnostic: BYAPR02MB4134:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB41344693C2EB6C2F9FFD9811A70C0@BYAPR02MB4134.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(366004)(376002)(136003)(13464003)(189003)(199004)(305945005)(6246003)(33656002)(53936002)(14444005)(68736007)(8936002)(99286004)(446003)(81166006)(8676002)(256004)(25786009)(81156014)(71200400001)(71190400001)(7736002)(76176011)(486006)(6506007)(7696005)(2906002)(4326008)(102836004)(3846002)(6116002)(11346002)(476003)(26005)(186003)(110136005)(54906003)(52536014)(74316002)(86362001)(7416002)(66446008)(5660300002)(6436002)(14454004)(9686003)(73956011)(76116006)(316002)(66946007)(55016002)(66066001)(66556008)(66476007)(64756008)(229853002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4134;H:BYAPR02MB5591.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0kJzyF/dldPIo3D8E5b4eN7p7/rOuKmOtX1s571b2fvrcqRD8bGaTqvV2ktnaycWw98ZR4P013Wi+QRWwENelGT4/vCH19lvBNTcivkCMpeLaqhRYUA5Kd2aNwG1vxR+NTwEJu/CCdJf0X2s3FZII+0QSYMQLohAuEcm7kQV301zZGLQFAbUm3cOQC+WORZ8LktMz8kSCJ8WogVmlqIWCsOhXpCscBX+aV2JB93c4oW8ERa9uEauUTPXQTQwHZyIuBi6G/IdsoAzPHxQ76KJvYreTi0mjrZivdm6LkGJZyrrzscgkbm4brc1ofp38sSgYp4qIEGToBidyg+AeB/jRkcNGCf25Sg27xgg2IxU6GbwUfMGQb7mOOvuluFujlF+FiCCH5nC+7TMnPyuPAbCRpLV5CMump9GJza5GIywGYg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b754931-bda8-4b5c-0eaa-08d6d514dc62
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 06:58:09.1200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thinh,

>-----Original Message-----
>From: Thinh Nguyen [mailto:Thinh.Nguyen@synopsys.com]
>Sent: Friday, May 10, 2019 5:30 AM
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
>Hi Anurag,
>
>Anurag Kumar Vulisha wrote:
>>>> +		return -EINVAL;
>>>>
>>>>  	reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);
>>>>  	if (set)
>>>> @@ -626,7 +630,10 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc,
>struct
>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>> index e293400..f2d3112 100644
>>>> --- a/drivers/usb/dwc3/gadget.c
>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>> @@ -2073,6 +2073,24 @@ static int dwc3_gadget_stop(struct usb_gadget *=
g)
>>>>  	return 0;
>>>>  }
>>>>
>>>> +static void dwc3_gadget_config_params(struct usb_gadget *g,
>>>> +				      struct usb_dcd_config_params *params)
>>>> +{
>>>> +	struct dwc3		*dwc =3D gadget_to_dwc(g);
>>>> +
>>>> +	/* U1 Device exit Latency */
>>>> +	if (dwc->dis_u1_entry_quirk)
>>>> +		params->bU1devExitLat =3D 0;
>>> It doesn't make sense to have exit latency of 0. Rejecting
>>> SET_FEATURE(enable U1/U2) should already let the host know that the
>>> device doesn't support U1/U2.
>>>
>> I am okay to remove this, but I feel that it is better to report zero va=
lue instead
>> of a non-zero value in exit latency of BOS when U1 or U2 entries are not=
 supported.
>> Advantage of reporting 0 is that some hosts doesn't even send
>SET_FEATURE(U1/U2)
>> requests on seeing zero value in BOS descriptor. Also there can be cases=
 where U1 is
>> disabled and U2 entry is allowed or vice versa, for these kind of cases =
the driver can
>> set zero exit latency value for U1 and non-zero exit latency value for U=
2 . Based on
>this
>> I think it would be better to report 0 when U1/U2 states are not enabled=
. Please
>provide
>> your opinion on this.
>
>Hm... I assume you're testing against linux usb stack and xhci host. If
>that's the case, it looks like host will still request the device to
>enter U1/U2 despite the device rejecting SET_FEATURE(enable U1/U2). This
>needs to be fixed. I think what you have is fine to workaround this issue.

Thanks . Will send the next series with the other fixes that you have sugge=
sted

Best Regards,
Anurag Kumar Vulisha
