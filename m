Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637ACC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4F522CED
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Uz94Aex/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbfHZJNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 05:13:16 -0400
Received: from mail-eopbgr750047.outbound.protection.outlook.com ([40.107.75.47]:52896
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730528AbfHZJNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:13:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1oRWdJjntBHCx71oa9bIAS4W5TgzXGGJgovQEMR/kR+5F1SNBH0FMPBh0tscUaEXTrjLtIP3Jby5mjdEwHALG0BPtwfPLxI5KKW2jCT5O8pTVUHTOD74TH5907vGPVutRpSzrUT8GaONXpeE2OKHmVwnXqEc+jmWrUlbKwLFYlm30zReMgi2hZojgGU5sl9gDxeHFtMPzstgckQfZo3PFgKZPEIcj5nVhAkRNuJ5lcZpc2WhtLNZEQHIxwq4XSgXVGySdtV2bzS+BK4pasgZmmxn+jN0jmG/su9Pp1HQzyk5yh3i/LeDSID5mdhQfihC2FQl6PNZLemfr0PDLMktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhJ95noRI3yL5YhdLLcTo4P0lu9h9B/7TIJL0a0u5PE=;
 b=AWjc/NLll6JeNsVgXa/9n+uEwq9KC7nYDy49I68o8ebpDTCnvyh0A5dd0Eqmwoc7UdPgRW4vG33Lp+X4WLNdiJxaxNu9KNQ5dwOGpEDMlwoOkLnVHA+DtUQ7tribjeNt3YBlEZFEIEYWKw2ndpFMqbKfAqCYo2PIlYI7PKocUhtqN7X+ymLmUMsnMgYyOfEYDGnA7QTROGBIiX8Fgoq3lo4eRgk+3gPn9ZsamiZmeu4BY3SoKQJtIon8vUQ3XNBNc3LeSjRviqKv0vDnro0d6xMhNq8T/fO0Lcegij8sMO6RO89XmlNLvON+ts8gL8aBQnIL1Doj3H/w+mL7TUtIlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhJ95noRI3yL5YhdLLcTo4P0lu9h9B/7TIJL0a0u5PE=;
 b=Uz94Aex/9HE93zLx7DOLFKXvQzyi3kilyTwdmBs7zcqnI1RYa20eI7zRPt6KYbIqxGdA3dlhjnHfXvrCngtMTsUo/0ncJlSxBnZBsnLP/cH3rKVCjPEYIemaDr63SCE7o3snivOqvYw27ZyL6Fblu0OJ2G/p18zmNLLs09gDZ8U=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3767.namprd03.prod.outlook.com (20.176.254.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Mon, 26 Aug 2019 09:13:13 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 09:13:13 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ftrace/x86: Remove mcount() declaration
Thread-Topic: [PATCH] ftrace/x86: Remove mcount() declaration
Thread-Index: AQHVW+58+SbOUj5nAUyBN5jCZRXaDg==
Date:   Mon, 26 Aug 2019 09:13:12 +0000
Message-ID: <20190826170150.10f101ba@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR0101CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::14) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9926310f-8e91-491c-7772-08d72a059eec
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB3767;
x-ms-traffictypediagnostic: BYAPR03MB3767:
x-microsoft-antispam-prvs: <BYAPR03MB3767ACA6F86E3EAF653CC70EEDA10@BYAPR03MB3767.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(39850400004)(346002)(366004)(199004)(189003)(7736002)(25786009)(66946007)(99286004)(66556008)(66446008)(64756008)(486006)(476003)(110136005)(3846002)(71200400001)(305945005)(2906002)(66066001)(4326008)(4744005)(6116002)(256004)(66476007)(14444005)(1076003)(52116002)(8676002)(50226002)(478600001)(71190400001)(81156014)(81166006)(8936002)(6506007)(6486002)(6436002)(386003)(102836004)(26005)(186003)(9686003)(14454004)(86362001)(53936002)(5660300002)(6512007)(2501003)(316002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3767;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ElLhQ2qpA2xvvdvoH5RczeGFK0rQteb1r+PLjGtPiZvffumjtSByzjDj89XR5bxU4gNE1dAvc6jpu6izJuWSD13ujwLt7rMHuZvrDgcJ2v4ZsD7iwsQfdgUafcuO9wzw5vuDN7YhdnsLCHRnfOUzMlu8bOXk5eXRCITywqDwW1UFuklwe1l2AED69fzRkj8VIOM7X87rlkTQhc1l3I9RWpIbUr+7ZtxVadVbXUQXibzb6H5BYtTAAsL95oecYumaQ7iRmfOh97CBNhZK9FceWWp9+ecO5KfFwvkwMyqc35aMV6tIVbCZ9DUVNMEpEiFsE4RDVWAtzNq3w0NrTbTOgvR1yddFTvJHEQpIBz/3XtLWeevcpMmEbzVSZfEqkjD35gFefjyJy+2S2Z+NuJV3Hqa4nve3Eem8rdfL5swcwy0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <737A4A171D9DF448BCD50E9C33E9A44E@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9926310f-8e91-491c-7772-08d72a059eec
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 09:13:12.9562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sEiL1ez2G8/AmUsdsEOxlEuxgGpfFlx0vxIh9ZmgR1/q7jD0NID4+OTcz3xJQlxGoemN/OmjSVY79MtjDTNm/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3767
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 562e14f72292 ("ftrace/x86: Remove mcount support") removed the
support for using mcount, so we could remove the mcount() declaration
to clean up.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/x86/include/asm/ftrace.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 287f1f7b2e52..c38a66661576 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -16,7 +16,6 @@
 #define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
=20
 #ifndef __ASSEMBLY__
-extern void mcount(void);
 extern atomic_t modifying_ftrace_code;
 extern void __fentry__(void);
=20
--=20
2.23.0.rc1

