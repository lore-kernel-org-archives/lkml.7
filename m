Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8F4C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AB6206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574377760;
	bh=FdLooqP5pbn09oFXiwYqheSjpr5aAzaNOozbLJ+flbc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=LkgarNr9miDhA+Gjwui451XABlk8SJVZWCR2q+St/IYkmSlJ/4iunkz/p88aheqqa
	 24XyHr5a25tyASfmLCb7Zg12QdhN2RLvnI1nuce0zFbkmwjIO83vcZuIKP01hMexp7
	 bD/1c49UBfPf4jks8FaHVUr43ZUSJGmSbaDJS9Gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfKUXJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:09:19 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35367 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKUXJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:09:18 -0500
Received: by mail-oi1-f195.google.com with SMTP id n16so4859451oig.2;
        Thu, 21 Nov 2019 15:09:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e0eGXUlpPsuu7HS159pYz26jh7T2iArFugLkNf/iYAM=;
        b=MpGhfpV7EQEMxHFxoMINAfvXcWmJRvY5YAHrBMVXNs0o/4OYVeB8B74sESpWrVB/Pd
         XJ1xrbdun0PNi9RmrhVxSJVBK10Pj+V0FVvFPz+ivCUtdy0ii5mt1kAz0CotsgfxMX2K
         nV4vlataLNb4Aq2GXb2QdwKVBO9FyibhrFYgAofo/MLYLyq9hZx2/Ju1lvW77uLXMFvV
         ZLiPEvoaaPjGwnm3dOFSSBMJgIfdZAPZ9AhhopuIq7ZIVY+Nul/ZQSpKS3dz23gZH7xQ
         p10Br+HclRh6wyJnzMg3WdJkiDOJ1uvkwee2bLDInLY3zakdtQZcWN24Hs2OPyV5mJ2/
         MjFg==
X-Gm-Message-State: APjAAAVCxWYaxD8CmcAQGeoDE9q3AwzdVpZ33DuIlgPScptlVg6C5Lo+
        DCQcvFN8om5GyqrZ0edXcYORImc=
X-Google-Smtp-Source: APXvYqzf1Zt5YPLdknC83UALw70b+iXYk3R7fkqDQ56Upz457bHR+r1xPKg2YSbqElVqftmqe7A6oA==
X-Received: by 2002:aca:5709:: with SMTP id l9mr9947850oib.163.1574377757173;
        Thu, 21 Nov 2019 15:09:17 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id v26sm1398565oic.5.2019.11.21.15.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 15:09:16 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH] dt-bindings: interrupt-controller: arm,gic-v3: Add missing type to interrupt-partition-* nodes
Date:   Thu, 21 Nov 2019 17:09:15 -0600
Message-Id: <20191121230915.4410-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing 'type: object' schema to interrupt-partition-* nodes. Found
with fix to meta-schema checks.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/interrupt-controller/arm,gic-v3.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
index 1fe147daca4c..66aacd106503 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -138,6 +138,7 @@ properties:
       containing a set of sub-nodes.
     patternProperties:
       "^interrupt-partition-[0-9]+$":
+        type: object
         properties:
           affinity:
             $ref: /schemas/types.yaml#/definitions/phandle-array
-- 
2.20.1

