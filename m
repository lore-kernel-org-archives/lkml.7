Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA48C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F03C2073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482478;
	bh=Pc3z72cadpFbt5c4gMi0YI0LDj/rV/cHjNRMOFb2z0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MZzeecYCTTws5OP1eHsZiv1ompBAG7zdHP00FLQI840AQKbiiRi5X6J3susRweJSZ
	 7RSKNbXRiJECe1RG/a0m5tBvhB2yU6tZ2ZOpliCqvM7s9m+g5aRSriwNHNNErdXysp
	 XJwBiyosBjNZeqechsMuJp7VshL7lcWrk4h2Kg2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfLDSBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:01:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:41290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbfLDSBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:01:15 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 021A420675;
        Wed,  4 Dec 2019 18:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482474;
        bh=Pc3z72cadpFbt5c4gMi0YI0LDj/rV/cHjNRMOFb2z0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M+UbGMh5QJ1NiXMl0Au2guy5Frvx91eHuexuQPjkzBbE0D/dccfyMwR+8vi+5BMIv
         TsyC6Sw5uTUsrx/v6HiIVSO83U/ichcRnHCXpESkzIdY3YxWk9YuLVOzKKO2NnO6h3
         ZAl8rGWsp3UuG9YENV6g148SYq+Z872qQb60YH9U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiaochen Shen <xiaochen.shen@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        pei.p.jia@intel.com, Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 011/209] x86/resctrl: Prevent NULL pointer dereference when reading mondata
Date:   Wed,  4 Dec 2019 18:53:43 +0100
Message-Id: <20191204175322.347943594@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaochen Shen <xiaochen.shen@intel.com>

[ Upstream commit 26467b0f8407cbd628fa5b7bcfd156e772004155 ]

When a mon group is being deleted, rdtgrp->flags is set to RDT_DELETED
in rdtgroup_rmdir_mon() firstly. The structure of rdtgrp will be freed
until rdtgrp->waitcount is dropped to 0 in rdtgroup_kn_unlock() later.

During the window of deleting a mon group, if an application calls
rdtgroup_mondata_show() to read mondata under this mon group,
'rdtgrp' returned from rdtgroup_kn_lock_live() is a NULL pointer when
rdtgrp->flags is RDT_DELETED. And then 'rdtgrp' is passed in this path:
rdtgroup_mondata_show() --> mon_event_read() --> mon_event_count().
Thus it results in NULL pointer dereference in mon_event_count().

Check 'rdtgrp' in rdtgroup_mondata_show(), and return -ENOENT
immediately when reading mondata during the window of deleting a mon
group.

Fixes: d89b7379015f ("x86/intel_rdt/cqm: Add mon_data")
Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: pei.p.jia@intel.com
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1572326702-27577-1-git-send-email-xiaochen.shen@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index f6ea94f8954a7..f892cb0b485e1 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -313,6 +313,10 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	int ret = 0;
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		ret = -ENOENT;
+		goto out;
+	}
 
 	md.priv = of->kn->priv;
 	resid = md.u.rid;
-- 
2.20.1



