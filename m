Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABADC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F70620665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="g0Wjrn9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfGOLVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 07:21:15 -0400
Received: from mail-eopbgr690065.outbound.protection.outlook.com ([40.107.69.65]:44809
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729725AbfGOLVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 07:21:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2irg275mXbyY+qyD20TrL1+9yzRozs0G+f8AXB03tLqkjffWJjtww/Be2u8fa1akr5H0rTmsHY2k3bgNrv1Si3vjuZDvwuHRC9Vk4AAieBd4eBHOLdOP3qlpCwprAUiK6swJ+M7XqhZhXbHEPprZnyZQvINyr1UiVIHGPpYdQguDn7nDZZAnKpooTBnREGJq5mvOGaUx9UZSN+tJ3jQEaxdIUFsNfKYfp93FJBv9OwZjvBVvVT86jxgtky++oofEHPXgFh9/n9EV8UaOKiRjWwcO+AqVdNEPrSILHGJ4oxYPTnG4z1CBOIQO050iRCXXJV1AYud6Z0gI6flbg/arg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueINqPcjsCE7QkODuQ1kPZ2NcIEokpUM7jiUD5D0L8E=;
 b=lgqsYO0C6Dunmg8h2WSgcN/luor2k2qJGePcjzHnzsiALFkuxH9qsXmFwPKXAIKBZezehj7jgsX6eCvAsOmRMJs6QHwgyg/AdNH8qOktvjYP7hs7WsQ6W2LiDxNd8Mb45m/gu4TpgiJylOWbtRzKvnmTGGFXbNL6rkTwpJmtt7E4+hH/471z7Gsjt0l8nk7Z4ujDdquP7PDfLXkMHTjdCo7bBTzldxup6umachb60rkaCo5N355iSLmbCyyf0HnXIGEBNAuQWTWgt4JrSne/fCZmRYRjovlIXewz45y2DYN0DsdMOqq+MDwyBGSt2nat2xRkwTF1dxmu7Q7qp4v4PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=micron.com;dmarc=pass action=none
 header.from=micron.com;dkim=pass header.d=micron.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueINqPcjsCE7QkODuQ1kPZ2NcIEokpUM7jiUD5D0L8E=;
 b=g0Wjrn9rjgoc6eEqwFv7FQDmEzFeJizW7v+rF3D2E0CFnpxxfWNYmWnz+9tZ18m0ukoKZRIHDwJeg3OhI3FB3FrU8y+SiRKZ+IzDLdHVhzAYBzp84qsfqv5BtzOemGR/hy44ebS8Ghou9QlVATrz/zaQN2+FWb0I7szwZWxkxJA=
Received: from BN7PR08MB5684.namprd08.prod.outlook.com (20.176.31.141) by
 BN7PR08MB4306.namprd08.prod.outlook.com (52.135.250.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Mon, 15 Jul 2019 11:21:11 +0000
Received: from BN7PR08MB5684.namprd08.prod.outlook.com
 ([fe80::4dd2:da15:6626:c3b0]) by BN7PR08MB5684.namprd08.prod.outlook.com
 ([fe80::4dd2:da15:6626:c3b0%3]) with mapi id 15.20.2073.012; Mon, 15 Jul 2019
 11:21:10 +0000
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
Subject: [PATCH v1] scsi: ufs: change msleep to usleep_range
Thread-Topic: [PATCH v1] scsi: ufs: change msleep to usleep_range
Thread-Index: AdU6/zmiJJopDFlPQEeuzjc9BNSdLA==
Date:   Mon, 15 Jul 2019 11:21:10 +0000
Message-ID: <BN7PR08MB5684BBB44FD0E43501558A20DBCF0@BN7PR08MB5684.namprd08.prod.outlook.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=beanhuo@micron.com; 
x-originating-ip: [195.89.176.137]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c758cdd-945a-43ae-de88-08d709168a3d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN7PR08MB4306;
x-ms-traffictypediagnostic: BN7PR08MB4306:|BN7PR08MB4306:
x-microsoft-antispam-prvs: <BN7PR08MB430626C76754720025C4333DDBCF0@BN7PR08MB4306.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(199004)(189003)(478600001)(52536014)(256004)(26005)(8676002)(53936002)(74316002)(81156014)(476003)(5660300002)(14454004)(55016002)(6506007)(4326008)(66066001)(86362001)(7736002)(68736007)(99286004)(186003)(9686003)(66446008)(64756008)(66556008)(8936002)(66476007)(71190400001)(71200400001)(76116006)(66946007)(3846002)(6116002)(25786009)(102836004)(81166006)(110136005)(2906002)(6436002)(316002)(54906003)(33656002)(305945005)(486006)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR08MB4306;H:BN7PR08MB5684.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GsvvFGNR5//LsuUprh2xUuUUTjerPJE3MX6zbjbjBaeWtjBl/LhU7Qf8m9u5RsKFcyF1U2ThvyOyVq9yI384W8Gmdn7Ej/D+Ny5viUWxSbUWJB19pNLpuSZ3jiEFNJAQGVN4rVUZyHw+kXfHtKsZ1RoAKzb+TDdlkT9yc58Jm4IbCOkrnhsgUUpfKd0x43GrnogqWyk+qjwcWdhkKlV3l0K2CT5xZKrPcqdWP8JS3DS6IPicvTIdPUsPuRRX8KJtPcM0hnvxKl08gIGh9N4NCjkPMZgmfU5eaMFbfK1FU63zVBEcYJwzVdJ3hOL+ULoEjP/tVnwrnd6ot53ylYW1W+2g7qCcB3NKkXsYCVhBj9ZJZEViRxaU641PgbSp5SdLu+t7tCOWVaB0mFrvTIgxGJdnG3whKs3ak9MBXHOQI40=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c758cdd-945a-43ae-de88-08d709168a3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 11:21:10.7646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: beanhuo@micron.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4306
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

This patch is to change msleep() to usleep_range() based on
Documentation/timers/timers-howto.txt. It suggests using
usleep_range() for small msec(1ms - 20ms) since msleep()
will often sleep longer than desired value.

After changing, booting time will be 5ms-10ms faster than before.
I tested this change on two different platforms, one has 5ms faster,
another one is about 10ms. I think this is different on different
platform.

Actually, from UFS host side, 1ms-5ms delay is already sufficient for
its initialization of the local UIC layer.

Fixes: 7a3e97b0dc4b ([SCSI] ufshcd: UFS Host controller driver)
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufshcd.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index a208589426b1..21f7b3b8026c 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4213,12 +4213,6 @@ static int ufshcd_hba_execute_hce(struct ufs_hba *hb=
a)
 {
 	int retry;
=20
-	/*
-	 * msleep of 1 and 5 used in this function might result in msleep(20),
-	 * but it was necessary to send the UFS FPGA to reset mode during
-	 * development and testing of this driver. msleep can be changed to
-	 * mdelay and retry count can be reduced based on the controller.
-	 */
 	if (!ufshcd_is_hba_active(hba))
 		/* change controller state to "reset state" */
 		ufshcd_hba_stop(hba, true);
@@ -4241,7 +4235,7 @@ static int ufshcd_hba_execute_hce(struct ufs_hba *hba=
)
 	 * instruction might be read back.
 	 * This delay can be changed based on the controller.
 	 */
-	msleep(1);
+	usleep_range(1000, 1100);
=20
 	/* wait for the host controller to complete initialization */
 	retry =3D 10;
@@ -4253,7 +4247,7 @@ static int ufshcd_hba_execute_hce(struct ufs_hba *hba=
)
 				"Controller enable failed\n");
 			return -EIO;
 		}
-		msleep(5);
+		usleep_range(5000, 5100);
 	}
=20
 	/* enable UIC related interrupts */
--=20
2.7.4
