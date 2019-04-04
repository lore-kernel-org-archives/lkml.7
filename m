Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB4BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A20220652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfDDK3M convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:29:12 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:62821 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726563AbfDDK3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:29:12 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16128560-1500050 
        for multiple; Thu, 04 Apr 2019 11:29:02 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190404102445.12303-1-janusz.krzysztofik@linux.intel.com>
Cc:     Janusz Krzysztofik <janusz.krzysztofik@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20190404102445.12303-1-janusz.krzysztofik@linux.intel.com>
Message-ID: <155437373474.7532.10868620123516507965@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Fix context IDs not released on driver hot
 unbind
Date:   Thu, 04 Apr 2019 11:28:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Janusz Krzysztofik (2019-04-04 11:24:45)
> From: Janusz Krzysztofik <janusz.krzysztofik@intel.com>
> 
> In case the driver gets unbound while a device is open, kernel panic
> may be forced if a list of allocated context IDs is not empty.
> 
> When a device is open, the list may happen to be not empty because a
> context ID, once allocated by a context ID allocator to a context
> assosiated with that open file descriptor, is released as late as
> on device close.
> 
> On the other hand, there is a need to release all allocated context IDs
> and destroy the context ID allocator on driver unbind, even if a device
> is open, in order to free memory resources consumed and prevent from
> memory leaks.  The purpose of the forced kernel panic was to protect
> the context ID allocator from being silently destroyed if not all
> allocated IDs had been released.

Those open fd are still pointing into kernel memory where the driver
used to be. The panic is entirely correct, we should not be unloading
the module before those dangling pointers have been made safe.

This is papering over the symptom. How is the module being unloaded with
open fd? If all the fd have been closed, how have we failed to flush and
retire all requests (thereby unpinning the contexts and all other
pointers).
-Chris
