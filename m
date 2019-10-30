Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AF8CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 04:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C00C20874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 04:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="l9HkwaEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfJ3E5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 00:57:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37925 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfJ3E5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 00:57:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id c13so674464pfp.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 21:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=ArmnP9i5XUZSJnnbGyOZyJsBaDqLnDSozm6eXsqgimA=;
        b=l9HkwaEvXz8u8EmhPFl5YLtBxINCKCME7sVU3t6ruBwHN9gCnFu/rm9sqg5kGWmtVR
         EnLYO2NMK3l+u1D676TGbmt0iM5uevSyjFltxuuAxxgs49nwQaUsTkAsRwVyyhj/uHLf
         NQEnuxKvDe+rtYdn3IsLMALYh0VaZImAgRyopX6Kc1SuTa9KefVppUhyiOKvqL1jBYch
         CkWYVUL4una2QyKzXE2jSP/kaqSGBWw3Z60qwH6eJm+PLfA3dqJtMFxqBtbKCgwkmxac
         J71seIedxe46uJfGWu7wi0iArRZi6Hozsi86rwkiEP259JPou7rSwAuEQL/gK6zPT3eb
         MEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=ArmnP9i5XUZSJnnbGyOZyJsBaDqLnDSozm6eXsqgimA=;
        b=iaL+y9iqge+GsHDi6lX2jQzhahnwC/Nh5+36fR9afgQEvhmPVsRd3QLDzHoD3sb7nz
         ldUkcrgKbg2bmgK3pi1otjwX7BI0MnIBxsERaePYB4ELobUpxIadqYz4Ad/sT3ielJwT
         WcTCbOajwJ7GClU1OrPm2tXzQuP8lPgXe5CJRKny+Pdm+XWDS+MU3qjrl7caE44ZSlMU
         oyvlgtg5ni3SIj1SO35EWkVnJ6NsG1Ktn+jvblsyv36QC2JuIHm4RfLw+Ug450/7nkWk
         RhO7+usPkMn7DmPSGypbATbVQ4YnLzBr9OZ/qK8OZJ/kmF4QzZaBX1eQRdDbjqzPiJ4s
         oXIg==
X-Gm-Message-State: APjAAAUjSH9Zem5D1ITl4aF32G/8fImRvtxVbBd3GcYWJLBRQT57Op7h
        e8K+AyhDq4kGWKoXw7CcKrsOWvEN7So=
X-Google-Smtp-Source: APXvYqzXo64sWdqbeOvgGSzZtJ1cBl27GXfDUBb5pBCfDsvjADWjIOOirknn7oBzixnz697YIrqRtQ==
X-Received: by 2002:a17:90a:6508:: with SMTP id i8mr11601510pjj.44.1572411440500;
        Tue, 29 Oct 2019 21:57:20 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id c26sm759148pfo.173.2019.10.29.21.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 21:57:19 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: Change to my personal email address
Date:   Tue, 29 Oct 2019 21:39:16 -0700
Message-Id: <20191030043916.27916-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

I'm leaving SiFive in a bit less than two weeks, which means I'll be
losing my @sifive email address.  I don't have my new email address yet,
so I'm switching over to my personal address instead.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c6c34d04ce95..f97f35163033 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13906,7 +13906,7 @@ F:	drivers/mtd/nand/raw/r852.h
 
 RISC-V ARCHITECTURE
 M:	Paul Walmsley <paul.walmsley@sifive.com>
-M:	Palmer Dabbelt <palmer@sifive.com>
+M:	Palmer Dabbelt <palmer@dabbelt.com>
 M:	Albert Ou <aou@eecs.berkeley.edu>
 L:	linux-riscv@lists.infradead.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
@@ -14783,7 +14783,7 @@ F:	drivers/media/usb/siano/
 F:	drivers/media/mmc/siano/
 
 SIFIVE DRIVERS
-M:	Palmer Dabbelt <palmer@sifive.com>
+M:	Palmer Dabbelt <palmer@dabbelt.com>
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 L:	linux-riscv@lists.infradead.org
 T:	git git://github.com/sifive/riscv-linux.git
@@ -14793,7 +14793,7 @@ N:	sifive
 
 SIFIVE FU540 SYSTEM-ON-CHIP
 M:	Paul Walmsley <paul.walmsley@sifive.com>
-M:	Palmer Dabbelt <palmer@sifive.com>
+M:	Palmer Dabbelt <palmer@dabbelt.com>
 L:	linux-riscv@lists.infradead.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pjw/sifive.git
 S:	Supported
-- 
2.21.0

