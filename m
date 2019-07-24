Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27427C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FF0217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hqv8AC23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbfGXO3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:29:00 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33856 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfGXO27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:28:59 -0400
Received: by mail-oi1-f195.google.com with SMTP id l12so35173178oil.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 07:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=07WBpiUlOYIZ7+P49JY1jjRjsEVdVyLwuxczlg4O6CI=;
        b=Hqv8AC23ggzMBGj+XNz87q/bwhtAZqBW9K01CFg1Ke4/U1wAGhKmppexKCc4EGZOyl
         KrTl6bgaWESUyaEOsfnVY1iFH3FefGe2ETp/hGkkAdl3KKTge7AhOe+NAXu6IwCsvfR6
         beRC9TM/51Cg2MPPRud6dSvT0IKTOFQha/L7UIs1hoB7whP7edTHVyTP6mVie6n/R6Kh
         YA+NmOmL5PyVoli5LE8MRCrmBDkOjgYnZcy5rHDoGoc9grpRKF8HOLj5QGncs2JshFZo
         m9vTH0j8dZ47bJeb/1sn59Q6cmVatCE7m+8hwbuPCkLIyKRIVTtoGquFd4SZtWThYaMF
         223w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=07WBpiUlOYIZ7+P49JY1jjRjsEVdVyLwuxczlg4O6CI=;
        b=grhb9+0OWlF0kXIYluY7fgyDjE2p0ynrF3df6xvDFcbs/2J00rBjD8bD9HptSa602R
         I/ye4x7ZttvTKL2d+myHHNBavTD/APiJ5rQTFDHnhd1QxSPkoAsI3rfJQAyMlaNiCX8b
         8jyBdkyN1di9yNNlGEwW1O0IbvflzhNkg8GUm6ckG0hj/TEmCQkwbV2W1NaU0ZgFAuh7
         RNsrgwXmrZpuGhW/d3GJwnWOeWl/LhWd/Goa2dqN/6mCL1ohZKkR/zjysgFQiLUKW5II
         2iEkZoEumN7K5IMrsid7NvnD1YDOjGhkcWTC6HNrgKGH2Rrx2CxUE+OX3S2lfq+OrQbE
         Ytrw==
X-Gm-Message-State: APjAAAX09bHtECVvZec0j4ZC7zHDa9poI6bcAf/nxwefW4+lPHWR3XAJ
        44HVAar4QYEgaPOYTW4Fcw6RaSHB4ehKX+0hYl8sPA==
X-Google-Smtp-Source: APXvYqzqMTdf8CPoruUPhw4URkBpdrabgibucjn8aLFByJaBJKYxxZjQtyWMUVa0kX6ewYeRZEUPdgw0udWGwYfMCyA=
X-Received: by 2002:aca:3dd7:: with SMTP id k206mr37007062oia.47.1563978537976;
 Wed, 24 Jul 2019 07:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190722113151.1584-1-nitin.r.gote@intel.com> <CAFqZXNs5vdQwoy2k=_XLiGRdyZCL=n8as6aL01Dw-U62amFREA@mail.gmail.com>
 <CAG48ez3zRoB7awMdb-koKYJyfP9WifTLevxLxLHioLhH=itZ-A@mail.gmail.com> <201907231516.11DB47AA@keescook>
In-Reply-To: <201907231516.11DB47AA@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 24 Jul 2019 16:28:31 +0200
Message-ID: <CAG48ez2eXJwE+vS2_ahR9Vuc3qD8O4CDZ5Lh6DcrrOq+7VKOYQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: convert struct sidtab count to refcount_t
To:     Kees Cook <keescook@chromium.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        NitinGote <nitin.r.gote@intel.com>,
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

On Wed, Jul 24, 2019 at 12:17 AM Kees Cook <keescook@chromium.org> wrote:
> On Tue, Jul 23, 2019 at 04:53:47PM +0200, Jann Horn wrote:
> > On Mon, Jul 22, 2019 at 3:44 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > On Mon, Jul 22, 2019 at 1:35 PM NitinGote <nitin.r.gote@intel.com> wrote:
> > > > refcount_t type and corresponding API should be
> > > > used instead of atomic_t when the variable is used as
> > > > a reference counter. This allows to avoid accidental
> > > > refcounter overflows that might lead to use-after-free
> > > > situations.
> > > >
> > > > Signed-off-by: NitinGote <nitin.r.gote@intel.com>
> > >
> > > Nack.
> > >
> > > The 'count' variable is not used as a reference counter here. It
> > > tracks the number of entries in sidtab, which is a very specific
> > > lookup table that can only grow (the count never decreases). I only
> > > made it atomic because the variable is read outside of the sidtab's
> > > spin lock and thus the reads and writes to it need to be guaranteed to
> > > be atomic. The counter is only updated under the spin lock, so
> > > insertions do not race with each other.
> >
> > Probably shouldn't even be atomic_t... quoting Documentation/atomic_t.txt:
> >
> > | SEMANTICS
> > | ---------
> > |
> > | Non-RMW ops:
> > |
> > | The non-RMW ops are (typically) regular LOADs and STOREs and are canonically
> > | implemented using READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and
> > | smp_store_release() respectively. Therefore, if you find yourself only using
> > | the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
> > | and are doing it wrong.
> >
> > So I think what you actually want here is a plain "int count", and then:
> >  - for unlocked reads, either READ_ONCE()+smp_rmb() or smp_load_acquire()
> >  - for writes, either smp_wmb()+WRITE_ONCE() or smp_store_release()
> >
> > smp_load_acquire() and smp_store_release() are probably the nicest
> > here, since they are semantically clearer than smp_rmb()/smp_wmb().
>
> Perhaps we need a "statistics" counter type for these kinds of counters?
> "counter_t"? I bet there are a lot of atomic_t uses that are just trying
> to be counters. (likely most of atomic_t that isn't now refcount_t ...)

This isn't a statistics counter though; this thing needs ordered
memory accesses, which you wouldn't need for statistics.
