Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE24C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDEB20881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="daAtSqCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfEOPbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:31:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33158 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfEOPbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:31:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id h17so1566602pgv.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SQsgM6LD4OGmyb9zuec5UbAtvnTOoKL54DBY7H0uK1U=;
        b=daAtSqCJ/oTaEYkG59u3o7jjY8qmxpZRWzhLXKwEHrXH/u26lAXnoFPkn/uCG/Sl6k
         UwbWWhR3FdnriNAjE2O7MvVmW1YSlkjnNGHYNQZXSckOluh1bP7799pE5M5xRw+A+4aZ
         ZTEZR3k7vhKDR6vgJEFTaz+4TP7QaLtvPz+jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SQsgM6LD4OGmyb9zuec5UbAtvnTOoKL54DBY7H0uK1U=;
        b=eTmyHj6qV6Z38zy2/LKKAVyGBKAtCwThACBqDPmGScBmEgb2VhiA5bzCAr20cYEEYQ
         wXo22B9BFatmbEG4ze52gwag/uppX4WuFTU+59o06HGTjn6BVm8bS+Rhf5zEsG3sTjxw
         +DskeqhQ7/FUqQQsG696JBB5IXFK7g0h8dtopOj6vmcyYASTVAdiFGsYheHsCQCduWZU
         fMg6tWbC2PbsYUS9P3bCwvlNdmuxlvJYNkQmHPCbPoiE5oWnGvOEfBbAR5vPQPHxS8RH
         7Qs4YYVd1K3zqOQI209qEHlekw/Xgbzko+v+XpXvXB8LkFX1VInFEoQ7lVekpzHWyo5o
         zEnQ==
X-Gm-Message-State: APjAAAVQVgDyAYIgIDcVTGVR/ddCd9opMF7IRFyuX0CDimZVUNpD1YWI
        Ac5wZu1BKzQCSenUVevXeKMa6w==
X-Google-Smtp-Source: APXvYqxOUzLo/if+h9XIHzCEFeYe9LeIRDutH5jCNlO5xeuGnD6kyzTn/1KEjr7JOey3ewert2okdQ==
X-Received: by 2002:a62:164f:: with SMTP id 76mr48532016pfw.172.1557934296145;
        Wed, 15 May 2019 08:31:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id e24sm3792704pgl.94.2019.05.15.08.31.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 08:31:35 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/2] ARM: dts: raise GPU trip point temperature for speedy to 80 degC
Date:   Wed, 15 May 2019 08:31:27 -0700
Message-Id: <20190515153127.24626-2-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190515153127.24626-1-mka@chromium.org>
References: <20190515153127.24626-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raise the temperature of the GPU thermal trip point for speedy
to 80°C. This is the value used by the downstream Chrome OS 3.14
kernel, the 'official' kernel for speedy.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm/boot/dts/rk3288-veyron-speedy.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-speedy.dts b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
index 2ac8748a3a0c..394a9648faee 100644
--- a/arch/arm/boot/dts/rk3288-veyron-speedy.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
@@ -64,6 +64,10 @@
 	temperature = <70000>;
 };
 
+&gpu_alert0 {
+	temperature = <80000>;
+};
+
 &edp {
 	/delete-property/pinctrl-names;
 	/delete-property/pinctrl-0;
-- 
2.21.0.1020.gf2820cf01a-goog

