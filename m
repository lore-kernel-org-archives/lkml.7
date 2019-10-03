Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46FAC4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A243222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066995;
	bh=pecg14+rqKCe9+MU1znEqt1dgbZQC6DApkD13yS7z0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EhVhToBiKbBcCkwnIFiq4CTU02vmk3wAKONQloAIkfHkt01mtg9MeFim1rOt1fr21
	 ylbMV+WIpOSnn5BOPosubdtlF4/uR7SseM34fp9iEIaj5pNUeCbfxgS3vrcoZpKx5O
	 ssIk2vZSjUh0K//i7Zh9Ow648sr6r1dLDYXvYjMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfJCBnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:43:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfJCBnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:43:13 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78982222CA;
        Thu,  3 Oct 2019 01:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066992;
        bh=pecg14+rqKCe9+MU1znEqt1dgbZQC6DApkD13yS7z0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aR9o0x1NHONIbxPoNOj8+Ux2ZBnn1MPxi/Eaxd2edaSTIw39ipumC3Ndu4BXSFyag
         7fSr1WKYBdYOcypMBAqTPl1y4f/M7W09FmEOoeFeg1kOl/FnKZ/PvU9nzUhm//Smok
         Za9vci8Sk49LJWA2iNQ8Knf/e7tHAtyDSW+QF1uQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH tip/core/rcu 3/9] drivers/gpu: Replace rcu_swap_protected() with rcu_replace()
Date:   Wed,  2 Oct 2019 18:43:04 -0700
Message-Id: <20191003014310.13262-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003014153.GA13156@paulmck-ThinkPad-P72>
References: <20191003014153.GA13156@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit replaces the use of rcu_swap_protected() with the more
intuitively appealing rcu_replace() as a step towards removing
rcu_swap_protected().

Link: https://lore.kernel.org/lkml/CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com/
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: <intel-gfx@lists.freedesktop.org>
Cc: <dri-devel@lists.freedesktop.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index 1cdfe05..c5c22c4 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -1629,7 +1629,7 @@ set_engines(struct i915_gem_context *ctx,
 		i915_gem_context_set_user_engines(ctx);
 	else
 		i915_gem_context_clear_user_engines(ctx);
-	rcu_swap_protected(ctx->engines, set.engines, 1);
+	set.engines = rcu_replace(ctx->engines, set.engines, 1);
 	mutex_unlock(&ctx->engines_mutex);
 
 	call_rcu(&set.engines->rcu, free_engines_rcu);
-- 
2.9.5

