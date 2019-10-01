Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E70C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2AE20700
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="0Zq2VdAa";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="0Zq2VdAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387514AbfJAJTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 05:19:46 -0400
Received: from mail-eopbgr20045.outbound.protection.outlook.com ([40.107.2.45]:17035
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730112AbfJAJTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 05:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E02/Ms4Mh0ImANA7D4x0EPoIO70mt2MslOmcMpOpL94=;
 b=0Zq2VdAacCTyDbRr2J+o2C5feW/RCYCPHdcFd1CYendsXhNE92DulBhnzpneHX4Rz2a7CwZc3XpBdnXKZ2Nw1zhz6lEifKCocEyhu+qjI12ue+ZBIRw8jZoa4WmVsKghFGhmqfkV52c910sOMO74Qdu5E6xlo5LdRv2X111+S4I=
Received: from VI1PR0802CA0013.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::23) by AM6PR08MB3462.eurprd08.prod.outlook.com
 (2603:10a6:20b:44::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Tue, 1 Oct
 2019 09:19:38 +0000
Received: from AM5EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by VI1PR0802CA0013.outlook.office365.com
 (2603:10a6:800:aa::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20 via Frontend
 Transport; Tue, 1 Oct 2019 09:19:38 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT043.mail.protection.outlook.com (10.152.17.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 1 Oct 2019 09:19:37 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Tue, 01 Oct 2019 09:19:29 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c47eafb1afe480e9
X-CR-MTA-TID: 64aa7808
Received: from 53dd24ad1df9.3 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.12.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9603E347-CC61-4535-B4C2-47A22E459F0E.1;
        Tue, 01 Oct 2019 09:19:23 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 53dd24ad1df9.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 01 Oct 2019 09:19:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXoatXdCjMEIX7BKdH+gqM+9QCTSs3Z58xS/zzjsUysX/4/fVW57ANYxYuseEHOWd/kPOHM04wp54gfZsDYbKalfvL7wB/LTXo/o0n9FiNDXFqWX8ET0iCtNK1/1ilvEmTpBbZ3YJIcApKKXVraL5UMH76aoC2/rwWWSqt5xjAeuxxH8lq3aCPb70LyhPx7Sjk0c1ptNZFM6ee3c4Bk8kO+YfOdpTlznfo3boPspYGt/fDTeuEdFtR0AVRHExbEs8yLiLV6TP4CakKFmaGyEHsbIJkmZSVqAgR4Upzrzp+szNOd7uG9/taIyKi3JPVgP9APVNxujrT0G9J9Gld1/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E02/Ms4Mh0ImANA7D4x0EPoIO70mt2MslOmcMpOpL94=;
 b=BCTZ1kTjpXJPVtcvTTm47ksjhoRgirayEFOHtUMbtpyeZ8xkEFb4Udk9VVLhA8/Jkb/X4FaA7FeaSUIGp4jw9nNhQa4d1B1wgn6zxALMZ0vNatcZ9zHJdZjsCWvgnVTMyhvonNIR8ZsTB+qAVWUoPRnXr7ODWYTnOVFLGZOLl7tTCdWXoQluxTKXujaxChSiZj0HX71P6sMCgkCH+YIrV5E37hkcgy5pMF0je0VZV1FIRDBbf9nXa0mZLjTL7RZUzWexVFG4ks/92o8CzljleHBrTmJjAdRk/QqazxvfKC86ia0LRkng76LTB/8Y3WuIp4Vp/560++FjlZTSlo+EMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E02/Ms4Mh0ImANA7D4x0EPoIO70mt2MslOmcMpOpL94=;
 b=0Zq2VdAacCTyDbRr2J+o2C5feW/RCYCPHdcFd1CYendsXhNE92DulBhnzpneHX4Rz2a7CwZc3XpBdnXKZ2Nw1zhz6lEifKCocEyhu+qjI12ue+ZBIRw8jZoa4WmVsKghFGhmqfkV52c910sOMO74Qdu5E6xlo5LdRv2X111+S4I=
Received: from AM7PR08MB5352.eurprd08.prod.outlook.com (10.141.172.139) by
 AM7PR08MB5350.eurprd08.prod.outlook.com (10.141.172.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Tue, 1 Oct 2019 09:19:21 +0000
Received: from AM7PR08MB5352.eurprd08.prod.outlook.com
 ([fe80::1c78:bb51:3634:9cf0]) by AM7PR08MB5352.eurprd08.prod.outlook.com
 ([fe80::1c78:bb51:3634:9cf0%2]) with mapi id 15.20.2305.022; Tue, 1 Oct 2019
 09:19:21 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Brian Starkey <Brian.Starkey@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yuq825@gmail.com" <yuq825@gmail.com>, nd <nd@arm.com>,
        Raymond Smith <Raymond.Smith@arm.com>
Subject: Re: [PATCH v2] drm/fourcc: Add Arm 16x16 block modifier
Thread-Topic: [PATCH v2] drm/fourcc: Add Arm 16x16 block modifier
Thread-Index: AQHVd65ZjChaP0zoZUGEUL74H9varqdEcloAgAEQ5QA=
Date:   Tue, 1 Oct 2019 09:19:21 +0000
Message-ID: <20191001091920.GA28248@arm.com>
References: <20190930164425.20282-1-ayan.halder@arm.com>
 <20190930170236.fvlim4c4ziqbxkw7@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20190930170236.fvlim4c4ziqbxkw7@DESKTOP-E1NTVVP.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0278.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::26) To AM7PR08MB5352.eurprd08.prod.outlook.com
 (2603:10a6:20b:106::11)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.50]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 00c1d2f3-0c74-4a2f-04d2-08d746507b19
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM7PR08MB5350:|AM7PR08MB5350:|AM6PR08MB3462:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3462FFB181B55009469B8B4EE49D0@AM6PR08MB3462.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 0177904E6B
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(51914003)(189003)(11346002)(102836004)(305945005)(66066001)(5660300002)(446003)(71190400001)(64756008)(99286004)(476003)(54906003)(8676002)(229853002)(71200400001)(81156014)(81166006)(8936002)(2616005)(478600001)(256004)(26005)(14444005)(14454004)(66446008)(386003)(1076003)(186003)(52116002)(6506007)(66556008)(486006)(25786009)(76176011)(66946007)(66476007)(44832011)(7736002)(6862004)(6246003)(86362001)(4326008)(36756003)(6512007)(37006003)(2906002)(6436002)(33656002)(316002)(6116002)(6636002)(6486002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR08MB5350;H:AM7PR08MB5352.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: zFYhf2kRDHvHW85lh3xA4jTWeokYcwcqL6831hK8eu0egTQlwnUdPSZwAooh2aG4u8/OQA3PpeULjO2BsJG8srSImKBnW4xg3+BCgxDm68OJFaa4ZwwOEHoYkqU3j7KPKKF3RJy+MNN1qEo9U5LLNeQy/068K494tfMtW5CaPw0Bk7ljgRqn6jKBe6OOqYUXO0ZdYy6u6arkl/+zdvBOGtCsF0nBDG8GDeM+vdZedSKx9bNa+BhWx/U9Rquo4lthBX6YJJuyS7FYWLGtuK9ax+HxhCW97brYo4couEs8sUQP8CKsviMeAnm9LZBUHEbY0+AFo0YJLd9gmN1KyOKcF7OIm2qWMZBwjBAqd+0H9c4EHlWIiUM0+MIvunJAQ7BMDLpz+jZv3rRxQut9PdqZpAuVK4Rm8m3t2YOHkHewZzY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5F38E1DB67CA8748B3C6674209244F6D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5350
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT043.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(189003)(199004)(51914003)(5660300002)(2906002)(4326008)(229853002)(6486002)(86362001)(14454004)(33656002)(66066001)(25786009)(478600001)(76130400001)(6512007)(6862004)(70586007)(6246003)(70206006)(46406003)(22756006)(8936002)(26826003)(23726003)(6636002)(47776003)(6116002)(3846002)(486006)(305945005)(7736002)(446003)(336012)(11346002)(1076003)(186003)(54906003)(126002)(14444005)(476003)(356004)(36756003)(37006003)(26005)(102836004)(63350400001)(386003)(6506007)(76176011)(99286004)(2616005)(50466002)(8746002)(81156014)(36906005)(8676002)(81166006)(316002)(97756001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3462;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: f465b48e-cd73-4ff4-c4ea-08d74650718d
NoDisclaimer: True
X-Forefront-PRVS: 0177904E6B
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HpFnRCvaWiHJAHxLd1oJ5IxVqOBsgLHlx5kzHwftP4/cy4xv3Zkld4jAXHG2RV5hS26jrc/0B3HPTOQOI0yDW1QRy0/nvEORyFuFL43kj7Th35MhSJ7h4EREiIzcmP3PaxTM+JT/A6x/Ir6MHTBSbbJpB5J+7MYXX34ARtNF5Z+TfrhR8DacZQFOYweMg9zdqdr7Bq8PnXuXkHHgYhtdMTUuVQ+6EaOcI+jSPbCQ48syT92ueWDETIPDXD4LStXVoNrzm17fVTa0qcH1s+OZ/Qjx3DM3ENU5TTJw71Xo6D2JSyONmppJ4oB7REarMjswDKnb/6W4TXYmlbKTJOcSP1jWhTzQqyr7Z0PrGfy8uqID681tul0dxMFWOCQLp7RYG3ooZKAWES18dxkUZ43gPKyOitpD7Jg9QUd8/jjXn1U=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2019 09:19:37.2099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c1d2f3-0c74-4a2f-04d2-08d746507b19
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3462
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 05:02:37PM +0000, Brian Starkey wrote:
> Hi Ayan,
>=20
> Could we preserve Ray's authorship on this patch?
Apologies for this, I will definitely preserve Ray's authorship in the
v3 patch.

>=20
> On Mon, Sep 30, 2019 at 04:44:38PM +0000, Ayan Halder wrote:
> > Add the DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED modifier to
> > denote the 16x16 block u-interleaved format used in Arm Utgard and
> > Midgard GPUs.
> >=20
> > Changes from v1:-
> > 1. Reserved the upper four bits (out of the 56 bits assigned to each ve=
ndor)
> > to denote the category of Arm specific modifiers. Currently, we have tw=
o
> > categories ie AFBC and MISC.
> >=20
> > Signed-off-by: Raymond Smith <raymond.smith@arm.com>
> > Signed-off-by: Ayan kumar halder <ayan.halder@arm.com>
> > ---
> >  include/uapi/drm/drm_fourcc.h | 27 ++++++++++++++++++++++++++-
> >  1 file changed, 26 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourc=
c.h
> > index 3feeaa3f987a..b1d3de961109 100644
> > --- a/include/uapi/drm/drm_fourcc.h
> > +++ b/include/uapi/drm/drm_fourcc.h
> > @@ -648,7 +648,21 @@ extern "C" {
> >   * Further information on the use of AFBC modifiers can be found in
> >   * Documentation/gpu/afbc.rst
> >   */
> > -#define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode)	fourcc_mod_code(ARM, __af=
bc_mode)
> > +
> > +/*
> > + * The top 4 bits (out of the 56 bits alloted for specifying vendor sp=
ecific
> > + * modifiers) denote the category for modifiers. Currently we have onl=
y two
> > + * categories of modifiers ie AFBC and MISC. We can have a maximum of =
sixteen
> > + * different categories.
> > + */
>=20
> Yeah, this makes more sense than getting crazy with saving bits. Sorry
> Qiang/Daniel for not just going with this in the first instance when
> you both suggested it.
>=20
> > +#define DRM_FORMAT_MOD_ARM_CODE(type, val) \
> > +	fourcc_mod_code(ARM, ((__u64)type << 52) | ((val) & 0x000ffffffffffff=
fULL))
>=20
> Not a big deal, but I might prefix type and val with "__" to reduce
> the chance of name collisions with code using the macro:
> DRM_FORMAT_MOD_ARM_CODE(__type, __val).
>=20
> > +
> > +#define DRM_FORMAT_MOD_ARM_TYPE_AFBC 0x00
> > +#define DRM_FORMAT_MOD_ARM_TYPE_MISC 0x01
> > +
> > +#define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode) \
> > +	DRM_FORMAT_MOD_ARM_CODE(DRM_FORMAT_MOD_ARM_TYPE_AFBC, __afbc_mode)
> > =20
> >  /*
> >   * AFBC superblock size
> > @@ -742,6 +756,17 @@ extern "C" {
> >   */
> >  #define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
> > =20
> > +/*
> > + * Arm 16x16 Block U-Interleaved modifier
> > + *
> > + * This is used by Arm Mali Utgard and Midgard GPUs. It divides the im=
age
> > + * into 16x16 pixel blocks. Blocks are stored linearly in order, but p=
ixels
> > + * in the block are reordered.
> > + */
> > +#define DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED \
> > +	DRM_FORMAT_MOD_ARM_CODE(DRM_FORMAT_MOD_ARM_TYPE_MISC, 1ULL)
> > +
> > +
>=20
> I think you can drop this newline, there's no extra space between any
> of the other definitions.
>=20
> With this line dropped, and if you fix up the author:
>=20
> Reviewed-by: Brian Starkey <brian.starkey@arm.com>
>=20
> Thanks for the respin,

I will wait for daniel@ffwll.ch and yuq825@gmail.com comments before
respinning the patch.

> -Brian
>=20
> >  /*
> >   * Allwinner tiled modifier
> >   *
> > --=20
> > 2.23.0
> >=20
