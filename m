Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0866C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3BC206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="egZ4TQLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfLPImT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 03:42:19 -0500
Received: from mail-eopbgr80105.outbound.protection.outlook.com ([40.107.8.105]:39375
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726777AbfLPImT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 03:42:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLGTPf4FR4lydyEFye7evn6gJnpwXZUw5gJCze4qE0kal/BORzp3WrUxWhdAoSyh7x1DFImpJRx4PCddVLMvXIFRQgUuvYBZYk3kMwluC4vggvDVbQt2Tz0DzHGWUMFOsdrSPUp9q3fA9RqyKyBLPRSvLYsZ3zFyocMN2rtZf5cSTTXIz1Gxxz/f4rD00OUPyhd0GNtcg1ZZoo1a5lGceU1kxoI/iOR/P6mb7JNI1C2tzAzKal1w/KfDr/Vq6Swu9hgzyvDho+IVN29JbmNZISvHe4rwzKXmjcr/fZIuO+msdQXBOmiwP0U/sL0jrPvjZB4aE4TyRQJmHat2qSvkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQFZkaGu/fYPNr85sZfRSbfxdwgROavh8Q2LoRg1gCw=;
 b=h/DglXbpG/SYsqyqLvL7OW47tYUvNT7f1EOM4JGJGJ7j7H8WxXYhXod6GLRAFqMNJA9WYtvcXZdh1uQymC/puW2wtDFOHJhD9s54P35otRCyebH0lIHPI1zkSkSd9a3AE/3sd9f7yx4r5x/ZS7YVT/TIeVP8XegDQX4Ar4GH6YXpwuoOeH43ntZkN4mnxn/RzVIpVIpLhcpxyf/5S8kFDttQjJeFjyMXWDJ6Cd9yIkhmvvASXeQyYCNRXMjx9eRwsj0Uhidcf1uoiWXaiGN3qATtWoy6UgyPYLMDwTB3nm8Wh8cFTaj54Toio78W5VS5+XeCasyAl1gboWRrxBQODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQFZkaGu/fYPNr85sZfRSbfxdwgROavh8Q2LoRg1gCw=;
 b=egZ4TQLsC5F6ZHl45+5i6SEg/gPHXb7cZ1o7EGRDjxpFa31uCB1FnxzITjcuhX4lNFhmqJoscQhvhi1OSWVK37dUW8fMYrYyrOiOQRUw6LWbnhm1kYPNuSs3FlVc32ka4iESUxEpKFAmsdxW47NQhp3I1mL1FrFcKgagsvDo8bM=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3557.eurprd02.prod.outlook.com (52.133.10.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Mon, 16 Dec 2019 08:42:15 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::700e:4595:8b7a:8b4c]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::700e:4595:8b7a:8b4c%3]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 08:42:15 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] habanalabs: use the user CB size as a default job size
Thread-Topic: [PATCH] habanalabs: use the user CB size as a default job size
Thread-Index: AQHVs+y3y+gwOWO0GEeukcbLoVbRKw==
Date:   Mon, 16 Dec 2019 08:42:14 +0000
Message-ID: <20191216084207.19482-1-oshpigelman@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::32) To AM6PR0202MB3382.eurprd02.prod.outlook.com
 (2603:10a6:209:20::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad486213-81ec-460a-29bb-08d78203d9db
x-ms-traffictypediagnostic: AM6PR0202MB3557:
x-microsoft-antispam-prvs: <AM6PR0202MB355771C3A02D4E44BF02583CB8510@AM6PR0202MB3557.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(396003)(39840400004)(199004)(189003)(6506007)(186003)(1076003)(71200400001)(66946007)(5660300002)(36756003)(478600001)(6512007)(66446008)(86362001)(66556008)(64756008)(66476007)(52116002)(2616005)(8936002)(81166006)(81156014)(8676002)(4326008)(26005)(6916009)(316002)(6486002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3557;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aFBcTjcqy+9mGRon3ZchQawy2wPkZrTK+GbSjLHzXNkT4XfM59OC3B6ghBREB/W2H6qXzn5CuEgq1CreiOfJFdldMRZzDsdnUmfebvnRc0YjADgvP07E6mustDGRnXWKJ9rh1t4o+7st2A4NJ6leWg8PZp2jyLjudTctyfV0HIPw+ixb7KycX0GJnkqNwjPsLpZmCBAMnQ907R5pqQ/McAeee0SAjFNA10QOxR5k6zJiwoWNrpcthDTfTADtFP3OggXZW1CZNALt8dOhcJDSvFqmu3TxEu0/V2OscDuxBoYNRMqozxfasCL1EpcLOFSRkarNtaC//irVzxXkdl7ovnRKxvnPNfZDFMWYAChy6SX8um9dGtA/NAzENkZOdvB8Qw0Rf4DBkm3Zhnmnla7EOBmiVEJYFEGA49B8rUyDvn/dlGrpBUKJZqCsvNMz8o0B
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: ad486213-81ec-460a-29bb-08d78203d9db
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 08:42:15.0024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 69WD2YFobDThM8kd1Z+ew0GFsrCSjLOSU/0xlRWnEQ7ZUgwFG6dkvk7b4nNJaRwxyKb+eKb1HSpG1vjgjVoVXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When no patched command buffer (CB) is created, use the user CB size as
the job size.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
---
 drivers/misc/habanalabs/command_submission.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/ha=
banalabs/command_submission.c
index 8850f475a413..41e95513c591 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -129,6 +129,8 @@ static int cs_parser(struct hl_fpriv *hpriv, struct hl_=
cs_job *job)
 		spin_unlock(&job->user_cb->lock);
 		hl_cb_put(job->user_cb);
 		job->user_cb =3D NULL;
+	} else if (!rc) {
+		job->job_cb_size =3D job->user_cb_size;
 	}
=20
 	return rc;
@@ -585,10 +587,6 @@ static int _hl_cs_ioctl(struct hl_fpriv *hpriv, void _=
_user *chunks,
 		job->cs =3D cs;
 		job->user_cb =3D cb;
 		job->user_cb_size =3D chunk->cb_size;
-		if (is_kernel_allocated_cb)
-			job->job_cb_size =3D cb->size;
-		else
-			job->job_cb_size =3D chunk->cb_size;
 		job->hw_queue_id =3D chunk->queue_index;
=20
 		cs->jobs_in_queue_cnt[job->hw_queue_id]++;
--=20
2.17.1

