Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077C5C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 04:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C747D21852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 04:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irbfu9qA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbfGEEQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 00:16:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36645 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfGEEQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 00:16:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so3970836plt.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 21:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DIVzl05bCmHqAQSTOF3kZ/Ym5AufpX9dq9JbDFqM6xA=;
        b=irbfu9qArbablvA6nbNLTjhMKotjU5R09Zqx9DqYYzjYZz6fd5+MPt/5WZbfkukptH
         ModvZovWGiIEr+b3EIj5ZiICW7ImUrh3nRwJTahq1LWKcCom1ky/dNd/YJtqmVepFxZ8
         7AsjoiTxjhRx2Aj53GHp3t5fLh2hoojsAcpKPqb0LR381CH/haWPEyvmmHBz2cAivW99
         WVXDORQ9Wr97G+nOp9RqBFcimlQK4ne9s+s2+ZgyW2brfU8QICXkVIuoj+gkRZdHXC3l
         ZmGrtQLaXCzMowk6ehabqxUsVefUs7+VLbWuol4DwWq9rU1zsWApq87yWvwdSTmkzzeM
         C6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DIVzl05bCmHqAQSTOF3kZ/Ym5AufpX9dq9JbDFqM6xA=;
        b=IQIctZBsMjgqPoiU7jHN7/8ac3zJlDAe/wVGvfQj0F/woTjsbh/v89Lw0aOlM4YHcw
         LxpYFN5oVoLZ4X/2im6s00IFwbEK1rKvqO8gmEK3vx7AilMl+wNk753EFVZIdczqYXUm
         4YHexrS0uc3ADG//2xcNUcqFau9KsZ7hfwFQklwxyr1Ruy0MVFTtupFB+9Jzi0yzv04t
         npU1qAgXaoUiX8CChOhtF/vK9isg3nQRHMAzXu9SMHDUvFBP43OmyTXc8PVmprHDL/wt
         oHqqCzqrEGa+6VKbRvr4tmcrQdT1d1Ebp2aLC+FvCdNk/2sadgNXogsnqDQhuJZsQl/j
         Yvjw==
X-Gm-Message-State: APjAAAXiSU2uSb7Vwyns9ba85AbOv5ak5TbtTA+yzmIiM0ucLGnrZgsW
        IZHSr7CoCt7tTaQm4TBUpA==
X-Google-Smtp-Source: APXvYqzI9ZcBsR33Wj69OYxhz8Fl3uU52XOagYXuFn3y1+rHU7l+0to8zenOnZia6VzGeJ1Wmt9bLQ==
X-Received: by 2002:a17:902:f204:: with SMTP id gn4mr2206522plb.3.1562300188420;
        Thu, 04 Jul 2019 21:16:28 -0700 (PDT)
Received: from mylaptop.redhat.com ([2408:8207:7821:9e80:eaf2:5f81:4c66:c3d0])
        by smtp.gmail.com with ESMTPSA id l68sm16328638pjb.8.2019.07.04.21.16.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 21:16:27 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Qian Cai <cai@lca.pw>,
        Barret Rhoden <brho@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/numa: carve node online semantics out of alloc_node_data()
Date:   Fri,  5 Jul 2019 12:15:42 +0800
Message-Id: <1562300143-11671-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Node online means either memory online or cpu online. But there is
requirement to instance a pglist_data, which has neither cpu nor memory
online (refer to [2/2]).

So carve out the online semantics, and call node_set_online() where either
memory or cpu is online.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Qian Cai <cai@lca.pw>
Cc: Barret Rhoden <brho@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/mm/numa.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index e6dad60..b48d507 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -213,8 +213,6 @@ static void __init alloc_node_data(int nid)
 
 	node_data[nid] = nd;
 	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
-
-	node_set_online(nid);
 }
 
 /**
@@ -589,6 +587,7 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 			continue;
 
 		alloc_node_data(nid);
+		node_set_online(nid);
 	}
 
 	/* Dump memblock with node info and return. */
@@ -760,8 +759,10 @@ void __init init_cpu_to_node(void)
 		if (node == NUMA_NO_NODE)
 			continue;
 
-		if (!node_online(node))
+		if (!node_online(node)) {
 			init_memory_less_node(node);
+			node_set_online(nid);
+		}
 
 		numa_set_node(cpu, node);
 	}
-- 
2.7.5

