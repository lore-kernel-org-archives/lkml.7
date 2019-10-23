Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81D9CA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0582084B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmL2XLde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbfJWAGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 20:06:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52412 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbfJWAGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 20:06:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id r19so19193341wmh.2;
        Tue, 22 Oct 2019 17:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gokM4n7dedwvMz3nVQdhJWZwmalfuzEvK8MTROAEiLo=;
        b=nmL2XLde2WB2uLAdxke8rA0HqWKBFJYeHsDDwcWrVgidimSdkjonniTpyTYGI5B6Ao
         finU+ZW9URhPGp5hmx0j+y4i7hYUTDE0eFMI5+F9gmi7J+KwWGfXLhDD/yu0i7LkWi4y
         xZrkLts/zyLMBDvsiwI6i5NXc/p4LVDXrJy1PUm9yB+shjeppAOsamV5PILKZNgb3KuS
         XLF0h1ajOIYYpe+9OKilKd+r1yvVsK/OAEOmDJ8kfpI0MeQya29a//NxYzfHOheqFts4
         nGHsKFpxMYULLljAiWBa5RMtNOjWCBeHjwuef4nK9nF3Mw7S+EX+XxeKfcglZ/0kMiWj
         Uj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gokM4n7dedwvMz3nVQdhJWZwmalfuzEvK8MTROAEiLo=;
        b=sELVt2jz4petFKpXo+RuzY1GLU+ceESUdK22qMCDIfj+NOArHhQi4W04LnZEy9ovLO
         wrDYYU+XLBK5cdTAQd6qLA6zZ01+lS13HWy0cqFhTGw4Wad0L3iP0oxCdoIOYQXzPjPb
         0Srsh9dX1ZVjJI130COt4EiVUyJq+GMlh+cLYp3Nz37nJn/4+vH5Bgz+qsYbCAgqcu/i
         RRAKhgaJFf+qPQRW2wsmmqtu3cIeW4sDL3Ndl1U/wn16pMMHWOPHxwbqv85hv3Pb6JDX
         Z6PwdKqGUo3VVo6zkWjC9upa+QaRCrtjwThg8IaY5vTcfWWSY1M7a6IUlTraAszqEVpj
         3XpQ==
X-Gm-Message-State: APjAAAVtiJUX4QqNpkIPkJ8lGajhuH+e92nWqJZh4qTPqfUvl6O3BhKE
        X9WNClBG5Mtb6h2Qy+xWLbKkS1NM
X-Google-Smtp-Source: APXvYqzQiHMeCDDNoaK/Il7oXDsbZlPDZKvFYnqWF6/bPf9fzRds46WyFEcSpn4NOt4+HVP2eMqs/g==
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr5550699wmj.150.1571789157938;
        Tue, 22 Oct 2019 17:05:57 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v10sm18500272wmg.48.2019.10.22.17.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 17:05:57 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE),
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Thanu Rangarajan <Thanu.Rangarajan@arm.com>
Subject: [PATCH RFC 1/2] dt-bindings: Define interrupt type for SGI interrupts
Date:   Tue, 22 Oct 2019 17:05:46 -0700
Message-Id: <20191023000547.7831-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023000547.7831-1-f.fainelli@gmail.com>
References: <20191023000547.7831-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for allowing drivers to use SGIs, define a new value for
the first ARM GIC interrupt controller cell to take a new value to
specifically designate a SGI interrupt.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/interrupt-controller/arm,gic.yaml       | 2 +-
 include/dt-bindings/interrupt-controller/arm-gic.h              | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
index 9a47820ef346..2d0bfcbe4933 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
@@ -58,7 +58,7 @@ properties:
     const: 3
     description: |
       The 1st cell is the interrupt type; 0 for SPI interrupts, 1 for PPI
-      interrupts.
+      interrupts and 2 for SGI interrupts.
 
       The 2nd cell contains the interrupt number for the interrupt type.
       SPI interrupts are in the range [0-987].  PPI interrupts are in the
diff --git a/include/dt-bindings/interrupt-controller/arm-gic.h b/include/dt-bindings/interrupt-controller/arm-gic.h
index 35b6f69b7db6..2dcc394b7b6b 100644
--- a/include/dt-bindings/interrupt-controller/arm-gic.h
+++ b/include/dt-bindings/interrupt-controller/arm-gic.h
@@ -12,6 +12,7 @@
 
 #define GIC_SPI 0
 #define GIC_PPI 1
+#define GIC_SGI 2
 
 /*
  * Interrupt specifier cell 2.
-- 
2.17.1

