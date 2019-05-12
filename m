Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82795C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 04:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4811C2089E
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 04:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gtj/vqFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfELEfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 00:35:24 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42900 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfELEfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 00:35:23 -0400
Received: by mail-qt1-f196.google.com with SMTP id j53so11187729qta.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 21:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dPdaQ04OQMGwU42dwLeynqlwiEFIdM5ipI+2HR6a1s4=;
        b=gtj/vqFS/ws9nX0lxJcywKgYAZdqHJJb4vL/tZ+2R7I6Exl8SCCT7HaTwvmrB2Yj2H
         SUzH4VhZPlI/HROyYk4qt6HtZSax9kDys+YNj6qhlXo4jBaMZaYiCbjf/5uDONIEBTy7
         Tp9d0mTyCX5Gvb5vM7my+jvPZWPq9O5PD4D1kQmMhPS+CHgfrcJIZnzFZRiN5T0mtKUR
         HnQ3U7MuG0YjkJFU/0tPcfOlZ6kShz+RVP1IB9GRzHKbwDIttPMGGRdwKjcDHKLPwyX7
         aZO0Qw7FW/GyAjk5DLGfxwdJhinfsGKM+GpQyYc1PsRSn1XbOpRc6T1MJG7x0eA5GbfB
         GpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dPdaQ04OQMGwU42dwLeynqlwiEFIdM5ipI+2HR6a1s4=;
        b=fZRPYPLCE7rUCMm/4QUEifUYlIs0rjadXZ3scWwd9loEy/n0p2SaQRftDDu7l3rYrI
         b6/EqSBG84FWOjYgwZ21tjr1CYaIF5ijaIpGc26+CAF1SIRk0QZmb/+WyMuOB232nG4D
         n8eKnAp/C2nghjWIUTu0vpFaiUS3ctTVittkGhzWPOaQd6CFMJ7qrrbqLuKDh1CAvJj/
         jL904kNxpvBfLUhVqNsH865Z1jPdh4VqAwORGcR8YuOXM6J60OoI7WKSwD2utE4wYhJe
         ftWy2SZFdEaMBq4Vlhu2KwSmsZw6GwiA+qPYTYESzSpEuHipRXzPDjkSob2hxoKOahd3
         rKZg==
X-Gm-Message-State: APjAAAWfbtrtbxdZz/Ucokn2zepxq/MOyBEIjrMz46UmM3Ix+PZW8PCG
        zgeONHMwncB2tzlAIkZEaHIagg==
X-Google-Smtp-Source: APXvYqzwDUmg+Md2mff4foee6rHIFv6KDP9kS5NCEcqkWVWSn/2AZSbj0Pa5JyccSK9BiECN+H5XrA==
X-Received: by 2002:ac8:3785:: with SMTP id d5mr18133800qtc.166.1557635722507;
        Sat, 11 May 2019 21:35:22 -0700 (PDT)
Received: from ovpn-121-162.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t63sm4887472qka.33.2019.05.11.21.35.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 21:35:21 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, brho@google.com, kernelfans@gmail.com,
        dave.hansen@intel.com, rppt@linux.ibm.com, peterz@infradead.org,
        mpe@ellerman.id.au, mingo@elte.hu, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/hotplug: fix a null-ptr-deref during NUMA boot
Date:   Sun, 12 May 2019 00:34:42 -0400
Message-Id: <20190512043442.11212-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit ("x86, numa: always initialize all possible
nodes") introduced a crash below during boot for systems with a
memory-less node. This is due to CPUs that get onlined during SMP boot,
but that onlining triggers a page fault in bus_add_device() during
device registration:

	error = sysfs_create_link(&bus->p->devices_kset->kobj,

bus->p is NULL. That "p" is the subsys_private struct, and it should
have been set in,

	postcore_initcall(register_node_type);

but that happens in do_basic_setup() after smp_init().

The old code had set this node online via alloc_node_data(), so when it
came time to do_cpu_up() -> try_online_node(), the node was already up
and nothing happened.

Now, it attempts to online the node, which registers the node with
sysfs, but that can't happen before the 'node' subsystem is registered.

Since kernel_init() is running by a kernel thread that is in
SYSTEM_SCHEDULINGi state, fixed this skipping registering with sysfs
during the early boot in __try_online_node().

Call Trace:
 device_add+0x43e/0x690
 device_register+0x107/0x110
 __register_one_node+0x72/0x150
 __try_online_node+0x8f/0xd0
 try_online_node+0x2b/0x50
 do_cpu_up+0x46/0xf0
 cpu_up+0x13/0x20
 smp_init+0x6e/0xd0
 kernel_init_freeable+0xe5/0x21f
 kernel_init+0xf/0x180
 ret_from_fork+0x1f/0x30

Reported-by: Barret Rhoden <brho@google.com>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b236069ff0d8..5970dd65d698 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1034,7 +1034,7 @@ static int __try_online_node(int nid, u64 start, bool set_node_online)
 	pg_data_t *pgdat;
 	int ret = 1;
 
-	if (node_online(nid))
+	if (node_online(nid) || system_state == SYSTEM_SCHEDULING)
 		return 0;
 
 	pgdat = hotadd_new_pgdat(nid, start);
-- 
2.20.1 (Apple Git-117)

