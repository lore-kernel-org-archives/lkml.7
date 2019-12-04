Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47185C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C26220656
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfLDObC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 09:31:02 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:56257 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfLDObB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 09:31:01 -0500
Received: from orion.localdomain ([77.9.37.28]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MQvL7-1iNKsd04oh-00NvdM; Wed, 04 Dec 2019 15:31:00 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH] usb: make usb_interrupt_msg() a static inline
Date:   Wed,  4 Dec 2019 15:30:35 +0100
Message-Id: <20191204143035.31751-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:11oIXUx93KR74Y69DiSZwrAwdf+nzRl+cXwMj/IyEr6GWO4jYkx
 BYQLXoxQTY+EZDKkdh8watI7Kt9Rhlc1znGlbcGJTtVkji+cRsvcSqlLwZYfWayDPdfWVOA
 7em2Hswy0p1HIr510SLHrz/YCuMMjlfjBVjPn/IYU7mpqdhCLt58q6aIkBVbru3xA+UtVAN
 xXWVuMDOgLDgMt3YIMwEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y/f5lIcjktU=:V4DNR0LM0mFh2QxEzhX31Q
 0yXd30wuwnMtT0E6Y97axs/leZkeVx6gbftOnUaqaeERnaZjWPb81H4RzFkTFxp/DzmE4Bwjn
 d89g8FYZmztGhKw5caCI3Qn6DWlfGf4AL+2REhAS4dZWChbQ9VaODxMK3OMcqVlKJUyYQM5uW
 y/abE7CSRLyvnaiIb7xEHxw5a1dviASXE4TxEQRX1bGGp+qvnBp/3dmAGNn1QJfSsj49wZUZD
 w9ARuy0xYUGlwBfWEngJ5aI4uqRLHvw6DIJ0NNHc1uHdl77g0GOMywisYxRbm7SCZEYycACy0
 EDYd8YQo3f8/2IQOyU9+uYsYSldDtaKRo5wPTnSb7CtkAfsJGUyC33LdlicvsIuyUPRPn5Ped
 sKLhJm56f6gudp6iyg5pFQf8ieJ+7Yx3Ou/6FYFYe7dUc7kQYOSkoBZZ8RIHPhBcuvb1gWwFi
 dJyuFgxX95TqsQ+5tYphZsmMXSMQcDv2z5iDkyeFCh0Pa66hm2tGqzRuFxkpoTv1DMvExoBhU
 HIcZC1EcoinOdKgBXw3YMdnRqMg+5z9l8vg1cmElYfP3qPbRgvCeVuHuz4Cvd2Rfwb1cXvgEu
 Q1ZjWya0zQ9LOpatPHmH2BGSlPLzqpwHvuhCieL5AF8Csc7Xnkd5TKtsOShNw6wlHajdY3DYi
 PcAnWMCY6dQ9rLyyC4l3Ta9QhM5FszGxPakgxjEuoOPmTgwXcmQwumyRIisO8MXJtdlrbCdBl
 4UryYdqJAutrBqQ19Is/OYlifHBHW7Oew5MAyNnhCtMHJNQMMtjNwxINhUkzOJqsHzfBALk8i
 U5KYoc+uu97Pjvk3IyMzKrBctJZ6KOfKIbeXBbFfbttZbQ9iA4/C5gPZjniAQlTGbXoUpx0EJ
 vUucISnoQnYUzppZ88rg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_interrupt_msg() effectively is just an alias for usb_bulk_msg(),
no need for being an real function, thus converting it to an
inline function.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/usb/core/message.c | 33 ---------------------------------
 include/linux/usb.h        |  8 ++++++--
 2 files changed, 6 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 5adf489428aa..d6088b77e05a 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -162,39 +162,6 @@ int usb_control_msg(struct usb_device *dev, unsigned int pipe, __u8 request,
 EXPORT_SYMBOL_GPL(usb_control_msg);
 
 /**
- * usb_interrupt_msg - Builds an interrupt urb, sends it off and waits for completion
- * @usb_dev: pointer to the usb device to send the message to
- * @pipe: endpoint "pipe" to send the message to
- * @data: pointer to the data to send
- * @len: length in bytes of the data to send
- * @actual_length: pointer to a location to put the actual length transferred
- *	in bytes
- * @timeout: time in msecs to wait for the message to complete before
- *	timing out (if 0 the wait is forever)
- *
- * Context: !in_interrupt ()
- *
- * This function sends a simple interrupt message to a specified endpoint and
- * waits for the message to complete, or timeout.
- *
- * Don't use this function from within an interrupt context. If you need
- * an asynchronous message, or need to send a message from within interrupt
- * context, use usb_submit_urb() If a thread in your driver uses this call,
- * make sure your disconnect() method can wait for it to complete. Since you
- * don't have a handle on the URB used, you can't cancel the request.
- *
- * Return:
- * If successful, 0. Otherwise a negative error number. The number of actual
- * bytes transferred will be stored in the @actual_length parameter.
- */
-int usb_interrupt_msg(struct usb_device *usb_dev, unsigned int pipe,
-		      void *data, int len, int *actual_length, int timeout)
-{
-	return usb_bulk_msg(usb_dev, pipe, data, len, actual_length, timeout);
-}
-EXPORT_SYMBOL_GPL(usb_interrupt_msg);
-
-/**
  * usb_bulk_msg - Builds a bulk urb, sends it off and waits for completion
  * @usb_dev: pointer to the usb device to send the message to
  * @pipe: endpoint "pipe" to send the message to
diff --git a/include/linux/usb.h b/include/linux/usb.h
index e656e7b4b1e4..0c96535bd5a0 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1783,12 +1783,16 @@ void usb_buffer_unmap_sg(const struct usb_device *dev, int is_in,
 extern int usb_control_msg(struct usb_device *dev, unsigned int pipe,
 	__u8 request, __u8 requesttype, __u16 value, __u16 index,
 	void *data, __u16 size, int timeout);
-extern int usb_interrupt_msg(struct usb_device *usb_dev, unsigned int pipe,
-	void *data, int len, int *actual_length, int timeout);
 extern int usb_bulk_msg(struct usb_device *usb_dev, unsigned int pipe,
 	void *data, int len, int *actual_length,
 	int timeout);
 
+static inline int usb_interrupt_msg(struct usb_device *usb_dev, unsigned int pipe,
+	void *data, int len, int *actual_length, int timeout)
+{
+	return usb_bulk_msg(usb_dev, pipe, data, len, actual_length, timeout);
+}
+
 /* wrappers around usb_control_msg() for the most common standard requests */
 extern int usb_get_descriptor(struct usb_device *dev, unsigned char desctype,
 	unsigned char descindex, void *buf, int size);
-- 
2.11.0

