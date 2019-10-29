Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8815CCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E47C21479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572368473;
	bh=CEfNBOwII3kRKjNTV1QnlKd06oaG8CbrkIl/0qlzYVo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nGJeQ92wdpt8y9jWFgD+DnAhDWiXBNu4U9cRUpNRoH1Nx+do71aQkwqft3LfXa9md
	 DwsTaDjRLQZHJL124l4ECtwVOJ9cG6m9GfQ63Oc250t8K/fv2YYNzshaxiAIQWlSou
	 0I92BYlwbD6JGkXttCsUW4swCG99Xpl+X240XdsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390860AbfJ2RBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 13:01:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390518AbfJ2RBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 13:01:11 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6584E21D7C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 17:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572368469;
        bh=CEfNBOwII3kRKjNTV1QnlKd06oaG8CbrkIl/0qlzYVo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q3ICBVGcY42CD77N0qTsXJMlZjKwCidRWPAxH82TYrbs7YAGB3c7j/9/y7vR/rPZR
         eDzCjhVK7kXCC1J3TLXjgEAjKbyUIb+2Sw6OzQcEHDflnMgQERH7a35eeLBeGOOIQO
         H7iDIO3lp7G8rFWGFzKfkz3edX4IblThKLG68/UA=
Received: by mail-wr1-f52.google.com with SMTP id q13so14443952wrs.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 10:01:09 -0700 (PDT)
X-Gm-Message-State: APjAAAX5jAkdn8PSLv0ZaybVmL/ROPnf20B6etjwDNTLpMd5TJznS37B
        0YseMihruPAwb0EKK4mMTRo6s1ZxMpNrWP3sPzlRyQ==
X-Google-Smtp-Source: APXvYqxXiNG2A88b6n9p+z8Zlwh9YkfuUsw66nu2TCU6joSFqbJXpVXXmh37z2G7Eps4xr3l8sMAkLs+7YfDYfVvLGo=
X-Received: by 2002:adf:f04e:: with SMTP id t14mr21415495wro.106.1572368466787;
 Tue, 29 Oct 2019 10:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <CA5C22D9-BC3E-4B69-8DD9-4D3B75E40BD5@amacapital.net> <20191029093254.GE18773@rapoport-lnx>
In-Reply-To: <20191029093254.GE18773@rapoport-lnx>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 29 Oct 2019 10:00:55 -0700
X-Gmail-Original-Message-ID: <CALCETrUuuc4DS0cdMBtS550Wkp0x9ND3M3SgtaMgyRROnDR5Kg@mail.gmail.com>
Message-ID: <CALCETrUuuc4DS0cdMBtS550Wkp0x9ND3M3SgtaMgyRROnDR5Kg@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user mappings
To:     Mike Rapoport <rppt@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, X86 ML <x86@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 2:33 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Mon, Oct 28, 2019 at 02:44:23PM -0600, Andy Lutomirski wrote:
> >
> > > On Oct 27, 2019, at 4:17 AM, Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > =EF=BB=BFFrom: Mike Rapoport <rppt@linux.ibm.com>
> > >
> > > Hi,
> > >
> > > The patch below aims to allow applications to create mappins that hav=
e
> > > pages visible only to the owning process. Such mappings could be used=
 to
> > > store secrets so that these secrets are not visible neither to other
> > > processes nor to the kernel.
> > >
> > > I've only tested the basic functionality, the changes should be verif=
ied
> > > against THP/migration/compaction. Yet, I'd appreciate early feedback.
> >
> > I=E2=80=99ve contemplated the concept a fair amount, and I think you sh=
ould
> > consider a change to the API. In particular, rather than having it be a
> > MAP_ flag, make it a chardev.  You can, at least at first, allow only
> > MAP_SHARED, and admins can decide who gets to use it.  It might also pl=
ay
> > better with the VM overall, and you won=E2=80=99t need a VM_ flag for i=
t =E2=80=94 you
> > can just wire up .fault to do the right thing.
>
> I think mmap()/mprotect()/madvise() are the natural APIs for such
> interface.

Then you have a whole bunch of questions to answer.  For example:

What happens if you mprotect() or similar when the mapping is already
in use in a way that's incompatible with MAP_EXCLUSIVE?

Is it actually reasonable to malloc() some memory and then make it exclusiv=
e?

Are you permitted to map a file MAP_EXCLUSIVE?  What does it mean?

What does MAP_PRIVATE | MAP_EXCLUSIVE do?

How does one pass exclusive memory via SCM_RIGHTS?  (If it's a
memfd-like or chardev interface, it's trivial.  mmap(), not so much.)

And finally, there's my personal giant pet peeve: a major use of this
will be for virtualization.  I suspect that a lot of people would like
the majority of KVM guest memory to be unmapped from the host
pagetables.  But people might also like for guest memory to be
unmapped in *QEMU's* pagetables, and mmap() is a basically worthless
interface for this.  Getting fd-backed memory into a guest will take
some possibly major work in the kernel, but getting vma-backed memory
into a guest without mapping it in the host user address space seems
much, much worse.

> Switching to a chardev doesn't solve the major problem of direct
> map fragmentation and defeats the ability to use exclusive memory mapping=
s
> with the existing allocators, while mprotect() and madvise() do not.
>

Will people really want to do malloc() and then remap it exclusive?
This sounds dubiously useful at best.
