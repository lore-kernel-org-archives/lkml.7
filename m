Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09D4C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873D3206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="F1JHxcDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfCLLHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:07:20 -0400
Received: from mail-eopbgr20070.outbound.protection.outlook.com ([40.107.2.70]:15490
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbfCLLHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vo6/TypSMf7EfHn4pl5lXNtXlgr5TfUHuq5wT3QGEwI=;
 b=F1JHxcDYVZQJtuE6J3xSJJ61l7+C+rzrUDTlXWdyiYicp5uLlCwl6oH01TMZap7ndnt98HvnW9qSdZwOo7+FaIRlCXYXYZx5Sv9PnJkzR+6MBhE9J9q6bHc8UmBWoccsGuIO1UgioKHZEeOZAXu/oaQcTWFuJUY0CUszpKtL0CI=
Received: from AM6PR08MB3365.eurprd08.prod.outlook.com (20.177.112.214) by
 AM6PR08MB3927.eurprd08.prod.outlook.com (20.179.0.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 12 Mar 2019 11:07:14 +0000
Received: from AM6PR08MB3365.eurprd08.prod.outlook.com
 ([fe80::287d:f3df:7ebb:e0fa]) by AM6PR08MB3365.eurprd08.prod.outlook.com
 ([fe80::287d:f3df:7ebb:e0fa%4]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 11:07:14 +0000
From:   Qais Yousef <Qais.Yousef@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [RFC][PATCH] Export supported trace features in debugfs
Thread-Topic: [RFC][PATCH] Export supported trace features in debugfs
Thread-Index: AQHU2MO/44zSUEkuI0KLRIY8LAP33g==
Date:   Tue, 12 Mar 2019 11:07:14 +0000
Message-ID: <20190312110437.5977-1-qais.yousef@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0373.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::25) To AM6PR08MB3365.eurprd08.prod.outlook.com
 (2603:10a6:20b:43::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Qais.Yousef@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [217.140.106.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d47a20b2-6b52-486a-9677-08d6a6dae235
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3927;
x-ms-traffictypediagnostic: AM6PR08MB3927:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR08MB3927C4FA8C9DFB312EBDC37CFC490@AM6PR08MB3927.eurprd08.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(346002)(136003)(40434004)(199004)(189003)(36756003)(7736002)(7416002)(386003)(25786009)(305945005)(52116002)(102836004)(6506007)(486006)(476003)(2616005)(186003)(99286004)(26005)(86362001)(966005)(97736004)(316002)(54906003)(478600001)(110136005)(72206003)(6116002)(71190400001)(71200400001)(6436002)(3846002)(6486002)(5660300002)(6306002)(14444005)(5024004)(6512007)(256004)(106356001)(2906002)(66066001)(8676002)(44832011)(105586002)(68736007)(4326008)(8936002)(53936002)(14454004)(1076003)(50226002)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3927;H:AM6PR08MB3365.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7JGbhb47r+hMURDKobRBVkPf9skDG2NeR4kCd4SgqaWCDTV6Attod5+RTSHT4CFiU32yVEowtfrEftP9PUBgc0USUG3kqiv4BcWE+I4reKTVcbkIYgVoNA+3euLiOp6zMXnbqlOhMcGc3ixpI0WKJfkzR2cG91bRdXnvKCXE/Ks/WRy2GWyC8tyRBHgnyW4E7wcUXscTm4c++b2+Nhc3qq3+fG1sR8wo6s84oNFBRiaRMvwLcaCV1pCSDZYzooyYXyAM38Bx3vGh9u4ztTPZM/WRrsf0SVJIqnWPLS9lny99tD8DO3ovWmVAhh9lebLt718QMiOKORZF6XgN/NBz8kghiDU27LjlsRTMtX2/DtdyvRW9FIhmQtFQHfLvXSBvACZ3rRkAFyxuQUJ1wjnCumgi4ctOLN0NjXByVVK8itw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47a20b2-6b52-486a-9677-08d6a6dae235
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 11:07:14.9379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3927
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eBPF tools like bcc-tools have hard time figuring out when features like
raw_tracepoint are supported in the kernel on which we are running. At
the moment a fragile mechanism of matching bpf_find_raw_tracepoint()
function in /proc/kallsyms is used to find out whether raw tracepoints
can be used or not. But when this function was renamed recently to
bpf_get_raw_tracepoint() the tool started to fail to use raw
tracepoints.

To help in providing a more reliable way to detect features like
RAW_TRACEPOINT, add a new file in trace debugfs to export the supported
features.

$cat /sys/kernel/debug/tracing/supported_features
RAW_TRACEPOINT
EXAMPLE_FEATURE_1
EXAMPLE_FEATURE_2

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---

This is a half baked patch to probe the potential of this solution.

The breakage mentioned in the commit message is here:

https://github.com/iovisor/bcc/pull/2241/commits/0f5849187972a50adf0d9eaa87=
88c11f9fd926ea

I am not sure what else beside raw_tracepoint makes sense to expose right n=
ow.

 kernel/trace/trace.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c4238b441624..daae09238e62 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6670,6 +6670,28 @@ static const struct file_operations snapshot_raw_fop=
s =3D {

 #endif /* CONFIG_TRACER_SNAPSHOT */

+#define TRACE_FEATURE(feat)__stringify(feat) "\n"
+
+#define TRACE_FEATURES\
+TRACE_FEATURE(RAW_TRACEPOINT)\
+TRACE_FEATURE(EXAMPLE_FEATUTE_1)\
+TRACE_FEATURE(EXAMPLE_FEATUTE_2)
+
+static ssize_t
+tracing_read_trace_features(struct file *filp, char __user *ubuf,
+size_t cnt, loff_t *ppos)
+{
+char *buf =3D TRACE_FEATURES;
+size_t len =3D sizeof(TRACE_FEATURES);
+
+return simple_read_from_buffer(ubuf, cnt, ppos, buf, len);
+}
+
+static const struct file_operations show_trace_features_fops =3D {
+.read           =3D tracing_read_trace_features,
+.llseek         =3D no_llseek,
+};
+
 static int tracing_buffers_open(struct inode *inode, struct file *filp)
 {
 struct trace_array *tr =3D inode->i_private;
@@ -8242,6 +8264,9 @@ static __init int tracer_init_tracefs(void)
 &ftrace_update_tot_cnt, &tracing_dyn_info_fops);
 #endif

+trace_create_file("trace_features", 0444, d_tracer,
+NULL, &show_trace_features_fops);
+
 create_trace_instances(d_tracer);

 update_tracer_options(&global_trace);
--
2.17.1

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
