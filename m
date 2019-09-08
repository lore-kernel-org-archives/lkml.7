Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B792BC4360D
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 20:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B803218AE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 20:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbfIHU7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 16:59:46 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47359 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729973AbfIHU7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 16:59:46 -0400
Received: from callcc.thunk.org (110.8.30.213.rev.vodafone.pt [213.30.8.110])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x88KxWoj021687
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 8 Sep 2019 16:59:33 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8EC6D42049E; Sun,  8 Sep 2019 16:59:31 -0400 (EDT)
Date:   Sun, 8 Sep 2019 16:59:31 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Sandro Volery <sandro@volery.com>
Cc:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed most indent issues in tty_io.c
Message-ID: <20190908205931.GG23683@mit.edu>
References: <529940f5dd3ca0426f8e953d232a16b4eccfbfb7.camel@perches.com>
 <C511485C-6194-4B31-BA98-C4C9000062AD@volery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C511485C-6194-4B31-BA98-C4C9000062AD@volery.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandro,

It's not mentioned in the process documentation (but maybe we should
add this), is that it's up to individual maintainers about whether or
not whitespace cleanups are accepted outside of the staging tree.

That's because whitespace cleanups are a great "training wheel" for
newbies who are learning the ropes, but they do have some costs.  For
example, for actively developed portions of the kernel whitespace
cleans can often break other pending changes.  Also, trivial cleanups
(e.g., spelling and whitespace cleanups) makes it more likely that
future bug fixes in that portion of the kernel will fail to be
automatically backported to the stable kernel, thus requiring a manual
backport effort.  

As a result, some maintainers will reject trivial cleanups unless they
are part of a patch series that is making some kind of substantive
improvement to the kernel (beyond trivial cleanups).

There are some good aspects of fixing whitespace issues, of course,
which is why they are encouraged in the staging tree, but there is not
consensus amongst maintainers about whether it is a net benefit to do
clean up patches just for the sake of doing cleanup patches.

(And of course, sometimes the checkpatch rules change over time --- at
one point, checkpatch would warn if *any* line was longer than 80
characters, and so there were tons and tons of trivial cleanups to
"fix" this, including breaking up strings.  When enough people
complained that this actually made it harder to find kernel messages
that got split, checkpatch changed to complain when strings were split
across lines, and more trivial patches got sent out undoing previous
trivial patches.  And this caused all of the same downsides of
breaking automated stable backports, *twice*.  As such, newbies are
strongly encouraged to restrict their checkpatch cleanups to the
staging tree, since when such cleanup patches are considered welcome
very much depends on the kernel subsystem and the maintainers
involved.)

Cheers,

						- Ted
