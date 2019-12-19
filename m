Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ADAC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 08:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4507824672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 08:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="RcJupqvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfLSIPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 03:15:46 -0500
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212]:61319 "EHLO
        esa3.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726439AbfLSIPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 03:15:45 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Dec 2019 03:15:44 EST
IronPort-SDR: fOHYE+nkkP2aQIKySW1sNeskNgcV80UVnY+txGM529WMW8Wa1agSaTvDpOKQFZDjU9/YtREpq7
 AJ6bYMz7oUP8rwEBKm7PGTGojQEdKQtvZqsfTLKdAFnHqLTxmhsui5mxmW3TLOR+G1mB62yUyD
 1jmcfSm+OaUiob6qq9MXP4RzVr6Ywa0nYRrJhFlBg9zfKxBekHt5qNHXME7ECL+5lyznSaSpma
 4WlwK5CVZ0A3tTSgWb3IFWp16fwQwR4ip5D2XE6HzCD2uRYk85d9N91EaEmgmETTZFl6Parpx8
 vl0=
X-IronPort-AV: E=McAfee;i="6000,8403,9475"; a="16853559"
X-IronPort-AV: E=Sophos;i="5.69,330,1571670000"; 
   d="scan'208";a="16853559"
Received: from mail-os2jpn01lp2056.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.56])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 17:08:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEQ2Ygnbg/mRfxLG5lll36pHI60XGFcChFttQAlHJBT2ngOZR4Bbd4HonEEoSJ2ulmRdM+A4gAzBx5MutJke70CRQHP8Afpps5PYdMbWCuLNH1pUzlICfYtkvoq9GXAVqge5cOCDpBxu4bBVqWcpj1JHxBPaPcQBgZR1FylNNbNnaSyJnN9T4vDy30U8mlOuK/QK19JZNTQNyOlyhmmrU539MAbevFnip4Q+UjK4Muzc8Sbc98SyWAatZcpj4xv/y4UpHWFdvTlwlxi1LQn1mr0wZYTfbWui8eTYaVNW3wpLTAP6Def2uKt1CP9r3EkVYDbU3ruu5dQY680jmKSkSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSHJ5trFHjaMPU9QgjaR3XV2KWTJltrSuGZlkmWE/TU=;
 b=FCC70m1PO8lhiavFyINk4agCoOJvS1EG2lXDE4+zGj8EfQREFUmgf5YVia+xbmxm5qVFzku4X1ePknMvAiObjiuV16gcVDWxE1XRm/8ozNEE2nu8L3yrB/CwqgyZsFtDlmE4b6Hm+fNoocsRmxNE4LJRBmVAEpb8CCnxPOKpBmve9QfRT1C5Nptu6jTzjkTr3wOEWmYvCaqi6WxqG+cohRPQ+ymjSws26zVppAOCaSR4G3k+JFiWCIzo+/M4akqj3oEtwy8fGtZTXoZ3Apo1SX+ScJone5cUYfROoSGop3NsihgVp6MGcp2pZSXmjyRCxDjigctCTm7cRKgaHwVd7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSHJ5trFHjaMPU9QgjaR3XV2KWTJltrSuGZlkmWE/TU=;
 b=RcJupqvtCuLW+84K+ydVBZ/nmfL2M1Z3j/9olk++v75LMoVDFKzxRyNwKHPWkghdlng01rw52pH+wqOmFmoqrD6yYXivAaBLLgHbMLwgQib+QkaHjevyaWyCA1nMYXDHYvQgH10WqMGc0SRlhggWYE6S7gPtEtQUfkNB661avtA=
