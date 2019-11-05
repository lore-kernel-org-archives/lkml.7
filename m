Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9DDCA9EC7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7433A217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kNXbtHFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387769AbfKEGuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 01:50:16 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:46325 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387569AbfKEGuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 01:50:16 -0500
Received: by mail-pl1-f202.google.com with SMTP id a5so2634969pln.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 22:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uOGehhWZgUVKoLCu9uPvy6GNYBcrgHwxU8kr8wE+agE=;
        b=kNXbtHFqBug+/oU8bSdHAs+qVLw4TxE9aiRKiowEJ21d0hfBCS6YHf/kqC5JAviop6
         ZELVuK1m500L8/nK08PErToeZYzfk4mHeZo5UvmKYPXkb9eLidNex7+SYhvOC953oNn3
         b+Kih+0HggJ4LjnpQwgSVisfSXxky5OPZuh/cz7u8F7X06dRI44sQVjACCIHmzada2gV
         9NIQUNHYW/HeRo6MIc5ur9zwHv/Ku4B0xkGa4k9vNz6JjEeJcDmet/pdaF28PEPRFNIu
         bNVKzrAMbpw4Kvgl0/yKVBxhLV9nzB7ZyMovUx3BILktQy4L+ADiidSYmMaGSKwlvqc3
         UEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uOGehhWZgUVKoLCu9uPvy6GNYBcrgHwxU8kr8wE+agE=;
        b=ZINoRMuFYTWXtDtvWXWtvl0dLP0yHCEjmYdqafPbmgiKTCKqnG1LnQuhrz6PpGGo5O
         jSsLLJoXa6gVD1gLsViMqxAJrtgdYv1SsmKgO2Z5yI6aXVow3FxBUoqndiP4A5WKWNlG
         JTlmd5Mkb1UE5U72tBTuOsQT1dj5LRKYkHbXDEW4kGuxIC/z0+eVPXBvzinY5+cQs8hJ
         3PX52sH9Lu8EEqQGBbfV76Y+zzIVdhj4ZGlg+MXZPaJtkceuzaQgG1uUFRiQ+hGXEi9u
         XbXpOwbU2GlQ1cbNSG05YX08INsh3cU/ZOseRnroh/XjOgTyrba1TPA7stiDNKRJp3sB
         ZH0w==
X-Gm-Message-State: APjAAAWjrIPA2DxFma0uzcbOb4hdqDt8oUgMShQ8WWOpB/3wHsOZiZiP
        N0+XYwo/gkDaa8QJ6nGJtH1PBkSNkbt6MqU=
X-Google-Smtp-Source: APXvYqxH7DTIrxXLzr6jLIklHMp5HeuCMdHVPfadC/hCVXWPxQo+eNZe9jARv5mXlPGzx8C3yGjcz4nA9zmOrU8=
X-Received: by 2002:a65:4c41:: with SMTP id l1mr35228412pgr.163.1572936613516;
 Mon, 04 Nov 2019 22:50:13 -0800 (PST)
Date:   Mon,  4 Nov 2019 22:50:00 -0800
In-Reply-To: <20191105065000.50407-1-saravanak@google.com>
Message-Id: <20191105065000.50407-4-saravanak@google.com>
Mime-Version: 1.0
References: <20191105065000.50407-1-saravanak@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v1 3/3] of: property: Add device link support for iommus,
 mboxes and io-channels
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for creating device links out of more DT properties.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 812b69a029d1..0fa04692e3cc 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1185,11 +1185,17 @@ struct supplier_bindings {
 
 DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
 DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
+DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
+DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
+DEFINE_SIMPLE_PROP(io_channels, "io-channel", "#io-channel-cells")
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 
 static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_clocks, },
 	{ .parse_prop = parse_interconnects, },
+	{ .parse_prop = parse_iommus, },
+	{ .parse_prop = parse_mboxes, },
+	{ .parse_prop = parse_io_channels, },
 	{ .parse_prop = parse_regulators, },
 	{}
 };
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

