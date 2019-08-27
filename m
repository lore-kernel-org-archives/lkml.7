Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A1CC3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884812173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYjfYeg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfH0DC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 23:02:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46471 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfH0DC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 23:02:57 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so11021115plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 20:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+678Xv5ru8PcQuczzEyKD2Pw0q4hQ1y6t38q+jHCNZs=;
        b=IYjfYeg2SY10CgAnFjQidvjw8uO4HIpNGr+sWsaHzTVz8BzWkE+tl0xH6Bf6wWnfmY
         hJ3Y020hTO33N2n+CK9nuT/0LV2HZdFq8fb2pU04S8jTsSeXo60elpa9fcnjLxPsSsPC
         uRLPqxUiJw6/bqGhiLMXW722bfYpwCmfWwcH8xiWmlwLEVZR23sXDGLgW2GDWI17LCb5
         ydBHcw/CvX03GwJSlLYvL5dpsoOi4/+h3oKgCLN4rrd9J05jkoIoF0v3Vrdv+pySvv2O
         0SeqN+kaN3LOhIz6gxiTzAZWfvIfkVz+zksM5a7XW2O5S+f9kQ6MxPS+HZ63ohbP3RmF
         fH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+678Xv5ru8PcQuczzEyKD2Pw0q4hQ1y6t38q+jHCNZs=;
        b=giqT02kydcUGATd4tF3nyV+V+pSHpRH69RZNSqZYn1Ky5BjkEAOUJV1XJ1I8tKrFfQ
         0XIFCWTcxfluSZr0JLIm1lW7t8YuIjM4NR3uzKcoOHOEL4Lc0Z4H4AC/bdZIIY0lKymI
         ADIaLp+UPCBbGe4ErpAch8LOXtCLKAPqq30hYMN2tkzQalOFSJmBZueQiO4gOLdoVEDb
         r8YwEhFlyLnerbEAv+7BtcvTvwx1E6Nuj811NwrvTNRrtlh/TTlcsOhMq11mSW7RhQWs
         3hE6/kjjo1rmnmhzT1xfGBJ1e7gD2kHNgwxdTBo3RmeBPyXObxIr8sp6mRqckRgIjuuP
         H2dA==
X-Gm-Message-State: APjAAAU3j4Q7w/M3aR/FRa6+qI+e8MhVaKnVeOmYpUV2/9m3dWVh0x0z
        wJ0UuNWWFbM9GzhAzrT8ag==
X-Google-Smtp-Source: APXvYqxy5aax1zCxTBqsR8zHF1JVOxQUspv/kSUvTRdHfceCX0u+jQsLz1i41dOfUEMbkoqp6qcK2g==
X-Received: by 2002:a17:902:6b88:: with SMTP id p8mr20470650plk.95.1566874976285;
        Mon, 26 Aug 2019 20:02:56 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s24sm11696535pgm.3.2019.08.26.20.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 20:02:55 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Drake <drake@endlessm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org
Subject: [PATCHv2 1/4] x86/apic: correct the ENO in generic_processor_info()
Date:   Tue, 27 Aug 2019 11:02:20 +0800
Message-Id: <1566874943-4449-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1566874943-4449-1-git-send-email-kernelfans@gmail.com>
References: <1566874943-4449-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When capped by nr_cpu_ids, the current code return -EINVAL or -ENODEV. It
is better to return -EINVAL for both cases.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Qian Cai <cai@lca.pw>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Daniel Drake <drake@endlessm.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org
---
 arch/x86/kernel/apic/apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index f529136..f4f603a 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2346,7 +2346,7 @@ int generic_processor_info(int apicid, int version)
 			"  Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
 
 		disabled_cpus++;
-		return -ENODEV;
+		return -EINVAL;
 	}
 
 	if (num_processors >= nr_cpu_ids) {
-- 
2.7.5

