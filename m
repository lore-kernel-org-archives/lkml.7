Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9FFC04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 14:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E0121743
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 14:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="F4ZlkH2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfEQO2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 10:28:12 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:37082 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728628AbfEQO2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 10:28:11 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4HERqeA031475;
        Fri, 17 May 2019 16:28:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=zGr1lxGgQtNmS0J+6HxA7EjIL7+HHN/enw+TDPeZ5ms=;
 b=F4ZlkH2ilZNn2vgMaPett5jkM+0SAoQ2V0oVs6ur6RT9llvaTitXaEH3yRbiyH+FkXKP
 bbTk9+7dNFAfZztpGStDHgBoaLJpHh/FMrI0IT4rysl+ZHBY8h9qHUhjrsp/Lw2ZCFtU
 w/SzjOG1rJo0z88TymlB/e1z+4XbqUuVaziZImuzhrd5inlcr9qTQjdRrrZM2Z6ZW0go
 P4dnSPau3XYy7f5HJKNpQEe2b1elkysDWHWzZ/pxW/xDQOI0Jfe2bT3BSfXs7bJ6S8/x
 36fhUCYQcnjsnzIAO9v7up6eM4laLfrW2IPDL8opXg0i2Rkl51eJG2P3ZTh0OGsI6aNh sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sdn9get5h-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 17 May 2019 16:27:59 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3F30A38;
        Fri, 17 May 2019 14:27:59 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0CC632C9D;
        Fri, 17 May 2019 14:27:59 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 17 May
 2019 16:27:59 +0200
Received: from localhost (10.48.0.131) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 17 May 2019 16:27:58 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        xiang xiao <xiaoxiang781216@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC:     <arnaud.pouliquen@st.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: [PATCH v3 2/2] tty: add rpmsg driver
Date:   Fri, 17 May 2019 16:27:46 +0200
Message-ID: <1558103266-1613-3-git-send-email-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558103266-1613-1-git-send-email-arnaud.pouliquen@st.com>
References: <1558103266-1613-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.131]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-17_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver exposes a standard tty interface on top of the rpmsg
framework through the "rpmsg-tty-channel" rpmsg service.

This driver supports multi-instances, offering a /dev/ttyRPMSGx entry
per rpmsg endpoint.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 Documentation/serial/tty_rpmsg.txt |  38 +++
 drivers/tty/Kconfig                |   9 +
 drivers/tty/Makefile               |   1 +
 drivers/tty/rpmsg_tty.c            | 479 +++++++++++++++++++++++++++++++++++++
 4 files changed, 527 insertions(+)
 create mode 100644 Documentation/serial/tty_rpmsg.txt
 create mode 100644 drivers/tty/rpmsg_tty.c

diff --git a/Documentation/serial/tty_rpmsg.txt b/Documentation/serial/tty_rpmsg.txt
new file mode 100644
index 000000000000..e069ed268a2b
--- /dev/null
+++ b/Documentation/serial/tty_rpmsg.txt
@@ -0,0 +1,38 @@
+
+			The rpmsg TTY
+
+The rpmsg tty driver implements a serial communication on the rpmsg bus,
+to communicate with a remote processor devices in asymmetric multiprocessing
+(AMP) configurations.
+
+The remote processor can instantiate a new tty by requesting a new "rpmsg-tty-channel" RPMsg service. Information related to the RPMsg and
+associated tty device is available in /sys/bus/rpmsg/devices/virtio0.rpmsg-tty-channel.-1.<X>, with
+<X> corresponding to the ttyRPMSG instance.
+
+RPMsg data/control structure
+----------------------------
+
+The RPMsg is used to send data or control messages. Differentiation between the
+stream and the control messages is done thanks to the first byte of the
+RPMsg payload:
+
+
+RPMSG_DATA	- rest of messages contains data
+
+RPMSG_CTRL 	- message contains control.
+
+
+To be compliant with this driver, the remote firmware has to respect this RPMsg
+payload structure. At least the RPMSG_DATA type has to be supported. The
+RPMSG_CTRL is optional.
+
+Flow control type
+-----------------
+
+A minimum flow control can be implemented to allow/block communication with the remote processor.
+
+DATA_TERM_READY	-	one parameter:
+			- u8 state
+				Set to indicate to remote side that terminal is
+				ready for communication.
+				Reset to block communication with remote side.
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index e0a04bfc873e..d7b426939f69 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -442,6 +442,15 @@ config VCC
 	help
 	  Support for Sun logical domain consoles.
 
