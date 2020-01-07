Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30376C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9F52081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="SQYoajgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgAGLRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:17:55 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:9740 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgAGLRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 06:17:55 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Codrin.Ciubotariu@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Codrin.Ciubotariu@microchip.com";
  x-sender="Codrin.Ciubotariu@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Codrin.Ciubotariu@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Codrin.Ciubotariu@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: G/qte2XtguT10gxLyXRbtrpKk0QE2/nQvKIHWaT6It0jjF1hrWcXX8pseitqKIJir+sfdsa4fb
 8sbxqlhLLTBj00yLr+QM7UzhsNiCMY69umdD6Vt4kc9Drr6XBC16Bh4UmflMk6rAFAFaXrZ3D7
 JqrBujr15VUP2GAhwotErFI8dfNBus4/jIxLy1kbo43OCqZsZobhWKyUiX89q/aM4ynhGwJN0Y
 Iodhf0AUhfh5BH7eNxSsWjejb2uBRuZzF3nyavMnk4fU49RGrzpkMGksVjQsCTnxArP94PgFt7
 Lxk=
X-IronPort-AV: E=Sophos;i="5.69,406,1571727600"; 
   d="scan'208";a="60386715"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jan 2020 04:17:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 Jan 2020 04:17:53 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 7 Jan 2020 04:17:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJCr/FmosTtmkxxf9cSWuDNY0WVHzgaQHs+lfcWfXnBSDMuZR+VDlZBG4McdmWR5ZjqRRf6YP4H9a+m9kfqUFUrAOctsbOLDDXmlYPIOJo0Q6JpstsefWhgyKuEA+lBenLwl3zZAl5aQDsOX+r1m5U0lha40omfG65h0oD9NraMtCDeLWSaRVzysvatrzc/X76iVvbLi6iMkTsGokGexLCvjYbleX50joegHPjBCfeLE9FwxYNi9qbVQZrkP0rfZDfiyjP/j8JWDfbPXVjOgn49L+tykMHTCnwh1xvH+/diyUO8+4h8I93xD5YLP8aeDN5B3maKizRr3YTn1heSxFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOEPNBogINIqqJomhUiSQmhyrHcBk/jUyfeejdF3JCQ=;
 b=NoCb3rzGGf2VeiV4MTO2TzlzodN5/O/e6lr+pVmmyqOUj7a/oEHBI/EUF7qCSSX4fGWXt8D8ncY8sa5ofnCNr2prZGsJiFpZGwGWxXJoyyJa0Qm8tcsssD9q7K79Z3cIwzGWWQii6M/qMwB1ni+ZNrqTse/QJFEJaqH2XrkMLQvtN93rHS2xafd2KDbqMGdhVY5AAANctVWlKLtXcVRzl/LxSJFEQm6bBu4xAaK/Z4AL/Oz5WHO+9ZZc6yGcY7ND20Dhqcfi97VaMg2jVaMge8n+qwTw6A6Su5/r3mFoqWquS5MWb5px2isSArlEHnLwyVEmZzs8W/HZzkFljb/38A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOEPNBogINIqqJomhUiSQmhyrHcBk/jUyfeejdF3JCQ=;
 b=SQYoajgWxLfi2C4/SilLsnS42EZJqWayqbLWOaM9Nf8PUy85XgLu0e25X3CBEbjRvg/u5YIfYRnPtxVKCcsvXvEK9TU/5rcRL74sl9wMOLSwi6D71IWrdfYTZIfCLA2d2YmKucHYRCBwj8EkZBPaiv4B+gRKWw2D++Pe+HDZqyM=
Received: from BY5PR11MB4497.namprd11.prod.outlook.com (52.132.255.220) by
 BY5SPR01MB0004.namprd11.prod.outlook.com (52.133.255.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 7 Jan 2020 11:17:48 +0000
Received: from BY5PR11MB4497.namprd11.prod.outlook.com
 ([fe80::6189:c32:b55b:b3fd]) by BY5PR11MB4497.namprd11.prod.outlook.com
 ([fe80::6189:c32:b55b:b3fd%5]) with mapi id 15.20.2623.008; Tue, 7 Jan 2020
 11:17:48 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH] tty/serial: atmel: RS485 & ISO7816: wait for TXRDY before
 sending data
Thread-Topic: [PATCH] tty/serial: atmel: RS485 & ISO7816: wait for TXRDY
 before sending data
