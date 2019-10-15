Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E12BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0452086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387868AbfJOQXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 12:23:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:36668 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbfJOQXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:23:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DACD6B63F;
        Tue, 15 Oct 2019 16:22:59 +0000 (UTC)
Date:   Tue, 15 Oct 2019 09:21:44 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     robdclark@gmail.com
Cc:     sean@poorly.run, dri-devel@lists.freedesktop.org,
        Davidlohr Bueso <dbueso@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/a5xx: Fix barrier usage in set_preempt_state()
Message-ID: <20191015162144.fuyc25tdwvc6ddu3@linux-p48b>
References: <20191015011438.22184-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191015011438.22184-1-dave@stgolabs.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to Cc lkml.

On Mon, 14 Oct 2019, Davidlohr Bueso wrote:

>Because it is not a Rmw operation, atomic_set() is never serialized,
>and therefore the 'upgradable' smp_mb__{before,after}_atomic() calls
>that order the write to preempt_state are completely bogus.
>
>This patch replaces these with smp_mb(), which seems like the
>original intent of when the code was written.
>
>Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
>---
> drivers/gpu/drm/msm/adreno/a5xx_preempt.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
>index 9cf9353a7ff1..d27d8d3208c6 100644
>--- a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
>+++ b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
>@@ -30,10 +30,10 @@ static inline void set_preempt_state(struct a5xx_gpu *gpu,
> 	 * preemption or in the interrupt handler so barriers are needed
> 	 * before...
> 	 */
>-	smp_mb__before_atomic();
>+	smp_mb();
> 	atomic_set(&gpu->preempt_state, new);
> 	/* ... and after*/
>-	smp_mb__after_atomic();
>+	smp_mb();
> }
>
> /* Write the most recent wptr for the given ring into the hardware */
>-- 
>2.16.4
>
