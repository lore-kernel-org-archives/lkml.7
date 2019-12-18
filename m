Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC5DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810262082E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="kINv+vSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfLRSzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:55:08 -0500
Received: from mail-mw2nam10on2061.outbound.protection.outlook.com ([40.107.94.61]:6032
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726699AbfLRSzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 13:55:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zn0bjfsAGoH/GhWoOUlawZ1kR2S+3n6LVlWTaqHdykz0Nbx6CeEdwpk5tAtAXS0DLGsrTKuQYWblXIStDMfx3P9PHeTSQ7QTXUDl67MVAnM1A1H+8O5cPMrTQTm8WZa0LLfuZPORNrQ0qIaRdYU+WUpYomG43yfdz+haEx864faDPfbDdLG652HHh3zV4JvjffJN1Q+LVDsiZ35t4QIh/LxmFbzzSfrSVKX8+T8Sk0jVi0AQe7EIIr4VjpYDLLEeRDMy+QbcYAjf5nTWsaih+ENPAGn7yvCpem2KlT7us7+3eKt8EAlkT3BOeueT1dxqvIbaHXDcnUR/wKKuephapA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcLECkgkjf7cB/I+ofnXtZcouX6EuE1gzGSTJmRR5JE=;
 b=Ed7T2ck2/740jdmA8iCvN5o8LkinIGitK4C+vma0aj2uDRJnCrsd+391JPzL1mVOs8XNNluHib9f5Bt7tKlMx6z5jItZbc5YScB1bk1sOTm7yaRP6IgFWU8RM3E8KneSNBjw/HVBNZigG6p0DBgLQZYagVrfa5GImR97wgFJZ0PMbhVRdvjvPze19OLF1+XzhK0nNHt9eNAmNM0wmaN8QKrRac4pCEN28fQrKYPkYazRZKQG7WnUk516MUuApIcl5xSthDF7aDQt0FA1jqsrX3+kkrS/5/zFZZZ0SaQaNf/2ioZslXjFzwjKhgMObaepa+uMBOafO19bnw8d3k4ogA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcLECkgkjf7cB/I+ofnXtZcouX6EuE1gzGSTJmRR5JE=;
 b=kINv+vSpgWD64A+VNb0LIY1v7h8FbHHfuI9ln7u/GUEzDV8qKEiJOizBS1nW5gQkiudwTj22bk6+isCmNDVrlln54gTSVGGAsi7RlnaQIDbIONOhQAMfwbx5jHvkEerSAAvfYcZc11heW7A7Mqd1JJYk/Xfp4Zo37rscHT7rIYw=
Received: from SN6PR11MB3312.namprd11.prod.outlook.com (52.135.113.78) by
 SN6PR11MB2861.namprd11.prod.outlook.com (52.135.96.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Wed, 18 Dec 2019 18:55:05 +0000
Received: from SN6PR11MB3312.namprd11.prod.outlook.com
 ([fe80::ada0:e35e:7c5e:58d]) by SN6PR11MB3312.namprd11.prod.outlook.com
 ([fe80::ada0:e35e:7c5e:58d%5]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 18:55:04 +0000
From:   Brant Merryman <Brant.Merryman@silabs.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Brant Merryman <Brant.Merryman@silabs.com>,
        Richard Hendricks <Richard.Hendricks@silabs.com>
Subject: [PATCH] USB: serial: cp210x: Enables usb generic functions for
  throttle/unthrottle to prevent USB data loss.
Thread-Topic: [PATCH] USB: serial: cp210x: Enables usb generic functions for
  throttle/unthrottle to prevent USB data loss.
Thread-Index: AQHVtdSo6upqSA09J0e+8oJWtcPRUQ==
Date:   Wed, 18 Dec 2019 18:55:04 +0000
Message-ID: <D6486D05-4E0F-4CDF-B178-C386A9075032@silabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brant.Merryman@silabs.com; 
x-originating-ip: [207.207.39.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1af8aaf-682d-4d4d-890a-08d783ebcb55
x-ms-traffictypediagnostic: SN6PR11MB2861:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB28617108825E9CA2C408F8A6E5530@SN6PR11MB2861.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39850400004)(396003)(136003)(199004)(189003)(33656002)(64756008)(66556008)(66446008)(6512007)(81166006)(81156014)(4744005)(107886003)(76116006)(2616005)(316002)(6506007)(54906003)(8676002)(478600001)(2906002)(26005)(71200400001)(5660300002)(4326008)(66476007)(86362001)(110136005)(36756003)(6486002)(66946007)(186003)(8936002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB2861;H:SN6PR11MB3312.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VKO9U2Vn1s6OfNKzleXlK810Tv2A5+dOfqyzUaIvsSI9D6srtqIbH9uHQE9tLU4WSCKfp3hpFE37VvOlzGEK5YnkglbTgY9OW3B3Biuia5ukaJAAcLMmms1iojwEA41orkEMBY46Qj0D/pE6gYiKnuLABDbKuBZy6PI3jI1fvVISSFBfvdNYn2EoSbVWhfJj2GFQpugzbRBP8iXIu+yQcFErFWz81m3ytOpO09saAcszedgTj75o2MNmR/Yk15H/43HETuR1XdDFyqrRyLEIWiRgiw8XbMKeQAyCDbX+x7+MgT03W1nGHc7GH/C4yWsyqD/an/6wMMDyEGrC4DfmfZ/8r1inhj3e0Z5AMH9c31OgYqyFcmk/gsmAJlsVdV61zDC1PyewH/wSsI5g599B6OuyA8Gx4jfCxvh8L8+AxlLDRcSjQG4Q8RySfjbx+uJUJhJnsob4iCg9mC9nSNR/bEZ7oh+2p3pAAIjIzDQS1Qx73hW9ONvyggfz3A8OCJWl
Content-Type: text/plain; charset="us-ascii"
Content-ID: <370361CCC0F6A74A949155A1893A6B80@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1af8aaf-682d-4d4d-890a-08d783ebcb55
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 18:55:04.7298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xK7LU5iLR20y7eObX4p0WjQV1MEP0nHEErpVJl2QkDsn5qc2QHwKvrB/QzWuFnKxtWjksyIAKbvFdCjYhjGqXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2861
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB: serial: cp210x: Enables usb generic functions for
 throttle/unthrottle to prevent USB data loss.

Signed-off-by: Brant Merryman <brant.merryman@silabs.com>
---
 drivers/usb/serial/cp210x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index f5143eedbc48..bcceb4ad8be0 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -272,6 +272,8 @@ static struct usb_serial_driver cp210x_device =3D {
 	.break_ctl		=3D cp210x_break_ctl,
 	.set_termios		=3D cp210x_set_termios,
 	.tx_empty		=3D cp210x_tx_empty,
+	.throttle		=3D usb_serial_generic_throttle,
+	.unthrottle		=3D usb_serial_generic_unthrottle,
 	.tiocmget		=3D cp210x_tiocmget,
 	.tiocmset		=3D cp210x_tiocmset,
 	.attach			=3D cp210x_attach,
--=20
