Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A3CC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 05:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219A82175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 05:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AvlL+Hws";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="IuPvjitV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfEJF2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 01:28:34 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:35370 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726284AbfEJF2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 01:28:33 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4A5JucC001987;
        Thu, 9 May 2019 22:28:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=yRSAAZ8zPYOyWv2F38sqsFclOq54MU1hjJ5zncj5hcI=;
 b=AvlL+Hws3YGPHOBGDlg8uUqDn6VFbCnhcCAtY6dLlFlffvstwO8neqf3Rsd18gsu2Rmm
 kvgS7s+ihGIxpxbcQeODeTtbPe24VG1iyJuROLxJfyXTWnhmITcPcQg/ci0gSrU/LV7+
 lGWmF8KRLqHOjvbb7yAYSZ3AnCuUc5TglGY/F3mRjzXzgpTQumnaFEHtTDxA7MwXrxxX
 1nvD7M0ab2Gn8La9A/QNTKfpXahXUuCgIuXa2x23hy14GYWvOuiJiOc/dZ38XpT6oTSy
 jAJ+v7QXzpeobbVsMqvI4cf6phk7VIVVqrmQlwPQX5OiSm1QwcQPxeJ6gm5cCLjHpV7S PQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2sd0p30ma7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 09 May 2019 22:28:26 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 9 May
 2019 22:28:24 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.56) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 9 May 2019 22:28:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRSAAZ8zPYOyWv2F38sqsFclOq54MU1hjJ5zncj5hcI=;
 b=IuPvjitVurljc3S9vSeKePMJENI+jI40ihv5cNELJ5wlSFGazPdWh9IuvvxC+U9lSX7LK7Rdtq1fyBOuCEsr9PYEv0VlLB8mmQjEThXOqSEFBEzawYu/daauuhjUic/Hz19YsArZDzjWk8B8i97e7AQZ7rnxoK2KYf+Kmks4lOA=
