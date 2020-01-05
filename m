Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2D3C00523
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 09:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE2820848
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 09:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="TkQkbilb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgAEJGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 04:06:00 -0500
Received: from mail-vi1eur05on2098.outbound.protection.outlook.com ([40.107.21.98]:2913
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbgAEJGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 04:06:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoaLmkBar4SkoCRYQLy0twFwcqENRM8rwV+PMnCD9dMsELy33Des3xClQ9Fr2QMrepViWUkafReP/NenSKBCPAa88TEVTnB+iIRkIz09OsyAm2+fJS8526USwbdJa4hAZj+yC3kEZ5Pb0YQoQXwwkTl5UjJ+GgsBSqHm+ry07epLL5m7dBJfyGx504bPXocHQJZQJpPmi0xN0ZIWaRzYC+5kQEi1Bt0egWjqa0TZesxglKRWQs8MZ8+2uRmHI5Hy33hI5JsRUFGMQmQefV5s3a6sYFwWmStfZG+BBXVOQSknw6LMzeuzXLDFpTy9CVDq/d5A3WmC5EPTjrmQ/voZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=316Pn0fTuE8DU+LNKlRDVBc2yeGDE4spJ98VY7jWMSU=;
 b=VQAK6gaOF3vtuTODdtdTDosMAfuZDVMyGNVnNwKRsH7sF5cXfvEDLbgw7PkR6yr3b15uZ/blUUXblisuq69Y4wt/rygm0WigHN+pYaB8m/yPxc0PsoYR4w/dr6Ruf8hR1f/fdkG2DBponFSDTGD6ItW/YHZMwon2vWekKHI/nUl6msZ0HJIj4gVI7/+yz00bHE7Wn2tewl2GDbHZFiZAjJGNOBwyGzzzscqvoCFIQclf4Tcm5dGtVTeqR4LMqAoDVCSc7QwIN2exlZs9FQ11vod34SikGRc33fuSFle1YoMjXIjZwPvJkXyHAvuFDPLA0jjMOCorK5KyCopP1OFxwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=316Pn0fTuE8DU+LNKlRDVBc2yeGDE4spJ98VY7jWMSU=;
 b=TkQkbilbH6arRebk61eoqWBO/LXt2QccSD4uee5L4IeDBPNm9+fPx8fNzGjq/es1R1MrsvGTykoYSd1iLcsCr18qJblUug4xVyqAPywyXEl+mQrGvT2j6Op9Pg6aMJZdoW7UHYMK56qgi6sGVl3MMv1tnniIwgsNj3SQtS3Dk+s=
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com (10.255.29.216) by
 AM0PR02MB3731.eurprd02.prod.outlook.com (52.133.63.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Sun, 5 Jan 2020 09:05:54 +0000
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::313d:beaa:db61:2e3d]) by AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::313d:beaa:db61:2e3d%2]) with mapi id 15.20.2602.015; Sun, 5 Jan 2020
 09:05:54 +0000
Received: from oshpigelman2-vm.habana-labs.com (31.154.190.6) by ZR0P278CA0022.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11 via Frontend Transport; Sun, 5 Jan 2020 09:05:45 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] habanalabs: do not halt Coresight during hard reset
Thread-Topic: [PATCH 2/2] habanalabs: do not halt Coresight during hard reset
Thread-Index: AQHVw6dQ3xASO1vhTkSE0k9uv9gUUQ==
Date:   Sun, 5 Jan 2020 09:05:45 +0000
Message-ID: <20200105090537.19979-2-oshpigelman@habana.ai>
References: <20200105090537.19979-1-oshpigelman@habana.ai>
In-Reply-To: <20200105090537.19979-1-oshpigelman@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ZR0P278CA0022.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::9) To AM0PR02MB5523.eurprd02.prod.outlook.com
 (2603:10a6:208:15e::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65ac9fed-621b-4f05-0bc7-08d791be730d
x-ms-traffictypediagnostic: AM0PR02MB3731:
x-microsoft-antispam-prvs: <AM0PR02MB373121D9B7602B1618E73D91B83D0@AM0PR02MB3731.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 027367F73D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39840400004)(376002)(346002)(366004)(396003)(199004)(189003)(5660300002)(36756003)(6916009)(1076003)(2906002)(4744005)(86362001)(6486002)(316002)(52116002)(81156014)(956004)(2616005)(81166006)(8936002)(8676002)(66556008)(66476007)(66946007)(66446008)(64756008)(186003)(478600001)(26005)(16526019)(6506007)(4326008)(6512007)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB3731;H:AM0PR02MB5523.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NO7AOSgJqMgCcEZtlkFl8dpRhFRD3IZ5xKBYYh974bQ8x9ZZolbtbl6u6QylQlqMHwExyaiXSL0fTHCKCrJehRQXF2SFZI4iuUgrIs4u6KJRXKx8uYi+Gsnzovhd45oPK2RjQo422k10Olupz8F+ozLmp7v3iJ3ExPPN57WhB8/bXcSrQECDK4sdLmD3NQrwxHJk7f2JVyOILC5AUSSIycQt85qvbDsDTxtZmvRcgRfhGRD+IAsnnsXHSM2X82ItHyEQqg/8820L6wO2Q5S9eqKPSCLoG5E973b7GhcrxsyD0krXXd2JlcsTecy1K65p4Co4fx64SB08iG32fk/fz8q5Ru7ncA0Oe3zssGXqODFbtYc//2AT7n6sa3c27PFtkglYolEiMQUjLJ3jWqf3DhcEH4izCHS4NZM2srHPpo8ZCtYY4z0GgDG+eGthWCjv
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ac9fed-621b-4f05-0bc7-08d791be730d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2020 09:05:45.8371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oJz533Jxv7In5MSkx6AT6w2EQOGQqtrdavZlWgx6iMNNvCh1S0FTaZFz2RubDRW4yn4E1G0NKmNOnvcl6ijFoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB3731
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During hard reset we must not write to the device.
Hence avoid halting Coresight during user context close if it is done
during hard reset.
In addition, we must not reenable clock gating afterwards as it was
deliberately disabled in the beginning of the hard reset flow.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
---
 drivers/misc/habanalabs/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/dev=
ice.c
index 166883b64725..b680b0caa69b 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -598,7 +598,9 @@ int hl_device_set_debug_mode(struct hl_device *hdev, bo=
ol enable)
 			goto out;
 		}
=20
-		hdev->asic_funcs->halt_coresight(hdev);
+		if (!hdev->hard_reset_pending)
+			hdev->asic_funcs->halt_coresight(hdev);
+
 		hdev->in_debug =3D 0;
=20
 		goto out;
--=20
2.17.1

