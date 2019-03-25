Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3391EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066AC2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbfCYKsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:48:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45246 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730895AbfCYKsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:48:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D69191596;
        Mon, 25 Mar 2019 03:48:03 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 181E43F575;
        Mon, 25 Mar 2019 03:48:02 -0700 (PDT)
Date:   Mon, 25 Mar 2019 10:47:59 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kbuild: gitignore output directory
Message-ID: <20190325104759.079a18ec@donnerap.cambridge.arm.com>
In-Reply-To: <CAK7LNAT3Yf1_3L77VNjtcr5SP2eM0x19hid0J45PcHqf8Fwcwg@mail.gmail.com>
References: <20190203084840.6113-1-vladimir.kondratiev@intel.com>
        <20190322155212.133029-1-andre.przywara@arm.com>
        <CAK7LNAT3Yf1_3L77VNjtcr5SP2eM0x19hid0J45PcHqf8Fwcwg@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2019 11:22:11 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

Hi Masahiro,

> On Sat, Mar 23, 2019 at 12:53 AM Andre Przywara <andre.przywara@arm.com> wrote:
> >
> > Hi,
> >  
> > > When compiling into output directory using O=, many files
> > > created under KBUILD_OUTPUT that git considers
> > > as new ones; git clients, ex. "git gui" lists it, and it clutters
> > > file list making it difficult to see what was really changed
> > >
> > > Generate .gitignore in output directory that ignores all
> > > its content  
> >
> > just found this when testing -rc1.
> > Unfortunately this breaks my setup, because I keep a totally separate
> > git repository in my build directories to track (various versions of)
> > .config. So .gitignore there is carefully crafted to ignore most build
> > artefacts, but not .config, for instance.
> >
> > I am not sure how git would interact with the build directory for you?
> > Do you build into a subdirectory of the kernel tree?
> >
> > I was hoping that we would not overwrite unrelated files in directories
> > outside of the kernel tree. In case this is about a subdirectory of the
> > source tree, can we somehow check for this case?  
> 
> 
> I am not sure if it is worthwhile
> adjusting the upstream kernel to
> the workflow of an individual like this.

I would argue that we should not overwrite files in the build directory
which are unrelated to the actual kernel *build*.
Another point is that one could easily add the build (sub-)directory
to .git/info/exclude to make git ignore it, without touching any git
monitored file at all. But I couldn't find an easy way to keep
my .gitignore file in place.

> If it is, we could like this:
> 
> outputmakefile:
> ifneq ($(KBUILD_SRC),)
>         $(Q)ln -fsn $(srctree) source
>         $(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree)
>         $(Q)test -e .gitignore || \
>         { echo "# this is build directory, ignore it"; echo "*"; } > .gitignore

Thanks, that looks good and fixes it for me!

Cheers,
Andre.

> endif
> 
> 
> > Cheers,
> > Andre.
> >  
> > >
> > > Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > ---
> > >  Makefile | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 97ee0be24d52..d487fca342c4 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -483,10 +483,13 @@ PHONY += outputmakefile
> > >  # outputmakefile generates a Makefile in the output directory, if using a
> > >  # separate output directory. This allows convenient use of make in the
> > >  # output directory.
> > > +# At the same time when output Makefile generated, generate .gitignore to
> > > +# ignore whole output directory
> > >  outputmakefile:
> > >  ifneq ($(KBUILD_SRC),)
> > >       $(Q)ln -fsn $(srctree) source
> > >       $(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree)
> > > +     $(Q){ echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
> > >  endif
> > >
> > >  ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
> > > --
> > > 2.17.1  
> >  
> 
> 

