Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDF5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CC7204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbfDDKuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:50:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:14924 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfDDKuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:50:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 03:50:18 -0700
X-IronPort-AV: E=Sophos;i="5.60,308,1549958400"; 
   d="scan'208";a="220486012"
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2019 03:50:16 -0700
Message-ID: <1bda752c136f3a75817fe257027edd8be4e7472e.camel@linux.intel.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Fix context IDs not released on
 driver hot unbind
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Date:   Thu, 04 Apr 2019 12:50:14 +0200
In-Reply-To: <155437462649.7532.18347010454266779928@skylake-alporthouse-com>
References: <20190404102445.12303-1-janusz.krzysztofik@linux.intel.com>
         <155437373474.7532.10868620123516507965@skylake-alporthouse-com>
         <c1a857b241020a44c070cfc6b57adb6e6aba00be.camel@linux.intel.com>
         <155437462649.7532.18347010454266779928@skylake-alporthouse-com>
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

On Thu, 2019-04-04 at 11:43 +0100, Chris Wilson wrote:
> Quoting Janusz Krzysztofik (2019-04-04 11:40:24)
> > On Thu, 2019-04-04 at 11:28 +0100, Chris Wilson wrote:
> > > Quoting Janusz Krzysztofik (2019-04-04 11:24:45)
> > > > From: Janusz Krzysztofik <janusz.krzysztofik@intel.com>
> > > > 
> > > > In case the driver gets unbound while a device is open, kernel
> > > > panic
> > > > may be forced if a list of allocated context IDs is not empty.
> > > > 
> > > > When a device is open, the list may happen to be not empty
> > > > because
> > > > a
> > > > context ID, once allocated by a context ID allocator to a
> > > > context
> > > > assosiated with that open file descriptor, is released as late
> > > > as
> > > > on device close.
> > > > 
> > > > On the other hand, there is a need to release all allocated
> > > > context
> > > > IDs
> > > > and destroy the context ID allocator on driver unbind, even if
> > > > a
> > > > device
> > > > is open, in order to free memory resources consumed and prevent
> > > > from
> > > > memory leaks.  The purpose of the forced kernel panic was to
> > > > protect
> > > > the context ID allocator from being silently destroyed if not
> > > > all
> > > > allocated IDs had been released.
> > > 
> > > Those open fd are still pointing into kernel memory where the
> > > driver
> > > used to be. The panic is entirely correct, we should not be
> > > unloading
> > > the module before those dangling pointers have been made safe.
> > > 
> > > This is papering over the symptom. How is the module being
> > > unloaded
> > > with
> > > open fd? 
> > 
> > A user can play with the driver unbind or device remove sysfs
> > interface.
> 
> Sure, but we must still follow all the steps before _unloading_ the
> module or else the user is left pointing into reused kernel memory.

I'm not talking about unloading the module, that is prevented by open
fds.  The driver still exists after being unbound from a device and may
just respond with -ENODEV.

Janusz

> -Chris
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

