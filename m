Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFE5C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5731206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TwF5AsO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbfETKMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 06:12:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37045 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732429AbfETKMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 06:12:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id g3so6995161pfi.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 03:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=e4QisK5dlRTGLzT7/Rg8a2odjBOSln7PHE3O27n2JN8=;
        b=TwF5AsO5zpsHXKDVSh6tLAWFsy5YsMSB+N+B8/kqQ1zchDjm9CqFwdP5lcVriNwKE2
         Z8h+rqxbhmbhKy67tOYP6XzYzp3Q25nrcuXw4uBwDDdNAb8CkwdIjmte5MoAnoM+RkDB
         8mVUKrOOgzaOeS8aYkgHgTetDi8Sagwsh1irm28lnaydlZNXkVXRq87vrqLRA70YmgHs
         4uJCYf1w5y1rMiPLHxs/00M56zU0FWvbAWb72CfmMXcCU7uR1yoYXfm+ekppfHyL0A/7
         2OEFUWA+gsM5aC+gfH/J/99QDee8CBtIQj+NE3StWzhdJVOLYdFu1owAhp+A830cjBYh
         mcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=e4QisK5dlRTGLzT7/Rg8a2odjBOSln7PHE3O27n2JN8=;
        b=CKVekhX3YkaCdINlohpsHCj4iQDNCJkmtSRkuUm/emDjSpDnzI5+380/BNa6NFqO5f
         NNY5I4J5JLILKqPgI8pbjFC7mTB/w7rqoA6nRfruBq5Fne3MKMj9oPcg3oSesNTz/fLu
         tIV5wuQI669Wplw4tKyRDJUn50Z1Akw12TVXqTlBl6VqFc8UpZwayBO4pSvqMe+D+uoF
         M/q4/vSPJpBptqCLfpEqIzk/9HBzbb9iQmNSstIhB8lUn4Vfp1ZXbaJPDuQSOwdgOlyJ
         L9FnZ1jH6qYpzqZv7N3rALT7trjilhg16kwmoQd3KOb0RHQXB2Fpk7798jkhq4m2+IHN
         4HRQ==
X-Gm-Message-State: APjAAAV9tpIDZ2yYpP2bsoNQM5B+sXScbOsdWe9nFwCiarRbHuPn6r26
        L+grjKBUpluBJQQi5PavWSzFmg==
X-Google-Smtp-Source: APXvYqwcAZDdcUPPLz7jaZHV8PzDymn8O/Vo0pRi78sKNC1rTBbmH5DNKY7ezKJmPTZOMLYnygiLyA==
X-Received: by 2002:aa7:9577:: with SMTP id x23mr78981496pfq.164.1558347151948;
        Mon, 20 May 2019 03:12:31 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b3sm30098127pfr.146.2019.05.20.03.12.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 03:12:31 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/9] dt-bindings: mmc: sprd: Add another optional clock documentation
Date:   Mon, 20 May 2019 18:11:55 +0800
Message-Id: <ee4ad0e7e131e4d639dbf6bd25ad93726648ce1c.1558346019.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1558346019.git.baolin.wang@linaro.org>
References: <cover.1558346019.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1558346019.git.baolin.wang@linaro.org>
References: <cover.1558346019.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some Spreadtrum platforms like SC9860 platform, we should enable another
gate clock '2x_enable' to make the SD host controller work well. Thus add
documentation for this optional clock.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/mmc/sdhci-sprd.txt         |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
index 45c9978..a285c77 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
@@ -14,6 +14,7 @@ Required properties:
 - clock-names: Should contain the following:
 	"sdio" - SDIO source clock (required)
 	"enable" - gate clock which used for enabling/disabling the device (required)
+	"2x_enable" - gate clock controlling the device for some special platforms (optional)
 
 Optional properties:
 - assigned-clocks: the same with "sdio" clock
-- 
1.7.9.5

