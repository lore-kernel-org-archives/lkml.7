Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C80EC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02802206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="Fm8zp0Xq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfLITRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:17:30 -0500
Received: from mail-bn8nam11on2071.outbound.protection.outlook.com ([40.107.236.71]:33555
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726819AbfLITR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:17:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPsbqamz008su5SKjyONAGtStuo1pNJ3Am0bVYvvWIXfgBeSigiTAAuQ0n5Vm13r+Nu0ae2bQjpZ5ynd3WUcqCKvplCg/2bxrBDbOSIf5X8/GIecUv/p0SELVORMfAZMawQ7ZgzCJZ2g1hkZLLDPzdRP2E/izLGtRySmOnv8pv1VkMzTuVJZd3s2Ya1dll+8BV8WKUFN+C/Xhsmwb9nYi2jI1qPKug+2OoxYP904PJKhNtRCod4+yJmvyK34s5or6Mn4FHkSgtJWJUG8+uBVS3e4+MFnq1FCEkivddrOitbY3ERMo6niWI9oR7BMfZWB26obftNVUN+ftodOix4u6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxQpBbCaBdYdeeTMM0HiLrpDt/1vEpZSZywQUTQ48k0=;
 b=Ov0q1/zuJmxTZ7LMSvJ25U0s93cWvtx4LMG3An0bz+h/KBXt7Nfs4yE78U42LbhH5ucnDUFqGGs717ki7ZlQ4FJ22HoyCYCZ7qw6w039j8KRuuI6Mmm+0ucsdjcH2fKi7tvJA4Szla1XbkbPnOI2wNixNjpRQKPgBlNvmTLRkm/Z2g+mQLf7YtGTOHQae3j38h6PCsewJMcPmJhqHPoPWKG21N92XJvMHCPayFHPnYi1Xz7mpLd1QrWlCHcoGSkZn1Hn/MD6JLj4wsSIk2WMn/xLlJguXUwlun+X+n9xMY7+bcJHAbWcroIFDrQ8C9rl9KV26C1ev5LIoJe6VLVsuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxQpBbCaBdYdeeTMM0HiLrpDt/1vEpZSZywQUTQ48k0=;
 b=Fm8zp0Xqrs/X1XWc9AFSOUWTbjUs51Ohh5RY+DSJ6FmyJuQeoBwR5Pe3fTo+utfHmaLjTBp6DHmUinLsOzsiSdghCwbrJUQBGn1g/VW3BClguMCeIxgOs0TWWU0bfk6EMoUyM8c97OH6Rd9OsiWHx+Ax5s/ExVGJLxb4l4fvdS0=
Received: from BL0PR11MB3297.namprd11.prod.outlook.com (10.167.235.29) by
 BL0PR11MB3249.namprd11.prod.outlook.com (10.167.235.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.16; Mon, 9 Dec 2019 19:17:26 +0000
Received: from BL0PR11MB3297.namprd11.prod.outlook.com
 ([fe80::529:e8b:5e30:87a3]) by BL0PR11MB3297.namprd11.prod.outlook.com
 ([fe80::529:e8b:5e30:87a3%7]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 19:17:26 +0000
From:   Brant Merryman <Brant.Merryman@silabs.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Brant Merryman <Brant.Merryman@silabs.com>
Subject: [PATCH] Proper RTS control when buffers fill
Thread-Topic: [PATCH] Proper RTS control when buffers fill
Thread-Index: AQHVrsVK8PotWc8F5k2Pc+4Ew0PTFA==
Date:   Mon, 9 Dec 2019 19:17:26 +0000
Message-ID: <E0F3E0D5-4652-4DF0-B576-3FDB0274A5CD@silabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brant.Merryman@silabs.com; 
x-originating-ip: [207.207.39.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b231a20-193d-4cef-846d-08d77cdc6d30
x-ms-traffictypediagnostic: BL0PR11MB3249:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR11MB3249B7E8B15A7A0B2163F661E5580@BL0PR11MB3249.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:820;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(186003)(76116006)(26005)(36756003)(91956017)(5660300002)(316002)(305945005)(66946007)(6506007)(66446008)(2616005)(71190400001)(64756008)(71200400001)(66476007)(86362001)(110136005)(66556008)(478600001)(6512007)(2906002)(33656002)(6486002)(8936002)(8676002)(81156014)(4326008)(107886003)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR11MB3249;H:BL0PR11MB3297.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0OWU2YUldQIVQI+Swk7xP5KDr/6GPFZUwv3aTt47aDZj1Q+npQkOgb58bJKiRpiEt3ybV/vukIcnjCBQrvlKscfkNWu9DhmpwuMLk42UeZx9qJ/R41j3oynm3rhSGaZ7R5kDEidI0e+wmwnC/n7n4SrN0VYfc3zKXxtUaFuWOcEFIXK++yd6u5m08bzy6Tki8RBhLovRjg9VVj5mB6JUh1vILKDe43nQwfYtgnK9G9cTb16UdAjPrZ253ammjL8+0+anwYfcQWm5Q7RoTP2eomUN9Z0FM8pnqiEt46+rTTh+sgStulIMyXh8zY0meC315mStE2H+I1psxFkMkyYP9tgG7p19//VbMARhfDRQ39ELJmRBe7P29DOhJ9wuCg2ef5Al0BjChrsQOdYmttoITxHcW7AEQ7gm0mq9JB+hldbYCAiC59Oz02Zgy/HRrXuX
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98A695EA9A4F45459DC76174B7080ED4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b231a20-193d-4cef-846d-08d77cdc6d30
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 19:17:26.0541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ejUrLhVUQLiMUX2z1lwRY9sDVDrkQlgpncfhnLxaALCpBPSDUJoAYYZDj4RugTXrUM+MadZ7hsoRJfcJrDv+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3249
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables usb generic functions for throttle/unthrottle to prevent USB data
loss. CP210x hardware disables RTS but leaves CTS when in hardware flow
control mode and port is closed. When re-opening the serial port, if CTS
is enabled, then RTS must be re-enabled inside the driver.

Signed-off-by: Brant Merryman <brant.merryman@silabs.com>
---
 drivers/usb/serial/cp210x.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index f5143eedbc48..fd54181e741b 100644
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
@@ -915,6 +917,7 @@ static void cp210x_get_termios_port(struct usb_serial_p=
ort *port,
 	u32 baud;
 	u16 bits;
 	u32 ctl_hs;
+	u32 flow_repl;
=20
 	cp210x_read_u32_reg(port, CP210X_GET_BAUDRATE, &baud);
=20
@@ -1013,8 +1016,24 @@ static void cp210x_get_termios_port(struct usb_seria=
l_port *port,
 	cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl,
 			sizeof(flow_ctl));
 	ctl_hs =3D le32_to_cpu(flow_ctl.ulControlHandshake);
+	flow_repl =3D le32_to_cpu(flow_ctl.ulFlowReplace);
+	/* CP210x hardware disables RTS but leaves CTS when in hardware
+	 * flow control mode and port is closed.
+	 * This allows data to flow out, but new data will not come into
+	 * the port. When re-opening the port, if CTS is enabled, then RTS
+	 * must be re-enabled. in the driver
+	 */
 	if (ctl_hs & CP210X_SERIAL_CTS_HANDSHAKE) {
 		dev_dbg(dev, "%s - flow control =3D CRTSCTS\n", __func__);
+		flow_repl &=3D ~CP210X_SERIAL_RTS_MASK;
+		flow_repl |=3D CP210X_SERIAL_RTS_SHIFT(
+			CP210X_SERIAL_RTS_FLOW_CTL);
+
+		flow_ctl.ulControlHandshake =3D cpu_to_le32(ctl_hs);
+		flow_ctl.ulFlowReplace =3D cpu_to_le32(flow_repl);
+		cp210x_write_reg_block(port, CP210X_SET_FLOW,
+			&flow_ctl, sizeof(flow_ctl));
+
 		cflag |=3D CRTSCTS;
 	} else {
 		dev_dbg(dev, "%s - flow control =3D NONE\n", __func__);
-- =
