Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EACDC48BE9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C7120674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbfFXL2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 07:28:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:9448 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727525AbfFXL2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 07:28:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 04:28:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,412,1557212400"; 
   d="scan'208";a="182617283"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jun 2019 04:27:58 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/3] Docs: An initial automarkup extension for sphinx
In-Reply-To: <20190621235159.6992-2-corbet@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190621235159.6992-1-corbet@lwn.net> <20190621235159.6992-2-corbet@lwn.net>
Date:   Mon, 24 Jun 2019 14:30:47 +0300
Message-ID: <87k1dbrziw.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019, Jonathan Corbet <corbet@lwn.net> wrote:
> Rather than fill our text files with :c:func:`function()` syntax, just do
> the markup via a hook into the sphinx build process.
>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/conf.py              |  3 +-
>  Documentation/sphinx/automarkup.py | 80 ++++++++++++++++++++++++++++++
>  2 files changed, 82 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/sphinx/automarkup.py
>
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 7ace3f8852bd..a502baecbb85 100644
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
>  if (major == 1 and minor > 3) or (major > 1):
> diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/automarkup.py
> new file mode 100644
> index 000000000000..14b09b5d145e
> --- /dev/null
> +++ b/Documentation/sphinx/automarkup.py
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright 2019 Jonathan Corbet <corbet@lwn.net>
> +#
> +# Apply kernel-specific tweaks after the initial document processing
> +# has been done.
> +#
> +from docutils import nodes
> +from sphinx import addnodes
> +import re
> +
> +#
> +# Regex nastiness.  Of course.
> +# Try to identify "function()" that's not already marked up some
> +# other way.  Sphinx doesn't like a lot of stuff right after a
> +# :c:func: block (i.e. ":c:func:`mmap()`s" flakes out), so the last
> +# bit tries to restrict matches to things that won't create trouble.
> +#
> +RE_function = re.compile(r'([\w_][\w\d_]+\(\))')
> +
> +#
> +# The DVB docs create references for these basic system calls, leading
> +# to lots of confusing links.  So just don't link them.
> +#
> +Skipfuncs = [ 'open', 'close', 'write' ]
> +
> +#
> +# Find all occurrences of function() and try to replace them with
> +# appropriate cross references.
> +#
> +def markup_funcs(docname, app, node):
> +    cdom = app.env.domains['c']
> +    t = node.astext()
> +    done = 0
> +    repl = [ ]
> +    for m in RE_function.finditer(t):
> +        #
> +        # Include any text prior to function() as a normal text node.
> +        #
> +        if m.start() > done:
> +            repl.append(nodes.Text(t[done:m.start()]))
> +        #
> +        # Go through the dance of getting an xref out of the C domain
> +        #
> +        target = m.group(1)[:-2]
> +        target_text = nodes.Text(target + '()')
> +        xref = None
> +        if target not in Skipfuncs:
> +            lit_text = nodes.literal(classes=['xref', 'c', 'c-func'])
> +            lit_text += target_text
> +            pxref = addnodes.pending_xref('', refdomain = 'c',
> +                                          reftype = 'function',
> +                                          reftarget = target, modname = None,
> +                                          classname = None)
> +            xref = cdom.resolve_xref(app.env, docname, app.builder,
> +                                     'function', target, pxref, lit_text)
> +        #
> +        # Toss the xref into the list if we got it; otherwise just put
> +        # the function text.
> +        #
> +        if xref:
> +            repl.append(xref)
> +        else:
> +            repl.append(target_text)
> +        done = m.end()
> +    if done < len(t):
> +        repl.append(nodes.Text(t[done:]))
> +    return repl
> +
> +def auto_markup(app, doctree, name):
> +    for para in doctree.traverse(nodes.paragraph):
> +        for node in para.traverse(nodes.Text):
> +            if not isinstance(node.parent, nodes.literal):
> +                node.parent.replace(node, markup_funcs(name, app, node))

I think overall this is a better approach than preprocessing. Thanks for
doing this!

I toyed with something like this before, and the key difference here
seems to be ignoring literal blocks. The problem seemed to be that
replacing blocks with syntax highlighting also removed the syntax
highlighting, with no way that I could find to bring it back.

Obviously it would be great to be able to add the cross references in
more places than just bulk text nodes, but this is a good start.

BR,
Jani.


> +
> +def setup(app):
> +    app.connect('doctree-resolved', auto_markup)
> +    return {
> +        'parallel_read_safe': True,
> +        'parallel_write_safe': True,
> +        }

-- 
Jani Nikula, Intel Open Source Graphics Center
