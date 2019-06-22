Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C614CC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 14:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7C62070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 14:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfFVOnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 10:43:49 -0400
Received: from ms.lwn.net ([45.79.88.28]:59774 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfFVOns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 10:43:48 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0CBE84FA;
        Sat, 22 Jun 2019 14:43:48 +0000 (UTC)
Date:   Sat, 22 Jun 2019 08:43:46 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Docs: An initial automarkup extension for sphinx
Message-ID: <20190622084346.28c7c748@lwn.net>
In-Reply-To: <20190621220046.3de30d9d@coco.lan>
References: <20190621235159.6992-1-corbet@lwn.net>
        <20190621235159.6992-2-corbet@lwn.net>
        <20190621220046.3de30d9d@coco.lan>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019 22:00:46 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> > +#
> > +# The DVB docs create references for these basic system calls, leading
> > +# to lots of confusing links.  So just don't link them.
> > +#
> > +Skipfuncs = [ 'open', 'close', 'write' ]  
> 
> and yeah, of course, if there's something weird, it has to be at
> the media docs :-)
> 
> Btw, if I'm not mistaken, we do the same for ioctl.

So that's actually interesting.  In, for example,
Documentation/media/uapi/v4l/func-ioctl.rst, you see something that looks
like this:

> .. c:function:: int ioctl( int fd, int request, void *argp )
>     :name: v4l2-ioctl

Some digging around didn't turn up any documentation for :name:, but it
seems to prevent ioctl() from going into the list of functions that can be
cross-referenced.  I wonder if the same should be done for the others?  I
think that would be better than putting a special-case hack into the
toolchain.

> I'm wandering if this could also handle the Documentation/* auto-replace.

I think it's the obvious place for it, yes.  Let's make sure I haven't
badly broken anything with the existing change first, though :)

Thanks,

jon
