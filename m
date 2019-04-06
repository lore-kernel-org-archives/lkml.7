Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AD6C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 11:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7415C2087F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 11:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a20QgqD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfDFLWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 07:22:23 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40463 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 07:22:22 -0400
Received: by mail-yw1-f66.google.com with SMTP id p64so3267671ywg.7
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 04:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zIWMF1R93QZItw73bSxup0eAGPLoi4yPEdVTTG3P0l8=;
        b=a20QgqD4uW4B3Rs+6cjMACWRmeB4oPCY/j9zmrWNWt42djjcOWINIptpdt7OniFRTs
         hCTf7GKg5bDurD9n4yyKFPyj3y3AwVVn0pFZ2U3aJfmqQXOmlyvMzilLMPHeoiQkENZG
         1qPgKsJIZ+Z4OIhhjgrUZNhJSNTx/885ovv+3uq6Gifm5lvxnNBAPy/3DIkZuUUaW/Me
         cfsepwG7vyTr9bvLQit9BJrjvv5x4mgQn1m5srNmD5OTpgQhBHP5/KXCx43TInY7+phK
         3QrpNJ4sdScZ0/g1d1Jq/W3CNMd9Iak0JU05Tg0av4pu83fwhpybOyBWW4f7Vx8nvQQb
         NVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zIWMF1R93QZItw73bSxup0eAGPLoi4yPEdVTTG3P0l8=;
        b=lKugka/j0+AcGLq9kCZ3LSqQnlGI4HIJfdWCoRPkX2Mt+uv7PBMfPRmA9bh4kiRMpI
         aFvfP9gdkvHh6HtffnA+T7cBtAdfwKjkbnQzprJByS6xYooOSzf5XMkC0q7ryer3yg73
         Ofkio1+LP2Le8gZa+lGyGEYG3zvqMyWc5FPAGe/lt0WTiK62jPpsO0yMkCiNAWY8a8y0
         Aa04sRivZgJxuAWX0ACRSN/s1rLQBB4IXhPZ3hZLXJ6IXuExBLoKzqTPI3VJ0Fqm4wLz
         fjtUBdJMG+oGXXjgAKSItvR8uZNwmVn6sTzhCEPckKiBkW5AfrOcYzEli1R+oAXy+GE5
         LKZw==
X-Gm-Message-State: APjAAAUB16QdCEe0jKMBRkE4gU7m5E8Wg3Z2tZf4vZDmPJQpdNXWZUMe
        Md013IcvHiR1tSa9S24iNoizBg==
X-Google-Smtp-Source: APXvYqwgF+DBaVZpWvKYikGIZNq1CHKcP+h0/bYMEdXtStb9fERIdJp9VuYgiq+xcG++kR7KEjeEjw==
X-Received: by 2002:a0d:fb87:: with SMTP id l129mr14992561ywf.432.1554549741641;
        Sat, 06 Apr 2019 04:22:21 -0700 (PDT)
Received: from localhost.localdomain (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id w22sm12729360yww.58.2019.04.06.04.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:22:20 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Wanglai Shi <shiwanglai@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 1/4] dt-bindings: arm: coresight: Add new compatible for static replicator
Date:   Sat,  6 Apr 2019 19:21:42 +0800
Message-Id: <20190406112145.15184-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190406112145.15184-1-leo.yan@linaro.org>
References: <20190406112145.15184-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CoreSight uses below bindings for replicator:

  Static replicator, aka. non-configurable replicator:
    "arm,coresight-replicator";

  Dynamic replicator, aka. configurable replicator:
    "arm,coresight-dynamic-replicator", "arm,primecell";

The compatible string "arm,coresight-replicator" is not an explicit
naming to express the replicator is 'static'.  To unify the naming
convention, this patch introduces a new compatible string
"arm,coresight-static-replicator" for the static replicator; the
compatible string "arm,coresight-replicator" is still kept thus we
can support the old DT binding, but tag it as obsolete and suggest
to use the new compatible string.

As result CoreSight replicator have below bindings:

  Static replicator:
    "arm,coresight-replicator"; (obsolete)
    "arm,coresight-static-replicator";

  Dynamic replicator:
    "arm,coresight-dynamic-replicator", "arm,primecell";

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 Documentation/devicetree/bindings/arm/coresight.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index f8aff65ab921..f8f794869af2 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -69,7 +69,11 @@ its hardware characteristcs.
 
 	* compatible: Currently supported value is (note the absence of the
 	  AMBA markee):
-		- "arm,coresight-replicator"
+		- Coresight Non-configurable Replicator, the compatible string
+		  "arm,coresight-replicator" is obsolete, keep it to support
+		  the old DT bindings:
+			"arm,coresight-replicator";
+			"arm,coresight-static-replicator";
 
 	* port or ports: see "Graph bindings for Coresight" below.
 
@@ -169,7 +173,7 @@ Example:
 		/* non-configurable replicators don't show up on the
 		 * AMBA bus.  As such no need to add "arm,primecell".
 		 */
-		compatible = "arm,coresight-replicator";
+		compatible = "arm,coresight-static-replicator";
 
 		out-ports {
 			#address-cells = <1>;
-- 
2.17.1

