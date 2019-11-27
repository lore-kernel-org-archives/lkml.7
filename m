Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07622C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF31F206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="jr9gJxmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfK0RNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:13:35 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44687 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfK0RNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:13:35 -0500
Received: by mail-ed1-f67.google.com with SMTP id a67so20268330edf.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 09:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=avbwI72EZ/UijnuZGSSoSC9YggMOVPWaFwJMxK6riZw=;
        b=jr9gJxmSQPb7Bj1DBwRNdZPRhmzt3zcOh776U79Aj1KoLk7VZjrppm/SOMSRGGbp5c
         p1XaJcFjws7wmiP8QdJXjCiKeXZGkBx4jqSfuNjk5XWpbS8/pLt2/OypTPnZpRW7rML2
         SsgFG2+xx28j8f42EQAh/yBk/leVmiClheJEXQA152z+RA0QBTn9Z+5nZhUpB39bm/dd
         FjqiQL/thqEGbY0p3Kd2yPu6WIFj5H7/da+9liGtltzOiOYT7fDTuHbpx/G6sgSNhaSX
         PdxJT7++0nqLEnbqtEwa3p5MEx0MITdbEXJb6AYy/l1nrbAT/LidVBkuD1XiPYJO9HIs
         eOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=avbwI72EZ/UijnuZGSSoSC9YggMOVPWaFwJMxK6riZw=;
        b=d0rO6UU1/jsfND6PKx4nM3/LhC6AVRsmaumvQ2pT/1j+RdnCWZ0087cHWYx/+TIOiM
         0tPP+P5h941qkIBUnTmBZRvhjxTR6gA6aRsPInnu/udnTx719sIxum+hwqAc5jq1o+XZ
         5daxH4BJThUez2vVpnITrordqMOreTi/vLctnUfvo0VTuqnlmNyJMWeCCR81E2PRQ2tz
         fdfAFNGHVuHFnHLpIE9V2N7/3cZ95bNwIAS57ag4Lwgc9J3xxvlBhemZIh/MuWploU76
         HHtQ55g697BC56ZNt+o/YR9t5RMRGmCsibRc+9EmLwCo9q9yH0FHjrbarYnvJGKrJg1F
         yekg==
X-Gm-Message-State: APjAAAVxDOnYVXGO+l1hjL1+JEIzkC8sfCztywgMh38pcPNQJ/PhjWf7
        p1INRl5xsuPg38DYo2yViOtgy90reXzpOoJNWPiuvw==
X-Google-Smtp-Source: APXvYqyZqD0tAbB7ilB8c3qt9BESX6KvcTNCcWyh8K0d4RwfSXJa3D/ae359IAhZ5F4Vw7HUXyFo+QE2ejNz+5zwlYs=
X-Received: by 2002:a17:906:a2d0:: with SMTP id by16mr1819282ejb.322.1574874813251;
 Wed, 27 Nov 2019 09:13:33 -0800 (PST)
MIME-Version: 1.0
References: <20191122022406.590141-1-pasha.tatashin@soleen.com>
 <20191122022406.590141-4-pasha.tatashin@soleen.com> <20191127151154.GC51937@lakrids.cambridge.arm.com>
 <CA+CK2bDDom_pwLC-ABwDw66ynyELH3f3NdjUEdhr1LYLkgWJvg@mail.gmail.com>
 <20191127160342.GF51937@lakrids.cambridge.arm.com> <CA+CK2bBszdMYbneQ1UiYxSndN8zmoVwbTVJ20NeajYPehT_X5Q@mail.gmail.com>
 <20191127170148.GG51937@lakrids.cambridge.arm.com>
In-Reply-To: <20191127170148.GG51937@lakrids.cambridge.arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 27 Nov 2019 12:13:22 -0500
Message-ID: <CA+CK2bByJJO+0_0H8sDOyWQ-igMvw8pJd_2FR1okX3EAr1r__A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: remove the rest of asm-uaccess.h
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, steve.capper@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        xen-devel@lists.xenproject.org,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 12:01 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Nov 27, 2019 at 11:09:35AM -0500, Pavel Tatashin wrote:
> > On Wed, Nov 27, 2019 at 11:03 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Wed, Nov 27, 2019 at 10:31:54AM -0500, Pavel Tatashin wrote:
> > > > On Wed, Nov 27, 2019 at 10:12 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > > > >
> > > > > On Thu, Nov 21, 2019 at 09:24:06PM -0500, Pavel Tatashin wrote:
> > > > > > The __uaccess_ttbr0_disable and __uaccess_ttbr0_enable,
> > > > > > are the last two macros defined in asm-uaccess.h.
> > > > > >
> > > > > > Replace them with C wrappers and call C functions from
> > > > > > kernel_entry and kernel_exit.
> > > > >
> > > > > For now, please leave those as-is.
> > > > >
> > > > > I don't think we want to have out-of-line C wrappers in the middle of
> > > > > the entry assembly where we don't have a complete kernel environment.
> > > > > The use in entry code can also assume non-preemptibility, while the C
> > > > > functions have to explcitily disable that.
> > > >
> > > > I do not understand, if C function is called form non-preemptible
> > > > context it stays non-preemptible. kernel_exit already may call C
> > > > functions around the time __uaccess_ttbr0_enable is called (it may
> > > > call post_ttbr_update_workaround), and that C functions does not do
> > > > explicit preempt disable:
> > >
> > > Sorry, I meant that IRQs are disabled here.
> > >
> > > The C wrapper calls __uaccess_ttbr0_enable(), which calls
> > > local_irq_save() and local_irq_restore(). Those are pointless in the
> > > bowels of the entry code, and potentially expensive if IRQ prio masking
> > > is in use.
> > >
> > > I'd rather not add more out-of-line C code calls here right now as I'd
> > > prefer to factor out the logic to C in a better way.
> >
> > Ah, yes, this makes sense. I could certainly factor out C calls in a
> > better way, or is this something you want to work on?
>
> I'm hoping to do that as part of ongoing entry-deasm work, now that a
> lot of the prerequisite work was merged in v5.4.

OK, I will send new patches with what we agreed on, and your comments addressed.

>
> > Without removing these assembly macros I do not think we want to
> > address this suggestion from Kees Cook:
> > https://lore.kernel.org/lkml/CA+CK2bCBS2fKOTmTFm13iv3u5TBPwpoCsYeeP352DVE-gs9GJw@mail.gmail.com/
>
> In the mean time, we could add checks around addr_limit_user_check(),
> and in the context-switch path. I have some preparatory cleanup to allow
> for the context-switch check, which I'll send out at -rc1. That was what
> I used to detect the case you reported previously.

Sounds good.

Thank you,
Pasha
