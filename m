Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF5BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAE720851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfCHSHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:07:45 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34804 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726761AbfCHSHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:07:44 -0500
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Mar 2019 13:07:43 EST
Received: from callcc.thunk.org (guestnat-104-133-0-99.corp.google.com [104.133.0.99] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x28Hv3FX015389
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Mar 2019 12:57:04 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 93461423702; Fri,  8 Mar 2019 12:57:03 -0500 (EST)
Date:   Fri, 8 Mar 2019 12:57:03 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, apw@canonical.com, joe@perches.com,
        linux-kbuild@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: Debian build polishing
Message-ID: <20190308175703.GA7178@lambda>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, apw@canonical.com, joe@perches.com,
        linux-kbuild@vger.kernel.org, linux-riscv@lists.infradead.org
References: <1552049064-32044-1-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552049064-32044-1-git-send-email-info@metux.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 01:44:19PM +0100, Enrico Weigelt, metux IT consult wrote:
> One point still puzzling me: once the debian/rules is applied and
> somebody calls `make deb-pkg`, he'll end up w/ unclean tree, as
> now a git-tracked file is changed.

This is not something I've noticed, but I build my Debian packages
like this:

make O=/build/linux-build bindeb-pkg

This works really well for me, since all of the build-artificats land
in /build, and I can use a HDD (or a PD-HDD when building using Google
Compute Engine) for /build, while I use a SSD for my source tree.  I
find that using a HDD for a target of a build doesn't really slow
things down, and this allows me to save $$$ (when using a Cloud VM)
and reduce flash wearout and capital cost (on my personal machines).

So I really hope your patches don't break this.  Also, are there any
changes the performance of building the Debian packages before and
after your changes?  And are there any differences in the packages in
terms of any pre-or-post install/removal scripts?

There are a lot of things I really dislike about the "official" Debian
kernel build processes (they're optimzied for distribution release
engineers, not kernel developers), so I'm really hoping that making
things more like the "official Debian way" doesn't break some of the
things I really like about the existing "make bindeb-pkg" build
system.

Cheers,

						- Ted
