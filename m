Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BC6C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876E92173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yh9EIr82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404347AbfHHRj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:39:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40242 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfHHRj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:39:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so44425551pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 10:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DFyYlsPKtD2pIkl+6HQ9NsXCJu2oBYedJ0F8UrzQk24=;
        b=Yh9EIr82yon5IKwUIC8/aoF3FklHeBHZH9PfoCglI1X9pa0gurA07RhtfLxokIKnIz
         81xyPWSnwnZLtp5kryW23U9msxajMEa5GnhdM44fHoSwcv0gQJEdVcOJVV7F2TrigyY7
         Yl3Mm05/ax1pcApFg4xYKIsnxB9O+sRcfZRQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DFyYlsPKtD2pIkl+6HQ9NsXCJu2oBYedJ0F8UrzQk24=;
        b=geDgWEpBsR4AXotOqPthqBqtiUCoKXI7GzM9pdlRn/pO6/jg7iSD5M51vUU9G65Un9
         664XDyHGxT39pmRFCUXqR/h8qJSRFTSaK3UkUwk8a7K8wZ32FiS4P+oNGYjm4tnPVAaX
         8kLrnn7Fw09ISXeci56WwKA4tuY/xmtVxkH9kwN0L/12lCBegqfZtcp9Cl1edXet+dxI
         Etl3gqq39HrNG98pwyHSdKKMkeankJpDRtpE+fRrMbiY7NCSML7CtpDtaacHJA7vMa0l
         A0tesAX9BzoJmrqPrWyIBTO+fgYVYUimvGo4/HXVSR3L15hERGK+fDW/XVNGLLGNVYXM
         vS0w==
X-Gm-Message-State: APjAAAWIQxZruQ/p8R81A58QPRZ8MiivIkx4WP9xsV2uW2eIPnqjaSuV
        U7eByOw+1eqIjuB0YBg4xK5eNQ==
X-Google-Smtp-Source: APXvYqyEVq5aKjaC1auKdVBOl3Eitrh/DUCGqDLTS3ddRuXoM7KR+75fidcuNyU2aVJLs620qmfVoQ==
X-Received: by 2002:a17:90a:d593:: with SMTP id v19mr5186942pju.1.1565285967016;
        Thu, 08 Aug 2019 10:39:27 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id y12sm105824412pfn.187.2019.08.08.10.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Aug 2019 10:39:26 -0700 (PDT)
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
Subject: [PATCH RESEND v7 2/3] fdt: add support for rng-seed
Date:   Fri,  9 Aug 2019 01:38:05 +0800
Message-Id: <20190808173803.1146-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808173803.1146-1-hsinyi@chromium.org>
References: <20190808173803.1146-1-hsinyi@chromium.org>
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
 drivers/of/fdt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 9cdf14b9aaab..640c817cf65b 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -24,6 +24,7 @@
 #include <linux/debugfs.h>
 #include <linux/serial_core.h>
 #include <linux/sysfs.h>
+#include <linux/random.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
@@ -1044,6 +1045,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 {
 	int l;
 	const char *p;
+	const void *rng_seed;
 
 	pr_debug("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
 
@@ -1078,6 +1080,14 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 
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

