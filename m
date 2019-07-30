Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB37C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B03206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZOU0EuLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfG3Fiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 01:38:55 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32921 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbfG3Fiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 01:38:51 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so28355545plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 22:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pne7qN8OQcDPBPEgu6IMUIvh4yQYOYprmqwJEV4YkPU=;
        b=ZOU0EuLk9k5y2mlcqwoNPv6X9BD7fmwO6xvwpR5qL7uuP558exRXf/8On7dFBaEhWX
         BcpUXMb2x+5GLSz2AUQwVfkWk6j3owSCERfHwRKue1TgRn/fN00ncWiPoIityuhXi5x8
         p2Zgh/kbUCPbN6Cu/TNKfjsQ6xIN45prMdekA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pne7qN8OQcDPBPEgu6IMUIvh4yQYOYprmqwJEV4YkPU=;
        b=P3qAlk1+4fdJcghawRK0Toka8GU81hdzLirruxxW8W7MKu+fiLqwg48TFkMD4A6mog
         pKlWLmUc4SMO1y2sQLdufkBicPPYWOiEb7vXcrDAaDpe2diVjCn+dPUns+HlCprAa1/Z
         bXKxBkLnVgPgJg6/+iyzXP6qLLW/oMSqL9l75okP8iHuitP/vL/crj7iibzgebuB1u+h
         onQYjzpr3nCAb25W1ed5AkI38f1ApVfztWQpoLMfElphPkViPk0t701UdlgSUJuTIxCV
         o5wv4HHL+oJ/i505ZHK8iSg6gt1qjLHHs+4hwjUgpd6NkSxWjcfMRpX25tXYxUJ52zuK
         XeEw==
X-Gm-Message-State: APjAAAVtg+rAU6cXYhraQPfHa0+hUE62xGd/prNYWzGJ8D6FdC09J923
        afMXiouJMbmJkrUvHhkiWEeJIw==
X-Google-Smtp-Source: APXvYqw2q+vi9PITZEeG7c6nqF5yZPddg3BMcleKfYNYcT6OOK1M55SCxr1F/kz3wtoMW/1VMb/LDA==
X-Received: by 2002:a17:902:758d:: with SMTP id j13mr111782528pll.197.1564465130964;
        Mon, 29 Jul 2019 22:38:50 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r1sm59306805pgv.70.2019.07.29.22.38.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 22:38:50 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v5 3/3] coccinelle: Add script to check for platform_get_irq() excessive prints
Date:   Mon, 29 Jul 2019 22:38:45 -0700
Message-Id: <20190730053845.126834-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730053845.126834-1-swboyd@chromium.org>
References: <20190730053845.126834-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a coccinelle script to check for the usage of dev_err() after a call
to platform_get_irq{,_byname}() as it's redundant now that the function
already prints an error when it fails.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Markus Elfring <Markus.Elfring@web.de>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

I'm not sure this will be accepted or not given that Markus indicates a
similar patch was made for other error messages that this may be able
to be merged into. Just sending again anyway to keep things together.

 scripts/coccinelle/api/platform_get_irq.cocci | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 scripts/coccinelle/api/platform_get_irq.cocci

diff --git a/scripts/coccinelle/api/platform_get_irq.cocci b/scripts/coccinelle/api/platform_get_irq.cocci
new file mode 100644
index 000000000000..543ae11400e7
--- /dev/null
+++ b/scripts/coccinelle/api/platform_get_irq.cocci
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Remove dev_err() messages after platform_get_irq*() failures
+//
+// Confidence: Medium
+// Options: --include-headers
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+@depends on context@
+expression ret;
+struct platform_device *E;
+@@
+
+ret =
+(
+platform_get_irq
+|
+platform_get_irq_byname
+)(E, ...);
+
+if ( ret \( < \| <= \) 0 )
+{
+(
+if (ret != -EPROBE_DEFER)
+{ ...
+*dev_err(...);
+... }
+|
+...
+*dev_err(...);
+)
+...
+}
+
+@depends on patch@
+expression ret;
+struct platform_device *E;
+@@
+
+ret =
+(
+platform_get_irq
+|
+platform_get_irq_byname
+)(E, ...);
+
+if ( ret \( < \| <= \) 0 )
+{
+(
+-if (ret != -EPROBE_DEFER)
+-{ ...
+-dev_err(...);
+-... }
+|
+...
+-dev_err(...);
+)
+...
+}
+
+@r depends on org || report@
+position p1;
+expression ret;
+struct platform_device *E;
+@@
+
+ret =
+(
+platform_get_irq
+|
+platform_get_irq_byname
+)(E, ...);
+
+if ( ret \( < \| <= \) 0 )
+{
+(
+if (ret != -EPROBE_DEFER)
+{ ...
+dev_err@p1(...);
+... }
+|
+...
+dev_err@p1(...);
+)
+...
+}
+
+@script:python depends on org@
+p1 << r.p1;
+@@
+
+cocci.print_main(p1)
+
+@script:python depends on report@
+p1 << r.p1;
+@@
+
+msg = "line %s is redundant because platform_get_irq() already prints an error" % (p1[0].line)
+coccilib.report.print_report(p1[0],msg)
-- 
Sent by a computer through tubes

