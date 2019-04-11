Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE711C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762822184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLzh8zCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfDKWNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:13:48 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36853 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfDKWNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:13:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id u17so5917069lfi.3;
        Thu, 11 Apr 2019 15:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oG3hPnb3KN0s2uq/zI/tZV54jaBGk8ESPyFLbdZwwek=;
        b=gLzh8zCJhl7b4U3GN4z9jtOtTgE6upGkg4PvOZq4ywqKyqqCszJ8hAX23bKeoUqmer
         KiI4wzva9UhYkAyLRw5CjYqrg/z9Yy59g0cLc882j6UFGFjWoIk9rmjoHymYu4oVja5t
         CnwjOKDIhDbMlXnDPHP5VOpogoKw3etNuURWYFHtvkWMbJBeISzCGGO9VAPAT6MMrpUL
         Bhu0uCWRXiu6jnb3AcYY6BuugTi558mYa1ehB4lu1ZdyxORheVmYRc10v1ySHdMvaXtv
         j0CxbbV6zFkF9UpAnCjtKfSiBnGF7A7G8tCCN+2jrjboTRM87Kk0U+/apQSCUROQWzWO
         nXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oG3hPnb3KN0s2uq/zI/tZV54jaBGk8ESPyFLbdZwwek=;
        b=cGRbUWWE0woX6fLL04zXg75pKRnCRUCsGDvYYdf/EtznlFADtTSNHysgSd5atwcBNl
         R7vVvYKMescy8VdSDeUmuNR/WUJ/LUFdouGgmRM4/4e/Z6aY82UfFSyxIjA0Hp00hkOn
         glUR2kH0jqRt+IoQuI0JMkaHJ5rmeOS+5U1Vj74O7kQMSOnq9w3G9eVQ/DPIwq7gq05X
         AtPIqECv8gUjQURqV8r+9IgTvCkZr+oHhQ414FRN2Ao0zs/0FJtq8/Gvnxxb0F+U0FY6
         A7jb1XD9mvWXmdZ7vtgQ/919jZTFKurplK28sEzZdPNOeKbjDgPXUPGzmpSGIJAIfSO2
         RfUA==
X-Gm-Message-State: APjAAAVI4oGI/jFm+lD3piWK2FUq5nHAWH7PVbTXa6zUqVk49r1exRhe
        Z78RzsdDzJOIBIQAvVu3Uyw=
X-Google-Smtp-Source: APXvYqyguAJO4bSZIkyF/lx2frvV86agjIc0TxAv4rN4swfb05Scf6dRWrP6MT2lOGLY5+ZWUPWrUw==
X-Received: by 2002:a19:2d57:: with SMTP id t23mr7151864lft.99.1555020810449;
        Thu, 11 Apr 2019 15:13:30 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id f4sm7953526ljg.37.2019.04.11.15.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:13:29 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] memory: tegra: Fix integer overflow on tick value calculation
Date:   Fri, 12 Apr 2019 01:12:48 +0300
Message-Id: <20190411221250.23233-3-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411221250.23233-1-digetx@gmail.com>
References: <20190411221250.23233-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiplying the Memory Controller clock rate by the tick count results
in an integer overflow and in result the truncated tick value is being
programmed into hardware, such that the GR3D memory client performance is
reduced by two times.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 60474597180b..89e463952b8a 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -285,7 +285,7 @@ static int tegra_mc_setup_latency_allowance(struct tegra_mc *mc)
 	u32 value;
 
 	/* compute the number of MC clock cycles per tick */
-	tick = mc->tick * clk_get_rate(mc->clk);
+	tick = (unsigned long long)mc->tick * clk_get_rate(mc->clk);
 	do_div(tick, NSEC_PER_SEC);
 
 	value = readl(mc->regs + MC_EMEM_ARB_CFG);
-- 
2.21.0

