Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E277C2D0DE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C89E206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxjQFh36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfLaT5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 14:57:41 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38479 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbfLaT5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 14:57:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id u2so2525176wmc.3;
        Tue, 31 Dec 2019 11:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CsU1YPkDyWBaNW9/0vlGQy7znmLLiuhBVSrYueAradc=;
        b=FxjQFh36axpDJGsW4aYnia11mXI7/TpaVw3Gb5v7dqoalYBw0RGP9TVCpJHwmWCBZC
         cy2Pflp8YA+u9Y8Ph8O7dh/ot2UqQpxPpmAcgWa+0NyYR8YSY6u1lOhPpPjaVq+lt3Td
         lf/NrsQVR0XI1b/0PeD+5Vm9GEdrRNl7MDC2IRhO/802djs+MAMezDULypjQ4zvpHTcv
         /DflrTnkyucc8ZXlVcy6FwGq1XqwZBqiJbSwNOlh8hKq/EJo7ufpJpnN5CBTuS4MfXTZ
         33IDsVRhvmyJUduMZrfOuY19ESCtC1XBYXYW0o1YGKsbE+BXJ6I48CFNYVZQxer+JLoH
         ycCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CsU1YPkDyWBaNW9/0vlGQy7znmLLiuhBVSrYueAradc=;
        b=M0pXbKhQ2En+Cp5Tw6jxpl5W+1J9PrrMJml7D1eJk9ePTMbZcaP6/fu/G3rORX05uJ
         euV6eJjd04QNq1YsCj73SetlSKaBGkoqMTOTcLHKXhWLwDQqiWptQZlDr2SERg4+84SP
         Zmumd2euvLnJHeCwkc+kodd9Eg7956WbbeRpNou2H6Jjx2qLwaZV7red/ZM4iY4lbYxb
         taxBWG9MdHM1hWg6IhuR6+PebyW5lpGpriE0tLabiafNBMSuSwMs4G4PXsrL7du0Z3s2
         OU1oSd3ybwDOvTSxSu2vtl7Gfs2YzoktHJmrgGljUJfPlLnyxcqedFhiEK7VjC4DYTSW
         /vXg==
X-Gm-Message-State: APjAAAU1aDEp47VVLr3ODnXosh/aqGHnlTGYiCT/+eNgi8QCC4/ECwg8
        L/Qioh2cX19akhoSk0i8v8g=
X-Google-Smtp-Source: APXvYqx2NEAB3NMhC7wZ8inzFPyzFcxEskKjvfDe1exbGCNjUr8AL271HjxGRZnhu3BBR4eZw9UI1Q==
X-Received: by 2002:a1c:a982:: with SMTP id s124mr5532358wme.132.1577822258515;
        Tue, 31 Dec 2019 11:57:38 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b16sm51590572wrj.23.2019.12.31.11.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Dec 2019 11:57:38 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     robh+dt@kernel.org
Cc:     mark.rutland@arm.com, vgupta@synopsys.com,
        devicetree@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARC: [plat-hsdk]: remove num-slots from mmc node
Date:   Tue, 31 Dec 2019 20:57:31 +0100
Message-Id: <20191231195731.6037-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The option "num-slots" was deprecated long time ago, so remove it.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arc/boot/dts/hsdk.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index 9acbeba83..1d12808a1 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -251,7 +251,6 @@
 		mmc@a000 {
 			compatible = "altr,socfpga-dw-mshc";
 			reg = <0xa000 0x400>;
-			num-slots = <1>;
 			fifo-depth = <16>;
 			card-detect-delay = <200>;
 			clocks = <&mmcclk_biu>, <&mmcclk_ciu>;
-- 
2.11.0

