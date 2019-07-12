Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28514C742D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0068720874
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NuFa6cXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfGLXxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 19:53:39 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:39928 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbfGLXxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 19:53:12 -0400
Received: by mail-pl1-f202.google.com with SMTP id r7so6011365plo.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 16:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u0aCbzfqst+D0QpebqfgPDDHqeCzNETI6rpepbYOqAg=;
        b=NuFa6cXOZ03xsdBH/ZfK+iY9xs3bPy/PkCnlYauhFuo7hp8ItcNakBHm6+e4a6FW2/
         Qy9eIPHN9QVYImgGz3vPgOgEL1Rh9APmS9LNzfVQyfr6nhAZXkcaPKv770hkuZ4I7FQo
         mPmItCpQQAy5CB2VrS/cMO2g4JsLM8S1emnd+9zU3+Xe0k044I2r6InPphZxx4momvaj
         7uKzqvPnB8g0uXab+/biy4Ex+MSTlHVndbwTeKi+rsrxW1L6kkIj29IQXCIfhS160bMb
         o/0MTn6NSnijj7JgBcEIScY75jodS+cD0NP6BucvNliohtB+o9sS3ZOoYnFmDXIwDtgE
         sliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u0aCbzfqst+D0QpebqfgPDDHqeCzNETI6rpepbYOqAg=;
        b=kQLvCaoN9t0MN/NDkAfTQLU9IHMLK03RiGPUGreLmrZrrOnMQPpNvLh8LfCEUzEAdF
         pdPvx3aLQ2JI9lak6q9E93UuF0jCCfXMXj6Jt0aA3VHfVieyhcU9UUohjwRBPOlRzKV1
         JBa+evjMfoe8GRJoqGu4RXo6nRHgW2/+PA25adQ49vYx9JRdEwEIy9ShA2MTIXGAq04F
         ncdYne+Gu/MLR1I9U48rJGHJO0F4O0oaVvJUKTvRr1LDdMPcRbhE8u3cb3FBY6sxGMi9
         BHqtjGvJ5UUPidVdIXDs+7iHi5iSonzN7HMl0tSngd4vgLxZgN2rswOhdnum4j0qQZJz
         S8Jw==
X-Gm-Message-State: APjAAAXf5hnR9WcU/X20nvj1uTxeYdvhv0i4qub2A3LV6NA5NKeYeRqN
        RaTwBkh2++8Or/GKovFdln2ZlARrq0DxaTU=
X-Google-Smtp-Source: APXvYqyWvabAfyxvg6UIJqiHNYu3Re+Ps/dXojaoKmsWOUDI0X+STCObr0nnDdxk3G7ga5ZyPciHY8ModRXmB94=
X-Received: by 2002:a63:e90b:: with SMTP id i11mr14217259pgh.351.1562975591373;
 Fri, 12 Jul 2019 16:53:11 -0700 (PDT)
Date:   Fri, 12 Jul 2019 16:52:40 -0700
In-Reply-To: <20190712235245.202558-1-saravanak@google.com>
Message-Id: <20190712235245.202558-8-saravanak@google.com>
Mime-Version: 1.0
References: <20190712235245.202558-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v5 07/11] of/platform: Sanity check DT bindings before
 creating device links
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
2.22.0.510.g264f2c817a-goog

