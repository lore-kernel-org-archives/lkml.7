Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B611DC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823A021A4A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="aRoUySdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfJKI7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:59:25 -0400
Received: from mail-eopbgr800073.outbound.protection.outlook.com ([40.107.80.73]:16992
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726310AbfJKI7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 04:59:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYUz9MuZaA1lCuziKgxtI7YqqJHA1PNJbwY4EcpIXZBDQNhXmrYDeZ/ik02Xgvep6zvgUFj6HJm9MXX6EKgfw7h6cQ7FX2+wHVBsjxlOsZ0pePrewG0w8RSo4Bk1u9iHhaDa64QUDBmN6iy01/BrFBI5UBRwqbnV7rEwhD3kIwxGaA87XOmC+8gKx3ZELwuhKknxIc5N4fvT0Y2JAQe+PHSKyMZhXODOiQ3o+rGvJlRZyOe8s1UdJa8neyFlXCOV/FLAtJO+QmCeA/lMTmdp250uiFVQsj5ZQbSQnelw88Ccq+M2BBnXR2D7Yr2hATPl/Xvy/39CPqBZrkdXjjKnUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IZfKVvhJxysuojyZ5QV2VmweEsaDOf6yWOHK2Dg0Bs=;
 b=Btq1pYci6l9zwMh14RChsLe40ieSRRP185Zeem7+d2kWFo6Fam32WM4yXAA7VKCuPGNZezuC5Ivize+fP8ZRH247OigkT1JserCYKRQo5tcElD8fYExgxauomD6J3n9L9pGTNgnMNGpY392hqLCS6qkehG2DOG2XBuSMYTAKA9wQmQFiLrU2vLe1xRP2sBxkSBduExqxDadIkUhG8SZutnIl5MzPEkPOMyYM4tdW2rrOo6pC24VwbH7EXsFcFf7CpO4Go+cFlz8jVUJQc9tt7WfUQFoVQciWoiLXLNxoAbhYL6xQEqnM4/fcBLbxHl2v6mIpo+n9JQghzGp+0lkMiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IZfKVvhJxysuojyZ5QV2VmweEsaDOf6yWOHK2Dg0Bs=;
 b=aRoUySdRehRP2KSi5qoGAPzWCh3otA7dE7cF/1ag3b7t/l/3NdZnGMeP/RehgVHdudUCbBk9c/F0apPYMvq+wkw95KniGUa5Aac/YKjWdhZESozOUAJEZvQ7I+zoCoshaJUeZfN57sSHoCAVeQmPO6nfO646TRsARXh5f7m9Wj0=
Received: from CH2PR02MB6359.namprd02.prod.outlook.com (52.132.230.25) by
 CH2PR02MB6455.namprd02.prod.outlook.com (10.255.155.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Fri, 11 Oct 2019 08:59:22 +0000
Received: from CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::691b:556b:b63d:6482]) by CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::691b:556b:b63d:6482%6]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 08:59:22 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>
CC:     Derek Kiernan <dkiernan@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH] docs: misc: xilinx_sdfec: Actually add documentation
Thread-Topic: [PATCH] docs: misc: xilinx_sdfec: Actually add documentation
Thread-Index: AQHVeUNjgR5wSI9FSUekjWo2K94HoadUg5CAgAAA84CAAK0BYA==
Date:   Fri, 11 Oct 2019 08:59:22 +0000
Message-ID: <CH2PR02MB6359973E7718EC50FE36E9C6CB970@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <201910021000.5E421A6F8F@keescook>  <201910101535.1804FC6@keescook>
 <20191010163905.70a4d6e1@lwn.net>
In-Reply-To: <20191010163905.70a4d6e1@lwn.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04e3c25d-dc10-496e-2519-08d74e294f16
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: CH2PR02MB6455:|CH2PR02MB6455:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB6455F0ED056A45276B2B787BCB970@CH2PR02MB6455.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(199004)(189003)(13464003)(55016002)(6116002)(3846002)(54906003)(229853002)(64756008)(66446008)(66476007)(33656002)(110136005)(99286004)(4326008)(9686003)(6306002)(66946007)(66556008)(76116006)(6436002)(316002)(86362001)(6246003)(25786009)(7736002)(305945005)(52536014)(5660300002)(74316002)(66066001)(81166006)(81156014)(8676002)(8936002)(14444005)(256004)(71200400001)(71190400001)(186003)(14454004)(966005)(6506007)(53546011)(478600001)(76176011)(102836004)(486006)(7696005)(446003)(2906002)(11346002)(26005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6455;H:CH2PR02MB6359.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I4PiRCdOJmTfaIP0Ipsc5t04AxXh6rpW6BvYu4wdaktoJYjk8P4/WV/FU8Qw4nrvmgm+97LItZ8qSg2AS9bAhwi1YoPwahP9Fmxp0hWInMCSRNpd2NNTBNjmn40qq7UJN9XZzU5hvd2hyGyfY0toMnZ48jZrqvx7XK2n7CPC5GMm1/yKBVVt+SMGyKQfOukhWMxAfPVtjzsgfVsk9Ajp7PmJGS35w8ezlBWzf6fKeYuNTN2gCPNSHKrdGkm5Wwbq615X3ZuMm0ykWaREaBRtQQomFWcKCBITLp3eiL04rpl6GS980gdNgMtNCEZth1eKgxPSeWTOI1MlnDvDZ0WcjzSOQQv0k2pZJxCTXupX7FXICKanU+tMKAxCMsvZNBlsVHpHS8IpVD043uRJtRq5uyYOpRP8hz1DWKH2E8GPUt9yI77xm1YRf+PB3fbEbRK0aHJsUeP1KWrAPeFtEN51eA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e3c25d-dc10-496e-2519-08d74e294f16
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 08:59:22.2182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2IntSrI6BLcUEdtbFHDakbC/6W9O4Q6pWGP2agr69jGtNc/GTxCk3ZF6y8+oUpBKw7ezsjZR3F/est5/yD9vHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Yes, please add the file.

Thank you
Regards=20

> -----Original Message-----
> From: Jonathan Corbet [mailto:corbet@lwn.net]
> Sent: Thursday 10 October 2019 23:39
> To: Kees Cook <keescook@chromium.org>
> Cc: Derek Kiernan <dkiernan@xilinx.com>; Dragan Cvetic <draganc@xilinx.co=
m>; linux-kernel@vger.kernel.org; linux-
> doc@vger.kernel.org
> Subject: Re: [PATCH] docs: misc: xilinx_sdfec: Actually add documentation
>=20
> On Thu, 10 Oct 2019 15:35:41 -0700
> Kees Cook <keescook@chromium.org> wrote:
>=20
> > On Wed, Oct 02, 2019 at 10:03:55AM -0700, Kees Cook wrote:
> > > From: Derek Kiernan <derek.kiernan@xilinx.com>
> > >
> > > Add SD-FEC driver documentation.
> > >
> > > Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
> > > Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
> > > Link: https://lore.kernel.org/r/1560274185-264438-11-git-send-email-d=
ragan.cvetic@xilinx.com
> > > [kees: extracted from v7 as it was missing in the commit for v8]
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > > As mentioned[1], this file went missing and causes a warning in ReST
> > > parsing, so I've extracted the patch and am sending it directly to Jo=
n.
> > > [1] https://lore.kernel.org/lkml/201909231450.4C6CF32@keescook/
> > > ---
> >
> > friendly ping! :)
> >
> > -Kees
>=20
> It's sitting in my queue.  I was hoping to hear from Derek that it was OK
> to add...Derek are you out there?
>=20
> Thanks,
>=20
> jon
