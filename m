Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B309DC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 04:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8270020673
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 04:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q3x9sXJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfGCECy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 00:02:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39392 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCECx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 00:02:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so453103pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 21:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D0DdOpMQGVeAdF8kK+Kt9fgmekxnUEujrSDi9AB3YmM=;
        b=Q3x9sXJvjIsCzqPkwq91GFznkehlCZyQIblUxwqegBXIDgIUasLe9okJjER1twbMfm
         nWjqNor3p1Clensei6236mF0jhvK+Sz6FDfN6WVrsJSiR0TJYu/hCDDyIKsI81w9QiZw
         hBV7oc1Qdq03EnAcOb1WkjushbCfRrm8Rx+WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D0DdOpMQGVeAdF8kK+Kt9fgmekxnUEujrSDi9AB3YmM=;
        b=qYQaXNbeAujLcQsMX9gFrSlpJxvznstEy8f9HQAFDoITVO1ddeXpISczzyR10EW0eU
         8FaeOXLRUn/hfsHxhDRp71rD69EnC0pdMHARPR8tFhbbOfh5GNp/c4eFk65vCaeHX2hz
         lfkYiQudGgCJ+D9TfCPagOMudPDh+CQ/uwocYRpDcai5mySw7Lk7Tnm2Gi9zFjjpiEKj
         wYLBRAnDlVoQjuNsVNXBgVIM/RAH1iDqZBAsidi+b7+3llHAFQ+g0ZxvDj7+zEXUFz5z
         ti72aqS6zlMhwtoyHNI94AMZ3lNdj7cTvwiB/VDg1NojGi4sdk5MrHDKnCeblJkpVc8Q
         YyQg==
X-Gm-Message-State: APjAAAVMQvDQZicAiRTfDM8uDOwzsWJmcs/yp/YxejnnEaRpU+LWmdMu
        Od9ycL0gf7HW0oKi92nXrcXV+w==
X-Google-Smtp-Source: APXvYqznyDfHYKikQKIqHH4oCiI9Z/+57ZuJwCnQCjDdBHt1Eb4/rlbJGAPXvGWmfJKbFYSPdnrnww==
X-Received: by 2002:a17:902:a414:: with SMTP id p20mr37549962plq.187.1562126572996;
        Tue, 02 Jul 2019 21:02:52 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id w16sm608327pfj.85.2019.07.02.21.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jul 2019 21:02:52 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v7 2/3] fdt: add support for rng-seed
Date:   Wed,  3 Jul 2019 12:01:37 +0800
Message-Id: <20190703040135.169843-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703040135.169843-1-hsinyi@chromium.org>
References: <20190703040135.169843-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing a chosen node, rng-seed, which is an entropy that can be
passed to kernel called very early to increase initial device
randomness. Bootloader should provide this entropy and the value is
read from /chosen/rng-seed in DT.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
No change since v6.
---
 drivers/of/fdt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index cd17dc62a719..7be50e287ba6 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -24,6 +24,7 @@
 #include <linux/debugfs.h>
 #include <linux/serial_core.h>
 #include <linux/sysfs.h>
+#include <linux/random.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
@@ -1043,6 +1044,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 {
 	int l;
 	const char *p;
+	const void *rng_seed;
 
 	pr_debug("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
 
@@ -1077,6 +1079,14 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 
 	pr_debug("Command line is: %s\n", (char*)data);
 
+	rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
+	if (rng_seed && l > 0) {
+		add_device_randomness(rng_seed, l);
+
+		/* try to clear seed so it won't be found. */
+		fdt_nop_property(initial_boot_params, node, "rng-seed");
+	}
+
 	/* break now */
 	return 1;
 }
-- 
2.20.1

