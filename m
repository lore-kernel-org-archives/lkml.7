Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83B7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 04:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61B120851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 04:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbfCAEiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 23:38:20 -0500
Received: from smtprelay0045.hostedemail.com ([216.40.44.45]:58211 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726347AbfCAEiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 23:38:20 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id A5536180A8142;
        Fri,  1 Mar 2019 04:38:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: iron22_e2f37b8d995d
X-Filterd-Recvd-Size: 6531
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Fri,  1 Mar 2019 04:38:17 +0000 (UTC)
Message-ID: <3f515cdb5cb6f77acb5cd8029bacd0be782eed64.camel@perches.com>
Subject: [PATCH] wusb: Remove unnecessary static function ckhdid_printf
From:   Joe Perches <joe@perches.com>
To:     Jon Flatley <jflat@chromium.org>
Cc:     Louis Taylor <louis@kragniz.eu>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 28 Feb 2019 20:38:16 -0800
In-Reply-To: <CACJJ=pz50c3oovHbKkjDDF=pabAj_9RtKGWvtpwx4nO+E_EtJg@mail.gmail.com>
References: <20190228115256.5446-1-louis@kragniz.eu>
         <20190228122417.9318-1-louis@kragniz.eu>
         <15c6689389503a82394bccb9204650bf20a7a6d3.camel@perches.com>
         <CACJJ=pzfSMgJbt5zKzgN-AcugkYRuGhbB88tsTX7k+-qPnS0jA@mail.gmail.com>
         <1450785b937f4a2b5f98c8548986b162684a719b.camel@perches.com>
         <CACJJ=pz50c3oovHbKkjDDF=pabAj_9RtKGWvtpwx4nO+E_EtJg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This static inline is unnecessary and can be removed
by using the vsprintf %ph extension.

This reduces overall object size by more than 2K.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/usb/wusbcore/cbaf.c       | 15 ++++-----------
 drivers/usb/wusbcore/dev-sysfs.c  |  5 ++---
 drivers/usb/wusbcore/devconnect.c |  2 +-
 drivers/usb/wusbcore/wusbhc.c     |  6 +-----
 include/linux/usb/wusb.h          | 16 ----------------
 5 files changed, 8 insertions(+), 36 deletions(-)

diff --git a/drivers/usb/wusbcore/cbaf.c b/drivers/usb/wusbcore/cbaf.c
index 222228c5c1e1..af77064c7456 100644
--- a/drivers/usb/wusbcore/cbaf.c
+++ b/drivers/usb/wusbcore/cbaf.c
@@ -302,10 +302,8 @@ static ssize_t cbaf_wusb_chid_show(struct device *dev,
 {
 	struct usb_interface *iface = to_usb_interface(dev);
 	struct cbaf *cbaf = usb_get_intfdata(iface);
-	char pr_chid[WUSB_CKHDID_STRSIZE];
 
-	ckhdid_printf(pr_chid, sizeof(pr_chid), &cbaf->chid);
-	return scnprintf(buf, PAGE_SIZE, "%s\n", pr_chid);
+	return sprintf(buf, "%16ph\n", cbaf->chid.data);
 }
 
 static ssize_t cbaf_wusb_chid_store(struct device *dev,
@@ -415,10 +413,8 @@ static ssize_t cbaf_wusb_cdid_show(struct device *dev,
 {
 	struct usb_interface *iface = to_usb_interface(dev);
 	struct cbaf *cbaf = usb_get_intfdata(iface);
-	char pr_cdid[WUSB_CKHDID_STRSIZE];
 
-	ckhdid_printf(pr_cdid, sizeof(pr_cdid), &cbaf->cdid);
-	return scnprintf(buf, PAGE_SIZE, "%s\n", pr_cdid);
+	return sprintf(buf, "%16ph\n", cbaf->cdid.data);
 }
 
 static ssize_t cbaf_wusb_cdid_store(struct device *dev,
@@ -503,7 +499,6 @@ static int cbaf_cc_upload(struct cbaf *cbaf)
 	int result;
 	struct device *dev = &cbaf->usb_iface->dev;
 	struct wusb_cbaf_cc_data *ccd;
-	char pr_cdid[WUSB_CKHDID_STRSIZE];
 
 	ccd =  cbaf->buffer;
 	*ccd = cbaf_cc_data_defaults;
@@ -513,10 +508,8 @@ static int cbaf_cc_upload(struct cbaf *cbaf)
 	ccd->BandGroups = cpu_to_le16(cbaf->host_band_groups);
 
 	dev_dbg(dev, "Trying to upload CC:\n");
-	ckhdid_printf(pr_cdid, sizeof(pr_cdid), &ccd->CHID);
-	dev_dbg(dev, "  CHID       %s\n", pr_cdid);
-	ckhdid_printf(pr_cdid, sizeof(pr_cdid), &ccd->CDID);
-	dev_dbg(dev, "  CDID       %s\n", pr_cdid);
+	dev_dbg(dev, "  CHID       %16ph\n", ccd->CHID.data);
+	dev_dbg(dev, "  CDID       %16ph\n", ccd->CDID.data);
 	dev_dbg(dev, "  Bandgroups 0x%04x\n", cbaf->host_band_groups);
 
 	result = usb_control_msg(
diff --git a/drivers/usb/wusbcore/dev-sysfs.c b/drivers/usb/wusbcore/dev-sysfs.c
index 85a1acf3a729..67b0a4c412b2 100644
--- a/drivers/usb/wusbcore/dev-sysfs.c
+++ b/drivers/usb/wusbcore/dev-sysfs.c
@@ -50,10 +50,9 @@ static ssize_t wusb_cdid_show(struct device *dev,
 	wusb_dev = wusb_dev_get_by_usb_dev(to_usb_device(dev));
 	if (wusb_dev == NULL)
 		return -ENODEV;
-	result = ckhdid_printf(buf, PAGE_SIZE, &wusb_dev->cdid);
-	strcat(buf, "\n");
+	result = sprintf(buf, "%16ph\n", wusb_dev->cdid.data);
 	wusb_dev_put(wusb_dev);
-	return result + 1;
+	return result;
 }
 static DEVICE_ATTR_RO(wusb_cdid);
 
diff --git a/drivers/usb/wusbcore/devconnect.c b/drivers/usb/wusbcore/devconnect.c
index fcb06aef2675..a93837d57d53 100644
--- a/drivers/usb/wusbcore/devconnect.c
+++ b/drivers/usb/wusbcore/devconnect.c
@@ -532,7 +532,7 @@ static void wusbhc_handle_dn_connect(struct wusbhc *wusbhc,
 	}
 
 	dnc = container_of(dn_hdr, struct wusb_dn_connect, hdr);
-	ckhdid_printf(pr_cdid, sizeof(pr_cdid), &dnc->CDID);
+	sprintf(pr_cdid, "%16ph", dnc->CDID.data);
 	dev_info(dev, "DN CONNECT: device %s @ %x (%s) wants to %s\n",
 		 pr_cdid,
 		 wusb_dn_connect_prev_dev_addr(dnc),
diff --git a/drivers/usb/wusbcore/wusbhc.c b/drivers/usb/wusbcore/wusbhc.c
index e5ba6140c1ba..d0b404d258e8 100644
--- a/drivers/usb/wusbcore/wusbhc.c
+++ b/drivers/usb/wusbcore/wusbhc.c
@@ -80,17 +80,13 @@ static ssize_t wusb_chid_show(struct device *dev,
 {
 	struct wusbhc *wusbhc = usbhc_dev_to_wusbhc(dev);
 	const struct wusb_ckhdid *chid;
-	ssize_t result = 0;
 
 	if (wusbhc->wuie_host_info != NULL)
 		chid = &wusbhc->wuie_host_info->CHID;
 	else
 		chid = &wusb_ckhdid_zero;
 
-	result += ckhdid_printf(buf, PAGE_SIZE, chid);
-	result += sprintf(buf + result, "\n");
-
-	return result;
+	return sprintf(buf, "%16ph\n", chid->data);
 }
 
 /*
diff --git a/include/linux/usb/wusb.h b/include/linux/usb/wusb.h
index 9e4a3213f2c2..65adee629106 100644
--- a/include/linux/usb/wusb.h
+++ b/include/linux/usb/wusb.h
@@ -236,22 +236,6 @@ enum {
 	WUSB_TRUST_TIMEOUT_MS = 4000,	/* [WUSB] section 4.15.1 */
 };
 
-static inline size_t ckhdid_printf(char *pr_ckhdid, size_t size,
-				   const struct wusb_ckhdid *ckhdid)
-{
-	return scnprintf(pr_ckhdid, size,
-			 "%02hx %02hx %02hx %02hx %02hx %02hx %02hx %02hx "
-			 "%02hx %02hx %02hx %02hx %02hx %02hx %02hx %02hx",
-			 ckhdid->data[0],  ckhdid->data[1],
-			 ckhdid->data[2],  ckhdid->data[3],
-			 ckhdid->data[4],  ckhdid->data[5],
-			 ckhdid->data[6],  ckhdid->data[7],
-			 ckhdid->data[8],  ckhdid->data[9],
-			 ckhdid->data[10], ckhdid->data[11],
-			 ckhdid->data[12], ckhdid->data[13],
-			 ckhdid->data[14], ckhdid->data[15]);
-}
-
 /*
  * WUSB Crypto stuff (WUSB1.0[6])
  */


