Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B923C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28D320665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388232AbfGHPXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:23:42 -0400
Received: from ms.lwn.net ([45.79.88.28]:51864 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731266AbfGHPXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:23:38 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 47D992B8;
        Mon,  8 Jul 2019 15:23:37 +0000 (UTC)
Date:   Mon, 8 Jul 2019 09:23:36 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: automarkup.py: ignore exceptions when seeking for
 xrefs
Message-ID: <20190708092336.01ade0ab@lwn.net>
In-Reply-To: <d9b1c85769ba659dba6c7c8b459e385be28ca478.1562430514.git.mchehab+samsung@kernel.org>
References: <d9b1c85769ba659dba6c7c8b459e385be28ca478.1562430514.git.mchehab+samsung@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  6 Jul 2019 13:28:42 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> When using the automarkup extension with:
> 	make pdfdocs
> 
> without passing an specific book, the code will raise an exception:
> 
> 	  File "/devel/v4l/docs/Documentation/sphinx/automarkup.py", line 86, in auto_markup
> 	    node.parent.replace(node, markup_funcs(name, app, node))
> 	  File "/devel/v4l/docs/Documentation/sphinx/automarkup.py", line 59, in markup_funcs
> 	    'function', target, pxref, lit_text)
> 	  File "/devel/v4l/docs/sphinx_2.0/lib/python3.7/site-packages/sphinx/domains/c.py", line 308, in resolve_xref
> 	    contnode, target)
> 	  File "/devel/v4l/docs/sphinx_2.0/lib/python3.7/site-packages/sphinx/util/nodes.py", line 450, in make_refnode
> 	    '#' + targetid)
> 	  File "/devel/v4l/docs/sphinx_2.0/lib/python3.7/site-packages/sphinx/builders/latex/__init__.py", line 159, in get_relative_uri
> 	    return self.get_target_uri(to, typ)
> 	  File "/devel/v4l/docs/sphinx_2.0/lib/python3.7/site-packages/sphinx/builders/latex/__init__.py", line 152, in get_target_uri
> 	    raise NoUri
> 	sphinx.environment.NoUri
> 
> This happens because not all references will belong to a single
> PDF/LaTeX document.

Interesting.  I'd like to understand better why the HTML builder doesn't do
this...it seems like a bug in the latex builder somehow.

> Better to just ignore those than breaking Sphinx build.
> 
> Fixes: d74b0d31ddde ("Docs: An initial automarkup extension for sphinx")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/sphinx/automarkup.py | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/automarkup.py
> index b300cf129869..dba14374f269 100644
> --- a/Documentation/sphinx/automarkup.py
> +++ b/Documentation/sphinx/automarkup.py
> @@ -55,8 +55,13 @@ def markup_funcs(docname, app, node):
>                                            reftype = 'function',
>                                            reftarget = target, modname = None,
>                                            classname = None)
> -            xref = cdom.resolve_xref(app.env, docname, app.builder,
> -                                     'function', target, pxref, lit_text)
> +
> +            # When building pdf documents, this may raise a NoUri exception
> +            try:
> +                xref = cdom.resolve_xref(app.env, docname, app.builder,
> +                                         'function', target, pxref, lit_text)
> +            except:
> +                xref = None

So this absolutely needs to be "except sphinx.environment.NoUri".  I have
seen catch-all "except" clauses paper over or otherwise hide too many
problems over the years; I really try to avoid ever using them.

I want to look at this problem and understand it a bit better; then I'll
probably end up applying this patch with the above tweak.

Thanks,

jon