+config RPMSG_TTY
+	tristate "RPMSG tty driver"
+	depends on RPMSG
+	help
+	  Say y here to export rpmsg endpoints as tty devices, usually found
+	  in /dev/ttyRPMSGx.
+	  This makes it possible for user-space programs to send and receive
+	  rpmsg messages as a standard tty protocol.
+
 config LDISC_AUTOLOAD
 	bool "Automatically load TTY Line Disciplines"
 	default y
diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index c72cafdf32b4..90a98a20714d 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -33,5 +33,6 @@ obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) += ehv_bytechan.o
 obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
 obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
 obj-$(CONFIG_VCC)		+= vcc.o
+obj-$(CONFIG_RPMSG_TTY)		+= rpmsg_tty.o
 
 obj-y += ipwireless/
diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
new file mode 100644
index 000000000000..c7f53352acb6
--- /dev/null
+++ b/drivers/tty/rpmsg_tty.c
@@ -0,0 +1,479 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics 2019 - All Rights Reserved
+ * Authors: Arnaud Pouliquen <arnaud.pouliquen@st.com> for STMicroelectronics.
+ *          Fabien Dessenne <fabien.dessenne@st.com> for STMicroelectronics.
+ */
+
+#include <linux/module.h>
+#include <linux/rpmsg.h>
+#include <linux/slab.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+
+#define MAX_TTY_RPMSG		32
+
+static DEFINE_IDR(tty_idr);	/* tty instance id */
+static DEFINE_MUTEX(idr_lock);	/* protects tty_idr */
+
+static struct tty_driver *rpmsg_tty_driver;
+
+enum rpmsg_tty_type_t {
+	RPMSG_DATA,
+	RPMSG_CTRL,
+	NUM_RPMSG_TTY_TYPE
+};
+
+enum rpmsg_tty_ctrl_t {
+	DATA_TERM_READY,	/* ready to accept data */
+	NUM_RPMSG_TTY_CTRL_TYPE
+};
+
+struct rpmsg_tty_payload {
+	u8 cmd;
+	u8 data[0];
+};
+
+struct rpmsg_tty_ctrl {
+	u8 ctrl;
+	u8 values[0];
+};
+
+struct rpmsg_tty_port {
+	struct tty_port		port;	 /* TTY port data */
+	int			id;	 /* TTY rpmsg index */
+	struct rpmsg_device	*rpdev;	 /* rpmsg device */
+	int			cts;	 /* remote reception status */
+};
+
+typedef void (*rpmsg_tty_rx_cb_t)(struct rpmsg_device *, void *, int, void *,
+				  u32);
+
+static void rpmsg_tty_data_handler(struct rpmsg_device *rpdev, void *data,
+				   int len, void *priv, u32 src)
+{
+	struct rpmsg_tty_port *cport = dev_get_drvdata(&rpdev->dev);
+	u8 *cbuf;
+	int space;
+
+	dev_dbg(&rpdev->dev, "msg(<- src 0x%x) len %d\n", src, len);
+
+	if (!len)
+		return;
+
+	space = tty_prepare_flip_string(&cport->port, &cbuf, len);
+	if (space != len)
+		dev_dbg(&rpdev->dev, "trunc buffer: available space is %d\n",
+			len, space);
+	if (space <= 0)
+		return;
+
+	memcpy(cbuf, data, space);
+	tty_flip_buffer_push(&cport->port);
+}
+
+static void rpmsg_tty_ctrl_handler(struct rpmsg_device *rpdev, void *data,
+				   int len, void *priv, u32 src)
+{
+	struct rpmsg_tty_port *cport = dev_get_drvdata(&rpdev->dev);
+	struct rpmsg_tty_ctrl *ctrl = data;
+
+	dev_dbg(&rpdev->dev, "%s: ctrl received %d\n", __func__, ctrl->ctrl);
+	print_hex_dump_debug(__func__, DUMP_PREFIX_NONE, 16, 1, data, len,
+			     true);
+
+	if (len <= sizeof(*ctrl)) {
+		dev_err(&rpdev->dev, "%s: ctrl message invalid\n", __func__);
+		return;
+	}
+
+	if (ctrl->ctrl == DATA_TERM_READY) {
+		/* Update the CTS according to remote RTS */
+		if (!ctrl->values[0]) {
+			cport->cts = 0;
+		} else {
+			cport->cts = 1;
+			tty_port_tty_wakeup(&cport->port);
+		}
+	} else {
+		dev_err(&rpdev->dev, "unknown control ID %d\n", ctrl->ctrl);
+	}
+}
+
+static const rpmsg_tty_rx_cb_t rpmsg_tty_handler[] = {
+	[RPMSG_DATA] = rpmsg_tty_data_handler,
+	[RPMSG_CTRL] = rpmsg_tty_ctrl_handler,
+};
+
+static int rpmsg_tty_cb(struct rpmsg_device *rpdev, void *data, int len,
+			void *priv, u32 src)
+{
+	struct rpmsg_tty_payload  *rbuf = data;
+
+	if (len <= sizeof(*rbuf) || rbuf->cmd > NUM_RPMSG_TTY_TYPE) {
+		dev_err(&rpdev->dev, "Invalid message: size %d, type %d\n",
+			len, rbuf->cmd);
+		return -EINVAL;
+	}
+
+	rpmsg_tty_handler[rbuf->cmd](rpdev, &rbuf->data,
+				     len - sizeof(rbuf->cmd), priv, src);
+
+	return 0;
+}
+
+static int rpmsg_tty_write_control(struct tty_struct *tty, u8 ctrl, u8 *values,
+				   unsigned int n_value)
+{
+	struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
+	struct rpmsg_tty_payload *msg;
+	struct rpmsg_tty_ctrl *m_ctrl;
+	struct rpmsg_device *rpdev;
+	unsigned int msg_size;
+	int ret;
+
+	if (!cport) {
+		dev_err(tty->dev, "cannot get cport\n");
+		return -ENODEV;
+	}
+
+	rpdev = cport->rpdev;
+
+	msg_size = sizeof(*msg) + sizeof(*m_ctrl) + n_value;
+	msg = kzalloc(msg_size, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->cmd = RPMSG_CTRL;
+	m_ctrl =  (struct rpmsg_tty_ctrl *)&msg->data[0];
+	m_ctrl->ctrl = DATA_TERM_READY;
+	memcpy(m_ctrl->values, values, n_value);
+
+	ret = rpmsg_trysend(rpdev->ept, msg, msg_size);
+	if (ret < 0) {
+		dev_dbg(tty->dev, "cannot send control (%d)\n", ret);
+		ret = 0;
+	}
+	kfree(msg);
+
+	return ret;
+};
+
+static void rpmsg_tty_throttle(struct tty_struct *tty)
+{
+	u8 rts = 0;
+
+	/* Disable remote transmission */
+	rpmsg_tty_write_control(tty, DATA_TERM_READY, &rts, 1);
+};
+
+static void rpmsg_tty_unthrottle(struct tty_struct *tty)
+{
+	u8 rts = 1;
+
+	/* Enable remote transmission */
+	rpmsg_tty_write_control(tty, DATA_TERM_READY, &rts, 1);
+};
+
+static int rpmsg_tty_install(struct tty_driver *driver, struct tty_struct *tty)
+{
+	struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
+
+	if (!cport) {
+		dev_err(tty->dev, "cannot get cport\n");
+		return -ENODEV;
+	}
+
+	return tty_port_install(&cport->port, driver, tty);
+}
+
+static int rpmsg_tty_open(struct tty_struct *tty, struct file *filp)
+{
+	return tty_port_open(tty->port, tty, filp);
+}
+
+static void rpmsg_tty_close(struct tty_struct *tty, struct file *filp)
+{
+	return tty_port_close(tty->port, tty, filp);
+}
+
+static int rpmsg_tty_write(struct tty_struct *tty, const u8 *buf, int len)
+{
+	struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
+	struct rpmsg_device *rpdev;
+	int msg_size, msg_max_size, ret = 0;
+	int cmd_sz = sizeof(struct rpmsg_tty_payload);
+	u8 *tmpbuf;
+
+	if (!cport) {
+		dev_err(tty->dev, "cannot get cport\n");
+		return -ENODEV;
+	}
+
+	/* If cts not set, the message is not sent*/
+	if (!cport->cts)
+		return 0;
+
+	rpdev = cport->rpdev;
+
+	dev_dbg(&rpdev->dev, "%s: send msg from tty->index = %d, len = %d\n",
+		__func__, tty->index, len);
+	if (!buf) {
+		dev_err(&rpdev->dev, "buf shouldn't be null.\n");
+		return -ENOMEM;
+	}
+
+	msg_max_size = rpmsg_get_buf_payload_size(rpdev->ept);
+	if (msg_max_size < 0)
+		return msg_max_size;
+
+	msg_size = min(len + cmd_sz, msg_max_size);
+	tmpbuf = kzalloc(msg_size, GFP_KERNEL);
+	if (!tmpbuf)
+		return -ENOMEM;
+
+	tmpbuf[0] = RPMSG_DATA;
+	memcpy(&tmpbuf[cmd_sz], buf, msg_size - cmd_sz);
+
+	/*
+	 * Try to send the message to remote processor, if failed return 0 as
+	 * no data sent
+	 */
+	ret = rpmsg_trysend(rpdev->ept, (void *)tmpbuf, msg_size);
+	kfree(tmpbuf);
+	if (ret) {
+		dev_dbg(&rpdev->dev, "rpmsg_send failed: %d\n", ret);
+		return 0;
+	}
+
+	return msg_size - sizeof(struct rpmsg_tty_payload);
+}
+
+static int rpmsg_tty_write_room(struct tty_struct *tty)
+{
+	struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
+	int space = 0;
+
+	if (!cport) {
+		dev_err(tty->dev, "cannot get cport\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * Report the space in the rpmsg buffer, first byte is reserved to
+	 * define the buffer type.
+	 */
+	if (cport->cts) {
+		space = rpmsg_get_buf_payload_size(cport->rpdev->ept);
+		space -= sizeof(struct rpmsg_tty_payload);
+	}
+
+	return space;
+}
+
+static const struct tty_operations rpmsg_tty_ops = {
+	.install	= rpmsg_tty_install,
+	.open		= rpmsg_tty_open,
+	.close		= rpmsg_tty_close,
+	.write		= rpmsg_tty_write,
+	.write_room	= rpmsg_tty_write_room,
+	.throttle	= rpmsg_tty_throttle,
+	.unthrottle	= rpmsg_tty_unthrottle,
+};
+
+static struct rpmsg_tty_port *rpmsg_tty_alloc_cport(void)
+{
+	struct rpmsg_tty_port *cport;
+
+	cport = kzalloc(sizeof(*cport), GFP_KERNEL);
+	if (!cport)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_lock(&idr_lock);
+	cport->id = idr_alloc(&tty_idr, cport, 0, MAX_TTY_RPMSG, GFP_KERNEL);
+	mutex_unlock(&idr_lock);
+
+	if (cport->id < 0) {
+		kfree(cport);
+		return ERR_PTR(-ENOSPC);
+	}
+
+	return cport;
+}
+
+static void rpmsg_tty_release_cport(struct rpmsg_tty_port *cport)
+{
+	mutex_lock(&idr_lock);
+	idr_remove(&tty_idr, cport->id);
+	mutex_unlock(&idr_lock);
+
+	kfree(cport);
+}
+
+static int rpmsg_tty_port_activate(struct tty_port *p, struct tty_struct *tty)
+{
+	/* Allocate the buffer we use for writing data */
+	return tty_port_alloc_xmit_buf(p);
+}
+
+static void rpmsg_tty_port_shutdown(struct tty_port *p)
+{
+	/* Free the write buffer */
+	tty_port_free_xmit_buf(p);
+}
+
+static void rpmsg_tty_dtr_rts(struct tty_port *port, int raise)
+{
+	struct rpmsg_tty_port *cport =
+				container_of(port, struct rpmsg_tty_port, port);
+
+	pr_debug("%s: dtr_rts state %d\n", __func__, raise);
+	if (!port->tty || !cport) {
+		pr_err("invalid port\n");
+		return;
+	}
+
+	cport->cts = raise;
+
+	if (raise)
+		rpmsg_tty_unthrottle(port->tty);
+	else
+		rpmsg_tty_throttle(port->tty);
+}
+
+static const struct tty_port_operations rpmsg_tty_port_ops = {
+	.activate = rpmsg_tty_port_activate,
+	.shutdown = rpmsg_tty_port_shutdown,
+	.dtr_rts  = rpmsg_tty_dtr_rts,
+};
+
+static int rpmsg_tty_probe(struct rpmsg_device *rpdev)
+{
+	struct rpmsg_tty_port *cport;
+	struct device *dev = &rpdev->dev;
+	struct device *tty_dev;
+	int ret;
+
+	cport = rpmsg_tty_alloc_cport();
+	if (IS_ERR(cport)) {
+		dev_err(dev, "failed to alloc tty port\n");
+		return PTR_ERR(cport);
+	}
+
+	tty_port_init(&cport->port);
+	cport->port.low_latency = cport->port.flags | ASYNC_LOW_LATENCY;
+	cport->port.ops = &rpmsg_tty_port_ops;
+
+	tty_dev = tty_port_register_device(&cport->port, rpmsg_tty_driver,
+					   cport->id, dev);
+	if (IS_ERR(tty_dev)) {
+		dev_err(dev, "failed to register tty port\n");
+		ret = PTR_ERR(tty_dev);
+		goto  err_destroy;
+	}
+
+	cport->rpdev = rpdev;
+
+	dev_set_drvdata(dev, cport);
+
+	dev_dbg(dev, "new channel: 0x%x -> 0x%x : ttyRPMSG%d\n",
+		rpdev->src, rpdev->dst, cport->id);
+
+	return 0;
+
+err_destroy:
+	tty_port_destroy(&cport->port);
+	rpmsg_tty_release_cport(cport);
+
+	return ret;
+}
+
+static void rpmsg_tty_remove(struct rpmsg_device *rpdev)
+{
+	struct rpmsg_tty_port *cport = dev_get_drvdata(&rpdev->dev);
+
+	dev_dbg(&rpdev->dev, "removing rpmsg tty device %d\n", cport->id);
+
+	/* User hang up to release the tty */
+	if (tty_port_initialized(&cport->port))
+		tty_port_tty_hangup(&cport->port, false);
+
+	tty_unregister_device(rpmsg_tty_driver, cport->id);
+
+	tty_port_destroy(&cport->port);
+	rpmsg_tty_release_cport(cport);
+}
+
+static struct rpmsg_device_id rpmsg_driver_tty_id_table[] = {
+	{ .name	= "rpmsg-tty-channel" },
+	{ },
+};
+MODULE_DEVICE_TABLE(rpmsg, rpmsg_driver_tty_id_table);
+
+static struct rpmsg_driver rpmsg_tty_rpmsg_drv = {
+	.drv.name	= KBUILD_MODNAME,
+	.id_table	= rpmsg_driver_tty_id_table,
+	.probe		= rpmsg_tty_probe,
+	.callback	= rpmsg_tty_cb,
+	.remove		= rpmsg_tty_remove,
+};
+
+static int __init rpmsg_tty_init(void)
+{
+	int err;
+
+	rpmsg_tty_driver = tty_alloc_driver(MAX_TTY_RPMSG, TTY_DRIVER_REAL_RAW |
+					    TTY_DRIVER_DYNAMIC_DEV);
+	if (IS_ERR(rpmsg_tty_driver))
+		return PTR_ERR(rpmsg_tty_driver);
+
+	rpmsg_tty_driver->driver_name = "rpmsg_tty";
+	rpmsg_tty_driver->name = "ttyRPMSG";
+	rpmsg_tty_driver->major = 0;
+	rpmsg_tty_driver->type = TTY_DRIVER_TYPE_CONSOLE;
+
+	/* Disable unused mode by default */
+	rpmsg_tty_driver->init_termios = tty_std_termios;
+	rpmsg_tty_driver->init_termios.c_lflag &= ~(ECHO | ICANON);
+	rpmsg_tty_driver->init_termios.c_oflag &= ~(OPOST | ONLCR);
+
+	tty_set_operations(rpmsg_tty_driver, &rpmsg_tty_ops);
+
+	err = tty_register_driver(rpmsg_tty_driver);
+	if (err < 0) {
+		pr_err("Couldn't install rpmsg tty driver: err %d\n", err);
+		goto error_put;
+	}
+
+	err = register_rpmsg_driver(&rpmsg_tty_rpmsg_drv);
+	if (err < 0) {
+		pr_err("Couldn't register rpmsg tty driver: err %d\n", err);
+		goto error_unregister;
+	}
+
+	return 0;
+
+error_unregister:
+	tty_unregister_driver(rpmsg_tty_driver);
+
+error_put:
+	put_tty_driver(rpmsg_tty_driver);
+
+	return err;
+}
+
+static void __exit rpmsg_tty_exit(void)
+{
+	unregister_rpmsg_driver(&rpmsg_tty_rpmsg_drv);
+	tty_unregister_driver(rpmsg_tty_driver);
+	put_tty_driver(rpmsg_tty_driver);
+	idr_destroy(&tty_idr);
+}
+
+module_init(rpmsg_tty_init);
+module_exit(rpmsg_tty_exit);
+
+MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
+MODULE_AUTHOR("Fabien Dessenne <fabien.dessenne@st.com>");
+MODULE_DESCRIPTION("virtio remote processor messaging tty driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

