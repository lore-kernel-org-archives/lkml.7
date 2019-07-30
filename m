Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFC8C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15DE206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564498779;
	bh=yJU2vSdYNDTJbclz9X3UhrpzXizGrzdNfRsk7ghK/RA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=l28ZWz9fOWc+OfeuztNPHR6s2SAqvlLXhP7eDlYMIz/w4yjaZk6tud14k5bZGaf1z
	 bZAV6N+xq8JTiO8Ow5P5ejf5vymSNE/as7spQsBtfF//1mssoqO0Ax41v9DuBlDhQH
	 gM+5QPZhsDg8+UMHt70BrTa7cYO+5/iykdKWDXJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbfG3O7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:59:38 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43296 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbfG3O7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:59:38 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so128723688ios.10;
        Tue, 30 Jul 2019 07:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VDQ6N11AAuFuFo85qHNKBrrA+iF4giDQhs8MrBVj2/U=;
        b=FlFDNv7qEiT7xGol/w+JrSk0waaMTEhkacpiTtJc49vXGdfS97geXbVa7KpkoXGqkY
         u6p/VtA/c9Qmb1PMqWvlV90dl4N7lMfWhqSu8gc0KRLXxHsbjGXD1KZJ11nO9gl+Bk94
         E9jifgrwF6ccqvXjb4voO4pcjGAVZksLWEIl7pGwgPOCM0OQdEK3IMbktwJnAgqFKgqr
         pDi/sBcfzUtWL6o5BEIQavQOzW9JwdTsp/xQuvc9xQ+Ryb+FR4UbhsVxqsl2Be02yFAC
         vyxM//IBspkLrhTDGGwKGwUDhNnspRAkSzCRLkpZBF6G30+JieGWcaVrJqSfZ5KQZQAF
         8a1Q==
X-Gm-Message-State: APjAAAVQk6qsdtlkGfZn8GsJRygZmi8R/jyr/+N/51xhZVPVd5exWyo7
        3ymHpiSnN7AVa7NuHj2Zp3BBA3Q=
X-Google-Smtp-Source: APXvYqwUx/7XadPHxDL9liK26JdO82wEyXXiqc3dEooJKqfNuUCVXmxmdyfBvths0mwPiJWTd9dJdg==
X-Received: by 2002:a5d:8253:: with SMTP id n19mr5661994ioo.80.1564498776564;
        Tue, 30 Jul 2019 07:59:36 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.254])
        by smtp.googlemail.com with ESMTPSA id p10sm81147279iob.54.2019.07.30.07.59.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 07:59:36 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Subject: [PATCH] dt-bindings: Fix generated example files getting added to schemas
Date:   Tue, 30 Jul 2019 08:59:35 -0600
Message-Id: <20190730145935.26248-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 837158b847a4 ("dt-bindings: Check the examples against the
schemas") started generating YAML encoded DT files to validate the
examples against the schema. When running 'make dt_binding_check' in
tree after the 1st time, the generated example .dt.yaml files are
mistakenly added to the list of schema files. Exclude *.example.dt.yaml
files from the search for schema files.

Fixes: 837158b847a4 ("dt-bindings: Check the examples against the schemas")
Reported-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 6b0dfd5c17ba..5138a2f6232a 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -19,7 +19,9 @@ quiet_cmd_mk_schema = SCHEMA  $@
 
 DT_DOCS = $(shell \
 	cd $(srctree)/$(src) && \
-	find * \( -name '*.yaml' ! -name $(DT_TMP_SCHEMA) \) \
+	find * \( -name '*.yaml' ! \
+		-name $(DT_TMP_SCHEMA) ! \
+		-name '*.example.dt.yaml' \) \
 	)
 
 DT_SCHEMA_FILES ?= $(addprefix $(src)/,$(DT_DOCS))
-- 
2.20.1

