Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0FFC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 09:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC672073B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 09:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="kINL7k5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfLYJm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 04:42:57 -0500
Received: from mail-co1nam11on2068.outbound.protection.outlook.com ([40.107.220.68]:30265
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbfLYJm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 04:42:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+qbiN+U6x2ytoBoM74oVZn7czVVgVbJncBfXa0oHpWOZP2gxc4Nn/NYH35BaEyqhmDgx4yK7yYKLOaIbMtTskKFfgC5F+4aLje8t74nHAXdzHrgTXSJoupbB/KQz+Dht8bIw42n45QHUVYQzeqbG6GCoX2dP0QktHF9qc3Mkb5QtVSNRXuxzqY/qUJ94gTVm/DWeQnoYy7PodPASChODX27bI3yS2lWs4+cMBzlwafoSSt9VJapZMt0g9RK7BIeOQcLOzU3H7eJAu15coZOr67BLscDMRqytL1p7pwZ9KJjMxPC77r3e/1cesh7YdVC02W0igtJbwHtL/EwovwgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICoQ2OQzX55MiUgYN1zoHHYBWdV5Zm3IcBDHqsGI63o=;
 b=FIDy7ENF/EVFeab3xWPFWjxN/Mos86MEnezHAN7KExSG2O7gsAjUxADKiqUx0yzC5eG0Qa1kqvQnBPoPB3m3E/GHua7BLJOiCe/4tWmPPLc/xVwe44m6ji5RDVRnTy4nh+ddrdGAwRigI5T1kvXbNVaiS2JuzwfiRgH5rDCI4ZcRwTsVIoaG63JJvOYUNrUtFIw9K8N0yohQ2ChyL3HtwfUxsRqn6RA5BTyH3Gijcul2SnGP1zT7J61PA5Ut1kRIAtH475TIQOHsEg4HszvE5S8u5IarRTqOBtQ2Yx/eH1QP26XW800RfSQY+NA2322aI+7eSfL4483b/krbD3S23g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICoQ2OQzX55MiUgYN1zoHHYBWdV5Zm3IcBDHqsGI63o=;
 b=kINL7k5BQWvh8Owf6Hj+e4qLgij9GXjbKD5IV96jL9pQCPaX0VSWu9BLMJa1D+5+EsVlWSYpyRswWfmpa4CEj3uEO2tCLTB5FGIs7ZQYzrNePl2QU1SfBruMduOQVIGKhdHhyBQ1XBwS+Ock08WkxFE+UpzZDOxOzd0GFzBymqA=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.93.213) by
 BYAPR03MB4213.namprd03.prod.outlook.com (20.177.185.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Wed, 25 Dec 2019 09:42:52 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a%6]) with mapi id 15.20.2559.017; Wed, 25 Dec 2019
 09:42:52 +0000
Received: from xhacker.debian (124.74.246.114) by TY2PR02CA0041.apcprd02.prod.outlook.com (2603:1096:404:a6::29) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 25 Dec 2019 09:42:49 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: [PATCH v7 2/3] ftrace: introduce FTRACE_IP_EXTENSION
Thread-Topic: [PATCH v7 2/3] ftrace: introduce FTRACE_IP_EXTENSION
Thread-Index: AQHVuwet+NDQHpTM7km5hPNb6KsFRg==
Date:   Wed, 25 Dec 2019 09:42:52 +0000
Message-ID: <20191225172836.7f381759@xhacker.debian>
References: <20191225172625.69811b3e@xhacker.debian>
In-Reply-To: <20191225172625.69811b3e@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:404:a6::29) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:139::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52e3ef56-3cf4-4e14-aca6-08d7891ecf9d
x-ms-traffictypediagnostic: BYAPR03MB4213:
x-microsoft-antispam-prvs: <BYAPR03MB421349DEEFF9F910F9801E95ED280@BYAPR03MB4213.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02622CEF0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(366004)(346002)(136003)(396003)(376002)(189003)(199004)(9686003)(1076003)(5660300002)(86362001)(55016002)(6666004)(66476007)(956004)(66946007)(66556008)(64756008)(81156014)(8936002)(81166006)(8676002)(66446008)(16526019)(71200400001)(2906002)(26005)(186003)(52116002)(7696005)(7416002)(6506007)(4326008)(316002)(54906003)(110136005)(478600001)(921003)(1121003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4213;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pHCMS+N4PedcKcydfeW5MFMk1UmdhAJjCx/K23t2O4aU16724KD2DebaOiFaSmjEyHA+jlia9kIw3xXnM2dbMM4ZFIp+PTskcqPs79B3i6lwJUyiQqW4C0CtekcU49RaElJ9IOWy4vuOfeJX3WMHm7HvnG4PiNxsy01cccJKc4ezorhsH+JzbTm1znX40jUWBFMZ4SCZ61vgpmV0OK4zeVf88o8QST+lXPh2SEAq1fAYawHUclGbVOv/oFChv1Le/5KfsvlxhqEMHtiyLzOktyy7HO/dcAi1ZSfCIU300ZJTsBCO3emmfbjuDv6EMvi2wqS+rOhzXTsreR2H4pDBz0rq1b4AzjhNEfwb+asUb12ei+c+F6/RO4ASswuEJuVBUo9+16Yirh5DecvxUudU6iFpbuwXPChO+GZDPHDFAUGQX36hgZmkSxr3X4nGI4sMm1IhneXSiG4OlWYvn5RcPBPXAAWpsiCyb5TaLMmozP4kOL//pRz16wU8AkDCkWnVB7Bzsv2yqepvBKMVph7QNsH71Q629dWsbZvQFarwb2E=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E24EC6778D25A341AA2105525F1DAF73@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e3ef56-3cf4-4e14-aca6-08d7891ecf9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2019 09:42:52.4104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b9rqria0Z1RJA/m9TirY3m17kvTfqUv/AqWB4gCaw5Z2h03CtmGW7OcG9wmOtj3+8AnYfLfCBoSRc3Axr6A5uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some architectures, the DYNAMIC_FTRACE_WITH_REGS is implemented by
gcc's -fpatchable-function-entry option. Take arm64 for example, arm64
makes use of GCC -fpatchable-function-entry=3D2 option to insert two
nops. When the function is traced, the first nop will be modified to
the LR saver, then the second nop to "bl <ftrace-entry>". we need to
update ftrace_location() to recognise these two instructions  as being
part of ftrace. To do this, we introduce FTRACE_IP_EXTENSION to let
ftrace_location search IP, IP + FTRACE_IP_EXTENSION range.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h | 4 ++++
 kernel/trace/ftrace.c  | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 7247d35c3d16..05a03b2a2f39 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -20,6 +20,10 @@
=20
 #include <asm/ftrace.h>
=20
+#ifndef FTRACE_IP_EXTENSION
+#define  FTRACE_IP_EXTENSION 0
+#endif
+
 /*
  * If the arch supports passing the variable contents of
  * function_trace_op as the third parameter back from the
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 74439ab5c2b6..a8cfea502369 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1590,7 +1590,7 @@ unsigned long ftrace_location_range(unsigned long sta=
rt, unsigned long end)
  */
 unsigned long ftrace_location(unsigned long ip)
 {
-	return ftrace_location_range(ip, ip);
+	return ftrace_location_range(ip, ip + FTRACE_IP_EXTENSION);
 }
=20
 /**
--=20
2.24.1

