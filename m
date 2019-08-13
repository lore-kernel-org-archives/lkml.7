Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9898C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CCF20651
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="IGbZnXc/";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="IGbZnXc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbfHMOlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:41:51 -0400
Received: from mail-eopbgr40055.outbound.protection.outlook.com ([40.107.4.55]:7426
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728216AbfHMOlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HomWtSVe00R157Jki78xAH0L6Dp3rvPwia+2gMIi5zU=;
 b=IGbZnXc/QBQIX72N6MWzQ8oWyRI1ogeavVz41kwFifrcE+kl85PMKjQdIyoX581RzVSwdGS3lPeycHGZs3SQts5N3XzBKajzI4RDycTZJWRvoJoKhMWOCaEGJwYo3EoF8i1+E9l2FYmX9PcCL3IJW59YUiH2XAIo95ITAIOCYNI=
Received: from VI1PR08CA0126.eurprd08.prod.outlook.com (2603:10a6:800:d4::28)
 by DB8PR08MB4956.eurprd08.prod.outlook.com (2603:10a6:10:e0::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.18; Tue, 13 Aug
 2019 14:41:45 +0000
Received: from AM5EUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::200) by VI1PR08CA0126.outlook.office365.com
 (2603:10a6:800:d4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.16 via Frontend
 Transport; Tue, 13 Aug 2019 14:41:45 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT049.mail.protection.outlook.com (10.152.17.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18 via Frontend Transport; Tue, 13 Aug 2019 14:41:43 +0000
Received: ("Tessian outbound a1fd2c3cfdb0:v26"); Tue, 13 Aug 2019 14:41:39 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: bbd765f446a65acf
X-CR-MTA-TID: 64aa7808
Received: from bef36e6b21fb.2 (cr-mta-lb-1.cr-mta-net [104.47.1.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 85C9BA67-92A3-4968-B783-FE266B64BDB8.1;
        Tue, 13 Aug 2019 14:41:34 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2058.outbound.protection.outlook.com [104.47.1.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bef36e6b21fb.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 13 Aug 2019 14:41:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnUhCebXxocG14uca/tEMczfplC5/GS7a8V0YNexryy5woJ7qx6akB2CMllhR1/ogBAcb0cErU1yBDtzwp6UqniWedg+/dIOwIw0qezZQKj9yDMJJTj1lrp56gyuNg8MTIkV8Ilx72/VVz1WD5VvrZRb9fGAU/VX/RZs6rK6ejnqOk0RUcIh2ImjO3WBYBWdTB1mdMpN/1jVQ3c/dUSXjX73UeQnXs+7RupIV64E4HLcVahip6iOKZGnbrMXSY1fCL+NVTN8HUXZjsY12Oykt9RZFWRVNEfhi7KK2Zn0gjuon6yCaIsGF9T5Qi378AfzIA/mlSw+bQ83K4JWxFlnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HomWtSVe00R157Jki78xAH0L6Dp3rvPwia+2gMIi5zU=;
 b=IkF+qJxADy4nCo87vkr9itIyrmk3E9TO/4l3ZCqCftNs7rOZ7VwvhO6lL9QpraNN4ZBM+Dax4ZOEiRlm84krflPz06amrNjaTrE7qs/PjMESQ1YpsYzFSGtdrMU2qYtiL0nxo9a093UqV4sHxsr3cDI9ph2tRbpGVARyfZ86QtIYQZbpnEjmr3HIZAva3MisiDtt+1k1sDyn0Cc76dIskZGoslzWDziDcg2HvzMQ9xF52K5J32TTb21CGPYk0N+4jdhZXgjxP7ztrvVsxQ+adDeiGpa0eo1edclQ0ZLftsw8Fi3vNpsQfuXHGkYcJyjk75wZJO36ZBNMFR4AyH6VuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HomWtSVe00R157Jki78xAH0L6Dp3rvPwia+2gMIi5zU=;
 b=IGbZnXc/QBQIX72N6MWzQ8oWyRI1ogeavVz41kwFifrcE+kl85PMKjQdIyoX581RzVSwdGS3lPeycHGZs3SQts5N3XzBKajzI4RDycTZJWRvoJoKhMWOCaEGJwYo3EoF8i1+E9l2FYmX9PcCL3IJW59YUiH2XAIo95ITAIOCYNI=
Received: from DB8PR08MB4105.eurprd08.prod.outlook.com (20.179.12.12) by
 DB8PR08MB5099.eurprd08.prod.outlook.com (10.255.18.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Tue, 13 Aug 2019 14:41:32 +0000
Received: from DB8PR08MB4105.eurprd08.prod.outlook.com
 ([fe80::f558:a6c5:f71c:491]) by DB8PR08MB4105.eurprd08.prod.outlook.com
 ([fe80::f558:a6c5:f71c:491%5]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 14:41:32 +0000
From:   Steve Capper <Steve.Capper@arm.com>
To:     Will Deacon <will@kernel.org>
CC:     Qian Cai <cai@lca.pw>, Catalin Marinas <Catalin.Marinas@arm.com>,
        "Andrey Konovalov" <andreyknvl@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: "arm64/for-next/core" causes boot panic
Thread-Topic: "arm64/for-next/core" causes boot panic
Thread-Index: AQHVUVgl/V1eSqMRPUyufGDCtItMGqb4yNmAgAAgpgCAABL2AIAAMcSA///5egA=
Date:   Tue, 13 Aug 2019 14:41:32 +0000
Message-ID: <20190813144130.GA15482@capper-ampere.manchester.arm.com>
References: <1565646695.8572.6.camel@lca.pw>
 <20190813090200.h2rz4xphgnb5j5bc@willie-the-truck>
 <20190813105852.ovk5gtzddwlsm4ly@willie-the-truck>
 <20190813120643.25y5px4andu6cfwp@willie-the-truck>
 <20190813140451.GA24579@capper-ampere.manchester.arm.com>
In-Reply-To: <20190813140451.GA24579@capper-ampere.manchester.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [217.140.106.32]
x-clientproxiedby: LO2P265CA0279.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::27) To DB8PR08MB4105.eurprd08.prod.outlook.com
 (2603:10a6:10:b0::12)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 9b07d181-2b16-48e7-1af1-08d71ffc5c7e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR08MB5099;
X-MS-TrafficTypeDiagnostic: DB8PR08MB5099:|DB8PR08MB4956:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB49565A1BA847B2D25B66EC6F81D20@DB8PR08MB4956.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 01283822F8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(199004)(189003)(81156014)(6246003)(64756008)(386003)(6506007)(5660300002)(102836004)(53936002)(26005)(186003)(1076003)(76176011)(305945005)(66476007)(66556008)(66946007)(52116002)(86362001)(66446008)(81166006)(7736002)(8676002)(14454004)(316002)(58126008)(446003)(11346002)(476003)(25786009)(6512007)(256004)(54906003)(99286004)(486006)(478600001)(44832011)(6116002)(66066001)(3846002)(6916009)(2906002)(229853002)(33656002)(71200400001)(6486002)(8936002)(71190400001)(6436002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5099;H:DB8PR08MB4105.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: ZEyvq5sVTHEytT6K7n7Yndo94sRZUfZt3ZG598hcFnZp+e52oFiqJKKso/5qqJY5ultaEu6qgXttCr0QD7AtYh+y8yv6lisK7ShNEoZgAvE6jCG+1dfdOAdDtxVeensaLt+YErYDFw0BnGgALsgxXW/EUCsaIekFHqCKT5OKV26UWzRG0bscC0QAbSiXEQKhT5IQEVu3ln+J+hvXT5USdZVjaz99guJ/+B258bL7qhshH9WS6kLt/Qn2siEIyDQ4kCJ/BxSPG/hhGY1cI5HAEtdAv/M26qm6tHtxO0BKQhtaXagiLwLSdx2G3Gke5PO9c3si1VS39yl3ut3EoK9PoA6islHnMpMyOKoMn/RrmRVjrVVIw9gNLs7xeLylI4hHRiwRmFcWfE+BAcjBY4SVQuD7ALw/1mD2XkUZmy6j0nk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <04F997140A69904B86CDF26BF2A3E53C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5099
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(2980300002)(189003)(199004)(26826003)(54906003)(8936002)(478600001)(3846002)(8746002)(23726003)(70586007)(6116002)(70206006)(8676002)(6246003)(81166006)(4326008)(81156014)(97756001)(25786009)(6862004)(76130400001)(36906005)(33656002)(99286004)(66066001)(316002)(58126008)(47776003)(486006)(476003)(5660300002)(186003)(14454004)(126002)(11346002)(7736002)(26005)(76176011)(305945005)(86362001)(386003)(6506007)(102836004)(2906002)(46406003)(22756006)(229853002)(446003)(63350400001)(63370400001)(6486002)(6512007)(336012)(1076003)(50466002)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB4956;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: ce893f85-11a0-4cce-400f-08d71ffc5586
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB8PR08MB4956;
NoDisclaimer: True
X-Forefront-PRVS: 01283822F8
X-Microsoft-Antispam-Message-Info: Y0eujGQe+LDy/1+5cSStyOci2Cev+XJCylAbF15A5lmAxbmQSBNeYg4YpsfhQLw/LGuYXO6weaJpIIdyGaTTyNn8w2ts894LclkjOy1Et6oOBEx25wQxfizjYk6+P5Xq0t66o/jJ0A000ALMHTIxxSWgB1Hw3xxgg/R67qdkoDCQjHYnCbBgDzyH+IvStb1ZLVwdeGwsQ+gbsxuzFukBJueEKGjEnrkw9x20GYjuonSjX9Ee1fDxEG9fLIB6+zFOjiou0hUl1CN4Yqfiso3hxW+K1a9BtJWIaw3zx87Z+1IwNgfU/IOOWv8u651Xx8KWwiYqodYIH5AGdw4f7K1dqvPywnJa2ZGyEKpdpqFeXG38aqB8xws5VWqCN2Lg4ii93QbXKULcySlH45cbaDOtG9aL7TS7BYjnNYlUfnNTJ94=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2019 14:41:43.9451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b07d181-2b16-48e7-1af1-08d71ffc5c7e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4956
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 03:04:52PM +0100, Steve Capper wrote:
> Hi Will,
>=20
> On Tue, Aug 13, 2019 at 01:06:44PM +0100, Will Deacon wrote:
> > [+Steve]
> >=20
> > On Tue, Aug 13, 2019 at 11:58:52AM +0100, Will Deacon wrote:
> > > On Tue, Aug 13, 2019 at 10:02:01AM +0100, Will Deacon wrote:
> > > > On Mon, Aug 12, 2019 at 05:51:35PM -0400, Qian Cai wrote:
> > > > > Booting today's linux-next on an arm64 server triggers a panic wi=
th
> > > > > CONFIG_KASAN_SW_TAGS=3Dy pointing to this line,
> > > >=20
> > > > Is this the only change on top of defconfig? If not, please can you=
 share
> > > > your full .config?
> > > >=20
> > > > > kfree()->virt_to_head_page()->compound_head()
> > > > >=20
> > > > > unsigned long head =3D READ_ONCE(page->compound_head);
> > > > >=20
> > > > > The bisect so far indicates one of those could be bad,
> > > >=20
> > > > I guess that means the issue is reproducible on the arm64 for-next/=
core
> > > > branch. Once I have your .config, I'll give it a go.
> > >=20
> > > FWIW, I've managed to reproduce this using defconfig + SW_TAGS on
> > > for-next/core, so I'll keep investigating.
>=20
> I've installed clang-8 and enabled CONFIG_KASAN_SW_TAGS and was able to
> reproduce the problem quite rapidly. Many apologies for missing this
> before in my testing.
>=20
> >=20
> > Right, hacky diff below seems to resolve this, so I'll split this up in=
to
> > some proper patches as there is more than one bug here.
> >=20
> > Thanks,
> >=20
> > Will
> >=20
> > --->8
> >=20
> > diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/m=
emory.h
> FWIW, this fixed the crashes I experienced, I'll run some additional
> tests.
>=20

This works for me with 52-bit VAs + CONFIG_KASAN_SW_TAGS +
CONFIG_DEBUG_VIRTUAL + CONFIG_DEBUG_VM

FWIW:
Tested-by: Steve Capper <steve.capper@arm.com>

Cheers,
--=20
Steve
