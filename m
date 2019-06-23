Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0351C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 17:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED1320673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 17:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="ALVYl2lg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfFWRi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 13:38:59 -0400
Received: from mail-eopbgr750042.outbound.protection.outlook.com ([40.107.75.42]:34286
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726718AbfFWRi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 13:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28wRNNOko65sM5APfnB/ZqIQlZWhViFUGA91pMekh0U=;
 b=ALVYl2lg323fRnCj/13t1lOjy+JoujO5cPU8IeQi5tTIrOX782RmgLjRaPpmqjjLQJFaSfCpm8zPN6+nSJCvqwf7uaxc9NAb48eZju74uEiLCuNrg/iq0hY1uiqwm1f+PG7ZcR/nnmRgw1q9Zpki/0tnDCjP0ZnAVgySnRbTrfo=
Received: from BN7PR08MB5684.namprd08.prod.outlook.com (20.176.31.141) by
 BN7PR08MB4241.namprd08.prod.outlook.com (52.133.222.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Sun, 23 Jun 2019 17:38:57 +0000
Received: from BN7PR08MB5684.namprd08.prod.outlook.com
 ([fe80::4dd2:da15:6626:c3b0]) by BN7PR08MB5684.namprd08.prod.outlook.com
 ([fe80::4dd2:da15:6626:c3b0%3]) with mapi id 15.20.2008.014; Sun, 23 Jun 2019
 17:38:57 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Evan Green <evgreen@chromium.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>
Subject: [PATCH v2 3/3] scsi: ufs-bsg: complete ufs-bsg job only if no error
Thread-Topic: [PATCH v2 3/3] scsi: ufs-bsg: complete ufs-bsg job only if no
 error
Thread-Index: AdUp6Srmpfy7wc9rSjiZVcf65uZncg==
Date:   Sun, 23 Jun 2019 17:38:56 +0000
Message-ID: <BN7PR08MB568413353176CE5E61C2CF87DBE10@BN7PR08MB5684.namprd08.prod.outlook.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=beanhuo@micron.com; 
x-originating-ip: [165.225.81.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfcbba79-46fd-4fd0-f8f6-08d6f801ab36
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN7PR08MB4241;
x-ms-traffictypediagnostic: BN7PR08MB4241:|BN7PR08MB4241:
x-microsoft-antispam-prvs: <BN7PR08MB4241A50CFE2CA59F19050C1BDBE10@BN7PR08MB4241.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00770C4423
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(366004)(189003)(199004)(2906002)(52536014)(110136005)(71190400001)(26005)(102836004)(6506007)(74316002)(55236004)(14444005)(186003)(256004)(476003)(4326008)(73956011)(316002)(71200400001)(486006)(81156014)(14454004)(66066001)(66946007)(81166006)(305945005)(7736002)(66476007)(5660300002)(8676002)(66446008)(66556008)(64756008)(54906003)(9686003)(478600001)(76116006)(86362001)(6436002)(68736007)(7696005)(53936002)(55016002)(33656002)(25786009)(8936002)(3846002)(6116002)(107886003)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR08MB4241;H:BN7PR08MB5684.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +Vaazy45kVuDhFvVO0byDaeaQEGl0tCpzTSDLqYEQHRyuPi7/fnMtwvJH/tavaiQMa0QpI5ypmnKyia13CfFBKo/3O5+onCWufW/FQMJLJyEIepmX8WTWwRjVTzx05o74oJEZdswUyZi05sv3dWr8qtol5tx0AWUAk2m4Qod65FDSHLUWrhLYm2eBu9A7eLSDyPw02VHwyCcEvM5zwtDBdbCdVlxddbkY4qY7K9gIxvIoxOQhHOPmK9hB6ZGJ5cuQIdLoGgDYJwmlAD4Javn348Z99Xdefz/xzmDtf/h41067+Iv8/eWZxUtW6BVFLRBduPXvwp72jjXycbW6I3+oHJhAWDN9fDNIldxOjVhupMCFl80UeGfuNFL1uiqSONkahnWMzpMhzjGMmRwYSY/ytowWmeC+iQxjyIC+sMo2vQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcbba79-46fd-4fd0-f8f6-08d6f801ab36
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2019 17:38:56.9107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: beanhuo@micron.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4241
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

In the case of UPIU/DME request execution failed in UFS device,
ufs_bsg_request() will complete this failed bsg job by calling
bsg_job_done(). Meanwhile, it returns this error status to blk-mq
layer, then triggers blk-mq completing this request again, this will
cause below panic.

Call trace:
ll_sc___cmpxchg_case_acq_32+0x4/0x20
complete+0x28/0x70
blk_end_sync_rq+0x24/0x30
blk_mq_end_request+0xb8/0x118
bsg_job_put+0x4c/0x58
bsg_complete+0x20/0x30
blk_done_softirq+0xb4/0xe8
do_softirq+0x154/0x3f0
run_ksoftirqd+0x4c/0x68
smpboot_thread_fn+0x22c/0x268
kthread+0x130/0x138
ret_from_fork+0x10/0x1c
Code: f84107fe d65f03c0 d503201f f9800011 (885ffc10)
---[ end trace d92825bff6326e66 ]---
Kernel panic - not syncing: Fatal exception in interrupt

This patch is to fix this issue. The solution is we complete
the ufs-bsg job only if no error happened.

Fixes: df032bf27a41 (scsi: ufs: Add a bsg endpoint that supports UPIUs)
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufs_bsg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufs_bsg.c b/drivers/scsi/ufs/ufs_bsg.c
index f420d6f8d84c..a9344eb4e047 100644
--- a/drivers/scsi/ufs/ufs_bsg.c
+++ b/drivers/scsi/ufs/ufs_bsg.c
@@ -149,7 +149,9 @@ static int ufs_bsg_request(struct bsg_job *job)
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
--=20
2.7.4
