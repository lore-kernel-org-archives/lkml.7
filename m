Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368C0C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164C521841
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfGXQRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:17:37 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40674 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbfGXQRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:17:37 -0400
Received: by mail-oi1-f196.google.com with SMTP id w196so14100661oie.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 09:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5IbouPeb+7HfRursxOx2UKgv+yR+yHqFG70l+YmYjuE=;
        b=S7zcAc+f9b417eohHPfm//8kk7zzB4uoXDMAfMqlYcXSiKP164dQwQP/5mHUq5idN1
         yt1baL6mjDP6otV1hH4IalRVulYFviB6e89TdLmOFG2T392zTuuQeCNbV8XrBdd3QxEx
         cj590mTlaD0g+qQ8HTmUGDgH8RAi9lzIxpF0pxHfSoxOU4Zdo0yRitcGR8OxIoxebTAi
         Ob/5AGWZ3Dj2tpCJy5OH3A0a1+0X9MHrQYLEKIicDVXYsLk01R8Fth2SpxxODKi18w7p
         G4PHzgTTAPFHSFQ5GYfnIisZC/SLYFStSUI5CXm6VcnaN/YgoJf4GotFS4/gtHz+EfRl
         jrBw==
X-Gm-Message-State: APjAAAUKqaWXZK5CD5NdYj4ebx/FaqdZgfgHnzM3/4/nw4LXLpI8dZG9
        WPDMvC1YchjGEChe66JHae1NvZkKg3TyTaopcOu75w==
X-Google-Smtp-Source: APXvYqyE0yBH1VD25VM7IVPkkwvYgKvqlMt4PLcQpZA64vAsr+tIlLbieTu94VOj0YIC8J9BVSxYD4KsZheoVpUwems=
X-Received: by 2002:aca:1c02:: with SMTP id c2mr42243691oic.166.1563985056283;
 Wed, 24 Jul 2019 09:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190722113151.1584-1-nitin.r.gote@intel.com> <CAFqZXNs5vdQwoy2k=_XLiGRdyZCL=n8as6aL01Dw-U62amFREA@mail.gmail.com>
 <CAG48ez3zRoB7awMdb-koKYJyfP9WifTLevxLxLHioLhH=itZ-A@mail.gmail.com>
In-Reply-To: <CAG48ez3zRoB7awMdb-koKYJyfP9WifTLevxLxLHioLhH=itZ-A@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 24 Jul 2019 18:17:27 +0200
Message-ID: <CAFqZXNuhRratpxMke=T4ZXW8e4WLit932iLWb6dR3w9-BYU9Kg@mail.gmail.com>
Subject: Re: [PATCH] selinux: convert struct sidtab count to refcount_t
To:     Jann Horn <jannh@google.com>
Cc:     NitinGote <nitin.r.gote@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 4:54 PM Jann Horn <jannh@google.com> wrote:
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

Oh yes, I had a hunch that there would be a better way to do it... I
should have taken the time to read the documentation carefully :)

I am on PTO today, but I will be happy to send a patch to convert the
atomic_t usage to the smp_load_acquire()/smp_store_release() helpers
tomorrow. It will also allow us to just use u32 directly and to get
rid of the ugly casts and the INT_MAX limit.

Thanks a lot for the hint, Jann!

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
