Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C77FC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D5A20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UvMLR0gF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403788AbfGWSQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:16:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42878 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403776AbfGWSQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:16:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so19534872pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 11:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OLwyoJ6pVDz0G0PmMPVZ49Vzk432XscoeBSyluf/+Es=;
        b=UvMLR0gFrugwu+qNlk7hoiHUatTym5tN//BnB1PAxf611waIoRZC2VCzHKAtlKQRTb
         8ViWegY8BtT2/hQl8kY7fFLE+1T4Ib/446Y1l3Wj8238eQGQ1lLNI2qdRxj8nZB4SSsy
         ECd38YGQmrrc4ZiN3qrJc+avnAguckDeGJHtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OLwyoJ6pVDz0G0PmMPVZ49Vzk432XscoeBSyluf/+Es=;
        b=Esf77MiROyH/3wapTOhANJ5TQEQrjRHnNcsA2XvBw7ZU2XQTRgACZeXppdT8JAgJlS
         LLyRrrgygC4k0/Yzg8lxYOxk08+l4OLJ674R/KoOZoBAl2/7tRgA9xrtcH5Fp0gRL3cZ
         voQRcJDNipB3tFofe+LOgDEfvP94nN/ce61X4IcgpFl4xK2GKAa/bH98VJPMoirWllM+
         hSNv+TPlGdN6z6Ouk+rGCu5awcLI+cLPjgN/0qpMWv3BsI5R3qQF3eCapeK6mqbWQzEt
         cqjYA0Yok4hythhS+5cpnzn/1JgK6yw2NDhYBdRi2uWhK1oWR03cuKxcPFqYnsx1T8hB
         JVDw==
X-Gm-Message-State: APjAAAW9zMkko80LnLFnGEoOa6NUe2zP+GwCO5AkyEUAFVLpGdyDVBgG
        eOShwUhTcsLW/wIVdxr2jaIlyw==
X-Google-Smtp-Source: APXvYqxZ5bomXdiJfzj5C5d7M1LmytH3cR4UHCbSofpK/86Jrw7Ca5mHBrhIZVgdXtZ2mTqWLr4N6Q==
X-Received: by 2002:a62:2aca:: with SMTP id q193mr7238612pfq.209.1563905789244;
        Tue, 23 Jul 2019 11:16:29 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k64sm24849104pge.65.2019.07.23.11.16.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 11:16:28 -0700 (PDT)
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
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 3/3] coccinelle: Add script to check for platform_get_irq() excessive prints
Date:   Tue, 23 Jul 2019 11:16:24 -0700
Message-Id: <20190723181624.203864-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190723181624.203864-1-swboyd@chromium.org>
References: <20190723181624.203864-1-swboyd@chromium.org>
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
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 scripts/coccinelle/api/platform_get_irq.cocci | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 scripts/coccinelle/api/platform_get_irq.cocci

diff --git a/scripts/coccinelle/api/platform_get_irq.cocci b/scripts/coccinelle/api/platform_get_irq.cocci
new file mode 100644
index 000000000000..6ec6e70bbbba
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
+platform_get_irq(E, ...)
+|
+platform_get_irq_byname(E, ...)
+);
+
+if ( \( ret < 0 \| ret <= 0 \) )
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
+platform_get_irq(E, ...)
+|
+platform_get_irq_byname(E, ...)
+);
+
+if ( \( ret < 0 \| ret <= 0 \) )
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
+platform_get_irq(E, ...)
+|
+platform_get_irq_byname(E, ...)
+);
+
+if ( \( ret < 0 \| ret <= 0 \) )
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

