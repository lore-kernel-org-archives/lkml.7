Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D445C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0150021848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwqSn6Hd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbfIEIQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 04:16:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40335 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730849AbfIEIQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 04:16:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so988755pgj.7;
        Thu, 05 Sep 2019 01:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8sJIwjC+uTMQQ+j3BpVe6IaoEgx2I750V29nK1aOgcw=;
        b=EwqSn6HdrjkflUwwwTPz+oNB7PSPSe1vzzqd8PzgpQ/x4PVHPQhQTuJmL1GtfuNYCG
         WG9pEel7UOok2H1UdGT8TNmDuS+4WPW0U5f3Udewev1VWDGKB70vF/N1tMk6VcDCiFLE
         e5mnQaIVqBmWxrH9zL2Jd1kSOzbKTK9oO4sfABX7VcZ2KTXFhKZll11ir2LHIW2aKr+q
         mOpjOA2gVj8KLBOIUq4S4Q5/m6Lgu9pRAPq0NXrsnQf7yGvOiRsI7x22zpTFxuOTdQ8O
         t4sEB6JUmZjJ3rzT7E1ZqL1CG6EqADbK5eM7uJDe64PgDmWEQ9nZFI/2EXJgiuDLU4mc
         nt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8sJIwjC+uTMQQ+j3BpVe6IaoEgx2I750V29nK1aOgcw=;
        b=GB/srr46ucUzcx2ZCsHqg4LDRm2TuD20Jt8boAUkhFo1ZB0M73X3/KWxQjm2kOnOGN
         JmJV90yAuCghl0yZFCwoCuyrtjv15sRYs9Iw32dx8Dj/PizHaI2OeM1ZkhG49GZS9XTx
         c8Lhv1kt+/E/kvRvMeq0vIPgRWLTr1TfwDEFxLmGdbrnDoV3RLYplKGFFOmo1WZbDGu+
         RjpfJLCFK8BODlb1rSczVhCYDw2uLvkvXbu7joFk9ZAvTc1RUKuX8nkaSRsfH9JGFzt1
         E7pBm996hO4LOn79cnQdmzNz9YuYq1EMSfa0TxTqKX5DCCOnunesl+SCgmPYuYimD7pW
         hvMA==
X-Gm-Message-State: APjAAAWM6IO2S9BmUyYPeKMxk4kcCgPYvIhrQvv2CZwRwhf+1ZULqJyk
        WI6HRs3cleF266YSCvTwFV+iKIzj
X-Google-Smtp-Source: APXvYqyymixaC/4ZmoAYVHw421NBXUFa1C+1zeteo7JioReZqYjJQ9yGnohHAF0A+fKrMjxJZR5TfQ==
X-Received: by 2002:aa7:8dc9:: with SMTP id j9mr2305645pfr.233.1567671400065;
        Thu, 05 Sep 2019 01:16:40 -0700 (PDT)
Received: from localhost.localdomain ([49.216.8.243])
        by smtp.gmail.com with ESMTPSA id g26sm1621121pfi.103.2019.09.05.01.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 01:16:39 -0700 (PDT)
From:   jamestai.sky@gmail.com
X-Google-Original-From: james.tai@realtek.com
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Olof Johansson <olof@lixom.net>,
        CY_Huang <cy.huang@realtek.com>,
        Phinex Hung <phinex@realtek.com>,
        "james.tai" <james.tai@realtek.com>
Subject: [PATCH] dt-bindings: cpu: Add a support cpu type for cortex-a55
Date:   Thu,  5 Sep 2019 16:14:35 +0800
Message-Id: <20190905081435.1492-1-james.tai@realtek.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james.tai" <james.tai@realtek.com>

Add arm cpu type cortex-a55.

Signed-off-by: james.tai <james.tai@realtek.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index aa40b074b864..1fc7c8effd25 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -124,6 +124,7 @@ properties:
       - arm,cortex-a15
       - arm,cortex-a17
       - arm,cortex-a53
+      - arm,cortex-a55
       - arm,cortex-a57
       - arm,cortex-a72
       - arm,cortex-a73
-- 
2.17.1

