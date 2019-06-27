Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F726C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AB52083B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Analogixsemi.onmicrosoft.com header.i=@Analogixsemi.onmicrosoft.com header.b="WESFCbhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfF0LYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 07:24:43 -0400
Received: from mail-eopbgr760139.outbound.protection.outlook.com ([40.107.76.139]:43207
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726816AbfF0LYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 07:24:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=T+3Bw3wjKsLg3qLrIG4eesjlCc4Blmokld2SZtxf43wbnGTzjLP6j0gIKcOkJvdSz2A1fdzUJdCvu87RS2WkUryJdxjilwY3sTG3IlVRAKQ75UB+nEnQ9U+eJ10CGTKiq8MeY/HSnhtxN+Ufr8dP+vPJlKmEZZJGSpwLHMrllRQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVdvPTvGgec/4z9jJCgGfdguG3KPfoiVEmfURUy1VwQ=;
 b=ftAhQFquyA3+xrircDifLvrN9y1zycmgG3G1GwfvM0aJDBUciXuERC+geBgcxNLcnhDlTZ7/D6jkt/GK+qCxvhe3FMBesnOzC8IviX2qtOcETfbgyOYe1RjXkrkXcmAaajkH7vbs7h/BXMq24zJSpBs+8wi3KgGjdjUY7Ch2kE4=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector1-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVdvPTvGgec/4z9jJCgGfdguG3KPfoiVEmfURUy1VwQ=;
 b=WESFCbhyaUeFY+HOSWtIQsqH8YLZH9U2uLfG1X42K+EtMGq+x+Tbg63v8IfAOapbT+ANfmKpamxdUoHggAe/TAQxyQCJFmPS6qcv8JW+zUuVDshUU6feA9O440gb9iWZKeAVcnH6hAb3BDaic7MFOyYvsxlzn308JX4/YuDy7J4=
Received: from MN2PR04MB5886.namprd04.prod.outlook.com (20.179.22.213) by
 MN2PR04MB5839.namprd04.prod.outlook.com (20.179.22.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.17; Thu, 27 Jun 2019 11:24:39 +0000
Received: from MN2PR04MB5886.namprd04.prod.outlook.com
 ([fe80::397b:3922:4027:f635]) by MN2PR04MB5886.namprd04.prod.outlook.com
 ([fe80::397b:3922:4027:f635%3]) with mapi id 15.20.2032.016; Thu, 27 Jun 2019
 11:24:39 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sjoerd.simons@collabora.co.uk" <sjoerd.simons@collabora.co.uk>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: Re: [PATCH] Adjust analogix chip driver location
Thread-Topic: [PATCH] Adjust analogix chip driver location
Thread-Index: AQHVLAwnWdhoUTbW6kumQO1/091b5g==
Date:   Thu, 27 Jun 2019 11:24:39 +0000
Message-ID: <20190627112430.GA4197@xin-VirtualBox>
References: <20190626104430.GA11770@xin-VirtualBox>
 <20190626122317.GC30972@kroah.com>
In-Reply-To: <20190626122317.GC30972@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0179.apcprd02.prod.outlook.com
 (2603:1096:201:21::15) To MN2PR04MB5886.namprd04.prod.outlook.com
 (2603:10b6:208:a3::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xji@analogixsemi.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [114.247.245.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 851cd163-83d2-4bb1-c354-08d6faf20acc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR04MB5839;
x-ms-traffictypediagnostic: MN2PR04MB5839:
x-microsoft-antispam-prvs: <MN2PR04MB58398E866F68ED4FB40F61A0C7FD0@MN2PR04MB5839.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(346002)(366004)(39850400004)(376002)(136003)(189003)(199004)(305945005)(6916009)(66446008)(107886003)(5660300002)(3846002)(6116002)(256004)(2351001)(14444005)(66066001)(5640700003)(33716001)(6246003)(478600001)(1076003)(33656002)(53936002)(71200400001)(71190400001)(86362001)(52116002)(76176011)(25786009)(11346002)(6506007)(229853002)(4326008)(6486002)(476003)(26005)(486006)(64756008)(66476007)(446003)(66556008)(6436002)(54906003)(7736002)(186003)(2906002)(68736007)(81156014)(8936002)(386003)(81166006)(316002)(1730700003)(6512007)(9686003)(99286004)(66946007)(73956011)(14454004)(102836004)(8676002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5839;H:MN2PR04MB5886.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analogixsemi.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VD4jp2iIVVHS0qYnZpRWJHubvSKV3ujXMA5kTO/XDSFsJKRBDyHHxx+2GssY2nd4QjlHnIB7KYX69M4uY98oHWdCb+geYwkulhn1oBvoaZ5L5x9IUO8u7on540t7c8+nuHcheFOOhN91qUbD3OLpyIdcx3RauhYsAyD095nA3bEtD8Mk8f+SEIkT5hdTBBeTfqTZ8ZDC+6gOnviweeXOvWxrmIihNlh/qZ8V1jgYYO6cuQkRG9J3mhIhCCjdtO7p6C8UdymX85AFeIEjbFdKtkKIJSd04uHm3peM+FIr5Qtltt7IDSfayvEbUSFq3gdKd55DcGYaj8Pnh863F9pNPVhAb3aSU5INI08jJ6ej3dLAKENhFzbxTM9W98Ig+T30saxXLzfO6jmIc0ErJof5DEUizrxzV0jR47Eh+j22/V4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23DDEA1C4E97CA499C817164357FB5E7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851cd163-83d2-4bb1-c354-08d6faf20acc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 11:24:39.5611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xji@analogixsemi.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 08:23:17PM +0800, gregkh@linuxfoundation.org wrote:
> On Wed, Jun 26, 2019 at 10:44:38AM +0000, Xin Ji wrote:
> > Move analogix chip ANX78XX bridge driver into "analogix" directory.
> >=20
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > ---
> >  drivers/gpu/drm/bridge/Kconfig                     |   10 -
> >  drivers/gpu/drm/bridge/Makefile                    |    3 +-
> >  drivers/gpu/drm/bridge/analogix-anx78xx.c          | 1485 ------------=
--------
> >  drivers/gpu/drm/bridge/analogix-anx78xx.h          |  710 ----------
> >  drivers/gpu/drm/bridge/analogix/Kconfig            |   10 +
> >  drivers/gpu/drm/bridge/analogix/Makefile           |    2 +
> >  drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 1485 ++++++++++++=
++++++++
> >  drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h |  710 ++++++++++
> >  8 files changed, 2208 insertions(+), 2207 deletions(-)
> >  delete mode 100644 drivers/gpu/drm/bridge/analogix-anx78xx.c
> >  delete mode 100644 drivers/gpu/drm/bridge/analogix-anx78xx.h
> >  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> >  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h
>=20
> 'git format-patch -M' is usually a lot better to use when moving files
> around, as it shows you only any changes in the files, not a huge
> delete/add cycle.
>=20
> thanks,
>=20
> greg k-h

Thanks, I'll submit new version.

Xin
