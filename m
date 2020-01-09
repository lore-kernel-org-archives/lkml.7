Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA49DC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AA82084D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="r2cUXeh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgAIJyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:54:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:43618 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729750AbgAIJyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:54:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 01:54:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,413,1571727600"; 
   d="scan'208";a="421731556"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jan 2020 01:54:49 -0800
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jan 2020 01:54:49 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jan 2020 01:54:49 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 9 Jan 2020 01:54:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnGO5VNwEAnFAxeVvctlVshDKp5WpHtvwgv42FTenRWaot8YLfekr3a3axHKqISk7+7pvvYBCKFujNiBpYwWf71KXl6w42/FEXpD88ZXPoUgAweQnEqv9yrvnPBZso9LUyiKYAbyi6KT05Na7o0DIVFzlUj3yDTcuy10sNS67j+saYONe9QygDxxcl1ImO8w6rt2+/wqaWYpJzTOs0oJktHhP5qOxaql6571Zy+PFGLTvKxtEttCqf6oACmtY4XG8lRcaRMK3XNnXu1IMEpuqjf/ewDIqrYvyIvglYu8IbApbI3Vclq6K0ozfwzFzfgrXDnwMPme+kEmTIxlN+dQwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlIrduGVQLb/0DhKAzviZEfYa4yGANzcgcCwuCJ+d2I=;
 b=CU1dH6fuvYy4HPDrs/B3F6LwfETWxSYneMz3sWsJoT9Ed954R1AvgyF2Qt62rGmhZDcBXViKfRbQI6MvwtDi71TkrjUrJNmzAFs/JlDgKxlEOMUUCIr635IvUQ7S8ycKozikc8jaGs+hgHO1gz7mD14rUF3a7+Ka4ltns84mhbrBI68C7D5wLJGAa7dfW/Vaw/xKxZpxoJnPwHc/F5WHt4x0b/EuaPtMdRgPqDpnzLT7eG7kExVTFyxCfOYlqa50vSaPg+A6YtLGVxhI9ZD65o1itVXs9dImcDfFOZAPCJ0S1yTM+z5k+ZM80T5oRbnWgpLvbkFMnh+JO6sThCUsUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlIrduGVQLb/0DhKAzviZEfYa4yGANzcgcCwuCJ+d2I=;
 b=r2cUXeh/7n11MR5BKvomWkyxkzAcfSToVuOeH4bv1y6Q5tEWG3h0DlwkTlxe7OJwD+mTNka91Vsj3yvRFg9ZAXYlzNLC/pUEjGKMg/kwdw7N6f6t3NJRKQM+LwKOk9nV7yFT9NaTHS/Abuk9h/3YZs10ep503rp9gL2clzzbxwo=
