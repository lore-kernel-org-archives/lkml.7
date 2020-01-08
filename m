Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7694C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B908620643
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="bmnwB05Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgAHOJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:09:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40099 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgAHOJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:09:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so2632415wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 06:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dLWf61ldCytmqFysX6YTdUEp/0E/OnAEjjKWPM8tEUg=;
        b=bmnwB05QvcNiJo9t/SIrcs+2Qfucblka2G4YI95Hz7UMTmWjHmMawGhIXEYCStoCp9
         v5urAUOEmq7aJY0WSHHUCVuZalTaysWtOIJqKpljeq43KSv7I4BafxHJK+E+jk/DKgi1
         auvJbhBQHD+E5UVZleDoxtDKJN+/So5eISvLoEO5EZgc0wYQoSywV2OrjPEqznP/QIf3
         pJE3SxXgGwVX63JRd1vkwOSo2HHuBmq5GfAGH4SqFWlJvpgkkowFD9qsd+XwdQW0BYqB
         H8j0lmq8Lj2l5r1tldRaimN34eKGGom7hfYI9SQW4U2abK1IQjZkC/Yz++DDaJNlJP88
         x7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=dLWf61ldCytmqFysX6YTdUEp/0E/OnAEjjKWPM8tEUg=;
        b=qnUyh5im43cDiD2DNAeZrmG05K8tkD97y60NXUj45wLTOuyKSza7ufSBFWsYLRyMe+
         40Nbse11YD9uMhsG3++DhduJkoEq0F7T25MBvrXURk2TzapEKwEqwj1DSAH45kv+XFP7
         wO1o6MeOyLna2xRw4qX9NW+oHzXY+Ws3x2/HrH++dQUtFiI1wkJVuPBY+yG3q8E+7Epd
         p3S9vik2VMK53ta3BCb+zDbFRQaMuj9Dsn9BQVW9YvEpH4n6agdECRTqI9zzD1ykUCob
         CBFIDFwb/N/wO1uOQnm51xxpmXw1fkN5O8EFX+Ukn7gNFN/rjiVDdTl/RkVcJIwqQl3p
         lXIA==
X-Gm-Message-State: APjAAAW+VD+hDpJ+rTQuTNHe1Lhzz6fy/VLV/LLwwiDnD2JM3x//Tzdy
        pIxF6E8NB05CWNG38u92sVNEbx7EcjpYUQ==
X-Google-Smtp-Source: APXvYqzBvMMsLiP7JmzW++yaIA7PLvuVvsWf25HTGNdnsYqu86RYFxz45TTE4dYlhuGeqE9Ract+7A==
X-Received: by 2002:a1c:6588:: with SMTP id z130mr4235502wmb.0.1578492553305;
        Wed, 08 Jan 2020 06:09:13 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id v14sm4302890wrm.28.2020.01.08.06.09.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jan 2020 06:09:12 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>
Subject: [PATCH] microblaze: Align comments with register usage
Date:   Wed,  8 Jan 2020 15:09:11 +0100
Message-Id: <15fd2e90780c08fe1a2989cdbbe69e95f46904a5.1578492549.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial patch.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/kernel/head.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/microblaze/kernel/head.S b/arch/microblaze/kernel/head.S
index 7d2894418691..14b276406153 100644
--- a/arch/microblaze/kernel/head.S
+++ b/arch/microblaze/kernel/head.S
@@ -121,10 +121,10 @@ no_fdt_arg:
 	tophys(r4,r4)			/* convert to phys address */
 	ori	r3, r0, COMMAND_LINE_SIZE - 1 /* number of loops */
 _copy_command_line:
-	/* r2=r5+r6 - r5 contain pointer to command line */
+	/* r2=r5+r11 - r5 contain pointer to command line */
 	lbu	r2, r5, r11
 	beqid	r2, skip		/* Skip if no data */
-	sb	r2, r4, r11		/* addr[r4+r6]= r2 */
+	sb	r2, r4, r11		/* addr[r4+r11]= r2 */
 	addik	r11, r11, 1		/* increment counting */
 	bgtid	r3, _copy_command_line	/* loop for all entries       */
 	addik	r3, r3, -1		/* decrement loop */
@@ -139,8 +139,8 @@ skip:
 	ori	r4, r0, TOPHYS(_bram_load_start)	/* save bram context */
 	ori	r3, r0, (LMB_SIZE - 4)
 _copy_bram:
-	lw	r7, r0, r11		/* r7 = r0 + r6 */
-	sw	r7, r4, r11		/* addr[r4 + r6] = r7 */
+	lw	r7, r0, r11		/* r7 = r0 + r11 */
+	sw	r7, r4, r11		/* addr[r4 + r11] = r7 */
 	addik	r11, r11, 4		/* increment counting */
 	bgtid	r3, _copy_bram		/* loop for all entries */
 	addik	r3, r3, -4		/* descrement loop */
-- 
2.24.0

