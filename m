Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213EEC49EAA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FCE217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbfKEJCe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:02:34 -0500
Received: from mga09.intel.com ([134.134.136.24]:52152 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727925AbfKEJCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:02:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 01:02:34 -0800
X-IronPort-AV: E=Sophos;i="5.68,270,1569308400"; 
   d="scan'208";a="192038022"
Received: from jlahtine-desk.ger.corp.intel.com (HELO localhost) ([10.252.31.180])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 01:02:31 -0800
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
In-Reply-To: <20191104173720.2696-3-daniel.vetter@ffwll.ch>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Will Deacon <will@kernel.org>
References: <20191104173720.2696-1-daniel.vetter@ffwll.ch>
 <20191104173720.2696-3-daniel.vetter@ffwll.ch>
Message-ID: <157294454858.9970.12268694142857953676@jlahtine-desk.ger.corp.intel.com>
User-Agent: alot/0.7
Subject: Re: [Intel-gfx] [PATCH 3/3] drm/i915: use might_lock_nested in get_pages
 annotation
Date:   Tue, 05 Nov 2019 11:02:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Vetter (2019-11-04 19:37:20)
> So strictly speaking the existing annotation is also ok, because we
> have a chain of
> 
> obj->mm.lock#I915_MM_GET_PAGES -> fs_reclaim -> obj->mm.lock
> 
> (the shrinker cannot get at an object while we're in get_pages, hence
> this is safe). But it's confusing, so try to take the right subclass
> of the lock.
> 
> This does a bit reduce our lockdep based checking, but then it's also
> less fragile, in case we ever change the nesting around.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

Regards, Joonas
