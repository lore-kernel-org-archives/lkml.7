Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AADC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D62223CA
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VPxugwvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfKTHNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 02:13:17 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:39547 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbfKTHNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 02:13:16 -0500
Received: by mail-pf1-f201.google.com with SMTP id z2so17898595pfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 23:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=C84JXx6eiD28S+GBkrYpaPubLQ8qnJVJ5/x3i43xZB0=;
        b=VPxugwvxwAHiOnzTkKNTxlUPbepfKwxGiJ8QCSBPfzo5d+TGN6buFYMRa2lfRykdL4
         mvCy9rsCszUHgIg+GHOqwpmkazIG+H6RRKDHk9f5jUuABO2Ib+334SJJ3xNUmvZqJNna
         WyKbTdxTqaqh/D72QRnt9s4HsKxv16nKK/ddK1M/QlGKNGpP7zsutZ4WwL7Ko2xfLDuJ
         XPCq7Jpc7IkHOtE6ca3Bns4AoQxx57OKN+rxpW00we3pHhi0K00ggRWwFN0CDSdq1RB4
         tON0m8LqG3WlAId6KcIxbwiXZSpRrbAgD8Ln6FTI5va6IwHL4v5K6R56vfm2pSdFdapH
         GN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=C84JXx6eiD28S+GBkrYpaPubLQ8qnJVJ5/x3i43xZB0=;
        b=epsPZldxzxeOrOsgUaQGKn4S9EFYWBku3Q4jdGl3h3w6LnpE2IKQVN2VFD82VvMa44
         yYaptlh/HqvwZY/2M15ReQNP2VtNzsF4jt+RhVDOuIP3rSNI6g67E3ouvzrX4nJ10O0O
         Gn+Zb3N3VBDMtCGChW3FxB8/RhA4Z3zCP28lqlHIJfqFLnSv5PoS7wa7QhrLRL5+XF74
         IILd3AFb9lo+sNk8ppJyY7BfYPhZnkcG72FCrHmOTaWHOnN9LATJzC/KORECfYaPkmul
         11Jcna5ukQ6+5ecsivXFVmlMkqLyKD0KfjoIncTLB7POk5b1m9QtEgDcgab3bu72KDRo
         BUsw==
X-Gm-Message-State: APjAAAUJ+e5iYSOWhbaQ1xNl/eMwjVWuWAKHYI7Ye0UYeEiYFFSkYUpg
        DoTUoLO6VajiRj88CmtFCBql76aHst5kaJA=
X-Google-Smtp-Source: APXvYqy58zvvnUjasx36C47MJ/SoV1H/b/9m3SnQwbO5JHS2q7QDVCp+4vHgJPTHpzJuKaz6Gb0p1WPXtXurK4Y=
X-Received: by 2002:a63:491d:: with SMTP id w29mr1533673pga.294.1574233993280;
 Tue, 19 Nov 2019 23:13:13 -0800 (PST)
Date:   Tue, 19 Nov 2019 23:13:01 -0800
Message-Id: <20191120071302.227777-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] of: property: Add device link support for interrupt-parent,
 dmas and -gpio(s)
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for creating device links out of more DT properties.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 0fa04692e3cc..dedbf82da838 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1188,7 +1188,11 @@ DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
 DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
 DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
 DEFINE_SIMPLE_PROP(io_channels, "io-channel", "#io-channel-cells")
+DEFINE_SIMPLE_PROP(interrupt_parent, "interrupt-parent", NULL)
+DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
+DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
+DEFINE_SUFFIX_PROP(gpios, "-gpios", "#gpio-cells")
 
 static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_clocks, },
@@ -1196,7 +1200,11 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_iommus, },
 	{ .parse_prop = parse_mboxes, },
 	{ .parse_prop = parse_io_channels, },
+	{ .parse_prop = parse_interrupt_parent, },
+	{ .parse_prop = parse_dmas, },
 	{ .parse_prop = parse_regulators, },
+	{ .parse_prop = parse_gpio, },
+	{ .parse_prop = parse_gpios, },
 	{}
 };
 
-- 
2.24.0.432.g9d3f5f5b63-goog

