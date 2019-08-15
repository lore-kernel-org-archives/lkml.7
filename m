Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470ABC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E46B20644
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbfHOWzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 18:55:44 -0400
Received: from smtprelay0173.hostedemail.com ([216.40.44.173]:52055 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730124AbfHOWzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 18:55:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 22CA2100E86C3;
        Thu, 15 Aug 2019 22:55:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: jail27_6bd326141ea25
X-Filterd-Recvd-Size: 2556
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu, 15 Aug 2019 22:55:40 +0000 (UTC)
Message-ID: <29743c8d0a5e5f4a1ead55bc614ed53079a42597.camel@perches.com>
Subject: Re: [PATCH] afs: Move comments after /* fallthrough */
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     David Howells <dhowells@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nathan Huckleberry <nhuck@google.com>,
        linux-afs@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 15 Aug 2019 15:55:39 -0700
In-Reply-To: <CAKwvOdmuReaFgFK+=aib6rRfAb_GTGubLyJ3sAH-tnkKYHASqQ@mail.gmail.com>
References: <e77b0f32a2ce97c872eede52c88b84aa78094ae5.1565836130.git.joe@perches.com>
         <CAKwvOdmuReaFgFK+=aib6rRfAb_GTGubLyJ3sAH-tnkKYHASqQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-15 at 15:34 -0700, Nick Desaulniers wrote:
> On Wed, Aug 14, 2019 at 7:36 PM Joe Perches <joe@perches.com> wrote:
> > Make the code a bit easier for a script to appropriately convert
> > case statement blocks with /* fallthrough */ comments to a macro by
> > moving comments describing the next case block to the case statement.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  fs/afs/cmservice.c | 10 +++-------
> >  fs/afs/fsclient.c  | 51 +++++++++++++++++----------------------------------
> >  fs/afs/vlclient.c  | 50 +++++++++++++++++++++++++-------------------------
> >  fs/afs/yfsclient.c | 51 +++++++++++++++++----------------------------------
> 
> So these changes are across just fs/afs, how many patches like this
> would you need across the whole tree to solve this problem?

No idea.  I only looked at afs when Nathan Chancellor showed
there were 350 or so changes necessary in the kernel tree.
The afs entries were 50 of them so I just looked and saw why.

I haven't looked at all the others.

https://gist.github.com/nathanchance/ffbd71b48ba197837e1bdd9bb863b85f

But probably most of the others are missing a fallthrough to
a break like:

	switch {foo} {
	case 1:
		<bar>;
	default:
		break;
	}

where gcc does not emit a warning but clang apparently does.

I do think gcc should emit a warning here too so I filed a
gcc bugzilla entry.

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91432


