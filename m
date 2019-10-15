Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E67C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D31E217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DK/V7t4E";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DK/V7t4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfJOIEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:04:46 -0400
Received: from mail-eopbgr140048.outbound.protection.outlook.com ([40.107.14.48]:44371
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727295AbfJOIEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WhRMRQrwjD7YAw0JiHnUI2hP/O9QSykPVkZopOmPdM=;
 b=DK/V7t4EJt+5t7gm7pogMYRALoqyISDpMLctXCcP2YuWHKz/GH74kJxzXunt/uGjn7WB6V9Pzx64Yb5w1kqXXrf7jN4d1TIOnwDTcINw8sXymeTpHcML8ZTicWyckSeGHl4c1sz2lb38FBZPLybnJEuNKfjoAOPXMIRygGJ3hjI=
Received: from VI1PR08CA0086.eurprd08.prod.outlook.com (2603:10a6:800:d3::12)
 by DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.18; Tue, 15 Oct
 2019 08:04:40 +0000
Received: from VE1EUR03FT038.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::203) by VI1PR08CA0086.outlook.office365.com
 (2603:10a6:800:d3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Tue, 15 Oct 2019 08:04:40 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT038.mail.protection.outlook.com (10.152.19.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 15 Oct 2019 08:04:38 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Tue, 15 Oct 2019 08:04:34 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8715c1b15fbbe74b
X-CR-MTA-TID: 64aa7808
Received: from 093b645d2a86.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 27E7B7F6-927A-415C-91BC-38D4112EB4AA.1;
        Tue, 15 Oct 2019 08:04:28 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2053.outbound.protection.outlook.com [104.47.4.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 093b645d2a86.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 15 Oct 2019 08:04:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hy2WWKKozQUAgFsiE+Q3dah/gcrUIKDvTcMnCouIjqhhHVbK806LxxOHPP/skTMdvNZM2nqqgN5z/p29jOiXNxqPJdDP5N3awwbELKcxl3lpW66Xk8zcgZN/EfJI7oZZQoGtKl0idRmMor11FBep2KtwPUDTEaASpOK5gb82/tvzB/UUpUOOD0TrXLaM8SWohBBcbShaiBjSubA0xWJlED3bmegEssZGdtQlhUJzjFnvFATxDXkpANFqaGrJrKHRnBCfQHLmtCd2zr7ViOvltl7Gf2zlsPHBqX22Lb/N02sdWwH80rvIYT949eQ/sKKIEgG5AEEYcKFSLDfjxassXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WhRMRQrwjD7YAw0JiHnUI2hP/O9QSykPVkZopOmPdM=;
 b=WfE4ak6qnz6c2KuRIMn1sK+vtXPaxDk17es2+IAHYk3hhVYqZh7YvT299PpNFDd9jlpfdvdO91a0iOTfuP8Z5R9EfMPvOne64sHQ7dhUYZs1Ia89dEEu1BdJ/SzwnszpdliL/tPBMkrafg56lUKctLfWeVerZaJFSiu9WZ2RvYYX2a9cVT8WqkqUepFMEABmEfzadnT/8Tn3O2jdH30ox1LoI9YMukH/u5uW0odZiLB2aT4+qEhucC3SUXzbZ5peD+a1YGf2Fqct6S4N4l29wgDwFVinEpxwlTDvGpRNp3CY0TO1uJ7qmYdOleSPqi/uOYozTUf5JtGJa0pvV4mEkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WhRMRQrwjD7YAw0JiHnUI2hP/O9QSykPVkZopOmPdM=;
 b=DK/V7t4EJt+5t7gm7pogMYRALoqyISDpMLctXCcP2YuWHKz/GH74kJxzXunt/uGjn7WB6V9Pzx64Yb5w1kqXXrf7jN4d1TIOnwDTcINw8sXymeTpHcML8ZTicWyckSeGHl4c1sz2lb38FBZPLybnJEuNKfjoAOPXMIRygGJ3hjI=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4960.eurprd08.prod.outlook.com (10.255.158.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Tue, 15 Oct 2019 08:04:26 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 08:04:26 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
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
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
Subject: Re: [PATCH v2 1/4] drm/komeda: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Topic: [PATCH v2 1/4] drm/komeda: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Index: AQHVf/bDNAzoDxuLVU+by7UkFix6lKdaUJkAgACbswCAACqhAIAAR3EA
Date:   Tue, 15 Oct 2019 08:04:26 +0000
Message-ID: <20191015080420.GA22242@jamwan02-TSP300>
References: <20191011054240.17782-1-james.qian.wang@arm.com>
 <20191011054240.17782-2-james.qian.wang@arm.com>
 <CAKb7Uvik6MZSwCQ4QF7ed1wttfufbR-J4vNdOtYzM+1tqPE_vw@mail.gmail.com>
 <20191015011604.GA26941@jamwan02-TSP300>
 <CAKb7Uvh7y20oikYR+UpabgXLHJM2i+2DPVyYSwE37d=NpheUGg@mail.gmail.com>
In-Reply-To: <CAKb7Uvh7y20oikYR+UpabgXLHJM2i+2DPVyYSwE37d=NpheUGg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::24) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 3d384682-37f6-4034-fa51-08d751465394
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4960:|VE1PR08MB4960:|DBBPR08MB4538:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB453855F330D9A54B078D9B5CB3930@DBBPR08MB4538.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4303;OLM:4303;
x-forefront-prvs: 01917B1794
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(396003)(39860400002)(376002)(366004)(346002)(189003)(199004)(6916009)(33656002)(256004)(6246003)(229853002)(6306002)(966005)(6436002)(66066001)(7736002)(305945005)(6512007)(9686003)(14454004)(58126008)(33716001)(54906003)(478600001)(316002)(6486002)(1076003)(26005)(2171002)(5660300002)(102836004)(66476007)(66946007)(6116002)(3846002)(66556008)(64756008)(66446008)(71200400001)(71190400001)(76176011)(386003)(6506007)(52116002)(99286004)(86362001)(11346002)(476003)(186003)(446003)(55236004)(53546011)(8936002)(25786009)(486006)(2906002)(4326008)(81166006)(81156014)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4960;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: UYE7Rr7reanK9RYS5WB2D1YsoF0UFePCCM4vBoWL4FKfPKI9SKSwuZEOskW16drf0zXaLgleTGxN2ETKXLmvlkWRreVUx9x8EkEL7AenJaRzT5RRcVDGBiUxOAEdpUkh/rXn1ARtKA0IiJMCqi27dm+OPDeETCD4vmj1Nzn8Z0+YvKSkjY5CkSdZX6GOrIhh2q7HTrYNFpeWBqpzyP+dhpJAY3Oq/QaAVMyymH3WUZbspGMp8SB1K9nLBJLW+/haRnGQDJGRgjVwYqP7/3ZVtX6c0XM3cFdxV/++GIUZqDMtEZVbQt3G6Wj7buoRd2VedVoaR+tDycRI4XvCw0x/JBaE3/iRS+1QEBQ8xkcXqkNFZ+D5+llSvUIajP4qRwAnIAPdfzoiYa+tSuETtqO9m3CxR5ZkQRKIUqHW6gLSsRlVyqMos0sGqb4pW6vAxxFB0dWqKDKG7+eYD90PKvdx8g==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12E7DBFF2DC9DE4CA94DC451C6EEB50D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4960
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT038.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(58126008)(36906005)(305945005)(33656002)(316002)(86362001)(2171002)(25786009)(102836004)(7736002)(26005)(229853002)(8676002)(81156014)(81166006)(6246003)(54906003)(8936002)(356004)(8746002)(50466002)(186003)(5660300002)(6306002)(1076003)(6512007)(47776003)(66066001)(386003)(6506007)(33716001)(70586007)(76176011)(2906002)(126002)(70206006)(76130400001)(6486002)(966005)(53546011)(9686003)(99286004)(22756006)(446003)(11346002)(26826003)(478600001)(97756001)(63350400001)(46406003)(4326008)(6862004)(336012)(23726003)(3846002)(6116002)(14454004)(476003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4538;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: aad850d9-869b-4726-e57b-08d751464c13
NoDisclaimer: True
X-Forefront-PRVS: 01917B1794
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ol/PYyZ2nkPvzpOkhchMQ07fcwvkHdyLvFnEFihwuj3jaf3bbZEMxxX6t8S30Cpm3gLcLXwi77cz8ESjZLe8XGWUlgS+Rbx/yZf1trPM9e2ygG28wkKI6L4xoFC1p2KA8BHrPTqtXopxcehtzlqq62UwoVtK5Z33b8MU6gNmhpGwZLBYGODFFiB77qZsJWYGFCOG0Fl4MeVc7BJnejMqaPk8MxIBG8URbt8AgJyTYG0/yqnA9yFCSh8dwZHPePSo6apYK9WZgUpg8E6zPdd7uV9sXcqEXazuGKBgVTkiZaa9D94vJtFUd2Y5jzsR1jghmmTiQwHPsQaeOoR4XQse296rjfYHI2nmx/U/0PHGxmlHQDxEoD0jma/iILssjBj+KGCg2tqu7Jv3YAeu280QyZPUDcxeRN5o2ARZSPg10mqEo1ifXfhXEWD+yxSLRSxy16ruTpeimo0kitMnxZIkiA==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 08:04:38.6876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d384682-37f6-4034-fa51-08d751465394
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4538
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 11:48:38PM -0400, Ilia Mirkin wrote:
> On Mon, Oct 14, 2019 at 9:16 PM james qian wang (Arm Technology China)
> <james.qian.wang@arm.com> wrote:
> > On Mon, Oct 14, 2019 at 11:58:48AM -0400, Ilia Mirkin wrote:
> > > On Fri, Oct 11, 2019 at 1:43 AM james qian wang (Arm Technology China=
)
> > > <james.qian.wang@arm.com> wrote:
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
> > >
> > > This implies that n =3D 32, m =3D 0 would actually yield a 33-bit 2's
> > > complement number. Is that what you meant?
> >
> > Yes, since m doesn't include sign-bit So a Q0.32 is a 33bit value.
>=20
> This goes counter to what the wikipedia page says [
> https://en.wikipedia.org/wiki/Q_(number_format) ]:
>=20
> (reformatted slightly for text-only consumption):
>=20
> """
> For example, a Q15.1 format number:
>=20
> - requires 15+1 =3D 16 bits
> - its range is [-2^14, 2^14 - 2^-1] =3D [-16384.0, +16383.5] =3D [0x8000,
> 0x8001 ... 0xFFFF, 0x0000, 0x0001 ... 0x7FFE, 0x7FFF]
> - its resolution is 2^-1 =3D 0.5
> """
>=20
> This suggests that the proper way to represent a standard 32-bit 2's
> complement integer would be Q32.0.
>

Yes you're right, I will send a new version to correct this code
according to the Wiki.

Thanks
James

>   -ilia
