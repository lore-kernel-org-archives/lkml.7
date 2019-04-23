Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EA1C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4248F218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpbLIdu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfDWWt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:49:27 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46644 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDWWt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:49:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id h21so14970055ljk.13;
        Tue, 23 Apr 2019 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7741/2a1/SrR4PpN1R0HoKZL/IBWcdVAEL0l49IfvUY=;
        b=fpbLIdu5Sft9yYIVNXT84yBNZa2bkD54EFhIaCN07y+9Jytm6XEDD+ehA3w3R6JDhf
         Um8W7TcrFRFtFPuplbtNRQIZv8KofmqqF1D7HDltZW6dBLIAsECFGawUxGtS06N6fWEH
         U9Fijh1cbNs+31hS5do4yZ4RnPyecdTOeKqLWoPuv9PCKNyLPpONK93lN4X7RYyEvOQR
         QNqSmjqOkR6Yv3AicISGmIfk4WJfbRiAPt7dO8loLgtT0ZGCi7X09vuYrtbuw1yYSqvB
         QMOj1H4KyR1Klj5k/ZhaOMETYMHk4YxaduJHZsRnNTzvtPcCFxKuFll6DYWOnlYUGQrO
         zaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7741/2a1/SrR4PpN1R0HoKZL/IBWcdVAEL0l49IfvUY=;
        b=kNYd1wRlChtpSbbcqPYjMY0qnZ5+Bg1rTSUNPNWgddtEQ7jIPBfe/RTgVClPJIUo5X
         fs9rnXy+XCFXQcCp62kYXxv059UPTk/qjvpFTMv6t7edjSLcoJUUtmV3wL1Ujhozx11P
         l5+KZYZ1r9TBShUJEIb8r8jvTYWyNFzo2NIiOOa7TvzYoEix7owNSKziCUofHlAyrr5F
         gstv/PB/wslk0NQRGIzl/9Nyu9Dtowaoj206p3H6GskTc+N91QU3K2sOWGtYM0icKbOJ
         sNVT55fuq1iPn+q3exDSH63fPjEZ57Lv5+xU2w16OfNNhey11E1GOMDdaip7t8yK6/Tf
         73aA==
X-Gm-Message-State: APjAAAWHYijZ9LloYTgl8+nK+lRU9bLSNhDmjHQ7Eyz9k4fd9O7Rwc0D
        Uu/k2R3yOsP2zL1ib4bIIj0=
X-Google-Smtp-Source: APXvYqwBZMORXOuppvcbzkF7hkDJD97M3ZKhmzvmLYFzhOqz1gVXQzJN1+V97c8olF86LQ//E41xvw==
X-Received: by 2002:a2e:9b13:: with SMTP id u19mr15286090lji.134.1556059764254;
        Tue, 23 Apr 2019 15:49:24 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id w2sm4904722lfa.63.2019.04.23.15.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:49:23 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Huacai Chen <chenhc@lemote.com>,
        Stefan Agner <stefan@agner.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Juergen Gross <jgross@suse.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 01/12] mips: Make sure kernel .bss exists in boot mem pool
Date:   Wed, 24 Apr 2019 01:47:37 +0300
Message-Id: <20190423224748.3765-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423224748.3765-1-fancer.lancer@gmail.com>
References: <20190423224748.3765-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current MIPS platform code makes sure the kernel text, data and init
sections are added to the boot memory map pool right after the
arch-specific memory setup method has been executed. But for some reason
the MIPS platform code skipped the kernel .bss section, which definitely
should be in the boot mem pool as well in any case. Lets fix this just be
adding the space between __bss_start and __bss_stop.

Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 8d1dc6c71173..0ee033c44116 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -809,6 +809,9 @@ static void __init arch_mem_init(char **cmdline_p)
 	arch_mem_addpart(PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT,
 			 PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT,
 			 BOOT_MEM_INIT_RAM);
+	arch_mem_addpart(PFN_DOWN(__pa_symbol(&__bss_start)) << PAGE_SHIFT,
+			 PFN_UP(__pa_symbol(&__bss_stop)) << PAGE_SHIFT,
+			 BOOT_MEM_RAM);
 
 	pr_info("Determined physical RAM map:\n");
 	print_memory_map();
-- 
2.21.0

