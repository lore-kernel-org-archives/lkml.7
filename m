Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAA1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8551620882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfDDNo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:44:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:56678 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbfDDNo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:44:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 06:44:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,308,1549958400"; 
   d="scan'208";a="161354804"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.79])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2019 06:44:55 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc:     David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Fix context IDs not released on driver hot unbind
In-Reply-To: <155437522546.7532.6754257066058816161@skylake-alporthouse-com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190404102445.12303-1-janusz.krzysztofik@linux.intel.com> <155437373474.7532.10868620123516507965@skylake-alporthouse-com> <c1a857b241020a44c070cfc6b57adb6e6aba00be.camel@linux.intel.com> <155437462649.7532.18347010454266779928@skylake-alporthouse-com> <1bda752c136f3a75817fe257027edd8be4e7472e.camel@linux.intel.com> <155437522546.7532.6754257066058816161@skylake-alporthouse-com>
Date:   Thu, 04 Apr 2019 16:47:31 +0300
Message-ID: <87r2ahyj9o.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Apr 2019, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> Quoting Janusz Krzysztofik (2019-04-04 11:50:14)
>> On Thu, 2019-04-04 at 11:43 +0100, Chris Wilson wrote:
>> > Quoting Janusz Krzysztofik (2019-04-04 11:40:24)
>> > > On Thu, 2019-04-04 at 11:28 +0100, Chris Wilson wrote:
>> > > > Quoting Janusz Krzysztofik (2019-04-04 11:24:45)
>> > > > > From: Janusz Krzysztofik <janusz.krzysztofik@intel.com>
>> > > > > 
>> > > > > In case the driver gets unbound while a device is open, kernel
>> > > > > panic
>> > > > > may be forced if a list of allocated context IDs is not empty.
>> > > > > 
>> > > > > When a device is open, the list may happen to be not empty
>> > > > > because
>> > > > > a
>> > > > > context ID, once allocated by a context ID allocator to a
>> > > > > context
>> > > > > assosiated with that open file descriptor, is released as late
>> > > > > as
>> > > > > on device close.
>> > > > > 
>> > > > > On the other hand, there is a need to release all allocated
>> > > > > context
>> > > > > IDs
>> > > > > and destroy the context ID allocator on driver unbind, even if
>> > > > > a
>> > > > > device
>> > > > > is open, in order to free memory resources consumed and prevent
>> > > > > from
>> > > > > memory leaks.  The purpose of the forced kernel panic was to
>> > > > > protect
>> > > > > the context ID allocator from being silently destroyed if not
>> > > > > all
>> > > > > allocated IDs had been released.
>> > > > 
>> > > > Those open fd are still pointing into kernel memory where the
>> > > > driver
>> > > > used to be. The panic is entirely correct, we should not be
>> > > > unloading
>> > > > the module before those dangling pointers have been made safe.
>> > > > 
>> > > > This is papering over the symptom. How is the module being
>> > > > unloaded
>> > > > with
>> > > > open fd? 
>> > > 
>> > > A user can play with the driver unbind or device remove sysfs
>> > > interface.
>> > 
>> > Sure, but we must still follow all the steps before _unloading_ the
>> > module or else the user is left pointing into reused kernel memory.
>> 
>> I'm not talking about unloading the module, that is prevented by open
>> fds.  The driver still exists after being unbound from a device and may
>> just respond with -ENODEV.
>
> i915_gem_contexts_fini() *is* module unload.

Janusz, please describe what you're doing exactly.

BR,
Jani.



-- 
Jani Nikula, Intel Open Source Graphics Center
