Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ED4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25A4218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="d50PWp/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732899AbfB1WCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:02:11 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34133 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731853AbfB1WCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:02:10 -0500
Received: by mail-qt1-f195.google.com with SMTP id w4so25530319qtc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 14:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=K0L9Lnk/1b0Etjht+VEBhvZ9+sZp2XGJ/B83LyP5FYc=;
        b=d50PWp/44CHLQxtGcrWaHFtTMvJg7xV42ZeHEMx9r94NFRlyuWafAs1v2D4l2vpWwI
         TjiR4A2yAqzhgVHnQm9WzMYS/4ZT4cyXZpslyEER/X+92BRJlwXM7HAZrc7L1UvC/imB
         OJCkPHK4BJkdqnt/+IZ9qpxQsOpm0BoFesrovU/zV+lEoMXuQTm4mK71K1YK+LY6nUG/
         /UVP0UA9O3BQ/4hbv3OlFhZMgwMH+g4Pd33IWAoJHQAW8pKKplXgT8eJ6L+q2JCxPcqY
         nBS93pg4pPuR6XSSaqrtG3JzGnMQ6rWJkG4CwRKkoeXulAEZfM4Ve896DaJC+quvJQ8N
         6uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K0L9Lnk/1b0Etjht+VEBhvZ9+sZp2XGJ/B83LyP5FYc=;
        b=h6KgTdv1Oye/H5LH2JCOsFW604hqINZqeV6amKOTKt97IVTvJLtN0eWLum83py36OE
         GW/RAqfp/DiY4gt1zShwSoJhQ7THer9KeEuurY1IlI5tcaP5ZmB/pLAQIg82GblraFQB
         iwUzimVOqGPx5b/Q04xqEHyggNxU456DOqqwp2qhJDbHcoxrJc4I8j9Mt5j2OceTHn45
         dP0UnvOXiAjnsllsEBn1xPmjhgWi0EwGtQRiHDbd8jRAueM2vYvt9H/h5LnoGdxcxH4d
         LNK4m0qWzz8hTK7LxwZR8Ith+JjbFcOfTXyR7eGU3/EkW50Jq6X51oxXHztbUNxQs1ai
         ma2g==
X-Gm-Message-State: APjAAAVbY/2rzdRCw2E3NlhlWkefyU7S3ZQ0z/OTUCYrMoQOQew5bBpy
        dPkcJXjqHw/XgG6IoPJ8fc2xbw==
X-Google-Smtp-Source: APXvYqzhehwPG+M6P+c2cmsZ/IfX3NbL+zxdwWXxDGu8zqiYRKxsrCXtya+RTJUZkV5BzRt3XxEO7Q==
X-Received: by 2002:aed:3b1d:: with SMTP id p29mr1320383qte.341.1551391329705;
        Thu, 28 Feb 2019 14:02:09 -0800 (PST)
Received: from ovpn-120-151.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u1sm14113235qki.36.2019.02.28.14.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 14:02:09 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] x86/mm: fix "cpu" set but not used
Date:   Thu, 28 Feb 2019 17:01:55 -0500
Message-Id: <20190228220155.88124-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit a2055abe9c67 ("x86/mm: Pass flush_tlb_info to
flush_tlb_others() etc") removed the unnecessary cpu parameter from
uv_flush_tlb_others() but left an unused variable.

arch/x86/mm/tlb.c: In function 'native_flush_tlb_others':
arch/x86/mm/tlb.c:688:16: warning: variable 'cpu' set but not used
[-Wunused-but-set-variable]
   unsigned int cpu;
                ^~~

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/mm/tlb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 999d6d8f0bef..bc4bc7b2f075 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -685,9 +685,6 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 		 * that UV should be updated so that smp_call_function_many(),
 		 * etc, are optimal on UV.
 		 */
-		unsigned int cpu;
-
-		cpu = smp_processor_id();
 		cpumask = uv_flush_tlb_others(cpumask, info);
 		if (cpumask)
 			smp_call_function_many(cpumask, flush_tlb_func_remote,
-- 
2.17.2 (Apple Git-113)

