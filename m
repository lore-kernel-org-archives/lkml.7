Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A662C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB0F2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="0ll6BaS+";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="0ll6BaS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfJKNw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:52:59 -0400
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:8551
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728120AbfJKNw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgL+Jy3wjKTV4DdhtJqxlJIzAG1S5mIBShX5SWP/tL8=;
 b=0ll6BaS+ZPqP18wBb1+GMACX6yzLZp5oLKXusnkCsxcB5NLRlJ4I2RwmhTVInRPWd/xkMLwAhux36bfbrrMaO3NWHjx/az/qx2b/s2hB5aZgMPytyhdLNP5wOxXrOsjDSVTVMQ8bJY92UCWUpYZ2cjm+3aEu5Xu6MxHdBDfh4to=
Received: from VI1PR0802CA0025.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::11) by DB8PR08MB4091.eurprd08.prod.outlook.com
 (2603:10a6:10:a2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Fri, 11 Oct
 2019 13:51:12 +0000
Received: from DB5EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::209) by VI1PR0802CA0025.outlook.office365.com
 (2603:10a6:800:a9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.18 via Frontend
 Transport; Fri, 11 Oct 2019 13:51:12 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT059.mail.protection.outlook.com (10.152.21.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 11 Oct 2019 13:51:10 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Fri, 11 Oct 2019 13:51:07 +0000
X-CR-MTA-TID: 64aa7808
Received: from 109d1fc128e0.3 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.2.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B97160E5-B932-4307-8A84-D455A67856C8.1;
        Fri, 11 Oct 2019 13:51:02 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2052.outbound.protection.outlook.com [104.47.2.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 109d1fc128e0.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 11 Oct 2019 13:51:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSjmn4rJzLtd95RWvjzqWs9Axeopm2IdkWVFXWx8emiImlf381KZV/iJamn4tmpjvd1zLTzeFo6t7rBQwiSfyRimOtDxaDxda+EE2Cr85tfOfz94NYtID+h1ikNfl7EyDhD4xg3vjN9bXFBmpihiwVR5DZ93XgXOz23FypQpra0uFgxnyoz4LcDQyGfs/NMAQEA+8T+TOb6Muz9G3UVw8AL7S4jSV8MPbjJ9jR7AvB7CHcoRBG1iyBx/Y6IMxFJPu5BkJz/vAU7PKhTL328q2ql6jKPrC0E2rJrUGjiOc6sxX5ANJe6WbT4NCps9imiVMGKb2kpmhmY19Qhf96x1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgL+Jy3wjKTV4DdhtJqxlJIzAG1S5mIBShX5SWP/tL8=;
 b=mOCrtJPQd+f8x6owbc4clg9yhRS+w7gyOUla4iMlCSf2km9khSzH0tbTtSY/neFTEJNe12IUV0jN5zI/OJbFSZ32hTP6NcSns2FwUkajQS6ZZLM/4iBWB+H1/DKP7TD40e2EXzpy9+lFT12qhRPmP9E+rk2Pr68v5inpyVy41NfPYmLCCg3Z5SQG9inELbJ3rTOw65m/+UXET1a82+qOjeayPx/wZJHh+oTw7+5sSX4bkK5qDV2Q6kJSGVozj5kD3173ikqoAaSlYE8WgHHF2zMmODUb8D7E/UMRarizUThOGK1J9h1AV8Vf8Qn5fAvCDQxejIVYLXQKSpgIWkouHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgL+Jy3wjKTV4DdhtJqxlJIzAG1S5mIBShX5SWP/tL8=;
 b=0ll6BaS+ZPqP18wBb1+GMACX6yzLZp5oLKXusnkCsxcB5NLRlJ4I2RwmhTVInRPWd/xkMLwAhux36bfbrrMaO3NWHjx/az/qx2b/s2hB5aZgMPytyhdLNP5wOxXrOsjDSVTVMQ8bJY92UCWUpYZ2cjm+3aEu5Xu6MxHdBDfh4to=
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com (52.134.110.24) by
 DB7PR08MB3658.eurprd08.prod.outlook.com (20.176.237.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 11 Oct 2019 13:51:01 +0000
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::f9f9:ad51:6636:42f0]) by DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::f9f9:ad51:6636:42f0%6]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 13:51:01 +0000
From:   "Justin He (Arm Technology China)" <Justin.He@arm.com>
To:     Catalin Marinas <Catalin.Marinas@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "hejianet@gmail.com" <hejianet@gmail.com>,
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>,
        nd <nd@arm.com>
Subject: RE: [PATCH v11 1/4] arm64: cpufeature: introduce helper
 cpu_has_hw_af()
Thread-Topic: [PATCH v11 1/4] arm64: cpufeature: introduce helper
 cpu_has_hw_af()
Thread-Index: AQHVfn2fVz/WJ52EYEizqdXPogUta6dUFqAAgACNw7CAAJ7OAIAANRzg
Date:   Fri, 11 Oct 2019 13:51:01 +0000
Message-ID: <DB7PR08MB3082DDB5E28648F873D23493F7970@DB7PR08MB3082.eurprd08.prod.outlook.com>
References: <20191009084246.123354-1-justin.he@arm.com>
 <20191009084246.123354-2-justin.he@arm.com>
 <20191010164312.GB40923@arrakis.emea.arm.com>
 <DB7PR08MB3082E71F1FF5FE8462F88B8BF7970@DB7PR08MB3082.eurprd08.prod.outlook.com>
 <20191011103857.GB54842@arrakis.emea.arm.com>
In-Reply-To: <20191011103857.GB54842@arrakis.emea.arm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 51cc0dae-e2ad-4a87-97e9-8c67649a08d7.1
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 68de0af2-0ae5-4d08-a5fa-08d74e52129b
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: DB7PR08MB3658:|DB7PR08MB3658:|DB8PR08MB4091:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB4091E801BD75178336B72787F7970@DB8PR08MB4091.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:421;OLM:421;
x-forefront-prvs: 0187F3EA14
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(979002)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(13464003)(51914003)(189003)(199004)(11346002)(5660300002)(81156014)(7696005)(8676002)(81166006)(55236004)(446003)(76176011)(26005)(25786009)(102836004)(229853002)(53546011)(6506007)(14454004)(55016002)(71190400001)(486006)(99286004)(71200400001)(86362001)(476003)(6636002)(186003)(66066001)(8936002)(6436002)(7736002)(66446008)(6306002)(52536014)(74316002)(66556008)(66476007)(966005)(305945005)(316002)(6862004)(66946007)(76116006)(9686003)(2906002)(6246003)(6116002)(256004)(3846002)(33656002)(478600001)(64756008)(4326008)(54906003)(309714004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3658;H:DB7PR08MB3082.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: bNKoMGHhR5bA+Dv9W7HW4uxPlkPEPx1zQY9+nurjPuQmT87bsBB/Et7xGePq2sEko1BnbN5mA/GogUl7Z/Bp5Qnxz8BKQpINlEe0rl2iRChK0XrIDrdHbMPUEW3EOrQ/NBoi6bH0Kj9B+HqW2tSMX1chsLjWHdpupeVXmioG2PhDpA4Mr2Edg7s9GSGX4nQJ3H61ERTudO30EdOKeYpXsmZq2bDJIEVUUOX4VLixVXcRPzrRXBkgz6+3/lkywxoVXVkHqzgPSibI/Qv73bJL6czcv22yHR6UGY7TqAS3o1zVFWDK+zFY0HwS8azmhPN8w840ZHNpCu6geZCzt6v1VluvUAHXnhdafU3njoXqfB1aaMzIubiX5M3t5whF+DrwXo5b32aL/EsYQWMSfrXe/IV1Y3mR4TNaccbqGdgwiPSmp/qS3uK4ZxlcxLbJJOLJ+jiXYdSkmKu0/AIhyYS09Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3658
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(4636009)(346002)(376002)(39850400004)(396003)(136003)(51914003)(13464003)(199004)(189003)(2906002)(23726003)(5660300002)(26826003)(99286004)(6116002)(966005)(478600001)(126002)(6636002)(47776003)(76130400001)(3846002)(50466002)(70586007)(97756001)(46406003)(476003)(33656002)(486006)(356004)(70206006)(6862004)(4326008)(26005)(63350400001)(186003)(25786009)(446003)(8746002)(8936002)(81166006)(81156014)(7696005)(8676002)(229853002)(6246003)(66066001)(86362001)(305945005)(14454004)(54906003)(52536014)(11346002)(316002)(22756006)(6506007)(53546011)(74316002)(6306002)(55016002)(102836004)(76176011)(9686003)(7736002)(336012)(309714004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB4091;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 639bb178-45ff-406c-2e81-08d74e520d93
NoDisclaimer: True
X-Forefront-PRVS: 0187F3EA14
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0JManUeCoORKWfi14LpzlI0+dY/clIKXK01DAcRCa6WN4hOZyk3+ijPBvLq96FuIci5flFSQkUT//AOBBBvATsnfyt3WgDXMAHBkIkthi7kwNfi8Q1wJW7LT1GNhuyD3FHDgk/ISK47Hd1lCJhSAfqu8hqr2YJWmeag+GueYLXndrPwgfTV2Jj1T/xQ+JcbdjVtr81SKevycATJ9mZgVCKrGBbnCvDxsuO/1OaOJBDYeykffmWEQpYCIh4rWc1EMCbCkjmpd2M1ae7FcJ3vhaQOlYd2xJfYHCZuMlDImRi1fc4BPBEpN9PmJDE2JoztgZ0dlOC/ySy2pd2x2ldfLBHVNNdxAhG0mC9L+nDk3MXG+Nt6tr2nF+XpGCphmihOuiOLQHRWytIDUVEeR9wimXt2lTUjJBFiBYwsTjmiqNrDXTNmIf2ckbbv7re63C6+WoRZTpGBXHlzrPslfb3z9iw==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 13:51:10.1118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68de0af2-0ae5-4d08-a5fa-08d74e52129b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catanlin
Thanks for the detailed explanation.
Will send out v12 soon after testing

--
Cheers,
Justin (Jia He)

=20

> -----Original Message-----
> From: Catalin Marinas <catalin.marinas@arm.com>
> Sent: Friday, October 11, 2019 6:39 PM
> To: Justin He (Arm Technology China) <Justin.He@arm.com>
> Cc: Will Deacon <will@kernel.org>; Mark Rutland
> <Mark.Rutland@arm.com>; James Morse <James.Morse@arm.com>; Marc
> Zyngier <maz@kernel.org>; Matthew Wilcox <willy@infradead.org>; Kirill A.
> Shutemov <kirill.shutemov@linux.intel.com>; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> mm@kvack.org; Suzuki Poulose <Suzuki.Poulose@arm.com>; Borislav
> Petkov <bp@alien8.de>; H. Peter Anvin <hpa@zytor.com>; x86@kernel.org;
> Thomas Gleixner <tglx@linutronix.de>; Andrew Morton <akpm@linux-
> foundation.org>; hejianet@gmail.com; Kaly Xin (Arm Technology China)
> <Kaly.Xin@arm.com>; nd <nd@arm.com>
> Subject: Re: [PATCH v11 1/4] arm64: cpufeature: introduce helper
> cpu_has_hw_af()
>=20
> On Fri, Oct 11, 2019 at 01:16:36AM +0000, Justin He (Arm Technology China=
)
> wrote:
> > From: Catalin Marinas <catalin.marinas@arm.com>
> > > On Wed, Oct 09, 2019 at 04:42:43PM +0800, Jia He wrote:
> > > > +		u64 mmfr1 =3D read_cpuid(ID_AA64MMFR1_EL1);
> > > > +
> > > > +		return !!cpuid_feature_extract_unsigned_field(mmfr1,
> > > > +
> > > 	ID_AA64MMFR1_HADBS_SHIFT);
> > >
> > > No need for !!, the return type is a bool already.
> >
> > But cpuid_feature_extract_unsigned_field has the return type "unsigned
> int" [1]
> >
> > [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch
> /arm64/include/asm/cpufeature.h#n444
>=20
> And the C language gives you the automatic conversion from unsigned int
> to bool without the need for !!. The reason we use !! in some places is
> for converting long to int (not bool) and losing the top 32-bit. See
> commit 84fe6826c28f ("arm64: mm: Add double logical invert to pte
> accessors") for an explanation.
>=20
> --
> Catalin
