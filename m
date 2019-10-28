Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B50ECA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96C821835
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yk6qAWI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390671AbfJ1WAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 18:00:43 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:38309 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390632AbfJ1WAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 18:00:41 -0400
Received: by mail-pf1-f201.google.com with SMTP id d126so9691681pfd.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 15:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1WpJs4rqFlazEgG1ALqWM9ztjxvHbXQZYC6yFmWs2yk=;
        b=Yk6qAWI2BvbfBU05Wsff0PGaMNDhMIm5Rg86/K6xfu7Ma5L7ToyW6RNRjxoM4Zg0TZ
         G7EswA38UEa/5hWjOs9Rj9+aAM2uTwa/DxQemqAUpjIyuZ01xRkLERXg1ZB4q4hp2Bmb
         /lK0wtpMAUCxYWy4n40EF5mTihZrzbqmuJuNUzYwBkHijNaSOWbWatRM5osGKG8e5G40
         g7xTXzNsFUFuPKgTLNK+cAxfUNPX66DJKbpl6ZuVMygFxzMPMNLx2pczWyj4jM7jF8oQ
         atYJOzCIhoGGv1hCrpbhZGpW+SA9MrnblLyteW4ZN5WRcvlKTrZXt4paFNSBfkYgtf8S
         RdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1WpJs4rqFlazEgG1ALqWM9ztjxvHbXQZYC6yFmWs2yk=;
        b=ST0qk5GHgqHhjdPUe8IiYj73aD32xRBlADdMKTkicQnx7vT9W1JBRNaoZPFoM0vU5r
         k6Fx4Caq5E5AXW17UXMn3JtLaDLa/4avWhpYaIRSo8kuCET4TODucXqn1EX4sz1J/2qU
         rt9Vq1BHAr1fhahwYljWyo1QLgij1ZWYT9g3MP59uZEeNuC07fCzyy3YSwkndTo1GRE2
         fSAwwYHtWYhkojBktFElftkEJKtcBSkFDEquGl8xf6bB8LXuOuQI5NztrUdKtV7+OotW
         zfZFfFpcR76sWnPm4Cj9R23oFZ6ZDwNv93HBHyITOg1JYh2RuGR4Pv8EyF269kmBO1Qn
         7n6w==
X-Gm-Message-State: APjAAAViCStAsS0cD/oz9wxnz3ZDuV4gUiosiN0BdHpQWDf0LU/AiFTf
        ok77PIiJNBENLAtILKfxkYgv5lFFzHj/IUI=
X-Google-Smtp-Source: APXvYqy9nquaj1y+oeAHBa2FvIbJ3pRLRVkY7Q7QAx/FpyzTrOehqtDTnU4RgtT4SEkxlu/hY0FIOMFzyx2ixSk=
X-Received: by 2002:a65:554e:: with SMTP id t14mr21065330pgr.370.1572300040549;
 Mon, 28 Oct 2019 15:00:40 -0700 (PDT)
Date:   Mon, 28 Oct 2019 15:00:24 -0700
In-Reply-To: <20191028220027.251605-1-saravanak@google.com>
Message-Id: <20191028220027.251605-4-saravanak@google.com>
Mime-Version: 1.0
References: <20191028220027.251605-1-saravanak@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v1 3/5] driver core: Allow fwnode_operations.add_links to
 differentiate errors
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

When add_links() still has suppliers that it needs to link to in the
future, this patch allows it to differentiate between suppliers that are
needed for probing vs suppliers that are needed for sync_state()
correctness.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 12 ++++++++----
 include/linux/fwnode.h | 13 +++++++++----
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 48cd43a91ce6..e6d3e6d485da 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2297,7 +2297,7 @@ int device_add(struct device *dev)
 	struct device *parent;
 	struct kobject *kobj;
 	struct class_interface *class_intf;
-	int error = -EINVAL;
+	int error = -EINVAL, fw_ret;
 	struct kobject *glue_dir = NULL;
 
 	dev = get_device(dev);
@@ -2413,9 +2413,13 @@ int device_add(struct device *dev)
 	 */
 	device_link_add_missing_supplier_links();
 
-	if (fwnode_has_op(dev->fwnode, add_links)
-	    && fwnode_call_int_op(dev->fwnode, add_links, dev))
-		device_link_wait_for_mandatory_supplier(dev, true);
+	if (fwnode_has_op(dev->fwnode, add_links)) {
+		fw_ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
+		if (fw_ret == -ENODEV)
+			device_link_wait_for_mandatory_supplier(dev);
+		else if (fw_ret)
+			device_link_wait_for_optional_supplier(dev);
+	}
 
 	bus_probe_device(dev);
 	if (parent)
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 25bb81f8ded8..a19134eae5a5 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -96,10 +96,15 @@ struct fwnode_reference_args {
  *		available suppliers.
  *
  *		Return 0 if device links have been successfully created to all
- *		the suppliers of this device or if the supplier information is
- *		not known. Return an error if and only if the supplier
- *		information is known but some of the suppliers are not yet
- *		available to create device links to.
+ *		the suppliers this device needs to create device links to or if
+ *		the supplier information is not known.
+ *
+ *		Return -ENODEV if and only if the suppliers needed for probing
+ *		the device are not yet available to create device links to.
+ *
+ *		Return -EAGAIN if there are suppliers that need to be linked to
+ *		that are not yet available but none of those suppliers are
+ *		necessary for probing this device.
  */
 struct fwnode_operations {
 	struct fwnode_handle *(*get)(struct fwnode_handle *fwnode);
-- 
2.24.0.rc0.303.g954a862665-goog

