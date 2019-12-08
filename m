Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52508C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 04:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E25C208C4
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 04:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XVEPL/S0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfLHENi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 23:13:38 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44453 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfLHENi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 23:13:38 -0500
Received: by mail-qk1-f193.google.com with SMTP id i18so10083326qkl.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 20:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLA1q1LXgu2LMbd6Iu8v7KNSxuSrHR8ib0TtyGhL5Oo=;
        b=XVEPL/S0Z3tKIXcAt8l+3sajxceiVVibMzqH+de02UhuGWOQ+5/an5c7iFXA29mX/Y
         12luL56/5yy9b31fFGDvfSMc/5/pEf7Av+SOexNHS3eR+nIPYSmgakRexLxMwJY/3Ny4
         E1+OY+SlT+yrBFzyP5cq5vYTLqTN42UZeLljFbYTqWt1kjeXhFQfWdh3IysC9MdZo05l
         tydV04b01BHZGDIpqYXBizsm/T8eISq3GoD9yR9ybdf/mZP+2wUroLqYTWyp5Vz0X0NP
         iNHkSpUOvRsgIYVeUTKEcAaIb5pb/oKinW8H3XiKcoMBitwgPFm+53TAKYRh2u/qgF3Z
         2l3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLA1q1LXgu2LMbd6Iu8v7KNSxuSrHR8ib0TtyGhL5Oo=;
        b=bhdxKKgMFXbQw6Aieb34i3q1SSRn/rNlBA1JKpE66u2VglLWHS9rYrdtsRCnJ5XEUU
         VnkTVHd6Gx7jPVu+NrJfuhH5D9C1ANVd1R8qJGcMAmqlzPIGz0UTcZQR2WvyowMl+ung
         GNT+0lcnZthQI50ODlDH1CWBUS/mfolkL/w5y8EzmRIxi/6K+qQjjWvTTkHl46qEf5eQ
         3a/OJemFfsfyjijSGtc8XLKgD/fkhORYTksoioCLbqJDZEMqzEvGu8y376tK4UTZ+rx1
         NSzGAV0ey6mmNjOGjoIG0aj0VLM+v7ecEJ5/6kqU16LsF0y/6osIKEcjrJALNP6p/lAu
         28zA==
X-Gm-Message-State: APjAAAUF9cbkt4kUR8zIEu3YyQoAE3gZ8I+tl95IToAR73jir6rpQutr
        6/65JuBc769tNZBNBGPVJVSODw==
X-Google-Smtp-Source: APXvYqy78Ej2EpkvMEearTuc/wcVxELtVCXzaXFCqQI9c6ly5ElS2WSEeM+D6M6kg7TpnEplr0SEFg==
X-Received: by 2002:a37:6451:: with SMTP id y78mr2737355qkb.499.1575778417217;
        Sat, 07 Dec 2019 20:13:37 -0800 (PST)
Received: from ovpn-120-157.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s44sm8294919qts.22.2019.12.07.20.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 20:13:36 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     reinette.chatre@intel.com, fenghua.yu@intel.com, hpa@zytor.com,
        john.stultz@linaro.org, sboyd@kernel.org, tony.luck@intel.com,
        tj@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] x86/resctrl: fix an imbalance in domain_remove_cpu
Date:   Sat,  7 Dec 2019 23:13:18 -0500
Message-Id: <20191208041318.3702-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

domain_add_cpu() calls domain_setup_mon_state() only when r->mon_capable
is true where it will initialize d->mbm_over. However,
domain_remove_cpu() calls cancel_delayed_work(&d->mbm_over) without
checking r->mon_capable. Hence, it triggers a debugobjects warning when
offlining CPUs because those timer debugobjects are never initialized.

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

