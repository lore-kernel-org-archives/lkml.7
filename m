Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162B5C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20FE2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="qGVvGpJE";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="xdMn0dy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfFNJrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:47:40 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:37010 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727210AbfFNJrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:47:40 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5E9jF5i013167;
        Fri, 14 Jun 2019 02:47:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=HZ07H84ALO8pKP73NIjWsjp2InvcVTFf7+ORLnms1Hw=;
 b=qGVvGpJExqUGKYlg0LKlrY85tZfxKf/1BU5DN+8ixXdT8+mQOew6t8YSTbfGdaYoCwZv
 iuUCv5N8Q88gGPkXvHDhVVPukRh/qiONUJXnPl4Ve5OSX/ACPn2T51SmSeDSA/hSvbCT
 PxXU1WItDxOMpN3AyNBc5HgXQKZLkGVgp+1W06XrYktx2HnMQPpEhYgmJeds6Z56Yy9d
 eEbtmUJHlVzY6Y/EdDla0dbpdUjnSbM95mRiJKX0//p6a07tHWMIU+rBXvsyhuZ1O0W0
 4v6rdd/TQlGNcTp/MpvBIhYrTbhQmSseDCAH1NpYCHG/IjD0LdecZ+oirys8HywMPC7w ow== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2t41j61qcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 14 Jun 2019 02:47:32 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 14 Jun
 2019 02:47:31 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.50) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 14 Jun 2019 02:47:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZ07H84ALO8pKP73NIjWsjp2InvcVTFf7+ORLnms1Hw=;
 b=xdMn0dy/MSei614iurPilBy8Mhsj5inPDQLt4/Kp0uJpLPXZ+PeePb6cNyDjxOROpzOYpsaS18i/0/XdPQz2VCLmNSbMLhaUZbsrT9/cMGqAoeevTA6daU+u+IthOnw9w/AMJc/cR1Ryd+zA7/VJ79acCvJ3Dobxf4AkoR5uSWM=
