Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84254C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A461216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="k2pk84En"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfK1JV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 04:21:57 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:48953 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfK1JV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 04:21:57 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ddf91870001>; Thu, 28 Nov 2019 17:21:11 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 28 Nov 2019 01:21:11 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 28 Nov 2019 01:21:11 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Nov
 2019 09:21:11 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.53) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 28 Nov 2019 09:21:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibFEnkMpwCi1f/Xf2kDZoT9kfdi1sVr7wm5EkEXW3xcuRovHSMCCEHgZtDafDEUWg/fKk0wI7oL+uRh7WBx+7tELPJPLtJ4gPHktJ92brPRRoUqbHJfVS+nrbs5OR2JrCJn4WylMyt4Qz1V0mqNmxPD+9N/x3iuKsCFQ1HMNtObgsFdFiL6FytZs99qU6RImYU/Lsq72Dc4B/1f5d7Z/KBN/pIF+h8eOAsTUrdMEFJf7Z74kjAaPLR3oKfSufUMxcAXfxKno1OeQlVHguWTgpagGeJsxXhFkz3BnsYGIHsJzqHPy0FiXwcFUm+HtPYSaov+KXvhHC7/jCrx/fUdDrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wy4iaTloM7+Gs5azlBg0dcZ7PJkh1HmJ2bmBMWp4qMY=;
 b=eW1ycjggd/+Mt00zdMnG3V1jCP758heevDIrQpHxqbb/okN4xHdk5xngNhjo1YktI3t2GEryIIl0DjuEDhP0P9aoIM/ejafgC/cITktbnalDJNsGgWkyCcMWxiubKFnMiw8Fu5m1ovVpHdbSWx1kSN63+jzLbZ7UqIxtmQ5diMSlHsn7uC/oo7KgLZiA6hyv/HG/Q0pDSGf1P1WAqYpv05iVp5j42V4xPVtt06uACeAvhVUeMFu2tjSu+8xceAMtUy3is0YstxXMJQP3XeOS4GP3kPfkDDhjIMita6wItLjbJ6w8UX78+JzsnBMyZiMTgM3eCqMcUuLghXD1uPVclw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from MN2PR12MB3389.namprd12.prod.outlook.com (20.178.242.161) by
 MN2PR12MB2911.namprd12.prod.outlook.com (20.179.80.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Thu, 28 Nov 2019 09:21:08 +0000
Received: from MN2PR12MB3389.namprd12.prod.outlook.com
 ([fe80::e03a:9150:cda:2dbb]) by MN2PR12MB3389.namprd12.prod.outlook.com
 ([fe80::e03a:9150:cda:2dbb%4]) with mapi id 15.20.2495.014; Thu, 28 Nov 2019
 09:21:08 +0000
From:   Henry Lin <henryl@nvidia.com>
To:     Peter Chen <peter.chen@nxp.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Romain Izard <romain.izard.pro@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        EJ Hsu <ejh@nvidia.com>
Subject: Re: [PATCH] usb: gadget: f_ncm: fix wrong usb_ep
Thread-Topic: [PATCH] usb: gadget: f_ncm: fix wrong usb_ep
Thread-Index: AQHVoCLus26pLsIkukm9vcuV6VVAeqebTyAAgAG/7WqAAA5WAIAAH+35gAENlwCAAg41Vw==
Date:   Thu, 28 Nov 2019 09:21:08 +0000
Message-ID: <MN2PR12MB3389A88286B9A8348596F947AC470@MN2PR12MB3389.namprd12.prod.outlook.com>
References: <20191121041858.15746-1-henryl@nvidia.com>,<20191125042039.GA10953@b29397-desktop>
 <MN2PR12MB33899F0DEEA0A22086ACE0ECAC450@MN2PR12MB3389.namprd12.prod.outlook.com>,<VI1PR04MB53277359AF0E283AE948F34C8B450@VI1PR04MB5327.eurprd04.prod.outlook.com>
 <MN2PR12MB33894E3D1D9AC14B8C9E2966AC450@MN2PR12MB3389.namprd12.prod.outlook.com>,<VI1PR04MB532730D2E1BA4108B37155D08B440@VI1PR04MB5327.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB532730D2E1BA4108B37155D08B440@VI1PR04MB5327.eurprd04.prod.outlook.com>
Accept-Language: en-US, zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=henryl@nvidia.com; 
x-originating-ip: [59.124.78.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d8971cb-a62a-42ad-8d9f-08d773e44d4a
x-ms-traffictypediagnostic: MN2PR12MB2911:|MN2PR12MB2911:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB29112F5E7A1EAE3B7E6E19C4AC470@MN2PR12MB2911.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(189003)(199004)(52536014)(6506007)(76176011)(7696005)(102836004)(446003)(186003)(26005)(11346002)(33656002)(316002)(99286004)(54906003)(71190400001)(71200400001)(86362001)(9686003)(256004)(14444005)(55016002)(6436002)(6116002)(3846002)(6246003)(229853002)(2906002)(478600001)(8936002)(107886003)(81156014)(81166006)(8676002)(4326008)(7736002)(74316002)(305945005)(64756008)(6916009)(4744005)(91956017)(25786009)(5660300002)(66556008)(76116006)(66946007)(14454004)(66066001)(66476007)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2911;H:MN2PR12MB3389.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NmPvt5qQ0FpNLhPgy/DI6Fe+hBdcNptv+ohmsPYT53kVD078XVZHK0wWpnGgyxKXLu8l+AcBtkIuAQVRbfW1vi869fdrSTgYwxFtIEk5DROtG+NMT6jF9mbCw6QP707S6mOoMED83BXtBPhvSTOkNkMkoEWlTVdLEhbdJ8pbukpYCQqNt8Vv/EDkpvSBc3Oekd5SnkwOdkk5qIv7J47K6GwhSQuPWTR5r9MwnoL1oSMBY6RkEHmKkoK/h/jOyBgjy0Qb+XOa4bcsbzpBNlBcyp5zqofoILqdJkjIztVltWw+nzOM9ToJRAG3hD4TPIij/Jk3+JvoFO/jfUigk8D6ZhvqJ78R8zEEbWtivpMQzeXlah5SPgLHUPEUPdrRbfQB+FKfbntPeHPhy+RJ7Uk3cyDXQlN59C7oul6TrANx4CtyRDv48KaxPD/49v3NALEn
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8971cb-a62a-42ad-8d9f-08d773e44d4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 09:21:08.0734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DpTNLd5s1gEz5upX1/UjHCz5Uws4AZbIgnhvz0far+iB3+Uhva5XND+xtMVoA/lFMHP13v6sZ9sq3lQGbjXPBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2911
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574932871; bh=wy4iaTloM7+Gs5azlBg0dcZ7PJkh1HmJ2bmBMWp4qMY=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-forefront-prvs:
         x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=k2pk84EnpUQlpfrF2FniLKyas3o22UalFml4lChL6Vqgqtp9Wbz2VShxhIUQ/iJ5y
         HbyK4UvpumW0y306LI1ifV6S56uAoOrOuqdVgDnekxA0PvHglu7Wqow2wsvOtFRgLY
         mvMNboPfNoihXbyyuMYqX4rogkf5lOQIP+HHb69QnGQ4BpTvZwUYaTTRI+kmqpgcOD
         /8mSuAwCZ1iWDRJvul9BeKy+t3naSHgygm8sahbHySbzcV03QAWVClHh9FY3in0M2Y
         VXsnkAvh0QwDOm8NZ+Kuo0su0MqxNyQGYgOhVOlVe4B0Cb/6endagJ9/dHsJrLmmOg
         WkMH/5Qpp7BcA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> >Does your UDC driver call composite_disconnect when disconnect from the=
 host?=0A=
>> >It should set all desc to NULL at related function ->disable.=0A=
>>=0A=
>> For ECM case, if ecm_set_alt() gets called with alt =3D=3D 0, in_ep->des=
c and out_ep-=0A=
>> >desc will be set up. But these two ep will not be enabled as gether_con=
nect() is not=0A=
>> executed. During disconnect from the host, ecm_disable() gets called wit=
h ep=0A=
>> disabled. In this case, gether_disconnect() will not get called to set d=
esc to NULL.=0A=
=0A=
>Would you please share your test case? I use Linux host, and the host will=
 always set alt for 1,=0A=
>and doesn't have this issue.=0A=
Using Windows host (without any proprietary NCM/ECM driver installed) can r=
eproduce set alt=0A=
to 0. We just used Win10 to confirm this.=0A=
