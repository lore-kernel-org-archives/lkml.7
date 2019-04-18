Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828F9C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3862821479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="L8J888o5";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="ktLVH7gh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388226AbfDRINm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:13:42 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:44138 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728074AbfDRINl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:13:41 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3I86SmY012355;
        Thu, 18 Apr 2019 01:13:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=KtOTa/p0+E115o2cU/iT0AWh/84yXJjsxacE0kCsl/g=;
 b=L8J888o54QoYcge9+JvgIO0i3//P1qakxf0nIlQXbcmNm4jVhPDDguq8Sscy7aBbBzZK
 xfVYzrAV53twvcJW5PSYUFYYFrCRIw03mSXu653FFDQBULlpJIE5HcuHIgRI1NPEpOs5
 t1mk69h/j0JiQ17ul70Mu72Yo95u8K/tCTkiAn5rijwidP+q8zVSOHg3VJWtHulJIVti
 5637ZAF9SjpcEb8bFZ2yVvjw8ZYgOcCAdG0g6PRBjN1L/d1MglZDrrBwYiBEKtvNU6wE
 SPpZxpIN9Nw90LiJrGaZZ0fl3b5AELXm2+8V67jc4juswWklDl89Ukt5DdE8aGrxHY6b rw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2rxh890x13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 18 Apr 2019 01:13:37 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 18 Apr
 2019 01:13:36 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.50) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 18 Apr 2019 01:13:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtOTa/p0+E115o2cU/iT0AWh/84yXJjsxacE0kCsl/g=;
 b=ktLVH7ghfTCvmqrRjBymcPiNVrkSQO2mOveo3cwIUNQaKA/NlANsi8Ib0Z+UQwpMjA981FXa8dqLzKSaCuQPphMcgM/lZnBvfGPsxMJpYoLwNciZODx37jyTs6BcNM6HcpZkCZgNaoV4alpd89A0MtV4R27sA3qySTAt7RpfOXs=
Received: from MWHPR18MB1310.namprd18.prod.outlook.com (10.175.6.148) by
 MWHPR18MB1279.namprd18.prod.outlook.com (10.175.6.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Thu, 18 Apr 2019 08:13:34 +0000
Received: from MWHPR18MB1310.namprd18.prod.outlook.com
 ([fe80::e87a:9d71:6000:e9]) by MWHPR18MB1310.namprd18.prod.outlook.com
 ([fe80::e87a:9d71:6000:e9%2]) with mapi id 15.20.1792.020; Thu, 18 Apr 2019
 08:13:34 +0000
From:   Saurav Kashyap <skashyap@marvell.com>
To:     Colin King <colin.king@canonical.com>,
        "QLogic-Storage-Upstream@cavium.com" 
        <QLogic-Storage-Upstream@cavium.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][V2] scsi: qedf: remove memset/memcpy to nfunc and use
 func instead
Thread-Topic: [PATCH][V2] scsi: qedf: remove memset/memcpy to nfunc and use
 func instead
