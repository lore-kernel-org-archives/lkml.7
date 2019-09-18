Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EA0C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 01:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD83214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 01:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MRnLx3s0";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MRnLx3s0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfIRBaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 21:30:09 -0400
Received: from mail-eopbgr60052.outbound.protection.outlook.com ([40.107.6.52]:22755
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726653AbfIRBaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 21:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwFHRkWQwDjACHJD6UFNiXvEq5CHQM80FKgd9kUZbDE=;
 b=MRnLx3s0Me3dNQQuM84bAx6lRVURTWGbL0PBRgIwhpu4U7QXlxklowBWe8hSgA1vClAO50yaqfnn4X0pFcyCs8gm/AuGotFh7G5paAEkpIgCje69mZLsw92nG/Y1/VpBWbyYbDwQxKefomc/NsJEmndlNXK1r1ZXK6DRVbHTNEI=
Received: from DB6PR0801CA0053.eurprd08.prod.outlook.com (2603:10a6:4:2b::21)
 by VI1PR08MB3120.eurprd08.prod.outlook.com (2603:10a6:803:46::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.21; Wed, 18 Sep
 2019 01:30:00 +0000
Received: from AM5EUR03FT056.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::205) by DB6PR0801CA0053.outlook.office365.com
 (2603:10a6:4:2b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2284.18 via Frontend
 Transport; Wed, 18 Sep 2019 01:30:00 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT056.mail.protection.outlook.com (10.152.17.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2263.14 via Frontend Transport; Wed, 18 Sep 2019 01:29:59 +0000
Received: ("Tessian outbound 0d576b67b9f5:v31"); Wed, 18 Sep 2019 01:29:52 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d1d1f021b1bc3165
X-CR-MTA-TID: 64aa7808
Received: from e846aa42bed5.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 173B670D-BDF2-4F36-B354-9A39C838CFCD.1;
        Wed, 18 Sep 2019 01:29:47 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2052.outbound.protection.outlook.com [104.47.4.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e846aa42bed5.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 18 Sep 2019 01:29:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9QUVp+n2VwxibBDs7otWhA+/ozrcsGhD7XhCRNl00VEEpl/9ZOt4yjEIW/yRpja80gbO7D4jYza/o4JJlqH6mSOWbhPkUzF5b+erRgAa73liFpU8ftIyarO3+U9YTVg1WBmDGtI/m0GoDEe/TUl+uea8vLw1LSy+zvTr75SoprQq9PExbSVRnxnZu4sOFcUcRhnLLFYidrReREMUGDkNhp/4ynzmpYxz4byaq20fjP7ikEvzIAvCfl4GS8tAWJWWVOXMgIEI/EmohzxOaeim1MdQGLiiGk6IQGdnn48MbMbbq69nBc4qtP+FvEx3n4hww6zJk0m7SbIdKRuYkvMVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwFHRkWQwDjACHJD6UFNiXvEq5CHQM80FKgd9kUZbDE=;
 b=Zgel834TwbUYZ4VwxlKqhQPg05e4WKu7Xki+SZu8Dskf8wy5HFRmn29LgMFyYoYyqiUq1BPOJrRWs29cNP5B57bw/ebJ0y7ruebJmkZz6IL8GiLlXqqEafocQsMqRHMwgsr8iYA2W+ZLrmA4NEikH+oWVeb8VwBHoDvVoxoDntRfCTNnkreJog9pPncm5qrEpi1YaoM7M3EDEOhpbCENrOKICF+z8gGReyN9kWyxUXEC47jqb9/UO1pGspYidaa8jzyPPInA2AxpM1TfTieMGpABgfrBJrxKyqfDb2oW5JGkoblXBhMp1E9XJKv7ORfTQrk87qGtdct5P6fzgU8t0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwFHRkWQwDjACHJD6UFNiXvEq5CHQM80FKgd9kUZbDE=;
 b=MRnLx3s0Me3dNQQuM84bAx6lRVURTWGbL0PBRgIwhpu4U7QXlxklowBWe8hSgA1vClAO50yaqfnn4X0pFcyCs8gm/AuGotFh7G5paAEkpIgCje69mZLsw92nG/Y1/VpBWbyYbDwQxKefomc/NsJEmndlNXK1r1ZXK6DRVbHTNEI=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5007.eurprd08.prod.outlook.com (10.255.159.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Wed, 18 Sep 2019 01:29:45 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879%5]) with mapi id 15.20.2284.009; Wed, 18 Sep 2019
 01:29:45 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Adds error event print functionality
Thread-Topic: [PATCH] drm/komeda: Adds error event print functionality
Thread-Index: AQHVSRayAboXOjuz1kKxLGlCvtrW0acwIKWAgADOPoA=
Date:   Wed, 18 Sep 2019 01:29:45 +0000
Message-ID: <20190918012937.GA11084@jamwan02-TSP300>
References: <1564738954-6101-1-git-send-email-lowry.li@arm.com>
 <CAKMK7uECMr46Ag8E=eqTKdZxgt_4M42t7GEyNGv0gxpv-TL3Pg@mail.gmail.com>
In-Reply-To: <CAKMK7uECMr46Ag8E=eqTKdZxgt_4M42t7GEyNGv0gxpv-TL3Pg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR04CA0083.apcprd04.prod.outlook.com
 (2603:1096:202:15::27) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: a8228192-88f3-4aa8-c5d3-08d73bd7b853
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5007;
X-MS-TrafficTypeDiagnostic: VE1PR08MB5007:|VE1PR08MB5007:|VI1PR08MB3120:
X-MS-Exchange-PUrlCount: 2
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB312012D24075E39E6957179FB38E0@VI1PR08MB3120.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6108;OLM:6108;
x-forefront-prvs: 01644DCF4A
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(199004)(189003)(4326008)(6916009)(5660300002)(33656002)(6436002)(1076003)(6486002)(6116002)(3846002)(71200400001)(71190400001)(256004)(14444005)(2906002)(86362001)(33716001)(486006)(446003)(229853002)(316002)(66446008)(9686003)(54906003)(66946007)(66476007)(66556008)(64756008)(76176011)(52116002)(186003)(99286004)(58126008)(386003)(55236004)(11346002)(476003)(66066001)(102836004)(26005)(966005)(478600001)(14454004)(25786009)(8936002)(6246003)(8676002)(81156014)(81166006)(6306002)(7736002)(6512007)(6506007)(53546011)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5007;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: VZuvJ3Jw3L8z2lsPIrl+lfTInUrY9Ajdy5PSSgf5Fv89tCVorUb69NTdQugMlBmLb12OmUf6i4QFNvjOHNgF3d+8Rut02rxGtN2isLHXgEOTrlugCJadbRx3unjQPf6KEAYVZkzoWBb3J5QkpS7df41aRX9U+b/BQVRtag0Kz1xJ2e/p50AcheaPiRwa9CyzEZMll1pcEQKodn2Cpgy4sQWA7MEf1qv8/bZFMoZC+2hlvmzg5SGelgTj/cmj6IANnf7ZPcK5nlLB+jw1Qk70iUY12FBh+1FPwG52j2j72lMXFpGKUrsA5mPdQlFVIzfeSxJrtdaZVfdnwlnhc4Zqz7t5rgf0A1m3uVzqK2zyLO+c0AxHntZrsEMw9V/fLrCMGLnYyRi2O/h+ne+Rci008UI+huFJLHGM1blZoWF0qso=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6837C2F5BB3AF941B5C73E15440B616B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5007
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT056.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(346002)(39860400002)(136003)(396003)(199004)(189003)(8746002)(186003)(22756006)(446003)(11346002)(1076003)(6486002)(53546011)(76176011)(478600001)(6116002)(23726003)(5660300002)(486006)(7736002)(305945005)(4326008)(2906002)(6862004)(54906003)(3846002)(9686003)(14454004)(58126008)(966005)(63350400001)(99286004)(476003)(26005)(86362001)(126002)(356004)(386003)(26826003)(97756001)(6506007)(47776003)(36906005)(25786009)(336012)(14444005)(102836004)(8676002)(316002)(70586007)(8936002)(50466002)(81166006)(6512007)(81156014)(76130400001)(46406003)(70206006)(6246003)(229853002)(6306002)(33716001)(66066001)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3120;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 91d5e5b1-5bab-45ee-b338-08d73bd7afb8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR08MB3120;
NoDisclaimer: True
X-Forefront-PRVS: 01644DCF4A
X-Microsoft-Antispam-Message-Info: LKMOonBznbu5nN7jAX7m2GUGB6WeDh8/VNagVMiyn2DfaQzP4r4++8KDkeMPBIn3A0eJVDfQ1b4tRsdLD5GsW1gyg6P5qc2IjYSawbTaEoUo2xwVNtcTJPOVa+a2rOxTf2sxmpxMxzyWo5brijA43qm3xE3IMss/Imh1buFaUJtBAnZpl5f8hcPmBxrNdUfpIgwAOsgTV8f/LwndSdVCONGR1XRWBMX/v/SbWaEkjU+0N7UAt5MljzihyzEa+DJb3iqTprx5PI/ztot2zcnPrzM8CeUluoJejBNpjfzBbSprnB8/Gogx5wXA83L2Kx7kIfAw3LQjSfIyvxzPZhiL1kK0j1aD0zEoE+0JfxWVYTX/d6UVi01DkZyBMQKroDdZpou0w5H1FJ4V3qsd/wlTZotCTr8jYkegXd+5hnLqKG0=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2019 01:29:59.1979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8228192-88f3-4aa8-c5d3-08d73bd7b853
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 03:11:27PM +0200, Daniel Vetter wrote:
> On Fri, Aug 2, 2019 at 11:43 AM Lowry Li (Arm Technology China)
> <Lowry.Li@arm.com> wrote:
> >
> > From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
> >
> > Adds to print the event message when error happens and the same event
> > will not be printed until next vsync.
> >
> > Changes since v2:
> > 1. Refine komeda_sprintf();
> > 2. Not using STR_SZ macro for the string size in komeda_print_events().
> >
> > Changes since v1:
> > 1. Handling the event print by CONFIG_KOMEDA_ERROR_PRINT;
> > 2. Changing the max string size to 256.
> >
> > Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> > ---
> >  drivers/gpu/drm/arm/display/Kconfig               |   6 +
> >  drivers/gpu/drm/arm/display/komeda/Makefile       |   2 +
> >  drivers/gpu/drm/arm/display/komeda/komeda_dev.h   |  15 +++
> >  drivers/gpu/drm/arm/display/komeda/komeda_event.c | 140 ++++++++++++++=
++++++++
> >  drivers/gpu/drm/arm/display/komeda/komeda_kms.c   |   4 +
> >  5 files changed, 167 insertions(+)
> >  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_event.c
> >
> > diff --git a/drivers/gpu/drm/arm/display/Kconfig b/drivers/gpu/drm/arm/=
display/Kconfig
> > index cec0639..e87ff86 100644
> > --- a/drivers/gpu/drm/arm/display/Kconfig
> > +++ b/drivers/gpu/drm/arm/display/Kconfig
> > @@ -12,3 +12,9 @@ config DRM_KOMEDA
> >           Processor driver. It supports the D71 variants of the hardwar=
e.
> >
> >           If compiled as a module it will be called komeda.
> > +
> > +config DRM_KOMEDA_ERROR_PRINT
> > +       bool "Enable komeda error print"
> > +       depends on DRM_KOMEDA
> > +       help
> > +         Choose this option to enable error printing.
> > diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/=
drm/arm/display/komeda/Makefile
> > index 5c3900c..f095a1c 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/Makefile
> > +++ b/drivers/gpu/drm/arm/display/komeda/Makefile
> > @@ -22,4 +22,6 @@ komeda-y +=3D \
> >         d71/d71_dev.o \
> >         d71/d71_component.o
> >
> > +komeda-$(CONFIG_DRM_KOMEDA_ERROR_PRINT) +=3D komeda_event.o
> > +
> >  obj-$(CONFIG_DRM_KOMEDA) +=3D komeda.o
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/=
gpu/drm/arm/display/komeda/komeda_dev.h
> > index d1c86b6..e28e7e6 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> > @@ -40,6 +40,17 @@
> >  #define KOMEDA_ERR_TTNG                        BIT_ULL(30)
> >  #define KOMEDA_ERR_TTF                 BIT_ULL(31)
> >
> > +#define KOMEDA_ERR_EVENTS      \
> > +       (KOMEDA_EVENT_URUN      | KOMEDA_EVENT_IBSY     | KOMEDA_EVENT_=
OVR |\
> > +       KOMEDA_ERR_TETO         | KOMEDA_ERR_TEMR       | KOMEDA_ERR_TI=
TR |\
> > +       KOMEDA_ERR_CPE          | KOMEDA_ERR_CFGE       | KOMEDA_ERR_AX=
IE |\
> > +       KOMEDA_ERR_ACE0         | KOMEDA_ERR_ACE1       | KOMEDA_ERR_AC=
E2 |\
> > +       KOMEDA_ERR_ACE3         | KOMEDA_ERR_DRIFTTO    | KOMEDA_ERR_FR=
AMETO |\
> > +       KOMEDA_ERR_ZME          | KOMEDA_ERR_MERR       | KOMEDA_ERR_TC=
F |\
> > +       KOMEDA_ERR_TTNG         | KOMEDA_ERR_TTF)
> > +
> > +#define KOMEDA_WARN_EVENTS     KOMEDA_ERR_CSCE
> > +
> >  /* malidp device id */
> >  enum {
> >         MALI_D71 =3D 0,
> > @@ -207,4 +218,8 @@ struct komeda_dev {
> >
> >  struct komeda_dev *dev_to_mdev(struct device *dev);
> >
> > +#ifdef CONFIG_DRM_KOMEDA_ERROR_PRINT
> > +void komeda_print_events(struct komeda_events *evts);
> > +#endif
> > +
> >  #endif /*_KOMEDA_DEV_H_*/
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c b/driver=
s/gpu/drm/arm/display/komeda/komeda_event.c
> > new file mode 100644
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
> > +       char *str;
> > +       u32 sz;
> > +       u32 len;
> > +};
> > +
> > +/* return 0 on success,  < 0 on no space.
> > + */
> > +static int komeda_sprintf(struct komeda_str *str, const char *fmt, ...=
)
> > +{
> > +       va_list args;
> > +       int num, free_sz;
> > +       int err;
> > +
> > +       free_sz =3D str->sz - str->len - 1;
> > +       if (free_sz <=3D 0)
> > +               return -ENOSPC;
> > +
> > +       va_start(args, fmt);
> > +
> > +       num =3D vsnprintf(str->str + str->len, free_sz, fmt, args);
> > +
> > +       va_end(args);
> > +
> > +       if (num < free_sz) {
> > +               str->len +=3D num;
> > +               err =3D 0;
> > +       } else {
> > +               str->len =3D str->sz - 1;
> > +               err =3D -ENOSPC;
> > +       }
> > +
> > +       return err;
> > +}
> > +
> > +static void evt_sprintf(struct komeda_str *str, u64 evt, const char *m=
sg)
> > +{
> > +       if (evt)
> > +               komeda_sprintf(str, msg);
> > +}
> > +
> > +static void evt_str(struct komeda_str *str, u64 events)
> > +{
> > +       if (events =3D=3D 0ULL) {
> > +               komeda_sprintf(str, "None");
> > +               return;
> > +       }
> > +
> > +       evt_sprintf(str, events & KOMEDA_EVENT_VSYNC, "VSYNC|");
> > +       evt_sprintf(str, events & KOMEDA_EVENT_FLIP, "FLIP|");
> > +       evt_sprintf(str, events & KOMEDA_EVENT_EOW, "EOW|");
> > +       evt_sprintf(str, events & KOMEDA_EVENT_MODE, "OP-MODE|");
> > +
> > +       evt_sprintf(str, events & KOMEDA_EVENT_URUN, "UNDERRUN|");
> > +       evt_sprintf(str, events & KOMEDA_EVENT_OVR, "OVERRUN|");
> > +
> > +       /* GLB error */
> > +       evt_sprintf(str, events & KOMEDA_ERR_MERR, "MERR|");
> > +       evt_sprintf(str, events & KOMEDA_ERR_FRAMETO, "FRAMETO|");
> > +
> > +       /* DOU error */
> > +       evt_sprintf(str, events & KOMEDA_ERR_DRIFTTO, "DRIFTTO|");
> > +       evt_sprintf(str, events & KOMEDA_ERR_FRAMETO, "FRAMETO|");
> > +       evt_sprintf(str, events & KOMEDA_ERR_TETO, "TETO|");
> > +       evt_sprintf(str, events & KOMEDA_ERR_CSCE, "CSCE|");
> > +
> > +       /* LPU errors or events */
> > +       evt_sprintf(str, events & KOMEDA_EVENT_IBSY, "IBSY|");
> > +       evt_sprintf(str, events & KOMEDA_ERR_AXIE, "AXIE|");
> > +       evt_sprintf(str, events & KOMEDA_ERR_ACE0, "ACE0|");
> > +       evt_sprintf(str, events & KOMEDA_ERR_ACE1, "ACE1|");
> > +       evt_sprintf(str, events & KOMEDA_ERR_ACE2, "ACE2|");
> > +       evt_sprintf(str, events & KOMEDA_ERR_ACE3, "ACE3|");
> > +
> > +       /* LPU TBU errors*/
> > +       evt_sprintf(str, events & KOMEDA_ERR_TCF, "TCF|");
> > +       evt_sprintf(str, events & KOMEDA_ERR_TTNG, "TTNG|");
> > +       evt_sprintf(str, events & KOMEDA_ERR_TITR, "TITR|");
> > +       evt_sprintf(str, events & KOMEDA_ERR_TEMR, "TEMR|");
> > +       evt_sprintf(str, events & KOMEDA_ERR_TTF, "TTF|");
> > +
> > +       /* CU errors*/
> > +       evt_sprintf(str, events & KOMEDA_ERR_CPE, "COPROC|");
> > +       evt_sprintf(str, events & KOMEDA_ERR_ZME, "ZME|");
> > +       evt_sprintf(str, events & KOMEDA_ERR_CFGE, "CFGE|");
> > +       evt_sprintf(str, events & KOMEDA_ERR_TEMR, "TEMR|");
> > +
> > +       if (str->len > 0 && (str->str[str->len - 1] =3D=3D '|')) {
> > +               str->str[str->len - 1] =3D 0;
> > +               str->len--;
> > +       }
> > +}
> > +
> > +static bool is_new_frame(struct komeda_events *a)
> > +{
> > +       return (a->pipes[0] | a->pipes[1]) &
> > +              (KOMEDA_EVENT_FLIP | KOMEDA_EVENT_EOW);
> > +}
> > +
> > +void komeda_print_events(struct komeda_events *evts)
> > +{
> > +       u64 print_evts =3D KOMEDA_ERR_EVENTS;
> > +       static bool en_print =3D true;
> > +
> > +       /* reduce the same msg print, only print the first evt for one =
frame */
> > +       if (evts->global || is_new_frame(evts))
> > +               en_print =3D true;
> > +       if (!en_print)
> > +               return;
> > +
> > +       if ((evts->global | evts->pipes[0] | evts->pipes[1]) & print_ev=
ts) {
> > +               char msg[256];
> > +               struct komeda_str str;
> > +
> > +               str.str =3D msg;
> > +               str.sz  =3D sizeof(msg);
> > +               str.len =3D 0;
> > +
> > +               komeda_sprintf(&str, "gcu: ");
> > +               evt_str(&str, evts->global);
> > +               komeda_sprintf(&str, ", pipes[0]: ");
> > +               evt_str(&str, evts->pipes[0]);
> > +               komeda_sprintf(&str, ", pipes[1]: ");
> > +               evt_str(&str, evts->pipes[1]);
> > +
> > +               DRM_ERROR("err detect: %s\n", msg);
> > +
> > +               en_print =3D false;
> > +       }
> > +}
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_kms.c
> > index 419a8b0..0fafc36 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > @@ -47,6 +47,10 @@ static irqreturn_t komeda_kms_irq_handler(int irq, v=
oid *data)
> >         memset(&evts, 0, sizeof(evts));
> >         status =3D mdev->funcs->irq_handler(mdev, &evts);
> >
> > +#ifdef CONFIG_DRM_KOMEDA_ERROR_PRINT
> > +       komeda_print_events(&evts);
> > +#endif
>=20
> #ifdef in code is discouraged, the usual way we handle these cases is
> by having a dummy static inline function which does nothing in the
> headers for the case a config option isn't enabled.
> -Daniel

Hi Daniel&Mihail:

If so, since this CONFIG is always enabled for komeda, I'd like to
delete this CONFIG option directly.

thanks
james

> > +
> >         /* Notify the crtc to handle the events */
> >         for (i =3D 0; i < kms->n_crtcs; i++)
> >                 komeda_crtc_handle_event(&kms->crtcs[i], &evts);
> > --
> > 1.9.1
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20
>=20
>=20
> --=20
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
