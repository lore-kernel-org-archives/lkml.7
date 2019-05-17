Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0094CC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 14:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21902087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 14:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfEQOcu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 10:32:50 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:63692 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728887AbfEQOct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 10:32:49 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16590567-1500050 
        for multiple; Fri, 17 May 2019 15:32:37 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        intel-gfx@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190517140617.31187-1-janusz.krzysztofik@linux.intel.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Janusz Krzysztofik <janusz.krzysztofik@intel.com>
References: <20190517140617.31187-1-janusz.krzysztofik@linux.intel.com>
Message-ID: <155810355587.12244.1572259791791116662@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [RFC PATCH] drm/i915: Tolerate file owned GEM contexts on hot unbind
Date:   Fri, 17 May 2019 15:32:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Janusz Krzysztofik (2019-05-17 15:06:17)
> From: Janusz Krzysztofik <janusz.krzysztofik@intel.com>
> 
> During i915_driver_unload(), GEM contexts are verified restrictively
> inside i915_gem_fini() if they don't consume shared resources which
> should be cleaned up before the driver is released.  If those checks
> don't result in kernel panic, one more check is performed at the end of
> i915_gem_fini() which issues a WARN_ON() if GEM contexts still exist.

Just fix the underlying bug of this code being called too early. The
assumptions we made for unload are clearly invalid when applied to
unbind, and we need to split the phases.
-Chris
