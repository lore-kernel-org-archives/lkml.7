Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7DAC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0E82084D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420797;
	bh=pBZM1+qxDgGdEEMveh3ihD78Jrc09jymm0BKj6GZGOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fNnmINU/2gi6a3HupEDorGro+zyTiLBNW+PR4UahWMlfnmU86bgtRhDISlYOol2h7
	 O2SGhxdSQ3Q/GuC2OVklk7s7b8LtjfPrdbo/KchivWSSnVuiOFvL1VmLzH/ThefX//
	 trEegy39YdvDg2yyTE6bythE72WUX1xxouC5q/Oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731881AbfKVLGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:06:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731865AbfKVLGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:06:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ACE420726;
        Fri, 22 Nov 2019 11:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420791;
        bh=pBZM1+qxDgGdEEMveh3ihD78Jrc09jymm0BKj6GZGOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eXrs/HxKcciX9ZhgxqCOmUr8v8FapzcT+bQoKHWGLhIjxGx48J1nYmxYfRfmSmrVg
         un8i6qe02CKdIpP6H+0WQcGPJE+lK66JS3b1Mtauc3UlhJsWgMhj8HXbVR7tB4ew+4
         5ySW0dlj5Z7H4rEnvNITDSqBlHD19iIkGCgi0wKc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, fenghua.yu@intel.com,
        gavin.hindman@intel.com, jithu.joseph@intel.com,
        x86-ml <x86@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 220/220] x86/resctrl: Fix rdt_find_domain() return value and checks
Date:   Fri, 22 Nov 2019 11:29:45 +0100
Message-Id: <20191122100929.421554902@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

[ Upstream commit 52eb74339a6233c69f4e3794b69ea7c98eeeae1b ]

rdt_find_domain() returns an ERR_PTR() that is generated from a provided
domain id when the value is negative.

Care needs to be taken when creating an ERR_PTR() from this value
because a subsequent check using IS_ERR() expects the error to
be within the MAX_ERRNO range. Using an invalid domain id as an
ERR_PTR() does work at this time since this is currently always -1.
Using this undocumented assumption is fragile since future users of
rdt_find_domain() may not be aware of thus assumption.

Two related issues are addressed:

- Ensure that rdt_find_domain() always returns a valid error value by
forcing the error to be -ENODEV when a negative domain id is provided.

- In a few instances the return value of rdt_find_domain() is just
checked for NULL - fix these to include a check of ERR_PTR.

Fixes: d89b7379015f ("x86/intel_rdt/cqm: Add mon_data")
Fixes: 521348b011d6 ("x86/intel_rdt: Introduce utility to obtain CDP peer")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: fenghua.yu@intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/b88cd4ff6a75995bf8db9b0ea546908fe50f69f3.1544479852.git.reinette.chatre@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/intel_rdt.c             | 2 +-
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 2 +-
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index abb71ac704433..cc43c5abd187b 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -421,7 +421,7 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
 	struct list_head *l;
 
 	if (id < 0)
-		return ERR_PTR(id);
+		return ERR_PTR(-ENODEV);
 
 	list_for_each(l, &r->domains) {
 		d = list_entry(l, struct rdt_domain, list);
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 627e5c809b33d..968ace3c6d730 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -459,7 +459,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 
 	r = &rdt_resources_all[resid];
 	d = rdt_find_domain(r, domid, NULL);
-	if (!d) {
+	if (IS_ERR_OR_NULL(d)) {
 		ret = -ENOENT;
 		goto out;
 	}
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 0d8ea82acd930..ad64031e82dcd 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1023,7 +1023,7 @@ static int rdt_cdp_peer_get(struct rdt_resource *r, struct rdt_domain *d,
 	 * peer RDT CDP resource. Hence the WARN.
 	 */
 	_d_cdp = rdt_find_domain(_r_cdp, d->id, NULL);
-	if (WARN_ON(!_d_cdp)) {
+	if (WARN_ON(IS_ERR_OR_NULL(_d_cdp))) {
 		_r_cdp = NULL;
 		ret = -EINVAL;
 	}
-- 
2.20.1



