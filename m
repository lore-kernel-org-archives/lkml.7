Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB324C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BBD222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570194941;
	bh=HKVYJOd8nlFyRLZWLG9ZCwnPGqerccWR7yCvAb5VGKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eK8xukufdEV7tX07q9NK6S64yfQipXV97b6yY8VDlbSbNLktcqZHvvjNEEHkHHRhI
	 B720B80YMQLBLw6YmyARopur1nqGaJJurgW7oT5CUho5syIb08/YV0j+RAZceErkYZ
	 mWuOS4Fhb+wuRMmHw1gfHpucNlvuf/90j8lwq1qc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388460AbfJDNPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:15:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388362AbfJDNPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5Jk2FsConQzsRK+hX40Ij18Y47YadtEMXcbabS4xxtY=; b=jXIrfHc8V9Vh47xoIPFMutpDf9
        RL16l8pr5w31/0SRBIMtw+5g9PUj2bVglq4SWN4RyY6ZlDE4CwYAjkujYBAHnN9yiacvsDn3LdyhA
        aNUGOADYAzg6zLCfA1HID5O12KsDHq46t7G/063BWC/LYG7kijxCXQ/adGv+ip8ZktHDzqFhksEb/
        GcXSWfrssd2bPFeit8r+7P07YzjwnlXolwy7hNjWR9tGDh20qExWz2RxT9pl43oblRAscvuuxbCBi
        kB3H4+flB+LMFsjzcQ4JlmQciCIRwo1FF0edQxdiAUloYljwgg6rXd6XBrvDlCJE2Go+Ra96Zo5Ba
        b5raJcrw==;
Received: from 177.133.68.49.dynamic.adsl.gvt.net.br ([177.133.68.49] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGNQj-0007jG-5d; Fri, 04 Oct 2019 13:15:33 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.2)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1iGNQg-0002hw-8j; Fri, 04 Oct 2019 10:15:30 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        JP <jp@jpvw.nl>, Gonsolo <gonsolo@gmail.com>, crope@iki.fi,
        Sean Young <sean@mess.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] media: af9035: add support for Logilink VG0022A
Date:   Fri,  4 Oct 2019 10:15:24 -0300
Message-Id: <9618316567493f917c41109f7dba94e533fbfb4b.1570194906.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <2942b7ca9ecf86b6bff75c10ccfca25c173c3f0d.1570194906.git.mchehab+samsung@kernel.org>
References: <2942b7ca9ecf86b6bff75c10ccfca25c173c3f0d.1570194906.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This it930x-based device has an issue with si2068.

When the si2168 firmware that came with the device is replaced
by a new one, any I2C data received from the tuner will be
replaced by 0xff.

Probably, the vendor firmware has some patch specifically
designed for this device. So, we can't replace by the generic
firmware.

The right solution would be to extract the si2168 firmware from
the original driver and ask the driver to load the specifically
designed firmware, but, while we don't have that, the next best
solution is to just keep the original firmware at the device.

For more details, see the discussions at:
	https://lore.kernel.org/linux-media/20191002141359.30166-2-gonsolo@gmail.com/

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/media/usb/dvb-usb-v2/af9035.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/media/usb/dvb-usb-v2/af9035.c b/drivers/media/usb/dvb-usb-v2/af9035.c
index 3afd18733614..e555483c3077 100644
--- a/drivers/media/usb/dvb-usb-v2/af9035.c
+++ b/drivers/media/usb/dvb-usb-v2/af9035.c
@@ -1255,6 +1255,23 @@ static int it930x_frontend_attach(struct dvb_usb_adapter *adap)
 	si2168_config.fe = &adap->fe[0];
 	si2168_config.ts_mode = SI2168_TS_SERIAL;
 
+	/*
+	 * HACK: The Logilink VG0022A has a bug: when the si2168
+	 * firmware that came with the device is replaced by a new
+	 * one, the I2C transfers to the tuner will return just 0xff.
+	 *
+	 * Probably, the vendor firmware has some patch specifically
+	 * designed for this device. So, we can't replace by the
+	 * generic firmware. The right solution would be to extract
+	 * the si2168 firmware from the original driver and ask the
+	 * driver to load the specifically designed firmware, but,
+	 * while we don't have that, the next best solution is to just
+	 * keep the original firmware at the device.
+	 */
+	if (le16_to_cpu(d->udev->descriptor.idVendor) == USB_VID_DEXATEK &&
+	    le16_to_cpu(d->udev->descriptor.idProduct) == 0x0100)
+		si2168_config.dont_load_firmware = true;
+
 	state->af9033_config[adap->id].fe = &adap->fe[0];
 	state->af9033_config[adap->id].ops = &state->ops;
 	ret = af9035_add_i2c_dev(d, "si2168",
@@ -2121,6 +2138,8 @@ static const struct usb_device_id af9035_id_table[] = {
 		&it930x_props, "ITE 9303 Generic", NULL) },
 	{ DVB_USB_DEVICE(USB_VID_AVERMEDIA, USB_PID_AVERMEDIA_TD310,
 		&it930x_props, "AVerMedia TD310 DVB-T2", NULL) },
+	{ DVB_USB_DEVICE(USB_VID_DEXATEK, 0x0100,
+		&it930x_props, "Logilink VG0022A", NULL) },
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, af9035_id_table);
-- 
2.21.0