Thread-Index: AQHVxUwXFa3UBqH4kUi+I0sc8auwuw==
Date:   Tue, 7 Jan 2020 11:17:47 +0000
Message-ID: <20200107111656.26308-1-codrin.ciubotariu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a05021b-24fe-48f4-11f2-08d793633a26
x-ms-traffictypediagnostic: BY5SPR01MB0004:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5SPR01MB00041B164398FD44481DB512E73F0@BY5SPR01MB0004.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(366004)(39860400002)(199004)(189003)(2616005)(71200400001)(66446008)(64756008)(66556008)(66476007)(76116006)(91956017)(66946007)(478600001)(26005)(6506007)(186003)(4326008)(107886003)(86362001)(5660300002)(6486002)(8676002)(81156014)(81166006)(316002)(36756003)(54906003)(110136005)(8936002)(1076003)(2906002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5SPR01MB0004;H:BY5PR11MB4497.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nDxUuw8/7to2cvPKNQrRy9EMaH9hFOvYbcM4zRFwa7kg7Z7nFXaE4RSybRoZNMGcFXW5IfwqGumbqa0wUN3RcLOTF/W+Pzc4E3xsI7cBafORvVabBAvfDUAC7Du/rrFEgPTMwearQXLjbTnKqy63GHrBTdd5wrb4jGHs2TBWYgzmHNoRpR3mvxHcwAroXFh1Vydm5n9qI8d9ntPOSyOOdD0Q8GMHsUp40AT3s2KMIybA527dsUyj98M9y5iO60Uid7DaezOUPzMusarNnegtac5O6ydvyL7BKlLIrCcPHH/FI61m+BDVycIbZRe+C7WgkCWavsVUQbIfw4XuzOhD60cRRbhiSQfHPD9Ucly1VU0CSeoFR2FJwnkt+GhDoNJWiR0mK88SJY0adWlXGKAD+KSK7GKDBJEHRMW2CKKEiWuAV49NNjLkFF7w4tJ8UifL
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a05021b-24fe-48f4-11f2-08d793633a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 11:17:47.9035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JmCSn7I+0xx3Q5oAD6PobN/EFeGrfFQzQBHZ+nUOy9pYYChvcOviRa0jAok2gyAvL9uGGD4zt3iVKVvn2QUGQ1Caembx5UMYjrXmIFifD1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5SPR01MB0004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At this moment, TXEMPTY is checked before sending data on RS485 and ISO7816
modes. However, TXEMPTY is risen when FIFO (if used) or the Transmit Shift
Register are empty, even though TXRDY might be up and controller is able to
receive data. Since the controller sends data only when TXEMPTY is ready,
on RS485, when DMA is not used, the RTS pin is driven low after each byte.
With this patch, the characters will be transmitted when TXRDY is up and
so, RTS pin will remain high between bytes.
The performance improvement on RS485 is about 8% with a baudrate of 300.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 drivers/tty/serial/atmel_serial.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_s=
erial.c
index a8dc8af83f39..19c8fb9faa36 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -313,7 +313,11 @@ static int atmel_config_rs485(struct uart_port *port,
=20
 	if (rs485conf->flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
-		atmel_port->tx_done_mask =3D ATMEL_US_TXEMPTY;
+		if (port->rs485.flags & SER_RS485_RX_DURING_TX)
+			atmel_port->tx_done_mask =3D ATMEL_US_TXRDY;
+		else
+			atmel_port->tx_done_mask =3D ATMEL_US_TXEMPTY;
+
 		atmel_uart_writel(port, ATMEL_US_TTGR,
 				  rs485conf->delay_rts_after_send);
 		mode |=3D ATMEL_US_USMODE_RS485;
@@ -831,7 +835,7 @@ static void atmel_tx_chars(struct uart_port *port)
 	struct atmel_uart_port *atmel_port =3D to_atmel_uart_port(port);
=20
 	if (port->x_char &&
-	    (atmel_uart_readl(port, ATMEL_US_CSR) & atmel_port->tx_done_mask)) {
+	    (atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXRDY)) {
 		atmel_uart_write_char(port, port->x_char);
 		port->icount.tx++;
 		port->x_char =3D 0;
@@ -839,8 +843,7 @@ static void atmel_tx_chars(struct uart_port *port)
 	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
 		return;
=20
-	while (atmel_uart_readl(port, ATMEL_US_CSR) &
-	       atmel_port->tx_done_mask) {
+	while (atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXRDY) {
 		atmel_uart_write_char(port, xmit->buf[xmit->tail]);
 		xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
@@ -851,10 +854,20 @@ static void atmel_tx_chars(struct uart_port *port)
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
=20
-	if (!uart_circ_empty(xmit))
+	if (!uart_circ_empty(xmit)) {
+		/* we still have characters to transmit, so we should continue
+		 * transmitting them when TX is ready, regardless of
+		 * mode or duplexity
+		 */
+		atmel_port->tx_done_mask |=3D ATMEL_US_TXRDY;
+
 		/* Enable interrupts */
 		atmel_uart_writel(port, ATMEL_US_IER,
 				  atmel_port->tx_done_mask);
+	} else {
+		if (atmel_uart_is_half_duplex(port))
+			atmel_port->tx_done_mask &=3D ~ATMEL_US_TXRDY;
+	}
 }
=20
 static void atmel_complete_tx_dma(void *arg)
@@ -2525,8 +2538,7 @@ static int atmel_init_port(struct atmel_uart_port *at=
mel_port,
 	 * Use TXEMPTY for interrupt when rs485 or ISO7816 else TXRDY or
 	 * ENDTX|TXBUFE
 	 */
-	if (port->rs485.flags & SER_RS485_ENABLED ||
-	    port->iso7816.flags & SER_ISO7816_ENABLED)
+	if (atmel_uart_is_half_duplex(port))
 		atmel_port->tx_done_mask =3D ATMEL_US_TXEMPTY;
 	else if (atmel_use_pdc_tx(port)) {
 		port->fifosize =3D PDC_BUFFER_SIZE;
--=20
2.20.1
