Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DCBCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78D12084D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H3BBaQmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfKDSM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:12:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40063 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729513AbfKDSM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:12:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id r4so12834639pfl.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 10:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ciXUSjrJzeNJ7x1YqUH63bTMmxfwRBsuiu2kMzOf67g=;
        b=H3BBaQmVJVl+8T39kKh3UPdS/XpJ9Q2VTPAOpfckdFx1bb9wba7xd/QD+BgQM/9Ah6
         9cC/e1iwKmsTGx3zd6x5oC19ft2PPIQuqXTJ93j/EISnxE+eT1tGGclEZ+uL3BzD06++
         +K7DYbObU4N+OJQyaBWGMMEg8oWlgwmtmXnNZgeFfFLDTeVnv3I73ibQd3LGkL6CCadO
         bN2+DYrqCKMeKZK2ugj04lS6vydLyGVv/RMfpSOlVeUE1TCSJH03TdKrVOob2mLH19By
         Zdlw/wbFj2imiInrA3rrueUMzjeMJvRLmBIRf9t8BeFnmiDUgpC0X1jZWnPCCGR8b8b1
         mT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ciXUSjrJzeNJ7x1YqUH63bTMmxfwRBsuiu2kMzOf67g=;
        b=LKyvK/rVHrIuzEWsJbUEsGjKQHo3XtOcnnlgGBYMI/7ATCd/AQ/6jlw91zEF4PQF6L
         8xIYXHpG5r7UE/Eznk4jTltr0bb0SbPeKyunJoLoa7wFNVmVQAWBXmYz0cQPFhXp5vqb
         fNecFBrw08lmsG4hWmvUwcq1n/crkaaXRZfbbv4XEcyXYxDIiIpUkx35G1WkCExFMAKH
         p7Hvr4OFz2c5ZRIF8XemocRoPpqeo11uh3D/npllYVYI6G2SUQtHh8ckXUBxx3xmo/V7
         kWY2CqlEjosOdxmQHQATnhp33dBSRfivFMBuoM9WSfiuiiSkoDlzquzD5MVX9Strqi1n
         kiVw==
X-Gm-Message-State: APjAAAUJ5nGkexUkuHbYEPAeJPtnB/rzFosMUzYM1wpl75CQYwYx+SrK
        Pk+cnS6rMar+ELftVofq3iYvDA==
X-Google-Smtp-Source: APXvYqyXGAX5moLNSKJJD6DBF7blkFyg5DP0ebMZ+PMsworRWcHt3ua8GOXx6Ev02S/YNcXwsgJRNw==
X-Received: by 2002:a63:3e0b:: with SMTP id l11mr28009360pga.448.1572891175644;
        Mon, 04 Nov 2019 10:12:55 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o12sm16149520pgl.86.2019.11.04.10.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 10:12:54 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] dt-bindings: arm: coresight: Add support for coresight-loses-context-with-cpu
Date:   Mon,  4 Nov 2019 11:12:39 -0700
Message-Id: <20191104181251.26732-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104181251.26732-1-mathieu.poirier@linaro.org>
References: <20191104181251.26732-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Murray <andrew.murray@arm.com>

Some coresight components, because of choices made during hardware
integration, require their state to be saved and restored across CPU low
power states.

The software has no reliable method of detecting when save/restore is
required thus let's add a binding to inform the kernel.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/devicetree/bindings/arm/coresight.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index fcc3bacfd8bc..d02c42d21f2f 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -87,6 +87,15 @@ its hardware characteristcs.
 
 	* port or ports: see "Graph bindings for Coresight" below.
 
+* Optional properties for all components:
+
+	* arm,coresight-loses-context-with-cpu : boolean. Indicates that the
+	  hardware will lose register context on CPU power down (e.g. CPUIdle).
+	  An example of where this may be needed are systems which contain a
+	  coresight component and CPU in the same power domain. When the CPU
+	  powers down the coresight component also powers down and loses its
+	  context. This property is currently only used for the ETM 4.x driver.
+
 * Optional properties for ETM/PTMs:
 
 	* arm,cp14: must be present if the system accesses ETM/PTM management
-- 
2.17.1

