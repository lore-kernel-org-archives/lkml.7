Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFBBC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BF420663
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W4ECwcO1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QdOjTop4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfDSTqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:46:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34942 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbfDSTq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:46:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 853376188E; Fri, 19 Apr 2019 19:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555703187;
        bh=TItnokO3ptuUROJyjnRI1pbipmM6zmQ9NJP7PbJyjek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W4ECwcO12haKdlhU3tOteW022Z06HRPijG0QWjBYhcJfI7/zALqOJ9v/b94ic3WbP
         n5o3Gxp60LwzGNVksTVMAIUESg1S+SCyk9jdgdhur5W+zOh6MaL0KIMKg0Q0fgMMXt
         2W/2rZdjOwL9aTtZ2SQk0UV8bFM7oiANgAaB+lZU=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5784461728;
        Fri, 19 Apr 2019 19:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555703186;
        bh=TItnokO3ptuUROJyjnRI1pbipmM6zmQ9NJP7PbJyjek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QdOjTop4ixG81paLng/o976nFYBicwB1ZVXAgnOC4tEy5vd/TuawS3jzxZ12rXRnR
         2apu/HF9C6km5zdMH7fgLBi66UiMytk4yjtnOhgGTD5i/ZDrGFAYMw5LM4WVKMbfTh
         4HFSjxxfPn2CZ1k4Uc/FfGkqcKFQLYEMliCfo0Zk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5784461728
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 3/3] dt-bindings: drm/msm/gpu: Document a5xx / a6xx zap shader region
Date:   Fri, 19 Apr 2019 13:46:16 -0600
Message-Id: <1555703176-5499-4-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555703176-5499-1-git-send-email-jcrouse@codeaurora.org>
References: <1555703176-5499-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe the zap-shader node that defines a reserved memory region
to store the zap shader.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 Documentation/devicetree/bindings/display/msm/gpu.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.txt b/Documentation/devicetree/bindings/display/msm/gpu.txt
index aad1aef..1e6d870 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.txt
+++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
@@ -25,6 +25,9 @@ Required properties:
 - qcom,gmu: For GMU attached devices a phandle to the GMU device that will
   control the power for the GPU. Applicable targets:
     - qcom,adreno-630.2
+- zap-shader: For a5xx and a6xx devices this node contains a memory-region that
+  points to reserved memory to store the zap shader that can be used to help
+  bring the GPU out of secure mode.
 
 Example 3xx/4xx/a5xx:
 
@@ -71,5 +74,9 @@ Example a6xx (with GMU):
 		operating-points-v2 = <&gpu_opp_table>;
 
 		qcom,gmu = <&gmu>;
+
+		zap-shader {
+			memory-region = <&zap_shader_region>;
+		};
 	};
 };
-- 
2.7.4

