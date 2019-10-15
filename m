Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31E3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 06:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F6F2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 06:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YOT0SMP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfJOG7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 02:59:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41901 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfJOG7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 02:59:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id t3so11531862pga.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 23:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WEvY8mI7wziVLeSGskg+VNlvZA9UmNy6YweIvzpqB9w=;
        b=YOT0SMP8zAfJji7EtL9vvZypd6z4pxouSQAnJufkKRSOMQ4ymp7uwYdjKZcCXY7Zr/
         vlHfrHfFTdZDS7kxk9/xC++gQjcLxWTpFf1Emh86cDYBMu9X0nyxBsOvX6zpeyDGFXg8
         sHb+qmocNkSYNxf9LblfFZD/XBXqzbvc/zUvVX/hYJjquDKKTQ0o0sY4IgVjCL2LiSi8
         qMPvK2TNwjKMR41GCEAWL3IiVLt/FAhHUOeXJouxPtHSvK/9eLS8eODPM1bEWkWRDHmr
         1L4HLAOGKmMoAC1as61Tls400S2SuDX1FGS1HRWvfX7H83dewtHM792iH76FBZw+XJya
         I/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WEvY8mI7wziVLeSGskg+VNlvZA9UmNy6YweIvzpqB9w=;
        b=cO7tY9+tSgDN1KXanm2AfaW+bHjEwqf5dDSCsQIVQbInaxk9CI1SyP0QFjkIPSr04M
         zscp7YKmAuAkDCLLXeBwIu25EnZOgArpLEsdja88NSMgCPzpOwxbzo4l82kxSajVgkHz
         FmgIrr/mMQdP2n/XNTtQQxVVfZwgXdvN6jKK5P5XLzYzL4MgbLMPoKmVvxpC7v1fXfzH
         aJS330MYcnrfITsCWZtYAD5rYZIDqJSXXDXebDTzyNBM2qDQkGBx1r/gkpD+HGAjWREF
         zW54NlueQOr3R3GvR65b42Ed01c6NgoGYb1B9HFoeHiPOQgKg3GY8NuVWdiCf3cpFaTx
         M7ww==
X-Gm-Message-State: APjAAAUxjNwSbXOGJF7HZmxdolfXf54j5g8KneqUXUup+tt6nazOBNHN
        71mgcvqdvhSufPsVzKkpQfm8aJ7s1TU=
X-Google-Smtp-Source: APXvYqyVgzodVpkQoZfWKsHR6n19NZcAwX3aK1+mxFq1JsBD/k0LL87kiVMZ0tTHshCDkxYoswk+bw==
X-Received: by 2002:aa7:9e88:: with SMTP id p8mr38091616pfq.10.1571122779560;
        Mon, 14 Oct 2019 23:59:39 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id i16sm17952646pfa.184.2019.10.14.23.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 23:59:38 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19][PATCH 1/4] ARM: dts: am4372: Set memory bandwidth limit for DISPC
Date:   Tue, 15 Oct 2019 00:59:34 -0600
Message-Id: <20191015065937.23169-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

commit f90ec6cdf674248dcad85bf9af6e064bf472b841 upstream

Set memory bandwidth limit to filter out resolutions above 720p@60Hz to
avoid underflow errors due to the bandwidth needs of higher resolutions.

am43xx can not provide enough bandwidth to DISPC to correctly handle
'high' resolutions.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Cc: stable <stable@vger.kernel.org> # 4.19
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm/boot/dts/am4372.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index d4b7c59eec68..cf1e4f747242 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -1142,6 +1142,8 @@
 				ti,hwmods = "dss_dispc";
 				clocks = <&disp_clk>;
 				clock-names = "fck";
+
+				max-memory-bandwidth = <230000000>;
 			};
 
 			rfbi: rfbi@4832a800 {
-- 
2.17.1

