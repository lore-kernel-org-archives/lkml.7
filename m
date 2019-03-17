Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A4DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 22:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251362087F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 22:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDq82OY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfCQWz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 18:55:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40790 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfCQWzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 18:55:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id u9so10023054pgo.7;
        Sun, 17 Mar 2019 15:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yq5wxwSzSOiQKae/Fl8cjis8j+TFJgO/dAYMPjapJ44=;
        b=sDq82OY4NHq+gWmXsU0zF/TyBXvRvQE89Ccg1fWIqHxltD2U5zgX3D/IsdwogTJfLc
         atB3UZ5TJCF9933+Ha1vhBfqCOVnZoXFRUx0TvQcHKs/kyX00Tdlppp4+8S24CCf2RG1
         S+7KdclKfsd11lWm8z1slHNYGNuREULU5JTB4foy2DLZ0oDDqZ9Oib/uzuyw4avux8JE
         r6hJhVF2Ewicj2ta5O2W7kWIgspV7mdOSOD7aKBPHGpaT4WHLyLVynRisteAcHh4SaBp
         Rx7yr82DceGTD4eVlQTLe4n6DP/nTE5Ve5FvB1bBQgtlGekRtRpFNa1hYp8bsnkwhz0o
         nXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yq5wxwSzSOiQKae/Fl8cjis8j+TFJgO/dAYMPjapJ44=;
        b=AohM6dgQx65uIyvYW3diG5an3gciaOpegy0POWm24EUy/Pb/pXtxtlNNntb/X0N2l5
         lp7HrxRnw1qSnYT+NJT06wdeqsnyg+PUZTjWfuTxX9r8gyBj+ZxsP6IuGCXqeb48kXOY
         wNq4ojGNPL20rJvgilpJgiIxvk/H6/EZ616fbylvccdZAR0sRu3ybzz5vC5eK2OCVoz3
         BZiW2vIj63bSsgMdrBF850ypDTCKYqvVfSxCnAMI7szIPcKN05B9Taf8cggov+roiU5u
         kZP8nXpcL/CLgNUG60g6CQMRq1ytyHbraiCxa9T+8zJqOM9HNFOTDcK4qT1EM1cTCiRp
         WN6g==
X-Gm-Message-State: APjAAAV02VLwGnFtVjdGiphw53xhAPGkqu6A6w3y3bF9tJ7SJfQSISYm
        rcYS0x1R8OKzu5kP6yfW1FU=
X-Google-Smtp-Source: APXvYqxFiScNA8yf0lov+46e0AgC7VJxPldRn92Ro7qqB4qo5NE1wtdvXtzl7YI3ipSWiz2LwD0rUg==
X-Received: by 2002:a65:47cb:: with SMTP id f11mr14875231pgs.18.1552863355027;
        Sun, 17 Mar 2019 15:55:55 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-37-86.pppoe.spdop.ru. [94.29.37.86])
        by smtp.gmail.com with ESMTPSA id v2sm13738838pfg.118.2019.03.17.15.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 15:55:54 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 4/7] ARM: tegra: Set up L2 cache using Trusted Foundations firmware
Date:   Mon, 18 Mar 2019 01:52:07 +0300
Message-Id: <20190317225211.23091-5-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190317225211.23091-1-digetx@gmail.com>
References: <20190317225211.23091-1-digetx@gmail.com>
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

