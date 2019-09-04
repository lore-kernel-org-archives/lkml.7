Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0274EC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61C122CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbfIDKsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 06:48:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:34529 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbfIDKsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:48:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 03:48:00 -0700
X-IronPort-AV: E=Sophos;i="5.64,465,1559545200"; 
   d="scan'208";a="176903236"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 03:47:55 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        Vishal Kulkarni <vishal@chelsio.com>, netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 1/2] linux/kernel.h: add yesno(), onoff(), enableddisabled(), plural() helpers
In-Reply-To: <dcdf1abc-7b8e-1f42-a955-0438b90fe9dc@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190903133731.2094-1-jani.nikula@intel.com> <dcdf1abc-7b8e-1f42-a955-0438b90fe9dc@rasmusvillemoes.dk>
Date:   Wed, 04 Sep 2019 13:47:52 +0300
Message-ID: <87blw049t3.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Sep 2019, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> On 03/09/2019 15.37, Jani Nikula wrote:
>
>> While the main goal here is to abstract recurring patterns, and slightly
>> clean up the code base by not open coding the ternary operators, there
>> are also some space savings to be had via better string constant
>> pooling.
>
> Eh, no? The linker does that across translation units anyway - moreover,
> given that you make them static inlines, "yes" and "no" will still live
> in .rodata.strX.Y in each individual TU that uses the yesno() helper.

I should've been more careful there; this allows us to do better
constant pooling but does not actually deliver on that here. You'd need
to return pointers to strings in the kernel image. The linker can't
constant pool across modules by itself.

Anyway, that was not the main point here.

> The enableddisabled() is a mouthful, perhaps the helpers should have an
> underscore between the choices
>
> yes_no()
> enabled_disabled()
> on_off()
>
> ?

I'm replacing existing functions that are being used in the kernel
already.

$ git grep "[^a-zA-Z0-9_]\(yesno\|onoff\|enableddisabled\)(" | wc -l
241

Not keen on renaming all of them.

>>  drivers/gpu/drm/i915/i915_utils.h             | 15 -------------
>>  .../ethernet/chelsio/cxgb4/cxgb4_debugfs.c    | 11 ----------
>>  drivers/usb/core/config.c                     |  5 -----
>>  drivers/usb/core/generic.c                    |  5 -----
>>  include/linux/kernel.h                        | 21 +++++++++++++++++++
>
> Pet peeve: Can we please stop using linux/kernel.h as a dumping ground
> for every little utility/helper? That makes each and every translation
> unit in the kernel slightly larger, hence slower to compile. Please make
> a linux/string-choice.h and put them there.

*grin*

In the absense of a natural candidate in include/linux/*.h, I thought
shoving them to kernel.h would provoke the best feedback on where to put
them. A new string-choice.h works for me, thanks. :)

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
