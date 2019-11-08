Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE01FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27C32087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="e/P1lD7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfKHNCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:02:04 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36717 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfKHNCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:02:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15so6145621lja.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/C1Eg1dR+pzbI0uF0+AzerXAuAR/n78tvkDzoMBSgLI=;
        b=e/P1lD7zvmjURhmsvbX23QE+8ASowwEgb4BpM1IFfQWI91Tr3jDWiq0X6CrLk99wVN
         mPk6Txdn0NvIKorqKDh7HBcWVDg2Ic5Yi9fVd1R5QMWlVvOdwlxoWhTPHcB8cInVr8Dv
         yoknf6mGfRANkmWuDMLpwcTHs5OfxaRyfaFd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/C1Eg1dR+pzbI0uF0+AzerXAuAR/n78tvkDzoMBSgLI=;
        b=UAjsgPzIBYJ8OMGGPqwoe00bCIJsDKdSATN8e1c2V0qbtOfXwf4Nd+F1UwYpavdA8H
         aEnM5xwy/M8Ndr+8+5+z2UOt7wql7pasEaXN/i2rd5HkLeFYivj1fwRL8nhH/gPVmXwP
         go8bvEoi5DZ4PpzzS9ML9b0RWUf7g0dFLLPa7VgJZ+ApgnFM+CGd2HLkOgWC57ZvL94G
         I7G2XfRGfY7h1nTHTvDCes+z5N5WdSwlDudYLgh7Yd+8432SK3gn42jOUUUYSmfQEPnd
         nE1QewLrNZP8XpADUlIaUTRbaAR2zhRDBYpuZeYmcQRC1uQsbopX3wKXpjH2ppdMEihb
         EMIw==
X-Gm-Message-State: APjAAAWDqRz4j242PPZhIjC+ct4C6cR7hrcpuuUZ36shw48508JKaD08
        DPkSyXYWTloI56bAkAu1VGqAAA==
X-Google-Smtp-Source: APXvYqxZ1oqYp4p6l2IsGiGO+a6bcfmX2jCuzyyob5hxO/rAt/CL2aEGqAw4ukWNphNhXQIN4rIjrw==
X-Received: by 2002:a2e:b5a2:: with SMTP id f2mr6611603ljn.108.1573218118236;
        Fri, 08 Nov 2019 05:01:58 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:01:57 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 24/47] soc: fsl: qe: qe_io.c: access device tree property using be32_to_cpu
Date:   Fri,  8 Nov 2019 14:01:00 +0100
Message-Id: <20191108130123.6839-25-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to apply be32_to_cpu to make this work correctly on
little-endian hosts.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_io.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_io.c b/drivers/soc/fsl/qe/qe_io.c
index 99aeb01586bd..61dd8eb8c0fe 100644
--- a/drivers/soc/fsl/qe/qe_io.c
+++ b/drivers/soc/fsl/qe/qe_io.c
@@ -142,7 +142,7 @@ int par_io_of_config(struct device_node *np)
 {
 	struct device_node *pio;
 	int pio_map_len;
-	const unsigned int *pio_map;
+	const __be32 *pio_map;
 
 	if (par_io == NULL) {
 		printk(KERN_ERR "par_io not initialized\n");
@@ -167,9 +167,15 @@ int par_io_of_config(struct device_node *np)
 	}
 
 	while (pio_map_len > 0) {
-		par_io_config_pin((u8) pio_map[0], (u8) pio_map[1],
-				(int) pio_map[2], (int) pio_map[3],
-				(int) pio_map[4], (int) pio_map[5]);
+		u8 port        = be32_to_cpu(pio_map[0]);
+		u8 pin         = be32_to_cpu(pio_map[1]);
+		int dir        = be32_to_cpu(pio_map[2]);
+		int open_drain = be32_to_cpu(pio_map[3]);
+		int assignment = be32_to_cpu(pio_map[4]);
+		int has_irq    = be32_to_cpu(pio_map[5]);
+
+		par_io_config_pin(port, pin, dir, open_drain,
+				  assignment, has_irq);
 		pio_map += 6;
 		pio_map_len -= 6;
 	}
-- 
2.23.0

