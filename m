Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84141C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 01:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0E320869
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 01:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="E8TUMiEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfI1BmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 21:42:01 -0400
Received: from mail-eopbgr770134.outbound.protection.outlook.com ([40.107.77.134]:32997
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727046AbfI1BmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 21:42:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuNoJCiOQyA7aXuiUlrrXE0xSkJGxzfcj9VCS8inVBjEJzToGP0sQ/9Qw9xXS1naDpBiOWkkjVGx+fw+rCJQvEYFa5MGgma2PVNzEWADwwS+8pKf4E7HDGGv/QdwKxsPQItsIpAY4i1e3I6uUwSaEUOeL3rFiUV3dLRo/rL0lEEtKMMd6DyhACu/EQOLaE6hbtbLGw3JMQMJD4TU9oUq0CxAaiLxFAn1NIEwAHpcbLLOxz0MJuch5fX7PrqWcsz5PII0SveVJFyQGZIRH+SLnG+cbu2QeFw1MfC9VxUpEcetXgZimWTcapr4NlW/UmCcJlKxWthgfaImglFhp50nbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HphtrLz3Bt9lrXcye2R+Vru1/ogD9A4WaHhxQ1lpVdY=;
 b=GfA7JH/qrKWGG3PHgmKW6F9yW5bnK0MNGRrtqYdPsDwjEiKiiIplPtWnr3m44CQAyVIkZwtfvfIbveT0ZeOZ8FKp7pwhvTBslZibdiTIrgTZ9TYRSJp1tDeQuuEPVmyX1LhICqjEYbRhYV6WGb78/QYN48S1JgKKqmT/r/ItIRN0rEVX9EsnzGEnAxqDQT0Y107voZabisaYF3plgOLEvl2zHnOsSCepBA3JPTYMfNGB0VKL/7BGDaQUw2kY0rW3FXsdIZUkWYCgPnGKdp940vYiBgScMPuk49AhD+bzmW/9quEBgjS08z1ZUM5gl6SVO369OkfKokjohni+wNIrPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HphtrLz3Bt9lrXcye2R+Vru1/ogD9A4WaHhxQ1lpVdY=;
 b=E8TUMiEwbp6Vr15QoSCfQSHu6UYPNYUZ17urLf6aXb56NHOuoNMMjlqz6SpW97uiKVmkH2Ktr7X7RQBcRZvY0qkLPUbwqhgOWsZssqcgN+KRsm9ohZlXT65P2ISAiW8NGO/trr5Z+JAD5L8fcLhZQbnephT3A9qt3UZa7cfvAUM=
Received: from BN8PR21MB1362.namprd21.prod.outlook.com (20.179.76.155) by
 BN8PR21MB1137.namprd21.prod.outlook.com (20.179.72.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.7; Sat, 28 Sep 2019 01:41:18 +0000
Received: from BN8PR21MB1362.namprd21.prod.outlook.com
 ([fe80::6cea:8074:a394:f20d]) by BN8PR21MB1362.namprd21.prod.outlook.com
 ([fe80::6cea:8074:a394:f20d%9]) with mapi id 15.20.2327.004; Sat, 28 Sep 2019
 01:41:18 +0000
From:   Steve MacLean <Steve.MacLean@microsoft.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
CC:     Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        John Keeping <john@metanate.com>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Leo Yan <leo.yan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Robbins <brianrob@microsoft.com>,
        Tom McDonald <Thomas.McDonald@microsoft.com>,
        John Salem <josalem@microsoft.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 2/4] perf inject jit: Fix JIT_CODE_MOVE filename
Thread-Topic: [PATCH 2/4] perf inject jit: Fix JIT_CODE_MOVE filename
Thread-Index: AdV1nbvfS5Lt3OevRNeqHelCsrcC0A==
Date:   Sat, 28 Sep 2019 01:41:18 +0000
Message-ID: <BN8PR21MB1362FF8F127B31DBF4121528F7800@BN8PR21MB1362.namprd21.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=stmaclea@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-28T01:38:59.2288447Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ab65d156-f883-4db3-993c-08be3d8ea58e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.MacLean@microsoft.com; 
x-originating-ip: [24.163.126.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b266a41-2a1e-4e94-dfd9-08d743b4f541
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BN8PR21MB1137:|BN8PR21MB1137:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR21MB1137265ADDCE0A0BB80E0C28F7800@BN8PR21MB1137.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:126;
x-forefront-prvs: 0174BD4BDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(189003)(199004)(74316002)(8990500004)(66066001)(478600001)(8936002)(52536014)(2906002)(25786009)(8676002)(7736002)(99286004)(4326008)(81156014)(110136005)(7696005)(71190400001)(81166006)(71200400001)(10290500003)(5660300002)(102836004)(316002)(64756008)(7416002)(66446008)(256004)(76116006)(476003)(14454004)(305945005)(486006)(26005)(6506007)(55016002)(9686003)(66946007)(33656002)(66556008)(186003)(10090500001)(86362001)(6116002)(22452003)(3846002)(6436002)(66476007)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1137;H:BN8PR21MB1362.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k9g4KHrMHj+xQrcIykBVw2mGb7xqHoeikhniel1nPN6TNQuSN+sG1Qe4yJ2qP9Ax22wM0Ob30PYP4pbVAqZvqlOnlPqt6G7rk+4Gie/WMb05iFpexfsyfGrArq7OvbY0kHazFpTMFotnj4y+u6GBR6J1RFeGM+t7RgUuSMnnUO3tH3/6dYXs90wYec0yU+5SjT6DDXuR/LLa+LO0O03rYWEcmmop7DQhyzIgQXfWVvxCtI5WfUNGlmf1BQa/J+mP3wBBCwrWItHzaOjnvYxadGCpK54po2SDo/4dO5zbUqCwfVD7k+EkAHx0WTx1lLlOSu1yDxKbITWQAeVzdWb2Fx41vn9fQDULW6ovXn8YQFZuXaXfXUIok2LSLbZ+kmlHPmZ2GuJOOZLr4OeGqEXPkTb6xnoOb7b2FG4DJaZ67Hw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b266a41-2a1e-4e94-dfd9-08d743b4f541
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2019 01:41:18.1135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E+Tu9ptSTUynK3VcyDhaTYF7HVKX3Lbj1KmFPUj6G/VmG8MMyDWk8fviloe3EGHcMLlJDdJ/3lQQsP86K8sfoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During perf inject --jit, JIT_CODE_MOVE records were injecting MMAP records
with an incorrect filename. Specifically it was missing the ".so" suffix.

Further the JIT_CODE_LOAD record were silently truncating the
jr->load.code_index field to 32 bits before generating the filename.

Make both records emit the same filename based on the full 64 bit
code_index field.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Steve MacLean <Steve.MacLean@Microsoft.com>
---
 tools/perf/util/jitdump.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 1bdf4c6..e3ccb0c 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -395,7 +395,7 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd=
, union jr_entry *jr)
 	size_t size;
 	u16 idr_size;
 	const char *sym;
-	uint32_t count;
+	uint64_t count;
 	int ret, csize, usize;
 	pid_t pid, tid;
 	struct {
@@ -418,7 +418,7 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd=
, union jr_entry *jr)
 		return -1;
=20
 	filename =3D event->mmap2.filename;
-	size =3D snprintf(filename, PATH_MAX, "%s/jitted-%d-%u.so",
+	size =3D snprintf(filename, PATH_MAX, "%s/jitted-%d-%" PRIu64 ".so",
 			jd->dir,
 			pid,
 			count);
@@ -529,7 +529,7 @@ static int jit_repipe_code_move(struct jit_buf_desc *jd=
, union jr_entry *jr)
 		return -1;
=20
 	filename =3D event->mmap2.filename;
-	size =3D snprintf(filename, PATH_MAX, "%s/jitted-%d-%"PRIu64,
+	size =3D snprintf(filename, PATH_MAX, "%s/jitted-%d-%" PRIu64 ".so",
 	         jd->dir,
 	         pid,
 		 jr->move.code_index);
--=20
2.7.4
