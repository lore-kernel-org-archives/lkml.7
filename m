Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A08C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9B921852
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EVoDF4XQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfKTICg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 03:02:36 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:51524 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfKTICg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 03:02:36 -0500
Received: by mail-vk1-f201.google.com with SMTP id v188so10962650vkv.18
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 00:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=v9SVguB34yFXQYQCtso1z5KQbnvYcbDvSh9zyizusBA=;
        b=EVoDF4XQ6IM4O3VY1rlvZJ9NaU03JESeIBp1JhoEPnNAstop8a2Sg/TABnt1lUWUKv
         uCaXxaaNnMslFUMqNcw4F1ViF8Fr6Dlj63FwShTfOAf9q8fM4xalLDtanLJNwhTgZBbO
         1nL9suTv3ysFsBKwfJdN0GKAm5LyCiTy1fMhGxmAzU8AEewgUKunXZC/iRbKunERmXs/
         Q60MA0VhhHWJjHScu2r2frQ6siyZH+xaOBPBZJxHnH/RbZxcqB9QLNjVSE0yHRn1hG2h
         3ooScZRGKGEY0X7LjfAEoTkaqgeL1Ibl4CQihrBZwwVFc88hW0oGmJ+WYy9VPSV7cRhT
         ZLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=v9SVguB34yFXQYQCtso1z5KQbnvYcbDvSh9zyizusBA=;
        b=TfNq7lIXWi2ZUGxtomu+Md1y6i/Upmz46wTJoknDtHtulv2Qnf54YebMMpG5CxHjvF
         cQ4AYaK9Ab6VhuTV5ZB6eyn3h8PzNiwSW3X1A4Wsx9UPnvPJ7TJN1y73+/+ZJ4SxZehD
         d43EbNVo5N5Un0YegPYXM2tpZE9h4VD+eiuDXPs+5l2BeBRaMyexd0rNgCE9vjMxN4Vg
         R1lP+Y/FAdycvfnksZbKOh5xY3sR1tEK9fxl018eqe467PHdcss/FIyFZgxA0IFZzOig
         zWprycp2oFWMtzO86O8NTk9pKICttBVMVXC2+EWqB9AXWbb3s0gBVQJ9hpk1vS0D2HQB
         pIRQ==
X-Gm-Message-State: APjAAAVdLyyDFEBDz6bYm0g2zyn4YsrXwEq5HO2uxxFT+hO+TRLbY4jP
        HW5gPW5kKQv6ZxLZVuKWpcZhgZjVn2r6M9A=
X-Google-Smtp-Source: APXvYqyfpv66UxK7JIjpQqQY+CUFYdhkL+YN9jQN8pNakCS0UrbJZPCsgJyVRHGDqPcEszUbvOAbQRddqE0K8kM=
X-Received: by 2002:ab0:765a:: with SMTP id s26mr805288uaq.17.1574236955402;
 Wed, 20 Nov 2019 00:02:35 -0800 (PST)
Date:   Wed, 20 Nov 2019 00:02:29 -0800
Message-Id: <20191120080230.16007-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] of: property: Fix the semantics of of_is_ancestor_of()
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_is_ancestor_of() function was renamed from of_link_is_valid()
based on review feedback. The rename meant the semantics of the function
had to be inverted, but this was missed in the earlier patch.

So, fix the semantics of of_is_ancestor_of() and invert the conditional
expressions where it is used.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index dedbf82da838..0de1e7e69b6e 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -993,11 +993,11 @@ static bool of_is_ancestor_of(struct device_node *test_ancestor,
 	while (child) {
 		if (child == test_ancestor) {
 			of_node_put(child);
-			return false;
+			return true;
 		}
 		child = of_get_next_parent(child);
 	}
-	return true;
+	return false;
 }
 
 /**
@@ -1043,7 +1043,7 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
 	 * descendant nodes. By definition, a child node can't be a functional
 	 * dependency for the parent node.
 	 */
-	if (!of_is_ancestor_of(dev->of_node, sup_np)) {
+	if (of_is_ancestor_of(dev->of_node, sup_np)) {
 		dev_dbg(dev, "Not linking to %pOFP - is descendant\n", sup_np);
 		of_node_put(sup_np);
 		return -EINVAL;
-- 
2.24.0.432.g9d3f5f5b63-goog

