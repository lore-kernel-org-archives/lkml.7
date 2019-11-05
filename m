Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB6DCA9EC7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7D0217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vUzRIv/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387642AbfKEGpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 01:45:12 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:33598 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387586AbfKEGpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 01:45:11 -0500
Received: by mail-pf1-f201.google.com with SMTP id s24so4650211pfd.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 22:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uOGehhWZgUVKoLCu9uPvy6GNYBcrgHwxU8kr8wE+agE=;
        b=vUzRIv/2PDghmvnw9rVBASojH8O7qO7BRdTsZxQ5eMoiwNwmO1zPP40Q59AkhRbjLy
         8yLLQSajwQ+U00YF0GZiq+JvGVpzOneNzV+z91JKg+gIidUQNTKKFZWfs4RHr6qiZJVr
         q205UVk6UriZ4t+g+CXb9EpCgYFRQCq9g6ZqJkqEvWjtfTdEBVLPgc43aIRGAypeGvco
         J+fEMvYvmw90IE/dJ+bkayWODd5GuMTyzbAnHkTSp3hfBJ+sV3NBmHUK6oi0T6/A3jzM
         KK/o/RpxbfT9s0GGJHKd3Yi25k6rnzC2Y9COjrw/ISiPHykqloGJAJkqXAi6alEgvQfP
         bRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uOGehhWZgUVKoLCu9uPvy6GNYBcrgHwxU8kr8wE+agE=;
        b=KUlhs+gsSOhi/MPigzi/R1BQ140wUaiP3yY8RRTMFnDnrjr2hqblNQOHB2RHQzCpHF
         xkS6WBO4q577dRy8enpnhcWrN59hXTvqL/Kke7oT/jOgLfQp/oKsISeqw1ugmMbUdUQa
         B1qZMJZc8GNhLFw89cRqUDP32DRj1/vBDzrR103hnAzaEhwPCXtMHCApvF0/gYSSncUC
         TxtupvN/KfPgANWnZ9k/8kuOqYCktyXNyB9aEvHBXmQ32i/d8MNeQbUuIXsBW90F1II2
         3Zh3xJSEdfGBlt5rpq02wgNZeOWY3OSRTjtQT3c0AquL8b7Ntxs0MCV7tx9RlUHLzNRb
         i5oQ==
X-Gm-Message-State: APjAAAUzBa1bPT53lR/QtHuDTt7R19HC6bXTUmOjSc7G1Ywi+xdp7IHF
        tv7OWED+5oKQH0a0KuRxMq3r94nSeaPtfTw=
X-Google-Smtp-Source: APXvYqwaX9o+xhbZdnc91VSu2I/Dnb1YJqF2Lfci4ZBRM0SNaH8Zs2+tatmB25BXH45BJuY9FNhdEaiHvzDf9bs=
X-Received: by 2002:a63:d4c:: with SMTP id 12mr34357755pgn.127.1572936309333;
 Mon, 04 Nov 2019 22:45:09 -0800 (PST)
Date:   Mon,  4 Nov 2019 22:44:55 -0800
In-Reply-To: <20191105064456.36906-1-saravanak@google.com>
Message-Id: <20191105064456.36906-4-saravanak@google.com>
Mime-Version: 1.0
References: <20191105064456.36906-1-saravanak@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v1 3/3] of: property: Add device link support for iommus,
 mboxes and io-channels
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

