Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDCDC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033A422387
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dAZim43y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392389AbfGWWRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 18:17:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37255 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392359AbfGWWRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 18:17:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id i70so9356780pgd.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 15:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1tRj12XMgs1Y3+O1rqUEapdlbt8lWOQ+IFc7/KZfXPw=;
        b=dAZim43y7Eol9vmjAIB8BeRHMVgrkO1k/3/F/JV1WYKVM9LWLARy0MvDlAwVL63Flo
         MlOPIFFQgonzgSA3mtZL/G9iRF2G47QTYenotSsBUZCEI8uwAit9C+Rif4ZqFQQPdnUY
         8TdVLpPwlPoValbGfPqM1x5pMpvQFl+7gOoEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1tRj12XMgs1Y3+O1rqUEapdlbt8lWOQ+IFc7/KZfXPw=;
        b=gPQgG7INKdTbGmsyYN0A0D1PhJwu/rHC+q2Fa1NT7ix1n3CGcLF1eM1iVwUBsa5eA6
         Rcl/jl1u+acKFN3Sfxd2fxw6yJjd/asTug5nUpA6RJoBhlOtv+vLEbaeNeLybA+0y9uy
         Zve3CmO2HKeDxyv0Bztrx0WYHG3wX5QKeQ/Qs8SDs+4FpduV3RdIrtTTgbCrxMtU0d3Q
         7r2iJ1R93JWOcT9L63hr+UjD6lfGNRdHQ0bCMnXH/GdPkFjjuHdXB6+eyliBnewe2ICm
         ewy3YyC+8qmRq0JC4cQ0XLTXvw74hKmdwvtFCLxDTK8+NPUssssRNaOl3OJ9o1voaLfW
         P+ww==
X-Gm-Message-State: APjAAAXDYIx2D/+Xgj3fKOwdCOF0CssmSGi8ilkpSPPhQf68Sy+sjWfu
        E2pJLNn7H2py5UWq5dj5kjdJh53jU0w=
X-Google-Smtp-Source: APXvYqxKDpqoSQmoMeWiZyozdu8jr1jHK0awjq6kY6EUyZIN/fJ86cWjhWRbVYlYok3Jw6Y0JckOvA==
X-Received: by 2002:a63:5452:: with SMTP id e18mr62112901pgm.232.1563920271498;
        Tue, 23 Jul 2019 15:17:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r9sm25569080pjq.3.2019.07.23.15.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 15:17:50 -0700 (PDT)
Date:   Tue, 23 Jul 2019 15:17:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        NitinGote <nitin.r.gote@intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selinux: convert struct sidtab count to refcount_t
Message-ID: <201907231516.11DB47AA@keescook>
References: <20190722113151.1584-1-nitin.r.gote@intel.com>
 <CAFqZXNs5vdQwoy2k=_XLiGRdyZCL=n8as6aL01Dw-U62amFREA@mail.gmail.com>
 <CAG48ez3zRoB7awMdb-koKYJyfP9WifTLevxLxLHioLhH=itZ-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3zRoB7awMdb-koKYJyfP9WifTLevxLxLHioLhH=itZ-A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 04:53:47PM +0200, Jann Horn wrote:
> On Mon, Jul 22, 2019 at 3:44 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Mon, Jul 22, 2019 at 1:35 PM NitinGote <nitin.r.gote@intel.com> wrote:
> > > refcount_t type and corresponding API should be
> > > used instead of atomic_t when the variable is used as
> > > a reference counter. This allows to avoid accidental
> > > refcounter overflows that might lead to use-after-free
> > > situations.
> > >
> > > Signed-off-by: NitinGote <nitin.r.gote@intel.com>
> >
> > Nack.
> >
> > The 'count' variable is not used as a reference counter here. It
> > tracks the number of entries in sidtab, which is a very specific
> > lookup table that can only grow (the count never decreases). I only
> > made it atomic because the variable is read outside of the sidtab's
> > spin lock and thus the reads and writes to it need to be guaranteed to
> > be atomic. The counter is only updated under the spin lock, so
> > insertions do not race with each other.
> 
> Probably shouldn't even be atomic_t... quoting Documentation/atomic_t.txt:
> 
> | SEMANTICS
> | ---------
> |
> | Non-RMW ops:
> |
> | The non-RMW ops are (typically) regular LOADs and STOREs and are canonically
> | implemented using READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and
> | smp_store_release() respectively. Therefore, if you find yourself only using
> | the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
> | and are doing it wrong.
> 
> So I think what you actually want here is a plain "int count", and then:
>  - for unlocked reads, either READ_ONCE()+smp_rmb() or smp_load_acquire()
>  - for writes, either smp_wmb()+WRITE_ONCE() or smp_store_release()
> 
> smp_load_acquire() and smp_store_release() are probably the nicest
> here, since they are semantically clearer than smp_rmb()/smp_wmb().

Perhaps we need a "statistics" counter type for these kinds of counters?
"counter_t"? I bet there are a lot of atomic_t uses that are just trying
to be counters. (likely most of atomic_t that isn't now refcount_t ...)

-- 
Kees Cook
