Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E44C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CB220833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=brtchip.onmicrosoft.com header.i=@brtchip.onmicrosoft.com header.b="UmPQrgZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfDIKrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:47:51 -0400
Received: from mail-eopbgr1300125.outbound.protection.outlook.com ([40.107.130.125]:6123
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726035AbfDIKru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brtchip.onmicrosoft.com; s=selector1-brtchip-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcV1j4aCrPdcvl1mtFu3y/cIAR68S6D4n0SfnJNEBQ8=;
 b=UmPQrgZr5StKG6vCoJZl08HxQ+JPO79SKAHOpgYdBtgNL05FNUe1yncm0npsAy17NTHM4a0bLIrktL8euvr8kLMD6qHY7pwFZ1f5yQ2amthsyPGWCOlzqj/1rZB8htioLaF8/kQnTnIHwATkkYe2XGacMBlK5JLlgZzaqu19Lb0=
Received: from SG2PR03MB4165.apcprd03.prod.outlook.com (20.177.171.75) by
 SG2PR03MB2752.apcprd03.prod.outlook.com (52.133.138.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.7; Tue, 9 Apr 2019 10:47:42 +0000
Received: from SG2PR03MB4165.apcprd03.prod.outlook.com
 ([fe80::2d63:4333:ba1d:dd5c]) by SG2PR03MB4165.apcprd03.prod.outlook.com
 ([fe80::2d63:4333:ba1d:dd5c%2]) with mapi id 15.20.1792.007; Tue, 9 Apr 2019
 10:47:42 +0000
From:   "Ramachandran Srinivasan (BRT-SG)" <srinivasan.r@brtchip.com>
CC:     "Ramachandran Srinivasan (BRT-SG)" <srinivasan.r@brtchip.com>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] usb: serial: defer URB submission for ftdi_sio
Thread-Topic: [PATCH v2] usb: serial: defer URB submission for ftdi_sio
Thread-Index: AQHU7sGoR3u2/Zw0xk24btFMtQpYGQ==
Date:   Tue, 9 Apr 2019 10:47:42 +0000
Message-ID: <1554806826-11543-1-git-send-email-srinivasan.r@brtchip.com>
References: <1554724399-2972-1-git-send-email-srinivasan.r@brtchip.com>
In-Reply-To: <1554724399-2972-1-git-send-email-srinivasan.r@brtchip.com>
Accept-Language: en-SG, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: KL1P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:802:2::12) To SG2PR03MB4165.apcprd03.prod.outlook.com
 (2603:1096:4:3d::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=srinivasan.r@brtchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [118.189.144.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cbb1fad-c652-4223-6001-08d6bcd8caa0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:SG2PR03MB2752;
x-ms-traffictypediagnostic: SG2PR03MB2752:
x-microsoft-antispam-prvs: <SG2PR03MB27522B69661354323AFBAF539B2D0@SG2PR03MB2752.apcprd03.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(366004)(39840400004)(346002)(199004)(189003)(109986005)(4326008)(53376002)(53936002)(71190400001)(54906003)(68736007)(6306002)(316002)(71200400001)(59246006)(106356001)(256004)(105586002)(6512007)(52116002)(6486002)(36756003)(486006)(5660300002)(3846002)(99286004)(97736004)(2906002)(10126004)(25786009)(14444005)(6116002)(186003)(476003)(11346002)(446003)(50226002)(81156014)(2616005)(86362001)(478600001)(386003)(26005)(1671002)(8936002)(8676002)(6506007)(66066001)(305945005)(7736002)(14454004)(102836004)(6436002)(76176011)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2PR03MB2752;H:SG2PR03MB4165.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: brtchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rjMFRZqvAdEjDLfQYnNiIKFvyTSc/HFwM5fRtec0k/hBOFVRdgvp0GIzXmaeYZTdl4Q0X/FxPPj7bE4yeH8hh/bDm0ESUwkQpAbtk4Lhubrum1ww8+QlTlxWYcszpDd724xUtiG4FytrO1cfdJn/zNxVMNocxyps6JCHxE91kM2NRc/1MF2cV6aQfGrShwSAm9ggQwh8laL6vyzRKFFRPZT7e6NH+MmM5JN1xOYh1/L9ljglf/Tfiawtxg900kcDYgKdPcpxmUyM2GtdzmG7yy79DKfTjwhCIp3tq+uaL5K4lKS1z5GQg4vO1+3ML9h2S/0Vnl6CDrTynU85FpcX3r34LWsaSy3K3fJPdQQnWJVpKCreQtRHKfWIjD0W6g/gGFgjb/1vd74OVXiovv5hfqwAL+VhpUqNIIatK3JB1B4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: brtchip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbb1fad-c652-4223-6001-08d6bcd8caa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 10:47:42.1352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a2bb2098-6a22-417d-b196-55ac329bdd17
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB2752
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivasan R <srinivasan.r@brtchip.com>

Deferring the URB resubmission, this can help time share the available
DMA chanels of DWC_OTG host controller in RaspberryPi.This change can
fix the problem, failed to enumerate the USB device when all the 8
instance of ftdi_sio serial driver is open by application. many bugs
had been rasied for RaspberryPi around this problem can be solved

Signed-off-by: Srinivasan Ramachandran <srinivasan.r@brtchip.com>
---
 drivers/usb/serial/ftdi_sio.c | 153 ++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 152 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 1d8077e..63edd38 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -40,12 +40,16 @@
 #include <linux/usb.h>
 #include <linux/serial.h>
 #include <linux/usb/serial.h>
+#include <linux/hrtimer.h>
+#include <linux/ktime.h>
 #include "ftdi_sio.h"
 #include "ftdi_sio_ids.h"

 #define DRIVER_AUTHOR "Greg Kroah-Hartman <greg@kroah.com>, Bill Ryder <br=
yder@sgi.com>, Kuba Ober <kuba@mareimbrium.org>, Andreas Mohr, Johan Hovold=
 <jhovold@gmail.com>"
 #define DRIVER_DESC "USB FTDI Serial Converters Driver"

+#define HUNDREDMS    (100 * 1000000)
+#define TIMEOUT  (30 * 1000000)  // mill seconds, default value

 struct ftdi_private {
 enum ftdi_chip_type chip_type;
@@ -72,6 +76,11 @@ struct ftdi_private {
 unsigned int latency;/* latency setting in use */
 unsigned short max_packet_size;
 struct mutex cfg_lock; /* Avoid mess by parallel calls of config ioctl() a=
nd change_speed() */
+spinlock_tlock;
+ktime_t ktime;
+struct hrtimer etx_hr_timer;
+struct tty_struct *tty;
+struct device   *dev;
 };

 /* struct ftdi_sio_quirk is used by devices requiring special attention. *=
/
@@ -1046,10 +1055,15 @@ static int  ftdi_sio_probe(struct usb_serial *seria=
l,
 static int  ftdi_sio_port_probe(struct usb_serial_port *port);
 static int  ftdi_sio_port_remove(struct usb_serial_port *port);
 static int  ftdi_open(struct tty_struct *tty, struct usb_serial_port *port=
);
+static void ftdi_close(struct usb_serial_port *port);
+static void ftdi_cancel_timer(struct usb_serial_port *port);
 static void ftdi_dtr_rts(struct usb_serial_port *port, int on);
 static void ftdi_process_read_urb(struct urb *urb);
 static int ftdi_prepare_write_buffer(struct usb_serial_port *port,
 void *dest, size_t size);
+static void ftdi_serial_read_bulk_callback(struct urb *urb);
+static void ftdi_serial_throttle(struct tty_struct *tty);
+static void ftdi_serial_unthrottle(struct tty_struct *tty);
 static void ftdi_set_termios(struct tty_struct *tty,
 struct usb_serial_port *port, struct ktermios *old);
 static int  ftdi_tiocmget(struct tty_struct *tty);
@@ -1083,10 +1097,12 @@ static struct usb_serial_driver ftdi_sio_device =3D=
 {
 .port_probe =3Dftdi_sio_port_probe,
 .port_remove =3Dftdi_sio_port_remove,
 .open =3Dftdi_open,
+.close =3Dftdi_close,
 .dtr_rts =3Dftdi_dtr_rts,
 .throttle =3Dusb_serial_generic_throttle,
 .unthrottle =3Dusb_serial_generic_unthrottle,
 .process_read_urb =3Dftdi_process_read_urb,
+.read_bulk_callback =3D ftdi_serial_read_bulk_callback,
 .prepare_write_buffer =3Dftdi_prepare_write_buffer,
 .tiocmget =3Dftdi_tiocmget,
 .tiocmset =3Dftdi_tiocmset,
@@ -1102,6 +1118,13 @@ static struct usb_serial_driver * const serial_drive=
rs[] =3D {
 &ftdi_sio_device, NULL
 };

+/*
+ * Module parameter to control URB defer timer for FTDI-based .
+ * USB serial converter, If this value is not set in /etc/modprobe.d/
+ * its value will be set to 30ms, maximum value of the delay can be 100ms
+ */
+static unsigned long urb_defer_timer =3D TIMEOUT;
+

 #define WDR_TIMEOUT 5000 /* default urb timeout */
 #define WDR_SHORT_TIMEOUT 1000/* shorter urb timeout */
@@ -1112,6 +1135,33 @@ static struct usb_serial_driver * const serial_drive=
rs[] =3D {
  * ***********************************************************************=
****
  */

+static enum hrtimer_restart timer_callbackserial(struct hrtimer *timer)
+{
+struct ftdi_private *priv =3D container_of(timer, struct ftdi_private,
+etx_hr_timer);
+int stopped =3D 0;
+unsigned long flags;
+
+spin_lock_irqsave(&priv->lock, flags);
+if (!priv->tty)
+stopped =3D 1;
+spin_unlock_irqrestore(&priv->lock, flags);
+if (!stopped)
+ftdi_serial_unthrottle(priv->tty);
+return HRTIMER_NORESTART;
+}
+
+static void ftdi_cancel_timer(struct usb_serial_port *port)
+{
+unsigned long flags;
+struct ftdi_private *priv =3D usb_get_serial_port_data(port);
+
+hrtimer_cancel(&priv->etx_hr_timer);
+spin_lock_irqsave(&port->lock, flags);
+priv->tty =3D NULL;
+spin_unlock_irqrestore(&port->lock, flags);
+}
+
 static unsigned short int ftdi_232am_baud_base_to_divisor(int baud, int ba=
se)
 {
 unsigned short int divisor;
@@ -1815,9 +1865,87 @@ static int ftdi_sio_port_probe(struct usb_serial_por=
t *port)
 priv->latency =3D 16;
 write_latency_timer(port);
 create_sysfs_attrs(port);
+priv->ktime =3D ktime_set(0, ((urb_defer_timer > 0) &&
+(urb_defer_timer <=3D HUNDREDMS)) ? urb_defer_timer : TIMEOUT);
+hrtimer_init(&priv->etx_hr_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+priv->etx_hr_timer.function =3D &timer_callbackserial;
+priv->dev =3D &port->dev;
+spin_lock_init(&port->lock);
 return 0;
 }

+static void ftdi_serial_read_bulk_callback(struct urb *urb)
+{
+struct usb_serial_port *port =3D urb->context;
+unsigned long flags;
+int status =3D urb->status;
+int i;
+
+for (i =3D 0; i < ARRAY_SIZE(port->read_urbs); ++i) {
+if (urb =3D=3D port->read_urbs[i])
+break;
+}
+set_bit(i, &port->read_urbs_free);
+
+dev_dbg(&port->dev, "%s - urb %d, len %d\n", __func__, i,
+urb->actual_length);
+switch (status) {
+case 0:
+break;
+case -ENOENT:
+case -ECONNRESET:
+case -ESHUTDOWN:
+dev_dbg(&port->dev, "%s - urb stopped: %d\n",
+__func__, status);
+return;
+case -EPIPE:
+dev_err(&port->dev, "%s - urb stopped: %d\n",
+__func__, status);
+return;
+default:
+dev_dbg(&port->dev, "%s - nonzero urb status: %d\n",
+__func__, status);
+return;
+}
+
+spin_lock_irqsave(&port->lock, flags);
+port->throttled =3D port->throttle_req;
+if (!port->throttled) {
+spin_unlock_irqrestore(&port->lock, flags);
+/*Stop submitting back the URB, later in the Timer callback
+ * submit
+ */
+ftdi_serial_throttle(tty_port_tty_get(&port->port));
+} else {
+spin_unlock_irqrestore(&port->lock, flags);
+}
+ftdi_process_read_urb(urb);
+}
+static void ftdi_serial_throttle(struct tty_struct *tty)
+{
+struct usb_serial_port *port =3D tty->driver_data;
+unsigned long flags;
+
+spin_lock_irqsave(&port->lock, flags);
+port->throttle_req =3D 1;
+spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void ftdi_serial_unthrottle(struct tty_struct *tty)
+{
+struct usb_serial_port *port =3D tty->driver_data;
+unsigned long flags;
+int was_throttled;
+
+spin_lock_irqsave(&port->lock, flags);
+was_throttled =3D port->throttled;
+port->throttled =3D port->throttle_req =3D 0;
+spin_unlock_irqrestore(&port->lock, flags);
+
+if (was_throttled)
+usb_serial_generic_submit_read_urbs(port, GFP_KERNEL);
+}
+
 /* Setup for the USB-UIRT device, which requires hardwired
  * baudrate (38400 gets mapped to 312500) */
 /* Called from usbserial:serial_probe */
@@ -1956,11 +2084,18 @@ static int ftdi_open(struct tty_struct *tty, struct=
 usb_serial_port *port)
    This is same behaviour as serial.c/rs_open() - Kuba */

 /* ftdi_set_termios  will send usb control messages */
-if (tty)
+if (tty) {
 ftdi_set_termios(tty, port, NULL);
+priv->tty =3D tty;
+}

 return usb_serial_generic_open(tty, port);
 }
+static void ftdi_close(struct usb_serial_port *port)
+{
+usb_serial_generic_close(port);
+ftdi_cancel_timer(port);
+}

 static void ftdi_dtr_rts(struct usb_serial_port *port, int on)
 {
@@ -2127,6 +2262,8 @@ static void ftdi_process_read_urb(struct urb *urb)
 int i;
 int len;
 int count =3D 0;
+unsigned long flags;
+bool isstoped =3D false;

 for (i =3D 0; i < urb->actual_length; i +=3D priv->max_packet_size) {
 len =3D min_t(int, urb->actual_length - i, priv->max_packet_size);
@@ -2135,6 +2272,18 @@ static void ftdi_process_read_urb(struct urb *urb)

 if (count)
 tty_flip_buffer_push(&port->port);
+
+spin_lock_irqsave(&port->lock, flags);
+if (!priv->tty)
+isstoped =3D true;
+/*Start only one Timer for all the URB Buffers per port*/
+if ((port->throttled) && (isstoped =3D=3D false)) {
+spin_unlock_irqrestore(&port->lock, flags);
+hrtimer_start(&priv->etx_hr_timer, priv->ktime,
+HRTIMER_MODE_REL);
+} else {
+spin_unlock_irqrestore(&port->lock, flags);
+}
 }

 static void ftdi_break_ctl(struct tty_struct *tty, int break_state)
@@ -2475,3 +2624,5 @@ MODULE_LICENSE("GPL");

 module_param(ndi_latency_timer, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(ndi_latency_timer, "NDI device latency timer override");
+module_param(urb_defer_timer, ulong, 0644);
+MODULE_PARM_DESC(urb_defer_timer, "urb_defer delay in ms, default value 30=
ms");
--
2.7.4


Please note BRT have updated their Privacy Policy.

Please click on the following link to access and review.

BRT Privacy Policy<http://brtchip.com/privacy-policy/>
