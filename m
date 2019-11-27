Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C46C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB5B206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890239;
	bh=WdjUGu7X/CWFXaVOckev9LeqnWq4q9ChzD+8yMwavRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ma4DNSrVmGOZ3GOfq8VfAhKKew+xaz3ht2acixnmTX7hsyhBLDnL11b02tTIbesLW
	 TBjY6ACcspOeNvVFS7c/PSMn4/i3IBVX0GRbg36Q9rk/+6eJlImk7e+1cWVYJBEtvh
	 LUtRLFO7B3m8pfZjtNGI6zMcR7oy4zYJLgfol1ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbfK0Vah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:30:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:46140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730356AbfK0Uzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:55:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43A5520862;
        Wed, 27 Nov 2019 20:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888136;
        bh=WdjUGu7X/CWFXaVOckev9LeqnWq4q9ChzD+8yMwavRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oOlWx8t4NQ8BsjF/6BbaNZbzGR8ihnn90wGkAL8a9sQmb74RSzaLpXr2o8eoXVeQf
         HuSqcrXz/YQIzLqLeAPBTtzyt9NlXVZefmGxNAXzPeq0TXaLLoPjPq0XWaxyqpjrFK
         JxJODFywskCyuIRwX6YJo0zkBNZAAwqsQdQSRh4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4.19 019/306] drm/i915/pmu: "Frequency" is reported as accumulated cycles
Date:   Wed, 27 Nov 2019 21:27:49 +0100
Message-Id: <20191127203116.103201032@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wilson <chris@chris-wilson.co.uk>

commit add3eeed3683e2636ef524db48e1a678757c8e96 upstream.

We report "frequencies" (actual-frequency, requested-frequency) as the
number of accumulated cycles so that the average frequency over that
period may be determined by the user. This means the units we report to
the user are Mcycles (or just M), not MHz.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20191109105356.5273-1-chris@chris-wilson.co.uk
(cherry picked from commit e88866ef02851c88fe95a4bb97820b94b4d46f36)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
(cherry picked from commit a7d87b70d6da96c6772e50728c8b4e78e4cbfd55)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_pmu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -827,8 +827,8 @@ create_event_attributes(struct drm_i915_
 		const char *name;
 		const char *unit;
 	} events[] = {
-		__event(I915_PMU_ACTUAL_FREQUENCY, "actual-frequency", "MHz"),
-		__event(I915_PMU_REQUESTED_FREQUENCY, "requested-frequency", "MHz"),
+		__event(I915_PMU_ACTUAL_FREQUENCY, "actual-frequency", "M"),
+		__event(I915_PMU_REQUESTED_FREQUENCY, "requested-frequency", "M"),
 		__event(I915_PMU_INTERRUPTS, "interrupts", NULL),
 		__event(I915_PMU_RC6_RESIDENCY, "rc6-residency", "ns"),
 	};


