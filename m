Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE06C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5888923402
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="nGpkFlcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfIDGMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 02:12:16 -0400
Received: from mail-eopbgr1400091.outbound.protection.outlook.com ([40.107.140.91]:63936
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725877AbfIDGMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:12:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7JEePvT0bCMN0UPN66HpyF3bfChAOj21P50ZAqsOlXRZQ4Cjl2CisNRmSbp0FmLptv8mI2bWpKaFg2joztUbsX6qYtCQ2TblYon/5QFkuMXgj5KPFlyWik38Qx3QO0Hw2gKX+nBK/7l43+M9u9AZ96sM55LfYtrueTWByNUo3nOJl9jKU0wT7XzkssX23uTTcjMxd9CwTTHBB6/kvS9knFOQQP9ECVeBhR/IM7xL7bpRaFWV47lUitsm4OwCs9tMJAVc13BQhSJGtAQ68nG3f81036W4jluPDdVXqk7k5z6v7R5sgSAwKeIu5PvGaQIYJX2G8mCoD9oEQ/OYkKKtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqBcuB2anjHAvyM0ZuBmc46iE3H6qH0WPkvaIYFIk+4=;
 b=WBLqaESWpgQOddD2cHcWRhbJXYGq7dct2D31vWAao55a/HZtAgBn+otPCKKNI/IFDx2LjaERDLUqbEUua3oItCNvoHGGCSIxdbhDc/78Nn1TiBU/MWxnR1kzyBm+G8lhyo8TgptPLde6cuqJYpSNDYolMjiGN75JWHwhrsBhLwQq3yO+CkYUu2D00uYzaQbuBag4X4ncvbzFYGe0Tq/sPOLhp0fC08oYwmg7wk0eCiiVzJTB7D0A1EdfirUyAOea/iaRolVXtEHAWpDvuYSStRDx00TpjpfIHjy44tPcB2EyK8HXbER76wr/7aX0mj7VoX1Cc29j9Ux+IBFMCndPrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqBcuB2anjHAvyM0ZuBmc46iE3H6qH0WPkvaIYFIk+4=;
 b=nGpkFlcOS8/Uz8s5K+dw0dek1AQDb3R4/lBxtvHSf9Bjf9NoZ6aZ3vj5tjfV8UqJuNGe0WeWTZ3fvW6OB5pLOoLc7wXdnRh3yzyOrbTQZ+NpvNQswYrYbtyTi+cttIUvX06kApw50plC/34q1yxtYyI6JoV36IE+83Kp4xf5g6U=
Received: from OSAPR01MB4930.jpnprd01.prod.outlook.com (20.179.177.213) by
 OSAPR01MB4098.jpnprd01.prod.outlook.com (20.178.102.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Wed, 4 Sep 2019 06:12:11 +0000
Received: from OSAPR01MB4930.jpnprd01.prod.outlook.com
 ([fe80::c4ca:b67c:1d3f:c71a]) by OSAPR01MB4930.jpnprd01.prod.outlook.com
 ([fe80::c4ca:b67c:1d3f:c71a%7]) with mapi id 15.20.2220.022; Wed, 4 Sep 2019
 06:12:11 +0000
From:   "Kobayashi, Kento (Sony)" <Kento.A.Kobayashi@sony.com>
To:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Cao, Jacky" <Jacky.Cao@sony.com>
Subject: RE: [PATCH] USB: dummy-hcd: fix power budget for SuperSpeed mode
Thread-Topic: [PATCH] USB: dummy-hcd: fix power budget for SuperSpeed mode
Thread-Index: AdUr4fO63YeCnMxgQdWlMpYcyadcJAOxqk0ACg+lZqA=
Date:   Wed, 4 Sep 2019 06:12:11 +0000
Message-ID: <OSAPR01MB49300F8CA0956F031CA4B1ECC9B80@OSAPR01MB4930.jpnprd01.prod.outlook.com>
References: <16EA1F625E922C43B00B9D8225022050086ECF6A@APYOKXMS108.ap.sony.com>
 <16EA1F625E922C43B00B9D8225022050086F86B4@APYOKXMS108.ap.sony.com>
In-Reply-To: <16EA1F625E922C43B00B9D8225022050086F86B4@APYOKXMS108.ap.sony.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kento.A.Kobayashi@sony.com; 
x-originating-ip: [2001:cf8:0:6c::202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71793a6d-eea6-4e51-8b4f-08d730fed323
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:OSAPR01MB4098;
x-ms-traffictypediagnostic: OSAPR01MB4098:
x-ld-processed: 66c65d8a-9158-4521-a2d8-664963db48e4,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB4098142EA1CE2BCAAD7AD3A0C9B80@OSAPR01MB4098.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(136003)(346002)(366004)(396003)(199004)(189003)(8936002)(446003)(478600001)(11346002)(46003)(25786009)(8676002)(81156014)(81166006)(476003)(7736002)(4326008)(66446008)(66556008)(64756008)(9686003)(66946007)(54906003)(66476007)(316002)(14454004)(305945005)(5660300002)(110136005)(74316002)(229853002)(6436002)(486006)(55016002)(107886003)(99286004)(6246003)(186003)(53546011)(6506007)(102836004)(7696005)(2906002)(6116002)(33656002)(2501003)(53936002)(71190400001)(71200400001)(86362001)(76116006)(76176011)(14444005)(256004)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:OSAPR01MB4098;H:OSAPR01MB4930.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: sony.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J5MvuROFOGNM/PdhDwdlunNw+KULeeuxo8erMC0t1GE9eqsiPp/TLj8fr6a5iyidNDu7U7KPLEhZTJ8ZuAZn/L8Kd3Diylfremvmdri/N7LawHs2dIQE2jttFD2rkWNuTN3rb4GL2n/pyrnZ/XdCMEzpzZ6Lza15ZV9PAYmg748UacsJMaLQtrk9xTA2jWPgsl7+X42vWGIA7Tr9WnYvqJHFhj6zXBYatHX224WneofaZZWdBnU3lBt3TLMI2N/dFcbSAIHNRnV8+eyt8IyuRZJNB2C61GNRtS45mrSy+/wLpUogio+a8ezdrDUdkrF0b33hCWEJYutwpjh+AVL15sG5wG+R2vE2Wil93pT+nG49scyNJsC6E1nsnWvQG2qeIzmbB8WhT0CGzSzDV6cBGhuTtMso9N8fvUV3lsX2Fg4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71793a6d-eea6-4e51-8b4f-08d730fed323
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 06:12:11.4165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hxPP7z0UVohPAJJ+HJ4Aq0Jey+vZpxA+AGYdvX4iY0J3Gl+L4O3ENvOP4uXRvx4UWG/eW3UaimINcpbn3l105WrSb7Za1TfVWtoTo1NuibA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My company's member, Mr.Jacky, sent patch in June 26th.
But we didn't receive comment about our patch.
Could you confirm and tell us this patch is needed or not?

Regards,
Kento Kobayashi



From: Cao, Jacky <Jacky.Cao@sony.com>=20
Sent: Monday, July 15, 2019 10:05 AM
To: balbi@kernel.org; gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org; Kobayashi, Ken=
to (Sony) <Kento.A.Kobayashi@sony.com>; Cao, Jacky <Jacky.Cao@sony.com>
Subject: RE: [PATCH] USB: dummy-hcd: fix power budget for SuperSpeed mode

Hi,=20

Since around half month past, let me confirm the status of this issue.
If any comment about the fix patch, would you kind to share with us?=20
Thank you.

Best Regards
Jacky

From: Cao, Jacky=20
Sent: Wednesday, June 26, 2019 1:48 PM
To: mailto:balbi@kernel.org; mailto:gregkh@linuxfoundation.org; mailto:linu=
x-usb@vger.kernel.org; mailto:linux-kernel@vger.kernel.org
Cc: Kobayashi, Kento (Sony) <mailto:Kento.A.Kobayashi@sony.com>; Cao, Jacky=
 <mailto:Jacky.Cao@sony.com>
Subject: [PATCH] USB: dummy-hcd: fix power budget for SuperSpeed mode

The power budget for SuperSpeed mode should be 900 mA
according to USB3.0 specification, so set the power
budget to 900 mA for dummy_start_ss which is only used
for SuperSpeed mode.

If the max power consumption of SuperSpeed device is
larger than 500 mA, insufficient available bus power
error happens in usb_choose_configuration function
when the device connects to dummy hcd.

Signed-off-by: Jacky Cao <mailto:Jacky.Cao@sony.com>
---
drivers/usb/gadget/udc/dummy_hcd.c | 3 ++-
1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/du=
mmy_hcd.c
index 8414fac..52f2cf5 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -48,6 +48,7 @@
#define DRIVER_VERSION "02 May 2005"

=A0#define POWER_BUDGET=A0 500=A0 /* in mA; use 8 for low-power port testin=
g */
+#define POWER_BUDGET_3_0=A0 900=A0 /* in mA */

=A0static const char=A0 driver_name[] =3D "dummy_hcd";
static const char=A0 driver_desc[] =3D "USB Host+Gadget Emulator";
@@ -2432,7 +2433,7 @@ static int dummy_start_ss(struct dummy_hcd *dum_hcd)
=A0=A0=A0=A0 dum_hcd->rh_state =3D DUMMY_RH_RUNNING;
=A0=A0=A0=A0 dum_hcd->stream_en_ep =3D 0;
=A0=A0=A0=A0 INIT_LIST_HEAD(&dum_hcd->urbp_list);
-=A0=A0=A0=A0 dummy_hcd_to_hcd(dum_hcd)->power_budget =3D POWER_BUDGET;
+=A0=A0=A0=A0 dummy_hcd_to_hcd(dum_hcd)->power_budget =3D POWER_BUDGET_3_0;
=A0=A0=A0=A0 dummy_hcd_to_hcd(dum_hcd)->state =3D HC_STATE_RUNNING;
=A0=A0=A0=A0 dummy_hcd_to_hcd(dum_hcd)->uses_new_polling =3D 1;
#ifdef CONFIG_USB_OTG
--=20
2.7.4
