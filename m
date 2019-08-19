Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EC1C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1436020851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJC7NEqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfHSFuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 01:50:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41580 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfHSFuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 01:50:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id m9so421789pls.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 22:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ZGbhnh/rQl26tl12zgYbAbZJa4C3RLtP+c9zSecEuwg=;
        b=OJC7NEqqIFckSHtMwvJvzoMvzR1HzZv8asknNEhBekF5AyaeMVFhfTN5aVT28rzsLS
         SfWI0BffYJI3D/kMC1pBkGlwWlRfL8chg19bQSe2fdIRvcnuL8oblwa+ItTYZSksVt/y
         5yWTqRQu/fTmS3+G53PKfp+iG1Fc4EwjTbufaHqn84uroAGS/9sJl2HRSywYrrsZr+E9
         lx1bQP2osZzYqlFocT9ZjaHQbYJkDywqhJAGGi8ErKQXIVuBBhX6MSoMXLkwvpS9LX6P
         Fe3MKHRz7aTiAlntaJTZ7hRiNaSZhM7ro++swZFdzpAhXe5vgHTa+/XsXGmIrvV3SP2I
         SSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ZGbhnh/rQl26tl12zgYbAbZJa4C3RLtP+c9zSecEuwg=;
        b=dJKGLdF+8XEbUuiMzKotm4pGQooLMHoJCqyBJPBs5fA6R3JRKj3kDWfXIgkXwA/ZuU
         u1nESlc45mu/tyyMBqj8zAaw6pPq3NjKGNRFyjA/09fMShgHpv+sPZRp8WJ60A6nGZtd
         Vkocac0mP4EX1hpP+eekzVBr0b5TY8ErUHZ+9KVcU391Q2+8LB73KnSRiJdF9hah8BFn
         GnFZx2bM8DzbHK7gtCzr8xJtVNGPXoPoFRJfvomlnefWK8K0VrsfNrkpdLpTkwAbAvKr
         i2ISVjLKHfRdmeRwKh/j8/jaXwelHfzNb36mQ2AA0oRHaSY/IjcpbzKtf0pApsVmQZeh
         9s9A==
X-Gm-Message-State: APjAAAW7PItWm12eSPEXSAfcT/8n9l5QnCsh/REjZ2khZiRJHKkHvcMY
        wR5KCQikYGzAufjsRRqlJ/Q=
X-Google-Smtp-Source: APXvYqxSH/FK0cAT9ydQelCiF5nBAb0CLUwft1MT1K73dTBqypzuhAaaaMpUmvakCpx0tNtvy1W0HA==
X-Received: by 2002:a17:902:690b:: with SMTP id j11mr21430996plk.35.1566193819287;
        Sun, 18 Aug 2019 22:50:19 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id v14sm14165972pfm.164.2019.08.18.22.50.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 22:50:18 -0700 (PDT)
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Doug Berger <opendmb@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] arch : arm : add a criteria for pfn_valid
Date:   Mon, 19 Aug 2019 13:50:08 +0800
Message-Id: <1566193808-9153-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1566179120-5910-1-git-send-email-huangzhaoyang@gmail.com>
References: <1566179120-5910-1-git-send-email-huangzhaoyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

pfn_valid can be wrong when parsing a invalid pfn whose phys address
exceeds BITS_PER_LONG as the MSB will be trimed when shifted.

The issue originally arise from bellowing call stack, which corresponding to
an access of the /proc/kpageflags from userspace with a invalid pfn parameter
and leads to kernel panic.

[46886.723249] c7 [<c031ff98>] (stable_page_flags) from [<c03203f8>]
[46886.723264] c7 [<c0320368>] (kpageflags_read) from [<c0312030>]
[46886.723280] c7 [<c0311fb0>] (proc_reg_read) from [<c02a6e6c>]
[46886.723290] c7 [<c02a6e24>] (__vfs_read) from [<c02a7018>]
[46886.723301] c7 [<c02a6f74>] (vfs_read) from [<c02a778c>]
[46886.723315] c7 [<c02a770c>] (SyS_pread64) from [<c0108620>]
(ret_fast_syscall+0x0/0x28)

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
v2: use __pfn_to_phys/__phys_to_pfn instead of max_pfn as the criteria
v3: update commit message to describe the defection's context
---
 arch/arm/mm/init.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index c2daabb..cc769fa 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -177,6 +177,11 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 int pfn_valid(unsigned long pfn)
 {
+	phys_addr_t addr = __pfn_to_phys(pfn);
+
+	if (__phys_to_pfn(addr) != pfn)
+		return 0;
+
 	return memblock_is_map_memory(__pfn_to_phys(pfn));
 }
 EXPORT_SYMBOL(pfn_valid);
-- 
1.9.1

