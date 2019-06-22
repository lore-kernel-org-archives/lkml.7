Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C64C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 20:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471422070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 20:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="MBRn/cBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfFVUWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 16:22:43 -0400
Received: from mail-eopbgr820079.outbound.protection.outlook.com ([40.107.82.79]:25734
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726286AbfFVUWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 16:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//PnnhyEEd+0caJL4qlwLCZXFuT+yB9TLoyFJFVlNgk=;
 b=MBRn/cBiGxOEj8+DB7wNG+6oFPkTOc0+QalX2jbFQ0AI9S+TfVC9xHVq8Cwe/ApQBt2TcGWhYQxiG+7Z3ZYu8rk4iacmGCovQSfh6TSu5oK/sXC/8mrQGVBsiQlvbPKPiwj+vuIrM6x8wW/FO+u2hX/jCzKTWUxjFN2awY4PLLw=
Received: from BN7PR08MB5684.namprd08.prod.outlook.com (20.176.31.141) by
 BN7PR08MB4034.namprd08.prod.outlook.com (52.132.7.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Sat, 22 Jun 2019 20:22:31 +0000
Received: from BN7PR08MB5684.namprd08.prod.outlook.com
 ([fe80::499a:3dda:4c08:f586]) by BN7PR08MB5684.namprd08.prod.outlook.com
 ([fe80::499a:3dda:4c08:f586%5]) with mapi id 15.20.1987.017; Sat, 22 Jun 2019
 20:22:31 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Evan Green <evgreen@chromium.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: [PATCH V1] scsi: ufs-bsg: complete ufs-bsg job only if no error
Thread-Topic: [PATCH V1] scsi: ufs-bsg: complete ufs-bsg job only if no error
Thread-Index: AdUpN0xws5PLgzbgS5mtBc6EeX8pxw==
Date:   Sat, 22 Jun 2019 20:22:31 +0000
Message-ID: <BN7PR08MB5684DDCA5C96794DAD71A1F9DBE60@BN7PR08MB5684.namprd08.prod.outlook.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=beanhuo@micron.com; 
x-originating-ip: [165.225.80.135]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eaa18d5e-e1ed-4b13-f1f1-08d6f74f5ab6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN7PR08MB4034;
x-ms-traffictypediagnostic: BN7PR08MB4034:|BN7PR08MB4034:
x-microsoft-antispam-prvs: <BN7PR08MB40341F57455A73C29B22BEAADBE60@BN7PR08MB4034.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0076F48C8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(39860400002)(396003)(346002)(376002)(366004)(189003)(199004)(6506007)(55236004)(53936002)(74316002)(66556008)(66476007)(76116006)(66446008)(64756008)(316002)(4326008)(25786009)(68736007)(305945005)(99286004)(7736002)(7696005)(102836004)(26005)(55016002)(478600001)(6436002)(5660300002)(86362001)(9686003)(186003)(8936002)(256004)(476003)(14444005)(52536014)(3846002)(6116002)(8676002)(2906002)(71190400001)(54906003)(110136005)(66946007)(73956011)(71200400001)(33656002)(66066001)(14454004)(81156014)(486006)(81166006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR08MB4034;H:BN7PR08MB5684.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ywZdiPJTPwnDJpF3lOvYSfLKgibRc+VAYT+ifZWXxelj90zjZwPukwZA62tMzj1KGgF3RFx5/oalHQBxUYiFy8HzV+1Pdc0mDYZm5KShLMTdEvOp9uFX/2ZJ6vLAIcySGu/2iNoueXSAihF00G6Hifra61lcAbe7X9ziCNZdvmqgFWvXXcbSeaTStbtYgDaJaw5EbN7DnbIZ7wbIo09rxALTJUsFlk5Jecfw0nvXhxZa86jnLeJ7tWYEpGjcsDHk3HKt+k4ap1+OAuYhNn4OXf+oiVmEWvfxxc26gS5hLq9VF1KkoHNNk47P3x/ctsPs7ebbMImmPvDE9usYjeLoVfDTcuUcn0NubHoxW514dk1N722rE0xniBOdh5099IjmKczJ+55ABth4KNEMakyqBg9GzQyytQJblAwPynuucdQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa18d5e-e1ed-4b13-f1f1-08d6f74f5ab6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2019 20:22:31.4930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: beanhuo@micron.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

In the case of UPIU/DME request execution failed in UFS device,=20
ufs_bsg_request() will complete this failed bsg job by calling
bsg_job_done(). Meanwhile, it returns this error status to blk-mq
layer, then trigger blk-mq complete this request again, this will
cause below panic.

[   68.673050] Call trace:
[   68.675491]  __ll_sc___cmpxchg_case_acq_32+0x4/0x20
[   68.680369]  complete+0x28/0x70
[   68.683510]  blk_end_sync_rq+0x24/0x30
[   68.687255]  blk_mq_end_request+0xb8/0x118
[   68.691350]  bsg_job_put+0x4c/0x58
[   68.694747]  bsg_complete+0x20/0x30
[   68.698231]  blk_done_softirq+0xb4/0xe8
[   68.702066]  __do_softirq+0x154/0x3f0
[   68.705726]  run_ksoftirqd+0x4c/0x68
[   68.709298]  smpboot_thread_fn+0x22c/0x268
[   68.713394]  kthread+0x130/0x138
[   68.716619]  ret_from_fork+0x10/0x1c
[   68.720193] Code: f84107fe d65f03c0 d503201f f9800011 (885ffc10)=20
[   68.726298] ---[ end trace d92825bff6326e66 ]---
[   68.730913] Kernel panic - not syncing: Fatal exception in interrupt

This patch is to fix this issue. The solution is we complete
the ufs-bsg job only if no error happened.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufs_bsg.c | 7 ++++---
 drivers/scsi/ufs/ufshcd.c  | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/ufs/ufs_bsg.c b/drivers/scsi/ufs/ufs_bsg.c
index 869e71f..d5516dc 100644
--- a/drivers/scsi/ufs/ufs_bsg.c
+++ b/drivers/scsi/ufs/ufs_bsg.c
@@ -122,7 +122,7 @@ static int ufs_bsg_request(struct bsg_job *job)
 		memcpy(&uc, &bsg_request->upiu_req.uc, UIC_CMD_SIZE);
 		ret =3D ufshcd_send_uic_cmd(hba, &uc);
 		if (ret)
-			dev_dbg(hba->dev,
+			dev_err(hba->dev,
 				"send uic cmd: error code %d\n", ret);
=20
 		memcpy(&bsg_reply->upiu_rsp.uc, &uc, UIC_CMD_SIZE);
@@ -143,13 +143,14 @@ static int ufs_bsg_request(struct bsg_job *job)
 			sg_copy_from_buffer(job->request_payload.sg_list,
 					    job->request_payload.sg_cnt,
 					    desc_buff, desc_len);
-
 	kfree(desc_buff);
=20
 out:
 	bsg_reply->result =3D ret;
 	job->reply_len =3D sizeof(struct ufs_bsg_reply);
-	bsg_job_done(job, ret, bsg_reply->reply_payload_rcv_len);
+	/* complete the job here only if no error */
+	if (ret =3D=3D 0)
+		bsg_job_done(job, ret, bsg_reply->reply_payload_rcv_len);
=20
 	return ret;
 }
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 04d3686..4718041 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -3776,7 +3776,7 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, s=
truct uic_command *cmd)
 }
=20
 /**
- * ufshcd_uic_change_pwr_mode - Perform the UIC power mode chage
+ * ufshcd_uic_change_pwr_mode - Perform the UIC power mode change
  *				using DME_SET primitives.
  * @hba: per adapter instance
  * @mode: powr mode value
--=20
2.7.4
