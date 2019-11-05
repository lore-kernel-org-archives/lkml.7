Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F116BCA9EC7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27572084D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZPWuvUj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbfKEGpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 01:45:06 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:57288 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387517AbfKEGpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 01:45:05 -0500
Received: by mail-pf1-f202.google.com with SMTP id v11so15438847pfm.23
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 22:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5TtiPZ8JG3IZB9IHfZXJzJVA9bfv9F4xuxgcwBO6hmE=;
        b=ZPWuvUj8a8q4uvpmzT22mQ2WR3WURPKcIka9HvFedRwDHQ6oPEfbSPy6PGxIeLvgo7
         vvZObZOobmyPhjgae6FPfXxT6DT5vClY/Qx1jWMpqThB2ysxdJy8/MBVFnxfdGcPqh4U
         JTRw8tqJeWcQ2feNXCqOQJc8JF7O4CJsxk30Ds0hq43s7+rDGHOWI/+uzBz/GRgSOqro
         EQqij06eWMv8TmLRWdyWAIyjIAH/qA5yhhcP3F4RTq9eyZU7XMHlnCa0qYD+2ATKoOiV
         X+R/VMxvu3Lgj9zdIxSiwlllYFxcmEPc2gxduqYBioPipNZ5hXKiy9tOkf52u0RQjhf9
         Vegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5TtiPZ8JG3IZB9IHfZXJzJVA9bfv9F4xuxgcwBO6hmE=;
        b=D1oKANcavodMoqIt7RozO61LjWWIfmwxyr55oe5EuafFK8RddwhH0Rd2hF/Nqs0emd
         O1zf+FYx7uanX5X0+Xkr0lJSBLmLXfD2oWMtDSNLC0srqz1q17gvFEH7v1pZXt010lV3
         dA/cFpY/cS0kk55WZwFeZHSQQkRf3qcLdoyBR8J1J/uzmlOhHE4gq51lWidehwgBnM8V
         uG8eItdVHKQmh4VO14iPvX+sh38QqbVSKbrxsb8ziaxqSL+rkMWHWkH7LLQsKtGwDsM5
         Hf8c3MwriM7FGY0jyEMFOkVpbGfxTC29Ln1WONSX3+JuSbJ9CMgWgDgMaoIJGAGrimb5
         O0dA==
X-Gm-Message-State: APjAAAWzlSIWd40GQ1AwocMHZpLu4MIVlRzV+sspzsNA2zWBz/bw6MTe
        QOZfhv7tD3qH8ZUHeZZd+1Xu4hZ0l1Xjf6w=
X-Google-Smtp-Source: APXvYqwyJ5qlDC7E2bSBigwa1PnPbCXw2M+VjtdsoAnhMgSgk+aTV3CEUrBXZIL2rOI0mC0p+IIFQU/0XtNicqo=
X-Received: by 2002:a63:4104:: with SMTP id o4mr34057739pga.169.1572936303079;
 Mon, 04 Nov 2019 22:45:03 -0800 (PST)
Date:   Mon,  4 Nov 2019 22:44:53 -0800
In-Reply-To: <20191105064456.36906-1-saravanak@google.com>
Message-Id: <20191105064456.36906-2-saravanak@google.com>
Mime-Version: 1.0
References: <20191105064456.36906-1-saravanak@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v1 1/3] of: property: Minor style clean up of of_link_to_phandle()
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

Adding a debug log instead of silently ignoring a phandle for an early
device. Also, return the right error code instead of 0 even though the
actual execution flow won't change.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index e225ab17f598..fbc201330ba0 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1051,8 +1051,14 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
 	sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
 	is_populated = of_node_check_flag(sup_np, OF_POPULATED);
 	of_node_put(sup_np);
-	if (!sup_dev)
-		return is_populated ? 0 : -EAGAIN;
+	if (!sup_dev && is_populated) {
+		/* Early device without struct device. */
+		dev_dbg(dev, "Not linking to %pOFP - No struct device\n",
+			sup_np);
+		return -ENODEV;
+	} else if (!sup_dev) {
+		return -EAGAIN;
+	}
 	if (!device_link_add(dev, sup_dev, dl_flags))
 		ret = -EAGAIN;
 	put_device(sup_dev);
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

