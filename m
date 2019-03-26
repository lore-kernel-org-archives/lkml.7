Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5109BC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB2E2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553628152;
	bh=TEBNw7TiawxkZvyrCzIPpSy5Hct8IdJe9+97XBQEcjI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XNerJJ4DtdCq4SBBAbjyaNtCdkPqotj/kULAj2OW25D38djccfth5f5fXsk3lBMzR
	 NMrLFxPRx1Bx5Ob6uFODDpHpghmYyOH3o6SZKv9unqTZ+ubZjyq31gJqvb1dhs3I9b
	 rTHl5x7w2P/yIGT5iIyej73P0sy1/Q+sAb+fpQfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbfCZTWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:22:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732230AbfCZTWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 15:22:30 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2014A20823
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553628149;
        bh=TEBNw7TiawxkZvyrCzIPpSy5Hct8IdJe9+97XBQEcjI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yXSujwgKXCG0x9NxMCv9CanO+xoDJpZVWENNAQOFqFaKCuUfQr7O4+YEWqVr0PVuK
         sWab4rtOMLRjAi+eRgF3zIDgzvfmTchgorJLOZjxaagrAgnWbs4IfDdL3HVwJKhOtW
         cZ3/6bqNYgsR5Dt4UQUbtTk6QjRRRFXBw8E7Wrjo=
Received: by mail-wr1-f44.google.com with SMTP id g3so12254190wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 12:22:29 -0700 (PDT)
X-Gm-Message-State: APjAAAU5/BfGeINMvKxvrmsOYHBI3JwzKtVF9Xve10R7fKo+vzio+eHb
        xYd3aD2IDLzw/4gUiSKQyNUkE5pWg8aPeBwpXc9jig==
X-Google-Smtp-Source: APXvYqz6qQn4tdlnd+9IIQn4uhajoJQO7lunAFxi8D0JlRkCJGpkajiezU/sOokacme974yx0V5OpqpctbUi7Mn4Fa4=
X-Received: by 2002:adf:f011:: with SMTP id j17mr18511809wro.330.1553628147761;
 Tue, 26 Mar 2019 12:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
 <20190325220954.29054-24-matthewgarrett@google.com> <20190325164221.5d8687bd@shemminger-XPS-13-9360>
 <CALCETrU=EqqRwyQGBT0=_N9-E_pBM53=z+WJrd9OzV7g6xJa0A@mail.gmail.com> <alpine.LRH.2.21.1903270523240.5235@namei.org>
In-Reply-To: <alpine.LRH.2.21.1903270523240.5235@namei.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 26 Mar 2019 12:22:17 -0700
X-Gmail-Original-Message-ID: <CALCETrUZ+oP0xxNt4mwN=AZA+zvkkfPZiAsFmAuqUD48pOHbBg@mail.gmail.com>
Message-ID: <CALCETrUZ+oP0xxNt4mwN=AZA+zvkkfPZiAsFmAuqUD48pOHbBg@mail.gmail.com>
Subject: Re: [PATCH 23/27] bpf: Restrict kernel image access functions when
 the kernel is locked down
To:     James Morris <jmorris@namei.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 11:57 AM James Morris <jmorris@namei.org> wrote:
>
> On Mon, 25 Mar 2019, Andy Lutomirski wrote:
>
> > A while back, I suggested an approach to actually make this stuff
> > mergeable: submit a patch series that adds lockdown mode, enables it
> > by command line option (and maybe sysctl) *only* and has either no
> > effect or only a token effect.  Then we can add actual features to
> > lockdown mode one at a time and review them separately.
>
> This makes sense to me.
>
> >
> > And I'm going to complain loudly unless two things change about this
> > whole thing:
> >
> > 1. Lockdown mode becomes three states, not a boolean.  The states are:
> > no lockdown, best-effort-to-protect-kernel-integrity, and
> > best-effort-to-protect-kernel-secrecy-and-integrity.  And this BPF
> > mess illustrates why: most users will really strongly object to
> > turning off BPF when they actually just want to protect kernel
> > integrity.  And as far as I know, things like Secure Boot policy will
> > mostly care about integrity, not secrecy, and tracing and such should
> > work on a normal locked-down kernel.  So I think we need this knob.
>
> Another approach would be to make this entirely policy based:
>
> - Assign an ID to each lockdown point
> - Implement a policy mechanism where each ID is mapped to 0 or 1
> - Allow this policy to be specified statically or dynamically
>
> So,
>
>         kernel_is_locked_down("ioperm")
>
> becomes
>
>         kernel_is_locked_down(LOCKDOWN_IOPERM)
>
> and this function checks e.g.
>
>         if (lockdown_polcy[id]) {
>                 fail or warn;
>         }
>
> Thoughts?

I'm concerned that this gives too much useless flexibility to
administrators and user code in general.  If you can break kernel
integrity, you can break kernel integrity -- it shouldn't really
matter *how* you break it.

--Andy
