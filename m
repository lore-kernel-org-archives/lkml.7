Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A541C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A78920637
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mm18gwiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfKZKDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 05:03:44 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:37186 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727557AbfKZKDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 05:03:43 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ddcf87b0000>; Tue, 26 Nov 2019 18:03:39 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 Nov 2019 02:03:39 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Tue, 26 Nov 2019 02:03:39 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Nov
 2019 10:03:38 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (104.47.41.55) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 26 Nov 2019 10:03:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjYQPbMPyyA4C8BrOD+sC9PNu27IilIs+TSB+hPDz81L341HlnTMip93H0KTfq88Wq+IcRq/tQom++xDVgeYmVQ++SIffI8PoAeI17mwgXoN4ZE/270vCq9vCTBRbesz/gsS+mpHJ9jbsi6P6Bia3UoV5jsKPiBH5JEIEyyv4YINNUGrJhVchFASq232ETnhycpVAL1bFGP4h/qd9o+Iydj2ZgVDnFOMhCJ7ijMiEv7fhZ76NtmesigzXVVfBhZPUOIqCwCq8L948UxsyQozOd83+qQFUgnZaPTiVD+mdd6eP5Rp/rLreh1yG9peDMiESqwKfYMz4NpNsTuHjbrvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCUz/3I4esOCmkaOsUuYOG8gu2Mosrqt8F3JbuwR1Cw=;
 b=YtdT6SAP0Y27vQdxvBzor82nn+u+8LSeh1OQ1xg88uJ+u46s5dNRA8lMPxZzHtfAv4Ulijb+ZG3pR16RjnqoURoqOiGKEAcMCD8oAH3R5iSmVRX6BH4WWgBz6KPeTjNoy2pU1LavVqxo6sjoLPG6FGdTfO4+UMTt69KqCsqxXRGQqsUKJYrlNylx6/S23ebzbhnrVGKkC/jB0GQ7ygbyvuy2evpQ+YQs1mmGMPloabIKE6tn9+xWi9tmYOeVCw4ogfC36T23LN+T4H5vkQ09xcdXsEWuy9tkDakB3U7egvnoBNXHVpv9SmVpsGMzx50DB/YLDQUOK2Hulg+kXZI5Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from MN2PR12MB3389.namprd12.prod.outlook.com (20.178.242.161) by
 MN2PR12MB3583.namprd12.prod.outlook.com (20.178.241.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Tue, 26 Nov 2019 10:03:35 +0000
Received: from MN2PR12MB3389.namprd12.prod.outlook.com
 ([fe80::457a:dc11:397f:d4ce]) by MN2PR12MB3389.namprd12.prod.outlook.com
 ([fe80::457a:dc11:397f:d4ce%7]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 10:03:35 +0000
From:   Henry Lin <henryl@nvidia.com>
To:     Peter Chen <peter.chen@nxp.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Romain Izard <romain.izard.pro@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: f_ncm: fix wrong usb_ep
Thread-Topic: [PATCH] usb: gadget: f_ncm: fix wrong usb_ep
Thread-Index: AQHVoCLus26pLsIkukm9vcuV6VVAeqebTyAAgAG/7WqAAA5WAIAAH+35
Date:   Tue, 26 Nov 2019 10:03:35 +0000
Message-ID: <MN2PR12MB33894E3D1D9AC14B8C9E2966AC450@MN2PR12MB3389.namprd12.prod.outlook.com>
References: <20191121041858.15746-1-henryl@nvidia.com>,<20191125042039.GA10953@b29397-desktop>
 <MN2PR12MB33899F0DEEA0A22086ACE0ECAC450@MN2PR12MB3389.namprd12.prod.outlook.com>,<VI1PR04MB53277359AF0E283AE948F34C8B450@VI1PR04MB5327.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB53277359AF0E283AE948F34C8B450@VI1PR04MB5327.eurprd04.prod.outlook.com>
Accept-Language: en-US, zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=henryl@nvidia.com; 
x-originating-ip: [59.124.78.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f165d0b5-f4df-4150-384d-08d77257e6bb
x-ms-traffictypediagnostic: MN2PR12MB3583:
x-microsoft-antispam-prvs: <MN2PR12MB358332EA4172D8F84D9568DBAC450@MN2PR12MB3583.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(189003)(199004)(66446008)(66946007)(64756008)(66556008)(7736002)(14454004)(91956017)(76116006)(66476007)(478600001)(71200400001)(54906003)(5660300002)(33656002)(52536014)(66066001)(71190400001)(6116002)(99286004)(256004)(8676002)(14444005)(81156014)(81166006)(74316002)(3846002)(305945005)(6436002)(2906002)(229853002)(7696005)(76176011)(11346002)(446003)(186003)(26005)(6916009)(316002)(8936002)(6506007)(102836004)(6246003)(9686003)(55016002)(86362001)(25786009)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3583;H:MN2PR12MB3389.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pFHsgNm+tLa0bUkTto8YrVvOOwZbziF/HEHLaxgy1Yr8mljhylWrRherLrsMQK4NbGjzJhGB2ZhzhYCjv8ednHQyCk9q08s/yktcm3zY4kh0iJtRIKrIrRB6Pq0cHazW5e1l/PPcXOkenzbtdog9nM5sxPgRGp2JcHIBZfNL/VBRlP5qMv8zU/FOgrKfth77c/Dszeaqvv7UiXeaUY8hRT6f/CWVIxEpEtupnHjh29Tn/LxUMPPhWD9fd4N9lVwyhxIqxE2MI2zVfG/T9SRWNOej8cVJeYy/MP/8SIhizptYKHhgafjwHz4OaxAWQgTdK0nyFr7mpaVDtJ87Y4PLmwwFxKFLjJVTt4jSa8kFzi9Aj2H/FigUM1MgsGxMhV09ZvFOn+NHTm92iAxs8zCrFrc77Bs+bM1yYkcoWbJi6ZhWm267cSgRzoLrN3nZXQwc
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f165d0b5-f4df-4150-384d-08d77257e6bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 10:03:35.0777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vjdeuVkdQgGqA5tzLleEr4NAogss5rlVyL3C/tB6HGU5XvHT4kDuel1ga2jXkd5mNEPeOr6ZanJCTGJxa3AHjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3583
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574762619; bh=XCUz/3I4esOCmkaOsUuYOG8gu2Mosrqt8F3JbuwR1Cw=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-ms-exchange-transport-forked:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=mm18gwiLQ+NcBljt+eWqADqTjCSYod/S8GOGo2q5umLKKnlip8fhBNWU9peSeLorD
         zK23lT0yy3SWlY9+kX1eO2tRoTuxxMIzFg66/EuHmoUe68bgUJ3jAdvqe0JPxBwLMi
         WoTJYa2jY4zXzC35/aifkKw5fMrAPBToQmI1Tn1ozw/qIsLB8ZOckbh54Ho54Gc8QJ
         Pqn1lbFwEhlI166EM8bwYtFq3UFyzCI6ux7qV2V3J8qV/0acU8luWEKRrcPScjCZ+g
         tLx08dbAhkgoiQHS7Mbp+CqtaJw4UtLuSNzOvls3ENePUSq5EKFL9d/dC10EznDrNd
         rKQ46WXla36hA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> >Would you please share the use case how to reproduce it?=0A=
>> We checked again and found NCM gadget driver should not have this issue.=
=0A=
>> Please ignore this patch.=0A=
>>=0A=
>> However, we still observe similar issue in ECM and RNDIS gadget driver. =
Take=0A=
>> ECM as example, if we plug ECM gadget in high-speed host port first. And=
, the host=0A=
>> only set interface with alternate setting !=3D 1 (alt !=3D 1 in ecm_set_=
alt()) for ECM=0A=
>> gadget. Then, if we unplug gadget from high-speed host port to another s=
uper-=0A=
>> speed host port afterwards, we will see both in_ep->desc and out_ep->des=
c in ecm-=0A=
> >port keep values for high-speed endpoints. Although NCM's implementation=
 is=0A=
>> similar to ECM in this part, NCM doesn't have same issue as it only does=
=0A=
>> config_ep_by_speed() under if alt is 1.=0A=
=0A=
>Does your UDC driver call composite_disconnect when disconnect from the ho=
st?=0A=
>It should set all desc to NULL at related function ->disable.=0A=
=0A=
For ECM case, if ecm_set_alt() gets called with alt =3D=3D 0, in_ep->desc a=
nd=0A=
out_ep->desc will be set up. But these two ep will not be enabled as gether=
_connect()=0A=
is not executed. During disconnect from the host, ecm_disable() gets called=
 with ep=0A=
disabled. In this case, gether_disconnect() will not get called to set desc=
 to NULL.=
