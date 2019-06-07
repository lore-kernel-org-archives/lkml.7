Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D33C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BEE208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="IV5rdcFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfFGK6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 06:58:38 -0400
Received: from mail-eopbgr680086.outbound.protection.outlook.com ([40.107.68.86]:26849
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728323AbfFGK6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 06:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vt6qoelTKHrMvuE1NywSjFEzIxJLjE+/50Vli2jX3Tk=;
 b=IV5rdcFL9DfmqcIuPodVD4DvWOZHCOIFMNgefbH4n1b4Ke0xrNZATedVODZJe7OPxB/LZQ2vAFnLnRwEgAgFLKDcBxWqIwl0JiDpctcJy1Dc8rjdwL6Ic8liW52aWQzSgSYdrEmzknGnGFzDsfmOvqAHG1421005mwb5gMTH9Io=
Received: from CH2PR02MB6359.namprd02.prod.outlook.com (52.132.231.93) by
 CH2PR02MB6071.namprd02.prod.outlook.com (52.132.228.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Fri, 7 Jun 2019 10:58:34 +0000
Received: from CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::b9dd:11e0:7fca:ba55]) by CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::b9dd:11e0:7fca:ba55%5]) with mapi id 15.20.1943.023; Fri, 7 Jun 2019
 10:58:34 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>, Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <dkiernan@xilinx.com>
Subject: RE: [PATCH V4 04/12] misc: xilinx_sdfec: Add open, close and ioctl
Thread-Topic: [PATCH V4 04/12] misc: xilinx_sdfec: Add open, close and ioctl
Thread-Index: AQHVEu5GErREaULonk+tvtDvF1CkjaaOsacAgAFm4tA=
Date:   Fri, 7 Jun 2019 10:58:34 +0000
Message-ID: <CH2PR02MB6359747C72220A978CCA807BCB100@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <1558784245-108751-1-git-send-email-dragan.cvetic@xilinx.com>
 <1558784245-108751-5-git-send-email-dragan.cvetic@xilinx.com>
 <20190606132842.GC7943@kroah.com>
In-Reply-To: <20190606132842.GC7943@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d509c819-b61d-4030-ffa5-08d6eb3715ce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR02MB6071;
x-ms-traffictypediagnostic: CH2PR02MB6071:
x-microsoft-antispam-prvs: <CH2PR02MB60715F8289A11E5E3EA43124CB100@CH2PR02MB6071.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(396003)(346002)(39860400002)(189003)(199004)(3846002)(71200400001)(6116002)(14444005)(71190400001)(316002)(74316002)(66476007)(99286004)(14454004)(256004)(86362001)(305945005)(478600001)(6506007)(54906003)(7736002)(64756008)(73956011)(102836004)(66446008)(76116006)(66946007)(2906002)(9686003)(7696005)(76176011)(66556008)(186003)(6916009)(4326008)(8676002)(68736007)(6436002)(81156014)(81166006)(4744005)(53936002)(8936002)(229853002)(486006)(25786009)(26005)(476003)(446003)(5660300002)(11346002)(6246003)(52536014)(33656002)(66066001)(55016002)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6071;H:CH2PR02MB6359.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DTCTOtaFLVMVjg/MpBGLkAR86bmZd8vSP2g23e2ggu48E+FL2cC9WKBFU9cXAApevXkck9LoFapvLgUg8PZOC19fC/uvpAAQoNjiXvbu1GvvQ00d/2e84zWNsjqJrZrQZ7pVsztpZUxsy9BftkRI1ecYWYQTQcE4N34s4H2lTWkZGHqXEIXWB07Ky9U0a2IocOkoLfIKufBjy3dj1Eh6wKcRVSCkMhuTexI/Ll7Fb1r0NVs0A24qLB+86uLXy88Fyo/x9rM9Eiep2uMezVfQC4vXeVL0KAzUeyV7ApCvE6iXL221uFgGR2UDMEZa1fWfeVFvJWhvOAV+iI76DXD2v4dy+zWUYMMugpMfu0vc0jBM+po7zjOtaUzY03F6SsuB5d5kqDIujNDD4LCtoJP++oDiPb2oDrg13bZ5iaGondw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d509c819-b61d-4030-ffa5-08d6eb3715ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 10:58:34.0280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: draganc@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, May 25, 2019 at 12:37:17PM +0100, Dragan Cvetic wrote:
> > +static int xsdfec_dev_open(struct inode *iptr, struct file *fptr)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int xsdfec_dev_release(struct inode *iptr, struct file *fptr)
> > +{
> > +	return 0;
> > +}
>=20
> empty open/close functions are never needed, just drop them.
>=20

open() is needed to allocate file descriptor eg.
fd =3D open(dev_name, O_RDWR);

Please, advise if you have some other idea in mind

Thanks
Dragan
