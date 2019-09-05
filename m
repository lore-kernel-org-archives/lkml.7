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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6070AC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A71F20870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwtpstSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732585AbfIEIWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 04:22:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43659 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732065AbfIEIWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 04:22:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id d15so1231740pfo.10;
        Thu, 05 Sep 2019 01:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OR+2oUf84ahdL/gVaL83KcJgug8/1OAXHF+oo7QgYic=;
        b=bwtpstSAkOACZBbe+Nv57N21Dz2M9GUhBRRV05iZb1fTtxh6mrFXkz2SCEV8dZcWtp
         DAwfvDgENT4ySZBGNChnQAx7D7jxtcqPgkLsxbTF9s2e2vJ6K4CdIbATHDCc0lSAFsvJ
         Qn8cZ7Tq8nzmPNw8Z4iFyf44omZi4lbePC8iJRa4iZLTTfjylBova4mnoNQW4ZAnLH0J
         E87DTxqATv5fvHEqWfJ1lbSbKzcvU6oXwP3c9EK0U7f8ZkPhOqlHHdKJdH7dH2tQFy2b
         cpg2xi+sRX3QQ3UJUKz2dMF3AoshIsYC0fnudFqtdnq2vZxwHAxk/QMrYNMyFCQNi1Cm
         WXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OR+2oUf84ahdL/gVaL83KcJgug8/1OAXHF+oo7QgYic=;
        b=X2t5NUAgogEQD0VEoP9tj957rh8oCtt4xQK58z9MnujuI27kXQiMC2rZUZBMNYef5b
         o4nXP5F230LCZXfUZUgACwhvtJ8J8ELp+TUrxWttRmDTnO2RYGBeqYPG1q+YpCYVtipj
         p4+Q+2LIBjxl6KtYKKjwj99wUCYIHxZnyLknGoNjw2+MrQjcg1yNlnmLAuVECp037n8q
         VCEiK4oa+QPY5PHp1VfkVRlwcRnfbRDUZlsJ8LUaFhNea9vOX1n06Irr+ResDp8TWkn/
         dJ8OP1zAP8bl5dhMQyrA2gKFmeJ2DTHRZG2mqZmv9QrqN36p0ZX/B2a5I+UtPDSVfRDK
         FLZA==
X-Gm-Message-State: APjAAAXaliEM+Rt8Zzo+A0GJIu3qodv7fvNhlICv4U9R4Gty8KX1/aww
        9P54UP7pXGoXDb8nHKV8OXt2548I
X-Google-Smtp-Source: APXvYqzHdSq7YdOvWnTnvzsz0Rhi1kScrNnkmtPlpLjJnsTgvZv6ahcq/gOI1BQ9DW9Fu+eOPqPkDg==
X-Received: by 2002:a63:ec48:: with SMTP id r8mr1939805pgj.387.1567671767306;
        Thu, 05 Sep 2019 01:22:47 -0700 (PDT)
Received: from localhost.localdomain ([49.216.8.243])
        by smtp.gmail.com with ESMTPSA id o35sm1178608pgm.29.2019.09.05.01.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 01:22:46 -0700 (PDT)
From:   jamestai.sky@gmail.com
X-Google-Original-From: james.tai@realtek.com
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        CY_Huang <cy.huang@realtek.com>,
        Phinex Hung <phinex@realtek.com>,
        "james.tai" <james.tai@realtek.com>
Subject: [PATCH] dt-bindings: arm: Add bindings for Realtek RTD16XX SoC
Date:   Thu,  5 Sep 2019 16:20:42 +0800
Message-Id: <20190905082042.1601-1-james.tai@realtek.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james.tai" <james.tai@realtek.com>

This patch adds dt-binding documentation for Realtek RTD16XX platform.

Signed-off-by: james.tai <james.tai@realtek.com>
---
 Documentation/devicetree/bindings/arm/realtek.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/realtek.yaml b/Documentation/devicetree/bindings/arm/realtek.yaml
index ad9b13bc42f0..4d4ac23acab0 100644
--- a/Documentation/devicetree/bindings/arm/realtek.yaml
+++ b/Documentation/devicetree/bindings/arm/realtek.yaml
@@ -15,3 +15,5 @@ properties:
               - probox2,ava
               - zidoo,x9s
           - const: realtek,rtd1295
+        items:
+          - const: realtek,rtd1619
-- 
2.17.1

