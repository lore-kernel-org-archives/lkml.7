Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702DDC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E98217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562598961;
	bh=QJsgjTG5QCeMh/lFp+X7Adal0D8yvlkVRLCM1NVRpQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x5uZoEBn+f9GMq13E2aaSpPgONj0J8bP9EAI1snmZzK/yL50T6CpuQdXafaK6gd92
	 2wft/OHYmcZbvucUKrmXESdu1vuvBbVNJOI2HQmIdKqVs0BFdYJ6+8PE8swLAHxSaF
	 XA85TZUH+cUAWen2NeqKNSKKZOjvZrSIS1VIuAdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbfGHPQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732433AbfGHPP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:15:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C04A32173E;
        Mon,  8 Jul 2019 15:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562598956;
        bh=QJsgjTG5QCeMh/lFp+X7Adal0D8yvlkVRLCM1NVRpQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dLUhcH/nuWCFu9OI99KfCnruExLikd2JhmAEoVg1xlMrw25KaKsoriWPrHHYCcOTH
         H4K1FEHrQQLABridBueVNdeXJF53Z6YxIljg7waNBppnBPWuJTndtur8BygvjnAhov
         5J7rlS7SD15bK/884+mIReu355DpM2NCmnDWZwcc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Jun Li <jun.li@nxp.com>, Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 4.4 06/73] usb: chipidea: udc: workaround for endpoint conflict issue
Date:   Mon,  8 Jul 2019 17:12:16 +0200
Message-Id: <20190708150518.237338255@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150513.136580595@linuxfoundation.org>
References: <20190708150513.136580595@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Chen <peter.chen@nxp.com>

commit c19dffc0a9511a7d7493ec21019aefd97e9a111b upstream.

An endpoint conflict occurs when the USB is working in device mode
during an isochronous communication. When the endpointA IN direction
is an isochronous IN endpoint, and the host sends an IN token to
endpointA on another device, then the OUT transaction may be missed
regardless the OUT endpoint number. Generally, this occurs when the
device is connected to the host through a hub and other devices are
connected to the same hub.

The affected OUT endpoint can be either control, bulk, isochronous, or
an interrupt endpoint. After the OUT endpoint is primed, if an IN token
to the same endpoint number on another device is received, then the OUT
endpoint may be unprimed (cannot be detected by software), which causes
this endpoint to no longer respond to the host OUT token, and thus, no
corresponding interrupt occurs.

There is no good workaround for this issue, the only thing the software
could do is numbering isochronous IN from the highest endpoint since we
have observed most of device number endpoint from the lowest.

Cc: <stable@vger.kernel.org> #v3.14+
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Jun Li <jun.li@nxp.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/chipidea/udc.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1614,6 +1614,25 @@ static int ci_udc_pullup(struct usb_gadg
 static int ci_udc_start(struct usb_gadget *gadget,
 			 struct usb_gadget_driver *driver);
 static int ci_udc_stop(struct usb_gadget *gadget);
+
+/* Match ISOC IN from the highest endpoint */
+static struct usb_ep *ci_udc_match_ep(struct usb_gadget *gadget,
+			      struct usb_endpoint_descriptor *desc,
+			      struct usb_ss_ep_comp_descriptor *comp_desc)
+{
+	struct ci_hdrc *ci = container_of(gadget, struct ci_hdrc, gadget);
+	struct usb_ep *ep;
+
+	if (usb_endpoint_xfer_isoc(desc) && usb_endpoint_dir_in(desc)) {
+		list_for_each_entry_reverse(ep, &ci->gadget.ep_list, ep_list) {
+			if (ep->caps.dir_in && !ep->claimed)
+				return ep;
+		}
+	}
+
+	return NULL;
+}
+
 /**
  * Device operations part of the API to the USB controller hardware,
  * which don't involve endpoints (or i/o)
@@ -1627,6 +1646,7 @@ static const struct usb_gadget_ops usb_g
 	.vbus_draw	= ci_udc_vbus_draw,
 	.udc_start	= ci_udc_start,
 	.udc_stop	= ci_udc_stop,
+	.match_ep 	= ci_udc_match_ep,
 };
 
 static int init_eps(struct ci_hdrc *ci)


