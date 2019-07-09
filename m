Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB655C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2F620656
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="r+6UMSl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfGIPfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 11:35:20 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:19603 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfGIPfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 11:35:20 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Joshua.Henderson@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Joshua.Henderson@microchip.com";
  x-sender="Joshua.Henderson@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Joshua.Henderson@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Joshua.Henderson@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: k73VEKjPVQ7elR9L+HFBMp4PZdQ++W4HylrHJvD40VJhzhIfH64jt5ApTrXTaNsRUBU1QXWeRU
 lfwIH1u/1cOIdX+p+CCG8mvWFZvH3GmxUrdTu/WWamkcjUb31iGyjGV7ZB7pz+8OsSr60s56nJ
 YRWkucZT3c2CyLj61msidMkUBzI/b6Je9xGBI+Ef4vogan+yVtfsBf3KYzwnnUhQGFBD8Kp81g
 BTRz3uSfMRVBQIywCUI+e+6NS4FsR+jZkbs0+5PGbBCOVhIjw1HG9YDx5B213KRqrtTNKa87Po
 EeI=
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; 
   d="scan'208";a="42015352"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2019 08:35:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 9 Jul 2019 08:35:15 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 9 Jul 2019 08:35:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhx64/kt1EPO29AOpPoX5HrQ1mdPrjVrcvtbOT88JiE=;
 b=r+6UMSl3MbDaqZckpjEhLf6InorgCGtAyKhGinOKP1mTKfzMVsJa9mtkTo5un/iqJkz7cf5hVWDohbDzHmrGMD448YS41319/MT7jL2RWDIm+1GqKijdHJbiaIwJvpeux81kYVGMg7KrrL6r2gjDOH9fjLKC9oHcq8N9CHboxDQ=
Received: from MWHPR1101MB2079.namprd11.prod.outlook.com (10.174.96.9) by
 MWHPR1101MB2255.namprd11.prod.outlook.com (10.174.101.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Tue, 9 Jul 2019 15:35:12 +0000
Received: from MWHPR1101MB2079.namprd11.prod.outlook.com
 ([fe80::7408:6501:d238:63cd]) by MWHPR1101MB2079.namprd11.prod.outlook.com
 ([fe80::7408:6501:d238:63cd%9]) with mapi id 15.20.2052.019; Tue, 9 Jul 2019
 15:35:12 +0000
From:   <Joshua.Henderson@microchip.com>
To:     <boris.brezillon@free-electrons.com>, <airlied@linux.ie>,
        <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@free-electrons.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/atmel-hlcdc: set layer REP bit to enable replication
 logic
Thread-Topic: [PATCH] drm/atmel-hlcdc: set layer REP bit to enable replication
 logic
Thread-Index: AQHVNmvlXoLVjRxOEE2KayDJ7WC1cA==
Date:   Tue, 9 Jul 2019 15:35:12 +0000
Message-ID: <1562686509-8747-1-git-send-email-joshua.henderson@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0082.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::23) To MWHPR1101MB2079.namprd11.prod.outlook.com
 (2603:10b6:301:50::9)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [198.175.253.81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffc36d22-1cf5-434d-3d8f-08d70483085e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR1101MB2255;
x-ms-traffictypediagnostic: MWHPR1101MB2255:
x-microsoft-antispam-prvs: <MWHPR1101MB22553B0BEC02A649EEFE9C379BF10@MWHPR1101MB2255.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(366004)(189003)(199004)(6506007)(478600001)(110136005)(81166006)(81156014)(54906003)(386003)(14444005)(256004)(6486002)(6512007)(6436002)(476003)(53936002)(72206003)(8936002)(52116002)(26005)(8676002)(316002)(102836004)(4326008)(36756003)(186003)(5660300002)(66446008)(66476007)(73956011)(66946007)(4744005)(66556008)(6116002)(305945005)(64756008)(3846002)(7736002)(68736007)(486006)(66066001)(99286004)(14454004)(71190400001)(71200400001)(2906002)(86362001)(50226002)(25786009)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1101MB2255;H:MWHPR1101MB2079.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jaU/+ij4cMDBDUmyxbZPODO9nRFbGFTvjoX/ruJRDqym0MAcX8ysUVjPHMz0uiY5pBEE5Nsto1/5/zIYllEoQQjPZs4v0NBfrc7Qw7+Og1LJIgbftKcE43XrSGPmn1FfYfcpwxoKi/0zNSIAPSgGlnSOCYnJKt8MRcnmPUOIkNZusXfgsVt+cY5k2DNUDvNmKeAncxaUenFTmQYmxk5K2FloQyyW+tg06NSJTGEy2eafjJY4N/+6dNotBnadq4WUvcbRq7kG/UW8Y23zgrH3DBIfJsj1AirSyO27SV5qpooV8llXp/6TKJAsDnV8HwzuwKCZnkXTpXsvpZq4dKPXQHXkio3ft+Ns0kMWArhc844BsV12p+clZQOhCfsvFRJi4DD1vcoYtZgUQPihpV0ftLy7hzAfAQs/A3DXS28+AwU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc36d22-1cf5-434d-3d8f-08d70483085e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 15:35:12.5786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: joshua.henderson@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2255
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bit enables replication logic to expand an RGB color less than 24
bits, to 24 bits, which is used internally for all formats.  Otherwise,
the least significant bits are always set to zero and the color may not
be what is expected.

Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/=
drm/atmel-hlcdc/atmel_hlcdc_plane.c
index eb7c4cf..6f6cf61 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -389,7 +389,7 @@ atmel_hlcdc_plane_update_general_settings(struct atmel_=
hlcdc_plane *plane,
 	atmel_hlcdc_layer_write_cfg(&plane->layer, ATMEL_HLCDC_LAYER_DMA_CFG,
 				    cfg);
=20
-	cfg =3D ATMEL_HLCDC_LAYER_DMA;
+	cfg =3D ATMEL_HLCDC_LAYER_DMA | ATMEL_HLCDC_LAYER_REP;
=20
 	if (plane->base.type !=3D DRM_PLANE_TYPE_PRIMARY) {
 		cfg |=3D ATMEL_HLCDC_LAYER_OVR | ATMEL_HLCDC_LAYER_ITER2BL |
--=20
2.7.4

