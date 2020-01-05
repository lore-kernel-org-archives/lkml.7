Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53176C33C9A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 15:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA8820866
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 15:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="pZMWJnVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgAEPL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 10:11:26 -0500
Received: from mail-eopbgr50121.outbound.protection.outlook.com ([40.107.5.121]:58182
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726212AbgAEPL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 10:11:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfkTrsy6rclEDEVNp5aDbaW8JhppS8jhWsDulgUG5PN/qIByhUBo3jYMvDj4j9e/111jDSmBL8vhKD0djRoULozT9t9mhRc3AIqW66+iakrfLpjasmVeQLFkf+TqITCS2iHF/nokK/RG4NREet0WEP4jmkBsfvZE9JY9Xsj+tpMFJSes6NBO1bevZ+gwHk0tzXnNn5x1oaZTXb2u8g9koQ52vc3OQCbWl5NydKHcoZQtNNP07fymtyyHw4n8aHGWRfn69X21nCRWNSPpmY5jIfPbWowbhFRTz2BOOpc/R5hRpheFgl5TOld2UJ+MEkANPx3/jlvDJGFxUWuTxYrMLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTk3g+o/VSm7pkuIm/+5Ib5pzdMYwpEBseCWEns+ntg=;
 b=Y4K5QeA7ouAMsTtJC4OB0eHXAeIlO73Z+ACm01EcJLKgOtIuzNyymn+4SEB90pOrOBeqAVJb77Eu3ir2bRqn4vwbuWu+UJsuZFKyvpoW9uz7H9Aqipw3Vof3usrtUQoackFuCxmF6lD+Y/ndd9tljv2Pne2cq9CegaVa/hEflNhJK1P29QFipu1zlRLFTQ0nYrF6ItHSpe34XTLCtyRM2EvH32wpxYlpCY8Iksd+0o+W20uYtp6sCfg+gLn0+E6pboItiVF1GEb6vUd7zg/A2PqZGyOJcGXBJKOv8V7hAP+rpVCJfCyl0PpzlWwqvmwVqgxT1XHamWtlgv63j5pe/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTk3g+o/VSm7pkuIm/+5Ib5pzdMYwpEBseCWEns+ntg=;
 b=pZMWJnVwXJMrspbQpNrJ++Ow1b4QvzHbV2X0rHgheFeIDCFYQbdT+JmuJ/zVCQWpwYI8pFkpzax1kx03GWINoaSDMLc22JiAkIsgvJQ8YsIWrk/T9AktH0Iy4B2vzZmA8aaaQGJ6YtqHsDGOQ1QfcBQQrEUggeBtjOUdzC7eRBA=
Received: from HE1PR02MB3258.eurprd02.prod.outlook.com (10.170.242.32) by
 HE1PR02MB3018.eurprd02.prod.outlook.com (10.170.241.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Sun, 5 Jan 2020 15:11:22 +0000
Received: from HE1PR02MB3258.eurprd02.prod.outlook.com
 ([fe80::24fe:bc90:5c45:acbf]) by HE1PR02MB3258.eurprd02.prod.outlook.com
 ([fe80::24fe:bc90:5c45:acbf%7]) with mapi id 15.20.2602.015; Sun, 5 Jan 2020
 15:11:22 +0000
Received: from ttayar-VM.habana-labs.com (31.154.190.6) by ZRAP278CA0004.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11 via Frontend Transport; Sun, 5 Jan 2020 15:11:22 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] habanalabs: Avoid running restore chunks if no execute chunks
Thread-Topic: [PATCH] habanalabs: Avoid running restore chunks if no execute
 chunks
Thread-Index: AQHVw9pkWXEAOtUcY0WlkYTgRf4U1Q==
Date:   Sun, 5 Jan 2020 15:11:22 +0000
Message-ID: <20200105151115.15860-1-ttayar@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ZRAP278CA0004.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::14) To HE1PR02MB3258.eurprd02.prod.outlook.com
 (2603:10a6:7:37::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f2c65ef-4650-4d56-15a3-08d791f18664
x-ms-traffictypediagnostic: HE1PR02MB3018:
x-microsoft-antispam-prvs: <HE1PR02MB3018B6FC4275318D7B3DECCED23D0@HE1PR02MB3018.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 027367F73D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(136003)(39840400004)(396003)(189003)(199004)(316002)(52116002)(71200400001)(1076003)(86362001)(8936002)(6916009)(81156014)(81166006)(8676002)(16526019)(478600001)(186003)(2906002)(66446008)(26005)(66556008)(66476007)(64756008)(66946007)(6506007)(4326008)(36756003)(956004)(5660300002)(6512007)(2616005)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR02MB3018;H:HE1PR02MB3258.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fnGFOStVNWzvffc3QXNheBcL/hSZgWJkKbilb8mgrViLdO+6VgVOb9xSNqYBDf5Z2FOiQkCL+v6LOMPPvEC28H97c97Nn0VJeLWnLcJskFID9Toe+318lyTzZtwYn7K2O3s7gD4r7yewOh0AJVs2BYpLDtssMyKa6zCx/c2bll4WS4KE0NtXaUIOaUSZiCA/OwU8P+/qXlyBjMSPnZ3SJalTEPrBqv+Jk1wHGLV4ALQVxYIeHlmATquCPGNHIwbXg3actwMUCSy2dB6DqGzS1ViDejcYkbzF3GvJTLuinydLnK+d4IX2b99Fwl6+xJy+sLEeZImz9Rl9/yjWVLzqH1OUCz2Du/ezXKix1JDUvHaikEBmeeqYXAFZMVpUn0IalabQqBvoEJN/3dYYKi4bqjfuiQSNsZHBpxVAjw0SZ0bc1EiG3JWhESxgyqPCtq1D
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2c65ef-4650-4d56-15a3-08d791f18664
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2020 15:11:22.5905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+o4Vr/mzpikXgiHnYAYZ4My2lrxH3m5VGB7/9VdHak4Mkp399MSJiG/5RCNzdvO2hYrhRFwZnd/jPInGHBwtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR02MB3018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CS with no chunks for execute phase is invalid, so its
context_switch/restore phase should not be run.
Hence, move the check of the execute chunks number to the beginning of
hl_cs_ioctl().

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
---
 drivers/misc/habanalabs/command_submission.c | 41 ++++++++++----------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/ha=
banalabs/command_submission.c
index 7cb6910378bf..73ef0f9d758a 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -657,8 +657,8 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 	struct hl_device *hdev =3D hpriv->hdev;
 	union hl_cs_args *args =3D data;
 	struct hl_ctx *ctx =3D hpriv->ctx;
-	void __user *chunks;
-	u32 num_chunks;
+	void __user *chunks_execute, *chunks_restore;
+	u32 num_chunks_execute, num_chunks_restore;
 	u64 cs_seq =3D ULONG_MAX;
 	int rc, do_ctx_switch;
 	bool need_soft_reset =3D false;
@@ -671,13 +671,25 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 		goto out;
 	}
