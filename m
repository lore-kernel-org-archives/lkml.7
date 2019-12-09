Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DECC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C003207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLKPscda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfLILpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:45:09 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:41037 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfLILpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:45:07 -0500
Received: by mail-pj1-f68.google.com with SMTP id ca19so5790183pjb.8;
        Mon, 09 Dec 2019 03:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P2jfCSzYbFvYY67ttPGi/ey6pKuWAVfUtVchsOxcx1A=;
        b=NLKPscdavLc8ejNYEpWxq4sPL0/eNlVVp+uTvmuQnM7QIpkB5yJdrCmKM1wK08eiFg
         xTkI1gXzHpKJfLQqPS1sNpbstxlqDfng6Ve38HUMmz7iU/k1JQo7DjvwwRkFPW1uVEXP
         Iqr9pJFobBoSKRJQH3Cq/tqL/SLo72+4jzIm6oKvo2zWyWzSOG6+B8xdx4I89B/j7Scr
         AmWvArCpT+k323PaqK3tQbZdImDL7X9ZUW7ZLXdVH907A+MoH/2N6Rz/Vv+9DPfXxCIf
         LpNNp5T3yBRxeCHbQYzBdyIEtz6CS1uNo6ftghQ/XuiBxn+uKfe/sEgKV0OCS5cDkIe+
         LZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P2jfCSzYbFvYY67ttPGi/ey6pKuWAVfUtVchsOxcx1A=;
        b=Q0PyTblSDzM/wixp8nu5JN1QwNNLeY1cUFODFOfeY9lg6371y6BdnreFoz0+fqQTdQ
         WqzcV07YTdHm0pH8tO/qmcfJtDqaJFBB6kPAA4T8QapDLngdKxJJIvbsNKZy3pDSNjWO
         QZO6h0yyQHkI5HkbY1EgXUG+28+ZDeiT7wLddTrF1Be/8xUmL4JSUlaZv8YjmRxJXCEg
         sn5/PLCcQDfdsVFhu8tW6sjczksm7w/b9fOkn/F/y+Pxvm3uInWPBIT7rOel1/QIVvAp
         tI8AQR9qe3KfeAa0UHZU2ZmVifRMAiXmR+lA7YXb3SkxbATj8DCXGdR51URPA35lmiTb
         8xqQ==
X-Gm-Message-State: APjAAAWdITK0OO9Qc4bwPRVbbBRnqjuCCqQwtT8vCowrL7YAzSIb+4Du
        i90CDxxPBCdN7OfQEsN1N7Dm5XP4
X-Google-Smtp-Source: APXvYqxjg2iBrIKx7CpmfCvrJtempz9K7Jsc3EthbSqCCWC8tVjv9BnijC11srEBnaytGZok5gzimg==
X-Received: by 2002:a17:90a:d78f:: with SMTP id z15mr31924319pju.36.1575891907121;
        Mon, 09 Dec 2019 03:45:07 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c8sm27805289pfj.106.2019.12.09.03.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 03:45:06 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v4 2/3] dt-bindings: arm: move sprd board file to vendor directory
Date:   Mon,  9 Dec 2019 19:44:03 +0800
Message-Id: <20191209114404.22483-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191209114404.22483-1-zhang.lyra@gmail.com>
References: <20191209114404.22483-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

We've created a vendor directory for sprd, so move the board bindings to
there.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 Documentation/devicetree/bindings/arm/{ => sprd}/sprd.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/arm/{ => sprd}/sprd.yaml (92%)

diff --git a/Documentation/devicetree/bindings/arm/sprd.yaml b/Documentation/devicetree/bindings/arm/sprd/sprd.yaml
similarity index 92%
rename from Documentation/devicetree/bindings/arm/sprd.yaml
rename to Documentation/devicetree/bindings/arm/sprd/sprd.yaml
index c35fb845ccaa..0258a96bfbde 100644
--- a/Documentation/devicetree/bindings/arm/sprd.yaml
+++ b/Documentation/devicetree/bindings/arm/sprd/sprd.yaml
@@ -2,7 +2,7 @@
 # Copyright 2019 Unisoc Inc.
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/sprd.yaml#
+$id: http://devicetree.org/schemas/arm/sprd/sprd.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Unisoc platforms device tree bindings
-- 
2.20.1

