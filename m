Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6826EC32756
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF23208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="jK4hN7ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfHJIm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 04:42:56 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:21815 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfHJImy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 04:42:54 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 465FvQ0mfGz6q;
        Sat, 10 Aug 2019 10:41:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1565426482; bh=G7R5e0R8xvaPUp5VxDgIxn2z2zA6lF8ZjDv/d5wGWZ4=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=jK4hN7ldot/gkRoFcHO/XX7LC6g4B4iBuE2/xFMOGngBKJI+jnCudz7V8gs0dgBNr
         UmN2xQK5YVs2jtvcCDMky860A7WHkK5rTgghV3/nP72sdMytCTuWg8zKhQYvfS+ZRt
         A+4S4chNCsT0adsEvmBmz7OoAOzTO9tn92UoJUsZYKdfZMOgmcYxizPiTIQDHeQhEG
         ANq80oW7WQON3iRmjpusek96cxCb3cqd7dtdgi4mcHduB8QYCU5Qap/UPOZJLQnuJM
         xa1uAwahb7enCFhxy/XwRpiTiaBzRKh5iYW01ZH9MWSlbh6MThgNMTu9KvCaln7Cwk
         kuNjbUEql8YPQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.3 at mail
Date:   Sat, 10 Aug 2019 10:42:50 +0200
Message-Id: <15b3e89a888a24d90647dc5d93820bf5b80c9a06.1565426370.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1565426370.git.mirq-linux@rere.qmqm.pl>
References: <cover.1565426370.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v6 3/7] usb: gadget: u_serial: make OBEX port not a console
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent OBEX serial port from ever becoming a console. Console messages
will definitely break the protocol, and since you have to instantiate
the port making it explicitly for OBEX, there is no point in allowing
console to break it by mistake.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
  v6: rebased on balbi/testing/next
  v5: no changes
  v4: no changes
  v3: rename gserial_alloc_line_raw() -> gserial_alloc_line_no_console()
  v2: change of API
    + commit message massage

---
 drivers/usb/gadget/function/f_obex.c   |  2 +-
 drivers/usb/gadget/function/u_serial.c | 16 ++++++++++++----
 drivers/usb/gadget/function/u_serial.h |  1 +
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/function/f_obex.c b/drivers/usb/gadget/function/f_obex.c
index 55b7f57d2dc7..ab26d84ed95e 100644
--- a/drivers/usb/gadget/function/f_obex.c
+++ b/drivers/usb/gadget/function/f_obex.c
@@ -432,7 +432,7 @@ static struct usb_function_instance *obex_alloc_inst(void)
 		return ERR_PTR(-ENOMEM);
 
 	opts->func_inst.free_func_inst = obex_free_inst;
-	ret = gserial_alloc_line(&opts->port_num);
+	ret = gserial_alloc_line_no_console(&opts->port_num);
 	if (ret) {
 		kfree(opts);
 		return ERR_PTR(ret);
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 94f6999e8262..62280c23cde2 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -1180,7 +1180,7 @@ void gserial_free_line(unsigned char port_num)
 }
 EXPORT_SYMBOL_GPL(gserial_free_line);
 
-int gserial_alloc_line(unsigned char *line_num)
+int gserial_alloc_line_no_console(unsigned char *line_num)
 {
 	struct usb_cdc_line_coding	coding;
 	struct gs_port			*port;
@@ -1221,12 +1221,20 @@ int gserial_alloc_line(unsigned char *line_num)
 		goto err;
 	}
 	*line_num = port_num;
-
-	if (!port_num)
-		gs_console_init(port);
 err:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(gserial_alloc_line_no_console);
+
+int gserial_alloc_line(unsigned char *line_num)
+{
+	int ret = gserial_alloc_line_no_console(line_num);
+
+	if (!ret && !*line_num)
+		gs_console_init(ports[*line_num].port);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(gserial_alloc_line);
 
 /**
diff --git a/drivers/usb/gadget/function/u_serial.h b/drivers/usb/gadget/function/u_serial.h
index 9acaac1cbb75..8b472b0c8cb4 100644
--- a/drivers/usb/gadget/function/u_serial.h
+++ b/drivers/usb/gadget/function/u_serial.h
@@ -54,6 +54,7 @@ struct usb_request *gs_alloc_req(struct usb_ep *ep, unsigned len, gfp_t flags);
 void gs_free_req(struct usb_ep *, struct usb_request *req);
 
 /* management of individual TTY ports */
+int gserial_alloc_line_no_console(unsigned char *port_line);
 int gserial_alloc_line(unsigned char *port_line);
 void gserial_free_line(unsigned char port_line);
 
-- 
2.20.1

