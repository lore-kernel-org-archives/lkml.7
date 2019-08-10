Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A616C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A2A208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="GNj42zQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfHJInQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 04:43:16 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:61709 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbfHJImy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 04:42:54 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 465FvR4Js1zZL;
        Sat, 10 Aug 2019 10:41:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1565426483; bh=iWOdfybI6mVoNgQPpeg8uc1pEY42f8eimks3ly6go5Y=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=GNj42zQq4K5PMLlfvUTnKy+NDDH4ElnF0y58WhZe0GA9OnCk/E4MaRt+dRjrr/g2V
         hh1OxIw4qXjz+a6W0Fyi/XdJ5TXghGZ2B6RAHyPzU2b0GlajrUm9wC/4bv3aqMA64d
         eS65U5e0U7DORcDQp/KcOAxBTXEAQQTI7cLXKWh/TaVNHGYw2EpLTeydyPZLoCZGsx
         kZJDHRhU0d+H0YogpruZyS68Z3NovYVjxh/NOnyBixO6FYXKM0jJf35hOEPEVe8Ol+
         xNy7FCS/WXzS7J/zyZYycWBIxQ/IStFvXQJLOk7+7K6GgW9QuYSKaCpQIYknA5mU5r
         leznt4JzwZfTA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.3 at mail
Date:   Sat, 10 Aug 2019 10:42:52 +0200
Message-Id: <12b6da6f4dfafd5ae1d4f556fd27263b3a3a2698.1565426370.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1565426370.git.mirq-linux@rere.qmqm.pl>
References: <cover.1565426370.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v6 5/7] usb: gadget: u_serial: diagnose missed console
 messages
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

Insert markers in console stream marking places where data
is missing. This makes the hole in the data stand out clearly
instead of glueing together unrelated messages.

Example output as seen from USB host side:

[    0.064078] pinctrl core: registered pin 16 (UART3_RTS_N PC0) on 70000868.pinmux
[    0.064130] pinctrl
[missed 114987 bytes]
[    4.302299] udevd[134]: starting version 3.2.5
[    4.306845] random: udevd: uninitialized urandom read (16 bytes read)

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
  v6: rebased on balbi/testing/next
  v5: no changes
  v4: no changes
  v3: added example output
    + lowercase "missed"
  v2: commit message massage

---
 drivers/usb/gadget/function/u_serial.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 0da00546006f..a248ed0fd5d2 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -88,6 +88,7 @@ struct gs_console {
 	spinlock_t		lock;
 	struct usb_request	*req;
 	struct kfifo		buf;
+	size_t			missed;
 };
 
 /*
@@ -931,6 +932,15 @@ static void __gs_console_push(struct gs_console *cons)
 	if (!size)
 		return;
 
+	if (cons->missed && ep->maxpacket >= 64) {
+		char buf[64];
+		size_t len;
+
+		len = sprintf(buf, "\n[missed %zu bytes]\n", cons->missed);
+		kfifo_in(&cons->buf, buf, len);
+		cons->missed = 0;
+	}
+
 	req->length = size;
 	if (usb_ep_queue(ep, req, GFP_ATOMIC))
 		req->length = 0;
@@ -952,10 +962,13 @@ static void gs_console_write(struct console *co,
 {
 	struct gs_console *cons = container_of(co, struct gs_console, console);
 	unsigned long flags;
+	size_t n;
 
 	spin_lock_irqsave(&cons->lock, flags);
 
-	kfifo_in(&cons->buf, buf, count);
+	n = kfifo_in(&cons->buf, buf, count);
+	if (n < count)
+		cons->missed += count - n;
 
 	if (cons->req && !cons->req->length)
 		schedule_work(&cons->work);
-- 
2.20.1

