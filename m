Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59446C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197032089C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="eCCm8hly";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="eCCm8hly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfJOJAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 05:00:07 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:6368
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728113AbfJOJAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7hzIMd7l0GcjS+dSpQOJi0mVi0M1923Q08g1GSg5eA=;
 b=eCCm8hlyQbDXvAUtshDjVYN2cK5KHfnsfSKJ1aiU4hjbddvBKPql9X4ogBHUhmMJ/K4lAh0nAkhr0iGYN2ko150owhYfMBRTwz1pi2Zk8DXA1pRSf5tfvPpct9+68CelED/zeGgj2D4QMfHpiMIHNYkyb1R94E8AlRvQe3QyMn0=
Received: from VI1PR0802CA0038.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::24) by VI1PR08MB3533.eurprd08.prod.outlook.com
 (2603:10a6:803:84::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Tue, 15 Oct
 2019 08:59:57 +0000
Received: from DB5EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::205) by VI1PR0802CA0038.outlook.office365.com
 (2603:10a6:800:a9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.18 via Frontend
 Transport; Tue, 15 Oct 2019 08:59:57 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT004.mail.protection.outlook.com (10.152.20.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 15 Oct 2019 08:59:55 +0000
Received: ("Tessian outbound 3fba803f6da3:v33"); Tue, 15 Oct 2019 08:59:51 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1904d8ef4fa598e7
X-CR-MTA-TID: 64aa7808
Received: from 3a57419f3a64.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.12.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6CA53FE3-F3D8-4963-984D-FE548D58D684.1;
        Tue, 15 Oct 2019 08:59:46 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2059.outbound.protection.outlook.com [104.47.12.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3a57419f3a64.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 15 Oct 2019 08:59:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZezBNl3yO4O/w7+qHaRWGAJ4mo+KIBysyCzFFmjOzIHYD22Xv9MYh05C28MON2VFkJePGF9XyHtIzggIa9twGrZPOBIQsWqCZpWe0TScd499Of6+IqgNFgK54WCuN8T5t5uhvkJNLlAap+DYDYmiR2os33j75VI0PaRELh9FJk86kayXETbbxM6vOkaHQtj49tI9XrJTu/BjtnVIzgOYPrtyJYyB/vPEH1DPTQ1SRjL/7f/FRoU3oM3OLRNVlmcpVu3+JMAK/SfGyLEbRC/HPZsS2ig5Fx70i3lBh0clXTwqaF3xoRdMWRa40sKxdb2kXWirs4iw2oLIZQbJqLGaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7hzIMd7l0GcjS+dSpQOJi0mVi0M1923Q08g1GSg5eA=;
 b=WUZrkeDGapHVtdTV9WBT6cHPghLYZXOzbay2PMva69rIvum3/Esq7kvM4fuiuwv4HxecOEKACx0Sjnce+FmVO3glYVd80rl7diadQDVg+qgu4vc7Ev+ndecb4S4l3awfkzhlJ1Y7I/OV7bzvH6O++L465gZmNI+RNyKs3GwW3LJJQDgrhmyYG1x0YpeMP+vg5yCXIi06HWI4lS37J+uCN4debRqGQdWMf6sCPM3eXG0qLpSw/jWmfA3ep/J++qsICcXd3sc2qjZa1c3NhWEwdUAWr75DZR/+28o0si5zKjZwWV91hRryWtvyfJE3Jhuo6WQ8A4wXVrNP+TxbKnh6Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7hzIMd7l0GcjS+dSpQOJi0mVi0M1923Q08g1GSg5eA=;
 b=eCCm8hlyQbDXvAUtshDjVYN2cK5KHfnsfSKJ1aiU4hjbddvBKPql9X4ogBHUhmMJ/K4lAh0nAkhr0iGYN2ko150owhYfMBRTwz1pi2Zk8DXA1pRSf5tfvPpct9+68CelED/zeGgj2D4QMfHpiMIHNYkyb1R94E8AlRvQe3QyMn0=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4704.eurprd08.prod.outlook.com (10.255.115.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Tue, 15 Oct 2019 08:59:44 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 08:59:44 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     Ilia Mirkin <imirkin@alum.mit.edu>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
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
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>
Subject: Re: [PATCH v2 1/4] drm/komeda: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Topic: [PATCH v2 1/4] drm/komeda: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Index: AQHVf/bDNAzoDxuLVU+by7UkFix6lKdaUJkAgACbswCAAHbuAIAACpaA
Date:   Tue, 15 Oct 2019 08:59:44 +0000
Message-ID: <20191015085937.GA1751@jamwan02-TSP300>
References: <20191011054240.17782-1-james.qian.wang@arm.com>
 <CAKb7Uvik6MZSwCQ4QF7ed1wttfufbR-J4vNdOtYzM+1tqPE_vw@mail.gmail.com>
 <20191015011604.GA26941@jamwan02-TSP300> <1687889.77CWzybTeB@e123338-lin>
In-Reply-To: <1687889.77CWzybTeB@e123338-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0198.apcprd02.prod.outlook.com
 (2603:1096:201:21::34) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 957c69c3-fed4-4847-44c2-08d7514e0c77
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4704:|VE1PR08MB4704:|VI1PR08MB3533:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB353387BF8AC8D137D11C6467B3930@VI1PR08MB3533.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 01917B1794
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(39860400002)(396003)(346002)(136003)(366004)(199004)(189003)(478600001)(9686003)(6512007)(33656002)(486006)(256004)(54906003)(99286004)(6246003)(2906002)(7736002)(305945005)(76176011)(4326008)(52116002)(25786009)(3846002)(6116002)(6486002)(6436002)(229853002)(71200400001)(26005)(6862004)(14454004)(186003)(71190400001)(102836004)(55236004)(1076003)(53546011)(6506007)(386003)(8936002)(446003)(8676002)(81156014)(81166006)(58126008)(316002)(33716001)(6636002)(66476007)(66556008)(66446008)(66946007)(64756008)(11346002)(476003)(66066001)(86362001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4704;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: uRQR+v8inLgw/oaDOiL0VHAhAhNTDiITFagYnKabx0kdwGPZkebXoy3UEHiEDDuaFHKzjS02D5wwKQ6iOfWKwnb96SsjBQVxna19MVqGgcmlzDhyNOMh9P57ioSQypZGdSNcaj5tEojXyqlP7efSV4d0VZxtkHDzI5ywUWy9IZ+4wJ9X/mL0wvZj+3eF3X9HMqzSUWXzjKkaDRWInZ73ytedCj2UC58IUwsODRvC4fRUlxvK8uNxWNR3OM1bz4I5MyUAakn85Zc/KkZq3omm0kgdSkhXrb9ROT93yeNOI3v7tVDK457vw2p+AVBIkYyZ6NmrNTuTO2f1P0+PzfKH1lr8jUzXty0rz73D4DGB5eHBtjiZ8g1jE+WNZDol4Snn4vIYcL2ozn223vWNA7QKUhOG+mY281hZ/dDqWkUWJ1I=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8EB86220C170F745A11A504C1DD3E4D0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4704
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(396003)(136003)(346002)(39860400002)(199004)(189003)(54906003)(478600001)(229853002)(1076003)(26826003)(6486002)(6512007)(9686003)(86362001)(70206006)(66066001)(58126008)(47776003)(23726003)(70586007)(336012)(486006)(76130400001)(33716001)(446003)(63350400001)(7736002)(11346002)(476003)(305945005)(126002)(50466002)(6636002)(81156014)(356004)(186003)(6506007)(53546011)(26005)(102836004)(8676002)(386003)(14454004)(46406003)(81166006)(25786009)(6116002)(6862004)(3846002)(4326008)(22756006)(8936002)(8746002)(76176011)(5660300002)(99286004)(6246003)(33656002)(97756001)(2906002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3533;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7463c02c-f9e2-4b10-51bf-08d7514e05a3
NoDisclaimer: True
X-Forefront-PRVS: 01917B1794
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: upRwvqjrcnTpcTLXtOLa4/Z1OSWDjIely+5StZEomyosUfn61hL33OmSlL7z+H4fkQ/HJE0ryxRKDo4/P4BYu9uCyww5YEEBcc7pFEcF2KqbkbnkdZdU4e/7H4uONIj3O/8FYJKLvhTWTTIYS89MaEBW0n0bNBEIJFRv5NT65z9gJvAeK0y8OtasPFKBzFww0iXSJ4kqhcS0IcsCDAwBF/ZbcKH+k7HASucTPLVFPF7Lj4xNhUg9EqULvYkN3DEb06eq0VjobQaZaWGEuWJHEq63/pCGkazhUkO22u6MI52NNOyaylBwtElD64zkfzo2zHHfOYPTOBa7+brECOpTKe72D4qN/UbD06RVCRqrPdIaWIltn1R12R4Nw1Pw3aG3T7mfjyiwQS0pE/GHZCtjstEkd4M7MWgGbWEUp68YXR0=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 08:59:55.4146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 957c69c3-fed4-4847-44c2-08d7514e0c77
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3533
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 08:21:44AM +0000, Mihail Atanassov wrote:
> On Tuesday, 15 October 2019 02:16:11 BST james qian wang (Arm Technology =
China) wrote:
> > On Mon, Oct 14, 2019 at 11:58:48AM -0400, Ilia Mirkin wrote:
> > > On Fri, Oct 11, 2019 at 1:43 AM james qian wang (Arm Technology China=
)
> > > <james.qian.wang@arm.com> wrote:
> > > >
> > > > Add a new helper function drm_color_ctm_s31_32_to_qm_n() for driver=
 to
> > > > convert S31.32 sign-magnitude to Qm.n 2's complement that supported=
 by
> > > > hardware.
> > > >
> > > > Signed-off-by: james qian wang (Arm Technology China) <james.qian.w=
ang@arm.com>
> > > > ---
> > > >  drivers/gpu/drm/drm_color_mgmt.c | 23 +++++++++++++++++++++++
> > > >  include/drm/drm_color_mgmt.h     |  2 ++
> > > >  2 files changed, 25 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm=
_color_mgmt.c
> > > > index 4ce5c6d8de99..3d533d0b45af 100644
> > > > --- a/drivers/gpu/drm/drm_color_mgmt.c
> > > > +++ b/drivers/gpu/drm/drm_color_mgmt.c
> > > > @@ -132,6 +132,29 @@ uint32_t drm_color_lut_extract(uint32_t user_i=
nput, uint32_t bit_precision)
> > > >  }
> > > >  EXPORT_SYMBOL(drm_color_lut_extract);
> > > >
> > > > +/**
> > > > + * drm_color_ctm_s31_32_to_qm_n
> > > > + *
> > > > + * @user_input: input value
> > > > + * @m: number of integer bits
> > >=20
> > > Is this the full 2's complement value? i.e. including the "sign" bit
> > > of the 2's complement representation? I'd kinda assume that m =3D 32,=
 n
> > > =3D 0 would just get me the integer portion of this, for example.
> >=20
> > @m doesn't include "sign-bit"
> >=20
> > and for this conversion only support m <=3D 31, n <=3D 32.
> >=20
> > > > + * @n: number of fractinal bits
> > >=20
> > > fractional
> >=20
> > Thank you.
> > >=20
> > > > + *
> > > > + * Convert and clamp S31.32 sign-magnitude to Qm.n 2's complement.
> > > > + */
> > > > +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> > > > +                                     uint32_t m, uint32_t n)
> > > > +{
> > > > +       u64 mag =3D (user_input & ~BIT_ULL(63)) >> (32 - n);
> > > > +       bool negative =3D !!(user_input & BIT_ULL(63));
> > > > +       s64 val;
> > > > +
> > > > +       /* the range of signed 2s complement is [-2^n+m, 2^n+m - 1]=
 */
> > >=20
> > > This implies that n =3D 32, m =3D 0 would actually yield a 33-bit 2's
> > > complement number. Is that what you meant?
> >=20
> > Yes, since m doesn't include sign-bit So a Q0.32 is a 33bit value.
> >=20
>=20
> I gotta say this would be quite confusing. There is no sign bit in 2's
> complement, per se. The MSbit just has a negative weight. Q16.16 is a
> 32-bit value, so Q0.32 should also be a 32-bit value with weights
> -2^-1, +2^-2, etc.
>=20
> Best to follow what Wikipedia says, right :).

Sorry, My fault! will correct in v5.

> > >=20
> > > > +       val =3D clamp_val(mag, 0, negative ? BIT(n + m) : BIT(n + m=
) - 1);
> > >=20
> > > I'm going to play with numpy to convince myself that this is right
> > > (esp with the endpoints), but in the meanwhile, you probably want to
> > > use BIT_ULL in case n + m > 32 (I don't think that's the case with an=
y
> > > current hardware though).
> >=20
> > Yes, you are right, I need to use BIT_ULL, and Mihail also point this o=
ut.
> > This is function is drived from our internal s31_32_to_q2_14()
> >=20
> > >=20
> > > > +
> > > > +       return negative ? 0ll - val : val;
> > >=20
> > > Why not just "negative ? -val : val"?
> >=20
> > will correct it.
> >=20
> > >=20
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
> > > >
> > > >  uint32_t drm_color_lut_extract(uint32_t user_input, uint32_t bit_p=
recision);
> > > > +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> > > > +                                     uint32_t m, uint32_t n);
> > > >
> > > >  void drm_crtc_enable_color_mgmt(struct drm_crtc *crtc,
> > > >                                 uint degamma_lut_size,
> > > > --
> > > > 2.20.1
> > > >
> >=20
>=20
>=20
> --=20
> Mihail
>=20
>=20
