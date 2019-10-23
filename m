Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3EFCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 19:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF3E20663
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 19:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571858497;
	bh=eA+ZT4QHat2+EIWy0C1wo1arzUq8iBFuHoCMVRtUvt8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UTvOO1BGrRJbZSm1/cFnHS77lUx97Bmd3/Q7m0HLoD1BGe15UDlqLEIX2IGTKBd73
	 i9Eq4yvUNn/I8r3DsHID3JJaRfjkMzecCbGvswo0vAEoIEEYERbpKIr1Jpk40Or7uj
	 PGe2/1eXAcljuJs8p3HGVfgFLKy3fyNhLf8n4WrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390615AbfJWTVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 15:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732686AbfJWTVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 15:21:32 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5659B21A4A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 19:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571858491;
        bh=eA+ZT4QHat2+EIWy0C1wo1arzUq8iBFuHoCMVRtUvt8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N30U1gto6Y/YW/X1kjdHTf6mLeW4+VibfbIFM42pv5YSs8asbTGcNaJWGqyX25TxZ
         z5gpw2lQn2AOn3p/diZj3/f2Oz28XCAKU3IjBQBjW9vLWlYnblHW6a82xQHkMXk/Ta
         DByiMu15BSt/Z7StrjbIRoYhSWZ8+32agPiSV8Js=
Received: by mail-wr1-f49.google.com with SMTP id r1so13537992wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 12:21:31 -0700 (PDT)
X-Gm-Message-State: APjAAAUZYLfdNSaZ8+CGB1INZ3jzu33026z80yP536Tm9ZnRYM4aQDRm
        Eq4x1gzaNMyT5KydpGdIFep3Y/y+TXYpgWgkpY9Tig==
X-Google-Smtp-Source: APXvYqw7KTG+90tUY67BWKH60wbgDRsGNBs48rLJnwu/jKRhPVU6JrS99XBLoxXAEuVueDNIS4APVe/18+ujBzqLCQ0=
X-Received: by 2002:a05:6000:1288:: with SMTP id f8mr266958wrx.111.1571858489805;
 Wed, 23 Oct 2019 12:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-4-dancol@google.com>
 <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com>
 <CAKOZuevUqs_Oe1UEwguQK7Ate3ai1DSVSij=0R=vmz9LzX4k6Q@mail.gmail.com>
 <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
 <CAG48ez3P27-xqdjKLqfP_0Q_v9K92CgEjU4C=kob2Ax7=NoZbA@mail.gmail.com> <20191023190959.GA9902@redhat.com>
In-Reply-To: <20191023190959.GA9902@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 23 Oct 2019 12:21:18 -0700
X-Gmail-Original-Message-ID: <CALCETrWY+5ynDct7eU_nDUqx=okQvjm=Y5wJvA4ahBja=CQXGw@mail.gmail.com>
Message-ID: <CALCETrWY+5ynDct7eU_nDUqx=okQvjm=Y5wJvA4ahBja=CQXGw@mail.gmail.com>
Subject: Re: [PATCH 3/7] Add a UFFD_SECURE flag to the userfaultfd API.
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
        Daniel Colascione <dancol@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Tim Murray <timmurray@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 12:10 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> Hello,
>
> On Sat, Oct 12, 2019 at 06:14:23PM -0700, Andy Lutomirski wrote:
> > [adding more people because this is going to be an ABI break, sigh]
>
> That wouldn't break the ABI, no more than when if you boot a kernel
> built with CONFIG_USERFAULTFD=n.
>
> All non-cooperative features can be removed any time in a backwards
> compatible way, the only precaution is to mark their feature bits as
> reserved so they can't be reused for something else later.
>
> > least severely restricted.  A .read implementation MUST NOT ACT ON THE
> > CALLING TASK.  Ever.  Just imagine the effect of passing a userfaultfd
> > as stdin to a setuid program.
>
> With UFFD_EVENT_FORK, the newly created uffd that controls the child,
> is not passed to the parent nor to the child. Instead it's passed to
> the CRIU monitor only, which has to be already running as root and is
> fully trusted and acts a hypervisor (despite there is no hypervisor).
>
> By the time execve runs and any suid bit in the execve'd inode becomes
> relevant, well before the new userland executable code can run, the
> kernel throws away the "old_mm" controlled by any uffd and all
> attached uffds are released as well.
>
> All I found is your "A .read implementation MUST NOT ACT ON THE
> CALLING TASK" as an explanation that something is broken but I need
> further clarification.

There are two things going on here.

1. Daniel wants to add LSM labels to userfaultfd objects.  This seems
reasonable to me.  The question, as I understand it, is: who is the
subject that creates a uffd referring to a forked child?  I'm sure
this is solvable in any number of straightforward ways, but I think
it's less important than:

2. The existing ABI is busted independently of #1.  Suppose you call
userfaultfd to get a userfaultfd and enable UFFD_FEATURE_EVENT_FORK.
Then you do:

$ sudo <&[userfaultfd number]

Sudo will read it and get a new fd unexpectedly added to its fd table.
It's worse if SCM_RIGHTS is involved.

So I think we either need to declare that UFFD_FEATURE_EVENT_FORK is
only usable by global root or we need to remove it and maybe re-add it
in some other form.


--Andy
