Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB85CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD47621900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YyHb2jvd";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="VegFM5I0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbfDXP4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:56:38 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:52702 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731094AbfDXP4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:56:38 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OFndmL019190;
        Wed, 24 Apr 2019 08:56:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Xa2dPiiwXMz1Gb0mDzME4bEaOTFZpcWKeHFwNIWtnc8=;
 b=YyHb2jvdn9QKo49grlG1SK2cE/mdiWl1KaaouK8boZnUoj9IwLdvkJ7ssYGK9Onimpvc
 zBJMAvhwJ9L07THef88H1SNtDT6Dcz/xJhG7CfDu4z3H+P9xcg7L5m8eVhmW9ozQiCW5
 UhroovSQ4+9twnS6FAYL9NbH8GrpU2ty1rZcoTjRWCrw8tXeNj9qchdqwVr8g4ZQxCsY
 Ul5kxn58DZBFfH07DBAO49iMR5o4BOKDoDODQ+Im0mdKFWlRH7UAslo/lKEJh+e4RKXh
 kSqgUTLiyB5lG3y6dURaTCxXjzWLZj4Thg9dsTRn5ESCrJ/ORiNSBP1RJYT5CMIU1VJy bQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2s2nnjh5x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 24 Apr 2019 08:56:30 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 24 Apr
 2019 08:56:28 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.52) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 24 Apr 2019 08:56:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xa2dPiiwXMz1Gb0mDzME4bEaOTFZpcWKeHFwNIWtnc8=;
 b=VegFM5I0W7hvWVY3R4mXqmvAbdYlv5Daw+VcDxvExPiVSoUPpJZs8rW3F9e3xxwmXyMbx5L5/jX5zZ5cBQ/fSdZc6NKSiC5YbjG445dgXMVsS4cjmxxCOm0gFBfy8HwYZFhcO8TqSmEAwz3didU0PMYRrtvO4+LzuHvxq+ksCYk=
