Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C7CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C642083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="YcfcGF9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfCVNbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:31:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40568 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfCVNbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:31:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id t5so2362962wri.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 06:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5gkvR2VoxuRrg3L+U8/Oe/NaMmWfQ9+b+NnIeTVNuWE=;
        b=YcfcGF9cxq1OnQXBUxQ6ivOwEaFi8te8o+Nskf7Ein/VFibhXa+geiCPriPCKWGfrf
         PiLW5mAMbXyHq3MKg0dc7fmwMFDhFkx+oeoqo16JJ1/LuvrQhcTEpUdITmcEdW7J3vQ8
         YIW6IaZmmhjUgJdryFBw6oCOywvQ2dmDp/wnm54904AefbMs9AcHRewH9+MovataGPPf
         Bregia2/13jE5783sSQSy4xVbwtBklV/cSM4XKCQrVWhKIfaCiJDhosCaU2mXo/zH9m2
         gtg05/CM6ixqznIQdUGc5DfxEEeq/GSRvkbS+nOtl4iLcIPED7gVAVaJuskuQSJ828+2
         y7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5gkvR2VoxuRrg3L+U8/Oe/NaMmWfQ9+b+NnIeTVNuWE=;
        b=McIc3/3FQL7ojs+KjTN+zMdpf5gbKJlmtVyE3GstfHKVy4ERBw/7StYs54XAEAUtki
         iMRNobEAHiJ8dwb2Xq90ntGP0zbzjIJ0m1LQsR0BualztNq2TD8ECjBE5pnEriu4em7i
         QOvbN7NQcu9C4SN3zQkQEMLPfdjmmdTO4kWjoHXWafI7bHLjAjI05K4KCLCWZ+8eXnrP
         +O2zuwwrjCTVUNtLa3j+4rjBeDUSB5nG1U+4RP4LefbtuqYmQnQDK+EVoryVqcXUI/Oq
         R0HHSGrtXXo1/GaO3WjMI1yJa7Da+7C7hvDcI5xMSQ1oTA2plfuiebfxOQIKem/+doNx
         SAXA==
X-Gm-Message-State: APjAAAV9nzT3S+3iiO3FDvjXPspY3L4WfY2LVzi1PMj05j7E2X5xTrwd
        LG6/oLPmdNPhO9b+nc0odBr6wg==
X-Google-Smtp-Source: APXvYqxrx9EOykj4l+wHI+q4G8hOsnknB5tP7GPzr++4efWDtjss9+3tVk1T6Arcvt8ckY28QE/C/Q==
X-Received: by 2002:a5d:69c7:: with SMTP id s7mr6277597wrw.71.1553261473089;
        Fri, 22 Mar 2019 06:31:13 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o15sm4684345wrj.59.2019.03.22.06.31.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 06:31:12 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 3/4] ARM: dts: da850-evm: enable cpufreq
Date:   Fri, 22 Mar 2019 14:31:04 +0100
Message-Id: <20190322133105.5945-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322133105.5945-1-brgl@bgdev.pl>
References: <20190322133105.5945-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Enable cpufreq-dt support for da850-evm. The cvdd is supplied by the
tps6507 pmic with configurable output voltage, so all operating points
can be enabled.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-evm.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index f04bc3e15332..a0a1b3dccf37 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -191,6 +191,18 @@
 	};
 };
 
+&cpu {
+	cpu-supply = <&vdcdc3_reg>;
+};
+
+&opp_375 {
+	status = "okay";
+};
+
+&opp_456 {
+	status = "okay";
+};
+
 &sata {
 	status = "okay";
 };
-- 
2.20.1