=20
+	chunks_execute =3D (void __user *) (uintptr_t) args->in.chunks_execute;
+	num_chunks_execute =3D args->in.num_chunks_execute;
+
+	if (!num_chunks_execute) {
+		dev_err(hdev->dev,
+			"Got execute CS with 0 chunks, context %d\n",
+			ctx->asid);
+		rc =3D -EINVAL;
+		goto out;
+	}
+
 	do_ctx_switch =3D atomic_cmpxchg(&ctx->thread_ctx_switch_token, 1, 0);
=20
 	if (do_ctx_switch || (args->in.cs_flags & HL_CS_FLAGS_FORCE_RESTORE)) {
 		long ret;
=20
-		chunks =3D (void __user *)(uintptr_t)args->in.chunks_restore;
-		num_chunks =3D args->in.num_chunks_restore;
+		chunks_restore =3D
+			(void __user *) (uintptr_t) args->in.chunks_restore;
+		num_chunks_restore =3D args->in.num_chunks_restore;
=20
 		mutex_lock(&hpriv->restore_phase_mutex);
=20
@@ -705,13 +717,13 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
=20
 		hdev->asic_funcs->restore_phase_topology(hdev);
=20
-		if (num_chunks =3D=3D 0) {
+		if (!num_chunks_restore) {
 			dev_dbg(hdev->dev,
 			"Need to run restore phase but restore CS is empty\n");
 			rc =3D 0;
 		} else {
-			rc =3D _hl_cs_ioctl(hpriv, chunks, num_chunks,
-						&cs_seq);
+			rc =3D _hl_cs_ioctl(hpriv, chunks_restore,
+						num_chunks_restore, &cs_seq);
 		}
=20
 		mutex_unlock(&hpriv->restore_phase_mutex);
@@ -724,7 +736,7 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 		}
=20
 		/* Need to wait for restore completion before execution phase */
-		if (num_chunks > 0) {
+		if (num_chunks_restore) {
 			ret =3D _hl_cs_wait_ioctl(hdev, ctx,
 					jiffies_to_usecs(hdev->timeout_jiffies),
 					cs_seq);
@@ -752,18 +764,7 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 		}
 	}
=20
-	chunks =3D (void __user *)(uintptr_t)args->in.chunks_execute;
-	num_chunks =3D args->in.num_chunks_execute;
-
-	if (num_chunks =3D=3D 0) {
-		dev_err(hdev->dev,
-			"Got execute CS with 0 chunks, context %d\n",
-			ctx->asid);
-		rc =3D -EINVAL;
-		goto out;
-	}
-
-	rc =3D _hl_cs_ioctl(hpriv, chunks, num_chunks, &cs_seq);
+	rc =3D _hl_cs_ioctl(hpriv, chunks_execute, num_chunks_execute, &cs_seq);
=20
 out:
 	if (rc !=3D -EAGAIN) {
--=20
2.17.1