Received: from MN2PR18MB2527.namprd18.prod.outlook.com (20.179.82.202) by
 MN2PR18MB2573.namprd18.prod.outlook.com (20.179.84.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Wed, 24 Apr 2019 15:56:22 +0000
Received: from MN2PR18MB2527.namprd18.prod.outlook.com
 ([fe80::1ca6:aae9:ec4a:d4e7]) by MN2PR18MB2527.namprd18.prod.outlook.com
 ([fe80::1ca6:aae9:ec4a:d4e7%3]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 15:56:22 +0000
From:   Saurav Kashyap <skashyap@marvell.com>
To:     Yue Haibing <yuehaibing@huawei.com>,
        "QLogic-Storage-Upstream@cavium.com" 
        <QLogic-Storage-Upstream@cavium.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH -next] scsi: qedf: remove set but not used variables
Thread-Topic: [PATCH -next] scsi: qedf: remove set but not used variables
Thread-Index: AQHU+eLLAYbZK12h3Uqr02S63kg9Z6ZL1OyA
Date:   Wed, 24 Apr 2019 15:56:22 +0000
Message-ID: <D8E684C7.18978%skashyap@marvell.com>
References: <20190423144138.20428-1-yuehaibing@huawei.com>
In-Reply-To: <20190423144138.20428-1-yuehaibing@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 755d7a05-8f2a-4dfb-7050-08d6c8cd6648
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR18MB2573;
x-ms-traffictypediagnostic: MN2PR18MB2573:
x-microsoft-antispam-prvs: <MN2PR18MB2573A57B069241B41BD39805D23C0@MN2PR18MB2573.namprd18.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(366004)(346002)(13464003)(189003)(199004)(53936002)(71200400001)(6512007)(316002)(54906003)(4326008)(110136005)(6246003)(256004)(14444005)(6436002)(71190400001)(97736004)(305945005)(81166006)(8936002)(68736007)(7736002)(81156014)(8676002)(6486002)(2501003)(14454004)(3846002)(6116002)(76176011)(2906002)(36756003)(478600001)(229853002)(446003)(6506007)(66066001)(73956011)(66946007)(5660300002)(66476007)(2616005)(99286004)(11346002)(91956017)(25786009)(476003)(66446008)(64756008)(66556008)(76116006)(486006)(86362001)(186003)(53546011)(26005)(102836004)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2573;H:MN2PR18MB2527.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: n1G73nBh5A3SYLl7KlQjeDlrrC2rMKHACPH1I9NOgp7p2SD1gy/SWZM8D3e/6Q74zcBZfjXlhZQgFocaP167LKEKH0VnOcvMJtJZjZM4zst9fyEa0LgBYl6QNVRIBmzXKCMS+xWTd5JvavDTOZGHilfceodijLyS/+pMQW3o6Efp3K6TEeQDV8WiOMn9mRuNZRWPf4xieSRSoutJ7cCZt8oJ1OEVA2ZzpZq4wiq0Nkts0yiKhhFx2U20qv3PmkuLJosOxXcDwcXZWghLEC3jMrxjnfa7PyvmjIHPSS/qWVYyBH6FfSsETvjam9B/bcRpaOuwbTyTBdwMLIr1PFXRTGVrdOPITDO0+kG7vDNqsq9/D41yTzJr6k3ZOp86XeyqVyylQC8F/h81nH6bEqHV61cipYcSlXyynrMgCYDpuA8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <688F04A98CCD0149A78E5273B6B00368@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 755d7a05-8f2a-4dfb-7050-08d6c8cd6648
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 15:56:22.4044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2573
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

-----Original Message-----
From: <linux-scsi-owner@vger.kernel.org> on behalf of Yue Haibing
<yuehaibing@huawei.com>
Date: Tuesday, 23 April 2019 at 8:11 PM
To: "QLogic-Storage-Upstream@cavium.com"
<QLogic-Storage-Upstream@cavium.com>, "jejb@linux.ibm.com"
<jejb@linux.ibm.com>, "martin.petersen@oracle.com"
<martin.petersen@oracle.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, YueHaibing
<yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: qedf: remove set but not used variables
Resent-From: <Saurav.Kashyap@cavium.com>
Resent-Date: Tuesday, 23 April 2019 at 8:12 PM

>From: YueHaibing <yuehaibing@huawei.com>
>
>Fixes gcc '-Wunused-but-set-variable' warnings:
>
>drivers/scsi/qedf/qedf_els.c: In function 'qedf_process_els_compl':
>drivers/scsi/qedf/qedf_els.c:149:20: warning: variable 'sc_cmd' set but
>not used [-Wunused-but-set-variable]
>drivers/scsi/qedf/qedf_els.c:148:28: warning: variable 'task_ctx' set but
>not used [-Wunused-but-set-variable]
>drivers/scsi/qedf/qedf_els.c: In function 'qedf_send_srr':
>drivers/scsi/qedf/qedf_els.c:612:6: warning: variable 'sid' set but not
>used [-Wunused-but-set-variable]
>
>They are never used since introduction.
>
>Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>---
> drivers/scsi/qedf/qedf_els.c | 10 +---------
> 1 file changed, 1 insertion(+), 9 deletions(-)
>
>diff --git a/drivers/scsi/qedf/qedf_els.c b/drivers/scsi/qedf/qedf_els.c
>index 1781e73..d900c89e 100644
>--- a/drivers/scsi/qedf/qedf_els.c
>+++ b/drivers/scsi/qedf/qedf_els.c
>@@ -145,9 +145,6 @@ static int qedf_initiate_els(struct qedf_rport
>*fcport, unsigned int op,
> void qedf_process_els_compl(struct qedf_ctx *qedf, struct fcoe_cqe *cqe,
> 	struct qedf_ioreq *els_req)
> {
>-	struct fcoe_task_context *task_ctx;
>-	struct scsi_cmnd *sc_cmd;
>-	uint16_t xid;
> 	struct fcoe_cqe_midpath_info *mp_info;
>=20
> 	QEDF_INFO(&(qedf->dbg_ctx), QEDF_LOG_ELS, "Entered with xid =3D 0x%x"
>@@ -158,10 +155,6 @@ void qedf_process_els_compl(struct qedf_ctx *qedf,
>struct fcoe_cqe *cqe,
> 	/* Kill the ELS timer */
> 	cancel_delayed_work(&els_req->timeout_work);
>=20
>-	xid =3D els_req->xid;
>-	task_ctx =3D qedf_get_task_mem(&qedf->tasks, xid);
>-	sc_cmd =3D els_req->sc_cmd;
>-
> 	/* Get ELS response length from CQE */
> 	mp_info =3D &cqe->cqe_info.midpath_info;
> 	els_req->mp_req.resp_len =3D mp_info->data_placement_size;
>@@ -609,7 +602,7 @@ static int qedf_send_srr(struct qedf_ioreq
>*orig_io_req, u32 offset, u8 r_ctl)
> 	struct qedf_rport *fcport;
> 	struct fc_lport *lport;
> 	struct qedf_els_cb_arg *cb_arg =3D NULL;
>-	u32 sid, r_a_tov;
>+	u32 r_a_tov;
> 	int rc;
>=20
> 	if (!orig_io_req) {
>@@ -635,7 +628,6 @@ static int qedf_send_srr(struct qedf_ioreq
>*orig_io_req, u32 offset, u8 r_ctl)
>=20
> 	qedf =3D fcport->qedf;
> 	lport =3D qedf->lport;
>-	sid =3D fcport->sid;
> 	r_a_tov =3D lport->r_a_tov;
>=20
> 	QEDF_INFO(&(qedf->dbg_ctx), QEDF_LOG_ELS, "Sending SRR orig_io=3D%p, "
>--=20
>2.7.0

Thanks,
Acked-by: Saurav Kashyap <skashyap@marvell.com>
>
>

