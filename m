Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656D0CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D73F2067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="goNZ5OE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbfKAMmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:42:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36923 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730782AbfKAMmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:51 -0400
Received: by mail-lf1-f67.google.com with SMTP id b20so7145938lfp.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=skc4BB3FfJVhrMQufim0pPb5lTLStBal+/ZiI3PgHrk=;
        b=goNZ5OE4tByzOYzAc1bKhKcL9oM+UBCCFrvDNLRRvcNalh8UnNn6w3j3/Q21+wi139
         yiMCFOFtB95G2/yRPf1PDZQuswYXEi69SttUocHkc6sMbHZBdFvyxel4r9/0e7RIvZPM
         c/eVWDJF9fTGzUPSul9kKDwPdfk36qWT5Kll4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=skc4BB3FfJVhrMQufim0pPb5lTLStBal+/ZiI3PgHrk=;
        b=e/HVRsNdz8+NF/mWu/XLIh7l2+73uRFhG4KWRNn+v/mvB6KDPOOVPcXTIohigjM5ET
         dzXW6AKwU/9sKLWDsHy56004tnZjvOIpMDQ2J2xyLLLkh1olwfl8r/jo7BarTNhE89qT
         YnaTKzGF0emuaqpKHMrmURUrePdhC5N4BnOteSGRcJmZR5n9uw4iR6XtwD8QZM0Osi8F
         I+BM8t6zswmweLW8e1kvstR+wCo04zByVr4yIMm4gFK8n6MrRHLVGgyTJsoA8Slc+oNX
         RUU8US+jBxR6mjAj7eXrrpFKbkET8Y3nndfsrN37Y0bvt6quhgdpHUNsLxIsOjcupSMd
         H2jg==
X-Gm-Message-State: APjAAAWhe3cmFnNMw7LbAUNIwPJBwumpaM33Wvw/UyJu93GRvrNkXTh3
        6b8ZFYbrATtOKEgmy0vO/aKgiw==
X-Google-Smtp-Source: APXvYqx+LkhhsdE4uicd68kleysrFNvL7csaxcY4M/SzGwCUFxmQjOfm//4bJ58IrETbPNpw6KnCjQ==
X-Received: by 2002:a19:8c1c:: with SMTP id o28mr7221433lfd.105.1572612169565;
        Fri, 01 Nov 2019 05:42:49 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:49 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v3 28/36] serial: ucc_uart: explicitly include soc/fsl/cpm.h
Date:   Fri,  1 Nov 2019 13:42:02 +0100
Message-Id: <20191101124210.14510-29-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101124210.14510-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver uses #defines from soc/fsl/cpm.h, so instead of relying on
some other header pulling that in, do that explicitly. This is
preparation for allowing this driver to build on ARM.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index a0555ae2b1ef..7e802616cba8 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -32,6 +32,7 @@
 #include <soc/fsl/qe/ucc_slow.h>
 
 #include <linux/firmware.h>
+#include <soc/fsl/cpm.h>
 #include <asm/reg.h>
 
 /*
-- 
2.23.0

