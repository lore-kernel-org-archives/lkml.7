Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA613C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F7C20896
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHWqqrP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732059AbfGORaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 13:30:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44303 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731859AbfGOR36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 13:29:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id k18so17091333ljc.11;
        Mon, 15 Jul 2019 10:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ez/DtEbZm91hvKH3/uYPobJLTWojYBqiK7N01oWP7xA=;
        b=GHWqqrP8MGo5usVZkesx/S/t3wUr6lK7Nh0zI9P8FCe6cwHfY1ofjS8rd2gkTNi1AB
         Xm6F8B6VWn52y6oG1ygaM2YdtR3QGK2RXJfjHVrjwHu/sFWreOak530bov65iaoUMLJu
         KBGIvqd4yq9Q5zRRzj7+uQc4gyLN471CLYZMIsExyTXS92hIwYhZqNYelURn1kTt7bVE
         MWZG8K6dRRASsmhu+fBv5+eUBn8gSjvRsHDTF73myDkOcRkmgwKFkDwXxYCnqrRmCt8c
         3v587cKJL0VM2o8h8pgRbifzPatUeq4IVvF/9NClJtjb+38k1SWH+v85RQj2zvDGAry6
         167Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ez/DtEbZm91hvKH3/uYPobJLTWojYBqiK7N01oWP7xA=;
        b=d/v6XSQoCkGGgVDL7UdJy/4IG6DWXWXWZUaONWJpWlsk9EIo3o3rFixHtTG8Sy8fiS
         hMJk4PMtdTUCAuQS4SROukelY3HAEPabM1s7oDSYPb1xv4vAsRDsvlPUuHFlct8t0p1f
         HNlpjKhY44WPkPknKtsXFjI+TKl4iJX3YSiFDSYro08N5922iZioXcNZ5jdUixwGcxqI
         RO3Ci3/7jXgYG9DCNPBCOfs24eNQ/i0lfSvcwsohSIZxpKeAcfJ6ydwv3cJ3PaDLm8U4
         TtEIZkxuTMCFpD1XgylpSOemeiBXt42m09ovIdOA6j0/M7uJB7OOHHeHvelOTt/Fl+27
         XRTg==
X-Gm-Message-State: APjAAAVo78/2zJPNSAqeyYWW4tVjPOdnPiAeUeDTFu8+i4v/bE2i6oZr
        UEOUxD2/YjLdyEJd2RaAQuI=
X-Google-Smtp-Source: APXvYqyDNuo3sjvpZZ1PrzvsKvNjDFwHsZyeZMQ0175G+DbtEMIV/KWgUicezlDGR98tOBvk4oyIHg==
X-Received: by 2002:a2e:9ec9:: with SMTP id h9mr14042084ljk.90.1563211795641;
        Mon, 15 Jul 2019 10:29:55 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id b17sm3248765ljf.34.2019.07.15.10.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 10:29:55 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/13] ARM: tegra: Create simple platform device for cpuidle driver
Date:   Mon, 15 Jul 2019 20:26:27 +0300
Message-Id: <20190715172629.4437-12-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715172629.4437-1-digetx@gmail.com>
References: <20190715172629.4437-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new CPUIDLE driver now is a proper platform driver, hence it needs
a platform device in order to be functional. Register the platform device,
like we do that for the CPUFreq driver. Note that on some Tegra114(124)
devices PSCI may be used for the CPU hotplugging and CPUIDLE driver
doesn't support that case, thus CPUIDLE device won't be registered if
PCSI presents.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index d9237769a37c..f1ce2857a251 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -36,6 +36,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/mach-types.h>
+#include <asm/psci.h>
 #include <asm/setup.h>
 
 #include "board.h"
@@ -92,6 +93,9 @@ static void __init tegra_dt_init_late(void)
 	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
 	    of_machine_is_compatible("nvidia,tegra20"))
 		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
+
+	if (IS_ENABLED(CONFIG_ARM_TEGRA_CPUIDLE) && !psci_smp_available())
+		platform_device_register_simple("tegra-cpuidle", -1, NULL, 0);
 }
 
 static const char * const tegra_dt_board_compat[] = {
-- 
2.22.0

