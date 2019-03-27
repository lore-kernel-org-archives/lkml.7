Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05098C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB702206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713454;
	bh=pylpkBLNcCZBLgMSDbploWxJ69hWPZeS0H5eeVswZy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xv45+yD7nR+asDHTi7IVHeSfhSVCEG6mN01J668KgNCWJqPlTG9AjCW1lmjM6lDTT
	 8EjAYoLMXNRtF/ANOOGGedtBVcNIb29qi1fNNH8scPbj7GFIfU78NlNa5ZrXWuY0VW
	 vQzZlYNMsYkPAEHnX2NOfkXA+qlY7h+2f0JGgHC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389496AbfC0TEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389116AbfC0SNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:13:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD4F121855;
        Wed, 27 Mar 2019 18:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710389;
        bh=pylpkBLNcCZBLgMSDbploWxJ69hWPZeS0H5eeVswZy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=atcY4NnBqaJaP0SxO43hxrgEkFntdLvPvltrq22Te2DxE3yNfhjI0DpyYl92D39YZ
         DMJ1xOJwKMPnAWe1YEDFO3UOa82izGwCELjb/ynYkYJ4vntr8MxZ64+wkvgvsZBz+e
         mhdcaUOWMiwwHsDx1nEqZxrW9V/xIknNILk5SkEg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>,
        cgroups@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 096/192] cgroup, rstat: Don't flush subtree root unless necessary
Date:   Wed, 27 Mar 2019 14:08:48 -0400
Message-Id: <20190327181025.13507-96-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

[ Upstream commit b4ff1b44bcd384d22fcbac6ebaf9cc0d33debe50 ]

cgroup_rstat_cpu_pop_updated() is used to traverse the updated cgroups
on flush.  While it was only visiting updated ones in the subtree, it
was visiting @root unconditionally.  We can easily check whether @root
is updated or not by looking at its ->updated_next just as with the
cgroups in the subtree.

* Remove the unnecessary cgroup_parent() test.  The system root cgroup
  is never updated and thus its ->updated_next is always NULL.  No
  need to test whether cgroup_parent() exists in addition to
  ->updated_next.

* Terminate traverse if ->updated_next is NULL.  This can only happen
  for subtree @root and there's no reason to visit it if it's not
  marked updated.

This reduces cpu consumption when reading a lot of rstat backed files.
In a micro benchmark reading stat from ~1600 cgroups, the sys time was
lowered by >40%.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/rstat.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index d503d1a9007c..bb95a35e8c2d 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -87,7 +87,6 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 						   struct cgroup *root, int cpu)
 {
 	struct cgroup_rstat_cpu *rstatc;
-	struct cgroup *parent;
 
 	if (pos == root)
 		return NULL;
@@ -115,8 +114,8 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 	 * However, due to the way we traverse, @pos will be the first
 	 * child in most cases. The only exception is @root.
 	 */
-	parent = cgroup_parent(pos);
-	if (parent && rstatc->updated_next) {
+	if (rstatc->updated_next) {
+		struct cgroup *parent = cgroup_parent(pos);
 		struct cgroup_rstat_cpu *prstatc = cgroup_rstat_cpu(parent, cpu);
 		struct cgroup_rstat_cpu *nrstatc;
 		struct cgroup **nextp;
@@ -140,9 +139,12 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 		 * updated stat.
 		 */
 		smp_mb();
+
+		return pos;
 	}
 
-	return pos;
+	/* only happens for @root */
+	return NULL;
 }
 
 /* see cgroup_rstat_flush() */
-- 
2.19.1

