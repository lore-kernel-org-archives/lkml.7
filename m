Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA41C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5AF2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hLeWA75Y";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="DqlzPVFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfC1Hzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:55:42 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:51958 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725948AbfC1Hzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 03:55:39 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2S7spIp002090;
        Thu, 28 Mar 2019 00:55:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=rQwMUXjLEKd+jsUWVYB1YM2dZybYB+iMDj7BdLgAoH4=;
 b=hLeWA75YM0qeVWroFVLbpDK7GrxPpUln0K5wO1tMiN8gsm+HdRy96uvAbENpuj7yVFAy
 Z/+hmpw2b9NXNknWTejdjoh1DMMafrI4GIhqacUZY8jouqx8cLjR2FBOdLvlue73cq5j
 7yto+m4YBGFDprA6Ha7F53mAU9aIkZ3VK3k6d/5HLNGT+DfG1enpatvQG5UygHK3JW+E
 HeyhcYuCHhDxErXxZaC11rsUAZuX/S3M7+bRDyh+ZzNfil6wqZIMpR8+uYnPlRZp0Z0I
 0aQoIoV2D9bINB1/IDfVii0IH90472Qcc1jtCc7ILmDEonRVAhrxhKd9KnrjOPytPLuO Lw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2rgfn59u1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 28 Mar 2019 00:55:26 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 28 Mar
 2019 00:55:20 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.51) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 28 Mar 2019 00:55:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQwMUXjLEKd+jsUWVYB1YM2dZybYB+iMDj7BdLgAoH4=;
 b=DqlzPVFa2mzDmQ4VJpxXtPFqwCClbuM2qEEZxDQH1QvWPDTTiTETjCRLGy3o6k8WrD5LWlD4ys8hHGeDyAXN3urtmQagubtJ6z/OGncOJOAoYWLY6lQUU6PnCs656XcGTyBe27pw16Nz5tbE89Daqf+ed2Z2TCjsTyk64QVv4rI=
Received: from SN1PR18MB2320.namprd18.prod.outlook.com (52.132.199.158) by
 SN1PR18MB2253.namprd18.prod.outlook.com (52.132.199.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Thu, 28 Mar 2019 07:55:18 +0000
Received: from SN1PR18MB2320.namprd18.prod.outlook.com
 ([fe80::b547:18dc:b293:a852]) by SN1PR18MB2320.namprd18.prod.outlook.com
 ([fe80::b547:18dc:b293:a852%7]) with mapi id 15.20.1750.017; Thu, 28 Mar 2019
 07:55:18 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Marcin Benka <mbenka@marvell.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v2] efi: Unify dmi setup code over architectures
 arm/arm64, io64 and x86
Thread-Topic: [PATCH v2] efi: Unify dmi setup code over architectures
 arm/arm64, io64 and x86
Thread-Index: AQHU5TuWgd4zCEGqTkyZgrONBDO9fg==
Date:   Thu, 28 Mar 2019 07:55:18 +0000
Message-ID: <20190328075510.svjbjdonrncrr73m@rric.localdomain>
References: <20190320130502.16667-1-rrichter@marvell.com>
 <20190320131607.vgst3r7ynha55ikw@rric.localdomain>
 <20190320152240.2eun63wqkbqmuqkg@rric.localdomain>
 <CAKv+Gu8ta4ZSKwcFGOaf7XCam29ZrHkNowDjfdCpfQas=Xo7Fg@mail.gmail.com>
In-Reply-To: <CAKv+Gu8ta4ZSKwcFGOaf7XCam29ZrHkNowDjfdCpfQas=Xo7Fg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR03CA0007.eurprd03.prod.outlook.com (2603:10a6:20b::20)
 To SN1PR18MB2320.namprd18.prod.outlook.com (2603:10b6:802:2f::30)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [78.54.12.151]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4cdf4ec-5cfe-4de6-1877-08d6b352b85a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN1PR18MB2253;
x-ms-traffictypediagnostic: SN1PR18MB2253:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN1PR18MB22538CF83D1675137425D65BD9590@SN1PR18MB2253.namprd18.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(136003)(376002)(346002)(199004)(189003)(316002)(106356001)(305945005)(25786009)(4744005)(76176011)(52116002)(14454004)(229853002)(66066001)(186003)(4326008)(8936002)(99286004)(966005)(3846002)(386003)(102836004)(6116002)(5660300002)(1076003)(26005)(54906003)(93886005)(53546011)(6506007)(97736004)(476003)(71200400001)(256004)(71190400001)(81166006)(486006)(11346002)(8676002)(81156014)(68736007)(6512007)(53936002)(86362001)(6486002)(6246003)(9686003)(478600001)(6916009)(7736002)(2906002)(105586002)(6436002)(6306002)(7416002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR18MB2253;H:SN1PR18MB2320.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +fpcDLphtwjdm0fuNgCPqh0MiYYS5iZRbp/MzxkbDmwqiToKSrflv+yGm1fguot+yLxt2JDhufrkH4f5EptETTSIVgCO5lEMP+Oc9+5HjdIHZU6ELLGdRQCq3su3QGG4l1T4d3P6A4pqzKfe2RrLmKnvkSLIIwxwdioo5kEkWGoS1XWh8RDvGKxDg+8p6bQovz4B4BJ1C6ryvFOwOLHZDtpkh8R0jFNM3lEHGlTQYE+3HRlFx6PiwKJjkZmAYe6nSlsDeqRHW2lMBp6VOzVvNqemZgwu+2PZZ0bruMj6afxGFSmS2rQqXUWpWme5nnVrVHMGoQJ7ts1ok7413UzhbqQuXikle7vMSF59whSSh2SFc/m2OXCy0QUkbZDRjreFgq4kAgOZYIHb15nXL6blZzcPHU8lYfd41GgUdyBFD58=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6D0D9D7F2C4DDB48A9D692CA80727D78@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cdf4ec-5cfe-4de6-1877-08d6b352b85a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 07:55:18.4308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR18MB2253
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-28_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.03.19 19:53:47, Ard Biesheuvel wrote:
> On Wed, 20 Mar 2019 at 16:23, Robert Richter <rrichter@marvell.com> wrote=
:
> >
> > On 20.03.19 14:16:07, Robert Richter wrote:
> > > On 20.03.19 13:05:37, Robert Richter wrote:
> > > > @@ -167,6 +167,7 @@ static int __init arm_dmi_init(void)
> > > >      * itself, depends on dmi_scan_machine() having been called alr=
eady.
> > > >      */
> > > >     dmi_scan_machine();
> > > > +   dmi_memdev_walk();
> > > >     if (dmi_available)
> > > >             dmi_set_dump_stack_arch_desc();
> > > >     return 0;
> > >
> > > After
> > >
> > >  [PATCH] efi/arm: Show SMBIOS bank/device location in cper and
> > >   ghes error logs
> > >
> > > wents in for arm/arm64, we can unify the code. See patch below.
> >
> > V2 with the fix in arm_dmi_init() below.
> >
>=20
> Could you please resend this as a proper patch? I am having trouble apply=
ing it.

I just resent the patch. But this worked for me:

 $ wget -nd -O - https://lore.kernel.org/patchwork/patch/1052718/mbox/ | gi=
t am -smc -3 -

Not sure what was wrong.

Thanks,

-Robert


