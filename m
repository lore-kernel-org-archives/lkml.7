Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA375C742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCF420874
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vBSRrli9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfGLXxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 19:53:16 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:34323 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbfGLXxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 19:53:09 -0400
Received: by mail-vk1-f201.google.com with SMTP id g68so1362995vkb.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 16:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CAlHJy5+PE+GUC+yGE/HoGyC126T/YkJLT0emjsVwvg=;
        b=vBSRrli97XKmYjaFIGkTrcpCdCNGuE+h8IhFrSjimPFbqLeAsD6MGB4jNFhsSO9U16
         aO7Hsb3DRlpZOw7nW7ieuCskwIYYeq4G9U9Dc4U6kCs6M4zxBv4owXK9H/L870Onwxyf
         Eb1rfA+W2CsEK33teA2bvZH4zYIXX4TxdFtbSRVakoxy1siyL2ZEMCCh4Dj5ajB3Z1DW
         Knm77sDEisIgodbyts3qx9jkiRdo4T2aotiJnFF5XbFfJnCtGYjsLoJh5/v4zTZFQZIf
         4qDSWvdPfYiUQj6h9dF5/U8AA1a8iBbFTjoB0iGNbPtwSHYVIVJNarpjiaR8y3iHb3t2
         IOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CAlHJy5+PE+GUC+yGE/HoGyC126T/YkJLT0emjsVwvg=;
        b=iYftUcrccZe1veVfMK+9krSGyX8vAy9W7lDcfLyp52LzacFVvFdgn9zvcGfg6hJUKV
         faFPv1g9w71ClEUUEOitjBD8SxvHutrIXcnDsg9hnJ/q9J+mSsGgFBZgmYE8kmx8bUjv
         zp6nVkkg82wpk6apGgrl/LHIUGpNhN0FOOVG/QNZt+ybr0Rcv4aTCSAy+ec9aVVpUp9a
         ODQnk+NmnhIM2kPQ+vxGd8sxrFApH+sgwuqx0J1IoozEm/yY37HfMd2oZndMUHVSj2N7
         nwWsaEv1F831VBVNOimhTmfdCsiSnLvlCqkTNbcWpABIL4Vwsd5xqYL++1bJ4STEWax3
         zdRw==
X-Gm-Message-State: APjAAAU6bP0lvkokNTd7w4G72nwf7H6JlVTForCe/SyW2SFJqTqyEA0X
        4zf0CkjEzQ+sCxjbVQkQk38bI5c8W9UNJc4=
X-Google-Smtp-Source: APXvYqzwP48zLLPRZS7QmxTr3oncKEyLjcgCl8Hybw1d/cNDtpOqX9dKb2Tc4NdPmWjX/kIB8o1avR2Bs7ubFXg=
X-Received: by 2002:ab0:2556:: with SMTP id l22mr10397175uan.46.1562975588442;
 Fri, 12 Jul 2019 16:53:08 -0700 (PDT)
Date:   Fri, 12 Jul 2019 16:52:39 -0700
In-Reply-To: <20190712235245.202558-1-saravanak@google.com>
Message-Id: <20190712235245.202558-7-saravanak@google.com>
Mime-Version: 1.0
References: <20190712235245.202558-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v5 06/11] of/platform: Pause/resume sync state in of_platform_populate()
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

When multiple child devices are populated using of_platform_populate()
after kernel init, there could be supplier-consumer dependencies between
the child devices.

Wait for all the devices to be added and linked before calling sync_state()
on all the suppliers.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 56b718f09929..dba962a0ee50 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -486,6 +486,7 @@ int of_platform_populate(struct device_node *root,
 	pr_debug("%s()\n", __func__);
 	pr_debug(" starting at: %pOF\n", root);
 
+	device_links_supplier_sync_state_pause();
 	for_each_child_of_node(root, child) {
 		rc = of_platform_bus_create(child, matches, lookup, parent, true);
 		if (rc) {
@@ -493,6 +494,8 @@ int of_platform_populate(struct device_node *root,
 			break;
 		}
 	}
+	device_links_supplier_sync_state_resume();
+
 	of_node_set_flag(root, OF_POPULATED_BUS);
 
 	of_node_put(root);
-- 
2.22.0.510.g264f2c817a-goog

