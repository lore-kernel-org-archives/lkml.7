Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26AFC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889A220856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfILWPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 18:15:11 -0400
Received: from smtprelay0199.hostedemail.com ([216.40.44.199]:55312 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726429AbfILWPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 18:15:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 58571181D3368;
        Thu, 12 Sep 2019 22:15:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pin05_49dff1f532f1d
X-Filterd-Recvd-Size: 3395
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Sep 2019 22:15:07 +0000 (UTC)
Message-ID: <2e3b15aea8645f38cea9442a4b6eb95f5b33eec6.camel@perches.com>
Subject: Re: [PATCH 00/13] nvdimm: Use more common kernel coding style
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Thu, 12 Sep 2019 15:15:06 -0700
In-Reply-To: <CANiq72mgbepmw=G5pM7iSRf-Eob7AHFzLw=76uFivpNGtccyKw@mail.gmail.com>
References: <cover.1568256705.git.joe@perches.com>
         <x498sqtvclx.fsf@segfault.boston.devel.redhat.com>
         <CANiq72kTsf=0rEufDMo7BzMNv1dqc5=ws7fSd=H_e=cpHR24Kg@mail.gmail.com>
         <4df0a07ec8f1391acfa987ecef184a50e7831000.camel@perches.com>
         <CANiq72mgbepmw=G5pM7iSRf-Eob7AHFzLw=76uFivpNGtccyKw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-12 at 23:58 +0200, Miguel Ojeda wrote:
> On Thu, Sep 12, 2019 at 11:08 PM Joe Perches <joe@perches.com> wrote:
> > Please name the major projects and then point to their
> > .clang-format equivalents.
> > 
> > Also note the size/scope/complexity of the major projects.
> 
> Mozilla, WebKit, LLVM and Microsoft. They have their style distributed
> with the official clang-format, not sure if they enforce it.
> 
> Same for Chromium/Chrome, but it looks like they indeed enforce it:

thanks for that list.

> > I used the latest one, and quite a bit of the conversion
> > was unpleasant to read.
> 
> It would be good to see particularly bad snippets to see if we can do
> something about them (and, if needed, try to improve clang-format to
> support whatever we need).

As I mentioned earlier, look at the __stringify conversion.
Also the C() blocks.

btw: emacs 'mark-whole-buffer indent-region',
the tool I used for each file in patch 1, also
made a mess of the C() block.

> Did you tweak the parameters with the new ones?

No.  I used

$ clang-format --version
clang-format version 10.0.0 (git://github.com/llvm/llvm-project.git 305b961f64b75e73110e309341535f6d5a48ed72)

and the existing .clang_format from
next-20190904 35394d031b710e832849fca60d0f53b513f0c390

> I am preparing an RFC
> patch for an updated .clang-format configuration that improves quite a
> bit the results w.r.t. to the current one (and allows for some leeway
> on the developer's side, which helps prevent some cases too).

Well, one day no doubt an automated tool will be
more useful for the kernel.  Hope you keep at it
and good luck.

> > Marking sections _no_auto_format_ isn't really a
> > good solution is it?
> 
> I am thinking about special tables that are hand-crafted or very
> complex macros. For those, yes, I think it is a fine solution. That is
> why clang-format has that feature to begin with, and you can see an
> example in Mozilla's style guide which points here:
> 
>   https://github.com/mozilla/gecko-dev/blob/master/xpcom/io/nsEscape.cpp#L22
> 
> Cheers,
> Miguel

