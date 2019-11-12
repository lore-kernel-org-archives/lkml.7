Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5CCC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279132067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="axfwgUDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKLHWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:22:52 -0500
Received: from mail-eopbgr1400109.outbound.protection.outlook.com ([40.107.140.109]:6160
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727024AbfKLHWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:22:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7lnHT5hBGpfjuSk5bmOtRW0fLPhin5rIZTZh1q+K7F/WnKWxtLKv48EhOp//Y72rKwBY6ZX0RcnTMIHTEnn1/u71sNfCB9niuCizR1W3LW67+64TvCGrT794bvnlyrokrdAYJtX409C6rUgF4dW8W6QBPpVW356A8hLSzr4eWmtPqv4o92o10bXN9ps/Ps8UoRK+UGXFL+0H0TRhYQSBwCVqujIAhfTkzz6jzeg78qYcLeRNgHqWnshUIKMrgah02xJoT68pHqnALr4Lr55K01ujtGeexWNrkTWMznmK40Js8nwlpdd/1laRV7rS7HIyY6Yj1ggu+7nkfWf/rO9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+kWtLO8I9AWFWJTpGclMMWHbl1vLM3/klEBeHLhD/E=;
 b=G1t9X0ahYLKwcONu+Q4SaMo8mCkyKO/4LdrvnzvPJUtLq4AzWxARbDm/rje905/q58+ptjpDUh2v7vsRC7zXpx80Bqme+/rTY/DnHt7eitqVm4cVKnNFeoy4W1d/wuXY+sGT77ImDR9pEIC5g8rIhingdyYzDA/I3kQ8F3TJIdqUexVZrH+nh5M/coQ13gY2nootGs0OcIBzCJ0NQlxfY8h12WGlebaXTYifwRkLJ6qRun2uZ0D5PkBdjuOPFGA4OfcY2w9x56OAxCYXDD6TIgzW1kAHgbfTygulff6NBkdL8jhlCr7+Ulix0TN92Zc1XE52cP1SmcYrkmMF6GeTew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+kWtLO8I9AWFWJTpGclMMWHbl1vLM3/klEBeHLhD/E=;
 b=axfwgUDhtZjrswm4KuMzdHasoq7IxkFGrH5tKkKsUDtLMlvX48/ANXkdtAQviPInfLc++79ep4bu3a4v22Dby3ApW2D7q+kH1VyOKW2mmK+ILBmDgqi3YbHmn1eZ/s7PZyMFKVMBUzvXxhDULTIMybYzB+incaPeE68jLy9n0H0=
Received: from TYAPR01MB2285.jpnprd01.prod.outlook.com (52.133.177.145) by
 TYAPR01MB4784.jpnprd01.prod.outlook.com (20.179.186.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 07:22:47 +0000
Received: from TYAPR01MB2285.jpnprd01.prod.outlook.com
 ([fe80::5b9:ce3e:e658:5b75]) by TYAPR01MB2285.jpnprd01.prod.outlook.com
 ([fe80::5b9:ce3e:e658:5b75%7]) with mapi id 15.20.2430.023; Tue, 12 Nov 2019
 07:22:47 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Greg KH <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>
CC:     kernel list <linux-kernel@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>
Subject: RE: patch in 4.4.201-rc1 breaks build (mm, meminit: recalculate pcpu
 batch and high limits after init completes)
Thread-Topic: patch in 4.4.201-rc1 breaks build (mm, meminit: recalculate pcpu
 batch and high limits after init completes)
Thread-Index: AQHVmJNrRrdhElUsAEGrCYk1pZy3yKeHBmQAgAAbXgA=
Date:   Tue, 12 Nov 2019 07:22:46 +0000
Message-ID: <TYAPR01MB228594797B8B61F329D85180B7770@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <20191111132451.GA1208@duo.ucw.cz>
 <20191112054104.GA1211223@kroah.com>
In-Reply-To: <20191112054104.GA1211223@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Paterson2@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9b352e8-2525-4bf2-8a96-08d767411e13
x-ms-traffictypediagnostic: TYAPR01MB4784:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-prvs: <TYAPR01MB4784A89EF0C84FB20B642533B7770@TYAPR01MB4784.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(199004)(189003)(11346002)(110136005)(5660300002)(3846002)(316002)(6436002)(476003)(6116002)(6506007)(102836004)(966005)(26005)(186003)(14454004)(2906002)(446003)(54906003)(66476007)(76176011)(86362001)(76116006)(229853002)(64756008)(478600001)(7696005)(9686003)(66556008)(99286004)(66446008)(8676002)(6306002)(8936002)(66946007)(52536014)(305945005)(25786009)(7736002)(74316002)(66066001)(81156014)(81166006)(486006)(256004)(14444005)(71190400001)(4326008)(33656002)(6246003)(55016002)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB4784;H:TYAPR01MB2285.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LVwnAt2+LeSNLmkR1fF7u6EkyaKfR3i3kg8/HIOQ4VAVTL77Q1M4OOH0hHAN34sM0k/MjpDbmLYJ30dPPr1MGASZ5kkhNG9bRvqHN2iVtHcgn1to+L3KO7j+iTDSXkz/xPoyh8RNNiMsNJ6Ev4TKrhILkw/X11A+EjyArYe6zKxsCElb/LD20MQKipyecxIolMKN6UIsXVsoM5yDz7kaN3YPGSuD7oELAk3S4xPnKAj7Oa3CyPVmkFzWCbfICf3x/WH3QNaSfoEnnIrO1CTfZbin9rDxhNLjIeQEGRZLDKK2d16q0XbTAlXcTmU3c3DCS2ojcJ+9sthJELwOoU5V7l0+MA2bfeKQ8CjPi0/ZhBWBlrmghWQ4zn8sEeoTJJCTLgM1EoqMFmU1Hq830XaqDXYUqJcTnZFeTz5RDVAWpodTo568BzkUZs2J4g/YKLnZWTar+9Yg4JYrq8Vry4VZpvL7EqlJOjQA/Ws3iBtjfeo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b352e8-2525-4bf2-8a96-08d767411e13
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 07:22:46.9407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qw5V3ZEjzmgwiIT1WtGIlsaPbEcut1VYRlHyayQhxokogaPAjbXceTxP3VmAP1ceKHInuOa2tKty7OS3lw1+jwj2JGbAjEIZNxtOL7zgMZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4784
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: 12 November 2019 05:41
>=20
> On Mon, Nov 11, 2019 at 02:24:52PM +0100, Pavel Machek wrote:
> > Hi!
> >
> > This seems to break our build with particular
> > .config. (cip-kernel-config/4.4.y-cip/arm/moxa_mxc_defconfig).
> >
> > commit df82285ab4b974f2040f31dbabdd11e055a282c2
> > Author: Mel Gorman <mgorman@techsingularity.net>
> > Date:   Tue Nov 5 21:16:27 2019 -0800
> >
> >     mm, meminit: recalculate pcpu batch and high limits after init comp=
letes
> >
> >     commit 3e8fc0075e24338b1117cdff6a79477427b8dbed upstream.
> >
> >
> >
> > Quoting Chris Peterson:
> >
> > > I've seen a failure this morning with our linux stable-rc build
> > > testing.
> >
> > > Version: 4cb9b88c651a2fff886dd64b6d797343e7ddb4dd Linux 4.4.201-rc1
> > > Arch: arm
> > > Config: moxa_mxc_defconfig
> >
> > > Pipeline: https://gitlab.com/cip-playground/linux-stable-rc-
> ci/pipelines/95016985
> > > Failure: https://gitlab.com/cip-playground/linux-stable-rc-
> ci/pipelines/95016985/failures
> > > Log: https://gitlab.com/cip-playground/linux-stable-rc-ci/-/jobs/3469=
74180
> > > Config: https://gitlab.com/cip-playground/linux-stable-rc-ci/-
> /jobs/346974180
> >
> > > All other configurations that we build were successful.
>=20
> Sorry, my fault, should now be fixed.

Yep. Working fine with Linux 4.4.201-rc2 (ca1d1b5f0f2a)
https://gitlab.com/cip-playground/linux-stable-rc-ci/-/jobs/347861814

Thank you Greg and Pavel.

Kind regards, Chris

>=20
> thanks,
>=20
> greg k-h