Received: from BYAPR18MB2485.namprd18.prod.outlook.com (20.179.92.143) by
 BYAPR18MB2887.namprd18.prod.outlook.com (20.179.58.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Fri, 10 May 2019 05:28:19 +0000
Received: from BYAPR18MB2485.namprd18.prod.outlook.com
 ([fe80::c974:8e88:5b70:fcfc]) by BYAPR18MB2485.namprd18.prod.outlook.com
 ([fe80::c974:8e88:5b70:fcfc%5]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 05:28:19 +0000
From:   Manish Rangankar <mrangankar@marvell.com>
To:     Yue Haibing <yuehaibing@huawei.com>,
        "QLogic-Storage-Upstream@cavium.com" 
        <QLogic-Storage-Upstream@cavium.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH -next] scsi: qedi: remove set but not used variables
 'cdev' and 'udev'
Thread-Topic: [PATCH -next] scsi: qedi: remove set but not used variables
 'cdev' and 'udev'
Thread-Index: AQHU+nQ89AUI/NIlBkC1079Ec+hhQaZj7UWg
Date:   Fri, 10 May 2019 05:28:18 +0000
Message-ID: <BYAPR18MB248596EAD386EC09F380162DD80C0@BYAPR18MB2485.namprd18.prod.outlook.com>
References: <20190424080256.30012-1-yuehaibing@huawei.com>
In-Reply-To: <20190424080256.30012-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80582d1a-d818-46c5-b337-08d6d5084f93
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR18MB2887;
x-ms-traffictypediagnostic: BYAPR18MB2887:
x-microsoft-antispam-prvs: <BYAPR18MB2887086E43D2BF2DB5B7810CD80C0@BYAPR18MB2887.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:74;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(376002)(39860400002)(346002)(13464003)(189003)(199004)(110136005)(54906003)(446003)(73956011)(76116006)(66946007)(229853002)(26005)(478600001)(256004)(305945005)(2906002)(186003)(71190400001)(14444005)(66066001)(99286004)(3846002)(52536014)(6116002)(5660300002)(71200400001)(66476007)(66556008)(64756008)(66446008)(25786009)(2201001)(9686003)(86362001)(6436002)(7696005)(486006)(81156014)(476003)(76176011)(14454004)(68736007)(11346002)(81166006)(8676002)(2501003)(7736002)(33656002)(6506007)(316002)(55016002)(53936002)(102836004)(53546011)(6246003)(74316002)(8936002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2887;H:BYAPR18MB2485.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2Tw1GXc/I6GP6qwjlQZTplA+sKnK45YBqjV5wgFWrqMXVRYW3EtNh+IXbTf0RBKFb6Pc4nVu9jwsdE3OzTS9PIw++YTCDj9YdVEOr8OZjo3E0MM7zCLJIq/zbwbuX7iXQqJxdpk3tVmeqOpMtlmFjj2tmCoyeK14rE3qq6OL0tK0gt/H7F0VrFP5W8bwTA34FZQQEcw6SZejI+g14AhjLD4K9UL/UaM0Uj+kGmqvK+BQAEYUR2nh2C1SD1n06mS0K1QhooqR/+3E85d8qsvonBKwTEDZc1AF2G26mz0IGta/F0VlkUtl7j3EMfSjsWOY9vk6KIMYLReybzb3oVD0nBzBJBKy5OaFQc24XJE3SCS0fWDyUVE0UuX76pVYLqggkSJ3p4MgNQNjEvNU1UkHMH5ffmzhslGLsZw3h1yAkB4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 80582d1a-d818-46c5-b337-08d6d5084f93
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 05:28:18.9379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2887
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: linux-scsi-owner@vger.kernel.org <linux-scsi-
> owner@vger.kernel.org> On Behalf Of Yue Haibing
> Sent: Wednesday, April 24, 2019 1:33 PM
> To: QLogic-Storage-Upstream@cavium.com; jejb@linux.ibm.com;
> martin.petersen@oracle.com
> Cc: linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org; YueHaibing
> <yuehaibing@huawei.com>
> Subject: [PATCH -next] scsi: qedi: remove set but not used variables 'cde=
v'
> and 'udev'
>=20
> From: YueHaibing <yuehaibing@huawei.com>
>=20
> Fixes gcc '-Wunused-but-set-variable' warning:
>=20
> drivers/scsi/qedi/qedi_iscsi.c: In function 'qedi_ep_connect':
> drivers/scsi/qedi/qedi_iscsi.c:813:23: warning: variable 'udev' set but n=
ot
> used [-Wunused-but-set-variable]
> drivers/scsi/qedi/qedi_iscsi.c:812:18: warning: variable 'cdev' set but n=
ot
> used [-Wunused-but-set-variable]
>=20
> They are never used since introduction.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/scsi/qedi/qedi_iscsi.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/scsi/qedi/qedi_iscsi.c b/drivers/scsi/qedi/qedi_iscs=
i.c
> index e4391ee..688a6d8 100644
> --- a/drivers/scsi/qedi/qedi_iscsi.c
> +++ b/drivers/scsi/qedi/qedi_iscsi.c
> @@ -809,8 +809,6 @@ qedi_ep_connect(struct Scsi_Host *shost, struct
> sockaddr *dst_addr,
>  	struct qedi_endpoint *qedi_ep;
>  	struct sockaddr_in *addr;
>  	struct sockaddr_in6 *addr6;
> -	struct qed_dev *cdev  =3D  NULL;
> -	struct qedi_uio_dev *udev =3D NULL;
>  	struct iscsi_path path_req;
>  	u32 msg_type =3D ISCSI_KEVENT_IF_DOWN;
>  	u32 iscsi_cid =3D QEDI_CID_RESERVED;
> @@ -830,8 +828,6 @@ qedi_ep_connect(struct Scsi_Host *shost, struct
> sockaddr *dst_addr,
>  	}
>=20
>  	qedi =3D iscsi_host_priv(shost);
> -	cdev =3D qedi->cdev;
> -	udev =3D qedi->udev;
>=20
>  	if (test_bit(QEDI_IN_OFFLINE, &qedi->flags) ||
>  	    test_bit(QEDI_IN_RECOVERY, &qedi->flags)) {
> --
> 2.7.4
>=20

Thanks,

Acked-by: Manish Rangankar <mrangankar@marvell.com>
