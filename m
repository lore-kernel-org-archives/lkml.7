Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF306C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7271C2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MN1yXbqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfDDAdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:33:45 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:54113 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbfDDAdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:33:40 -0400
Received: by mail-pf1-f202.google.com with SMTP id j18so504249pfi.20
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 17:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=h9EnFy04jMHVM1ZMNH2nx3A+bDTELFHTwxmLElxP71o=;
        b=MN1yXbqBCCTTy42BJKCEKzcNSpCVI9QaCSde6dHY9nVoglt6DHZ2fuci9W/00kyRF5
         Ts6mPovN9ohlqPZjT2uk9sa9MxeuKSqBWm5zkVtm9dlesak92Ga9hE9Hja+66abKI+Es
         wB6u5AfgV5rWUrezpynHB8Nbg4bZ/03nLRF0kxyZevHMN1CjetAQK7ShhT+5aT+xSXO5
         e9hH7f9vpdqsDa6dOJLdy1lO1U7EJpTlLKKf/3EJJ4UfxmHeiNt01Bd737BoJvtC/ZgY
         viDIrtHsf/jwB23jwY+pW4Vre06W3qyOVxhRl+DH6qY9vEIre409m6nmcFcDv4UR/Cl6
         9AMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=h9EnFy04jMHVM1ZMNH2nx3A+bDTELFHTwxmLElxP71o=;
        b=Qyn77mF1ME0VRa26G1zqcDA7bXBbfiiVAuIsC7/JCUnnNzLB7rCOgoXFLqY1agBmpe
         i9qFTAEGDLJEsxcfOTggMXZ34T++TEUNueuIAyPDK7+fVn0HUV+ikqauija5p9UqjPP1
         Yu++P+FkzrUZwVqWT2OIYz2mz2+dKDSJWUWwoa1roKyymcWlT1lGuKVHnghNOKMSZ18P
         timtcFoAbbb8sIlBSagNtBfC+TSbE/qGbcYkpOubKDKMjn2wBVnaAzXt+ZTIZ7Oa2yF6
         3LBIZQAYdY2A1EbAvHtX8qhkrbx2GsVfDu4nOESyIgH4v3aI0LMrQ4yez618Z1JboVx8
         ndcw==
X-Gm-Message-State: APjAAAUT4Kdlv+pKnSbGKpzJbJii5X2bZEM2N1tmzPCnDhBshFXR6Zgu
        zHWV7wUOiI6vx0E3rcW47nISnCTz/oQQL6Rn2G4r1A==
X-Google-Smtp-Source: APXvYqyhfisNuAlj4WEh7WTqrSKFquTVmzWpEoNMp1mQMYjKSqBSFlno83biCQPnZ4sGVGFqUy4FOHMV7iKrDTtN+d8IvQ==
X-Received: by 2002:a62:25c6:: with SMTP id l189mr75197pfl.19.1554338019633;
 Wed, 03 Apr 2019 17:33:39 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:39 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-18-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 17/27] Lock down TIOCSSERIAL
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