Received: from OSAPR01MB1588.jpnprd01.prod.outlook.com (52.134.230.145) by
 OSAPR01MB3604.jpnprd01.prod.outlook.com (20.178.101.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Thu, 19 Dec 2019 08:08:33 +0000
Received: from OSAPR01MB1588.jpnprd01.prod.outlook.com
 ([fe80::ed23:d4ce:558e:fab0]) by OSAPR01MB1588.jpnprd01.prod.outlook.com
 ([fe80::ed23:d4ce:558e:fab0%6]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 08:08:33 +0000
From:   "fujita.yuya@fujitsu.com" <fujita.yuya@fujitsu.com>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        'Ingo Molnar' <mingo@redhat.com>,
        'Arnaldo Carvalho de Melo' <acme@kernel.org>,
        'Jiri Olsa' <jolsa@kernel.org>
CC:     "fujita.yuya@fujitsu.com" <fujita.yuya@fujitsu.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf tools: Fix variable name's inconsistency in
 hists__for_each macro
Thread-Topic: [PATCH] perf tools: Fix variable name's inconsistency in
 hists__for_each macro
Thread-Index: AdW2QzdRSj0h+PCsTGKjyjyItPyt0Q==
Date:   Thu, 19 Dec 2019 08:08:32 +0000
Message-ID: <OSAPR01MB1588E1C47AC22043175DE1B2E8520@OSAPR01MB1588.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
x-shieldmailcheckermailid: 44d9c91dbaca4bfbb8be409b17047868
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fujita.yuya@fujitsu.com; 
x-originating-ip: [210.162.184.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 719688fb-eaae-4e2e-0147-08d7845aa40e
x-ms-traffictypediagnostic: OSAPR01MB3604:|OSAPR01MB3604:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB3604482BB774EFCEA2CA3DBEE8520@OSAPR01MB3604.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(66446008)(6506007)(55016002)(33656002)(26005)(85182001)(54906003)(2906002)(316002)(9686003)(110136005)(8676002)(81156014)(8936002)(81166006)(478600001)(86362001)(64756008)(76116006)(52536014)(5660300002)(4326008)(71200400001)(7696005)(66476007)(186003)(66946007)(66556008)(777600001)(101420200001);DIR:OUT;SFP:1101;SCL:1;SRVR:OSAPR01MB3604;H:OSAPR01MB1588.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uozTE0mkf+g5HOxWiU2rHF9qysbTk0roRthTzxN1C6RHg3QsQvJtdO25tzfcHQzFvfJE87xsY9eCPkdzjNzCnbDTdwbNL24+Vh+yEuZecQaclZGtObKzIp3SkkUWCew6EKNJtUxovwoqLCt9CZvTz4MF0obFZocjdA6MUARYjZoKG+nn9wkRf9C5UtF2niDl8fTMMmIMJmBkvk4wPvvA97ZAtFjL6AwPTET09JNwhxITPXJxAnRrYbc0XEX5CKwuLwAoPnflfwjd2g4/rGmTNxtJBXJhkLPpj/+SVUaArVNiwzypqja4gblFEGWLuUak5e5wtcj/SSe/v0r7nkfp5u53udxgehKUT7IDe/ThGohy+q2UXLTL0kioFAQAhyOKjFOVv6pBFELUB1t26+WHh3XUH2RwVAf0LJo9RufllpHVHT5is0ox8cuXwAuhJYFDSmWmlBfJg+OOVE4H09r22saBbEpmxD3bi3+P5RhQc38iZ55zzEMV8kgEyeoU9loXbFnCE7x84C6+ZEopdrTiDQ==
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719688fb-eaae-4e2e-0147-08d7845aa40e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 08:08:32.9879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LQ80Jr5bfSIpddP4Xgjne8OY7UfZD+FDuaJ/7ciOAMPG6jMtamas+IAICJaTX59r2ixjZ+vx++fsMP8AbvcAXWfN9+MlUBxUWVPCY4nwroo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3604
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuya Fujita <fujita.yuya@fujitsu.com>

Variable names are inconsistent in hists__for_each macro.
Due to this inconsistency, the macro replaces its second argument with "fmt=
"=20
regardless of its original name.
So far it works because only "fmt" is passed to the second argument.
However, this behavior is not expected and should be fixed.

Fixes: f0786af536bb ("perf hists: Introduce hists__for_each_format macro")
Fixes: aa6f50af822a ("perf hists: Introduce hists__for_each_sort_list macro=
")
Signed-off-by: Yuya Fujita <fujita.yuya@fujitsu.com>
---
 tools/perf/util/hist.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 4528690..0aa63ae 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -339,10 +339,10 @@ static inline void perf_hpp__prepend_sort_field(struc=
t perf_hpp_fmt *format)
 	list_for_each_entry_safe(format, tmp, &(_list)->sorts, sort_list)
=20
 #define hists__for_each_format(hists, format) \
-	perf_hpp_list__for_each_format((hists)->hpp_list, fmt)
+	perf_hpp_list__for_each_format((hists)->hpp_list, format)
=20
 #define hists__for_each_sort_list(hists, format) \
-	perf_hpp_list__for_each_sort_list((hists)->hpp_list, fmt)
+	perf_hpp_list__for_each_sort_list((hists)->hpp_list, format)
=20
 extern struct perf_hpp_fmt perf_hpp__format[];
=20
--=20
1.7.1
