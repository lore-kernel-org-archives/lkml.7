Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C26C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FAA12133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQlkbUme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbfB1XNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:13:00 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:50358 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388023AbfB1XMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:54 -0500
Received: by mail-qk1-f201.google.com with SMTP id d134so17178408qkc.17
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IP8fctA6K8NN5G061Fb911uxfYbe+tQq7t68cSfEm4c=;
        b=mQlkbUme7tUstIHNnk9Zjy+vZsDymO3M/+KQz36FFl4PseyptXPSkOtBCU+VpzfEzc
         w3Im01jnFe+xZbYmKjScHPbl0D5aFAz9aJX9QND+3DJ+4w2AyWglVW9aSPYzyZWM4Xov
         VNMUMd1Hty/C/yllcYOxa1rarjilo90btm0agwUTN1xuIFhQmzbKupvAihcV0+yUYUmP
         5SRr3bC9Lxy14IGMFYgXruziHJfDmPzF+qG4swTP01x4n/j6MX/s8cEo5REfTmpcTorT
         i380vbq3qlJJdw2Ya002CR0tq2AQicmhOuN88v8S4QRFAmpsoW5lTOuK+Et7XBt2D3XH
         dQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IP8fctA6K8NN5G061Fb911uxfYbe+tQq7t68cSfEm4c=;
        b=otL5+4ZlQkHLOn8g1HvIbjS9aCQEN0Ej5jGui9JNQY2wdzOJC9ftBRVg/fa+RB+ULf
         pRDCPVBqcbpGko8c6bvb7ZMMNNElyGd5HmbuOJb5cdOShAKnr/78gp7r6RTNN73KgxFA
         XYuK3OgvcT96XTQDIIsyYYI8ASA6zyu8gb0p7Rhj/jhJDY+Eznjt8yadEcCiAtGAz/+2
         baajN+eptl9lTvboznd4yYujYdInaepdhgntIc5SnDjlkJlvp98sbWq0uWab9L1DEYK2
         cBm56q7IGeAQa/q2/sM+RP0fPYVyEKUYqj/vwM+ejG0BFl1AriCpYypaYFuYp8RzSUj1
         rNVQ==
X-Gm-Message-State: APjAAAXOv2LsdZT8sZF0+cwFscAQ9EZOAsM3Vw9LeIEhZ2xd2nZSWByG
        oE6nDlap6t5Og0bkRm8La4IG4tNt5iHe7soS6xwoCA==
X-Google-Smtp-Source: APXvYqy6lnQP7cNTqUdwNAkXY6NJVBfXyJNp6Vjb7dh42LsutuwHpIVZFbrkYoaWwoRivdgkehMjZnjCLN5L07N/suMS5g==
X-Received: by 2002:ac8:1973:: with SMTP id g48mr1130734qtk.58.1551395574099;
 Thu, 28 Feb 2019 15:12:54 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:55 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-19-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 19/27] Lock down TIOCSSERIAL
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Lock down TIOCSSERIAL as that can be used to change the ioport and irq
settings on a serial port.  This only appears to be an issue for the serial
drivers that use the core serial code.  All other drivers seem to either
ignore attempts to change port/irq or give an error.

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jiri Slaby <jslaby@suse.com>
---
 drivers/tty/serial/serial_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 556f50aa1b58..627e859ae25a 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -852,6 +852,12 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	new_flags = (__force upf_t)new_info->flags;
 	old_custom_divisor = uport->custom_divisor;
 
+	if ((change_port || change_irq) &&
+	    kernel_is_locked_down("Using TIOCSSERIAL to change device addresses, irqs and dma channels")) {
+		retval = -EPERM;
+		goto exit;
+	}
+
 	if (!capable(CAP_SYS_ADMIN)) {
 		retval = -EPERM;
 		if (change_irq || change_port ||
-- 
2.21.0.352.gf09ad66450-goog

