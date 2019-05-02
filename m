Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEC2C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15902081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fC1fKb4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfEBQya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:54:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38287 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfEBQyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:54:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so1418830pfo.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Akvar0z3H2C4Po+4q/PqqG5fzv7JGnOTC1Q3ZfsqLhU=;
        b=fC1fKb4UtdDJy+EmO1Gym1hhgWjGO3rGFwZni5C2m9o/yy56e4k/VuEbNtE5wdlYbT
         9t9fkXDGp9Hf38G7rtbxc7AZxJ82RLFxjeG3VNayNl/PJnrJVxHerN59gizF8GK2sBB/
         0Jd8Eabzc3vaCa6Y8CqD6KjcuEx3vyJzECm9Uz6d8p3fkVRdQTygykJKdyZa0BsE0jvc
         S0eGFoEFF1lyCtMPM4QsGU6xBZiCfFOM9q59zFqkZV63H7HLzt1WV+J11lgNzezF5ATf
         HGzR9JN/MAKLXOa1sSBWRrnpp5Pndhp1QULWXHvTn0ddGIXoHceAgemoViMFxkFetEEj
         CKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Akvar0z3H2C4Po+4q/PqqG5fzv7JGnOTC1Q3ZfsqLhU=;
        b=o48TX2yLudwAp9hucjhmd8FnHTWVBK3huQ9qKUHduCjVP8DObeollh/YYCW4HzwruS
         kD+P/FmsLYyu02+YZXr0v3ccw7hhRaBZ0plLZl/jKtJDM0cgs2J9KBeQGSx8QHdN6xOQ
         o19cU53rPTeCX+SHPDJmoF1pyYF2hK4a0L8xzzC//HvlM3lalCk1zT2uxtLZeVnUjT/W
         xFR5yhbN/wWKt+IT883ofz3ZycjXVjPCvzsAlXOmk9h7JfUQsUGZ62oF66zBP/sEANJA
         8VXbhGQANOFx6Kd5xMmMsYE+1pNqdqc3urzkKT9OP5PwT2JnJKZRziP5J6zRHEsG5K8G
         vlNQ==
X-Gm-Message-State: APjAAAVlQ6sZ4zZQL0fODK9pjilduajGn/E/NMlamX8fAVV/5rTAZdi/
        C6pcIE4H69BoSn00AB5n6/iWkiKruV8=
X-Google-Smtp-Source: APXvYqyeyXwssHT1qjn2P4lp23bJGQNZPL+x2k1nwyT2Te9BxDQPkk63jNbgkCyEDO64qv5sdeRFrw==
X-Received: by 2002:a63:8b4b:: with SMTP id j72mr5048125pge.318.1556816048509;
        Thu, 02 May 2019 09:54:08 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j2sm69949pff.77.2019.05.02.09.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 09:54:07 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: arm: coresight: Add new compatible for static replicator
Date:   Thu,  2 May 2019 10:54:02 -0600
Message-Id: <20190502165405.31573-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190502165405.31573-1-mathieu.poirier@linaro.org>
References: <20190502165405.31573-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

CoreSight uses below bindings for replicator:

  Dynamic replicator, aka. configurable replicator:
    "arm,coresight-dynamic-replicator", "arm,primecell";

  Static replicator, aka. non-configurable replicator:
    "arm,coresight-replicator";

The compatible string "arm,coresight-replicator" is not an explicit
naming to express the replicator is 'static'.  To unify the naming
convention, this patch introduces a new compatible string
"arm,coresight-static-replicator" for the static replicator; the
compatible string "arm,coresight-replicator" is kept for backward
compatibility, but tag it as obsolete and suggest to use the new
compatible string.

As result CoreSight replicator have below bindings:

  Dynamic replicator:
    "arm,coresight-dynamic-replicator", "arm,primecell";

  Static replicator:
    "arm,coresight-static-replicator";
    "arm,coresight-replicator"; (obsolete)

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/devicetree/bindings/arm/coresight.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index f8aff65ab921..d02d160fa8ac 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -69,7 +69,10 @@ its hardware characteristcs.
 
 	* compatible: Currently supported value is (note the absence of the
 	  AMBA markee):
-		- "arm,coresight-replicator"
+		- Coresight Non-configurable Replicator:
+			"arm,coresight-static-replicator";
+			"arm,coresight-replicator"; (OBSOLETE. For backward
+				compatibility and will be removed)
 
 	* port or ports: see "Graph bindings for Coresight" below.
 
@@ -169,7 +172,7 @@ Example:
 		/* non-configurable replicators don't show up on the
 		 * AMBA bus.  As such no need to add "arm,primecell".
 		 */
-		compatible = "arm,coresight-replicator";
+		compatible = "arm,coresight-static-replicator";
 
 		out-ports {
 			#address-cells = <1>;
-- 
2.17.1

