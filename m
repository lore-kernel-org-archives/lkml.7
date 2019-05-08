Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8258AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA2B21479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="C5sNLivw";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="gmjFxs6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfEHI42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:56:28 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:35876 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbfEHI41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:56:27 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x488orBO015373;
        Wed, 8 May 2019 01:56:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=0kNdc5bsJDd8lcNUq0d71aKDUe7atUQ5nsvzFriQjbk=;
 b=C5sNLivwV1t0ocEqBh1aGV9cYG6oljNYDKsbmhcK5IfUjWvf5fNHdIqsOwWDQpBzNTXW
 1M9+bkNdpcCz5D61z+K2L8DaaC+xy5w0RfqONHCrIhAWYSNYAzzfMxa9/q0y1eA5vcyo
 OnJmNg6MuLLsgPAX1O3qe2LkCgEWXE8y+8sFoEKyfss/e9ZweDfgqfXqhMkgOuxMN2Gq
 wcINDJRciKMNyFwJnfGmuDDh5u/cDR3x0bRzFTgPxi21xlE+qcNwna0D9u8v/LHoseWo
 2O9vtfJpYLp57ImGYsiYetlSYedCmOyDmGN7EcMnWSbIa+0ZTbpDsy02UdgRcIpnM20N cA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2sbgjbb0qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 08 May 2019 01:56:22 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 8 May
 2019 01:56:21 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.55) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 8 May 2019 01:56:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kNdc5bsJDd8lcNUq0d71aKDUe7atUQ5nsvzFriQjbk=;
 b=gmjFxs6mvgPcTOQAI3U97uphFpwzgQbzMYZMPiv9J9za837200Qpgs12rHpWAbHNH3T95koKMSO5vc1q1QDa49nAGK8sJqvs3obfuq1yTFucFk9xBDr7u4twGZaPhrwAq0ErWR9ap8u6FvTqNP1eEd/28p/cJ3ajKM0WCVaIqS4=
Received: from MN2PR18MB2527.namprd18.prod.outlook.com (20.179.82.202) by
 MN2PR18MB2893.namprd18.prod.outlook.com (20.179.22.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Wed, 8 May 2019 08:56:17 +0000
Received: from MN2PR18MB2527.namprd18.prod.outlook.com
 ([fe80::1ca6:aae9:ec4a:d4e7]) by MN2PR18MB2527.namprd18.prod.outlook.com
 ([fe80::1ca6:aae9:ec4a:d4e7%3]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 08:56:17 +0000
From:   Saurav Kashyap <skashyap@marvell.com>
To:     Colin King <colin.king@canonical.com>,
        "QLogic-Storage-Upstream@qlogic.com" 
        <QLogic-Storage-Upstream@qlogic.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: bnx2fc: fix incorrect cast to u64 on shift
 operation
Thread-Topic: [PATCH] scsi: bnx2fc: fix incorrect cast to u64 on shift
 operation
Thread-Index: AQHVApk55OnNuhA+90ehxt2QaOq1PKZhTrgA
Date:   Wed, 8 May 2019 08:56:17 +0000
Message-ID: <D8F89753.18F6C%skashyap@marvell.com>
References: <20190504164829.26631-1-colin.king@canonical.com>
In-Reply-To: <20190504164829.26631-1-colin.king@canonical.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ebc7e49-a0b9-45d0-8c6f-08d6d393084e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR18MB2893;
x-ms-traffictypediagnostic: MN2PR18MB2893:
x-microsoft-antispam-prvs: <MN2PR18MB28930503536D0CEBABBD4845D2320@MN2PR18MB2893.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(376002)(396003)(39850400004)(199004)(189003)(13464003)(51914003)(86362001)(305945005)(71200400001)(71190400001)(53546011)(64756008)(76176011)(316002)(6506007)(6246003)(2501003)(54906003)(81166006)(53936002)(26005)(7736002)(446003)(5660300002)(81156014)(186003)(8676002)(110136005)(6512007)(8936002)(6436002)(36756003)(91956017)(11346002)(73956011)(486006)(66066001)(6486002)(66476007)(14454004)(66446008)(76116006)(66556008)(66946007)(99286004)(68736007)(229853002)(25786009)(478600001)(2906002)(4326008)(2616005)(14444005)(476003)(3846002)(6116002)(256004)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2893;H:MN2PR18MB2527.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: obSBiAtQgzQ0/Z4tHh+cx0qQ3QEYAF/IOF7H6zwwlgn/lMNue/Dpdr/O+obINPziKKrbtwmj88XIlJPcGjz9hb5jpcgitgH6oumvbOLpJAuQdk1Q7tKNmBnTAP26fSFHVNyWpiGEsjuMJA4XI/02ArdBvo8SNUR7CN1awSEfCwi9Kgi9Qnk9ayGerrhD6Y7XZQpGUWfnCkZpAEXhGeEPU/tdOJqHgpnIOEsEdFRzRwtTxHgfKSW5Tr4RAeOhYMhBl2fEctaly1rzOXb4dZw3IkfwZJrSDBdcHIWP6CVk6dqpp/17q1DBW6S8vtkStMJQhdyyMF7EyM/TEQLLakLDkBov5nF6v7naWPbPVTZ3UjqfkR1RsUT0rAX2ZGiIuOEslClaoD2pbzD5aRQe7hjkDFCAh4gUJWdJoAm7npRrmck=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7736346B17E9C5488A89DB364FC4654D@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebc7e49-a0b9-45d0-8c6f-08d6d393084e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 08:56:17.0751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2893
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-08_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: <linux-scsi-owner@vger.kernel.org> on behalf of Colin King
<colin.king@canonical.com>
Date: Saturday, 4 May 2019 at 10:18 PM
To: "QLogic-Storage-Upstream@qlogic.com"
<QLogic-Storage-Upstream@qlogic.com>, "James E . J . Bottomley"
<jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>,
"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] scsi: bnx2fc: fix incorrect cast to u64 on shift operation

>From: Colin Ian King <colin.king@canonical.com>
>
>Currently an int is being shifted and the result is being cast to a u64
>which leads to undefined behaviour if the shift is more than 31 bits. Fix
>this by casting the integer value 1 to u64 before the shift operation.
>
>Addresses-Coverity: ("Bad shift operation")
>Fixes: 7b594769120b ("[SCSI] bnx2fc: Handle REC_TOV error code from
>firmware")
>Signed-off-by: Colin Ian King <colin.king@canonical.com>
>---
> drivers/scsi/bnx2fc/bnx2fc_hwi.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/scsi/bnx2fc/bnx2fc_hwi.c
>b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
>index 19734ec7f42e..747f019fb393 100644
>--- a/drivers/scsi/bnx2fc/bnx2fc_hwi.c
>+++ b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
>@@ -830,7 +830,7 @@ static void bnx2fc_process_unsol_compl(struct
>bnx2fc_rport *tgt, u16 wqe)
> 			((u64)err_entry->data.err_warn_bitmap_hi << 32) |
> 			(u64)err_entry->data.err_warn_bitmap_lo;
> 		for (i =3D 0; i < BNX2FC_NUM_ERR_BITS; i++) {
>-			if (err_warn_bit_map & (u64) (1 << i)) {
>+			if (err_warn_bit_map & ((u64)1 << i)) {
> 				err_warn =3D i;
> 				break;
> 			}
>--=20
>2.20.1

Thanks for the Patch.

Acked-by: Saurav Kashyap <skashyap@marvell.com>

>

