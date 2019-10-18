Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298F7CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6118222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="xYAEUymB";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="xYAEUymB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438693AbfJRKQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 06:16:40 -0400
Received: from mail-eopbgr30061.outbound.protection.outlook.com ([40.107.3.61]:58020
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438471AbfJRKQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTyPv+JW84MjyhdjJpffPNM2vPRPmFYh7RbmzcD4AAM=;
 b=xYAEUymBNFAubRQ47LjFVvru45KKsySOepoaMviV3rkFoLTz7so03ajcpvklcLqWD4Ayii/T+X1ljQFLSPqHWsP/T+GkKXLgkcaYoR1rqRPZVbzm5yHUKgJME1j7igwruxTruUX1EmdzZ8Km6gtNIFsJ9aVWX1Cdg9DWLshUvpo=
Received: from VI1PR08CA0177.eurprd08.prod.outlook.com (2603:10a6:800:d1::31)
 by VE1PR08MB5198.eurprd08.prod.outlook.com (2603:10a6:803:10d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Fri, 18 Oct
 2019 10:16:27 +0000
Received: from AM5EUR03FT021.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by VI1PR08CA0177.outlook.office365.com
 (2603:10a6:800:d1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.18 via Frontend
 Transport; Fri, 18 Oct 2019 10:16:27 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT021.mail.protection.outlook.com (10.152.16.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 18 Oct 2019 10:16:25 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Fri, 18 Oct 2019 10:16:21 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 075ead6eb65a5547
X-CR-MTA-TID: 64aa7808
Received: from c7c900905e49.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.2.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D1198BE6-59C9-43ED-BCE5-FB2134247329.1;
        Fri, 18 Oct 2019 10:16:15 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2054.outbound.protection.outlook.com [104.47.2.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c7c900905e49.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 18 Oct 2019 10:16:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBZPuNU1lLP+mDxU9SrmhpddBL6smoN+/Wxe3IxxtSekQHSJTLPdFkubhmH72Ktpz0Ea6W9hXhrqQE8uXwvpLzJeCZUJNduCLYt6FXoAKU8r41b6h6xSpLXNxondRJQAJk2SCJnNFjcdhdLmKn0UEK9eonWKPH6hzgLR1SNNv/cmk+lcIJcVCr/Bw03xx7wUnR3QeJxOqLCR/ZZpxyYArPNRIJOsnlK4mQWH8nBMkfHdEexe7xzkep/hTdGEGS1AnrXIhLNcd4VLdcwNxIH2ZG+xQkVoIzRQyL2MgpD638RWbVgGXcPlRStSR4d+OZo6qJj8xG2RCJCa58g4nV68yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTyPv+JW84MjyhdjJpffPNM2vPRPmFYh7RbmzcD4AAM=;
 b=mB6+iCqpl0i0VAs0RrN9JCtox1yewTJOzuAahnV2fWQrk1bU5TR+ml1VVMrPPiIrfw9Gd0dGkvjM8T+j52foAgm2WWkntr+zEqRYb0PqJqfny8HcOoxDwh8ivyWTdgJ8qsqLEYswzqP4Ix5uwj+LNwwjG0cL1IctOaLrVBQsgcXG4MB8h/PO79fg1HGCckB32oXXae2ryN11JwNb93MvBKRwWtPdthx8Jiz+kpYKfUQ0IA0CLzdap8RJv8TQTNkPxntB+l9ExCAz1EuVx+o+zN3HhGTfMuCEI0LTRAbcO5v1Tmc9iUx4RRKloTp+soTzkSXQc8lIsD758VnCvAce2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTyPv+JW84MjyhdjJpffPNM2vPRPmFYh7RbmzcD4AAM=;
 b=xYAEUymBNFAubRQ47LjFVvru45KKsySOepoaMviV3rkFoLTz7so03ajcpvklcLqWD4Ayii/T+X1ljQFLSPqHWsP/T+GkKXLgkcaYoR1rqRPZVbzm5yHUKgJME1j7igwruxTruUX1EmdzZ8Km6gtNIFsJ9aVWX1Cdg9DWLshUvpo=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5040.eurprd08.prod.outlook.com (10.255.159.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 18 Oct 2019 10:16:13 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.026; Fri, 18 Oct 2019
 10:16:13 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
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
Thread-Index: AQHVhA09wVtvHgqrOkmWUho1ovfOOaddGi2AgALvSoCAABu1gIAADNQA
Date:   Fri, 18 Oct 2019 10:16:13 +0000
Message-ID: <20191018101606.GA26967@jamwan02-TSP300>
References: <20191016103339.25858-1-james.qian.wang@arm.com>
 <2404938.QDdPyV61sH@e123338-lin> <20191018075101.GA19928@jamwan02-TSP300>
 <4381055.oiViQHVQgJ@e123338-lin>
In-Reply-To: <4381055.oiViQHVQgJ@e123338-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0197.apcprd02.prod.outlook.com
 (2603:1096:201:21::33) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 353aecd1-56c2-4268-f7b9-08d753b43be4
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5040:|VE1PR08MB5040:|VE1PR08MB5198:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB51984CD39B61E5A544B07E0FB36C0@VE1PR08MB5198.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 01949FE337
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(189003)(199004)(6116002)(14454004)(478600001)(54906003)(81166006)(81156014)(8676002)(8936002)(7736002)(25786009)(6486002)(256004)(3846002)(14444005)(2906002)(229853002)(1076003)(86362001)(4326008)(6436002)(11346002)(55236004)(6506007)(386003)(486006)(52116002)(99286004)(6636002)(5660300002)(476003)(33716001)(446003)(6862004)(6246003)(64756008)(6512007)(76176011)(66066001)(66946007)(71200400001)(71190400001)(66476007)(186003)(316002)(58126008)(102836004)(66446008)(33656002)(9686003)(26005)(66556008)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5040;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: pn0afTntVzx1seH2VDheqprqW8HdNI77lA30GbeNngp8Mt32x+4FM/VJdw13DTX2y90BO7eLfdwNc6vi/00yKYBJXaQfMBvYfW/7WCrhDdqYJuATw8pkVGUEPfyBTRgx1yK+Zw3N045o5JYgvbiIYB/VnS505/Kl8LQ+milkNdz5gUnCWukf3uc9rv2c0d5m5BO3EWmeMZBaX5xPn6PYrNW1LKzWjoChpUOGW8/JhxQGU+a45yQj2/fono1S4XAgux/M5OMTFRZY5D0tOwMb5FpWa/M3c1ZvxR5dEnwTAFKCnt0rTSVjFE/fpk0jvXV3RkHeNrUG9UBww01rqYUIFff+Jt/KPzWUo3Now+1R1iMwe0tUdQFJY57evDDvJLyORN9OSB6ugqKRjxx+6UJwCAccxpNUJk7fA/1qzU4SVTs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2ACF7231D728B443810BFD099710F1A7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5040
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT021.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(376002)(396003)(346002)(136003)(199004)(189003)(6512007)(70586007)(47776003)(9686003)(66066001)(70206006)(36906005)(1076003)(316002)(23726003)(4326008)(3846002)(6116002)(58126008)(6636002)(25786009)(14444005)(33656002)(46406003)(107886003)(6246003)(6862004)(5660300002)(14454004)(126002)(486006)(356004)(33716001)(99286004)(7736002)(476003)(336012)(446003)(305945005)(50466002)(11346002)(63350400001)(76176011)(478600001)(76130400001)(2906002)(26826003)(54906003)(102836004)(8746002)(8936002)(186003)(81166006)(81156014)(8676002)(229853002)(6486002)(6506007)(86362001)(97756001)(26005)(22756006)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5198;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0c8668e2-3510-48c4-548a-08d753b4341f
NoDisclaimer: True
X-Forefront-PRVS: 01949FE337
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b7JlF5XZXQnEV4bpVGMlxwCNgMZga5bAfnfCWujC8itucjJYVSyKXXA+0qxCZiM1Hd3BVuyuBrxhCwHCBsOgz6OV2jfAnDywnQBHMjd88npfl1YB9v5N2v9xPtonpgTLdPuhNQqCg+gldwQ5DtuPI5MPkqtj1jb4vQVeGs+ZuERUifKLC32WMaU9MprePCzATATuKLz8XMpgllfVOjgaF53a/Z0iLx+uvBh5hjDSZ1ZYbGEWizEBKsd7X3QglSC8gocrywlHxrFXoUgRpNQdYeKLGNx/P2dZKpTzup0tu3hFhxpdZpN/ALoC8AFR3Ho7jabbDH3wbGVoRz28ysXvJShuUjqpRwv8+6Ybxt6FABDYtb/9N0G2jwJiKAphPWBGE23cMlqTe/WHti1ERMxz9PapJWUeH6fpEpM3N2F4QXc=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2019 10:16:25.9263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 353aecd1-56c2-4268-f7b9-08d753b43be4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 09:30:11AM +0000, Mihail Atanassov wrote:
> On Friday, 18 October 2019 08:51:09 BST james qian wang (Arm Technology C=
hina) wrote:
> > On Wed, Oct 16, 2019 at 11:02:03AM +0000, Mihail Atanassov wrote:
> > > On Wednesday, 16 October 2019 11:34:08 BST james qian wang (Arm Techn=
ology China) wrote:
> > > > Add a new helper function drm_color_ctm_s31_32_to_qm_n() for driver=
 to
> > > > convert S31.32 sign-magnitude to Qm.n 2's complement that supported=
 by
> > > > hardware.
> > > >=20
> > > > V4: Address Mihai, Daniel and Ilia's review comments.
> > > > V5: Includes the sign bit in the value of m (Qm.n).
> > > >=20
> > > > Signed-off-by: james qian wang (Arm Technology China) <james.qian.w=
ang@arm.com>
> > > > Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>
> > > > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > > ---
> > > >  drivers/gpu/drm/drm_color_mgmt.c | 27 +++++++++++++++++++++++++++
> > > >  include/drm/drm_color_mgmt.h     |  2 ++
> > > >  2 files changed, 29 insertions(+)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm=
_color_mgmt.c
> > > > index 4ce5c6d8de99..d313f194f1ec 100644
> > > > --- a/drivers/gpu/drm/drm_color_mgmt.c
> > > > +++ b/drivers/gpu/drm/drm_color_mgmt.c
> > > > @@ -132,6 +132,33 @@ uint32_t drm_color_lut_extract(uint32_t user_i=
nput, uint32_t bit_precision)
> > > >  }
> > > >  EXPORT_SYMBOL(drm_color_lut_extract);
> > > > =20
> > > > +/**
> > > > + * drm_color_ctm_s31_32_to_qm_n
> > > > + *
> > > > + * @user_input: input value
> > > > + * @m: number of integer bits, include the sign-bit, support range=
 is [1, 32]
> > >=20
> > > Any reason why numbers like Q0.32 are disallowed? In those cases, the
> > > 'sign' bit and the first fractional bit just happen to be the same bi=
t.
> > > The longer I look at it, the more I think mentioning a 'sign-bit' her=
e
> > > might confuse people more, since 2's complement doesn't have a
> > > dedicated bit just for the sign. How about reducing it simply to:
> >=20
> > No, since the value is signed there must be dedicated sign-bit.
>=20
> As I've said a few times before in this review, 2's complement has no
> dedicated sign bit, that's the whole reason 2's complement exists in
> the first place. The sign is implemented by negating the weight of
> the most significant bit. This isn't a dedicated +/- field!
>=20
> >=20
> > consider very simple 2 bit signed, Q1.1
> >=20
> >  0.5  is 01
> >  0    is 00
> > -0.5  is 11
> > -1.0  is 10, sign-bit and value share same bit, but it is integer part.
>=20
> And a very simple 2-bit signed Q0.2 would look like this:
>=20
> weights: (-2^-1)*b1 + (2^-2)*b0
>           ^
>           L-> note negative weight at most significant bit position
>=20
> +-------------+---------------+
> / bit pattern | decimal value |
> +-------------+---------------+
> \     00      |     0.0       |
> /     01      |     0.25      |
> \     10      |    -0.5       |
> /     11      |    -0.25      |
> +-------------+---------------+
>=20
> (Apologies for the ragged left border on the table :/)
>=20
> I genuinely don't see why you really want to have that integer part be
> strictly non-zero in size, it can very well be all fractional.
>=20
> >=20
> > See the wiki:
> >=20
> > One convention includes the sign bit in the value of m,[1][2] and the o=
ther convention
> > does not. The choice of convention can be determined by summing m+n. If=
 the value is equal
> > to the register size, then the sign bit is included in the value of m. =
If it is one
> > less than the register size, the sign bit is not included in the value =
of m.
>=20
> This is very much off the mark. See above for my sign bit in 2's
> complement rant. With that caveat, what you refer to as the sign
> bit is simply the top bit. If m+n is 16, then what you refer to as
> the sign bit is in bit position 15 with a weight of -2^(m-1). If
> m+n is instead 13, then all that changes is that the bit with the
> weight of -2^(m-1) is at position 12.
>=20
> Most importantly, there is nothing special about m + n =3D=3D regsize,
> the lack of sign-extension aside.
>=20
> What I think is the source of confusion is that when you expand, say,
> Q4.4 into a Q8.8, you need to do sign extension, so bit position 7
> in the original Q4.4 needs to be replicated into positions 12-15 in
> addition to moving it to position 11 in the destination format. But
> then those are no longer sign bits, the signedness is encoded in bit
> 15 as a weight of -2^7 :).
>

Thank you very much.

finial I got it, will update the patch in the next version=20

> >=20
> > So for the 32bit value, all fractional:
> >=20
> > a) M include sign-bit: Q1.31
>=20
> This is a 32-bit number with range [-1, 1 - 2^-31] and precision 2^-31.
> The weight of bit 31 is simply -2^0 (i.e. -1). This has 1 integer bit.
>=20
> > b) M doesn't include sign-bit: Q0.31
>=20
> This is a 31-bit number with range [-0.5, 1 - 2^-31]. Same precision as
> above but smaller range. This is all fractional but not a 32-bit value.
> I think you're looking for Q0.32, which has almost the same range but
> double the precision.
>=20
> >=20
> > >=20
> > >  * @m: number of integer bits, m <=3D 32.
> > >=20
> > > > + * @n: number of fractional bits, only support n <=3D 32
> > > > + *
> > > > + * Convert and clamp S31.32 sign-magnitude to Qm.n (signed 2's com=
plement). The
> > > > + * higher bits that above m + n are cleared or equal to sign-bit B=
IT(m+n).
> > >=20
> > > [nit] BIT(m + n - 1) if we count from 0.
> >=20
> > do we real need to consider this, convert to (Q1.0) :)
> > I think it can be easily caught by review.
>=20
> Q1.0 has a range of [-1, 0] and precision of 1, but I don't get how
> this is relevant. I was just referring to convention that bits get
> counted from 0, so the most significant bit is simply at position
> m + n - 1 and not m + n.
> m + n in, say, Q16.16 would be bit 32, which is just past the valid
> [0..31] bits.
>=20
> I was hoping that by explicitly tagging the comment with '[nit]' would
> help convey its low importance :).
>=20
> > >=20
> > > > + */
> > > > +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> > > > +				      uint32_t m, uint32_t n)
> > > > +{
> > > > +	u64 mag =3D (user_input & ~BIT_ULL(63)) >> (32 - n);
> > > > +	bool negative =3D !!(user_input & BIT_ULL(63));
> > > > +	s64 val;
> > > > +
> > > > +	WARN_ON(m < 1 || m > 32 || n > 32);
> > > > +
> > > > +	/* the range of signed 2's complement is [-2^(m-1), 2^(m-1) - 2^-=
n] */
> > > > +	val =3D clamp_val(mag, 0, negative ?
> > > > +				BIT_ULL(n + m - 1) : BIT_ULL(n + m - 1) - 1);
> > > > +
> > > > +	return negative ? -val : val;
> > > > +}
> > > > +EXPORT_SYMBOL(drm_color_ctm_s31_32_to_qm_n);
> > > > +
> > > >  /**
> > > >   * drm_crtc_enable_color_mgmt - enable color management properties
> > > >   * @crtc: DRM CRTC
> > > > diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_m=
gmt.h
> > > > index d1c662d92ab7..60fea5501886 100644
> > > > --- a/include/drm/drm_color_mgmt.h
> > > > +++ b/include/drm/drm_color_mgmt.h
> > > > @@ -30,6 +30,8 @@ struct drm_crtc;
> > > >  struct drm_plane;
> > > > =20
> > > >  uint32_t drm_color_lut_extract(uint32_t user_input, uint32_t bit_p=
recision);
> > > > +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> > > > +				      uint32_t m, uint32_t n);
> > > > =20
> > > >  void drm_crtc_enable_color_mgmt(struct drm_crtc *crtc,
> > > >  				uint degamma_lut_size,
> > > >=20
> > >=20
> > >=20
> >=20
>=20
>=20
> --=20
> Mihail
>=20
>=20
