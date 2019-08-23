Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714ACC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475822166E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="JBSSsVDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391583AbfHWKeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:34:03 -0400
Received: from mail-eopbgr760040.outbound.protection.outlook.com ([40.107.76.40]:43844
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730818AbfHWKeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:34:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0V/MzHUSWjalarG1kXXr2foqK7VzN/IcctQTCoMnV30dkC2LIXeZ6PLpCDGcsM//JN0sta/U6oHSzq1BPeQsFW7LRmb3HBCG7Va1fxKFk9LbLmSftCba0gnI5bPAQxZwpxXVFzJnCebpkVzaNi/Py+J99juJ4aYcv1+eibC52C//fmIogYTenoGlsDVA6/zitIGsyx+7rbO3anXc8f+LOP/7f1QCz0HSkgRUnv1ns+TQaxkaJrDTlrH+CCD/zy6ja47WBFWwR2Vurpfw8MfHOXvfMTemCSGbCrYDV3YznrbDk4dNKwtqolSFbrowRW7aZREsNdhZcDmaxhqz5uDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8Ts2d8pHRDLT0IACX/DY/FykRL/kw6c8+nK82VL1xo=;
 b=nxuMw4melQuazbF276EHNAwM9LT5mKq7VGbhphpbtbcXbYBRVfNsUOavEvqyzTsVAULFAfxsxY8TjOJCRgHq2zpzM9wK0T7KVmrLEgVEAp4XOKbWWbJDy6U56/EwxJ21gPjZrEm+8w3dphidIpkvNzbuR2m8EJzPodSa+rxcX0LR6lUmUDsLlEzI9oZkOyVPGdXnkbzHdWo7Su/Au9JsfLm15SxsvNOCieF+jW4Z8tV90V96zSFaS8Qq4Bmm7TF+ghVy/rhqUof+xKtepcZn4sXPhpZvmXoNZGzRPj0x8CNLQLkOez1kD72WWuhSCGlxpm8fcneASVE5msn219ibLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8Ts2d8pHRDLT0IACX/DY/FykRL/kw6c8+nK82VL1xo=;
 b=JBSSsVDMASUFpKUvJVe3yjOwkFGo3fR5gSmkpVNb3jjjt8och2GRiXj5qnrtf8001wlBq2JGmF93nkYA8VZTeq78zFy+0sPcZ9ZnuPvawl1XrTx12TIEb/TTStbGYP3RJECF1NJB4VVQt/IGtmrzH30so3tGUyyolYb5Dx/TtdA=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3640.namprd03.prod.outlook.com (52.135.213.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 10:33:58 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 10:33:58 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] ARM: ftrace: remove mcount(),ftrace_caller_old() and
 ftrace_call_old()
Thread-Topic: [PATCH v3] ARM: ftrace: remove mcount(),ftrace_caller_old() and
 ftrace_call_old()
Thread-Index: AQHVWZ5Fj072LJHyfUy3f20zWMoBCQ==
Date:   Fri, 23 Aug 2019 10:33:58 +0000
Message-ID: <20190823182239.20f9a656@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR06CA0038.apcprd06.prod.outlook.com
 (2603:1096:404:2e::26) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10047bab-65d4-49ce-83db-08d727b567b5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB3640;
x-ms-traffictypediagnostic: BYAPR03MB3640:
x-microsoft-antispam-prvs: <BYAPR03MB364033969C5790D4A6033FB1EDA40@BYAPR03MB3640.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39850400004)(346002)(366004)(199004)(189003)(102836004)(8676002)(305945005)(81156014)(81166006)(7736002)(478600001)(86362001)(53936002)(8936002)(14454004)(256004)(486006)(9686003)(6512007)(6116002)(25786009)(6436002)(71200400001)(71190400001)(3846002)(6486002)(2906002)(50226002)(4326008)(66946007)(66476007)(66556008)(64756008)(66446008)(26005)(476003)(186003)(54906003)(110136005)(5660300002)(1076003)(316002)(66066001)(99286004)(6506007)(386003)(52116002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3640;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Sgkul4uLL5yZq8qBDzliD8yPFGW6UHlY/h71TJ9/sYcX15CIDfBrIwde8rgKhKZq6vysZ7/gpInYKKCy/KRP4sMUgRgMtEtCzXIri7TBzkkMh5aJNSj+VObtGBkh/vEYDITBClCk0vn/q9zccMu2rG0FQZLjNNSoeAURIlf4GaCBYeit0svklyrkthJXrie6rBl1nfxQVOEAvFr4x7eze7v1+SVI/iUtvKwQJHhCRlkEmVCqNvbiUG4vl4LPqWj0pYi/HRF78NwZI9XMPV8ePEAdKeQc7iFomTitIXwk0vryzlop+DuQ8CwgyoVqGAFg+Q6L8I4K38uNd8KzRcnjBol1UNwu2QvheF1gh9mXNGKWCus+x+a2rAEAamooesCnBRuL8hv9fJMPBoaHd4ds5rwloKgHxxEkp2B1fxgC1PI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8999C4D5AEF51046A238F6BC3FC3D51A@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10047bab-65d4-49ce-83db-08d727b567b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 10:33:58.1335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MxEbxJw9uPY0RdAaAfba/rHOllKTCxS6LCp9uPwW1XSaduhvM4k2PuGbEoyBaD1wOHL6gM4MVs4tV+c1LxL2Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3640
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d3c61619568c ("ARM: 8788/1: ftrace: remove old mcount support")
removed the old mcount support, but forget to remove these three
declarations. This patch removes them.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---

Changes since v2:
  - really remove mcount() declaration too. I made a mistake when sending o=
ut v2

Changes since v1:
  - remove mcount() declaration too

 arch/arm/include/asm/ftrace.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
index 18b0197f2384..48ec1d0337da 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -11,7 +11,6 @@
 #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
=20
 #ifndef __ASSEMBLY__
-extern void mcount(void);
 extern void __gnu_mcount_nc(void);
=20
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -23,9 +22,6 @@ static inline unsigned long ftrace_call_adjust(unsigned l=
ong addr)
 	/* With Thumb-2, the recorded addresses have the lsb set */
 	return addr & ~1;
 }
-
-extern void ftrace_caller_old(void);
-extern void ftrace_call_old(void);
 #endif
=20
 #endif
--=20
2.23.0.rc1

