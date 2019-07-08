Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC49FC606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA68216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tTgk5Tee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfGHW4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 18:56:54 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:35550 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbfGHW4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 18:56:51 -0400
Received: by mail-pf1-f202.google.com with SMTP id r142so11179250pfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 15:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zu6AdTATFD4ZE9loxoxyWukrBCqkYU2rnfNDEw4rbbE=;
        b=tTgk5TeemfmHzhA11ZfxhP3IqZlPZymIiHUS4zAvJX8eS1cvOt5qrvUsJbcqvKK9Rv
         dynvGuWWtUbHVnBlrPBLLFcNu2oLaQI+uh6e5dkOZk1Ux2E/YF/UOJ4t0wQDBaBLSMVe
         nGQT24EVsbDYsc+3b0flRRLJ4CswVeEh8M7dpfksJVLNvkDxfoh1br8IjrterPhOIPLp
         UApIxHtdm6UGaHUPMcifdk8NcCf6i9R/5eBdaw0pkA0py2TgDjXNk422wPO9mANgeqUw
         hwf1icWC4Onwim9R7Sh67WjyE7x0ALTSJ6+DOaL+iCJ8GdVM5ywoz8ie2T7XfC9otnUC
         jXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zu6AdTATFD4ZE9loxoxyWukrBCqkYU2rnfNDEw4rbbE=;
        b=Z3j96Qb/B9Pe1muTRGY5jfrB5XTOC373uBFLducG2KJV2lrtM5v170Pp45sOLDFsaJ
         2g8cPRUrIhVpVUz9idSIvcv2q7A4sGZR7UA4hL1RnJzPX63fEbuGWiYVyDaFrDeKO0sL
         KceP7nO3chY3YtRMPXQ/2Oor3RZnz7PJYAd8r9KdIGr3IutmmzandfHjbK8SU1lEqwDx
         l8TI39jjWqWg7egQ2HA4/UAEa1QaSTaf5P+ykjriWgn71De5FYYdOGSW/qm+f0YByHNA
         W2MODkte4UVDZpJy+pytBWb1PdMyX95oWSjj/07l4T9b7X8ipliwkdF3l7IqN+ab50NR
         YJuQ==
X-Gm-Message-State: APjAAAXZs9+YAP3tPr9ZN/3VpL/+Tj4aG8lYUsLbZnNTBeuOdyiTkM6S
        eFZC28AisRPODg1tKa4cBcckx6Bcu0igw7A=
X-Google-Smtp-Source: APXvYqzA3e6ZqiC442jLeAvlq2VIwrxODvvReLfzb6pDluX81Ne/1fLcRfvzsUQz8Zi4q0n06Rqql5Logkju08Q=
X-Received: by 2002:a63:1950:: with SMTP id 16mr26513759pgz.312.1562626610106;
 Mon, 08 Jul 2019 15:56:50 -0700 (PDT)
Date:   Mon,  8 Jul 2019 15:56:23 -0700
In-Reply-To: <20190708225624.119973-1-saravanak@google.com>
Message-Id: <20190708225624.119973-8-saravanak@google.com>
Mime-Version: 1.0
References: <20190708225624.119973-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v4 7/8] of/platform: Sanity check DT bindings before creating
 device links
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a common DT binding is pointing to a child DT node of a particular
parent DT node, don't add device links for such DT references. This is
because, by definition, a child node can't be a functional dependency for
the parent node.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index dba962a0ee50..98414ba53b1f 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -512,6 +512,19 @@ int of_platform_default_populate(struct device_node *root,
 }
 EXPORT_SYMBOL_GPL(of_platform_default_populate);
 
+bool of_link_is_valid(struct device_node *con, struct device_node *sup)
+{
+	of_node_get(sup);
+	while (sup) {
+		if (sup == con) {
+			of_node_put(sup);
+			return false;
+		}
+		sup = of_get_next_parent(sup);
+	}
+	return true;
+}
+
 static int of_link_binding(struct device *dev,
 			   const char *binding, const char *cell)
 {
@@ -522,6 +535,10 @@ static int of_link_binding(struct device *dev,
 
 	while (!of_parse_phandle_with_args(dev->of_node, binding, cell, i,
 					   &sup_args)) {
+		if (!of_link_is_valid(dev->of_node, sup_args.np)) {
+			of_node_put(sup_args.np);
+			continue;
+		}
 		i++;
 		sup_dev = of_find_device_by_node(sup_args.np);
 		of_node_put(sup_args.np);
-- 
2.22.0.410.gd8fdbe21b5-goog

