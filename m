Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4113C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE9920663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v0tBa2sQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfCGAAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:00:19 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:45442 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfCGAAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:00:17 -0500
Received: by mail-vs1-f74.google.com with SMTP id k17so1512552vsm.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e2I9s9eqW/pXhDtnWHYZKjtstIRBgNmOxa3j3Xgurck=;
        b=v0tBa2sQbOTLb/utAQ2jny2osFBJ/ZHvmthqYWL8mOmUeYd3yB3hOM9kXvC58IMMKc
         iVeQ1IpvYNjWwnQllc4Nd3mLWcxLuR1Xpp0LYZk5Nz0pdJWgwOPXwb0BmboZwisQ2fBU
         ykU8Abjk4JdNj7+gWWyzdjcA9tSZSIcDOagC6sb+4jlYIXSTAYR5Qzk6U3w7WzxOoUWi
         iTAnXLEUhWL4rwGZQsFEpYE5MRfIs7KSC5mxtEhOz3tRConSFneIBvZ26r0n0P4Pun5M
         OkQnYbfX56BwMRQl/la7dXKkpI/h2zE5PLHg44xE128DgK7eVWqvGZblKSbyKV9stUhJ
         tRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e2I9s9eqW/pXhDtnWHYZKjtstIRBgNmOxa3j3Xgurck=;
        b=joLCT1xIS4+YTx7eMNbHUFde7r3pM3fGNYXXn3eW5GbSq0mbvxkDR5RgPCLDC6LMic
         k5aZysYWO7/sJC2ORW9vLjp0TfMMvP1hTn0XiMTX2bC9UZ/13+YrEtGkEw/N0X1p123G
         sTg4Obow4qPd8Qb6izY7db9uMaiSLof9f6F7+lo2ub1AxS+BVbnZ9qljd9KlzzXoihgr
         i92oqbk8U1rTjbrqBzB6aUBGkRITQ3TKFQFY8dVqdNHt/KNZpB4pPQuzaJ3FqYPh+/qn
         taOH0rEtbAIMkAg/8SeuTFZ4s3Gav5lD+rYFmb2J+gAyFM9izlO16d4NmD0pNBTADH6n
         2OiQ==
X-Gm-Message-State: APjAAAXzalg9/IObEG1ZWCOVoBb6I4Yb3yUkii/BHmEH/stTWuEgzyuJ
        hrRVWgBox5Ypzi6ZYwGS373SoqYuOFhqKzsbIlNg2A==
X-Google-Smtp-Source: APXvYqw5w89OaCptTN2iiXxIkQF11FyJzVUWh6zTtwJcfZIsI7QxC6CeyvSs7FQFJgAEb1+tvYwixgrs5L3jcy4cST9fdg==
X-Received: by 2002:ab0:2495:: with SMTP id i21mr6864138uan.9.1551916815988;
 Wed, 06 Mar 2019 16:00:15 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:59:05 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-20-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
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
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 drivers/tty/serial/serial_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d4cca5bdaf1c..04534877b575 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -842,6 +842,12 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
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

