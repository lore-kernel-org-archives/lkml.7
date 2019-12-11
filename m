Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AB9C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 03:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550B720718
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 03:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="CTaMO3gL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfLKDbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 22:31:02 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40029 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfLKDbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 22:31:01 -0500
Received: by mail-qt1-f194.google.com with SMTP id t17so4977593qtr.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 19:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8p/Q2bxZeO5bi1EVw6Q757/wo4JM84hhuXgjbNxgF2Q=;
        b=CTaMO3gLfuaJ629CA6r7J81pnyc0ggmIBBsrNr4sc8F87lghO/nLJ0eQcHdGAglk+Y
         Sv4PDb2qK+CA/BwoU4fRRGfTs8CGsD673z0q3bOiyqLTaqNVvTavhake+6dSBcC1g8zv
         TMoKoTlAKLuccLOHw8a6xhS08vWUJuoaSTK7gELYbwVuZz9IdB/bTEQzQhWAVB1rfJX7
         kgnlWU/2ySMLxuPSdPHQb/2FF+PghG2bJOo4XP5oWTxlhjGB4YFrDJra2kKZQnR3unDp
         e1q4KgGPlQCMLLWKrB9gjJY8mRvBbTP5tYqft26HiiZI7Kd+ZVHldmNGaBHzW07T60X5
         bmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8p/Q2bxZeO5bi1EVw6Q757/wo4JM84hhuXgjbNxgF2Q=;
        b=WSVEetTIaUBN0CSRMZkydlPG3e/H+fde49FLZmnjMt+yuUg3dqDfjAH+MtXelY8UGZ
         5qAMQksNAtJGgwCICl7NB8TxdOx0YOBkE1JZ0gqCmDK+Gh6nDQkRJOrZ6eys8twWdNqB
         7ss16nOP/pPRgkY4WgqF+Wi/Y3c9dfbPx4u3szN8IvsnSRj5Zl34GQctzo5bJT5MfHoX
         X3iOMJ9kV4UOz52Y83kmVsYuwb/1/hP8MxXlYd73ZsEkPMZHBU0WGcqc3k9r4i/RIXW/
         TnXjVq5OwsgxElgQ+TTlmMJ4aBqxlBVtq2ms8PFxpZI9G3BC2hl2gxT5bYWPZZ0MAZHa
         M/fQ==
X-Gm-Message-State: APjAAAU/n1BEz1P16PSZVADXRpMHKA8lz8EEWbuARvypxa6NpdreWh7s
        UVakcj48F7S+O/megZCjTFBU1A==
X-Google-Smtp-Source: APXvYqwaB3e7PyaASk1GLGUx2wW15cmycxfSXSUL1/OYmLSLmxnc1xD5mSk8m0ng7GKmQWhw4ucHHw==
X-Received: by 2002:aed:3be1:: with SMTP id s30mr1002632qte.163.1576035060751;
        Tue, 10 Dec 2019 19:31:00 -0800 (PST)
Received: from ovpn-123-154.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u16sm249382qku.19.2019.12.10.19.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 19:30:59 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     reinette.chatre@intel.com, fenghua.yu@intel.com, hpa@zytor.com,
        john.stultz@linaro.org, sboyd@kernel.org, tony.luck@intel.com,
        tj@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v2] x86/resctrl: fix an imbalance in domain_remove_cpu
Date:   Tue, 10 Dec 2019 22:30:42 -0500
Message-Id: <20191211033042.2188-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A system that supports resource monitoring may have multiple resources
while not all of these resources are capable of monitoring. Monitoring
related state is initialized only for resources that are capable of
monitoring and correspondingly this state should subsequently only be
removed from these resources that are capable of monitoring.

domain_add_cpu() calls domain_setup_mon_state() only when r->mon_capable
is true where it will initialize d->mbm_over. However,
domain_remove_cpu() calls cancel_delayed_work(&d->mbm_over) without
checking r->mon_capable resulting in an attempt to cancel d->mbm_over on
all resources, even those that never initialized d->mbm_over because
they are not capable of monitoring. Hence, it triggers a debugobjects
warning when offlining CPUs because those timer debugobjects are never
initialized.

ODEBUG: assert_init not available (active state 0) object type:
timer_list hint: 0x0
WARNING: CPU: 143 PID: 789 at lib/debugobjects.c:484
debug_print_object+0xfe/0x140
Hardware name: HP Synergy 680 Gen9/Synergy 680 Gen9 Compute Module, BIOS
I40 05/23/2018
RIP: 0010:debug_print_object+0xfe/0x140
Call Trace:
debug_object_assert_init+0x1f5/0x240
del_timer+0x6f/0xf0
try_to_grab_pending+0x42/0x3c0
cancel_delayed_work+0x7d/0x150
resctrl_offline_cpu+0x3c0/0x520
cpuhp_invoke_callback+0x197/0x1120
cpuhp_thread_fun+0x252/0x2f0
smpboot_thread_fn+0x255/0x440
kthread+0x1e6/0x210
ret_from_fork+0x3a/0x50

Fixes: e33026831bdb ("x86/intel_rdt/mbm: Handle counter overflow")
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: update the commit log thanks to Reinette.

 arch/x86/kernel/cpu/resctrl/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 03eb90d00af0..89049b343c7a 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -618,7 +618,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		if (static_branch_unlikely(&rdt_mon_enable_key))
 			rmdir_mondata_subdir_allrdtgrp(r, d->id);
 		list_del(&d->list);
-		if (is_mbm_enabled())
+		if (r->mon_capable && is_mbm_enabled())
 			cancel_delayed_work(&d->mbm_over);
 		if (is_llc_occupancy_enabled() &&  has_busy_rmid(r, d)) {
 			/*
-- 
2.21.0 (Apple Git-122.2)

