Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3753CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A112087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyvNTRkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfC0Q3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:29:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43731 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfC0Q3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:29:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id c8so9939044pfd.10;
        Wed, 27 Mar 2019 09:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MmtmcE7ooWmaw7qy83iNnf7LHrb2EJ8IjfLcGQJlm04=;
        b=gyvNTRkREYAbX1iH1MMdP9VJS4ZwwgPWPVAavjEnvQDnoT4wbZyR1w8AUaXQKDx2or
         IX93Zjj9BgfnsdP+EeJxaR9LU2TKG10ko62rS2DCYPYT82Ov6k/fhVHvuXQURq91+e1/
         bnLSvoIGjvpXsk7KZu6LasTCVYAGfpf8cyzYfjRIdoJ/c749VLM44oPaLQqp3j4GvY+j
         4J17MuQRuncD4b2EeMEkJk6weUWHiHDVkT/FhXvQOSpYS/SVuHycXA15JwnyKMG+PtJz
         7WsdKmdzEIFFN9/OnFECLi1Bkpjmo/kjnsDaY2hQ6sK6x2Or7lcqyt9wVsOYhLdrW55o
         8tJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MmtmcE7ooWmaw7qy83iNnf7LHrb2EJ8IjfLcGQJlm04=;
        b=WErgoR2BUZ4Vu+u0VgOMTJb3pD3il2Ij2ZyHw+S1Nf6WAy9qWvhpDEaa8TA4HfUv5L
         Ul/XfOlO+ndz75pO7LHejj2AUfKVQD9oXMCMm03yzP9ZNMS7/7/3TOWBMihMgESoHOTD
         xC3u4xxfY6ShA0lvlf9Vt9yDRgvPq1UJ/JHi3oh4UErG2RLUIb307Ga8vL9ykncmlRf5
         po4kw0FWVnnM2bkmy3uOU/8cq552mT181nfl6FFFE/m1Draq5k7GTuC105MHK9CMvXUR
         AEedAXVFf7eU4yLHEQhsVRWnOQk7PGUg+iT+U/j18lH8FwFh+lwG8y+f2K80OyY0ydeg
         30VA==
X-Gm-Message-State: APjAAAWFzevpQGG3spKvF2Iz4PJEJOLrbhGvV3YBu4mOM+cSEBQip/Oa
        KxJmYBTX0xOd+my1xUOhguE=
X-Google-Smtp-Source: APXvYqwxWrC57GQKLcNNGAh3v6Pwa6g4Hv9L94+4SE0jwAODEmBFbfOy8hFFWyLwIIBdytdmBzu9bQ==
X-Received: by 2002:aa7:8841:: with SMTP id k1mr35988974pfo.115.1553704181925;
        Wed, 27 Mar 2019 09:29:41 -0700 (PDT)
Received: from CentOS76.localdomain.localdomain ([27.59.54.136])
        by smtp.gmail.com with ESMTPSA id j71sm47433324pfc.6.2019.03.27.09.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 09:29:40 -0700 (PDT)
From:   jagdsh.linux@gmail.com
To:     davem@davemloft.net, paul.burton@mips.com
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Subject: [PATCH] arch:sparc:kernel/uprobes.c : Remove duplicate header
Date:   Thu, 28 Mar 2019 02:58:45 +0530
Message-Id: <1553722125-38957-1-git-send-email-jagdsh.linux@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Remove duplicate header which is included twice.

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
---
 arch/sparc/kernel/uprobes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/kernel/uprobes.c b/arch/sparc/kernel/uprobes.c
index d852ae5..c44bf5b 100644
--- a/arch/sparc/kernel/uprobes.c
+++ b/arch/sparc/kernel/uprobes.c
@@ -29,7 +29,6 @@
 #include <linux/kdebug.h>
 
 #include <asm/cacheflush.h>
-#include <linux/uaccess.h>
 
 /* Compute the address of the breakpoint instruction and return it.
  *
-- 
1.8.3.1

