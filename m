Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A58C04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F8821019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tf95ZE3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfEHCUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 22:20:12 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43506 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfEHCUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:20:11 -0400
Received: by mail-yw1-f65.google.com with SMTP id p19so12146009ywe.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 19:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3xn9aUdHTXUU+Zzxyk2IpkpM9si4DJKJs9eF/WREL/I=;
        b=tf95ZE3nCfdgu1pnTDfH+dgBMFO5i/a0a0gc+zEHdvOxf2q0PDyUZTkgfr0o2qjpd1
         hWUGkOWMovWzFekc8yXWkTxPxt3P0Hncn+FNwVdnpTQz+Wqx/ZWSJT5TQcA5Xe56LVbh
         C6qfw3gcsRulLCzxPE3aJpvYdOKxDQlHPwcudUVP6ZlWK8cuhdBmQFhKuFcUzt+nFgJt
         5RsKHcugdpgvojQKpjzuNAvPSBpmKMewr0ZcPUzCqmMVeHksBlZK39fhYfsnkePHWrxH
         McbkxCCCe6G+E354jNQiFHZ5j6GBUwgWGt2hoMWaIw+pnAwWd9adUaSyoUJfnk10VMKv
         fi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3xn9aUdHTXUU+Zzxyk2IpkpM9si4DJKJs9eF/WREL/I=;
        b=pRxepKmuMY+67fV/UkJAdDajFNHY8OwLjS97l1wkUYzVNn6becfhLKShOQspDM81/L
         9a4URo4vEaN6xnwHHZtNQIceulx9XzqTk4mFp/SzgJaXtWwnkOg/dXly5pEkSgTLzfKD
         nCpIvX7YqoLFdOHh4IM6yEZrJgF2ydptcAix4AcuZqC0Hncf+mKTaG7GkYt/IvImesHl
         RbiOu/B/K1HcBqFetazTTI/N5YFYyg91gD5nUA6s+VzIMlY4V0h+crm4low9Qlvl2he9
         TvhtxMWvP/Oev09rT34Gp7KwT2Mae/74mKgKNqURBmSrDHQG3pGMtqPpqCeGzzsyOgqS
         oeqA==
X-Gm-Message-State: APjAAAWrZA6Jt3FTVupA83nxc06BlCScKHR5uBylQ/nk5o6qa0+JgaF3
        MYIYjhHtr1V/oSJ60ibkJEbfFA==
X-Google-Smtp-Source: APXvYqyecJI9uSLoBVIG2oni2XR7jmB3bIQR/Y9OHbOtXUCo3QF+8holn3bu3+ZduqAFuRNVS5n6Og==
X-Received: by 2002:a81:518c:: with SMTP id f134mr7492739ywb.0.1557282010773;
        Tue, 07 May 2019 19:20:10 -0700 (PDT)
Received: from localhost.localdomain (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id s4sm1168116yws.48.2019.05.07.19.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 19:20:10 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 04/11] ARM: dts: ste: Update coresight DT bindings
Date:   Wed,  8 May 2019 10:18:55 +0800
Message-Id: <20190508021902.10358-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508021902.10358-1-leo.yan@linaro.org>
References: <20190508021902.10358-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CoreSight DT bindings have been updated, thus the old compatible strings
are obsolete and the drivers will report warning if DTS uses these
obsolete strings.

This patch switches to the new bindings for CoreSight dynamic funnel and
static replicator, so can dismiss warning during initialisation.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 81fabf031eff..4bdd247b9534 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -98,7 +98,7 @@
 		};
 
 		funnel@801a6000 {
-			compatible = "arm,coresight-funnel", "arm,primecell";
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0x801a6000 0x1000>;
 
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
@@ -133,7 +133,7 @@
 		};
 
 		replicator {
-			compatible = "arm,coresight-replicator";
+			compatible = "arm,coresight-static-replicator";
 			clocks = <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "atclk";
 
-- 
2.17.1

