Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA56C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECB2218AF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CJAI1CrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfDLK2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:28:01 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38119 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfDLK2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:28:00 -0400
Received: by mail-oi1-f196.google.com with SMTP id a6so7519915oie.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 03:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=770Ob84vz3SOnHU9WPlMyR//VhmOeh8sknOJE3geQGQ=;
        b=CJAI1CrYlZ0zplrx6RhXb/dBS/OxqzuAUxFPlQdQbehAsO2xhQ+bWJ4xbcGHDH8uVA
         +Z+Rtapew29rHN8GPaBb0Ixq8mHAd39PllyZVD+vmUGjIZWn+RxbAeZwvClFGP60QMg/
         zQG9El5PIoVIn3RMfluwFVBKsC2q7Uv+lDBQOnw2E2cl45rVARhCURjtuu2DeFf+PJPS
         E7vdyAeRkcr/e2copB1VQxemzlz9AWmk43KpLdW/O542bWEKimF9z+NnZHOmk0l0thaB
         BGBCPmO3uMoulXZM3IEJneTncVlTIDGJjhq3AT8OVy6+v6NxWu0MyDKsKe5tJwmj9ADx
         7d3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=770Ob84vz3SOnHU9WPlMyR//VhmOeh8sknOJE3geQGQ=;
        b=Go5kENqAxdnmcIiVCqpkhwEwUXHs2L6gEatz45TH8OvTc8EOJPGxLaX0T6NVhPLWXM
         Jao7dUxF+XqH3DMzkXDPLLR5AnfXu0T3mhj0eDJl/Y6x8PmmiY6s+gmS+IgNcwOZAn/Q
         +KyN1FoKr186C6IpXlZz2vFz/Xew06Eu+uQmUyI6guKY/n9n2ctpBwyDnp5Z35tXcq42
         fqchwKiBDrB+UGWHM/FxFg9ZXv8DzukGPqVMXU+GIhwRg5U5xSHf6JOQDurzJw/PU1Mp
         00IVBoqD36uBKJC6D7vioV2nBsS5LvGo0tWGpw3Mmkr3hlrsxIWvv4dKNcqU+20QZ3o4
         0GMQ==
X-Gm-Message-State: APjAAAWlExA5n5bs58mdbxxdOYI7LlA9OlyOiEFYEi/HM+a6IEnu4EHU
        eTpHfUviGCi+1oKhbSx6nrKJNA==
X-Google-Smtp-Source: APXvYqwDFsxTGPH1Ua8vt94ReYjfVGQ08Sxn2TVC1QXVnZQxtMlMNN92MhfT6t+Oir5CH04l4s94rQ==
X-Received: by 2002:aca:c4cc:: with SMTP id u195mr9628984oif.40.1555064879597;
        Fri, 12 Apr 2019 03:27:59 -0700 (PDT)
Received: from localhost.localdomain (li808-42.members.linode.com. [104.237.132.42])
        by smtp.gmail.com with ESMTPSA id 88sm17530692otj.3.2019.04.12.03.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 03:27:58 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 1/4] dt-bindings: arm: coresight: Add new compatible for static replicator
Date:   Fri, 12 Apr 2019 18:27:35 +0800
Message-Id: <20190412102738.12679-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412102738.12679-1-leo.yan@linaro.org>
References: <20190412102738.12679-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

