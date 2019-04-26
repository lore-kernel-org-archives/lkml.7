Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D226C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490C32084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556303585;
	bh=zu26x2Cfg4/zMlaNcGM6fyH0OhgAOWcY8XdI9Lkcm8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EFTv43rghFnJdPwwEMMqp2nUoMt+wd2dIq4rZxgewBCBchP4kLQpgBcjfou1Nwz7J
	 yKT1h6Mq0Ao9qY2lhm5VM6AuNWZeoY77nQiTSTnfCGV2orSHreG6wqC5SPdqDlg/uM
	 emhgzZnYaFsYLYSOiTEVbNQabTqDar9jw/0Mlpc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfDZSdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:33:03 -0400
Received: from casper.infradead.org ([85.118.1.10]:34968 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfDZSdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=J4cV7Zn6kon3SBzZ8Dkc4MK9mlmKdioSL0HZpblnYyw=; b=A/HTRXJhvpDHtT6ri15Ud8Qkid
        uX1aJAZuvaRufXInPuDOS+zsSvLyf9X12ejfpdLycPPY1TV/Fv5UYavzY8JAoeaPW7ZpS+C/92LBA
        Hrop7PgifyhkMEvFvb7Rr6YSUwDLTp90x4XhcKNyQaFaPIc7qJ2Q6lFdCm8enueZarSQApUxNJ3MF
        5RTw30szdjcn6kFCqEpZ+Esh0NX4kQuBjTUTgDJz/zQ/lXc2WlXa44S2lS84M2M4el1kunT2xM5j8
        axnuyMwpYGrIL2vojws+EMg65sdcRCP7z6YGdf+67gzjt06pwbWBD22HehVqfcT5hOHF+vcOnaV/q
        lgtsrHRQ==;
Received: from [179.95.39.209] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hK5ed-0005W0-KY; Fri, 26 Apr 2019 18:33:00 +0000
Date:   Fri, 26 Apr 2019 15:32:55 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/2] Docs: An initial automarkup extension for sphinx
Message-ID: <20190426153255.7e424a45@coco.lan>
In-Reply-To: <20190425200125.12302-2-corbet@lwn.net>
References: <20190425200125.12302-1-corbet@lwn.net>
        <20190425200125.12302-2-corbet@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 25 Apr 2019 14:01:24 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Rather than fill our text files with :c:func:`function()` syntax, just do
> the markup via a hook into the sphinx build process.  As is always the
> case, the real problem is detecting the situations where this markup shou=
ld
> *not* be done.
>=20
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/conf.py              |  3 +-
>  Documentation/sphinx/automarkup.py | 90 ++++++++++++++++++++++++++++++
>  2 files changed, 92 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/sphinx/automarkup.py
>=20
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 72647a38b5c2..ba7b2846b1c5 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -34,7 +34,8 @@ needs_sphinx =3D '1.3'
>  # Add any Sphinx extension module names here, as strings. They can be
>  # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
>  # ones.
> -extensions =3D ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain'=
, 'kfigure', 'sphinx.ext.ifconfig']
> +extensions =3D ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain',
> +              'kfigure', 'sphinx.ext.ifconfig', 'automarkup']
> =20
>  # The name of the math extension changed on Sphinx 1.4
>  if major =3D=3D 1 and minor > 3:
> diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/au=
tomarkup.py
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
> +# much later and traversing through the doctree.  That would eliminate t=
he
> +# need to duplicate some RST parsing and perhaps be less fragile, at the
> +# cost of some more complexity and the need to generate the cross-refere=
nce
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
> +RE_function =3D re.compile(r'(^|\s+)([\w\d_]+\(\))([.,/\s]|$)')

IMHO, this looks good enough to avoid trouble, maybe except if one
wants to write a document explaining this functionality at the
doc-guide/kernel-doc.rst.

Anyway, the way it is written, we could still explain it by adding
a "\ " after the func, e. g.:

	When you write a function like: func()\ , the automarkup
	extension will automatically convert it into:
	``:c:func:`func()```.

So, this looks OK on my eyes.

> +#
> +# Lines consisting of a single underline character.
> +#
> +RE_underline =3D re.compile(r'^([-=3D~])\1+$')

Hmm... why are you calling this "underline"? Sounds a bad name to me,
as it took me a while to understand what you meant.

=46rom the code I'm inferring that this is meant to track 3 of the
possible symbols used as a (sub).*title markup. On several places=20
we use other symbols:'^', '~', '.', '*' (and others) as sub-sub(sub..)
title markups.

I would instead define this Regex as:

	RE_title_markup =3D re.compile(r'^([^\w\d])\1+$')

You should probably need another regex for the title itself:

	RE_possible_title =3D re.compile(r'^(\S.*\S)\s*$')

in order to get the size of the matched line. Doing a doing len(previous)
will get you false positives.

As on Sphinx, **all** titles should start at the first column,
or it will produce a severe error[1], we can use such regex to
minimize parsing errors.

[1] and either crash or keep running some endless loop internally.
Not being bad enough, it will also invalidate all the previously
cached data, losing a lot of time next time you try to build the
docs.

---

on a separate matter (but related to automarkup matter - and to what
I would name underline), as a future feature, perhaps we could also add
a parser for:

	_something that requires underlines_

Underlined text is probably the only feature that we use on several docs
with Sphinx doesn't support (there are some extensions for that - I guess,
but it sounds simple enough to have a parser here).

This can be tricky to get it right, as just underlines_ is a
cross reference markup - so, I would only add this after we improve the
script to come after Sphinx own markup processing.

---

> +#
> +# Starting a literal block.
> +#
> +RE_literal =3D re.compile(r'^(\s*)(.*::\s*|\.\.\s+code-block::.*)$')
> +#
> +# Just get the white space beginning a line.
> +#
> +RE_whitesp =3D re.compile(r'^(\s*)')
> +
> +def MangleFile(app, docname, text):
> +    ret =3D [ ]
> +    previous =3D ''
> +    literal =3D False
> +    for line in text[0].split('\n'):
> +        #
> +        # See if we might be ending a literal block, as denoted by
> +        # an indent no greater than when we started.
> +        #
> +        if literal and len(line) > 0:
> +            m =3D RE_whitesp.match(line)  # Should always match
> +            if len(m.group(1).expandtabs()) <=3D lit_indent:
> +                literal =3D False
> +        #
> +        # Blank lines, directives, and lines within literal blocks
> +        # should not be messed with.
> +        #
> +        if literal or len(line) =3D=3D 0 or line[0] =3D=3D '.':
> +            ret.append(line)


> +        #
> +        # Is this an underline line?  If so, and it is the same length
> +        # as the previous line, we may have mangled a heading line in
> +        # error, so undo it.
> +        #
> +        elif RE_underline.match(line):
> +            if len(line) =3D=3D len(previous):

No, that doesn't seem enough. I would, instead, use the regex I
proposed before, in order to check if the previous line starts with
a non-space, and getting the length only up to the last non-space
(yeah, unfortunately, we have some text files that have extra blank
spaces at line's tail).

> +                ret[-1] =3D previous
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
> +        m =3D RE_literal.match(line)
> +        if m:
> +            literal =3D True
> +            lit_indent =3D len(m.group(1).expandtabs())
> +        previous =3D line
> +    text[0] =3D '\n'.join(ret)
> +
> +def setup(app):
> +    app.connect('source-read', MangleFile)
> +
> +    return dict(
> +        parallel_read_safe =3D True,
> +        parallel_write_safe =3D True
> +    )

The remaining looks fine to me - although I'm not a Sphinx-extension
expert, and my knowledge of python is far from being perfect.

Thanks,
Mauro
