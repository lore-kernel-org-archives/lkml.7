Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D512FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6812073F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="RrGVX/B2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="f28IEXCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfKUKV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:21:26 -0500
Received: from mail-eopbgr20087.outbound.protection.outlook.com ([40.107.2.87]:5086
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbfKUKV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFU0vvl438xpWahWY1n0Y+yCB/ZEwTi7EeXsTtM8zx4=;
 b=RrGVX/B2UinknpOFCSpSkEzhLLkNslD7oYvBu9ldEEv9HOBhTSD3j2NyeHYxaAQZsSHMMYhlzQHkPMduxJIKbu92N71bDX96LcdvfOceZlbKqVLN1XRVoh3SZg+B9rda+PSE5hZFieg7RdTLktrgPXv1ywADrCs9coee/4+wu0w=
Received: from VI1PR0802CA0048.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::34) by HE1PR0802MB2521.eurprd08.prod.outlook.com
 (2603:10a6:3:df::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.29; Thu, 21 Nov
 2019 10:21:19 +0000
Received: from DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by VI1PR0802CA0048.outlook.office365.com
 (2603:10a6:800:a9::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16 via Frontend
 Transport; Thu, 21 Nov 2019 10:21:19 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT054.mail.protection.outlook.com (10.152.20.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Thu, 21 Nov 2019 10:21:19 +0000
Received: ("Tessian outbound af6b7800e6cb:v33"); Thu, 21 Nov 2019 10:21:17 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 933cf55c3eee27e1
X-CR-MTA-TID: 64aa7808
Received: from 06923708197a.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.5.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A22A7C2D-E643-40A4-9BBA-9BB28AE41F65.1;
        Thu, 21 Nov 2019 10:21:12 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2050.outbound.protection.outlook.com [104.47.5.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 06923708197a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 21 Nov 2019 10:21:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejDRoC2QMmVgRZsFz6/B4v+TI6ay7ItWVbv/r/udyj/AMXUOsceYlKNJqUABsP5y+2LGtLkB60mdUpYopPn4z+7zuK4hGPNTzeXXisWL43AKDUwRzjz1d2lEu/by3NSbs8Y+qp90zW5xY/CaRs8/27gF3hgv6xsKe3OkaFecYjmRjppcbXawI5w5yVx581PfoWgmzgN6/FoVHItp+vadlWQWrtZ+K761Cb2JUrhnHy7RDKXSkttpEKsotIxlJ0r++p8j/WKZJL4NVX9mk6KfjHHHzt5aOkNW1QjaOZZ3mPs+8wIBULOohRsKJJXM+1ysxe/hOMWSST0oYdJknZl/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SHNq2JNFL4mqTY0KLlGETwFJgM4uMauCtLOM8c8jwM=;
 b=k+B5+wiSY/afkhOxD4fpmu/o3orKrTHrOgxJJn4mFnXWBDuIWdgbqc9Ss2ThE2NjfYYs8+jveL58xdRFDDcQGZDAqxi7xW7Kc9IlbGem2owDjzxIqkKF8tkp0JT04Zcj+dpri+REqAKnmIOeNDv2pW/5BoZFgZy/TXY9E+dB3tiQPCtuzdTVSIf4Hmzslnar4M2D5waBgNP5uBToCKKuvJ8t/ruMt860+/0Z7e/QYdjsOwgy0oc3qtSw/nuATcETqZAJRy1a53M1MpgC35eQjKbLRNDTgjMpSPlE6U3LjsDqZhH98bgaZ1oxAXsbB2FAdlrEkkD0w6ekxplYmIcE6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SHNq2JNFL4mqTY0KLlGETwFJgM4uMauCtLOM8c8jwM=;
 b=f28IEXCqx1BOmIP2Tj4X0lYIhl4Kjadz7XJUBWJaYbU9cF0ZjzAkQcvFDCDXX0E/08rT4pST76ZZf6IN9RIKj9rBk5hUirPqC9NiByp9OZy1n6CX11P/YKKlJ2kF6KW+cV8VQzMmS/HPx/pxTjiL6lcx1gjVyw3yUyHq5LRUCGE=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5101.eurprd08.prod.outlook.com (20.179.29.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Thu, 21 Nov 2019 10:21:09 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 10:21:08 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Dave Airlie <airlied@gmail.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ben Davis <Ben.Davis@arm.com>
Subject: Re: [PATCH v4 6/6] drm/komeda: Expose side_by_side by sysfs/config_id
Thread-Topic: [PATCH v4 6/6] drm/komeda: Expose side_by_side by
 sysfs/config_id
Thread-Index: AQHVoDsY3wS7JXHxKU+92h5A5rXdAKeVYXUAgAAI04A=
Date:   Thu, 21 Nov 2019 10:21:08 +0000
Message-ID: <20191121102101.GA32514@jamwan02-TSP300>
References: <20191121071205.27511-1-james.qian.wang@arm.com>
 <20191121071205.27511-7-james.qian.wang@arm.com>
 <20191121094926.GC6236@phenom.ffwll.local>
In-Reply-To: <20191121094926.GC6236@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:202:2e::29) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8612c760-76d1-479b-8b86-08d76e6c8c9f
X-MS-TrafficTypeDiagnostic: VE1PR08MB5101:|VE1PR08MB5101:|HE1PR0802MB2521:
X-MS-Exchange-PUrlCount: 2
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB25211BB3636DC77BD3A49266B34E0@HE1PR0802MB2521.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6430;OLM:6430;
x-forefront-prvs: 0228DDDDD7
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(199004)(189003)(86362001)(81156014)(55236004)(99286004)(52116002)(33716001)(229853002)(1076003)(6436002)(6486002)(478600001)(76176011)(966005)(66066001)(26005)(5660300002)(186003)(25786009)(8936002)(6636002)(6306002)(9686003)(102836004)(2906002)(6506007)(386003)(14454004)(305945005)(3846002)(256004)(6512007)(33656002)(14444005)(8676002)(110136005)(66946007)(446003)(6116002)(64756008)(7736002)(71200400001)(66446008)(66556008)(71190400001)(66476007)(11346002)(2501003)(58126008)(6246003)(316002)(2201001)(81166006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5101;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Vt5YbTUNQs5Sxn5LuQ8e/YsbhVzG6vkP9eeFayg/mc7UjecQdgL1gncWFzbdZZrbHKmw6nnHH2Vw/QppfwDd3zMt0AOHBwG9O7zFiTAb4EABeY1RRv19UWdVnrVhykvIkO3q20Nl9ZDXOfCHOZpxVIK+UtD+Zx4m8F+a/5ynDd5nIZUbuxaqU6mUjccdkPXqry3mnCITUGY2wS5O+thYg9Qv9d4h4GVUVze9l57p5BwYi6RywE+P/Z+fKYnSCucKfa6ckUO1me+yd/EgbkKUPccTw6tI33CxDlnNsfFaceJoTTY82aoTTKTHRIkqMI+0SLn/WIqacpORDUseK5Q6TSJBnmizYTz3hvKaLLaS79f4JfLqw2njmEFBnRrR7L/Ht4k0Qo34imuEyfAEWDS8iBamgwgOZXFs6q22w8+dJLaS02USzndiJVkZ9X28kzaUU3QMu4YFsftCiouxwhb2c2kXzkV+LIuSXqEMjFIK8K8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FE7D88DA5A172F4CAEE863476F9DEDDB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5101
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(346002)(376002)(39860400002)(136003)(396003)(1110001)(339900001)(189003)(199004)(40434004)(25786009)(1076003)(58126008)(50466002)(229853002)(33656002)(81166006)(26005)(46406003)(2501003)(7736002)(14454004)(478600001)(966005)(356004)(587094005)(102836004)(23726003)(81156014)(5024004)(305945005)(105606002)(6506007)(386003)(99286004)(6636002)(14444005)(9686003)(110136005)(33716001)(2201001)(70586007)(97756001)(22756006)(8746002)(336012)(446003)(6246003)(6306002)(70206006)(6486002)(76176011)(8676002)(2906002)(186003)(26826003)(316002)(11346002)(6116002)(3846002)(86362001)(5660300002)(8936002)(47776003)(6512007)(66066001)(76130400001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0802MB2521;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1cd417b3-9f04-4481-64dd-08d76e6c8663
X-Forefront-PRVS: 0228DDDDD7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9783tlMMd/s3PBDkJSJ8rT5Y4HCJv0sA2f/mdtsk6MkDqT4lUCd5i3PRAvSE+zaNWTXem9VlCD8R4fY1q2uPdRPvFMbcUmkpnVooRfGEz+Xv3la2/m917gfwmpfKpiIhFwSeQX+QUZo6m8KdrZhU/4udHagL1ZgrGprvccqqTVPsLDJxJcn93FLguWX2sOo2NNNnKnfL+8R0/iZA2HpRT3dAVzmX/3zs9sFUEVw2FTqRJEsgWWFd4l6B4XPWhcS54Bh95hLEGbuBKs8l1VPJ1sygr3f5l3kEL6B8Qh30Qqfp3lIenfrTXXGpeE27T2gwNJKJYN60EVPI3ZI9LYoUpbPSKoMrb9AtWziANVd0fMKkiyVz6EFkXeVU/JNVI1OiRwrduBTdXogu5TGDnSSsWIsz4hdWKvs4KNK4T4b1iTVOMlfO3E5DPdFREakFSUOB4ydKPtnSxDeUIZYuhpMnUf5jLlQGUoQssmvnUcQn3Rw=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2019 10:21:19.0103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8612c760-76d1-479b-8b86-08d76e6c8c9f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2521
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 10:49:26AM +0100, Daniel Vetter wrote:
> On Thu, Nov 21, 2019 at 07:12:55AM +0000, james qian wang (Arm Technology=
 China) wrote:
> > There are some restrictions if HW works on side_by_side, expose it via
> > config_id to user.
> >
> > Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@=
arm.com>
> > ---
> >  drivers/gpu/drm/arm/display/include/malidp_product.h | 3 ++-
> >  drivers/gpu/drm/arm/display/komeda/komeda_dev.c      | 1 +
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/arm/display/include/malidp_product.h b/dri=
vers/gpu/drm/arm/display/include/malidp_product.h
> > index 1053b11352eb..96e2e4016250 100644
> > --- a/drivers/gpu/drm/arm/display/include/malidp_product.h
> > +++ b/drivers/gpu/drm/arm/display/include/malidp_product.h
> > @@ -27,7 +27,8 @@ union komeda_config_id {
> >                     n_scalers:2, /* number of scalers per pipeline */
> >                     n_layers:3, /* number of layers per pipeline */
> >                     n_richs:3, /* number of rich layers per pipeline */
> > -                   reserved_bits:6;
> > +                   side_by_side:1, /* if HW works on side_by_side mode=
 */
> > +                   reserved_bits:5;
> >     };
> >     __u32 value;
> >  };
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_dev.c
> > index c3fa4835cb8d..4dd4699d4e3d 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > @@ -83,6 +83,7 @@ config_id_show(struct device *dev, struct device_attr=
ibute *attr, char *buf)
>
> Uh, this sysfs file here looks a lot like uapi for some compositor to
> decide what to do. Do you have the userspace for this?

Yes, our HWC driver uses this config_id and product_id for identifying the
HW caps.

> Also a few more thoughts on this:
> - You can't just add more fields to uapi structs.
> - This doesn't really feel like it was ever reviewed to fit into atomic.
> - sysfs should be one value per file, not a smorgasbrod of things stuffed
>   into a binary structure.

I will sent a series and split this struct to multiple files.

| This doesn't really feel like it was ever reviewed to fit into atomic

These values don't have atomic problem, since config_id is for
representing the HW caps info, which are not configurable.

Thanks
James

> -Daniel
>
> >     memset(&config_id, 0, sizeof(config_id));
> >
> >     config_id.max_line_sz =3D pipe->layers[0]->hsize_in.end;
> > +   config_id.side_by_side =3D mdev->side_by_side;
> >     config_id.n_pipelines =3D mdev->n_pipelines;
> >     config_id.n_scalers =3D pipe->n_scalers;
> >     config_id.n_layers =3D pipe->n_layers;
> > --
> > 2.20.1
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
