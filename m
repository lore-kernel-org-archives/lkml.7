Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3106C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 13:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B152146F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 13:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pvk6bCRa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfDFNKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 09:10:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38520 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfDFNKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 09:10:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id f36so86909plb.5
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 06:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PBt9ZS1f/XlWZPisju35mqGnn1r/LiMis6JE32KTnoQ=;
        b=Pvk6bCRa6R24Qkb9Vu4MUwMpv2KGp8nT4A865UC/LHe6S06ReZ+M7tNVwhjp2F1/4H
         yapOxZ5XaK1et9MwxZjgQgwnYgWFhLxbOLTZF2BZbIK/qGtqvrbWsYYA3zCCJF0aefBl
         4h/H8xho6KBpeozp+7L8oHSKPZUzW0b3jPkVcpjLXNoI0N+cc7pSdr/1HVRP4woqmHM3
         QCoSe65SC2GG8Umv++MSCZ8vhuLHdUjByACcSkkITNXjoWhOBHT4PNKXwXcqbtcEZ7QN
         9gxKaZEsFgyn2dLQanTT7SDcgLCaOUxS2vOqu8NIm1Lfbf57RRmrD1oU4EIHL3K4S0GO
         WSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PBt9ZS1f/XlWZPisju35mqGnn1r/LiMis6JE32KTnoQ=;
        b=i8EybAbVvb8bHcTBftvy6/BwZ1O/7TK7k2oBi8GTN2ymiBTfoYpj5pIv0C7LLqFJhB
         3iM6Vi5WufJM3VZhRDVdJvxvKJ4cQNwBp+mGXZCF6X/X4Qo29r3bQF9ra/qv2RsNWGhC
         Vgxj7u4NfSiAcMho34U3i/RJfxhrF3u4QrB/b/iLvIbvaD1TA6TW7bZI8SiiSoRJ22ID
         I3czjMLw7FJQG9p03T1yoPCP5az4N+zVorwgz1hCx3MniIbHh+DVDZoTNmEXszbTl401
         DBY5XbGpSR42B3660Psm38eJfIi+rdenprqgMN6VsU5S97VQuegSKumWOSpUHeb22z4Q
         9deg==
X-Gm-Message-State: APjAAAUoliNJipR6CAkvIxSR9ubs3533ZsgPv4lnA+n6UI1XQ1cVnUu0
        2K+pY6mxeWrtJxwcF7kVJCX9IdgD
X-Google-Smtp-Source: APXvYqxtwTEWwSNiDvQKbPPSK8ozxd8mZYjU7ZtiEE9kcvGbm1GTfpR2PavY1ktMSMxV4UNgoJrBOg==
X-Received: by 2002:a17:902:8bc3:: with SMTP id r3mr19431456plo.53.1554556205651;
        Sat, 06 Apr 2019 06:10:05 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([49.207.51.153])
        by smtp.gmail.com with ESMTPSA id g4sm36355372pfo.38.2019.04.06.06.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Apr 2019 06:10:04 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     linux@armlinux.org.uk, akpm@linux-foundation.org,
        rppt@linux.ibm.com, anders.roxell@linaro.org, mhocko@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH v2] arm: mm: Remove duplicate header
Date:   Sat,  6 Apr 2019 18:43:26 +0530
Message-Id: <1554556406-9290-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate header which is included twice.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
---
v2: Added Acked-by tag.

 arch/arm/mm/mmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index f3ce341..a64a3c5 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -23,7 +23,6 @@
 #include <asm/sections.h>
 #include <asm/cachetype.h>
 #include <asm/fixmap.h>
-#include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/smp_plat.h>
 #include <asm/tlb.h>
-- 
1.9.1

