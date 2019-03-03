Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433E6C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EA520857
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtD7TBbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfCCRNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 12:13:52 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42140 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfCCRNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 12:13:52 -0500
Received: by mail-pl1-f195.google.com with SMTP id v11so1345196plg.9;
        Sun, 03 Mar 2019 09:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yq5wxwSzSOiQKae/Fl8cjis8j+TFJgO/dAYMPjapJ44=;
        b=MtD7TBbXLyW6fjethOzFExYZI8piXlJEpV2qEZKIYUw42knJE9ItuU5wuzL6Ign6Sq
         VF0KfgM79UEJNfn+oQ4S/e5QtgXk/5UwNLdW/6tdFh2BI+PQMgcNMeig8XaIQrm/FpCC
         a/BU+Owy9YzpICcSwliPiU9NYFSMpSU4pGmXeUXOUEYl0AUz9Ux1HLWsGAOPBAjQgp5v
         bW0+ZV9SWPUz/A4c0b7/2E6ejxVY3Pc2o/JGv8IzOPBygQVYiuRLD+S49/WekIttte0+
         Wo/fj8OMKyf0bgVJ9Ju4oY0ykw4uaZyJ8jCusKEJ4bd9RC4Tmx0clVkqRfue9khM9bxa
         3rZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yq5wxwSzSOiQKae/Fl8cjis8j+TFJgO/dAYMPjapJ44=;
        b=lhJIFaCh17mzopXNHqmCRZM5UYMXnwF9O9xMYZDNkt9SCMGA/vxtj5vCi1IBS88Tkx
         jutt+jXvddW5ODeJ+UDWsl9LbddbF4dKZf6RmuSxhQpNAdTHz8pAypsTmAB5Hc3e9kI4
         7dnc1vOH5xWzMycNmqaoSIMZQCzsOcF7ojdn3ojfkTAUTxkTPp+l011rIVRk+f4w3ZzB
         TsD8+0JsjKc+LAWd/aLtsWeZ3LatEy0Xmly7rnQ5LlqEmpJDUcU24QSgaoTLgWt+R1CB
         wD86TB3H5YrMDeCcN3tuahA8/XD61JVcGuxNIxMfmxzu3GX6/sYKDiKghRiFh2oFp0aM
         ubVw==
X-Gm-Message-State: APjAAAWzBSTFgM/HlvJ4UaCYZM33hl7VtPx9PhrNcm5rJr+VdrXVZHLB
        roKEQSrqDlJt03xChZekVzQ=
X-Google-Smtp-Source: APXvYqysRSIMaTkF2jEZg2EV10D31KYgs37WSSrRrIQwB1hI5QxwgHTB/mbyIiwICzZXKvuEzHTqkA==
X-Received: by 2002:a17:902:33c1:: with SMTP id b59mr15885023plc.220.1551633231506;
        Sun, 03 Mar 2019 09:13:51 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id e22sm5349412pfi.126.2019.03.03.09.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 09:13:51 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 4/7] ARM: tegra: Set up L2 cache using Trusted Foundations firmware
Date:   Sun,  3 Mar 2019 20:12:11 +0300
Message-Id: <20190303171214.24821-5-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190303171214.24821-1-digetx@gmail.com>
References: <20190303171214.24821-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tegra30 L2 cache should be initialized using firmware call if CPU
is running in insecure mode. Set up the required outer-cache write_sec()
callback early during boot using the firmware API, it is always a NO-OP
on T114+ and is NO-OP on T20/30 if Trusted Foundations firmware node
isn't present in device-tree.

Tested-by: Robert Yang <decatf@gmail.com>
Tested-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index f9587be48235..1e89cfefbf68 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -38,6 +38,7 @@
 #include <soc/tegra/fuse.h>
 #include <soc/tegra/pmc.h>
 
+#include <asm/firmware.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -74,6 +75,7 @@ static void __init tegra_init_early(void)
 {
 	of_register_trusted_foundations();
 	tegra_cpu_reset_handler_init();
+	call_firmware_op(l2x0_init);
 }
 
 static void __init tegra_dt_init_irq(void)
-- 
2.20.1

