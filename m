Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C372ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB0A207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="kiKffzCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbfJVSY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 14:24:29 -0400
Received: from mail-eopbgr810110.outbound.protection.outlook.com ([40.107.81.110]:6122
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727226AbfJVSY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 14:24:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcoEBwKqIU7PrAv+2jRat90rn3SPx0zo01/EvkVRKi3zfuuedaSeBiI/vierRT1ug1ReZ0qDKzHLIiL9Lq6VyF2EyUuHc4loQcSRjyw1fmina4UTYqvFXqIJQJ/D7pocXw524F/Ho1LPZPq/ZNIBssQupwRVoVaQbDMKa1iam4VrwXpk49eCqggUqo5MtbpGLSmtvCxCx1bl44VKDS/MRNtefXe1NYebzo+C6J967kIdI84IKy5Q9O0Ly3ZbFNKSPv/q3YJRLGDHXWPWLJUHErYWGW1mresQJlo85yOcTdeKeTW/plJ0Nm8Z4NvrCoYQ0paH/l6K63VmcnEkR9JC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXnt8gUJQop6xptp/QhIpRwzoj/MxLdHsKFhcT/3rNk=;
 b=m5356L/S+O+v4g78OagXzsKBfyYj/JMLNZh5jLX2jKmlb39B2XIQXev1WXxZJmGAL1VUecKFcXH9sqakRbgdg40ZAeNF/0KGOviQNz97lBcwbhOqS4UVA6gntLSB4/fFBHqG0Z1AA1MA2QYYQpjRkdDxwd4/quHY/ARIBPOw8MebkrUx54wOdKfmv1jjRjZ/hZTVoMgfoMyDvEDzUzMWbEZ48yQ/dAmy6g7YsJG0dK0DEbdWvCb1gdM1SXDVHyI7W6UQTu0BR6D+pHZ5eTngzDBcoI8wSAos03+OiYkfxopjuTVtMFbveL3xlI5VHrvTLyplLUZrLdtH6odpdsg5Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXnt8gUJQop6xptp/QhIpRwzoj/MxLdHsKFhcT/3rNk=;
 b=kiKffzCZyqmX/v7mdzue9OiG9yak2weawrt8GX25t0mh30EDzogZvC/S8PkycNX5cfrqb5CD0SetRQfV0565STO0UbREe+r9tUBPWKyMO2rSuy/Oq1E2FRmIp8slHLzUbcSj8Bx0S96B9GJ/WEVRGbOeSZBdrcvfjJT81aC9nI4=
Received: from CY4PR2201MB1349.namprd22.prod.outlook.com (10.171.209.23) by
 CY4PR2201MB1349.namprd22.prod.outlook.com (10.171.209.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Tue, 22 Oct 2019 18:24:26 +0000
Received: from CY4PR2201MB1349.namprd22.prod.outlook.com
 ([fe80::edfc:bc08:cdfe:17b6]) by CY4PR2201MB1349.namprd22.prod.outlook.com
 ([fe80::edfc:bc08:cdfe:17b6%9]) with mapi id 15.20.2347.028; Tue, 22 Oct 2019
 18:24:25 +0000
From:   Hassan Naveed <hnaveed@wavecomp.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>,
        Hassan Naveed <hnaveed@wavecomp.com>
Subject: [PATCH] TRACING: FTRACE: Use xarray structure for ftrace syscalls
Thread-Topic: [PATCH] TRACING: FTRACE: Use xarray structure for ftrace
 syscalls
Thread-Index: AQHViQXvykgdc0QYqUG3OJB0FA3v5A==
Date:   Tue, 22 Oct 2019 18:24:25 +0000
Message-ID: <20191022182303.14829-1-hnaveed@wavecomp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::35) To CY4PR2201MB1349.namprd22.prod.outlook.com
 (2603:10b6:910:64::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hnaveed@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [12.94.197.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72f6e871-009a-4a3f-08ac-08d7571d1172
x-ms-traffictypediagnostic: CY4PR2201MB1349:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR2201MB1349D6E0B84B0F961DC5AA8DD4680@CY4PR2201MB1349.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39840400004)(136003)(376002)(366004)(189003)(199004)(71190400001)(316002)(71200400001)(66476007)(64756008)(50226002)(66446008)(2906002)(4326008)(1076003)(25786009)(66556008)(102836004)(6506007)(54906003)(52116002)(2501003)(110136005)(26005)(6436002)(66946007)(99286004)(81156014)(8676002)(81166006)(8936002)(386003)(186003)(6486002)(6512007)(256004)(6116002)(14454004)(3846002)(5660300002)(7736002)(305945005)(107886003)(36756003)(86362001)(66066001)(486006)(476003)(2616005)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1349;H:CY4PR2201MB1349.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vePpAYm59YO1hjnwZzqu1Kj00CJjx76F8nkYA3Q6ABNHnh84iOkPJDs3ExUC3gbnV2Q6I6bGQWUDIiGMAiw5TlUXy5e5YcaluW29z618t315WnA4+7MD5VkKwSAxYwJZUo5A9+m0XhFiy7B5M6xdg/HT2UJSSqbXhIZCAb0yljuGpUyr/ZpXWnSv6rV+f9ouh1zZiXBwvNOg9wsiKVpf8crvUbIVFBnYQvBTx9TUOpvA7MGlj17D+O6cJiNunECGZpESxTWbWOB+9rLirxIBlyhlqEJTSE5pXyjhuj13O7L3FUwJILUPyP+1gjeTJLtJpgDVCzuZmUXuZJ8RFVhLuL+7TNi7CWWUv3LY0qe6BmMwQsTAd+eQUic2dgFLOtf88uCTh7ZyegnSUiz5mPFlN3O21toGnyDPqeyFPf2h0ME=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f6e871-009a-4a3f-08ac-08d7571d1172
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 18:24:25.7407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iB7X7jk3JleMzk5Bmnixliqu1dVJy7h/VTqaMgC3fJzZKlVeG/DU9eSZ21/yv3S4MfCOqNDZzXM1HBI++jhCfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1349
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hassan Naveed <hnaveed@wavecomp.com>

Currently, a lot of memory is wasted for architectures like MIPS when
init_ftrace_syscalls() allocates the array for syscalls using kcalloc.
This is because syscalls numbers start from 4000, 5000 or 6000 and
array elements up to that point are unused.
Fix this by using a data structure more suited to storing sparsely
populated arrays. The XARRAY data structure, implemented using radix
trees, is much more memory efficient for storing the syscalls in
question.

Signed-off-by: Hassan Naveed <hnaveed@wavecomp.com>
---
 kernel/trace/trace_syscalls.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index f93a56d2db27..1fee710be874 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>	/* for MODULE_NAME_LEN via KSYM_SYMBOL_LEN */
 #include <linux/ftrace.h>
 #include <linux/perf_event.h>
+#include <linux/xarray.h>
 #include <asm/syscall.h>
=20
 #include "trace_output.h"
@@ -30,7 +31,7 @@ syscall_get_enter_fields(struct trace_event_call *call)
 extern struct syscall_metadata *__start_syscalls_metadata[];
 extern struct syscall_metadata *__stop_syscalls_metadata[];
=20
-static struct syscall_metadata **syscalls_metadata;
+static DEFINE_XARRAY(syscalls_metadata);
=20
 #ifndef ARCH_HAS_SYSCALL_MATCH_SYM_NAME
 static inline bool arch_syscall_match_sym_name(const char *sym, const char=
 *name)
@@ -101,10 +102,7 @@ find_syscall_meta(unsigned long syscall)
=20
 static struct syscall_metadata *syscall_nr_to_meta(int nr)
 {
-	if (!syscalls_metadata || nr >=3D NR_syscalls || nr < 0)
-		return NULL;
-
-	return syscalls_metadata[nr];
+	return xa_load(&syscalls_metadata, (unsigned long)nr);
 }
=20
 const char *get_syscall_name(int syscall)
@@ -535,13 +533,6 @@ void __init init_ftrace_syscalls(void)
 	unsigned long addr;
 	int i;
=20
-	syscalls_metadata =3D kcalloc(NR_syscalls, sizeof(*syscalls_metadata),
-				    GFP_KERNEL);
-	if (!syscalls_metadata) {
-		WARN_ON(1);
-		return;
-	}
-
 	for (i =3D 0; i < NR_syscalls; i++) {
 		addr =3D arch_syscall_addr(i);
 		meta =3D find_syscall_meta(addr);
@@ -549,7 +540,7 @@ void __init init_ftrace_syscalls(void)
 			continue;
=20
 		meta->syscall_nr =3D i;
-		syscalls_metadata[i] =3D meta;
+		xa_store(&syscalls_metadata, i, meta, GFP_KERNEL);
 	}
 }
=20
--=20
2.17.1

