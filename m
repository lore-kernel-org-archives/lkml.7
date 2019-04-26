Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741F8C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478F22084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfDZJEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:04:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:7812 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfDZJE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:04:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2019 02:04:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,396,1549958400"; 
   d="scan'208";a="168131998"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 26 Apr 2019 02:04:25 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/2] Docs: An initial automarkup extension for sphinx
In-Reply-To: <20190425200125.12302-2-corbet@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190425200125.12302-1-corbet@lwn.net> <20190425200125.12302-2-corbet@lwn.net>
Date:   Fri, 26 Apr 2019 12:06:42 +0300
Message-ID: <87tvelrv8d.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019, Jonathan Corbet <corbet@lwn.net> wrote:
> Rather than fill our text files with :c:func:`function()` syntax, just do
> the markup via a hook into the sphinx build process.  As is always the
> case, the real problem is detecting the situations where this markup should
> *not* be done.

This is basically a regex based pre-processing step in front of Sphinx,
but it's not independent as it embeds a limited understanding/parsing of
reStructuredText syntax. This is similar to what we do in kernel-doc the
Perl monster, except slightly different.

I understand the motivation, and I sympathize with the idea of a quick
regex hack to silence the mob. But I fear this will lead to hard to
solve corner cases and the same style of "impedance mismatches" we had
with the kernel-doc/docproc/docbook Rube Goldberg machine of the past.

It's more involved, but I think the better place to do this (as well as
the kernel-doc transformations) would be in the doctree-read event,
after the rst parsing is done. You can traverse the doctree and find the
places which weren't special for Sphinx, and replace the plain text
nodes in-place. I've toyed with this in the past, but alas I didn't have
(and still don't) have the time to finish the job. There were some
unresolved issues with e.g. replacing nodes that had syntax highlighting
(because I wanted to make the references work also within preformatted
blocks).

If you decide to go with regex anyway, I'd at least consider pulling the
transformations/highlights from kernel-doc the script to the Sphinx
extension, and use the exact same transformations for stuff in source
code comments and rst files.

BR,
Jani.

>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/conf.py              |  3 +-
>  Documentation/sphinx/automarkup.py | 90 ++++++++++++++++++++++++++++++
>  2 files changed, 92 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/sphinx/automarkup.py
>
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 72647a38b5c2..ba7b2846b1c5 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -34,7 +34,8 @@ needs_sphinx = '1.3'
>  # Add any Sphinx extension module names here, as strings. They can be
>  # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
>  # ones.
> -extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain', 'kfigure', 'sphinx.ext.ifconfig']
> +extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain',
> +              'kfigure', 'sphinx.ext.ifconfig', 'automarkup']
>  
>  # The name of the math extension changed on Sphinx 1.4
>  if major == 1 and minor > 3:
> diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/automarkup.py
> new file mode 100644
> index 000000000000..c47469372bae
> --- /dev/null
> +++ b/Documentation/sphinx/automarkup.py
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# This is a little Sphinx extension that tries to apply certain kinds
> +# of markup automatically so we can keep it out of the text files
> +# themselves.
> +#
> +# It's possible that this could be done better by hooking into the build
> +# much later and traversing through the doctree.  That would eliminate the
> +# need to duplicate some RST parsing and perhaps be less fragile, at the
> +# cost of some more complexity and the need to generate the cross-reference
> +# links ourselves.
> +#
> +# Copyright 2019 Jonathan Corbet <corbet@lwn.net>
> +#
> +from __future__ import print_function
> +import re
> +import sphinx
> +
> +#
> +# Regex nastiness.  Of course.
> +# Try to identify "function()" that's not already marked up some
> +# other way.  Sphinx doesn't like a lot of stuff right after a
> +# :c:func: block (i.e. ":c:func:`mmap()`s" flakes out), so the last
> +# bit tries to restrict matches to things that won't create trouble.
> +#
> +RE_function = re.compile(r'(^|\s+)([\w\d_]+\(\))([.,/\s]|$)')
> +#
> +# Lines consisting of a single underline character.
> +#
> +RE_underline = re.compile(r'^([-=~])\1+$')
> +#
> +# Starting a literal block.
> +#
> +RE_literal = re.compile(r'^(\s*)(.*::\s*|\.\.\s+code-block::.*)$')
> +#
> +# Just get the white space beginning a line.
> +#
> +RE_whitesp = re.compile(r'^(\s*)')
> +
> +def MangleFile(app, docname, text):
> +    ret = [ ]
> +    previous = ''
> +    literal = False
> +    for line in text[0].split('\n'):
> +        #
> +        # See if we might be ending a literal block, as denoted by
> +        # an indent no greater than when we started.
> +        #
> +        if literal and len(line) > 0:
> +            m = RE_whitesp.match(line)  # Should always match
> +            if len(m.group(1).expandtabs()) <= lit_indent:
> +                literal = False
> +        #
> +        # Blank lines, directives, and lines within literal blocks
> +        # should not be messed with.
> +        #
> +        if literal or len(line) == 0 or line[0] == '.':
> +            ret.append(line)
> +        #
> +        # Is this an underline line?  If so, and it is the same length
> +        # as the previous line, we may have mangled a heading line in
> +        # error, so undo it.
> +        #
> +        elif RE_underline.match(line):
> +            if len(line) == len(previous):
> +                ret[-1] = previous
> +            ret.append(line)
> +        #
> +        # Normal line - perform substitutions.
> +        #
> +        else:
> +            ret.append(RE_function.sub(r'\1:c:func:`\2`\3', line))
> +        #
> +        # Might we be starting a literal block?  If so make note of
> +        # the fact.
> +        #
> +        m = RE_literal.match(line)
> +        if m:
> +            literal = True
> +            lit_indent = len(m.group(1).expandtabs())
> +        previous = line
> +    text[0] = '\n'.join(ret)
> +
> +def setup(app):
> +    app.connect('source-read', MangleFile)
> +
> +    return dict(
> +        parallel_read_safe = True,
> +        parallel_write_safe = True
> +    )

-- 
Jani Nikula, Intel Open Source Graphics Center
