Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B29FC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735762070B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389075AbfJAObt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:31:49 -0400
Received: from ms.lwn.net ([45.79.88.28]:37144 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388640AbfJAObt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:31:49 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2EA6F491;
        Tue,  1 Oct 2019 14:31:48 +0000 (UTC)
Date:   Tue, 1 Oct 2019 08:31:47 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] docs: Programmatically render MAINTAINERS into ReST
Message-ID: <20191001083147.3a1b513f@lwn.net>
In-Reply-To: <20190924230208.12414-1-keescook@chromium.org>
References: <20190924230208.12414-1-keescook@chromium.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2019 16:02:06 -0700
Kees Cook <keescook@chromium.org> wrote:

> Commit log from Patch 2 repeated here for cover letter:
> 
> In order to have the MAINTAINERS file visible in the rendered ReST
> output, this makes some small changes to the existing MAINTAINERS file
> to allow for better machine processing, and adds a new Sphinx directive
> "maintainers-include" to perform the rendering.

I finally got around to trying this out.  After the usual warnings, the
build comes to a screeching halt with this:

  Sphinx parallel build error:
  UnicodeDecodeError: 'ascii' codec can't decode byte 0xc3 in position 8: ordinal not in range(128)

For extra fun, the build process simply hangs, requiring a ^C to blow it
away.  You've managed to get new behavior out of Sphinx that I've not seen
before, congratulations :)

This almost certainly has to do with the fact that I'm (intentionally)
running the Python2 Sphinx build here.  Something's not doing unicode that
should be.

I would suggest that we might just want to repair this before merging this
feature.  Either that, or we bite the bullet and deprecate the use of
Python 2 entirely - something that's probably not too far into our future
regardless.  Anybody have thoughts on that matter?

On a separate note...it occurred to me, rather belatedly as usual, that
last time we discussed doing this that there was some opposition to adding
a second MAINTAINERS parser to the kernel; future changes to the format of
that file may force both to be adjusted, and somebody will invariably
forget one.  Addressing that, if we feel a need to do so, probably requires
tweaking get_maintainer.pl to output the information in a useful format.

Thanks,

jon
