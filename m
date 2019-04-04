Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9D7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FCD20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SAZzNCu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfDDICJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:02:09 -0400
Received: from mail-eopbgr20085.outbound.protection.outlook.com ([40.107.2.85]:47078
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726204AbfDDICJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=348CXBVtmou65d21vBrF/WcaMPEjMuawVro6sIs0r4A=;
 b=SAZzNCu0N1Ia85yhDSuPzwJ/Le+ZZni/C9U0E4RsaMBV5Xv839nFTb8nnyyi/NRApDdZhcvhgqJmySNJnO2r0xo4lnESNsQtVRm9cvQ4YeRnweZyDOutFC+ntC6+bfakpL6sxLijbxu77zP0VXz3f5Zz80IlDXK3GH1+mYjDKjw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3818.eurprd04.prod.outlook.com (52.134.71.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Thu, 4 Apr 2019 08:02:05 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Thu, 4 Apr 2019
 08:02:05 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "martink@posteo.de" <martink@posteo.de>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] iio: accell: mma8452: free iio trigger pointer when cleanup
Thread-Topic: [PATCH] iio: accell: mma8452: free iio trigger pointer when
 cleanup
Thread-Index: AQHU6ryxEHCPaiVeL06acUetPMat+Q==
Date:   Thu, 4 Apr 2019 08:02:05 +0000
Message-ID: <1554364635-19653-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:203:36::15) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25e4b445-2eb8-4244-d64f-08d6b8d3d391
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3818;
x-ms-traffictypediagnostic: DB3PR0402MB3818:
x-microsoft-antispam-prvs: <DB3PR0402MB3818D2E0F11A84369BB293E7F5500@DB3PR0402MB3818.eurprd04.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(7736002)(99286004)(25786009)(86362001)(14454004)(6512007)(6436002)(52116002)(186003)(4326008)(71190400001)(110136005)(6506007)(97736004)(316002)(71200400001)(478600001)(6486002)(5660300002)(486006)(26005)(102836004)(476003)(386003)(2616005)(8676002)(2501003)(14444005)(81166006)(256004)(305945005)(6116002)(3846002)(8936002)(2201001)(66066001)(106356001)(68736007)(2906002)(45080400002)(53936002)(36756003)(105586002)(50226002)(81156014)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3818;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E4pNxvUM9S3VN5aa7PVMq1QyhMscPB5AGcCNNBm+s10vf1iCuOK9byIErp5s+UVxWnD/Bxh6Kbr+oWcs6qETU7bjjzPYbuwuzYvNvw4EDM/po3cmZ74nmxwN2DZu7JIuInhFrwwNObuAU37RBOnQGFdeSpuoYHGZ59MXFhcw4gfuyE9uRejMFLZ+26cly6Vqk+JwKy3+RWmvkq2uzrVpRlQ1NV+5Ygs1glzF4udpjBGzXBYULc21AMAVA2HuXC6u2UVYw0EjgyLzi83SKlw0MdgStGeN6n6UALs7hcMpJRmYsBzo89qAJIdOqhEpozl8EqIljn80WvBA7V1NVQOdSyL/u9SDvKc1f3LvFrHl4SRY2Aj8gSAoFwZ4ou+B3+HLHy29UocGRlsGGTFlYGjWMvSqMFq4Zpn1vh3PNydGtj0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e4b445-2eb8-4244-d64f-08d6b8d3d391
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 08:02:05.2448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3818
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mma8452 is built as module, once it is insmod and rmmod, below
kernel dump will show out, the root cause is module being put twice
if iio trigger pointer is NOT NULL, this patch frees iio trigger
pointer after iio trigger is unregistered to avoid below kernel
dump:

------------[ cut here ]------------
WARNING: CPU: 3 PID: 270 at kernel/module.c:1145 module_put+0xd0/0x188
Modules linked in: mma8452(-)
CPU: 3 PID: 270 Comm: rmmod Not tainted 5.1.0-rc3-next-20190403-00022-g5ede=
0c9-dirty #1596
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[<c011272c>] (unwind_backtrace) from [<c010d094>] (show_stack+0x10/0x14)
[<c010d094>] (show_stack) from [<c0bdc160>] (dump_stack+0xd8/0x10c)
[<c0bdc160>] (dump_stack) from [<c01275d8>] (__warn+0xf8/0x124)
[<c01275d8>] (__warn) from [<c0127714>] (warn_slowpath_null+0x3c/0x48)
[<c0127714>] (warn_slowpath_null) from [<c01ca4d0>] (module_put+0xd0/0x188)
[<c01ca4d0>] (module_put) from [<c08a5bb4>] (iio_device_unregister_trigger_=
consumer+0x18/0x24)
[<c08a5bb4>] (iio_device_unregister_trigger_consumer) from [<c08a0ab4>] (ii=
o_dev_release+0x20/0)
[<c08a0ab4>] (iio_dev_release) from [<c065c0e8>] (device_release+0x24/0x8c)
[<c065c0e8>] (device_release) from [<c0be1810>] (kobject_put+0x74/0xd4)
[<c0be1810>] (kobject_put) from [<c0664dc0>] (release_nodes+0x16c/0x1f0)
[<c0664dc0>] (release_nodes) from [<c0661b80>] (device_release_driver_inter=
nal+0xec/0x1a0)
[<c0661b80>] (device_release_driver_internal) from [<c0661c90>] (driver_det=
ach+0x44/0x80)
[<c0661c90>] (driver_detach) from [<c066096c>] (bus_remove_driver+0x4c/0xa0=
)
[<c066096c>] (bus_remove_driver) from [<c01cc1a4>] (sys_delete_module+0x130=
/0x1dc)
[<c01cc1a4>] (sys_delete_module) from [<c0101000>] (ret_fast_syscall+0x0/0x=
28)
Exception stack(0xe8d87fa8 to 0xe8d87ff0)
7fa0:                   0001ffc0 38616d6d be87bbf0 00000880 00000000 be87be=
98
7fc0: 0001ffc0 38616d6d 00323534 00000081 000a9744 be87bf81 000a9790 000000=
00
7fe0: be87bbe8 be87bbd8 0001fe18 b6e381a0
irq event stamp: 4017
hardirqs last  enabled at (4035): [<c0188a0c>] console_unlock+0x400/0x630
hardirqs last disabled at (4052): [<c018868c>] console_unlock+0x80/0x630
softirqs last  enabled at (4050): [<c0102698>] __do_softirq+0x458/0x554
softirqs last disabled at (4069): [<c012ed6c>] irq_exit+0x130/0x180
---[ end trace a7ba8f1823b1e073 ]---

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/iio/accel/mma8452.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 3027811..6b18177 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1475,8 +1475,10 @@ static int mma8452_trigger_setup(struct iio_dev *ind=
io_dev)
=20
 static void mma8452_trigger_cleanup(struct iio_dev *indio_dev)
 {
-	if (indio_dev->trig)
+	if (indio_dev->trig) {
 		iio_trigger_unregister(indio_dev->trig);
+		indio_dev->trig =3D NULL;
+	}
 }
=20
 static int mma8452_reset(struct i2c_client *client)
--=20
2.7.4

