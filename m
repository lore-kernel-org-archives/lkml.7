Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF42C5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 17:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0632421D7F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 17:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QDlUNpXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389302AbfKERCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 12:02:49 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41314 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387789AbfKERCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 12:02:48 -0500
Received: by mail-lf1-f67.google.com with SMTP id j14so15684555lfb.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 09:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3LbJPI0FDJ0eEH2iVM7vPGyU9geutYVr1qL8gmhIfHE=;
        b=QDlUNpXdd3Dyvqcp0bF9C4VAE6LpyEAfN3KCcFBDOBEqH3n8L0ZpW+QnevnXgO+jYu
         Qk8o1QZ5B54+yqYQT3t1wn/SYX8uoo4FtQ1RoMpU13Ly74nWaZ0DpB6c+SSSrHAm2jOf
         zyStjxIvVVyjTHDy76iWx/Fk+mv4DLTBXicRDuPGAVTUhNzNrCPpjPK7KNIliqLxmqiB
         7T85gjDMOw7LSetpqnnY8SLtjNFCld4SIVi8OEtT4kdKKV7JOiysKXHmaTOJOxh+RA7i
         sp0okHC4thvaKKudFX+HbfOenxmYBJ8YHGdTvAjMhkrw0vRQ1VRkfjrtXACS9VQBneMH
         4yMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3LbJPI0FDJ0eEH2iVM7vPGyU9geutYVr1qL8gmhIfHE=;
        b=ovOnjaiGWB9Fl/M+i9Fk1iTpsjXB3u/Sd9GM72s03mzPh2QK7KEel5OHbKxf35C3UP
         8pMs7PBSNCIKICNQf1dXUIHB8WvteMjES6+oCunM+Y95f2jjikMWEq/j19u36dTnBtvr
         6bGmjQr/4I33Lh8LRJRtllo1XYM00/7S0QqiC+SZ3m9qsAxkdYZOrMs48KNmdBksbVe5
         hEAYd1ktJZmCrcnAzCBdyVlSeXHQc2+PkkY/uuZHFtk8Oj1wAG4japnoupak3MHyzPiG
         vK1G8O78MhU0MIP2IsRf545E/I4E4eBCe5dakoo9LbckJfHCQwZotwbYFjmhhUTDzBu6
         0VEA==
X-Gm-Message-State: APjAAAVOisvDc+/+e6GdVC5fC+pbFcvFw4U8Sx51IlY+XNWFuuc5R3bB
        kYIZUsVhHtfCNmaoqOS+EIwMwK6o5Q7OashQhjLh/A==
X-Google-Smtp-Source: APXvYqxoAZZ3CBPgeWIOEoK9yoKNl+AObjnu16/uWXH4QNCI609JrFh7R0bTPoVuzjjLAldIucXdfUSSf/LzD/JxH1Y=
X-Received: by 2002:a19:8582:: with SMTP id h124mr9689722lfd.64.1572973365922;
 Tue, 05 Nov 2019 09:02:45 -0800 (PST)
MIME-Version: 1.0
References: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com>
 <1572967777-8812-2-git-send-email-rppt@linux.ibm.com> <CAKOZuev93zDGNPX+ySg_jeUg4Z3zKMcpABekUQvHA01kTVn4=A@mail.gmail.com>
 <CALCETrX=VmSjD6kLT6tuZQ4Efhc_13vZrw1mo4Z2iKqZTT-bzg@mail.gmail.com>
 <CAKOZuetu0QWUDAycTOFzC4HEbjH99EtOhb4gJnHAuovT_StpzA@mail.gmail.com>
 <20191105163316.GI30717@redhat.com> <CAKOZuet1Hrdd7U4VVBmXNCkE6xwiUPERRHjP=A3bX6B9A4BQRQ@mail.gmail.com>
 <20191105165556.GK30717@redhat.com>
In-Reply-To: <20191105165556.GK30717@redhat.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 5 Nov 2019 09:02:09 -0800
Message-ID: <CAKOZuet+fgaJR72YwYrHFdFVSOo6EWpcT8jUoh7se4cZb0V2aw@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: require CAP_SYS_PTRACE for UFFD_FEATURE_EVENT_FORK
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 8:56 AM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> On Tue, Nov 05, 2019 at 08:39:26AM -0800, Daniel Colascione wrote:
> > I'm not suggesting that we fail userfaultfd(2) without CAP_SYS_PTRACE.
> > That would, as you point out, break things. I'm talking about
> > recording *whether* we had CAP_SYS_PTRACE in an internal flag in the
> > uffd context when we create the thing --- and then, at ioctl time,
> > checking that flag, not the caller's CAP_SYS_PTRACE, to see whether
> > UFFD_FEATURE_EVENT_FORK should be made available. This way, the
> > security check hinges on whether the caller *at create time* was
> > privileged.
>
> Until now it wasn't clear to me you still wanted to do the permission
> check in UFFDIO_API time, and you only intended to move the
> "measurement" of the capability to the syscall.
>
> So you're suggesting to add more kernel complexity to code pending for
> removal to achieve a theoretically more pure solution in the band-aid
> required to defer the removal of the posix-breaking read
> implementation of the uffd fork feature?

And you're suggesting making a security check work weirdly unlike most
other security checks because you hope it'll get removed one day?
Temporary solutions aren't, and if something goes into the kernel at
all, it's worth getting right. The general rule is that access checks
happen at open time. The kernel has already been bitten by UFFD
exempting itself from the normal rules (e.g., the
read(2)-makes-a-file-descriptor thing) in the name of expediency.
There shouldn't be any more exceptions.
