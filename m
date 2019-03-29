Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621D6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AD22070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZGFrmr7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfC2KNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:13:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50181 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbfC2KNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:13:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id z11so1939283wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 03:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Nh0o7w+Yt9ud7+T6lHPtFI13Y0R7ShnQgi+aiu0VS3Q=;
        b=ZGFrmr7zZI0jIM9pHHSJelJtWGPZIU0l0RAciOHkHM1DjuIM6iZmobVUiIXoWPsOpX
         e9uwfcKiOwD1A2+NKeqetExfxWJbVjbKmJQ88BETyDe6d88gS0Z1MdRUzFI4DIIYxLBN
         7rrdZApkc38NWlFElPDFVr272rtDux3HxDyX4WoFwhQlUw7xQlg3tkGjkZzF6kyfO5PI
         ov9WKuj3MZ/G5A7duSglQTPfSWZMAPclvk752DT4g+iPWo/H8zU7ifHlQt7WyGAu5Bn7
         12/hhoUxguTqZpftfdGWIzQnz+L+GcoL5P2VNCnfBX3kewA/O4Y02YyETikhcJpDpaQh
         Eg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Nh0o7w+Yt9ud7+T6lHPtFI13Y0R7ShnQgi+aiu0VS3Q=;
        b=tI6yTMntMVSsQvfvrlgQe2s6314nuU+SVH3yx2GsRk6HS1bRY00V+2r8rjW5jaHbjq
         Jiv1Yr2bszBC8ZZYPg9LXDOxTlYerqJLtj/2JDDq8JL2YPW3me/nxFnGPWaw4NA1yk1A
         2qcM8VJ2D1rlsFfpV0fc7N0SRzFYEa+G4qeKbySh37UWi655G75MKeV92K8hHXqHEHbi
         eTcbqftff4eptEIBro9LrIaqsYryD5rI5nbEfuwJu6qIo38utx5tPbRKImUI7hI7C49Y
         Vw7YH6KwYjdsFm/lzqfCW9XDaVygSEiTNJ2jVBbpDzLffYpCvay0COrxhOxwOjgHOnEw
         cb5Q==
X-Gm-Message-State: APjAAAUZUB1A3dRExVvY8Wh9ow9p65Tx2zVfRTQvqV6xEcl+p+aX8O+1
        I3e3pX1aWqFZoQRgYMUmW0oqfmvPcCU=
X-Google-Smtp-Source: APXvYqx3luLhX/jjPh24NdBSkw8j7xg6LIjb5h3KIj1p+cD/utAHRzRETOmRHrjL8LcTux5rNe5h4A==
X-Received: by 2002:a1c:a7c5:: with SMTP id q188mr2990714wme.126.1553854428681;
        Fri, 29 Mar 2019 03:13:48 -0700 (PDT)
Received: from localhost ([49.248.196.175])
        by smtp.gmail.com with ESMTPSA id n189sm2558433wmb.28.2019.03.29.03.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 03:13:47 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 13/13] arm64: dts: msm8916: thermal: Convert camera trip type to hot
Date:   Fri, 29 Mar 2019 15:42:19 +0530
Message-Id: <86fe318aa10e4fa967b88cf1d0a728271a54613e.1553853990.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553853990.git.amit.kucheria@linaro.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553853990.git.amit.kucheria@linaro.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't have any cooling-devices related to the camera. Use the "hot"
trip type so allow the temperature to be exported to userspace and
remove the "critical" trip.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index ea734b98ec96..e4b1010f70b6 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -270,12 +270,7 @@
 				cam_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
-					type = "passive";
-				};
-				cam_crit: cam_crit {
-					temperature = <95000>;
-					hysteresis = <2000>;
-					type = "critical";
+					type = "hot";
 				};
 			};
 		};
-- 
2.17.1

