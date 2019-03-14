Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F59C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174112085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfCNJaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:30:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:62488 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfCNJaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:30:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 02:30:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="125383921"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 14 Mar 2019 02:29:59 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h4MgY-0002mA-9a; Thu, 14 Mar 2019 11:29:58 +0200
Date:   Thu, 14 Mar 2019 11:29:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     lkml@sdf.org
Cc:     akpm@linux-foundation.org, daniel.wagner@siemens.com,
        dchinner@redhat.com, don.mullis@gmail.com, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        st5pub@yandex.ru
Subject: Re: [PATCH 1/5] lib/sort: Make swap functions more generic
Message-ID: <20190314092958.GV9224@smile.fi.intel.com>
References: <cover.1552097842.git.lkml@sdf.org>
 <dc6cc09e71f8687ff2ef4cbfc2b11accc9aba8aa.1552097842.git.lkml@sdf.org>
 <20190309140653.GO9224@smile.fi.intel.com>
 <201903091553.x29FrfMR018600@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201903091553.x29FrfMR018600@sdf.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 09, 2019 at 03:53:41PM +0000, lkml@sdf.org wrote:
> Andy Shevchenko wrote:
> > On Thu, Feb 21, 2019 at 06:30:28AM +0000, George Spelvin wrote:
> >> +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > 
> > Why #ifdef is better than if (IS_ENABLED()) ?
> 
> Because CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is bool and not
> tristate.  IS_ENABLED tests for 'y' or 'm' but we don't need it
> for something that's only on or off.

There is IS_BUILTIN(), though it's a common practice to use IS_ENABLED() even
for boolean options (I think because of naming of the macro).

> Looking through the kernel, I see both, but #ifdef or #if defined()
> are definitely in the majority:
> 
> lib/lzo/lzo1x_compress.c:#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && defined(LZO_USE_CTZ64)
> lib/siphash.c:#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> lib/string.c:#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> lib/strncpy_from_user.c:#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> lib/zlib_inflate/inffast.c:#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> 
> I see a few IS_ENABLED uses in include/crypto/ and kernel/bpf/.
> 
> It makes no real difference; #ifdef is simpler to me.


> static bool __attribute_const__
> is_aligned(const void *base, size_t size, unsigned char align)
> {
> 	unsigned char lsbits = (unsigned char)size;
> #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> 	(void)base;
> #else
> 	lsbits |= (unsigned char)(uintptr_t)base;
> #endif
> 	return (lsbits & (align - 1)) == 0;
> }

> Any preference?

This one looks better in a sense we don't suppress the warnings when it's not
needed.

> > For such primitives that operates on top of an arrays we usually append 's' to
> > the name. Currently the name is misleading.
> > 
> > Perhaps u32s_swap().
> 
> I don't worry much about the naming of static helper functions.
> If they were exported, it would be a whole lot more important!
> 
> I find "u32s" confusing; I keep reading the "s" as "signed" rather
> than a plural.

For signedness we use prefixes, for plural — suffixes. I don't see the point of
confusion. And this is in use in kernel a lot.

> How about one of:
> swap_bytes / swap_ints / swap_longs
> swap_1 / swap_4 / swap_8

longs are ambiguous, so I would prefer bit-sized types.

> > Shouldn't simple memcpy cover these case for both 32- and 64-bit architectures?
> 
> This isn't a memcpy, it's a memory *swap*.  To do it with memcpy
> requires:
> 	memcpy(temp_buffer, a, size);
> 	memcpy(a, b, size);
> 	memcpy(b, temp_buffer, size);
> 
> This is 1.5x as much memory access, and you have to find a large
> enough temp_buffer.  (I didn't think a variable-length array on
> the stack would make people happy.)
> 
> Also, although it is a predictable branch, memcpy() has to check the
> alignment of its inputs each call.  The reason for these helpers is
> to factor that out.

Makes sense.

-- 
With Best Regards,
Andy Shevchenko


