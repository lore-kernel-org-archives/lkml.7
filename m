Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A61DC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502CC206DA
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="gYI0Ha/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfKTTIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 14:08:52 -0500
Received: from mail-eopbgr730054.outbound.protection.outlook.com ([40.107.73.54]:40672
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726634AbfKTTIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:08:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTpftedokf5WrcpYfbx7g2QZrq091u9rbj+UEkT1okJOEKwo2dIqjvrC3KY59cPgRlZgwZ0v0F1N/0vx2+OZV+TeZoI3UQxiFTzM19a/Xno2tpFgkgDrzvkGXiqzppJF8MQVBBnKBnPyVDgD2IKqo0MAu7PwJIHtbilmB3X+fJww184WSWIHOZZ6KSXTBCOBTcKu22RprpOfTQxwImKWZJzXiU+2DAN1Jv4x/Ihg7GjELZqYTdS5ibW2MXqO8zi/uz0qF0O5MNL2KtpIY+Fjufy9F++he+4RV2sWwJQzv0Aeb467A8I0WG89WlFZjVU4kliOiMFQuVJ3XAFy3ZnKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prW9p7/6ffhCc0rfTfLLUtbekk/fgldFk/xQBPUuz2g=;
 b=HA1xfBz7ZQAh/4xO08/ALlxxa9+vmscCqNpYxNdeJOx5kj2dNGjGUozNWTq7GVGtLwyXSJ/ZnVYLprgjxHvMGmm/pH5wUzyHrf3cbJjbPjNRoUIsjKoy4iAARcsr9gvSLdGCmYIqbW8T01aA4dt+QDh1OaMfKoUXKxqp8koK3b5Oj8KDz2CiI9yIZFdfLlxiUUOhwWNiG+sBZGUNgA4ZtsamvYvE2lKNlIHZOiJ01CN1yVNkNeQWX5OHlwshUg4ny4y8u/UUs62dk45GzEe6aIOhtIgd7iSYTgUgfxVcDcSTng5SbARt93ZZtyMkA37Pla3AFtyhQx87hKkhBpdcDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prW9p7/6ffhCc0rfTfLLUtbekk/fgldFk/xQBPUuz2g=;
 b=gYI0Ha/4PuymkcWMvhl8/R18Qv4nunRLF3/tQAoJRUbjscWmDELL0FE3+b60LI0bzY96XutRUjkRI7axyfUMsxhK1F2aV7y55OMDp3aVZ5z5FQo0bze7V8q0tTySo/XmKwonLbqRZskKez7jpLSs+RhgxkV9cvwYFZ5qhr2w8+k=
Received: from CH2PR02MB6359.namprd02.prod.outlook.com (52.132.230.25) by
 CH2PR02MB6150.namprd02.prod.outlook.com (52.132.229.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 20 Nov 2019 19:08:49 +0000
Received: from CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::e81d:489c:2bd7:918a]) by CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::e81d:489c:2bd7:918a%7]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 19:08:49 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <dkiernan@xilinx.com>
Subject: RE: [PATCH] misc: xilinx_sdfec: fix xsdfec_poll()'s return type
Thread-Topic: [PATCH] misc: xilinx_sdfec: fix xsdfec_poll()'s return type
Thread-Index: AQHVnzbvRwd5Ss/ZH0ugJQL96aPqOKeUNshQgAAkIoCAABHVkA==
Date:   Wed, 20 Nov 2019 19:08:49 +0000
Message-ID: <CH2PR02MB6359A3A9D842021B15E89E7BCB4F0@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <20191120001030.30779-1-luc.vanoostenryck@gmail.com>
 <CH2PR02MB6359CE45D06E908634CDA855CB4F0@CH2PR02MB6359.namprd02.prod.outlook.com>
 <20191120180229.frd5padrsdxf7hag@ltop.local>
