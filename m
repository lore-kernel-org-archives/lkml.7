Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD7FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B43E217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBJUkxIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388501AbfDXVNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:13:46 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33196 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388319AbfDXVNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:13:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id j11so15811166lfm.0;
        Wed, 24 Apr 2019 14:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=afMEzm9g2f2iOhKZFts1vKHdZwClQlHwJYLx/Eicp00=;
        b=XBJUkxIHMgCWX1pMikm0wxhDuE4+cNnyDvrVdGAdwvgU2asmdkZue9/0PFr3rTf84J
         Vqn3CJn6Yn6xb+3L/3sI2B17RHdKo7fBacJs9RORtXyKy7NR2wCd0p8YRPwuSKDDd5P/
         HJqfi4NaLYzlBOSVs8MjoPgUTf5enF3tyHUuWauTVNwrUaRTo/0CC+ZlqvvjyXctZkNt
         A6KJlOYRLOiiZ0A0qFz4hUuRj4lTj1HhhipXEmkS4q44rAXHqCzPb7rcC2PFsOQSVdZi
         CS69HYJu69jBcrY1QEWqeICDqUynIF2/KFqCrG4nCpiL7fJLaHq/y1YSy1onUgtpsOdP
         kdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=afMEzm9g2f2iOhKZFts1vKHdZwClQlHwJYLx/Eicp00=;
        b=tURWdH3MM4FWanOkh2Ux0dE2MmGF6uHIBYvKGJm5N90Y0w2vux2WuapknebC7E50yB
         GDOtttTpWVG+4oO077G5glWZiM7UYVMaVqBp5jXy+g66RfSWN/lyOcPpm8k2oaarlUOf
         HqKW6MsAZU86PRJIXWk9JmJXjnT/JuSFQ1a35vGODuQ4cxx6OfsKcS9/52LZX3+Jkl89
         Paq1MVqAG9wr3SU5nJY9RthgCNelIIvvCoERc2t9YcKf/hnoer5EeL0XdeyYzf9NdXpe
         N/twNOo9sUMvCLtFGDmgqmj1TVryCoyKwfVlSBnMBz7FwPKagabiwErHWNcfV3vIo/t+
         OkoA==
X-Gm-Message-State: APjAAAWOqEzzgMSRFooetHMQMQ7lygBQ7mh0PZ6t/4idC5FSNVIA/0bC
        KxYZcFP/j+8hDjTgeZgcLWcWRgje6b0=
X-Google-Smtp-Source: APXvYqyeUx74hqZinRcRS8umt56ljPomaVmYowHfvoJcah210H/zTwGWZBu7sNeTeu2VmNRj4JMmHw==
X-Received: by 2002:ac2:53b2:: with SMTP id j18mr6553646lfh.78.1556140418416;
        Wed, 24 Apr 2019 14:13:38 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id m3sm4540248lfh.94.2019.04.24.14.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 14:13:37 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] usb: usb251xb: Add US port lanes inversion property
Date:   Thu, 25 Apr 2019 00:12:07 +0300
Message-Id: <20190424211208.17499-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424211208.17499-1-fancer.lancer@gmail.com>
References: <20190424211208.17499-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver bindings already declare the "swap-dx-lanes" property to
invert the downstream ports lanes polarity. The similar config
can be defined for a single upstream port - "swap-us-lanes". It's
going to be boolean since there is only one upstream port
on the hub.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/usb/misc/usb251xb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
index 4ef34df948ad..56f0a10633fc 100644
--- a/drivers/usb/misc/usb251xb.c
+++ b/drivers/usb/misc/usb251xb.c
@@ -531,6 +531,8 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
 	hub->port_swap = USB251XB_DEF_PORT_SWAP;
 	usb251xb_get_ports_field(hub, "swap-dx-lanes", data->port_cnt,
 				 &hub->port_swap);
+	if (of_get_property(np, "swap-us-lanes", NULL))
+		hub->port_swap |= BIT(0);
 
 	/* The following parameters are currently not exposed to devicetree, but
 	 * may be as soon as needed.
-- 
2.21.0

