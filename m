Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B09C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E878324683
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576780737;
	bh=jjTBPwkNjj4iWeR8ZqS0cI4PSSxGrsm80SbqQwZ7etw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VB0Ue5vadwaNKCvMA7/bBcWyhR9M9St8JVsVu3aITPUiIkJMp+I6PAqflDFBbFBJt
	 Kc5D2gDkk7fjy7g9RDPWNuILLAV2tigA9M+qu2AU16b4UqBXWvKs5o7BphLrZ9+QFm
	 YGC6PbViJMHLjVyS9DBYbF9hMWg/qQKG/yqRbUdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfLSSiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:38:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:56840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbfLSSiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:38:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 193F6222C2;
        Thu, 19 Dec 2019 18:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780729;
        bh=jjTBPwkNjj4iWeR8ZqS0cI4PSSxGrsm80SbqQwZ7etw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0eQ1EiFuGR3j5FggBPY7GkGGoQvDn5+lknEzk0XCulm1EgAV4WqRbMAhbPhON0DG0
         xSkreNkrjxLikpyYmJDqE8gTwwNzESb5W373i7C34RJxRkaMIcgD3Vl8jrwld0hGTT
         nDi9drwCNlKdlxF7AzASnAiooQ6I5CZHdLkXiV+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 093/162] USB: serial: io_edgeport: fix epic endpoint lookup
Date:   Thu, 19 Dec 2019 19:33:21 +0100
Message-Id: <20191219183213.453180261@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 7c5a2df3367a2c4984f1300261345817d95b71f8 upstream.

Make sure to use the current alternate setting when looking up the
endpoints on epic devices to avoid binding to an invalid interface.

Failing to do so could cause the driver to misbehave or trigger a WARN()
in usb_submit_urb() that kernels with panic_on_warn set would choke on.

Fixes: 6e8cf7751f9f ("USB: add EPIC support to the io_edgeport driver")
Cc: stable <stable@vger.kernel.org>     # 2.6.21
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191210112601.3561-5-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/io_edgeport.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -2859,16 +2859,18 @@ static int edge_startup(struct usb_seria
 	response = 0;
 
 	if (edge_serial->is_epic) {
+		struct usb_host_interface *alt;
+
+		alt = serial->interface->cur_altsetting;
+
 		/* EPIC thing, set up our interrupt polling now and our read
 		 * urb, so that the device knows it really is connected. */
 		interrupt_in_found = bulk_in_found = bulk_out_found = false;
-		for (i = 0; i < serial->interface->altsetting[0]
-						.desc.bNumEndpoints; ++i) {
+		for (i = 0; i < alt->desc.bNumEndpoints; ++i) {
 			struct usb_endpoint_descriptor *endpoint;
 			int buffer_size;
 
-			endpoint = &serial->interface->altsetting[0].
-							endpoint[i].desc;
+			endpoint = &alt->endpoint[i].desc;
 			buffer_size = usb_endpoint_maxp(endpoint);
 			if (!interrupt_in_found &&
 			    (usb_endpoint_is_int_in(endpoint))) {


