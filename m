Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E32C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365D521479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562603341;
	bh=aW71/K4ecHLosDSDLDxZDE0IssLk1LqzCVnCsGZcpSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=R/2+pYZwGgUHyYshqZ8lbBWc4v2YTh3Ao+Xit37vseU1VMtA/qEYLfqkPY0MpvgWW
	 no8+uysOeE3EZ9Cj9XYSkAk22yh4SPViOb4IUGEBQSGQGHhumpsoMK0K3CrpC9yI38
	 TSkKuMJWZCJiuMD981eWTykbUX3r7Ja0EQ+MuzvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbfGHQ3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:29:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44408 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbfGHQ27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QqUJReTurIBV3kcOzctiiT9WS5fiRjHeQEh1zDlTBHA=; b=IhhHHt3D1sjrMXz8D7Z4fP4+D
        zHbSwD+uXt02lyJVCrocniNMoZPBP/GEArKSh9GV0JaEXXiAOz/uZ78ePuP+oK6jTxpSISWtoWdBC
        KNF0pf0J0NlPij0lO1ejUtMl6ZbGA9vtYlaJ/x0e3Gxm0c/4/mMK4aB2PHBNV3YiOUCfYfP1whwmF
        rZBozXXn5f2wASONLC/v6KDH26vyZuKE4ijD/UMcCpop0f2iMiMrpmPo2E3A82UXmmeGOEwdrSj7y
        rC4kY7xyiqjutNWXmycyPPSVZoohR7ldDWESAFI499XtaOkhkjriYfzC9PCSjKAkYSM+Ga9BVBaUp
        /Gw/Mm4kQ==;
Received: from 177.43.30.58.dynamic.adsl.gvt.net.br ([177.43.30.58] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkWVe-00068h-AO; Mon, 08 Jul 2019 16:28:58 +0000
Date:   Mon, 8 Jul 2019 13:28:53 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: automarkup.py: ignore exceptions when seeking for
 xrefs
Message-ID: <20190708132853.2fba9f62@coco.lan>
In-Reply-To: <20190708092336.01ade0ab@lwn.net>
References: <d9b1c85769ba659dba6c7c8b459e385be28ca478.1562430514.git.mchehab+samsung@kernel.org>
        <20190708092336.01ade0ab@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 8 Jul 2019 09:23:36 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Sat,  6 Jul 2019 13:28:42 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > When using the automarkup extension with:
> > 	make pdfdocs
> > 
> > without passing an specific book, the code will raise an exception:
> > 
> > 	  File "/devel/v4l/docs/Documentation/sphinx/automarkup.py", line 86, in auto_markup
> > 	    node.parent.replace(node, markup_funcs(name, app, node))
> > 	  File "/devel/v4l/docs/Documentation/sphinx/automarkup.py", line 59, in markup_funcs
> > 	    'function', target, pxref, lit_text)
> > 	  File "/devel/v4l/docs/sphinx_2.0/lib/python3.7/site-packages/sphinx/domains/c.py", line 308, in resolve_xref
> > 	    contnode, target)
> > 	  File "/devel/v4l/docs/sphinx_2.0/lib/python3.7/site-packages/sphinx/util/nodes.py", line 450, in make_refnode
> > 	    '#' + targetid)
> > 	  File "/devel/v4l/docs/sphinx_2.0/lib/python3.7/site-packages/sphinx/builders/latex/__init__.py", line 159, in get_relative_uri
> > 	    return self.get_target_uri(to, typ)
> > 	  File "/devel/v4l/docs/sphinx_2.0/lib/python3.7/site-packages/sphinx/builders/latex/__init__.py", line 152, in get_target_uri
> > 	    raise NoUri
> > 	sphinx.environment.NoUri
> > 
> > This happens because not all references will belong to a single
> > PDF/LaTeX document.  
> 
> Interesting.  I'd like to understand better why the HTML builder doesn't do
> this...it seems like a bug in the latex builder somehow.

It took me a while to identify what part of the extension was causing the
build breakage with make pdfdocs, but this occurs upstream too, if you
try to build all documents.

The funny thing is that, if you try to build a single book, e. g.:

	make SPHINXDIRS=foo pdfdocs

this won't happen.

I didn't spend too much time trying to identify the exact breakage reason.
All I did were to add some prints inside latex/*.py while debugging it, in
order to get a rough idea about what was happening.

On several places, the code with calls "raise NoUri" is called, but the
caller silently ignores it (that happens, for example, when it parses
:ref:`genindex`).

What I suspect is that, when you do an html build - or when you build just
a single book with SPHINXDIRS=foo, all dependencies are either:

	- unsolved; or
	- solved within the same document/html URL

In other words, solved references will have a relative position within
a single documentation body. So, there won't be any need for a document
to refer to a symbol on some other document.

With PDF, a symbol defined under, let's say, "core-api" defines a
core_foo() function, and this function is referenced inside the "driver-api"
book. The automarkup.py will convert a driver-api core_foo() to:
:ref:`core_foo()`, instead of :doc:`core-api`, but core_foo label
doesn't exist within the "driver-api" book context.

As we're not using intersphinx extension, Sphinx doesn't have any
URL to convert the cross-reference in a way that, if one clicks at the
reference, it will open the referenced document at the proper page. 

So, it bails out.

That's said, I didn't try to use intersphinx in order to check if
LaTeX references to other documents would actually work.

> 
> > Better to just ignore those than breaking Sphinx build.
> > 
> > Fixes: d74b0d31ddde ("Docs: An initial automarkup extension for sphinx")
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  Documentation/sphinx/automarkup.py | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/automarkup.py
> > index b300cf129869..dba14374f269 100644
> > --- a/Documentation/sphinx/automarkup.py
> > +++ b/Documentation/sphinx/automarkup.py
> > @@ -55,8 +55,13 @@ def markup_funcs(docname, app, node):
> >                                            reftype = 'function',
> >                                            reftarget = target, modname = None,
> >                                            classname = None)
> > -            xref = cdom.resolve_xref(app.env, docname, app.builder,
> > -                                     'function', target, pxref, lit_text)
> > +
> > +            # When building pdf documents, this may raise a NoUri exception
> > +            try:
> > +                xref = cdom.resolve_xref(app.env, docname, app.builder,
> > +                                         'function', target, pxref, lit_text)
> > +            except:
> > +                xref = None  
> 
> So this absolutely needs to be "except sphinx.environment.NoUri".  I have
> seen catch-all "except" clauses paper over or otherwise hide too many
> problems over the years; I really try to avoid ever using them.

Makes sense to me. Feel free to change it when you apply it.

> 
> I want to look at this problem and understand it a bit better; then I'll
> probably end up applying this patch with the above tweak.

Btw, I got some other issues when changed Sphinx to include all books to the
pdf output on my documentation development tree:

	https://git.linuxtv.org/mchehab/experimental.git/commit/?h=convert_rst_renames_next_v2&id=cd72aaefc8b07ce7909be914e46dfb02bad5d86b

They're related to having nested tables, with got fixed by this patch:

	https://git.linuxtv.org/mchehab/experimental.git/commit/?h=convert_rst_renames_next_v2&id=fd0b22e391431f766e9be6f161fab9646c0dd9ca

Thanks,
Mauro
