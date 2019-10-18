Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16B2CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC6B21897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="X1tlgdFW";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="X1tlgdFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409738AbfJRJal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:30:41 -0400
Received: from mail-eopbgr130047.outbound.protection.outlook.com ([40.107.13.47]:30631
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2395294AbfJRJak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5foMB7HxV+Jsn5OCccMwSBlv9vljQyjtu7dKK0/hr68=;
 b=X1tlgdFWgz/4JxM40StXGO4n+1h/iZPZLh4UwZo+EcQ5rNKTagz5UVvjUbBpJrNA90g4rPFoYMOijX5i0uWP7WNEEPMKIkk7NMzkfVgoFTPKM8vbhV79QUwUuixesVt+qUZ9sQ94bkNPaJy7cmMNKuteyFOXprZQbgLaRFU7Afw=
Received: from DB6PR0802CA0034.eurprd08.prod.outlook.com (2603:10a6:4:a3::20)
 by AM6PR08MB3189.eurprd08.prod.outlook.com (2603:10a6:209:45::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Fri, 18 Oct
 2019 09:30:28 +0000
Received: from DB5EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::209) by DB6PR0802CA0034.outlook.office365.com
 (2603:10a6:4:a3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.20 via Frontend
 Transport; Fri, 18 Oct 2019 09:30:28 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT059.mail.protection.outlook.com (10.152.21.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 18 Oct 2019 09:30:26 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Fri, 18 Oct 2019 09:30:19 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1045642e34c096b1
X-CR-MTA-TID: 64aa7808
Received: from 6312e6fad71b.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C633BFF0-38A8-4B34-9E6B-B76729B49A19.1;
        Fri, 18 Oct 2019 09:30:13 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6312e6fad71b.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 18 Oct 2019 09:30:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y530bNxIVPplknihrT/MYZC46BKAiSn1BlRU+7O6VLzU3uEwYj4TEcFegC4s+0KSerihvA6WHqFnhY/H3ov2M3XG3a/kpsFvpY/A0gGSo+R/7e5jIARqKbaWEhNPkqpaul6ABagiCem8IImRQR5xCDElDmEJdJazBhBG0XnKvVPlCAguGbVbSS1hGuacvjsLeISwUqJhzwImbAfvjnWqfj7BhxcIQtGVKYMS1GgX43mWYjqSQNCs6CvsiMF4a/ycm2s4HulwBKKSMWzpQDUc6DgM7sDtNn3k4QKRHXEV3KUrbO2/hJc51dqpL0YX4Sk+GpMSYLJWZGa1S2rnaRe72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5foMB7HxV+Jsn5OCccMwSBlv9vljQyjtu7dKK0/hr68=;
 b=HBU+F26XUx42xsQzZihWItUGGH1LG2jTTLwdix2qx1l3KcVpXz3wV9VKU98/Opl2AHWrkbj6T259Hasp5CbtrCIBxTZuKWDQNw8413AGH07rAODeIwE0Z2VZFCADWtYY4pwjbcTz+gHxOwFWldzulVnyRxWqtOlg0+qy9MKrntwZysYOkpuUBKPhY26PreCiYgaX8D3GVyomVoI2wMTMttyh3pw1x4hmQwS0G6hYl6psrJh7W7yKMZbwBXcSQWS+uEBqEbIMWMMSSAEmi1JvHc+U3eK1xM1MPdznMeMLwy5M0oM/6bR5AWp8qCullvloRF7LXICXa77A9DrcPuZm3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5foMB7HxV+Jsn5OCccMwSBlv9vljQyjtu7dKK0/hr68=;
 b=X1tlgdFWgz/4JxM40StXGO4n+1h/iZPZLh4UwZo+EcQ5rNKTagz5UVvjUbBpJrNA90g4rPFoYMOijX5i0uWP7WNEEPMKIkk7NMzkfVgoFTPKM8vbhV79QUwUuixesVt+qUZ9sQ94bkNPaJy7cmMNKuteyFOXprZQbgLaRFU7Afw=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2864.eurprd08.prod.outlook.com (10.175.243.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Fri, 18 Oct 2019 09:30:11 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2347.024; Fri, 18 Oct 2019
 09:30:11 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "imirkin@alum.mit.edu" <imirkin@alum.mit.edu>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v5 1/4] drm: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Topic: [PATCH v5 1/4] drm: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Index: AQHVhA1Dae0PEifxdEmUeEe4shI0vKddKu6AgALekoCAABupgA==
Date:   Fri, 18 Oct 2019 09:30:11 +0000
Message-ID: <4381055.oiViQHVQgJ@e123338-lin>
References: <20191016103339.25858-1-james.qian.wang@arm.com>
 <2404938.QDdPyV61sH@e123338-lin> <20191018075101.GA19928@jamwan02-TSP300>
In-Reply-To: <20191018075101.GA19928@jamwan02-TSP300>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P265CA0338.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::14) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 3e751cc3-d5a5-42d8-d2c3-08d753adcee7
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB2864:|VI1PR08MB2864:|AM6PR08MB3189:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3189EDD5315C44A4EDB9EC478F6C0@AM6PR08MB3189.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 01949FE337
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(346002)(136003)(39860400002)(366004)(396003)(376002)(189003)(199004)(6436002)(6636002)(256004)(7736002)(9686003)(66066001)(229853002)(305945005)(6512007)(6246003)(33716001)(14454004)(5660300002)(478600001)(316002)(54906003)(6486002)(14444005)(52116002)(66946007)(66446008)(6116002)(66556008)(71190400001)(71200400001)(76176011)(386003)(6506007)(26005)(186003)(8676002)(81156014)(11346002)(486006)(86362001)(99286004)(476003)(64756008)(6862004)(25786009)(4326008)(8936002)(102836004)(66476007)(2906002)(81166006)(3846002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2864;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: RT7sMBE4lnHF6lkJ5W6A1qDI0+lJSKnd//8BIrijHfMSbQWGxTIHzeQ88vlcSozbU+WDx1sIX4NsOkW9Rx6UY47eKv1wRpD5Tr2UxQ/EFBSjbzPFVffHQPpIjlubH4J6qBH9Q26FiwSD2uT2+ePgczwnliPop50M4m+nHnlkvXkfnwnoqng6KPpOYd+yIxfgHwOws/KkaRwitaA019wlswzQXCQJuTnidDWiuOF8faYlXLUH4ZB/sZSLNVibCxREhmtwVIsc+SnzrU4/N2yE2uA8NYNT8+hZQX2k3exFJ0PFvYO+OR3dIQFKcR7sWiQAl+QzkHl0CUqGeORwE39IXp2s+ZomRu4seKrWJThHw6KXuSYc/7NPa9iQXgMMz706ZWpocu8WAc2hmuWF1j9fs4uwrTGBBBr4dr331FqmGXg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FFA6730941821047B99D83655A1352B2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2864
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(346002)(376002)(136003)(396003)(189003)(199004)(6862004)(50466002)(25786009)(70586007)(70206006)(97756001)(486006)(26005)(336012)(26826003)(478600001)(476003)(63350400001)(66066001)(316002)(11346002)(186003)(229853002)(54906003)(47776003)(14454004)(22756006)(446003)(5660300002)(386003)(6506007)(81166006)(356004)(6636002)(7736002)(126002)(14444005)(8936002)(8676002)(8746002)(81156014)(86362001)(46406003)(102836004)(23726003)(4326008)(6512007)(6246003)(9686003)(6116002)(305945005)(3846002)(33716001)(6486002)(76130400001)(107886003)(76176011)(2906002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3189;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0bba1a9b-4ae8-47c3-16f6-08d753adc5ce
NoDisclaimer: True
X-Forefront-PRVS: 01949FE337
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HUJc9p7A76zZfALi2Z6PnVpIRCUTvZug3yZY6+O/SQlGyvtKAyQ8kyqmPxEYxDN4VkkcLiI6CyZ/vf7hIVWdAieRy7yNZK9RaVG84ecxKd3jZCb+pePyL+o5BsUsvI7y2hiOT8+CzoNXmUIp43W6Nay18U6SGM+IsM7wYENNHD9NX4wTnahFXNwpKjFlvzejpgfx6aXjL8JlI0dxmzq1UzVFZ3nxT3u72sIGeoIeiTBvOlUSdRiBalmdFBc3aFjt5PKLMHLrnB6keSTrcMFD0G2gMvsWKXbzF1uF2KExUR74hSIAvnbEYx+jTp1EykWF1IXbmjhvxlnyOfEZwqB9oad2c28UYAcWjk9obqZA/RN8JF9wkjIlOl0s3kDro200th1PA8/N2OZj+DuZCXYC0X0nlmQh/o+RpKBlwKW7la4=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2019 09:30:26.1210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e751cc3-d5a5-42d8-d2c3-08d753adcee7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 18 October 2019 08:51:09 BST james qian wang (Arm Technology Chi=
na) wrote:
> On Wed, Oct 16, 2019 at 11:02:03AM +0000, Mihail Atanassov wrote:
> > On Wednesday, 16 October 2019 11:34:08 BST james qian wang (Arm Technol=
ogy China) wrote:
> > > Add a new helper function drm_color_ctm_s31_32_to_qm_n() for driver t=
o
> > > convert S31.32 sign-magnitude to Qm.n 2's complement that supported b=
y
> > > hardware.
> > >=20
> > > V4: Address Mihai, Daniel and Ilia's review comments.
> > > V5: Includes the sign bit in the value of m (Qm.n).
> > >=20
> > > Signed-off-by: james qian wang (Arm Technology China) <james.qian.wan=
g@arm.com>
> > > Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>
> > > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > ---
> > >  drivers/gpu/drm/drm_color_mgmt.c | 27 +++++++++++++++++++++++++++
> > >  include/drm/drm_color_mgmt.h     |  2 ++
> > >  2 files changed, 29 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_c=
olor_mgmt.c
> > > index 4ce5c6d8de99..d313f194f1ec 100644
> > > --- a/drivers/gpu/drm/drm_color_mgmt.c
> > > +++ b/drivers/gpu/drm/drm_color_mgmt.c
> > > @@ -132,6 +132,33 @@ uint32_t drm_color_lut_extract(uint32_t user_inp=
ut, uint32_t bit_precision)
> > >  }
> > >  EXPORT_SYMBOL(drm_color_lut_extract);
> > > =20
> > > +/**
> > > + * drm_color_ctm_s31_32_to_qm_n
> > > + *
> > > + * @user_input: input value
> > > + * @m: number of integer bits, include the sign-bit, support range i=
s [1, 32]
> >=20
> > Any reason why numbers like Q0.32 are disallowed? In those cases, the
> > 'sign' bit and the first fractional bit just happen to be the same bit.
> > The longer I look at it, the more I think mentioning a 'sign-bit' here
> > might confuse people more, since 2's complement doesn't have a
> > dedicated bit just for the sign. How about reducing it simply to:
>=20
> No, since the value is signed there must be dedicated sign-bit.

As I've said a few times before in this review, 2's complement has no
dedicated sign bit, that's the whole reason 2's complement exists in
the first place. The sign is implemented by negating the weight of
the most significant bit. This isn't a dedicated +/- field!

>=20
> consider very simple 2 bit signed, Q1.1
>=20
>  0.5  is 01
>  0    is 00
> -0.5  is 11
> -1.0  is 10, sign-bit and value share same bit, but it is integer part.

And a very simple 2-bit signed Q0.2 would look like this:

weights: (-2^-1)*b1 + (2^-2)*b0
          ^
          L-> note negative weight at most significant bit position

+-------------+---------------+
/ bit pattern | decimal value |
+-------------+---------------+
\     00      |     0.0       |
/     01      |     0.25      |
\     10      |    -0.5       |
/     11      |    -0.25      |
+-------------+---------------+

(Apologies for the ragged left border on the table :/)

I genuinely don't see why you really want to have that integer part be
strictly non-zero in size, it can very well be all fractional.

>=20
> See the wiki:
>=20
> One convention includes the sign bit in the value of m,[1][2] and the oth=
er convention
> does not. The choice of convention can be determined by summing m+n. If t=
he value is equal
> to the register size, then the sign bit is included in the value of m. If=
 it is one
> less than the register size, the sign bit is not included in the value of=
 m.

This is very much off the mark. See above for my sign bit in 2's
complement rant. With that caveat, what you refer to as the sign
bit is simply the top bit. If m+n is 16, then what you refer to as
the sign bit is in bit position 15 with a weight of -2^(m-1). If
m+n is instead 13, then all that changes is that the bit with the
weight of -2^(m-1) is at position 12.

Most importantly, there is nothing special about m + n =3D=3D regsize,
the lack of sign-extension aside.

What I think is the source of confusion is that when you expand, say,
Q4.4 into a Q8.8, you need to do sign extension, so bit position 7
in the original Q4.4 needs to be replicated into positions 12-15 in
addition to moving it to position 11 in the destination format. But
then those are no longer sign bits, the signedness is encoded in bit
15 as a weight of -2^7 :).

>=20
> So for the 32bit value, all fractional:
>=20
> a) M include sign-bit: Q1.31

This is a 32-bit number with range [-1, 1 - 2^-31] and precision 2^-31.
The weight of bit 31 is simply -2^0 (i.e. -1). This has 1 integer bit.

> b) M doesn't include sign-bit: Q0.31

This is a 31-bit number with range [-0.5, 1 - 2^-31]. Same precision as
above but smaller range. This is all fractional but not a 32-bit value.
I think you're looking for Q0.32, which has almost the same range but
double the precision.

>=20
> >=20
> >  * @m: number of integer bits, m <=3D 32.
> >=20
> > > + * @n: number of fractional bits, only support n <=3D 32
> > > + *
> > > + * Convert and clamp S31.32 sign-magnitude to Qm.n (signed 2's compl=
ement). The
> > > + * higher bits that above m + n are cleared or equal to sign-bit BIT=
(m+n).
> >=20
> > [nit] BIT(m + n - 1) if we count from 0.
>=20
> do we real need to consider this, convert to (Q1.0) :)
> I think it can be easily caught by review.

Q1.0 has a range of [-1, 0] and precision of 1, but I don't get how
this is relevant. I was just referring to convention that bits get
counted from 0, so the most significant bit is simply at position
m + n - 1 and not m + n.
m + n in, say, Q16.16 would be bit 32, which is just past the valid
[0..31] bits.

I was hoping that by explicitly tagging the comment with '[nit]' would
help convey its low importance :).

> >=20
> > > + */
> > > +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> > > +				      uint32_t m, uint32_t n)
> > > +{
> > > +	u64 mag =3D (user_input & ~BIT_ULL(63)) >> (32 - n);
> > > +	bool negative =3D !!(user_input & BIT_ULL(63));
> > > +	s64 val;
> > > +
> > > +	WARN_ON(m < 1 || m > 32 || n > 32);
> > > +
> > > +	/* the range of signed 2's complement is [-2^(m-1), 2^(m-1) - 2^-n]=
 */
> > > +	val =3D clamp_val(mag, 0, negative ?
> > > +				BIT_ULL(n + m - 1) : BIT_ULL(n + m - 1) - 1);
> > > +
> > > +	return negative ? -val : val;
> > > +}
> > > +EXPORT_SYMBOL(drm_color_ctm_s31_32_to_qm_n);
> > > +
> > >  /**
> > >   * drm_crtc_enable_color_mgmt - enable color management properties
> > >   * @crtc: DRM CRTC
> > > diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgm=
t.h
> > > index d1c662d92ab7..60fea5501886 100644
> > > --- a/include/drm/drm_color_mgmt.h
> > > +++ b/include/drm/drm_color_mgmt.h
> > > @@ -30,6 +30,8 @@ struct drm_crtc;
> > >  struct drm_plane;
> > > =20
> > >  uint32_t drm_color_lut_extract(uint32_t user_input, uint32_t bit_pre=
cision);
> > > +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> > > +				      uint32_t m, uint32_t n);
> > > =20
> > >  void drm_crtc_enable_color_mgmt(struct drm_crtc *crtc,
> > >  				uint degamma_lut_size,
> > >=20
> >=20
> >=20
>=20


--=20
Mihail



