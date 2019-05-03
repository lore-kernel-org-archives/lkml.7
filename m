Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A77C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07AAC2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F6lrwkUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfECRsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 13:48:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45212 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbfECRsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 13:48:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id o5so3012867pls.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 10:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hcu8K+zWlIGVcO7HslnrIVULTnaD0CZgK/YRsSv5h7E=;
        b=F6lrwkUObP5QsxdWxxiNyUKTwB/nEyF4/2ZuY81qbcsiroixxS1vfHPuhgJCG74vnG
         ZpQu2+yRS0RB44jtMo71Bq3M3BbxP6cxxmSZI8bQ/c/OgD/1tMxXKzfjUhB2JqKaAn/l
         NG8WILFO9GWdfOIoO5C2INyNQwVBGc70wO/D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hcu8K+zWlIGVcO7HslnrIVULTnaD0CZgK/YRsSv5h7E=;
        b=PMHzIjfZT/1DPOR7HnaM4nqX35J/HWymjdm2v5+uZOlNVMSC7yMaFHXKtRTmsbp65+
         p+FBRyoMObR/IKNVhw2r4JJInApUoXKuE1HaEV93Imq1Er1lNY1GnkL8Qtr6/wDQacIm
         K5oL9SuV6vQ6VnE/JBrlX/qTlXD5ifL5h9UFIn1kML6OWAOFynvgpk6UKM1Vk9nrFE/e
         oD0ccEhrruE+bKNYUPMzJGtQDyJSHgPJESO1tO5Q5jKcK5joW6Pq6zvptXUZQn2qEG8u
         CZ5MQxOCgR0XUuOY+FTuAE87JC7fV2qdiRMGtn2DfyIYCwTUpOxLmY6OoInrYogCn4uZ
         ShtA==
X-Gm-Message-State: APjAAAVSEFwp3KzwCYO3NuvHqe9NBDCKzPYLHX9AImFhJjiWMC8Wa52y
        FO+0GTSW4nbVafLTIaRzVZkPYw==
X-Google-Smtp-Source: APXvYqwUHs8vMvaru9Cwe1tZkDsvr7dVSbNkuW/Q+VhSh7UtsmWhvEG5ztlrguWI+8XxxHBhnHpwGA==
X-Received: by 2002:a17:902:7085:: with SMTP id z5mr12285610plk.78.1556905682002;
        Fri, 03 May 2019 10:48:02 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id v15sm3588446pff.105.2019.05.03.10.48.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 10:48:01 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>
Cc:     linux-rockchip@lists.infradead.org, jwerner@chromium.org,
        groeck@chromium.org, mka@chromium.org, briannorris@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] pstore/ram: Improve backward compatibility with older Chromebooks
Date:   Fri,  3 May 2019 10:47:30 -0700
Message-Id: <20190503174730.245762-1-dianders@chromium.org>
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

 fs/pstore/ram.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index c5c685589e36..8df3bfa2837f 100644
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
@@ -703,6 +704,23 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 
 #undef parse_size
 
+	/*
+	 * Some old Chromebooks relied on the kernel setting the console_size
+	 * and pmsg_size to the record size since that's what the downstream
+	 * kernel did.  These same Chromebooks had "ramoops" straight under
+	 * the root node which isn't according to the upstream bindings.  Let's
+	 * make those old Chromebooks work by detecting this and mimicing the
+	 * expected behavior.
+	 */
+	parent_node = of_get_parent(of_node);
+	if (of_node_is_root(parent_node) &&
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