Thread-Index: AQHU8RTwXdQkoj3FSkm+1yAymO4RfaZB9zCA
Date:   Thu, 18 Apr 2019 08:13:34 +0000
Message-ID: <D8DE2F28.187A3%skashyap@marvell.com>
References: <20190412094829.15868-1-colin.king@canonical.com>
In-Reply-To: <20190412094829.15868-1-colin.king@canonical.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cc0ee03-e74f-4d54-af9c-08d6c3d5c0ab
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR18MB1279;
x-ms-traffictypediagnostic: MWHPR18MB1279:
x-microsoft-antispam-prvs: <MWHPR18MB127976A7DBC42DA07912C83CD2260@MWHPR18MB1279.namprd18.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(366004)(396003)(136003)(13464003)(189003)(199004)(8676002)(99286004)(81156014)(36756003)(54906003)(2906002)(81166006)(6246003)(316002)(14444005)(5660300002)(25786009)(110136005)(8936002)(256004)(6436002)(71190400001)(71200400001)(486006)(2616005)(14454004)(229853002)(4326008)(6486002)(476003)(68736007)(446003)(7736002)(66066001)(478600001)(6116002)(6512007)(26005)(11346002)(53546011)(86362001)(6506007)(305945005)(3846002)(76176011)(186003)(53936002)(2501003)(102836004)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR18MB1279;H:MWHPR18MB1310.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2vKWfmDOOau1TgvdWOkjSyyIDoS8rgI9y0qxlk7TAC98AC2NZ5oqKuoQ9tGm1hS3G7NSuk8+J88GrE/+dwqHXGXaVWk/0FV2101QhWM9clOG1kJKMOybF9d1Jjozuw/FpUX1XV8r4rgBTgewZBIR1uUp2Xp49UImDonMx1qPYzz2CWiauMVk3spwN6PEjziUtadbvDs4cogedqdbNqy7lrdNy151HlfyfVU+3MDWkoYT7z9vNvDTbLp5JQ1yn6Ip+uU6lkL6gSoyJTefLHKZt8XBkCpMerR8X6cqxzhdFI4pAuI9dK2tEu8nCCmcTMiaKPpx25X/Dx7A7dGzsd6cOUMwQXjddKiYABpR7EcpKenxHXvCsIBC7NrDXLHYdL1C0Xgw0MZJ3coIx/Z0YsD0BcsHhYmQ/BVmZAj4IzJVSUQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6FE65425F8EB6A4183AA304D1208C5C7@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc0ee03-e74f-4d54-af9c-08d6c3d5c0ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 08:13:34.5589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR18MB1279
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-18_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Colin King <colin.king@canonical.com>
Date: Friday, 12 April 2019 at 3:18 PM
To: <QLogic-Storage-Upstream@cavium.com>, "James E . J . Bottomley"
<jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>,
<linux-scsi@vger.kernel.org>
Cc: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH][V2] scsi: qedf: remove memset/memcpy to nfunc and use
func instead
Resent-From: <Saurav.Kashyap@cavium.com>
Resent-Date: Fri, 12 Apr 2019 02:48:45 -0700

