Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B162AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843A3206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732857AbfC0LHp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:07:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:59676 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729489AbfC0LHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:07:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 04:07:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,276,1549958400"; 
   d="scan'208";a="126273942"
Received: from jlahtine-desk.ger.corp.intel.com (HELO localhost) ([10.252.29.190])
  by orsmga007.jf.intel.com with ESMTP; 27 Mar 2019 04:07:40 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     DRI <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
In-Reply-To: <20190327135904.7830c60c@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Paulo Zanoni <paulo.r.zanoni@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
References: <20190327135904.7830c60c@canb.auug.org.au>
Message-ID: <155368485987.8699.12849690159482129286@jlahtine-desk.ger.corp.intel.com>
User-Agent: alot/0.7
Subject: Re: linux-next: build failure after merge of the drm-intel tree
Date:   Wed, 27 Mar 2019 13:07:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Rothwell (2019-03-27 04:59:04)
> Hi all,
> 
> After merging the drm-intel tree, today's linux-next build (i386
> defconfig) failed like this:

We had a CI reporting mishap, where a failed 32-bit build resulted in
a misleading success e-mail being sent.

The tree is now fixed and we'll investigate the problem to avoid such
a false report in the future.

Regards, Joonas

> 
> In file included from drivers/gpu/drm/i915/intel_guc.h:28:0,
>                  from drivers/gpu/drm/i915/intel_uc.h:27,
>                  from drivers/gpu/drm/i915/intel_uc.c:25:
> drivers/gpu/drm/i915/intel_uncore.h: In function '__raw_uncore_read64':
> drivers/gpu/drm/i915/intel_uncore.h:257:9: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Werror=implicit-function-declaration]
>   return read##s__(uncore->regs + i915_mmio_reg_offset(reg)); \
>          ^
> drivers/gpu/drm/i915/intel_uncore.h:269:1: note: in expansion of macro '__raw_read'
>  __raw_read(64, q)
>  ^~~~~~~~~~
> drivers/gpu/drm/i915/intel_uncore.h: In function '__raw_uncore_write64':
> drivers/gpu/drm/i915/intel_uncore.h:264:2: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]
>   write##s__(val, uncore->regs + i915_mmio_reg_offset(reg)); \
>   ^
> drivers/gpu/drm/i915/intel_uncore.h:274:1: note: in expansion of macro '__raw_write'
>  __raw_write(64, q)
>  ^~~~~~~~~~~
> 
> Caused by commit
> 
>   6cc5ca768825 ("drm/i915: rename raw reg access functions")
> 
> I have reverted that commit and the following ones in the tree up to
> 
>   9511cb6481af ("drm/i915: Adding missing '; ' to ENGINE_INSTANCES")
> 
> -- 
> Cheers,
> Stephen Rothwell
