Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E43C742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4913D20874
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wLKRVzok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfGLXxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 19:53:20 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:37646 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbfGLXxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 19:53:15 -0400
Received: by mail-pg1-f202.google.com with SMTP id n9so3216824pgq.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 16:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tt/DTeQs0nvo9WoetVmfSZpmCFMdgz1aG+kJun8yGvM=;
        b=wLKRVzokAdZ+sOZ0EVqWDmF2WSFfl0Zd8n3dg5gXkMxXk/VYBMY8xoip1vQBsOqGK1
         L3tmmFkecXTHq2Cj/pVkI19ndx+Bm3ubtU6NNRwx0F/GMZhL2N41YsAXN7ZKdLJwRO1D
         frvCfjf0kwJzgFMVwxW8/7IeeBlYXuvPdavLaEooB2dcPkg3UJqNc/T8rrimZncvq48r
         Rd+wBiVcfOQGrmjhOZkYjXnDgZxH1OnUOiUkm+bLKE8ts4ANN8bIkYfW/N4mmvzdh1p3
         OikGbOms/olMsbXXw6IURWCCqsY3Ycth21WtvF+YGiZ7aV56f9f2tj11s7FJf3gFMxaz
         gDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tt/DTeQs0nvo9WoetVmfSZpmCFMdgz1aG+kJun8yGvM=;
        b=Xl3Y8aJlHviS9aD+WG+Ii2B3AuCtM7jB7ASy63HbWiAze83FnBdjAS3GFihLXcS0Hs
         88iaBmHeQbJORGtW1tD1nFCP36ENDnT2YSTrQHYcruivy5qzw29KUEWT2pSYZO3+nBzP
         jJlS9oEOCjoB9ARXQbFWCrd3DYl+7Nz87raGWaDvvV/rrCfcSTZ4GeMsXV96JhgX3Tom
         MMQKIuWlrS2wcIRAgAC4V9XH2OTY9sH0Rs6gb8+D83dwi45+9FXBjzeECXMxryntywkk
         /NM1LQBSz32Nv1FKQeO54dOCHHoQdOn3Q1umA30dWnKtFT9CeCAoT+Otp6qEp0irmJlj
         luCw==
X-Gm-Message-State: APjAAAXzTYljFaQv1PbftvWTFKNALH/+JXnLCDzmi72iAxFB1p6cnim8
        EowECeKzCp8pUPZTHtVgLGfHIeF8UJKDml4=
X-Google-Smtp-Source: APXvYqw00/nq1o/MSeTmkRBVcKK4DJpRz0GCa3SIEHTE3wNs9/3sBfq4wk1F7KycCoDZgeiaLwfs3cKq1BglehE=
X-Received: by 2002:a63:1658:: with SMTP id 24mr14469351pgw.167.1562975594316;
 Fri, 12 Jul 2019 16:53:14 -0700 (PDT)
Date:   Fri, 12 Jul 2019 16:52:41 -0700
In-Reply-To: <20190712235245.202558-1-saravanak@google.com>
Message-Id: <20190712235245.202558-9-saravanak@google.com>
Mime-Version: 1.0
References: <20190712235245.202558-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v5 08/11] of/platform: Make sure supplier DT node is device
 when creating device links
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

While most phandle references in common bindings point to the supplier
device node, there are also common bindings where the phandle can
pointing to a child node of the supplier device node.

Therefore, when trying to find the supplier device that corresponds to a
supplier phandle, we need to make sure we are using the supplier's
device node. Otherwise, we'll never find the supplier device.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 98414ba53b1f..cf8625abe30c 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -529,19 +529,33 @@ static int of_link_binding(struct device *dev,
 			   const char *binding, const char *cell)
 {
 	struct of_phandle_args sup_args;
+	struct device_node *sup_np;
 	struct platform_device *sup_dev;
 	unsigned int i = 0, links = 0;
 	u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
 
 	while (!of_parse_phandle_with_args(dev->of_node, binding, cell, i,
 					   &sup_args)) {
-		if (!of_link_is_valid(dev->of_node, sup_args.np)) {
-			of_node_put(sup_args.np);
+		sup_np = sup_args.np;
+		/*
+		 * Since we are trying to create device links, we need to find
+		 * the actual device node that owns this supplier phandle.
+		 * Often times it's the same node, but sometimes it can be one
+		 * of the parents. So walk up the parent till you find a
+		 * device.
+		 */
+		while (sup_np && !of_find_property(sup_np, "compatible", NULL))
+			sup_np = of_get_next_parent(sup_np);
+		if (!sup_np)
+			continue;
+
+		if (!of_link_is_valid(dev->of_node, sup_np)) {
+			of_node_put(sup_np);
 			continue;
 		}
 		i++;
-		sup_dev = of_find_device_by_node(sup_args.np);
-		of_node_put(sup_args.np);
+		sup_dev = of_find_device_by_node(sup_np);
+		of_node_put(sup_np);
 		if (!sup_dev)
 			continue;
 		if (device_link_add(dev, &sup_dev->dev, dl_flags))
-- 
2.22.0.510.g264f2c817a-goog

