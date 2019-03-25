Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E428DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7802054F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="t91zf0om";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="q7EkP8lP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbfCYGYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:24:00 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:40646 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729649AbfCYGX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:23:59 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2P653X2012655;
        Sun, 24 Mar 2019 23:18:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=jhzaxAvEwqJcFy9G12QhC6WBCzK9ae0DJCO4aE5Uals=;
 b=t91zf0om1KeSRVfyGFlzdHNX6sEZTOvWaumctdjqCLjhNgaywc1odBL5LqGEpFccGpN8
 vRSBV85GfDzNoY7SVNqT9AS81z/HwziUuWksmvH+u7ls0K4nwzRsgWKzJ7jugrbPOdS3
 1bD8iUfPev7mSO8twtrA3i8V9ZjUFAB37jV0rfEPac+tgomBJeoUcA87yPQm/9YU96AD
 xwFabjQQQPVV5XCv4Q3/63K64jO6/EDndsH63wJuYRTHKhGxa9QuW/grgGFIbcOlEpdO
 JeT7z2nz1DxMR7hla32OXQeWgNiazCP+JfsxGK9W3kwn6ygPsR6io0aDQKv7xttfptb1 Kw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2rem8egkug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 24 Mar 2019 23:18:47 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 24 Mar
 2019 23:18:35 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.52) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 24 Mar 2019 23:18:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhzaxAvEwqJcFy9G12QhC6WBCzK9ae0DJCO4aE5Uals=;
 b=q7EkP8lPwjAFwBv0b73yAr+wHBm+P7aYYqe1cm5drk+g0HQQzzHDN2fH2SsRKOUHP1yi+H0oHLPtNx3J3MNk1Wgwk6G4B56aWYpcMtGLO2GctRg0uT7CRudz9xjpqLlJYBz01wV54pxKqIdSl14VEZC3en5VLLImx3LeGSkMaUo=
Received: from BYAPR18MB2485.namprd18.prod.outlook.com (20.179.92.143) by
 BYAPR18MB2677.namprd18.prod.outlook.com (20.179.94.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 06:18:31 +0000
Received: from BYAPR18MB2485.namprd18.prod.outlook.com
 ([fe80::2d57:671d:82c7:14e0]) by BYAPR18MB2485.namprd18.prod.outlook.com
 ([fe80::2d57:671d:82c7:14e0%4]) with mapi id 15.20.1730.017; Mon, 25 Mar 2019
 06:18:30 +0000
From:   Manish Rangankar <mrangankar@marvell.com>
To:     Kangjie Lu <kjlu@umn.edu>
CC:     "pakki001@umn.edu" <pakki001@umn.edu>,
        "QLogic-Storage-Upstream@qlogic.com" 
        <QLogic-Storage-Upstream@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: qla4xxx: fix a potential NULL pointer dereference
Thread-Topic: [PATCH] scsi: qla4xxx: fix a potential NULL pointer dereference
Thread-Index: AQHU2i+KpmB/z0aEeESzxgiymI8cpaYb8Jcw
Date:   Mon, 25 Mar 2019 06:18:30 +0000
Message-ID: <BYAPR18MB24857ABD5DDE4D62E35F9C6DD85E0@BYAPR18MB2485.namprd18.prod.outlook.com>
References: <20190314063100.12805-1-kjlu@umn.edu>
In-Reply-To: <20190314063100.12805-1-kjlu@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9472fc80-1ad9-402f-584d-08d6b0e9b3c4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR18MB2677;
x-ms-traffictypediagnostic: BYAPR18MB2677:
x-microsoft-antispam-prvs: <BYAPR18MB26774F3BFDA2B580EE7DA031D85E0@BYAPR18MB2677.namprd18.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(346002)(376002)(366004)(136003)(13464003)(189003)(199004)(476003)(305945005)(7696005)(3846002)(7736002)(6116002)(4326008)(11346002)(68736007)(53546011)(102836004)(6506007)(97736004)(71190400001)(86362001)(14454004)(25786009)(486006)(54906003)(5660300002)(74316002)(229853002)(446003)(33656002)(2906002)(105586002)(52536014)(106356001)(53936002)(66066001)(6436002)(8936002)(478600001)(55016002)(316002)(9686003)(26005)(2171002)(8676002)(99286004)(256004)(14444005)(186003)(6246003)(71200400001)(76176011)(81156014)(81166006)(6916009)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2677;H:BYAPR18MB2485.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IDM9CjcogkZyG/CHuKwO398jxBBfhyUV2aEmcQqAZblBKrOhQYMX2DdWQaaZDwM0M9vdvD45PaKr9q1IkhUHzqVAJZTdKyYsKZ3Xxt9gbNOb9BOuKgzPwC6bMAxsZjCzONyr+Y81auJR9upiNMZQpv03+Pn6bKT9t2RFVc4ocn6c+bfwW13RhZg5Ahp3kmkdD+aixTjZQzSn8/HOTdW69h8aSPXDe1WNPiw9nLvg8Sv0YzTWaTR+Q+3y6mpMUraS3sSefiSqh0Yusj2w7NwkXOBgAut+eM+Voa0gAhEzZPibxOwFPVNnAV478bXCi1e9gCe7YoLtZfkuhczjEH2UPQ3EXKjUlffKmJsvMDqrM67y3ajw+eqgnXyuDxRJP2stpqEc+IO+HyNMTyZuAHPEdc0sdbkrKoSZpBOp9JzdVzM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9472fc80-1ad9-402f-584d-08d6b0e9b3c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 06:18:30.8180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2677
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-scsi-owner@vger.kernel.org <linux-scsi-
> owner@vger.kernel.org> On Behalf Of Kangjie Lu
> Sent: Thursday, March 14, 2019 12:01 PM
> To: kjlu@umn.edu
> Cc: pakki001@umn.edu; QLogic-Storage-Upstream@qlogic.com; James E.J.
> Bottomley <jejb@linux.ibm.com>; Martin K. Petersen
> <martin.petersen@oracle.com>; linux-scsi@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] scsi: qla4xxx: fix a potential NULL pointer dereference
>=20
> In case iscsi_lookup_endpoint fails, the fix returns -EINVAL to avoid NUL=
L
> pointer dereference.
>=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/scsi/qla4xxx/ql4_os.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.=
c
> index a77bfb224248..80289c885c07 100644
> --- a/drivers/scsi/qla4xxx/ql4_os.c
> +++ b/drivers/scsi/qla4xxx/ql4_os.c
> @@ -3203,6 +3203,8 @@ static int qla4xxx_conn_bind(struct
> iscsi_cls_session *cls_session,
>  	if (iscsi_conn_bind(cls_session, cls_conn, is_leading))
>  		return -EINVAL;
>  	ep =3D iscsi_lookup_endpoint(transport_fd);
> +	if (!ep)
> +		return -EINVAL;
>  	conn =3D cls_conn->dd_data;
>  	qla_conn =3D conn->dd_data;
>  	qla_conn->qla_ep =3D ep->dd_data;
> --
> 2.17.1

Thanks
Acked-by: Manish Rangankar <mrangankar@marvell.com>

