Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295F9CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED19F218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bb0GM5MS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390719AbfJ1WAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 18:00:51 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:40723 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733276AbfJ1WAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 18:00:47 -0400
Received: by mail-pl1-f201.google.com with SMTP id f10so6881906plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 15:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ukpi3nf6Ccj0NPps1DEia34Fh1Y1K6ULN6sRoVS7jm8=;
        b=bb0GM5MSoyGi8NIAFn3/DHCH0XRkiFMVmCUChuT7/6zrAVzgyDGF1auYVOJfhs7H/u
         S3HfpZziQ/hoFGtHmgHyvXzazBa9Cc5N56+oTe5Lscdb0DLcHLMFCCiaePTsB+44MMB6
         v6zrjCnxUzbwrqUWvmF2m+N7pAFfATDmAzkkU4lqZLEg+cQTgkkKC4fel6CXRZxiEbz3
         KssYpg4ZtqO2QAYwMeSPe4WIjHIBaUJXkGfrxA78Ij4kOUAYeVvue/tWc8UKceu+u4S+
         +TKgVT9pbpEA+kPuvaDXktiGBu2cLNAKUXwS+RCQt8TWnlJw2hA9OLRDI5H1h///ekhR
         cgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ukpi3nf6Ccj0NPps1DEia34Fh1Y1K6ULN6sRoVS7jm8=;
        b=s/fC7B3rPWLfKmkT1Tv6GO5T8idCcSQv68cycYn5BlFTrDmE7GfkvkVuBk+3WPs8zD
         ZX/4tJD/oJD6h6N1raVPZrj9efGaoyFjbUKtjZPqXCX4jS/qtCMXM3Tb84jpcXNG+9yc
         6yEO/59ME42spnPEPwBxbf2EFgoNX8Ll4pLmJvZIlxzVpJ7w6cHoBbDVD/fJTc4D35Di
         NGq9HB3hqDlnsmbFb29uxKw6ppTDKY8hK7id/JCNFlur8pnfWsVE0VxdTv31oRRo+OnN
         hXgLNIRvuNDq5bmnJJDQyg597rpackce3QEjVRUbcqEOLxCJA0jt8NZFzlgBZ44RoPzt
         w8GQ==
X-Gm-Message-State: APjAAAVhgM0pQto0wZBV0qRqsORe5t0OGa3z+FQm4KPnATTXm10JsX84
        fyhyQog6c1+ZOn7Q1v6GBfB53Nk+0pkQaPU=
X-Google-Smtp-Source: APXvYqwSzFW+0pdVmCL1Iwg9wofXL1u2TvqvPQ2942w6raECJ/0R34lyrQI5HBJOGEpOyS+HE2reeybrz/Jjv1k=
X-Received: by 2002:a65:6092:: with SMTP id t18mr23294242pgu.418.1572300046743;
 Mon, 28 Oct 2019 15:00:46 -0700 (PDT)
Date:   Mon, 28 Oct 2019 15:00:26 -0700
In-Reply-To: <20191028220027.251605-1-saravanak@google.com>
Message-Id: <20191028220027.251605-6-saravanak@google.com>
Mime-Version: 1.0
References: <20191028220027.251605-1-saravanak@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v1 5/5] of: property: Skip adding device links to suppliers
 that aren't devices
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices need to be initialized really early and can't wait for
driver core or drivers to be functional.  These devices are typically
initialized without creating a struct device for their device nodes.

If a supplier ends up being one of these devices, skip trying to add
device links to them.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index f16f85597ccc..21c9d251318a 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1038,6 +1038,7 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
 	struct device *sup_dev;
 	int ret = 0;
 	struct device_node *tmp_np = sup_np;
+	int is_populated;
 
 	of_node_get(sup_np);
 	/*
@@ -1062,9 +1063,10 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
 		return -EINVAL;
 	}
 	sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
+	is_populated = of_node_check_flag(sup_np, OF_POPULATED);
 	of_node_put(sup_np);
 	if (!sup_dev)
-		return -EAGAIN;
+		return is_populated ? 0 : -EAGAIN;
 	if (!device_link_add(dev, sup_dev, dl_flags))
 		ret = -EAGAIN;
 	put_device(sup_dev);
-- 
2.24.0.rc0.303.g954a862665-goog

