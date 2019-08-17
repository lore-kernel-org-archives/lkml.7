Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A20C3A59D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 03:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4CB21721
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 03:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6fxR2O8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfHQDAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 23:00:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43328 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfHQDAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 23:00:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3so3819661pgb.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 20:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=ZNmqO+5oQExi9j6sURYtncJ3cIGe7QR8qkct94PKzGM=;
        b=I6fxR2O84IX+kAUdE0YjnjTo2SkzcFS7bu/CNXFrVBKS7Y0zkNc+GrGJ0B+SAb+fxX
         F184Vt0MgipU/QCEs6xmJfDtN4ptYVLz8S8qhvPxt/wEmjRIguFGV1gEFlZqITQfkBfx
         jq0jsnAz9/j4IJGZUs6aTsCQmFsjc4ADtF4pX41rr3GJ/k7ZunXmybseIDiozPH9QOSB
         khof9WZds2JrVOx7joe6OrNIJh1VjQXu6cpNfWuEYBHuxHuBbpwuv6VihhfyTPHRk5BZ
         FIDJlO/wUSGbISA6qoFf31Gy8XpyUYsrg+KzetFNXh9NJJUqd0Z2AO8aOdgRkQMrRzH9
         1Q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=ZNmqO+5oQExi9j6sURYtncJ3cIGe7QR8qkct94PKzGM=;
        b=B+rUXOo0tYOsrS0Jp7mAbPdrZnWgl1YSR6VIQ2V66GxEmCl0p2OVQI+wFsSxTs3uNc
         s/E4MKidsLAmTCXgDga3NtKgpJBwJx8ulzlXXFNUvvIAWItJaqrg/dYlxHA1lyvL+odS
         HJ/kR/l4NfajuoXigxm8sGzic89LVUyZ3pYvXBb84BLAsKAmAeIOUJXL8lfc6MSX8uV6
         JoGRsI4X3sfBAEyRamd/WIGnnPhd3cNBc3t8rXsR8RjRTxX4rfGw2qCXlokHPBN11CUv
         vJUCELal3gzOo+iWaVtBM8FLP0sHax+tAWuhXdnS6lVZkxm6Cgivvq+Aj+KhlsfF20Q2
         xCfA==
X-Gm-Message-State: APjAAAWbjInME4zp7PVN4VjGyawtOo81oaHaVtyGXvsHEWrGU3QEbEss
        XQ1VqaApwPdzPXUjndJK53A=
X-Google-Smtp-Source: APXvYqw9mXgAJbJGWPUv7KLnt54TBolvSb735/2o2qTm6FCNXPGL4MBESs1wcsP82axZw/+PE4Q0kQ==
X-Received: by 2002:a17:90a:f484:: with SMTP id bx4mr10109470pjb.61.1566010820431;
        Fri, 16 Aug 2019 20:00:20 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id n128sm7241440pfn.46.2019.08.16.20.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Aug 2019 20:00:19 -0700 (PDT)
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
Subject: [PATCH] arch : arm : add a criteria for pfn_valid
Date:   Sat, 17 Aug 2019 11:00:13 +0800
Message-Id: <1566010813-27219-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

pfn_valid can be wrong while the MSB of physical address be trimed as pfn
larger than the max_pfn.

Signed-off-by: Zhaoyang Huang <huangzhaoyang@gmail.com>
---
 arch/arm/mm/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index c2daabb..9c4d938 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -177,7 +177,8 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 int pfn_valid(unsigned long pfn)
 {
-	return memblock_is_map_memory(__pfn_to_phys(pfn));
+	return (pfn > max_pfn) ?
+		false : memblock_is_map_memory(__pfn_to_phys(pfn));
 }
 EXPORT_SYMBOL(pfn_valid);
 #endif
-- 
1.9.1

