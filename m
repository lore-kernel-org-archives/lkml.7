Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF2FECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDDA2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fethwRHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfJGTAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:00:25 -0400
Received: from mail-eopbgr690067.outbound.protection.outlook.com ([40.107.69.67]:51427
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728465AbfJGTAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:00:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wc/PlKvKNzAP53aE8r+Z9pDCsDQSJamR+lv9/CCATwkNc6pOn19qmcb7cGaHXrOYJbc2LrGUzeW/Darc9frPtT/r4gz6M4tsJiS+PV+wMO7CfMYQITUJ8TBo+In5aUg9vAhbHDhBCPZzpjzHgXtGKjzrIt95FtutBXWVsqvhbUKH+xhSokEjmgAJ+I1OOh+CrmlGUsUzVpu0+BeJqCw5RltamIFfbkQjAQentL2aoOsVqSAHbmtbym1ANlULTE+Zshr7d1yZEr5my6CSuzW5YBFx8wlHcjrcsvGMwKkwe96vBOXlDRt7U+xMopdb3G8h7d0nScduE/ios/Y95vkQbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm9qQMcLOLu0uyHSoAEZQEYzeYl5apmqXMzt47jXO1g=;
 b=N1Ln6i5KVJ2qxMeUQDYhs8lSb1xasnrxZMkaXkumZrCswboxA6vtgsnPw/IjLhGIGKwpLaTheXFoLEbheqJc+Whbc73cj7q5Kn0axfUb54oh4uPQLrTGk9ZiGsKtkx9JqNph2yPsu39+wXamBCYDaE41Iqu7LmoHGrY3BrmA87PLxF/UEeEX8OiCmjh6qkutJI1wBj8AsLYRjoxq53gZXDoCXaoveecGZQIt8Lg3WLDxFjjfEi/0QW+Fsl7nE4dv/B93VL0y/dPitr+h/EnIy5911BxNx2IzknKEHNFwVf/73BWHvYtpXOImDNWT3RSsHUujv78TAkOaz+tnYZilfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm9qQMcLOLu0uyHSoAEZQEYzeYl5apmqXMzt47jXO1g=;
 b=fethwRHHzivN4AyvK+RwPV61D9Ferd26xo1RjtpFtlOKMmjYiEWcptttI6i5szxcp/J4r7BmddexUop/jDWBrGIe93Eje0xQ4wlrugowTv1v2iIF5dLHXlIta4YEPyHddk+mDmeyNBbaSe6TOJXNaAjBIreqCWRnb5V3+ty6E0o=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 19:00:22 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c%6]) with mapi id 15.20.2327.023; Mon, 7 Oct 2019
 19:00:22 +0000
From:   "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
To:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Jon Masters <jcm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Subject: [PATCH] x86/asm: Fix MWAITX C-state hint value
Thread-Topic: [PATCH] x86/asm: Fix MWAITX C-state hint value
Thread-Index: AQHVfUF4wAEM81IrLUWesxXs7fzPCw==
Date:   Mon, 7 Oct 2019 19:00:22 +0000
Message-ID: <20191007190011.4859-1-Janakarajan.Natarajan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:805:a2::21) To SN6PR12MB2736.namprd12.prod.outlook.com
 (2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c90bb332-ccc1-42de-9015-08d74b589ac8
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR12MB2736:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB27363E0C01C45962BF3090A3E79B0@SN6PR12MB2736.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(189003)(199004)(86362001)(6116002)(478600001)(5660300002)(14444005)(256004)(3846002)(64756008)(66556008)(66476007)(71200400001)(66446008)(66946007)(1076003)(2906002)(71190400001)(4744005)(36756003)(8676002)(54906003)(81156014)(81166006)(66066001)(316002)(7736002)(305945005)(110136005)(99286004)(2616005)(6486002)(52116002)(6512007)(186003)(14454004)(26005)(102836004)(25786009)(8936002)(386003)(6506007)(4326008)(6436002)(486006)(2501003)(476003)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2736;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oO8TMC4dwJLIFE2LpNQBwEiXUWFsN8a7FLhOW3DJ7dEycUbLr9prJs+IEFLCkTlAQxGvNJwizHR+q55IzzlMLM+lKxs9HL7ftB1mzaEfk84erbto/PK8PIKRDTJK8/0kIm84wpQcD5e+1wZUcg19pmIcxsqZtU3iZ4xvKmli7SJ2Gl8CS0zLgiAhn/+tdb1UrrqR+76uk1oG5IUSpNxje2PiH4OcPfWOG3RE//F7px014lFVgsBk1e2Vet8dILGte88aRav1KmnpWrhcNnesfKUFk7cwwxPDNoZZkj1fddVCCWKp25ZKXeloHej7qYn77qUepY1uuAiuDSOVXYez7BpSD1cxvw3VFpwtOTtXEZO/uMiHKowMlmJ44Yv1H0XQcUjRcXiYTD9gOvknrR2Qe4wOTLmL6ImoYs4WdFHpoog=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90bb332-ccc1-42de-9015-08d74b589ac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 19:00:22.4024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UAhAxZg5vzTfxPyYQR55FwW8jJGL4WSZomqUBbcOZ+RuFL5WzlIcv8NNX2lEpYKHowRG5HrttKc/PQp5mRxd4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2736
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per "AMD64 Architecture Programmer's Manual Volume 3: General-Purpose
and System Instructions", MWAITX EAX[7:4]+1 specifies the optional hint
of the optimized C-state. For C0 state, EAX[7:4] should be set to 0xf.

Currently, a value of 0xf is set for EAX[3:0] instead of EAX[7:4]. Fix
this by changing MWAITX_DISABLE_CSTATES from 0xf to 0xf0.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 arch/x86/include/asm/mwait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index e28f8b723b5c..9d5252c9685c 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -21,7 +21,7 @@
 #define MWAIT_ECX_INTERRUPT_BREAK	0x1
 #define MWAITX_ECX_TIMER_ENABLE		BIT(1)
 #define MWAITX_MAX_LOOPS		((u32)-1)
-#define MWAITX_DISABLE_CSTATES		0xf
+#define MWAITX_DISABLE_CSTATES		0xf0
=20
 static inline void __monitor(const void *eax, unsigned long ecx,
 			     unsigned long edx)
--=20
2.17.1

