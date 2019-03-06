Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C256AC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FF320663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BXibPNAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfCGAAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:00:16 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:54148 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfCGAAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:00:13 -0500
Received: by mail-qk1-f201.google.com with SMTP id z123so11621178qka.20
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EeAsNLooacMCIyQQG8kjyYl9LfYTYq2OlHNVaSq+jF4=;
        b=BXibPNAU2kBLKi0tjOaBoATPK4GSG9rdLOziADGyltDJLflexEotgn/YIOIEl1Fm1H
         yMKiAZuRKAYyc2wi9Z9d4o35i6BvJDlVbS0M3iQvUIZits5qZwr7R60IUQGPdO6d5eWg
         oqY4UJoLQdmZJ2B0X2IxvA0M9/CXZx0HcS1UqVad8pRlnNi2MHHBlTg276gQPOoUjJVU
         jXR9xzzJ/1LnMTEgqx6l/1wlLediq2tk6EewVxCYv9Ajdlki6r3EAt3+eXpztFNwMs93
         3/hzDEIcglR4a8m9b8Zr9hyDIA0YZdse4rBnWiIpPApIuSjtOjoQUODVtRMhiygVCjIw
         lwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EeAsNLooacMCIyQQG8kjyYl9LfYTYq2OlHNVaSq+jF4=;
        b=tyM9wWz2KlzJn7dXfhCc5sKsB0uGuTgfIgG5qscTTAtHD4YndIRe+OBTzqGKHURChu
         QLI+1Uhx35UTwlwM6e1nHRMALNDKLaMI+vFp/ya71o0Gf9cXnrRavZl4wULW5zyyizMX
         jcdDl1k9Voe5UkU52KmFN2mb0XOlTM314zh/AmI5LpPH2p9BjLo2rOwy8AWeyBwZ6cbP
         sbvLLgpYCPv8ZJ0e6DWWDbDVuDnydsp1YCByRDULTzf+g3MkGJ9cSnwn/4M7hhg6Oey+
         3k4FDyW9ZJhh4S+5on8RuOccbhxzQ/bxPaMQqhkoed+7g34HcP+YKVnAg6i8Cq92WgeO
         frtw==
X-Gm-Message-State: APjAAAVmuAuDXmQE2j8H8MlqLpPLT1c0CBNuUAGW04uqxCwdC0CfiBH4
        7Kk2s/f2+LuN2pipN7el0rIludnQKGdTPQDhiCc8Fw==
X-Google-Smtp-Source: APXvYqyyHqurNEQcATvX9vuJ/DA66of6NpknXBwulCWr+CZ2zas04bUFP1eObLNYb/FpEk+eXfimYgny1hYZiiVpm2mLag==
X-Received: by 2002:a0c:b10f:: with SMTP id q15mr6331977qvc.0.1551916812836;
 Wed, 06 Mar 2019 16:00:12 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:59:04 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-19-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 18/27] Prohibit PCMCIA CIS storage when the kernel is locked down
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

Prohibit replacement of the PCMCIA Card Information Structure when the
kernel is locked down.

Suggested-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-pcmcia@lists.infradead.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 drivers/pcmcia/cistpl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index ac0672b8dfca..8adf092d0e18 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -1578,6 +1578,9 @@ static ssize_t pccard_store_cis(struct file *filp, struct kobject *kobj,
 	struct pcmcia_socket *s;
 	int error;
 
+	if (kernel_is_locked_down("Direct PCMCIA CIS storage"))
+		return -EPERM;
+
 	s = to_socket(container_of(kobj, struct device, kobj));
 
 	if (off)
-- 
2.21.0.352.gf09ad66450-goog

