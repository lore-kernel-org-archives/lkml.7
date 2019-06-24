Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493C6C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E42C208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370522;
	bh=amAPfe8nFBVpmTr8hMxl5t1uBr6QIyXhovJtfP9avOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rat/JkvB+6CVtv5l11RhKrV6l16uGapiTUUlsHrbtVtK/vFfYB+B6jzc+QWJeQqZk
	 iIntDeLBY3DbgCN3wQhPogaiemV/g8u8sYo/jHpAFgLVyqKxUb6/UgVObRBavWOT6K
	 RfVs/f+/ZSMWzFJ54Hm5hKzOoHPBU00q6hhyAQTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfFXKCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728881AbfFXJ55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:57:57 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E245D21530;
        Mon, 24 Jun 2019 09:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370276;
        bh=amAPfe8nFBVpmTr8hMxl5t1uBr6QIyXhovJtfP9avOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PH8NPjKFKqV2/Ouf0NiSDD/uMJNA49llccgFqiKtinldirSIcTlW8GeD7XDGvb6Sn
         Aq/DDm+3wsjcEQD2fmh+hcwrcF6RYoZHw58Ud0RYLFcASrkTuW5R0oBNlPZ7vM0+p7
         PuIYwfmfJ1im8epbd6fhZR4K/jkujtC2q43vUgCg=
Date:   Mon, 24 Jun 2019 10:57:50 +0100
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: defconfig: update and enable CONFIG_RANDOMIZE_BASE
Message-ID: <20190624095749.wasjfrgcda7ygdr5@willie-the-truck>
References: <20190620003244.261595-1-ndesaulniers@google.com>
 <20190620074640.GA27228@brain-police>
 <CAKv+Gu_KCFCVxw_zAfzUf8DjD4DmhvaJEoqBsX_SigOse_NwYw@mail.gmail.com>
 <CAKwvOdmQ+WdD8nvLz_VB_5atDi56fv485Xsn+mHJZKnyj6L-JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmQ+WdD8nvLz_VB_5atDi56fv485Xsn+mHJZKnyj6L-JA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick, Kees, Ard,

Thanks for the responses.

On Fri, Jun 21, 2019 at 01:27:45PM -0700, Nick Desaulniers wrote:
> On Thu, Jun 20, 2019 at 1:17 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> > On Thu, 20 Jun 2019 at 09:47, Will Deacon <will.deacon@arm.com> wrote:
> > > On the flip side, I worry that it could make debugging more difficult, but I
> > > don't know whether that's a genuine concern or not. I'm assuming you've
> > > debugged your fair share of crashes from KASLR-enabled kernels; how bad is
> > > it? (I'm thinking of the case where somebody mails you part of a panic log
> > > and a .config).
> 
> I don't recall specific cases where KASLR made debugging difficult.  I
> went and spoke to our stability team that debugs crash reports from
> the field.  My understanding is that we capture full ramdumps.  They
> have a lot of custom tooling for debugging, but they did not recall
> ever having to disable KASLR to debug further.  We've had KASLR
> enabled since I think the 2016 Pixel 1, so I assume their tooling
> accounts for the seed/offset.
> 
> I think if a full ramdump of the kernel image is loaded into GDB with
> the matching kernel image it "just works" but could be mistaken.  For
> external developers, "nokaslr" boot time param is pretty standard.
> 
> > In fact, given how many Android phones are running this code: Nick,
> > can you check if there are any KASLR related kernel fixes that haven't
> > been upstreamed?
> 
> I spoke with the android common kernel team that's trying to burn down
> their out of tree patches.  I triple checked a doc they had where they
> had audited every last patch, looking for for KASLR and
> CONFIG_RANDOMIZE_BASE.  I also triple checked our internal bug tracker
> for burning down the out of tree patches.  Finally I'm scanning each
> branch of our android-common trees via `git log --all --grep
> <KASLR|CONFIG_RANDOMIZE_BASE>`.  I haven't found anything yet, and the
> team doesn't expect any out of tree patches related to that feature.
> Sorry for not responding sooner, but I'm still going through our 4.4,
> 4.9, 4.14, and 4.19 branches.

Thanks for having a look. It could be that we've fixed the issue Catalin was
running into in the past -- he was going to see if the problem persists with
mainline, since it was frequent enough that it was causing us to ignore the
results from our testing infrastructure when RANDOMIZE_BASE=y.

> > So KASLR is known to be broken unless you enable KPTI as well, so that
> > is something we could take into account. I.e., mitigations that don't
> > reduce the attack surface at all are just pointless complexity, which
> > should obviously be avoided.
> 
> (Note to Sami + Jeff if they had KPTI on their radar)

I mean, we could have RANDOMIZE_BASE select UNMAP_KERNEL_AT_EL0 if you like?
The latter is already default y and hidden behind EXPERT.

> > Another thing to note is that the runtime cost of KASLR is ~zero, with
> > the exception of the module PLTs. However, the latter could do with
> > some additional coverage as well, so in summary, I think enabling this
> > is a good thing. Otherwise, we could disable full module randomization
> > so that the module PLT code doesn't get used in practice.
> >
> > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> Olof mentioned on IRC that I should resend without the other defconfig
> changes.  Do others have thoughts on that?

That's not a bad idea. If you do that, feel free to add my Ack to the one
adding RANDOMIZE_BASE=y:

Acked-by: Will Deacon <will@kernel.org>

Will
