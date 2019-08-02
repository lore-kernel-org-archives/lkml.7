Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A009C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E412087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="n1wxS/PU";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="n1wxS/PU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbfHBKne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 06:43:34 -0400
Received: from mail-eopbgr10067.outbound.protection.outlook.com ([40.107.1.67]:60741
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730424AbfHBKnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANgFG8PZXsUB8pWmTSAbt5YsgDPbPzmCo2SWsQdt5aA=;
 b=n1wxS/PUdLnMz9JmYvELMl7V21OmQuFsn7UYQ0eCgkeaUc2C5DmGbOS48to8TphhxECV1zQEZdURTguUSKzfrwRwGWtMDH/NKNbPGX8ke6ZtifM8daSd6q+JycE50cdpIpopKQ2u7h97syYmx6cgBuv+SKFCS/f9yBANamC0JDE=
Received: from AM6PR08CA0020.eurprd08.prod.outlook.com (2603:10a6:20b:b2::32)
 by VI1PR0801MB1855.eurprd08.prod.outlook.com (2603:10a6:800:59::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.14; Fri, 2 Aug
 2019 10:43:21 +0000
Received: from DB5EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by AM6PR08CA0020.outlook.office365.com
 (2603:10a6:20b:b2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.14 via Frontend
 Transport; Fri, 2 Aug 2019 10:43:20 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT045.mail.protection.outlook.com (10.152.21.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18 via Frontend Transport; Fri, 2 Aug 2019 10:43:19 +0000
Received: ("Tessian outbound cc8a947d4660:v26"); Fri, 02 Aug 2019 10:43:13 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a8c2a9e9b6e00623
X-CR-MTA-TID: 64aa7808
Received: from ffac1cd95e13.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.2.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id AB70A217-5F17-4984-AE95-4A686845B8F5.1;
        Fri, 02 Aug 2019 10:43:07 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2054.outbound.protection.outlook.com [104.47.2.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ffac1cd95e13.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 02 Aug 2019 10:43:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwTA+K7qjKAvQl64ZGVWVoiaoPqAqU9qcSYOoCgKpj86szG5efim6GJbGEgAOts+K2sRm2MGbkzIOqcua9M/Y/Lgef65uh7RoROWd4WV/cZW/xvC0lqymIxOowFvuadIL4sk5jUwvtwqj67VXIx2ppFTeMmLH3oH5JWbCRbiUbEg4zA9Fq6FAStjARfrYwLHCn4zvSll7qLn0rfFys3IJbv/mSJ5zhzkCUpyoGLCDAQPTXtdNMrPDaD2BMejo3UcNx327+lMdZDgYZ6liofPGY8JZH39fyDyzLQYlkVLvUbf440GvwEPWuW12nbzssf8Q4TykW8+47I5Z02Hb7xt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANgFG8PZXsUB8pWmTSAbt5YsgDPbPzmCo2SWsQdt5aA=;
 b=ZhBq7JS8VaZ0ZSt8TCjery+edRh4LDzJ/4jNEHGzz/MffWxZSaGRicPx1q89YUsaE68OOMCiy6LSXI7U32yj+5aRgwVps/UpICaT64BzRTLeGd85SRI3yuHFEb6SbAr4EDsZcCPLdkpKA2nAdDS/NXSBVJF5+yHSFgglIOoadBTjkxJmuplujpdu2A2fBfvVjr3a0DlOpbX88Al7pD05qZ5/NXoxpySkH00fDJm5vGNDKtkDzD4d0+lHv+UbyerpUPceGKaVIaKSQ2f8TriYxT7DsdnJ1OsOUwK2Z/Sr6ZpRqUFknk/it8ywy27wqxUj8J2E+WKJ+ibl4lW6sSq7qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANgFG8PZXsUB8pWmTSAbt5YsgDPbPzmCo2SWsQdt5aA=;
 b=n1wxS/PUdLnMz9JmYvELMl7V21OmQuFsn7UYQ0eCgkeaUc2C5DmGbOS48to8TphhxECV1zQEZdURTguUSKzfrwRwGWtMDH/NKNbPGX8ke6ZtifM8daSd6q+JycE50cdpIpopKQ2u7h97syYmx6cgBuv+SKFCS/f9yBANamC0JDE=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4990.eurprd08.prod.outlook.com (10.255.158.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.15; Fri, 2 Aug 2019 10:43:04 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134%6]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 10:43:04 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Adds error event print functionality
Thread-Topic: [PATCH] drm/komeda: Adds error event print functionality
Thread-Index: AQHVSRayAboXOjuz1kKxLGlCvtrW0abnoVcAgAAKlAA=
Date:   Fri, 2 Aug 2019 10:43:04 +0000
Message-ID: <20190802104258.GA26890@jamwan02-TSP300>
References: <1564738954-6101-1-git-send-email-lowry.li@arm.com>
 <1646739.69SqAVYMUr@e123338-lin>
In-Reply-To: <1646739.69SqAVYMUr@e123338-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0221.apcprd02.prod.outlook.com
 (2603:1096:201:20::33) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: c4319e35-b1c0-4c89-d475-08d717363bfa
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4990;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4990:|VI1PR0801MB1855:
X-Microsoft-Antispam-PRVS: <VI1PR0801MB18551181366E9193934C77CAB3D90@VI1PR0801MB1855.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
x-forefront-prvs: 011787B9DD
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(346002)(376002)(366004)(396003)(136003)(199004)(189003)(52116002)(68736007)(76176011)(446003)(11346002)(3846002)(6116002)(8936002)(1076003)(229853002)(8676002)(6486002)(66066001)(5660300002)(81166006)(186003)(476003)(486006)(81156014)(316002)(26005)(2906002)(256004)(14444005)(58126008)(6862004)(33656002)(6636002)(6506007)(33716001)(66446008)(386003)(6436002)(7736002)(66556008)(66476007)(305945005)(55236004)(14454004)(478600001)(71190400001)(71200400001)(66946007)(25786009)(4326008)(53936002)(64756008)(6512007)(86362001)(9686003)(99286004)(102836004)(54906003)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4990;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: jjs5jKTJm56Air+QL7FkcGR6jsI+nLWNsFPaQSPxqopAbKlI2ZrKICjZa3zKnfLn6DiF44b/REs0QmXfTvF/NXzw0/4/o4yd7UEx89Z8mlJsQYg+qygFPxAyWKGz1Qx2o6PyF/LH5Ibyccn7VeCt1YGIFbx0/mmrU0ZePbPMWTt036FtPgIW+cYb1OTSkL/SSaKS49WiLbkl9mQu9hSQ+RuKz8nsEKBbuPrGSVlDq+zRtZx9ttSK/GO5ej1utQNMjKyins7kpHJzWUWWdSCeje24MoMJkrt6ZG/mQCP6WbJWCAvtW32Ds9iWy1ZGLveSvFqarolAFPpLxcNJegOYSrwSlklSAJgb578Z5iwpwLhdyxCUAJXJwWn1nRBBmD9BocZUZBL/zw9tRU33SxXa9oOJVmS2kFRDij1VgLJq12Q=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F5EA93DE92B50744B9EE44FCE38E02E1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4990
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(346002)(396003)(136003)(376002)(2980300002)(199004)(189003)(102836004)(6512007)(14454004)(63350400001)(2906002)(446003)(76176011)(9686003)(476003)(126002)(14444005)(23726003)(4326008)(70206006)(22756006)(3846002)(11346002)(478600001)(86362001)(486006)(386003)(26826003)(6862004)(63370400001)(97756001)(50466002)(6116002)(8746002)(336012)(1076003)(316002)(47776003)(6486002)(76130400001)(46406003)(6246003)(70586007)(25786009)(33656002)(229853002)(66066001)(54906003)(6506007)(26005)(99286004)(305945005)(33716001)(6636002)(356004)(5660300002)(81166006)(58126008)(8936002)(7736002)(8676002)(186003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1855;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: fc20b74c-f2d0-4d30-e86f-08d7173632b6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0801MB1855;
NoDisclaimer: True
X-Forefront-PRVS: 011787B9DD
X-Microsoft-Antispam-Message-Info: pyF+DjMcDag1a0eIAHVFta+dV89BzILGRyCDAK1ZUMkYKDCD3dPipJZObOAmVTmq/Str7hplgC+69etuShdiH1DvKkr2lQBQFSq4hwQDNb3kXPpBwautlfZDAM/cXAqNi5Be/9oVLxqfwZEUr4wbCe6S8huHJk0qSuyMnF4rbsR1Xh49C1Eup+T0wqAMmMOIYE6xjCvXN/eY35Oh5XzG1djdoCMQTeAy0NW2S2p0mfhqHizpwrmXqqnhFFc09jAo2Phd67/ea3qhL9pfC37WdKJUruIctfjrT8gdMVxLFIPiao0g5dSGTR3y8mxWLZVh2PYwh1sWUxqruissO6BIO/3JSY9G9CVrWcXKGME5HmZFIRbP4dxJenuiMaRTR56Wl410pcqpRnsk5QNe9AQhvHDTiis/fbiEM4hv6Y7D8Go=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2019 10:43:19.7280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4319e35-b1c0-4c89-d475-08d717363bfa
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 06:05:08PM +0800, Mihail Atanassov wrote:
> On Friday, 2 August 2019 10:43:10 BST Lowry Li (Arm Technology China) wro=
te:
> > From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
> >=20
> > Adds to print the event message when error happens and the same event
> > will not be printed until next vsync.
> >=20
> > Changes since v2:
> > 1. Refine komeda_sprintf();
> > 2. Not using STR_SZ macro for the string size in komeda_print_events().
> >=20
> > Changes since v1:
> > 1. Handling the event print by CONFIG_KOMEDA_ERROR_PRINT;
> > 2. Changing the max string size to 256.
> >=20
> > Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
>=20
> Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>
>=20
> BR,
> Mihail

looks good to me.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

>=20
> > ---
> >  drivers/gpu/drm/arm/display/Kconfig               |   6 +
> >  drivers/gpu/drm/arm/display/komeda/Makefile       |   2 +
> >  drivers/gpu/drm/arm/display/komeda/komeda_dev.h   |  15 +++
> >  drivers/gpu/drm/arm/display/komeda/komeda_event.c | 140
> > ++++++++++++++++++++++ drivers/gpu/drm/arm/display/komeda/komeda_kms.c =
  |=20
> >  4 +
> >  5 files changed, 167 insertions(+)
> >  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_event.c
> >=20
> > diff --git a/drivers/gpu/drm/arm/display/Kconfig
> > b/drivers/gpu/drm/arm/display/Kconfig index cec0639..e87ff86 100644
> > --- a/drivers/gpu/drm/arm/display/Kconfig
> > +++ b/drivers/gpu/drm/arm/display/Kconfig
> > @@ -12,3 +12,9 @@ config DRM_KOMEDA
> >  	  Processor driver. It supports the D71 variants of the hardware.
> >=20
> >  	  If compiled as a module it will be called komeda.
> > +
> > +config DRM_KOMEDA_ERROR_PRINT
> > +	bool "Enable komeda error print"
> > +	depends on DRM_KOMEDA
> > +	help
> > +	  Choose this option to enable error printing.
> > diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile
> > b/drivers/gpu/drm/arm/display/komeda/Makefile index 5c3900c..f095a1c 10=
0644
> > --- a/drivers/gpu/drm/arm/display/komeda/Makefile
> > +++ b/drivers/gpu/drm/arm/display/komeda/Makefile
> > @@ -22,4 +22,6 @@ komeda-y +=3D \
> >  	d71/d71_dev.o \
> >  	d71/d71_component.o
> >=20
> > +komeda-$(CONFIG_DRM_KOMEDA_ERROR_PRINT) +=3D komeda_event.o
> > +
> >  obj-$(CONFIG_DRM_KOMEDA) +=3D komeda.o
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> > b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h index d1c86b6..e28e7e=
6
> > 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> > @@ -40,6 +40,17 @@
> >  #define KOMEDA_ERR_TTNG			BIT_ULL(30)
> >  #define KOMEDA_ERR_TTF			BIT_ULL(31)
> >=20
> > +#define KOMEDA_ERR_EVENTS	\
> > +	(KOMEDA_EVENT_URUN	| KOMEDA_EVENT_IBSY	| KOMEDA_EVENT_OVR |
> \
> > +	KOMEDA_ERR_TETO		| KOMEDA_ERR_TEMR	|=20
> KOMEDA_ERR_TITR |\
> > +	KOMEDA_ERR_CPE		| KOMEDA_ERR_CFGE	|=20
> KOMEDA_ERR_AXIE |\
> > +	KOMEDA_ERR_ACE0		| KOMEDA_ERR_ACE1	|=20
> KOMEDA_ERR_ACE2 |\
> > +	KOMEDA_ERR_ACE3		| KOMEDA_ERR_DRIFTTO	|=20
> KOMEDA_ERR_FRAMETO |\
> > +	KOMEDA_ERR_ZME		| KOMEDA_ERR_MERR	|=20
> KOMEDA_ERR_TCF |\
> > +	KOMEDA_ERR_TTNG		| KOMEDA_ERR_TTF)
> > +
> > +#define KOMEDA_WARN_EVENTS	KOMEDA_ERR_CSCE
> > +
> >  /* malidp device id */
> >  enum {
> >  	MALI_D71 =3D 0,
> > @@ -207,4 +218,8 @@ struct komeda_dev {
> >=20
> >  struct komeda_dev *dev_to_mdev(struct device *dev);
> >=20
> > +#ifdef CONFIG_DRM_KOMEDA_ERROR_PRINT
> > +void komeda_print_events(struct komeda_events *evts);
> > +#endif
> > +
> >  #endif /*_KOMEDA_DEV_H_*/
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> > b/drivers/gpu/drm/arm/display/komeda/komeda_event.c new file mode 10064=
4
> > index 0000000..a36fb86
> > --- /dev/null
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> > @@ -0,0 +1,140 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * (C) COPYRIGHT 2019 ARM Limited. All rights reserved.
> > + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> > + *
> > + */
> > +#include <drm/drm_print.h>
> > +
> > +#include "komeda_dev.h"
> > +
> > +struct komeda_str {
> > +	char *str;
> > +	u32 sz;
> > +	u32 len;
> > +};
> > +
> > +/* return 0 on success,  < 0 on no space.
> > + */
> > +static int komeda_sprintf(struct komeda_str *str, const char *fmt, ...=
)
> > +{
> > +	va_list args;
> > +	int num, free_sz;
> > +	int err;
> > +
> > +	free_sz =3D str->sz - str->len - 1;
> > +	if (free_sz <=3D 0)
> > +		return -ENOSPC;
> > +
> > +	va_start(args, fmt);
> > +
> > +	num =3D vsnprintf(str->str + str->len, free_sz, fmt, args);
> > +
> > +	va_end(args);
> > +
> > +	if (num < free_sz) {
> > +		str->len +=3D num;
> > +		err =3D 0;
> > +	} else {
> > +		str->len =3D str->sz - 1;
> > +		err =3D -ENOSPC;
> > +	}
> > +
> > +	return err;
> > +}
> > +
> > +static void evt_sprintf(struct komeda_str *str, u64 evt, const char *m=
sg)
> > +{
> > +	if (evt)
> > +		komeda_sprintf(str, msg);
> > +}
> > +
> > +static void evt_str(struct komeda_str *str, u64 events)
> > +{
> > +	if (events =3D=3D 0ULL) {
> > +		komeda_sprintf(str, "None");
> > +		return;
> > +	}
> > +
> > +	evt_sprintf(str, events & KOMEDA_EVENT_VSYNC, "VSYNC|");
> > +	evt_sprintf(str, events & KOMEDA_EVENT_FLIP, "FLIP|");
> > +	evt_sprintf(str, events & KOMEDA_EVENT_EOW, "EOW|");
> > +	evt_sprintf(str, events & KOMEDA_EVENT_MODE, "OP-MODE|");
> > +
> > +	evt_sprintf(str, events & KOMEDA_EVENT_URUN, "UNDERRUN|");
> > +	evt_sprintf(str, events & KOMEDA_EVENT_OVR, "OVERRUN|");
> > +
> > +	/* GLB error */
> > +	evt_sprintf(str, events & KOMEDA_ERR_MERR, "MERR|");
> > +	evt_sprintf(str, events & KOMEDA_ERR_FRAMETO, "FRAMETO|");
> > +
> > +	/* DOU error */
> > +	evt_sprintf(str, events & KOMEDA_ERR_DRIFTTO, "DRIFTTO|");
> > +	evt_sprintf(str, events & KOMEDA_ERR_FRAMETO, "FRAMETO|");
> > +	evt_sprintf(str, events & KOMEDA_ERR_TETO, "TETO|");
> > +	evt_sprintf(str, events & KOMEDA_ERR_CSCE, "CSCE|");
> > +
> > +	/* LPU errors or events */
> > +	evt_sprintf(str, events & KOMEDA_EVENT_IBSY, "IBSY|");
> > +	evt_sprintf(str, events & KOMEDA_ERR_AXIE, "AXIE|");
> > +	evt_sprintf(str, events & KOMEDA_ERR_ACE0, "ACE0|");
> > +	evt_sprintf(str, events & KOMEDA_ERR_ACE1, "ACE1|");
> > +	evt_sprintf(str, events & KOMEDA_ERR_ACE2, "ACE2|");
> > +	evt_sprintf(str, events & KOMEDA_ERR_ACE3, "ACE3|");
> > +
> > +	/* LPU TBU errors*/
> > +	evt_sprintf(str, events & KOMEDA_ERR_TCF, "TCF|");
> > +	evt_sprintf(str, events & KOMEDA_ERR_TTNG, "TTNG|");
> > +	evt_sprintf(str, events & KOMEDA_ERR_TITR, "TITR|");
> > +	evt_sprintf(str, events & KOMEDA_ERR_TEMR, "TEMR|");
> > +	evt_sprintf(str, events & KOMEDA_ERR_TTF, "TTF|");
> > +
> > +	/* CU errors*/
> > +	evt_sprintf(str, events & KOMEDA_ERR_CPE, "COPROC|");
> > +	evt_sprintf(str, events & KOMEDA_ERR_ZME, "ZME|");
> > +	evt_sprintf(str, events & KOMEDA_ERR_CFGE, "CFGE|");
> > +	evt_sprintf(str, events & KOMEDA_ERR_TEMR, "TEMR|");
> > +
> > +	if (str->len > 0 && (str->str[str->len - 1] =3D=3D '|')) {
> > +		str->str[str->len - 1] =3D 0;
> > +		str->len--;
> > +	}
> > +}
> > +
> > +static bool is_new_frame(struct komeda_events *a)
> > +{
> > +	return (a->pipes[0] | a->pipes[1]) &
> > +	       (KOMEDA_EVENT_FLIP | KOMEDA_EVENT_EOW);
> > +}
> > +
> > +void komeda_print_events(struct komeda_events *evts)
> > +{
> > +	u64 print_evts =3D KOMEDA_ERR_EVENTS;
> > +	static bool en_print =3D true;
> > +
> > +	/* reduce the same msg print, only print the first evt for one=20
> frame */
> > +	if (evts->global || is_new_frame(evts))
> > +		en_print =3D true;
> > +	if (!en_print)
> > +		return;
> > +
> > +	if ((evts->global | evts->pipes[0] | evts->pipes[1]) & print_evts)=20
> {
> > +		char msg[256];
> > +		struct komeda_str str;
> > +
> > +		str.str =3D msg;
> > +		str.sz  =3D sizeof(msg);
> > +		str.len =3D 0;
> > +
> > +		komeda_sprintf(&str, "gcu: ");
> > +		evt_str(&str, evts->global);
> > +		komeda_sprintf(&str, ", pipes[0]: ");
> > +		evt_str(&str, evts->pipes[0]);
> > +		komeda_sprintf(&str, ", pipes[1]: ");
> > +		evt_str(&str, evts->pipes[1]);
> > +
> > +		DRM_ERROR("err detect: %s\n", msg);
> > +
> > +		en_print =3D false;
> > +	}
> > +}
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c index 419a8b0..0fafc3=
6
> > 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > @@ -47,6 +47,10 @@ static irqreturn_t komeda_kms_irq_handler(int irq, v=
oid
> > *data) memset(&evts, 0, sizeof(evts));
> >  	status =3D mdev->funcs->irq_handler(mdev, &evts);
> >=20
> > +#ifdef CONFIG_DRM_KOMEDA_ERROR_PRINT
> > +	komeda_print_events(&evts);
> > +#endif
> > +
> >  	/* Notify the crtc to handle the events */
> >  	for (i =3D 0; i < kms->n_crtcs; i++)
> >  		komeda_crtc_handle_event(&kms->crtcs[i], &evts);
>=20
>=20
>=20
