Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48487C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E67213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfFXO0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:26:00 -0400
Received: from ms.lwn.net ([45.79.88.28]:43870 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfFXO0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:26:00 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A686D35A;
        Mon, 24 Jun 2019 14:25:59 +0000 (UTC)
Date:   Mon, 24 Jun 2019 08:25:58 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Docs: An initial automarkup extension for sphinx
Message-ID: <20190624082558.62e6c0d2@lwn.net>
In-Reply-To: <87k1dbrziw.fsf@intel.com>
References: <20190621235159.6992-1-corbet@lwn.net>
        <20190621235159.6992-2-corbet@lwn.net>
        <87k1dbrziw.fsf@intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019 14:30:47 +0300
Jani Nikula <jani.nikula@linux.intel.com> wrote:

> > +def auto_markup(app, doctree, name):
> > +    for para in doctree.traverse(nodes.paragraph):
> > +        for node in para.traverse(nodes.Text):
> > +            if not isinstance(node.parent, nodes.literal):
> > +                node.parent.replace(node, markup_funcs(name, app, node))  
> 
> I think overall this is a better approach than preprocessing. Thanks for
> doing this!
> 
> I toyed with something like this before, and the key difference here
> seems to be ignoring literal blocks. The problem seemed to be that
> replacing blocks with syntax highlighting also removed the syntax
> highlighting, with no way that I could find to bring it back.

That test could use a comment, really.  What it is actually doing is
skipping text chunks in ``inline literal`` sections, and what that is
*actually* doing is avoiding marking up functions that have an
explicit :c:func: markup on them already.

Someday I don't doubt that this loop will be replaced by a proper tree
walk that knows where to prune things and how to replace various other
types of nodes, but this is easy and does the right thing pretty much
everywhere as far as I can tell.

Thanks,

jon