Received: from MN2PR18MB2527.namprd18.prod.outlook.com (20.179.82.202) by
 MN2PR18MB2591.namprd18.prod.outlook.com (20.179.82.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Fri, 14 Jun 2019 09:47:27 +0000
Received: from MN2PR18MB2527.namprd18.prod.outlook.com
 ([fe80::440b:de1d:b672:2e09]) by MN2PR18MB2527.namprd18.prod.outlook.com
 ([fe80::440b:de1d:b672:2e09%7]) with mapi id 15.20.1987.010; Fri, 14 Jun 2019
 09:47:27 +0000
From:   Saurav Kashyap <skashyap@marvell.com>
To:     Young Xiao <92siuyang@gmail.com>,
        "QLogic-Storage-Upstream@qlogic.com" 
        <QLogic-Storage-Upstream@qlogic.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: bnx2fc: Check if sense buffer has been allocated
 during completion
Thread-Topic: [PATCH] scsi: bnx2fc: Check if sense buffer has been allocated
 during completion
Thread-Index: AQHVIpPIIJXdzJ0nyUOUrUslEmPGh6abQ18A
Date:   Fri, 14 Jun 2019 09:47:26 +0000
Message-ID: <D9296ADB.1A233%skashyap@marvell.com>
References: <1560501397-831-1-git-send-email-92siuyang@gmail.com>
In-Reply-To: <1560501397-831-1-git-send-email-92siuyang@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10fecc79-c60e-4197-5661-08d6f0ad4f65
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2591;
x-ms-traffictypediagnostic: MN2PR18MB2591:
x-microsoft-antispam-prvs: <MN2PR18MB2591B9F7EE1B90CC31508F67D2EE0@MN2PR18MB2591.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(366004)(346002)(13464003)(51914003)(189003)(199004)(446003)(11346002)(68736007)(2616005)(476003)(486006)(66066001)(25786009)(14444005)(76176011)(256004)(99286004)(229853002)(316002)(2906002)(110136005)(8936002)(2201001)(478600001)(86362001)(6436002)(66476007)(81156014)(36756003)(7736002)(6246003)(6512007)(305945005)(2501003)(8676002)(6486002)(76116006)(73956011)(66946007)(91956017)(66446008)(64756008)(66556008)(14454004)(102836004)(6506007)(5660300002)(6116002)(3846002)(53546011)(186003)(26005)(81166006)(53936002)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2591;H:MN2PR18MB2527.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QI+hXr+79uOaO2Yw1HZzlR77+tipSXWM2rrOdXreIGu94o2A5ynONMqXqO5YJUj/gFqcSXwnb+Ftbf8td/ORgbfZH9kNzCKDoEzafVB5C0BFEJbYFRKy3mbTFdQbeheNy46z7FSHTZwLtWRuOkrA7K4ONYcDgbCRXD+EDVnTl61AgKffAEl+aN8mA1AXksHywLK4+N1E9oFiXYstNjOBb3qLPyvaDykq8RPDLCTGmEwhd7c2L3AJ1XVmdB4q5No1WS3We2Kzbx7fnshn1ePs9ssnd7SsSihljG885qcbBH5QEYoCsj1IOpXtoWf/I88lc1dbggvVqGzTqIBMV/IkMhnJm5VtDjxZ1f6Ygqc6IV/+eTZlYWBCPVynyjEZuAwyO6gz2VcD7f/IiK3nLR45c+Exf/TtlKfk9gpmSqKNKJQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <238FE32BDB6C7C4BAEE1507B150D240B@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fecc79-c60e-4197-5661-08d6f0ad4f65
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 09:47:27.0214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: skashyap@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2591
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: <linux-scsi-owner@vger.kernel.org> on behalf of Young Xiao
<92siuyang@gmail.com>
Date: Friday, 14 June 2019 at 2:06 PM
To: "QLogic-Storage-Upstream@qlogic.com"
<QLogic-Storage-Upstream@qlogic.com>, "jejb@linux.ibm.com"
<jejb@linux.ibm.com>, "martin.petersen@oracle.com"
<martin.petersen@oracle.com>, "linux-scsi@vger.kernel.org"
<linux-scsi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
<linux-kernel@vger.kernel.org>
Cc: Young Xiao <92siuyang@gmail.com>
Subject: [PATCH] scsi: bnx2fc: Check if sense buffer has been allocated
during completion

>sc_cmd->sense_buffer is not guaranteed to be allocated so we need to
>sc_cmd->check if the pointer is NULL before trying to copy anything into
>it.
>
>See commit 16a611154dc1 ("scsi: qedf: Check if sense buffer has been
>allocated
>during completion") for details.
>
>Signed-off-by: Young Xiao <92siuyang@gmail.com>
>---
> drivers/scsi/bnx2fc/bnx2fc_io.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/scsi/bnx2fc/bnx2fc_io.c
>b/drivers/scsi/bnx2fc/bnx2fc_io.c
>index 8def63c..44a5e59 100644
>--- a/drivers/scsi/bnx2fc/bnx2fc_io.c
>+++ b/drivers/scsi/bnx2fc/bnx2fc_io.c
>@@ -1789,9 +1789,11 @@ static void bnx2fc_parse_fcp_rsp(struct bnx2fc_cmd
>*io_req,
> 			fcp_sns_len =3D SCSI_SENSE_BUFFERSIZE;
> 		}
>=20
>-		memset(sc_cmd->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
>-		if (fcp_sns_len)
>-			memcpy(sc_cmd->sense_buffer, rq_data, fcp_sns_len);
>+		if (sc_cmd->sense_buffer) {
>+			memset(sc_cmd->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
>+			if (fcp_sns_len)
>+				memcpy(sc_cmd->sense_buffer, rq_data, fcp_sns_len);
>+		}
>=20
> 		/* return RQ entries */
> 		for (i =3D 0; i < num_rq; i++)
>--=20
>2.7.4

Thanks for the patch
Acked-by: Saurav Kashyap <skashyap@marvell.com>

Thanks,
~Saurav
>

