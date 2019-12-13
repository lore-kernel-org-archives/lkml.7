Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12E6C3498C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CFB24801
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="aDdLn77F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfLMTxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:53:52 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35261 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728900AbfLMTxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 14:53:52 -0500
Received: by mail-qk1-f193.google.com with SMTP id z76so218812qka.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 11:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=UDUGuPy0SzNQtaLWS/B5DyJXF4eqKf2oErS2khMyg4Y=;
        b=aDdLn77F4ZSNiHcIyuN9tH5vtM9rtFMe/mkQfzUVRPPOC5mOfxX/l8Rd4ai7xnb14T
         54qeT6LQLY1m+thu/An8GPv7ds/kfhZwcyG7BkZDXYwWN6AeQiPOJRnXdpT/GdVmwZtA
         PAtDqicdbbejRnxZBr6LL1D4fAr1/EEXNeriU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=UDUGuPy0SzNQtaLWS/B5DyJXF4eqKf2oErS2khMyg4Y=;
        b=U39g1ktP6+GC5D5IOVtnn8iKc691ovItXVj9SDhg3daXvqdQzTmT5TH/qjMio0Eo+k
         xBK+O0mTZbPpeADthwQgRwZ4c9Pz4d1mKEH9aS+goQ2C6JanN1lsSmMkM1GA4e6bdp3b
         Un3GxWsh5rMP5w8yfl6juTmJySUDfK3dyiHGm8mZDT/AbfNjHWau7+qWOLPJrxLwinxT
         SLArmOO8ADUkMtMsS0pcqXBMLAuTm96G/Xlole78FaRxYy0PnsiZ5Nk4YiTMsqzDxkbe
         P6pdEZ6YA3Y1A5dIFJ4XRrLZfs7GlckDL5ZVl9grJSI4ah5CZ95cv9gunv3qCiESDTk0
         3JBg==
X-Gm-Message-State: APjAAAWEUTa4EVQh9rQW/JsD5/dam+DNYgSKq52iBqvx3+KhFGPTlS4p
        94YXZcMr74X2u8gh2L1NfX8G4g==
X-Google-Smtp-Source: APXvYqyfqS0ID8TthkiIcQbMK759FrzJW0tg6ZzVKhlFGN942BaI/winZ1bilTouIW/UnGxRclYZnw==
X-Received: by 2002:a05:620a:1112:: with SMTP id o18mr14883267qkk.126.1576266831174;
        Fri, 13 Dec 2019 11:53:51 -0800 (PST)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id t11sm3065461qkm.92.2019.12.13.11.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 11:53:49 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Fri, 13 Dec 2019 14:53:48 -0500 (EST)
X-X-Sender: vince@macbook-air
To:     Dave Hansen <dave.hansen@intel.com>
cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [perf] perf_fuzzer triggers NULL pointer derefernce in i915
 driver
In-Reply-To: <f2c6502a-f13e-a663-f1f5-c441964d77ac@intel.com>
Message-ID: <alpine.DEB.2.21.1912131452170.19748@macbook-air>
References: <alpine.DEB.2.21.1912121032420.15237@macbook-air> <87tv641z20.fsf@intel.com> <f2c6502a-f13e-a663-f1f5-c441964d77ac@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2019, Dave Hansen wrote:

> On 12/12/19 11:09 PM, Jani Nikula wrote:
> > On Thu, 12 Dec 2019, Vince Weaver <vincent.weaver@maine.edu> wrote:
> >> with current git the perf_fuzzer was able to trigger this NULL pointer
> >> de-reference in the i915 driver.
> > Please file a bug.
> > 
> > https://gitlab.freedesktop.org/drm/intel/wikis/How-to-file-i915-bugs
> 
> I'm seeing the same thing.  It's annoyingly and immediately reproducible
> for me:
> 
> 	https://gitlab.freedesktop.org/drm/intel/issues/826
> 
> Let me know if you want anything fancier done like a bisect.  Looking
> back through my kernel logs, it appears to also have happened with
> 5.4.0-rc4.

This patch was sent out in response to my report (but not as a direct 
reply).


>From chris@chris-wilson.co.uk Thu Dec 12 10:42:36 2019
>Date: Thu, 12 Dec 2019 15:42:24 +0000
>From: Chris Wilson <chris@chris-wilson.co.uk>
>To: intel-gfx@lists.freedesktop.org
>Cc: Chris Wilson <chris@chris-wilson.co.uk>, Vince Weaver <vincent.weaver@maine.edu>, Matthew Auld <matthew.auld@intel.com>
>Subject: [PATCH] drm/i915: Set fence_work.ops before dma_fence_init

Since dma_fence_init may call ops (because of a meaningless
trace_dma_fence), we need to set the worker ops prior to that call.

Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Fixes: 8e458fe2ee05 ("drm/i915: Generalise the clflush dma-worker")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>
---
 drivers/gpu/drm/i915/i915_sw_fence_work.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_sw_fence_work.c b/drivers/gpu/drm/i915/i915_sw_fence_work.c
index 07552cd544f2..8538ee7a521d 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence_work.c
+++ b/drivers/gpu/drm/i915/i915_sw_fence_work.c
@@ -78,12 +78,11 @@ static const struct dma_fence_ops fence_ops = {
 void dma_fence_work_init(struct dma_fence_work *f,
 			 const struct dma_fence_work_ops *ops)
 {
+	f->ops = ops;
 	spin_lock_init(&f->lock);
 	dma_fence_init(&f->dma, &fence_ops, &f->lock, 0, 0);
 	i915_sw_fence_init(&f->chain, fence_notify);
 	INIT_WORK(&f->work, fence_work);
-
-	f->ops = ops;
 }
 
 int dma_fence_work_chain(struct dma_fence_work *f, struct dma_fence *signal)
-- 
2.24.0

