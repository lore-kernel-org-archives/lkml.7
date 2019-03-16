Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56665C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ECF3218D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwzhwtuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfCPR60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 13:58:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33457 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfCPR6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 13:58:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id i7so5383621pgq.0;
        Sat, 16 Mar 2019 10:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pSVREjPCAv5T2ZXAYt7SDw0JOGFlD724donHrtDZGs4=;
        b=gwzhwtuYHAukJnuCVE538uazrdK6lMvAnBOSu2ZJL8T/RzBz73VGy9TYw3ELDMkriz
         H0EdPTa4z4G9HOheuqpLS9KnS2TIpPVE1kkiRHGj3R72fZtBoeEH+JIRVpXAxlP13Uzy
         zngGXAzT5DCbVbalF12VD3qtnkCYBIrxtUbAh458w5jkQd4xqtzOhGgENrUCdZUKesTb
         G8tF8PHci7Ec+yjdVYVJ0KkvYJlWssDi4h31/R/1pyLF+2KZ5p4KZAvFJ+IaAz6bvP8J
         WAImBgK1fhFSRakIcxykVU5d2K2W2aZ9HdASO6Wso+25ayUerc9YcNu4dh6eyVTyMKjl
         TsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSVREjPCAv5T2ZXAYt7SDw0JOGFlD724donHrtDZGs4=;
        b=tN24490vxtu3VYUAGyk/D9mDC6UBfostIoL+cmuA+HhHylW7MxJlbaIFs+iGwduTAa
         QHcoDojbXu9S/tNQ+wP/OtJkFtFPw1LNRD4b9i2U26vcBG33x4g2lx3y7h4EvSPsnJ+G
         KX9QeG65XT7htPU3/cDZe5x/Krc8KIeSvLhuQ081Y/BMUczp1P8GBJy3IcnvLtEZPA08
         SrmcxYQFGU99qLVJVbQIJYpmK30qfKSqCvZTj14DjTxS9i2US2SnP+evV1MAmZ2b4giy
         U2J1LVA4u/D6PfGNDcnfLRevKutym7r4/7Qwvn7Y+xy6Y4n72c98reWB3pPYVABiswe6
         2YjA==
X-Gm-Message-State: APjAAAVJyHnIvgouFz6A9eBC0OumoWZi3mmhDFEXUt/mn1Hfea8B1DC9
        a79kjVy2RPhwz7/VJHWebWCaneKOtE4=
X-Google-Smtp-Source: APXvYqwyoU76a5n+PfJG348JHEdw7Xmgs5gVM7mVfGcMTT6wwac3J9QT/VZQ++KrtxMLrB5dPc2sZw==
X-Received: by 2002:a17:902:10d:: with SMTP id 13mr3058421plb.230.1552759102246;
        Sat, 16 Mar 2019 10:58:22 -0700 (PDT)
Received: from castle.hsd1.ca.comcast.net ([2603:3024:1704:3e00::d657])
        by smtp.gmail.com with ESMTPSA id p86sm11025638pfa.104.2019.03.16.10.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Mar 2019 10:58:20 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     Roman Gushchin <guro@fb.com>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 3/9] cgroup: protect cgroup->nr_(dying_)descendants by css_set_lock
Date:   Sat, 16 Mar 2019 10:58:06 -0700
Message-Id: <20190316175812.6787-4-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190316175812.6787-1-guro@fb.com>
References: <20190316175812.6787-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of descendant cgroups and the number of dying
descendant cgroups are currently synchronized using the cgroup_mutex.

The number of descendant cgroups will be required by the cgroup v2
freezer, which will use it to determine if a cgroup is frozen
(depending on total number of descendants and number of frozen
descendants). It's not always acceptable to grab the cgroup_mutex,
especially from quite hot paths (e.g. exit()).

To avoid this, let's additionally synchronize these counters using
the css_set_lock.

So, it's safe to read these counters with either cgroup_mutex or
css_set_lock locked, and for changing both locks should be acquired.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernel-team@fb.com
---
 include/linux/cgroup-defs.h | 5 +++++
 kernel/cgroup/cgroup.c      | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 120d1d40704b..319c07305500 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -348,6 +348,11 @@ struct cgroup {
 	 * Dying cgroups are cgroups which were deleted by a user,
 	 * but are still existing because someone else is holding a reference.
 	 * max_descendants is a maximum allowed number of descent cgroups.
+	 *
+	 * nr_descendants and nr_dying_descendants are protected
+	 * by cgroup_mutex and css_set_lock. It's fine to read them holding
+	 * any of cgroup_mutex and css_set_lock; for writing both locks
+	 * should be held.
 	 */
 	int nr_descendants;
 	int nr_dying_descendants;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b230afccf635..7438c24297d4 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4758,9 +4758,11 @@ static void css_release_work_fn(struct work_struct *work)
 		if (cgroup_on_dfl(cgrp))
 			cgroup_rstat_flush(cgrp);
 
+		spin_lock_irq(&css_set_lock);
 		for (tcgrp = cgroup_parent(cgrp); tcgrp;
 		     tcgrp = cgroup_parent(tcgrp))
 			tcgrp->nr_dying_descendants--;
+		spin_unlock_irq(&css_set_lock);
 
 		cgroup_idr_remove(&cgrp->root->cgroup_idr, cgrp->id);
 		cgrp->id = -1;
@@ -4978,12 +4980,14 @@ static struct cgroup *cgroup_create(struct cgroup *parent)
 	if (ret)
 		goto out_psi_free;
 
+	spin_lock_irq(&css_set_lock);
 	for (tcgrp = cgrp; tcgrp; tcgrp = cgroup_parent(tcgrp)) {
 		cgrp->ancestor_ids[tcgrp->level] = tcgrp->id;
 
 		if (tcgrp != cgrp)
 			tcgrp->nr_descendants++;
 	}
+	spin_unlock_irq(&css_set_lock);
 
 	if (notify_on_release(parent))
 		set_bit(CGRP_NOTIFY_ON_RELEASE, &cgrp->flags);
@@ -5268,10 +5272,12 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
 	if (parent && cgroup_is_threaded(cgrp))
 		parent->nr_threaded_children--;
 
+	spin_lock_irq(&css_set_lock);
 	for (tcgrp = cgroup_parent(cgrp); tcgrp; tcgrp = cgroup_parent(tcgrp)) {
 		tcgrp->nr_descendants--;
 		tcgrp->nr_dying_descendants++;
 	}
+	spin_unlock_irq(&css_set_lock);
 
 	cgroup1_check_for_release(parent);
 
-- 
2.20.1

