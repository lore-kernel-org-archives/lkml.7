Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAB9CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 22:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4A621872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 22:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t7oj1A8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfJYWuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 18:50:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36289 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfJYWuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 18:50:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id g9so1456098plp.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 15:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=osNStqGe/+pixQ+TIIwo4hgOQ0iCE+khF0tMpALPhbA=;
        b=t7oj1A8/ELwYNKEiPY/Pw18dHmD+od22U+4C5NhOE2wd5jiFHCseOjSRPgNDzrSyKq
         dPtd5CcVf9iIPtDONddh2eO4eP3j6pOkNRnByhXulltB5XaUZ4VBvTkOfFT3PuuTpbgR
         fm3I84wjJaEQhBPHt7WSbAUDubIimzLHWBCLSLWX5sMsbyrT3fCHo5F1xVc6KrpAYg6a
         AgjQBcwoRkdatjyjUVB6aSuWoLUrCrbKujOVSG/5gs8lzDyIeWuQNxGe2iKOkrtKXEpq
         1wh9xGKkBGFWOlUKiBuDHcJfU/9wkfMXegJLC9PRvNvTK7V02u/r9lQ0YSfzf7FIX6cd
         JAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=osNStqGe/+pixQ+TIIwo4hgOQ0iCE+khF0tMpALPhbA=;
        b=Hdzf0wWNozDD3r4Dv7qvNx/SI/w7njffg+fBlA3IV4HtlyvZESmkcvefWa2QWOBABp
         IyuRCmaJ0450YyKjy8RYTVVzazLqfuexswOWeuRfyylFiUZBNPh4c7CBB1eInXnyf/SN
         cYaB+C9SWLgVBxCN9OH/RCLNsSq+TgbiiL0jtyHAqokU0S2ebAW2cFb5bXHxVB8EzmtR
         r5az3xH5omnFtBUJ/YBbh4sWes/SEnyp3t6C/fAGqjLuG/GcQdJ/vPn4TJhKIed3VQna
         6/WgZtIAO3R8EolXLUtaY+vxTAiMPa6CMUg96zDw3MRn6y1HB5CRg8HHrTY4mFDTynXP
         /jiw==
X-Gm-Message-State: APjAAAXvPW4eoIBkuhz16+UwbjbSEmznzdDTCeB1uNLLFTxcJbvO21iz
        x4Nme5yOUZunvWPQ5krknhgPlTNX5kI=
X-Google-Smtp-Source: APXvYqwEfPgMUzNALdpaZ7hIfRdBK9Sl+x7omJQowf6j1uRY6bjZJnZXHQcn0Yn6ut98Jyy0zAwi0g==
X-Received: by 2002:a17:902:8a96:: with SMTP id p22mr6280974plo.272.1572043819516;
        Fri, 25 Oct 2019 15:50:19 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id o15sm2758018pjs.14.2019.10.25.15.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 15:50:19 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [RFC][PATCH 3/3] example: dts: hi3660-hikey960: Add dts entries to test cma heap binding
Date:   Fri, 25 Oct 2019 22:50:09 +0000
Message-Id: <20191025225009.50305-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025225009.50305-1-john.stultz@linaro.org>
References: <20191025225009.50305-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds example test entry to create and expose a camera cma region
via the dmabuf heaps interface

This isn't a patch I'm submitting to merge, but just an example
of how this functionality can be used, which I've used for
testing.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Chenbo Feng <fengc@google.com>
Cc: Alistair Strachan <astrachan@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index 190ac29b9e2f..783c5b2abd2d 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -75,12 +75,23 @@
 		};
 
 		/* global autoconfigured region for contiguous allocations */
-		linux,cma {
+		cma_default: linux,cma {
 			compatible = "shared-dma-pool";
 			reg = <0x0 0x20C00000 0x0 0x4000000>;
 			reusable;
 			linux,cma-default;
 		};
+
+		cma_camera: cma-camera {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x24C00000 0x0 0x4000000>;
+			reusable;
+		};
+	};
+
+	cma_heap {
+		compatible = "dmabuf-heap-cma";
+		memory-region = <&cma_camera>;
 	};
 
 	reboot-mode-syscon@32100000 {
-- 
2.17.1

