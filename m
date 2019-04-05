Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4050BC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B382171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J68x9X82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbfDERrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:47:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35505 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731633AbfDERrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:47:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so3421760plp.2;
        Fri, 05 Apr 2019 10:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lZLLa5MWCUzqpcbdhGYUwTVi7fb5Sf8gELlrzCcLpf8=;
        b=J68x9X8233cAedrO+T1UTwAbjYnCXXKepQg4YtENX2bg4PkeJLifgfDthmv7qWl0ol
         Nf+yUiPOUY8cY9kyGlMUpmXISI8hlwvtX7ZzPie6ZPS1EBaQoeyZkKIbFjRbONw3GAK4
         M8P/efLJMrNl+2OxFfiNcT89/9LpUEnMoGi9nCIafg0WYn+117Q3MZOgF1oVXvGo+HQb
         GXFK6cqXeTOIIr1ew2Gz7EDLYeQurHUDXOOddop4nE+rUDjmRqDwTnQr33yJqoQ+jqtn
         UiKVBZ6hKrJIFUdCmDBt9K+505Kg4PTGKlheMgCjoL84wVHnt2d8HULQdc2kiE3NiSQH
         DEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lZLLa5MWCUzqpcbdhGYUwTVi7fb5Sf8gELlrzCcLpf8=;
        b=dMdIf8g9pQgZ95CgT3tgRhsgjRBNn9k417Io5xtO/Rcj8lnH12gy7pq6pWGxQ/TFgz
         oBOLXYcSKznui0tS4WK6MYvLygxG0f0LxaP0ULQNlnu6NszBSd8L9WKW0j8l5MfmSYmx
         WCyb6dxBVCguQaNKygxI7fuX7UxeHXlEk/Ql57hF4QCBLqKiasO/J67YBJdVzG4O4O36
         ceA8jcFS5/HPJYP96BumLGJo1y9f7r297g8O/OsoQ851v5sLAbhGYFUVUvXjoBFmpWB5
         mlaGHjokK5wJc+KdiKaf+1AlCGHs1xp7ESFExnkpDbMCPqCIiYIM/d4U1N5/dgMPo9pi
         mNBQ==
X-Gm-Message-State: APjAAAVBZNBDjju5iH9uhoujxHbJ/x5uIUMaTF4T+vAPbv5Jfi/OEG2C
        fYLigt7p3GhdEEVGhjAlW/w=
X-Google-Smtp-Source: APXvYqw1PHeb2x+LhHs1rM+BO8feGC1jGw5/37ksWOp+FQFRYAPse1e+IHMZlO2lZRDXO4J/AZDvCw==
X-Received: by 2002:a17:902:362:: with SMTP id 89mr14485867pld.172.1554486455005;
        Fri, 05 Apr 2019 10:47:35 -0700 (PDT)
Received: from tower.thefacebook.com ([2620:10d:c090:200::1:ad20])
        by smtp.gmail.com with ESMTPSA id m2sm33169135pgr.74.2019.04.05.10.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 10:47:34 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: [PATCH v10 3/9] cgroup: protect cgroup->nr_(dying_)descendants by css_set_lock
Date:   Fri,  5 Apr 2019 10:47:02 -0700
Message-Id: <20190405174708.1010-4-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405174708.1010-1-guro@fb.com>
References: <20190405174708.1010-1-guro@fb.com>
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
index 1c70803e9f77..7d57890cec67 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -349,6 +349,11 @@ struct cgroup {
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
index 3008ea684aa0..786ceef2f222 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4811,9 +4811,11 @@ static void css_release_work_fn(struct work_struct *work)
 		if (cgroup_on_dfl(cgrp))
 			cgroup_rstat_flush(cgrp);
 
+		spin_lock_irq(&css_set_lock);
 		for (tcgrp = cgroup_parent(cgrp); tcgrp;
 		     tcgrp = cgroup_parent(tcgrp))
 			tcgrp->nr_dying_descendants--;
+		spin_unlock_irq(&css_set_lock);
 
 		cgroup_idr_remove(&cgrp->root->cgroup_idr, cgrp->id);
 		cgrp->id = -1;
@@ -5031,12 +5033,14 @@ static struct cgroup *cgroup_create(struct cgroup *parent)
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
@@ -5321,10 +5325,12 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
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

