Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F68C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299B9206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbfETK6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 06:58:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:55257 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfETK6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 06:58:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 03:58:32 -0700
Received: from jkrzyszt-desk.ger.corp.intel.com ([172.22.244.18])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 03:58:30 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Michal Wajdeczko <michal.wajdeczko@intel.com>
Subject: Re: [RFC PATCH] drm/i915: Tolerate file owned GEM contexts on hot unbind
Date:   Mon, 20 May 2019 12:58:21 +0200
Message-ID: <1818300.2E6qEfYBKl@jkrzyszt-desk.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <155810355587.12244.1572259791791116662@skylake-alporthouse-com>
References: <20190517140617.31187-1-janusz.krzysztofik@linux.intel.com> <155810355587.12244.1572259791791116662@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, May 17, 2019 4:32:35 PM CEST Chris Wilson wrote:
> Quoting Janusz Krzysztofik (2019-05-17 15:06:17)
> > From: Janusz Krzysztofik <janusz.krzysztofik@intel.com>
> > 
> > During i915_driver_unload(), GEM contexts are verified restrictively
> > inside i915_gem_fini() if they don't consume shared resources which
> > should be cleaned up before the driver is released.  If those checks
> > don't result in kernel panic, one more check is performed at the end of
> > i915_gem_fini() which issues a WARN_ON() if GEM contexts still exist.
> 
> Just fix the underlying bug of this code being called too early. The
> assumptions we made for unload are clearly invalid when applied to
> unbind, and we need to split the phases.
> -Chris

Thanks Chris, I think I get it finally.

Janusz




