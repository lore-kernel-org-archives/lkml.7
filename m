Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF00C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6220B224FE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="h0AS4P1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbfI3VAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:00:06 -0400
Received: from mail-eopbgr710123.outbound.protection.outlook.com ([40.107.71.123]:27825
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727702AbfI3VAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:00:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQ/c8QhnhnhhUE0GXzkirYiOPo6aO+fP9ipuW3GHEb0YJf8ub0SDDVx6DF82HcTCfFL/1MHmtI+H/GPqCB9+kAL4XL/k5t0SQxVmikAfN0/sC1ol3mDyN1Z+73WYWuZ0kqtINlCYkueKiZcOE3zh1nchBzNpTMVYZv0y9tuyUpMtMclaZkNTinc3kGSr/aYlmi1V8AlPfPzRiHNVE1NX+bZgZQh0FWlyNipI10fqtdr18YPn5uuWiqTldpZWreyInP6omCVT3ovR0HUtc9B2/OwRMBchyuf8+CH3NmlX6LIS/2NWbz6QBK7NMG/DNHeDXdD3RErTNsKLTjicpwdgvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1o6BzbzEMRhv2rAAmUkukE7cMMgip72SefEDxGb0uPA=;
 b=AuRqGNO/Uh01ZDhDVQJzPn8bSNvulkCIo+QLQkF11MVXz216gUd4JXdrgHAftq5UBUng6YLBJ0JnZgK51FE5ZKqCutGAoTVsrueOtBHYVC7eIHQTPo6ZNt7efAr4emIpZc7j9+tP8SlINZq5SWHEyMsn3eNaYA/+yavBvZkYUQdw/R6ghXOdrGi0UWi3/64uXdyMwbv1OHR9S980kWLphhV12cnL4De76b0V3zN8gDiN0Q4BmJIhRYM6XFERZ5kpoWPd63iHOsTMWMVQ2qt8czMG6ky/lACm5OLC7vyM/oX6OGGMz+h7+D2dTbGQZko3JcuQdZPkXoCjJeVy3qJPow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1o6BzbzEMRhv2rAAmUkukE7cMMgip72SefEDxGb0uPA=;
 b=h0AS4P1Br2Lr1wmhwbQbRJCLfPNdZh+de7Je2NjllaXNx+LD4OTrBPLwodhUJmxJ0LApXpuV9w80QOfbUpoPBIJL96ixqouNFxA5S6ekaTq3PLDXFLTcVct8u/aABe/VcdQ4kO5ec2q+KGGwrDcrueUSanX5IiYrLYFXazkdal0=
Received: from BN8PR21MB1362.namprd21.prod.outlook.com (20.179.76.155) by
 BN8PR21MB1156.namprd21.prod.outlook.com (20.179.72.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.7; Mon, 30 Sep 2019 21:00:01 +0000
Received: from BN8PR21MB1362.namprd21.prod.outlook.com
 ([fe80::6cea:8074:a394:f20d]) by BN8PR21MB1362.namprd21.prod.outlook.com
 ([fe80::6cea:8074:a394:f20d%9]) with mapi id 15.20.2327.004; Mon, 30 Sep 2019
 21:00:01 +0000
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
Subject: [PATCH 3/4 RESEND] perf inject --jit: Remove //anon mmap events
Thread-Topic: [PATCH 3/4 RESEND] perf inject --jit: Remove //anon mmap events
Thread-Index: AdV30UpDWyGhNX8tTHCRL/VpRSaZoA==
Date:   Mon, 30 Sep 2019 21:00:01 +0000
Message-ID: <BN8PR21MB13622159D33A3EBCADDF4B2FF7820@BN8PR21MB1362.namprd21.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 80a6ed17-e305-4d93-e9cf-08d745e92933
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BN8PR21MB1156:|BN8PR21MB1156:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN8PR21MB1156E0E189D4C4E4AB04DDEBF7820@BN8PR21MB1156.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(199004)(189003)(81166006)(6306002)(74316002)(9686003)(7416002)(26005)(3846002)(8990500004)(81156014)(66476007)(66946007)(76116006)(66556008)(66446008)(6116002)(54906003)(86362001)(10290500003)(25786009)(14454004)(55016002)(64756008)(110136005)(22452003)(10090500001)(305945005)(8936002)(102836004)(4326008)(476003)(6436002)(52536014)(478600001)(5660300002)(186003)(966005)(316002)(6506007)(8676002)(66066001)(486006)(14444005)(99286004)(71200400001)(33656002)(7736002)(71190400001)(2906002)(256004)(7696005)(21314003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1156;H:BN8PR21MB1362.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hBbainCRoj6M9DbzSMpKIdqR1AgEyIdaRaR2USa2eKQVKBP87YKuUlMqEeOCnDpQ1j4kWFejZpGRvSLAFiP4aa1hR1VPyRMFFH5wD4XD2RCGNeoDz65EB1D9At+rhp6BMz5OK2BC/eXj18I1CQ0byBL6sLVpimI+Ma8ZAchZ4zwamtaPXneTPNUKB/u4foNYKCkVFRAb57Gn2JLzEnoi2FkF5cqNlt3d2Q5jFkmElcBplCU4SdMrFc0aWzGB9DcBRfi5/UrBK8s9RN0oRcNSEUlpoRnA3/k3gMpSqHjI9l4N4oINkGcqWjH23LpUGxREYY8P8j+yT2ZJUr2msgWbyUhCVIDEtAc8whQT79N4cCOpnzTBbXSpLEXJff0yBp+yGX93dP/X+zuP1iaYC8A66at3+L0CCFtQXQYuo+d+pn+Oqj3fq+UOP8dJ/QDFzUkRAfps9UQM8oBZJI2nJnogaQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a6ed17-e305-4d93-e9cf-08d745e92933
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 21:00:01.4300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +tpkX0MWDLMUBg36rhTDep+PQ1bPKir3agSp5/rTCGp/BjKRLO/eD6g+yXOILPqImAd3a+PucD9IhclWm8+G7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While a JIT is jitting code it will eventually need to commit more pages an=
d
change these pages to executable permissions.

Typically the JIT will want these collocated to minimize branch displacemen=
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
index c14f40b8..4c921e0 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -261,7 +261,7 @@ static int perf_event__jit_repipe_mmap(struct perf_tool=
 *tool,
         * if jit marker, then inject jit mmaps and generate ELF images
         */
        ret =3D jit_process(inject->session, &inject->output, machine,
-                         event->mmap.filename, sample->pid, &n);
+                         event->mmap.filename, event->mmap.pid, &n);
        if (ret < 0)
                return ret;
        if (ret) {
@@ -299,7 +299,7 @@ static int perf_event__jit_repipe_mmap2(struct perf_too=
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
index 22d09c4..6a1563f 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -751,6 +751,59 @@ jit_detect(char *mmap_name, pid_t pid)
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
@@ -762,12 +815,21 @@ jit_process(struct perf_session *session,
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
@@ -786,6 +848,7 @@ jit_process(struct perf_session *session,
=20
        ret =3D jit_inject(&jd, filename);
        if (!ret) {
+               jit_add_pid(&jitdump_pids, pid);
                *nbytes =3D jd.bytes_written;
                ret =3D 1;
        }
--=20
2.7.4

