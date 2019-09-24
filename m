Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB1CC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9BA20673
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409219AbfIXHM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:12:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:42250 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393564AbfIXHM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:12:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 00:12:28 -0700
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="scan'208";a="182824701"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 00:12:25 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: Use make invocation's -j argument for parallelism
In-Reply-To: <201909231537.0FC0474C@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <201909191438.C00E6DB@keescook> <20190922140331.3ffe8604@lwn.net> <201909231537.0FC0474C@keescook>
Date:   Tue, 24 Sep 2019 10:12:22 +0300
Message-ID: <87pnjqtbft.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2019, Kees Cook <keescook@chromium.org> wrote:
> On Sun, Sep 22, 2019 at 02:03:31PM -0600, Jonathan Corbet wrote:
>> On Thu, 19 Sep 2019 14:44:37 -0700
>> Kees Cook <keescook@chromium.org> wrote:
>> 
>> > While sphinx 1.7 and later supports "-jauto" for parallelism, this
>> > effectively ignores the "-j" flag used in the "make" invocation, which
>> > may cause confusion for build systems. Instead, extract the available
>> 
>> What sort of confusion might we expect?  Or, to channel akpm, "what are the
>> user-visible effects of this bug"?
>
> When I run "make htmldocs -j16" with a pre-1.7 sphinx, it is not
> parallelized. When I run "make htmldocs -j8" with 1.7+ sphinx, it uses
> all my CPUs instead of 8. :)

To be honest, part of the solution should be to require Sphinx 1.8 or
later. Even Debian stable has it. If your distro doesn't have it
(really?), using the latest Sphinx in a virtual environment should be a
matter of:

$ python3 -m venv .venv
$ . .venv/bin/activate
(.venv) $ pip install sphinx sphinx_rtd_theme
(.venv) $ make htmldocs

BR,
Jani.


>
>> > +	-j $(shell python3 $(srctree)/scripts/jobserver-count $(SPHINX_PARALLEL)) \
>> 
>> This (and the shebang line in the script itself) will cause the docs build
>> to fail on systems lacking Python 3.  While we have talked about requiring
>> Python 3 for the docs build, we have not actually taken that step yet.  We
>> probably shouldn't sneak it in here.  I don't see anything in the script
>> that should require a specific Python version, so I think it should be
>> tweaked to be version-independent and just invoke "python".
>
> Ah, no problem. I can fix this. In a quick scan it looked like sphinx
> was python3, but I see now that's just my install. :)
>
>> >  	-b $2 \
>> >  	-c $(abspath $(srctree)/$(src)) \
>> >  	-d $(abspath $(BUILDDIR)/.doctrees/$3) \
>> > diff --git a/scripts/jobserver-count b/scripts/jobserver-count
>> > new file mode 100755
>> > index 000000000000..ff6ebe6b0194
>> > --- /dev/null
>> > +++ b/scripts/jobserver-count
>> > @@ -0,0 +1,53 @@
>> > +#!/usr/bin/env python3
>> > +# SPDX-License-Identifier: GPL-2.0-or-later
>> 
>> By license-rules.rst, this should be GPL-2.0+
>
> Whoops, thanks.
>
>> > +# Extract and prepare jobserver file descriptors from envirnoment.
>> > +try:
>> > +	# Fetch the make environment options.
>> > +	flags = os.environ['MAKEFLAGS']
>> > +
>> > +	# Look for "--jobserver=R,W"
>> > +	opts = [x for x in flags.split(" ") if x.startswith("--jobserver")]
>> > +
>> > +	# Parse out R,W file descriptor numbers and set them nonblocking.
>> > +	fds = opts[0].split("=", 1)[1]
>> > +	reader, writer = [nonblock(int(x)) for x in fds.split(",", 1)]
>> > +except:
>> 
>> So I have come to really dislike bare "except" clauses; I've seen them hide
>> too many bugs.  In this case, perhaps it's justified, but still ... it bugs
>> me ...
>
> Fair enough. I will adjust this (and the later instance).
>
>> 
>> > +	# Any failures here should result in just using the default
>> > +	# specified parallelism.
>> > +	print(default)
>> > +	sys.exit(0)
>> > +
>> > +# Read out as many jobserver slots as possible.
>> > +jobs = b""
>> > +while True:
>> > +	try:
>> > +		slot = os.read(reader, 1)
>> > +		jobs += slot
>> > +	except:
>> 
>> This one, I think, should be explicit; anything other than EWOULDBLOCK
>> indicates a real problem, right?
>> 
>> > +		break
>> > +# Return all the reserved slots.
>> > +os.write(writer, jobs)
>> 
>> You made writer nonblocking, so it seems plausible that we could leak some
>> slots here, no?  Does writer really need to be nonblocking?
>
> Good point. I will fix this too.
>
>> 
>> > +# If the jobserver was (impossibly) full or communication failed, use default.
>> > +if len(jobs) < 1:
>> > +	print(default)
>> > +
>> > +# Report available slots (with a bump for our caller's reserveration).
>> > +print(len(jobs) + 1)
>> 
>> The last question I have is...why is it that we have to do this complex
>> dance rather than just passing the "-j" option through directly to sphinx?
>> That comes down to the "confusion" mentioned at the top, I assume.  It
>> would be good to understand that?
>
> There is no method I have found to discover the -j option's contents
> (intentionally so, it seems) from within make. :(

-- 
Jani Nikula, Intel Open Source Graphics Center
