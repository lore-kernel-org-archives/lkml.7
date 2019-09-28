Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB9CC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 01:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7972053B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 01:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eRgzdUcD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfI1Bpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 21:45:52 -0400
Received: from mail-eopbgr770109.outbound.protection.outlook.com ([40.107.77.109]:12805
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725990AbfI1Bpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 21:45:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTpw551d3SWfahguTruatoTqxw6Syz72+4YgUCMlnwCSZh4LoC1Yq64h1ScqN7QrZG1IuKE8KR0SnmCrNEJN+NQDtEkdiSfJ1KLZilReRWtFl9opARYLW5G03odOCvk3D4Ky5xA6cRvMKG16/ZQO/omCQCe6t1NFOLrOy9YQxv4kY8R60seqXlvge1PvLEfX8SwaUc3q+ROKHLfHq54qu/ameGKNVHF+c/3TdBFo1C4TF+ub1HfrHExZKedc62moEXW/NK51Nna599hqd3LHnVbx39DozvreV8aG9jkxj3xwi0vlzanehIirVexUnmG+WjTYFyd50fH7EXC/vHEXTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swmpkmETbczmgoj11j3DY5i+dylA487MeNmsybD6/G0=;
 b=jbe8itmhcrfzx2v7K8UhJ6tbgA5z43KfTFO0kvJdPcBh6PBJ3KOdbHuhvZrm10NLDKlYyTVe7O+4KQ7W63/XD388RK9qrIL1BvRzBY0XUfViH49po32vSNFSRRjGW73c244CxwwbEW7pqrRIzGYBYa64d0mKj7c1z1CWc0PlB1sFnJFieCAuQRGKJ0i7Uycy7yhCDOU46RVNYBhHNJm0EW/2OgXVbc2TeK1ANU+KdTPIJ2tadSePoQ3iM3Xil6FFiSzjISPm02uoRwhLJBz/Aywllkwe0QssAmyCw1BIyvDcESO4tU9PxZoMdtEUiA+BX29s5dD0rGTSnC7T3Rm+Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swmpkmETbczmgoj11j3DY5i+dylA487MeNmsybD6/G0=;
 b=eRgzdUcDmtF/a7X5qKuF5jWEZlMsfwTCDOGrDAQQOUUUyR9msQ0g6qFPRMPdzmDI1AUMzKHk8dlMSv/QyAvqKfsAlBdS7aim2lUq5MjDbu3P7QLRKOgElFXMFbG1Lp432Rf+wpQltgw9md3uvDQSUBPZyvhvMl2rp4UOxdQNcyw=
Received: from BN8PR21MB1362.namprd21.prod.outlook.com (20.179.76.155) by
 BN8PR21MB1137.namprd21.prod.outlook.com (20.179.72.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.7; Sat, 28 Sep 2019 01:45:36 +0000
Received: from BN8PR21MB1362.namprd21.prod.outlook.com
 ([fe80::6cea:8074:a394:f20d]) by BN8PR21MB1362.namprd21.prod.outlook.com
 ([fe80::6cea:8074:a394:f20d%9]) with mapi id 15.20.2327.004; Sat, 28 Sep 2019
 01:45:36 +0000
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
Subject: [PATCH 3/4] perf inject --jit: Remove //anon mmap events
Thread-Topic: [PATCH 3/4] perf inject --jit: Remove //anon mmap events
Thread-Index: AdV1ng9CnlECXJYCQw+p/SiDI/4npA==
Date:   Sat, 28 Sep 2019 01:45:36 +0000
Message-ID: <BN8PR21MB13625F8AD3E9C67C0918A750F7800@BN8PR21MB1362.namprd21.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: ca849b7c-5443-4061-0c32-08d743b58f59
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BN8PR21MB1137:|BN8PR21MB1137:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN8PR21MB1137225834E0B1BD690CEEC4F7800@BN8PR21MB1137.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0174BD4BDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(199004)(189003)(486006)(26005)(6506007)(476003)(305945005)(14454004)(9686003)(55016002)(14444005)(66446008)(7416002)(64756008)(316002)(256004)(76116006)(6116002)(86362001)(22452003)(966005)(10090500001)(66476007)(54906003)(3846002)(6436002)(66946007)(33656002)(186003)(66556008)(102836004)(52536014)(8936002)(2906002)(81156014)(4326008)(8676002)(25786009)(99286004)(7736002)(66066001)(478600001)(6306002)(74316002)(8990500004)(71200400001)(81166006)(71190400001)(10290500003)(5660300002)(110136005)(7696005)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1137;H:BN8PR21MB1362.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9LTqEdKr9lKYaLwzKbs6XD9s+HLFy0vDQyGv+gx5V4Bp+/Lq3v5iWh4oKHhy6kwWD4uiRBx22qnBlRBRh4aFPI6M6IUNoJFNdvz2d0lRTThnSQHR1kV/IeLFLlBNisIn1xfAo41YnmZL0Ak1gyoEdvdmOK7kLy64uNWAFCbazvhncK3qdHnUqp/K328p1M9mMYYfEpFm8hENkhnoUiomsqxZQaGWka4Rph02kdf9QFpKyG9ppgmoF3D8TfvSs4V98ZjhXTFPXXwHPH/M/1ijnxlR86+FDDcTRBb2TLHVn8BlEdyM4J5WjGVQgWJ1p0tIgU9bkMCJu7pf/7XuRPevYUm/uvNn/GgBhkQDRHmUL67unrCnj90XYdriCjJqyaKPb/szdFUkVqtkgeq2L9ojA5tqOYaVfJmklY9fHQIYqX6LbgzXghS5zNeN6OHSidkF/ZaXZ/YlLifVK7TQIc60Bg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca849b7c-5443-4061-0c32-08d743b58f59
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2019 01:45:36.7165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOIOmWDjZLSD1sQbMnDaIccmVsjdjash4ddsXFc3mdReL3FnVsPe1g2AQRZ35gvi339D5c+tKiBMGIk34AzOHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While a JIT is jitting code it will eventually need to commit more pages an=
d
change these pages to executable permissions.

Typically the JIT will want these co-located to minimize branch displacemen=
ts.

The kernel will coalesce these anonymous mapping with identical permissions
before sending an mmap event for the new pages. This means the mmap event f=
or
the new pages will include the older pages.

These anonymous mmap events will obscure the jitdump injected pseudo events=
.
This means that the jitdump generated symbols, machine code, debugging info=
,
and unwind info will no longer be used.

Observations:

When a process emits a jit dump marker and a jitdump file, the perf-xxx.map
file represents inferior information which has been superseded by the
jitdump jit-xxx.dump file.

Further the '//anon*' mmap events are only required for the legacy
perf-xxx.map mapping.

Summary:

Add rbtree to track which pids have successfully injected a jitdump file.

During "perf inject --jit", discard "//anon*" mmap events for any pid which
has successfully processed a jitdump file.

Committer testing:

// jitdump case
perf record <app with jitdump>
perf inject --jit --input perf.data --output perfjit.data

// verify mmap "//anon" events present initially
perf script --input perf.data --show-mmap-events | grep '//anon'
// verify mmap "//anon" events removed
perf script --input perfjit.data --show-mmap-events | grep '//anon'

// no jitdump case
perf record <app without jitdump>
perf inject --jit --input perf.data --output perfjit.data

// verify mmap "//anon" events present initially
perf script --input perf.data --show-mmap-events | grep '//anon'
// verify mmap "//anon" events not removed
perf script --input perfjit.data --show-mmap-events | grep '//anon'

Repro:

This issue was discovered while testing the initial CoreCLR jitdump
implementation. https://github.com/dotnet/coreclr/pull/26897.

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
 tools/perf/builtin-inject.c |  4 +--
 tools/perf/util/jitdump.c   | 63 +++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 372ecb3..0f38862 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -263,7 +263,7 @@ static int perf_event__jit_repipe_mmap(struct perf_tool=
 *tool,
         * if jit marker, then inject jit mmaps and generate ELF images
         */
        ret =3D jit_process(inject->session, &inject->output, machine,
-                         event->mmap.filename, sample->pid, &n);
+                         event->mmap.filename, event->mmap.pid, &n);
        if (ret < 0)
                return ret;
        if (ret) {
@@ -301,7 +301,7 @@ static int perf_event__jit_repipe_mmap2(struct perf_too=
l *tool,
         * if jit marker, then inject jit mmaps and generate ELF images
         */
        ret =3D jit_process(inject->session, &inject->output, machine,
-                         event->mmap2.filename, sample->pid, &n);
+                         event->mmap2.filename, event->mmap2.pid, &n);
        if (ret < 0)
                return ret;
        if (ret) {
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index e3ccb0c..6d891d1 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -749,6 +749,59 @@ jit_detect(char *mmap_name, pid_t pid)
        return 0;
 }
=20
+struct pid_rbtree
+{
+       struct rb_node node;
+       pid_t pid;
+};
+
+static void jit_add_pid(struct rb_root *root, pid_t pid)
+{
+       struct rb_node **new =3D &(root->rb_node), *parent =3D NULL;
+       struct pid_rbtree* data =3D NULL;
+
+       /* Figure out where to put new node */
+       while (*new) {
+               struct pid_rbtree *this =3D container_of(*new, struct pid_r=
btree, node);
+               pid_t nodePid =3D this->pid;
+
+               parent =3D *new;
+               if (pid < nodePid)
+                       new =3D &((*new)->rb_left);
+               else if (pid > nodePid)
+                       new =3D &((*new)->rb_right);
+               else
+                       return;
+       }
+
+       data =3D malloc(sizeof(struct pid_rbtree));
+       data->pid =3D pid;
+
+       /* Add new node and rebalance tree. */
+       rb_link_node(&data->node, parent, new);
+       rb_insert_color(&data->node, root);
+
+       return;
+}
+
+static bool jit_has_pid(struct rb_root *root, pid_t pid)
+{
+       struct rb_node *node =3D root->rb_node;
+
+       while (node) {
+               struct pid_rbtree *this =3D container_of(node, struct pid_r=
btree, node);
+               pid_t nodePid =3D this->pid;
+
+               if (pid < nodePid)
+                       node =3D node->rb_left;
+               else if (pid > nodePid)
+                       node =3D node->rb_right;
+               else
+                       return 1;
+       }
+       return 0;
+}
+
 int
 jit_process(struct perf_session *session,
            struct perf_data *output,
@@ -760,12 +813,21 @@ jit_process(struct perf_session *session,
        struct evsel *first;
        struct jit_buf_desc jd;
        int ret;
+       static struct rb_root jitdump_pids =3D RB_ROOT;
=20
        /*
         * first, detect marker mmap (i.e., the jitdump mmap)
         */
        if (jit_detect(filename, pid))
+       {
+               /*
+                * Strip //anon* mmaps if we processed a jitdump for this p=
id
+                */
+               if (jit_has_pid(&jitdump_pids, pid) && (strncmp(filename, "=
//anon", 6) =3D=3D 0))
+                       return 1;
+
                return 0;
+       }
=20
        memset(&jd, 0, sizeof(jd));
=20
@@ -784,6 +846,7 @@ jit_process(struct perf_session *session,
=20
        ret =3D jit_inject(&jd, filename);
        if (!ret) {
+               jit_add_pid(&jitdump_pids, pid);
                *nbytes =3D jd.bytes_written;
                ret =3D 1;
        }
--=20
2.7.4
