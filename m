Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9B2C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8EF214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HniB7Q85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfEHPtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:49:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37951 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfEHPtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:49:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so10302579pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 08:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=48PM5wjwHg5QAu3xwuXzBgAZQekQFPxmgJORD2kHJRs=;
        b=HniB7Q85atLr+xF0KXfSp07SsofmrDYFHpaSrRf/D3y7xkRoKwr4rdzgyUqRj26lqg
         uQUGl/OHlceMWux9HEaQFZBdZd2cM4O9qYSGaEKO5Ee79L0jvzoPjOmafsgQyNlg62PW
         5HvZJdfXvIHH2wgUXn7UaBUBUFhje8IdI7zX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=48PM5wjwHg5QAu3xwuXzBgAZQekQFPxmgJORD2kHJRs=;
        b=pknS7aPdFfsl0Xsn3sEFffc99k5u5cbTa3W5/tK42eLIQSMjch9LZDVdYDWvsaRVG2
         PTuw+Fvzgjz8XF2kLJvH3vL346t6U8DJ/HsM4HMFmc6ICiMGmy8yzr53DDv8OEcckv83
         WCNpXTLEqmWmPp1g0+ojrg/2+rTNfO2ByfTISu1zSujaLwIhSb8TfmofopYYhKaGl88i
         qEBoOLZc+/4KxKcZ46slkBZJJwqACcORf71YBkLFZ686sqB5mBSaIK4LFoH7mu5aPiAz
         Z/GZQ5zcOto1Tu4ns4nK7gEDpV/QYAqREtlKD7pVfg2GOCgs8UQ1QFOshKwQ6NW4ncqT
         QuPg==
X-Gm-Message-State: APjAAAV0BUdnzcBdi9mOZUIPqnoZN7xevito5W7oSnKb5sfzhlh2eX2z
        /LgHIKgqmOaaoQHgxabLJYLJFZamxd0=
X-Google-Smtp-Source: APXvYqyK6aJeIBmRwXhHkF3WLNv5b7LcG+SteylVUiskVBLe8KT0Fs/zXnnoRsGZSoGUPGeRYxh69g==
X-Received: by 2002:a62:56d9:: with SMTP id h86mr40751950pfj.195.1557330548169;
        Wed, 08 May 2019 08:49:08 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d186sm11953443pgc.58.2019.05.08.08.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:49:07 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>
Cc:     linux-rockchip@lists.infradead.org, briannorris@chromium.org,
        groeck@chromium.org, mka@chromium.org,
        Frank Rowand <frowand.list@gmail.com>, jwerner@chromium.org,
        Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] pstore/ram: Improve backward compatibility with older Chromebooks
Date:   Wed,  8 May 2019 08:48:31 -0700
Message-Id: <20190508154832.241525-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When you try to run an upstream kernel on an old ARM-based Chromebook
you'll find that console-ramoops doesn't work.

Old ARM-based Chromebooks, before <https://crrev.com/c/439792>
("ramoops: support upstream {console,pmsg,ftrace}-size properties")
used to create a "ramoops" node at the top level that looked like:

/ {
  ramoops {
    compatible = "ramoops";
    reg = <...>;
    record-size = <...>;
    dump-oops;
  };
};

...and these Chromebooks assumed that the downstream kernel would make
console_size / pmsg_size match the record size.  The above ramoops
node was added by the firmware so it's not easy to make any changes.

Let's match the expected behavior, but only for those using the old
backward-compatible way of working where ramoops is right under the
root node.

NOTE: if there are some out-of-tree devices that had ramoops at the
top level, left everything but the record size as 0, and somehow
doesn't want this behavior, we can try to add more conditions here.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- s/mimicing/mimicking/ (Brian Norris)
- Slight rewording of the comment (Brian Norris)
- Check name rather than relying on of_node_is_root() (Frank Rowand)

 fs/pstore/ram.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index c5c685589e36..5195a3a3daec 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -669,6 +669,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 			    struct ramoops_platform_data *pdata)
 {
 	struct device_node *of_node = pdev->dev.of_node;
+	struct device_node *parent_node;
 	struct resource *res;
 	u32 value;
 	int ret;
@@ -703,6 +704,26 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 
 #undef parse_size
 
+	/*
+	 * Some old Chromebooks relied on the kernel setting the
+	 * console_size and pmsg_size to the record size since that's
+	 * what the downstream kernel did.  These same Chromebooks had
+	 * "ramoops" straight under the root node which isn't
+	 * according to the current upstream bindings (though it was
+	 * arguably acceptable under a prior version of the bindings).
+	 * Let's make those old Chromebooks work by detecting that
+	 * we're not a child of "reserved-memory" and mimicking the
+	 * expected behavior.
+	 */
+	parent_node = of_get_parent(of_node);
+	if (!of_node_name_eq(parent_node, "reserved-memory") &&
+	    !pdata->console_size && !pdata->ftrace_size &&
+	    !pdata->pmsg_size && !pdata->ecc_info.ecc_size) {
+		pdata->console_size = pdata->record_size;
+		pdata->pmsg_size = pdata->record_size;
+	}
+	of_node_put(parent_node);
+
 	return 0;
 }
 
-- 
2.21.0.1020.gf2820cf01a-goog

