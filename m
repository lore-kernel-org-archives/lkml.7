Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578EAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B58F2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfDDKka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:40:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:15960 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfDDKka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:40:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 03:40:29 -0700
X-IronPort-AV: E=Sophos;i="5.60,308,1549958400"; 
   d="scan'208";a="313079954"
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2019 03:40:27 -0700
Message-ID: <c1a857b241020a44c070cfc6b57adb6e6aba00be.camel@linux.intel.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Fix context IDs not released on
 driver hot unbind
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Date:   Thu, 04 Apr 2019 12:40:24 +0200
In-Reply-To: <155437373474.7532.10868620123516507965@skylake-alporthouse-com>
References: <20190404102445.12303-1-janusz.krzysztofik@linux.intel.com>
         <155437373474.7532.10868620123516507965@skylake-alporthouse-com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-04 at 11:28 +0100, Chris Wilson wrote:
> Quoting Janusz Krzysztofik (2019-04-04 11:24:45)
> > From: Janusz Krzysztofik <janusz.krzysztofik@intel.com>
> > 
> > In case the driver gets unbound while a device is open, kernel
> > panic
> > may be forced if a list of allocated context IDs is not empty.
> > 
> > When a device is open, the list may happen to be not empty because
> > a
> > context ID, once allocated by a context ID allocator to a context
> > assosiated with that open file descriptor, is released as late as
> > on device close.
> > 
> > On the other hand, there is a need to release all allocated context
> > IDs
> > and destroy the context ID allocator on driver unbind, even if a
> > device
> > is open, in order to free memory resources consumed and prevent
> > from
> > memory leaks.  The purpose of the forced kernel panic was to
> > protect
> > the context ID allocator from being silently destroyed if not all
> > allocated IDs had been released.
> 
> Those open fd are still pointing into kernel memory where the driver
> used to be. The panic is entirely correct, we should not be unloading
> the module before those dangling pointers have been made safe.
> 
> This is papering over the symptom. How is the module being unloaded
> with
> open fd? 

A user can play with the driver unbind or device remove sysfs
interface.

Thanks,
Janusz

> If all the fd have been closed, how have we failed to flush and
> retire all requests (thereby unpinning the contexts and all other
> pointers).
> -Chris
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

