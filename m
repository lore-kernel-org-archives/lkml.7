Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36437C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABF720866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z7k55eRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbfCZS2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:28:41 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:37946 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732784AbfCZS2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:38 -0400
Received: by mail-qt1-f202.google.com with SMTP id v18so14455736qtk.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=h9EnFy04jMHVM1ZMNH2nx3A+bDTELFHTwxmLElxP71o=;
        b=Z7k55eRQRYGcZah8QOHEIlHkH8KCl4gYI7fGrsmv4pyVRN2TE0VQxMVCfKBoCJFYcV
         kvxQC/SOAqFtnWiz6XNtEHDlp0wdjYRXLoWdNGYNtazGpr1wIYh7W9UzmDh5iZf7wwKM
         bpBIXO6ymj34WPya4v+dPjhxdGs93VkG7jXgcc7DLXNfHMLrPcWGD1nX79BWUY3qY48s
         DgpRcNhmY8ZJAqANIbasB7lKFamqPuXlJZNJNd40vPj/fgZvScq0VExRxburPO3qk/JN
         1PtAOp8+Mk7977nxUVBg5Z6w7LvRhumrO/NQ7JKIlm0NMH9sDbothKVECbiaIBhj6xzz
         yUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=h9EnFy04jMHVM1ZMNH2nx3A+bDTELFHTwxmLElxP71o=;
        b=hzVTD6tsM6RSNaR2cFrHIws7X55KDgv1e4OMIsDCL4Q9oRAEmZufKdt1BXf2vNVYjI
         ol59BAI1xfgR0rCd4Ia/iuC4udQJySNz04U0b9AOUdscPRRzMIF/w4XEnjmlnEJcq401
         BvDSOudZ1T5n91Up0QN2erZy+QipHnV9bgCUX8R6n913HydGNfvpkt+bTnuJA82CBXQG
         tCTaCzFeH/d+PuB6aDV/R7s8BDaMuXsPMByJCI6p1icIUsoXA6/rnSba1JU6AbqXh/pj
         z5fWsT9AuxZfXHCAgLgf6/5jXyJcPO38JMNTD4IeXEPxHH5LJBeGaXL8qAnIf6c2jmJ4
         5dJA==
X-Gm-Message-State: APjAAAW8YLukkON1DyOrU+DW1pDD8NrUb0ugawQn8tTLEVkWm6jIHd+z
        hpOsVZK3xNqmUvCxmsRcYUqY2flbDpHETP7hCg4UJA==
X-Google-Smtp-Source: APXvYqxdTd1jUs6dwf4ovhU+ZzR5OkjsK7SluXNtMP4TQSlVeJye4bUNfuWPhjrz9fQ9H73M9kP4eC8pkZdt7zfnoeQ90g==
X-Received: by 2002:a37:a797:: with SMTP id q145mr2953780qke.292.1553624917716;
 Tue, 26 Mar 2019 11:28:37 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:33 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-18-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 17/25] Lock down TIOCSSERIAL
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
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
Signed-off-by: Matthew Garrett <mjg59@google.com>
cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/serial_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d4cca5bdaf1c..65b67f0d4386 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -842,6 +842,12 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	new_flags = (__force upf_t)new_info->flags;
 	old_custom_divisor = uport->custom_divisor;
 
+	if ((change_port || change_irq) &&
+	    kernel_is_locked_down("Using TIOCSSERIAL to change device addresses, irqs and dma channels", LOCKDOWN_INTEGRITY)) {
+		retval = -EPERM;
+		goto exit;
+	}
+
 	if (!capable(CAP_SYS_ADMIN)) {
 		retval = -EPERM;
 		if (change_irq || change_port ||
-- 
2.21.0.392.gf8f6787159e-goog