>From: Colin Ian King <colin.king@canonical.com>
>
>Currently the qedf_dbg_* family of functions can overrun the end
>of the source string if it is less than the destination buffer
>length because of the use of a fixed sized memcpy. Remove the
>memset/memcpy calls to nfunc and just use func instead as it
>is always a null terminated string.
>
>Addresses-Coverity: ("Out-of-bounds access")
>Fixes: 61d8658b4a43 ("scsi: qedf: Add QLogic FastLinQ offload FCoE driver
>framework.")
>Signed-off-by: Colin Ian King <colin.king@canonical.com>
>---
>
>V2: replace the V1 strscpy with just using func since this is always
>    going to be a NUL terminated string. Thanks to Rasmus Villemoes for
>    noticing that.
>
>---
> drivers/scsi/qedf/qedf_dbg.c | 32 ++++++++------------------------
> 1 file changed, 8 insertions(+), 24 deletions(-)
>
>diff --git a/drivers/scsi/qedf/qedf_dbg.c b/drivers/scsi/qedf/qedf_dbg.c
>index f2397ee9ba69..f7d170bffc82 100644
>--- a/drivers/scsi/qedf/qedf_dbg.c
>+++ b/drivers/scsi/qedf/qedf_dbg.c
>@@ -15,10 +15,6 @@ qedf_dbg_err(struct qedf_dbg_ctx *qedf, const char
>*func, u32 line,
> {
> 	va_list va;
> 	struct va_format vaf;
>-	char nfunc[32];
>-
>-	memset(nfunc, 0, sizeof(nfunc));
>-	memcpy(nfunc, func, sizeof(nfunc) - 1);
>=20
> 	va_start(va, fmt);
>=20
>@@ -27,9 +23,9 @@ qedf_dbg_err(struct qedf_dbg_ctx *qedf, const char
>*func, u32 line,
>=20
> 	if (likely(qedf) && likely(qedf->pdev))
> 		pr_err("[%s]:[%s:%d]:%d: %pV", dev_name(&(qedf->pdev->dev)),
>-			nfunc, line, qedf->host_no, &vaf);
>+			func, line, qedf->host_no, &vaf);
> 	else
>-		pr_err("[0000:00:00.0]:[%s:%d]: %pV", nfunc, line, &vaf);
>+		pr_err("[0000:00:00.0]:[%s:%d]: %pV", func, line, &vaf);
>=20
> 	va_end(va);
> }
>@@ -40,10 +36,6 @@ qedf_dbg_warn(struct qedf_dbg_ctx *qedf, const char
>*func, u32 line,
> {
> 	va_list va;
> 	struct va_format vaf;
>-	char nfunc[32];
>-
>-	memset(nfunc, 0, sizeof(nfunc));
>-	memcpy(nfunc, func, sizeof(nfunc) - 1);
>=20
> 	va_start(va, fmt);
>=20
>@@ -55,9 +47,9 @@ qedf_dbg_warn(struct qedf_dbg_ctx *qedf, const char
>*func, u32 line,
>=20
> 	if (likely(qedf) && likely(qedf->pdev))
> 		pr_warn("[%s]:[%s:%d]:%d: %pV", dev_name(&(qedf->pdev->dev)),
>-			nfunc, line, qedf->host_no, &vaf);
>+			func, line, qedf->host_no, &vaf);
> 	else
>-		pr_warn("[0000:00:00.0]:[%s:%d]: %pV", nfunc, line, &vaf);
>+		pr_warn("[0000:00:00.0]:[%s:%d]: %pV", func, line, &vaf);
>=20
> ret:
> 	va_end(va);
>@@ -69,10 +61,6 @@ qedf_dbg_notice(struct qedf_dbg_ctx *qedf, const char
>*func, u32 line,
> {
> 	va_list va;
> 	struct va_format vaf;
>-	char nfunc[32];
>-
>-	memset(nfunc, 0, sizeof(nfunc));
>-	memcpy(nfunc, func, sizeof(nfunc) - 1);
>=20
> 	va_start(va, fmt);
>=20
>@@ -84,10 +72,10 @@ qedf_dbg_notice(struct qedf_dbg_ctx *qedf, const char
>*func, u32 line,
>=20
> 	if (likely(qedf) && likely(qedf->pdev))
> 		pr_notice("[%s]:[%s:%d]:%d: %pV",
>-			  dev_name(&(qedf->pdev->dev)), nfunc, line,
>+			  dev_name(&(qedf->pdev->dev)), func, line,
> 			  qedf->host_no, &vaf);
> 	else
>-		pr_notice("[0000:00:00.0]:[%s:%d]: %pV", nfunc, line, &vaf);
>+		pr_notice("[0000:00:00.0]:[%s:%d]: %pV", func, line, &vaf);
>=20
> ret:
> 	va_end(va);
>@@ -99,10 +87,6 @@ qedf_dbg_info(struct qedf_dbg_ctx *qedf, const char
>*func, u32 line,
> {
> 	va_list va;
> 	struct va_format vaf;
>-	char nfunc[32];
>-
>-	memset(nfunc, 0, sizeof(nfunc));
>-	memcpy(nfunc, func, sizeof(nfunc) - 1);
>=20
> 	va_start(va, fmt);
>=20
>@@ -114,9 +98,9 @@ qedf_dbg_info(struct qedf_dbg_ctx *qedf, const char
>*func, u32 line,
>=20
> 	if (likely(qedf) && likely(qedf->pdev))
> 		pr_info("[%s]:[%s:%d]:%d: %pV", dev_name(&(qedf->pdev->dev)),
>-			nfunc, line, qedf->host_no, &vaf);
>+			func, line, qedf->host_no, &vaf);
> 	else
>-		pr_info("[0000:00:00.0]:[%s:%d]: %pV", nfunc, line, &vaf);
>+		pr_info("[0000:00:00.0]:[%s:%d]: %pV", func, line, &vaf);
>=20
> ret:
> 	va_end(va);
>--=20
>2.20.1

Thanks,
Acked-by: Saurav Kashyap <skashyap@marvell.com>


>

