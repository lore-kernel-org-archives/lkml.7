Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA5EC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77603216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfEIMbK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 08:31:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:22904 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbfEIMbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 08:31:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 May 2019 05:31:09 -0700
X-ExtLoop1: 1
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 09 May 2019 05:31:06 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Daniel Drake <drake@endlessm.com>,
        Paulo Zanoni <paulo.r.zanoni@intel.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: [PATCH] i915: disable framebuffer compression on GeminiLake
In-Reply-To: <CAD8Lp462rLGnnTLCSOoMWwU37bxCk1cznsw8==Z8AgumeqHXkQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190423092810.28359-1-jian-hong@endlessm.com> <155613593248.25205.769591454199358982@skylake-alporthouse-com> <15be67b19d898ab74c9ae6d9d9080ef339772e00.camel@intel.com> <CAD8Lp462rLGnnTLCSOoMWwU37bxCk1cznsw8==Z8AgumeqHXkQ@mail.gmail.com>
Date:   Thu, 09 May 2019 15:33:12 +0300
Message-ID: <87ftpnlsdz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 May 2019, Daniel Drake <drake@endlessm.com> wrote:
> Hi,
>
>
> On Thu, Apr 25, 2019 at 4:27 AM Paulo Zanoni <paulo.r.zanoni@intel.com> wrote:
>>
>> Em qua, 2019-04-24 às 20:58 +0100, Chris Wilson escreveu:
>> > Quoting Jian-Hong Pan (2019-04-23 10:28:10)
>> > > From: Daniel Drake <drake@endlessm.com>
>> > >
>> > > On many (all?) the Gemini Lake systems we work with, there is frequent
>> > > momentary graphical corruption at the top of the screen, and it seems
>> > > that disabling framebuffer compression can avoid this.
>> > >
>> > > The ticket was reported 6 months ago and has already affected a
>> > > multitude of users, without any real progress being made. So, lets
>> > > disable framebuffer compression on GeminiLake until a solution is found.
>> > >
>> > > Buglink: https://bugs.freedesktop.org/show_bug.cgi?id=108085
>> > > Signed-off-by: Daniel Drake <drake@endlessm.com>
>> > > Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
>> >
>> > Fixes: fd7d6c5c8f3e ("drm/i915: enable FBC on gen9+ too") ?
>> > Cc: Paulo Zanoni <paulo.r.zanoni@intel.com>
>> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
>> > Cc: <stable@vger.kernel.org> # v4.11+
>> >
>> > glk landed 1 month before, so that seems the earliest broken point.
>> >
>>
>> The bug is well reported, the bug author is helpful and it even has a
>> description of "steps to reproduce" that looks very easy (although I
>> didn't try it). Everything suggests this is a bug the display team
>> could actually solve with not-so-many hours of debugging.
>>
>> In the meantime, unbreak the systems:
>> Reviewed-by: Paulo Zanoni <paulo.r.zanoni@intel.com>
>
> Quick ping here. Any further comments on this patch? Can it be applied?

Pushed now, thanks. Needed to get a clean CI result, and I dropped the
ball a bit there, sorry.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