In-Reply-To: <20191120180229.frd5padrsdxf7hag@ltop.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0db8a9bc-c31a-4717-1dd0-08d76ded1332
x-ms-traffictypediagnostic: CH2PR02MB6150:|CH2PR02MB6150:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB61503E147EBC52079B08C0B5CB4F0@CH2PR02MB6150.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(13464003)(189003)(199004)(51914003)(2906002)(9686003)(55016002)(6436002)(71190400001)(3846002)(6116002)(6246003)(305945005)(33656002)(7736002)(74316002)(99286004)(107886003)(66066001)(486006)(54906003)(316002)(229853002)(66946007)(5660300002)(11346002)(446003)(476003)(4326008)(71200400001)(186003)(64756008)(66556008)(14454004)(256004)(25786009)(66476007)(66446008)(81156014)(76176011)(7696005)(478600001)(102836004)(26005)(6506007)(53546011)(52536014)(86362001)(6916009)(81166006)(76116006)(8936002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6150;H:CH2PR02MB6359.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NkW1MhS43+CXdiBAXPNnbX0JhOZxb6NoL7w/CJb3Qdz8PkHLQGe7zwRbRw5RdNcB34GnLMCxJIzwELePWJmzhmb8I/QT4/iusCbMJQc/1vbV2uTTVTOWgFRq9hc57RKvzgpMCyKuAHgXD3XfI3L63ZN9VSKfXeRqkRw0Vz0qhiS3r0MmHhQqgVQEX3TKCH1XJ+WUDWQLdSvJ3BvmPbRoruANtUeTB4CcUBJN8b9Xt7zRMtJl0wjfynWD6Qnfx+QJkyFZafofKLuhoRcv/NBj7H6sRoeTDtm5/eQpwBt4cQH/xVcWoVqIYcs/AwXjkkOiVhHNAXW1eDAWNb39ru+vZ7LPKoRdIfxQ/JKunJtNb4lbk0BRYCD/E4QvPBGE0kgttCJrjjKUeFwehd8rSbCLxv5BFztKHKiU6Woi5tPApim8T8o4n994iEv02/nSc2pw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db8a9bc-c31a-4717-1dd0-08d76ded1332
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 19:08:49.1943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r0efDqtYW18IlrKd9zmuYFjJRVJ/Uw52WMKMCmsgnYM196L7OVVpTO4K9JtXxcW44JnKJ5SX/2o+9zYjb4Fndw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc,

Thanks for the really useful answer.

I promise I'll test this soon.

Thanks
Dragan


> -----Original Message-----
> From: Luc Van Oostenryck [mailto:luc.vanoostenryck@gmail.com]
> Sent: Wednesday 20 November 2019 18:02
> To: Dragan Cvetic <draganc@xilinx.com>
> Cc: linux-kernel@vger.kernel.org; Derek Kiernan <dkiernan@xilinx.com>
> Subject: Re: [PATCH] misc: xilinx_sdfec: fix xsdfec_poll()'s return type
>=20
> On Wed, Nov 20, 2019 at 03:59:24PM +0000, Dragan Cvetic wrote:
> > Hi Luc,
> >
> > For the sake of my understanding I'd like to ask you when the .pole met=
hod is defined
> > Why I'm asking this? I have a fairly new book (published in 2017) which=
 suggests what is implemented in SDFEC driver.
> >
> > I'll test your suggestions and will come back to you soon.
>=20
> Well, yes, it changed in July 2017.
>=20
> The current definition can be found in include/linux/fs.h:
> 	struct file_operations {
> 		...
> 		__poll_t (*poll) (struct file *, struct poll_table_struct *);
> 		...
>=20
> The main commit making the change is:
>     a3f8683bf7d5 ("->poll() methods should return __poll_t")
>=20
>=20
> The result can be verified by compiling the driver with the command
> 	make C=3D2 path/to/the/driver.o
> which will use the static analyser 'sparse' to make additional checks
> where the difference between 'unsigned int' and __poll_t will matter.
> See Documentation/dev-tools/sparse.rst for more info about it.
>=20
> Best regards,
> -- Luc Van Oostenryck