Received: from SN6PR11MB2750.namprd11.prod.outlook.com (52.135.89.148) by
 SN6PR11MB2605.namprd11.prod.outlook.com (52.135.97.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 9 Jan 2020 09:54:47 +0000
Received: from SN6PR11MB2750.namprd11.prod.outlook.com
 ([fe80::f044:6625:17ff:3c83]) by SN6PR11MB2750.namprd11.prod.outlook.com
 ([fe80::f044:6625:17ff:3c83%3]) with mapi id 15.20.2602.017; Thu, 9 Jan 2020
 09:54:46 +0000
From:   "Loh, Tien Hock" <tien.hock.loh@intel.com>
To:     "Ooi, Joyce" <joyce.ooi@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Rob Herring" <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "See, Chin Liang" <chin.liang.see@intel.com>,
        "Tan, Ley Foon" <ley.foon.tan@intel.com>,
        Ooi <IMCEAINVALID-Ooi@namprd11.prod.outlook.com>
Subject: RE: [PATCH] MAINTAINERS: Replace Tien Hock Loh as Altera PIO
 maintainer
Thread-Topic: [PATCH] MAINTAINERS: Replace Tien Hock Loh as Altera PIO
 maintainer
Thread-Index: AQHVwley8VxKb1ZtM0q5x6Av+ymvqafiIMqQ
Date:   Thu, 9 Jan 2020 09:54:46 +0000
Message-ID: <SN6PR11MB2750CD8233FF8F14B006B343BD390@SN6PR11MB2750.namprd11.prod.outlook.com>
References: <20200103170155.100743-1-joyce.ooi@intel.com>
In-Reply-To: <20200103170155.100743-1-joyce.ooi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWUyNTRjMDYtYWNiNC00YWVjLWJlNDMtMjQ5OWVlN2Y2NTA3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOWErMjJnd1Bzd0haclhaT2w1Sm1vK1FVVFhtR2lUOXo0NFBpcEVZMEJVSlpvVFhzYjE1RXN1bjhOVmpGT0tmMyJ9
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tien.hock.loh@intel.com; 
x-originating-ip: [192.198.147.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d10a627-5979-4b66-bc29-08d794e9f5db
x-ms-traffictypediagnostic: SN6PR11MB2605:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB260585AFFEE307C18F72FF34BD390@SN6PR11MB2605.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:313;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(136003)(396003)(39860400002)(199004)(189003)(13464003)(4744005)(55016002)(52536014)(9686003)(316002)(7696005)(71200400001)(8936002)(33656002)(478600001)(54906003)(110136005)(5660300002)(2906002)(107886003)(86362001)(76116006)(81156014)(8676002)(4326008)(81166006)(53546011)(26005)(6506007)(66446008)(186003)(66556008)(64756008)(66946007)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB2605;H:SN6PR11MB2750.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 75xVPJz6QlIixzk7rHhpE672Kkruw5gqG5QXDGYLMOKmDzBQt72Nuz3XNVLubhtXv6D4dKFPVz7w9qo0S4whcny2itgMTB3oBwMMyskKPceU0Lri7+C3vJsOuhYMbbwor8RH3+cA0n1Z3Onl9Gq5+zLi4QZRSfUp5ej9KeDdg44EaYrnBGF48apx63Bx7ih8adpHwPDq5SSG04j+MRHohPulW39GhIXwlFGKwDk4t2gnXNsOR9u17vECsscGASgNZIgpZhFQWoVI71c6DLVe9F/2jqvkzluZSQWZvzPn0TIY3SEUmdGRfjnZl6O0kHpJGNxGIX1G0AfD/JRaJy3EEZH8XBKTekfdHYyH65vN9oA28FFI7W6crqMZ/iQGFQIHuADBhJ/lvlpGr3wNGYVNBSP+t7bLQ4u2Ncbq0Os2LnMOLAHfi2mgh2yDJR6IEOW6mydRoiRlScQf7nvRhEVY0Ct70aBf/47baqwBzw8aj8LBINZP7EOXd5ot2xcvCwKD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d10a627-5979-4b66-bc29-08d794e9f5db
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 09:54:46.7924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EMgHglpJcU5fol5NPSD/bCwsPXKXq5jfwvV3FiFxgId2RRyyaFa9SOVAkvBEcAOiZAPyLf8Pbx3T/t0f+0rqow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2605
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Ooi, Joyce <joyce.ooi@intel.com>
> Sent: Saturday, January 4, 2020 1:02 AM
> To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>; David S .
> Miller <davem@davemloft.net>; Rob Herring <robh@kernel.org>; Greg
> Kroah-Hartman <gregkh@linuxfoundation.org>; Jonathan Cameron
> <Jonathan.Cameron@huawei.com>
> Cc: linux-kernel@vger.kernel.org; Ooi, Joyce <joyce.ooi@intel.com>; Loh,
> Tien Hock <tien.hock.loh@intel.com>; See, Chin Liang
> <chin.liang.see@intel.com>; Tan, Ley Foon <ley.foon.tan@intel.com>; Ooi
> Subject: [PATCH] MAINTAINERS: Replace Tien Hock Loh as Altera PIO
> maintainer
>=20
> This patch is to replace Tien Hock Loh as Altera PIO maintainer as he has
> moved to a different role.

Thanks Joyce!

Acked-by: Tien Hock Loh<tien.hock.loh@intel.com>

>=20
> Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
> ---
>  MAINTAINERS |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a049abc..3401c4a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -726,7 +726,7 @@ S:	Maintained
>  F:	drivers/mailbox/mailbox-altera.c
>=20
>  ALTERA PIO DRIVER
> -M:	Tien Hock Loh <thloh@altera.com>
> +M:	Joyce Ooi <joyce.ooi@intel.com>
>  L:	linux-gpio@vger.kernel.org
>  S:	Maintained
>  F:	drivers/gpio/gpio-altera.c
> --
> 1.7.1

