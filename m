Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EB8C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720512184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566925776;
	bh=Nrwl1ADYbWkW2k7rd5YL6tq23uKcWAARjfK77AYdRFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w7i1yKbEpNOPsuUJMcUA581K9TaZ4bZ4nLZpdal7sxjZq5z9E7XFND00pprgRF+IU
	 xhqUQuvTGSR0eCXQtlHPVVTCRYh19NNIOiUD+Jj6xP97wpCTJqqCb0+0ShAcmqyub2
	 lMseFZsDB7BqzCwGAaciHhv0bltNz3qIs6cF7zDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbfH0RJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 13:09:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfH0RJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:09:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 360FE214DA;
        Tue, 27 Aug 2019 17:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566925773;
        bh=Nrwl1ADYbWkW2k7rd5YL6tq23uKcWAARjfK77AYdRFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DRDBGeBEiAx9zbtasYS9m8iabi3FKP9tDLbgpPS0vHu7HiCyzdjDot8jxo3g9Nnbi
         gzhYcrztPyFL7EX/PLN5/Ox8L1Q+P7aHKFE2TVEnVCKCLz2qrqrxBZpiIZ3uLUl39c
         69EouWhg0dBDh9ZMx22/BrKySA+OSDQ+k5icff5U=
Date:   Tue, 27 Aug 2019 19:09:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Debian kernel maintainers <debian-kernel@lists.debian.org>
Subject: Re: a bug in genksysms/CONFIG_MODVERSIONS w/ __attribute__((foo))?
Message-ID: <20190827170931.GA26908@kroah.com>
References: <CAKwvOdnJAApaUhTQs7w_VjSeYBQa0c-TNxRB4xPLi0Y0sOQMMQ@mail.gmail.com>
 <CAKwvOdkbY_XatVfRbZQ88p=nnrahZbvdjJ0OkU9m73G89_LRzg@mail.gmail.com>
 <1566899033.o5acyopsar.astroid@bobo.none>
 <CAK7LNARHacanVT6XjRDkFJDETWX6qHfUJCFhskCVG6aDL-bt1g@mail.gmail.com>
 <1566908344.dio7j9zb2h.astroid@bobo.none>
 <daacccf8e36132b6a747fa4b42626a8812906eaa.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daacccf8e36132b6a747fa4b42626a8812906eaa.camel@decadent.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 04:34:15PM +0100, Ben Hutchings wrote:
> On Tue, 2019-08-27 at 22:42 +1000, Nicholas Piggin wrote:
> > Masahiro Yamada's on August 27, 2019 8:49 pm:
> > > Hi.
> > > 
> > > On Tue, Aug 27, 2019 at 6:59 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> > > > Nick Desaulniers's on August 27, 2019 8:57 am:
> > > > > On Mon, Aug 26, 2019 at 2:22 PM Nick Desaulniers
> > > > > <ndesaulniers@google.com> wrote:
> > > > > > I'm looking into a linkage failure for one of our device kernels, and
> > > > > > it seems that genksyms isn't producing a hash value correctly for
> > > > > > aggregate definitions that contain __attribute__s like
> > > > > > __attribute__((packed)).
> > > > > > 
> > > > > > Example:
> > > > > > $ echo 'struct foo { int bar; };' | ./scripts/genksyms/genksyms -d
> > > > > > Defn for struct foo == <struct foo { int bar ; } >
> > > > > > Hash table occupancy 1/4096 = 0.000244141
> > > > > > $ echo 'struct __attribute__((packed)) foo { int bar; };' |
> > > > > > ./scripts/genksyms/genksyms -d
> > > > > > Hash table occupancy 0/4096 = 0
> > > > > > 
> > > > > > I assume the __attribute__ part isn't being parsed correctly (looks
> > > > > > like genksyms is a lex/yacc based C parser).
> > > > > > 
> > > > > > The issue we have in our out of tree driver (*sadface*) is basically a
> > > > > > EXPORT_SYMBOL'd function whose signature contains a packed struct.
> > > > > > 
> > > > > > Theoretically, there should be nothing wrong with exporting a function
> > > > > > that requires packed structs, and this is just a bug in the lex/yacc
> > > > > > based parser, right?  I assume that not having CONFIG_MODVERSIONS
> > > > > > coverage of packed structs in particular could lead to potentially
> > > > > > not-fun bugs?  Or is using packed structs in exported function symbols
> > > > > > with CONFIG_MODVERSIONS forbidden in some documentation somewhere I
> > > > > > missed?
> > > > > 
> > > > > Ah, looks like I'm late to the party:
> > > > > https://lwn.net/Articles/707520/
> > > > 
> > > > Yeah, would be nice to do something about this.
> > > 
> > > modversions is ugly, so it would be great if we could dump it.
> > > 
> > > > IIRC (without re-reading it all), in theory distros would be okay
> > > > without modversions if they could just provide their own explicit
> > > > versioning. They take care about ABIs, so they can version things
> > > > carefully if they had to change.
> 
> Debian doesn't currently have any other way of detecting ABI changes
> (other than eyeballing diffs).
> 
> I know there have been proposals of using libabigail for this instead,
> but I'm not sure how far those progressed.

Google has started using libabigail to track api changes in AOSP, here's
a patch that updates the ABI file after changing it:
	https://android-review.googlesource.com/c/kernel/common/+/1108662

Note, there are issues with it, and some rough edges, but I think it can
work.

But, it means nothing at module load time, this is only at build-check
time.  At least modversions would prevent module loading in some cases.

thanks,

greg k-h
