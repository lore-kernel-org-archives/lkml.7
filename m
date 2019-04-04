Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C70C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D67F20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370735;
	bh=aN2qvTfBxzBXAMrTLUcLlfNCWAmU6bJVjF4wJOtL99s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XaajsWKEef3KfyMnYvmrayjO487QzfT1Z3TeskaxrwLci6DPT63APY3QH5KQefqHZ
	 jshSBSkLsYFwUJGNmbEZtOUrgo5WlhTh2lLf3YlJjRjltVNcjltIStUQwZDFLl3hhh
	 WlpOpRAl2K6uenSb6f7t7aElHjuNLvZFCmZ3gpBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbfDDJEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:04:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731871AbfDDJDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:03:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DC5A21855;
        Thu,  4 Apr 2019 09:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368632;
        bh=aN2qvTfBxzBXAMrTLUcLlfNCWAmU6bJVjF4wJOtL99s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jhlf5TcBcmKz1kDu1/qO3AYvlN2CG3DvYPB1H9A7L+FW1tQ6vtc/cQxNzLvF+uRA+
         vDZ4Tc1uCL6CZheBqlA8nrZ6PBk/GeEoTousUseOrNQDqGCqtTxpI8RZ9j6LbLXxbd
         SL4UaNvKgwhP8N7I2nAgIh3otdw96Q2E9Dh8xg7k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 095/187] cgroup, rstat: Dont flush subtree root unless necessary
Date:   Thu,  4 Apr 2019 10:47:12 +0200
Message-Id: <20190404084607.635838141@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



