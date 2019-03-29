Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FABC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42262206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="yzC+4iVu";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="FNc9SvXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfC2ENW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 00:13:22 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:50500 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725385AbfC2ENV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 00:13:21 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2T49cEK008421;
        Thu, 28 Mar 2019 21:13:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=wUo1GKehTrZrHe6VYsO4u2luHJd+ImdqXBa3gSRurx4=;
 b=yzC+4iVuDYWQYkS3C7hgzgqmSXmeFZMp32ufv7aYl5XupFoEUa+mXSLcZAJWLzd9ggv4
 n4dFZut6AJp02xGPhqALTS4FGaJdksf4d6E2KjCyzTgQi3TL7mKZnW/PVVsdnLkjO4im
 4uTaWGH3m7VEDOds2Aua1oTZhzv3AtShwXEAd4Z0g3MsUgxC88s265fKp4W2D1O7tWh5
 JXhHsubsdnfRO5SXowD/R1fYbpvipU52A7Fq4thLToktYs9w0ZUH5eI8xXsy0hbhvkga
 1tFLA+P8t6Divg3alp8kJXGQbGzu9ghe8Me6G8ILuo76Svzfq/7qOAHvWRvUOCOIaX1N Jg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2rhapj85p3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 28 Mar 2019 21:13:13 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 28 Mar
 2019 21:13:01 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.53) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 28 Mar 2019 21:13:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUo1GKehTrZrHe6VYsO4u2luHJd+ImdqXBa3gSRurx4=;
 b=FNc9SvXx+WkInTb/gXj1wZs5J6uVCD/MjQG+jpIn4kscWARCSE+vyKV6KbVZmF9j83LP1skTYCUtXhmegGn3ZCPF8CtkKJ4MqDUN1HG3Kj3KYQq6p4FCUEwlcPw4RxPSxyF0mFGpY5OABBHO0Mt4F/We/OA9+6a0WrHpuYbUcN4=
Received: from BYAPR18MB2485.namprd18.prod.outlook.com (20.179.92.143) by
 BYAPR18MB2871.namprd18.prod.outlook.com (20.179.58.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Fri, 29 Mar 2019 04:13:00 +0000
Received: from BYAPR18MB2485.namprd18.prod.outlook.com
 ([fe80::2d57:671d:82c7:14e0]) by BYAPR18MB2485.namprd18.prod.outlook.com
 ([fe80::2d57:671d:82c7:14e0%4]) with mapi id 15.20.1730.019; Fri, 29 Mar 2019
 04:13:00 +0000
From:   Manish Rangankar <mrangankar@marvell.com>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>,
        "QLogic-Storage-Upstream@qlogic.com" 
        <QLogic-Storage-Upstream@qlogic.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: bnx2fc: remove unneeded variable
Thread-Topic: [PATCH] scsi: bnx2fc: remove unneeded variable
Thread-Index: AQHU5d8EVwTq6D948k+hP2xl0Kz9z6Yh/1Hg
Date:   Fri, 29 Mar 2019 04:13:00 +0000
Message-ID: <BYAPR18MB2485B5A8C2997C9075E3454CD85A0@BYAPR18MB2485.namprd18.prod.outlook.com>
References: <1553829852-16525-1-git-send-email-dingxiang@cmss.chinamobile.com>
In-Reply-To: <1553829852-16525-1-git-send-email-dingxiang@cmss.chinamobile.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [115.113.156.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abef1a81-a0ee-4e03-8f31-08d6b3fcd4c7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR18MB2871;
x-ms-traffictypediagnostic: BYAPR18MB2871:
x-microsoft-antispam-prvs: <BYAPR18MB28719443CCD32FE65189B388D85A0@BYAPR18MB2871.namprd18.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39850400004)(396003)(376002)(136003)(346002)(13464003)(199004)(189003)(4326008)(81166006)(68736007)(8676002)(7696005)(81156014)(6506007)(26005)(9686003)(53936002)(486006)(446003)(71200400001)(8936002)(54906003)(99286004)(316002)(53546011)(76176011)(110136005)(6246003)(106356001)(55236004)(105586002)(55016002)(476003)(71190400001)(186003)(2201001)(6116002)(33656002)(86362001)(66066001)(3846002)(11346002)(305945005)(7736002)(74316002)(478600001)(97736004)(102836004)(52536014)(229853002)(5660300002)(6436002)(2906002)(256004)(25786009)(2501003)(14454004)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2871;H:BYAPR18MB2485.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YtIG9duqjSTbP5R8v0cfaazDDIJECuKc+gQ0c/MM0HcS7xJDg4mi8hGUofgQ8FOhFLQ97WELoofbF3k5kLJMyrMJIv3+qJI7MmewzmQxvp5fgeyoX9nIsWcbIZvCmHkh0xPZXMiMry2pXuZ9HPkSX064DPtMlmhSY3Qn32jsRBSWl6UdewPPKHHKOgS3WRrAqNUxxkqqmtu1VGH3t28655cfM3uS3JBqmi92mDyYOe4w1W1iJkQdgG0fE6KF2fYyHJ9gkKw18z7ZulOC6nA1fnqw+5NwyIX1oBLjM3vfTQAi19/+9+B51G9ImwssubB/tKO8RWYOEa+jeZiuL+IDmUvrfgSbynd+fGexZUy9G+lRP/+K07sEBB0fp8crqfwnHxSNJVE+GxK/R2VgiOMSjtFac8UUiYqDBHrsSwRMbYY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: abef1a81-a0ee-4e03-8f31-08d6b3fcd4c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 04:13:00.0981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2871
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Ding Xiang <dingxiang@cmss.chinamobile.com>
> Sent: Friday, March 29, 2019 8:54 AM
> To: QLogic-Storage-Upstream@qlogic.com; jejb@linux.ibm.com;
> martin.petersen@oracle.com
> Cc: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] scsi: bnx2fc: remove unneeded variable
>=20
> "rc" is unneeded,just return SUCCESS
>=20
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>  drivers/scsi/bnx2fc/bnx2fc_io.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/scsi/bnx2fc/bnx2fc_io.c
> b/drivers/scsi/bnx2fc/bnx2fc_io.c index bc9f2a2..8def63c 100644
> --- a/drivers/scsi/bnx2fc/bnx2fc_io.c
> +++ b/drivers/scsi/bnx2fc/bnx2fc_io.c
> @@ -1083,7 +1083,6 @@ int bnx2fc_eh_device_reset(struct scsi_cmnd
> *sc_cmd)  static int bnx2fc_abts_cleanup(struct bnx2fc_cmd *io_req)  {
>  	struct bnx2fc_rport *tgt =3D io_req->tgt;
> -	int rc =3D SUCCESS;
>  	unsigned int time_left;
>=20
>  	io_req->wait_for_comp =3D 1;
> @@ -1110,7 +1109,7 @@ static int bnx2fc_abts_cleanup(struct
> bnx2fc_cmd *io_req)
>  	kref_put(&io_req->refcount, bnx2fc_cmd_release);
>=20
>  	spin_lock_bh(&tgt->tgt_lock);
> -	return rc;
> +	return SUCCESS;
>  }
>=20
>  /**
> --
> 1.9.1
>=20

Thanks,
Acked-by: Manish Rangankar <mrangankar@marvell.com>

