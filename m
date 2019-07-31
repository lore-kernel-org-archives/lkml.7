Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB338C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 03:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DB320651
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 03:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="cSMoutok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfGaDLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 23:11:39 -0400
Received: from mail-eopbgr730079.outbound.protection.outlook.com ([40.107.73.79]:54624
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726440AbfGaDLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 23:11:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xs4Je3Hc7cZIvYt0PqdgnYWqvhC6HJnVDIw25dWVUrH2GNof7LsM49+kHPxUVW+67RbJ0fQ4j8kayYOGFlygSf3S3io5XBL8xxIfQha42ymusfCMNiRRQ4w1X3gxQSM/JadeBzifG+hyafF9MeYMojF6LrSSKUYhWEA5olKg/Zd0Ijoi8FHQ+b1tzBlmE2rd7MnGoJubW90nGJoosIqyO+QLPEwUaCkgCd+GMsAOHPP353kKtU4fCnAu5249dGj6ALTKhm/4mpts88QFVqgm1y6+/Ovb01Ta1WoANnZEnUTwYVP1m7McWiOrKArWTZ3i6isE7k9WGvu4rY78h/z9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmJYGmV0qLv58hqz/iliLhuK3tG4t82A5INmNCLp+co=;
 b=MJMkaAlitsnGg25UBFopXTu/RTJy0Gz5yJ3huN+4/dHw2LbshdloXTqDU7+o+ALLeg/tEMBOPRuVyInpzigmkK8H7wqB9An+d4//cqH5H4WJ+9GE+IAp2A7xquAMa+zzfQ0UUGECY1/37lYw/ITbRUWX433iX4rdp/TDkE6ynYoI5FccFxsFfvHRoRQx4ajSTEH7Q/hWDBg4qmPyWjX3fGIASZ9Fnp73R1GqnTQPOH9G67WYd8A/IFav+iSTGRaZYvnSItv/UFXeRie9awm7hdV0j+OtyEaM0CN99j8PHs/JfAELKxfGPrqC7BjvSmNmtiK8DsJb1J0pdCdtuS9vKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmJYGmV0qLv58hqz/iliLhuK3tG4t82A5INmNCLp+co=;
 b=cSMoutokwLBacwph0HOl8Td9NaV+yCnkpyA42koG0hWkwLFOjylC63RFIHH+jfqFisPsZV6ISIAmMxIoNu1+P4jZCunNhw/eFLGhdw17baVqs5LkkKcPnN5kxG2m+QHTJlKGkUQSXfqSoQYNRtsu/BWDBC4NnkGRQRw9z4fwMcI=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5223.namprd05.prod.outlook.com (20.177.231.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.10; Wed, 31 Jul 2019 03:11:33 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718%2]) with mapi id 15.20.2136.009; Wed, 31 Jul 2019
 03:11:33 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Mike Travis <mike.travis@hpe.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v3 8/9] x86/mm/tlb: Remove UV special case
Thread-Topic: [PATCH v3 8/9] x86/mm/tlb: Remove UV special case
Thread-Index: AQHVPc0usbowTTFECki3EVK5pK8NM6bRNtyAgBLo1wA=
Date:   Wed, 31 Jul 2019 03:11:33 +0000
Message-ID: <9A6DA70B-F73E-454B-834E-08B36E0B7550@vmware.com>
References: <20190719005837.4150-1-namit@vmware.com>
 <20190719005837.4150-9-namit@vmware.com>
 <54c082c5-ebee-8fd7-cf69-b8c15b60a329@hpe.com>
In-Reply-To: <54c082c5-ebee-8fd7-cf69-b8c15b60a329@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6080a0ef-ae8a-451f-39ab-08d71564caa5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB5223;
x-ms-traffictypediagnostic: BYAPR05MB5223:
x-microsoft-antispam-prvs: <BYAPR05MB52230DCFA5C1E490AF7E689FD0DF0@BYAPR05MB5223.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(81166006)(102836004)(186003)(2906002)(26005)(3846002)(71190400001)(6116002)(6246003)(66446008)(71200400001)(66556008)(66476007)(64756008)(7736002)(53546011)(66946007)(446003)(478600001)(25786009)(316002)(68736007)(86362001)(36756003)(6916009)(6436002)(53936002)(11346002)(476003)(54906003)(2616005)(76116006)(486006)(66066001)(296002)(8936002)(4326008)(6486002)(33656002)(4744005)(81156014)(14454004)(229853002)(305945005)(76176011)(6512007)(5660300002)(8676002)(256004)(99286004)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5223;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e9/yRFtEDcYwhR75GGKHrNJZM+aPAXXShY6knRRtubjTk3uSoubr28u5HjACYwFV0BCTZITzYVDec+0AWdP62jJUCMbfHBJ8ieuHPvI7PCd3sAevV7je+PIt+AskGaH0eo+agvp7iZhumJdnEqWp4eEEar6I32oc+xPfz6uIgHpSsfqojjEf8q1O4MBN/3LT1vqyLIxa2xLnPVyOrpstJjB54SZka9l4mhRACXp+LAhE+Q8AQrZJIKX8swO4UYhZhKdZSCIk70ZXA2N79mCziwAVvNZa07jZWNsFp10p5ENXzuUUNAKhADo+XGesYYs2sbYZun3M9fq8u4xoXrIHIhTvLgWxnKqrrvClRVrgUbLSFBEsNFRkRuJqsqv076O6axiL5yDB11iCrdnb94KHnRw9Qn/TfbZwSJ0wibSx1n8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F10D7596CE124A41B89CB66868B1A980@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6080a0ef-ae8a-451f-39ab-08d71564caa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 03:11:33.4284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jul 18, 2019, at 7:25 PM, Mike Travis <mike.travis@hpe.com> wrote:
>=20
> It is a fact that the UV is still the UV and SGI is now part of HPE. The
> current external product is known as SuperDome Flex. It is both up to dat=
e
> as well as very well maintained. The ACK I provided was an okay to change
> the code, but please make the description accurate.

Looking at the code again, if I remove the call to uv_flush_tlb_others(), i=
s
there any use for tlb_uv.c?

