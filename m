Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E8CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 21:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A83F2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 21:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wn7w5KAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733095AbfJVV05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 17:26:57 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:36865 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfJVV04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 17:26:56 -0400
Received: by mail-wm1-f48.google.com with SMTP id f22so17544624wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 14:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Z38w4WeorVLa55pv2bFPQYaKP+W4SvCLyYXgYMK+IY=;
        b=Wn7w5KAyx1ojYoHVRBGGgyNncGa/iKhuHd5rjXLNsG8vDzbKO38J2Qvk71WBeHPv7M
         b1AxxZPMkvOCIMng/n547Xwq6V4p5a+E8UE17l2+Uk44iM9Y3aOTEVeGU6BqHthEcem/
         MhNPnsw8Gs1QfungV7+kD02pWsv2pedejSkFk3FEjsiKE4NsfiaIYLLJy/ZMeoACeohq
         RVWU3fa59Oz8TSew7u9gsW3+jFsHG7r+5nrgOTXZ7EzEpYxAoa/HkVMn3OZjzfJpXycL
         EE96D1eSCKwTr8URqmefMtyqrhMlajgcWBcIG3e8T/RIoI+z47wC7d9mXfy5ylJefmRv
         8GDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Z38w4WeorVLa55pv2bFPQYaKP+W4SvCLyYXgYMK+IY=;
        b=haIiaMAkEaZ8hJWx1+mAS351RALdurhT8Arm0JUfwel0dBb+KA/lYEKKGKBCGOdWYE
         vuiT3CUChAhfxdGhnijBhXW0vrlH1KCXlRbL6HYtl8EGdP2/KkeECzqeYBAqpV9Zr/s1
         qUB0SzeAlQIWFXRe+VJ8l28PgM06c9kV7Dlhh1OomvmFMKP7wlnTgMssMgXnqj+CHZQ3
         pOF7Sjx4STacUpkKYUKF+Z2qWqXGza5aBG6Er4t4BAaec6zqg+qgboexe63vwbhBhrgY
         ze2aJ227sGa1TTa00Adxcu2BkLz/dPinasW9fP1lAobEDxulRNt76c6PZ3ZBaxe4mikO
         Fehw==
X-Gm-Message-State: APjAAAUUzOqd2RDCGTEX95KRUBIubKUU9117v18HlL0lvO3XhSvwnwyG
        Rz/K4h620X5PnV5M5dOM20Lj2RVx8hXek4zNCcyuBSjwDdI=
X-Google-Smtp-Source: APXvYqyzdwGgDwMP2zk4d3TpGzXYgy26HaSUxMxn18tcYotG6c04jlPfK4Ld5JCvCkJnYpJDytgJsKPnvH5Txse/kJg=
X-Received: by 2002:a1c:2986:: with SMTP id p128mr2971786wmp.173.1571779613021;
 Tue, 22 Oct 2019 14:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAA25o9TABY=3C+FQEg8FDyF1rim315G2hmeB1DBWJLn-wG1j0g@mail.gmail.com>
 <CAJZ5v0gJWxLJTi7TjaRP-3aR3f4VnX1n9dRE_jxdS6e3SM46LQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gJWxLJTi7TjaRP-3aR3f4VnX1n9dRE_jxdS6e3SM46LQ@mail.gmail.com>
From:   Luigi Semenzato <semenzato@google.com>
Date:   Tue, 22 Oct 2019 14:26:41 -0700
Message-ID: <CAA25o9TiaaKGH4ZkOa=FhZW7PdXQ592YZ4q52o-QNx=yFsR4Pw@mail.gmail.com>
Subject: Re: is hibernation usable?
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geoff Pike <gpike@google.com>, Bas Nowaira <bassem@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the quick reply!

On Tue, Oct 22, 2019 at 1:57 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Oct 22, 2019 at 10:09 PM Luigi Semenzato <semenzato@google.com> wrote:
> >
> > Following a thread in linux-pm
> > (https://marc.info/?l=linux-mm&m=157012300901871) I have some issues
> > that may be of general interest.
> >
> > 1. To the best of my knowledge, Linux hibernation is guaranteed to
> > fail if more than 1/2 of total RAM is in use (for instance, by
> > anonymous pages).  My knowledge is based on evidence, experiments,
> > code inspection, the thread above, and a comment in
> > Documentation/swsusp.txt, copied here:
>
> So I use it on a regular basis (i.e. every day) on a system that often
> has over 50% or RAM in use and it all works.
>
> I also know about other people using it on a regular basis.
>
> For all of these users, it is usable.
>
> >  "Instead, we load the image into unused memory and then atomically
> > copy it back to it original location. This implies, of course, a
> > maximum image size of half the amount of memory."
>
> That isn't right any more.  An image that is loaded during resume can,
> in fact, be larger than 50% of RAM.  An image that is created during
> hibernation, however, cannot.

Sorry, I don't understand this.  Are you saying that, for instance,
you can resume a 30 GB image on a 32 GB device, but that image could
only have been created on a 64 GB device?

> > 2. There's no simple/general workaround.  Rafael suggested on the
> > thread "Whatever doesn't fit into 50% of RAM needs to be swapped out
> > before hibernation".  This is a good suggestion: I am actually close
> > to achieving this using memcgroups, but it's a fair amount of work,
> > and a fairly special case.  Not everybody uses memcgroups, and I don't
> > know of other reliable ways of forcing swap from user level.
>
> I don't need to do anything like that.

Again, I don't understand.  Why did you make that suggestion then?

> hibernate_preallocate_memory() manages to free a sufficient amount of
> memory on my system every time.

Unfortunately this doesn't work for me.  I may have described a simple
experiment: on a 4GB device, create two large processes like this:

dd if=/dev/zero bs=1100M count=1 | sleep infinity &
dd if=/dev/zero bs=1100M count=1 | sleep infinity &

so that more than 50% of TotalMem is used for anonymous pages.  Then
echo disk > /sys/power/state fails with ENOMEM.

Is this supposed to work?  Maybe I am doing something wrong?
Hibernation works before I create the dd processes.  After I force
some of those pages to a separate swap device, hibernation works too,
so those pages aren't mlocked or anything.

> > 3. A feature that works only when 1/2 of total RAM can be allocated
> > is, in my opinion, not usable, except possibly under special
> > circumstances, such as mine. Most of the available articles and
> > documentation do not mention this important fact (but for the excerpt
> > I mentioned, which is not in a prominent position).
>
> It can be used with over 1/2 of RAM allocated and that is quite easy
> to demonstrate.
>
> Honestly, I'm not sure what your problem is really.

I apologize if I am doing something stupid and I should know better
before I waste other people's time.  I have been trying to explain
these issues as best as I can.  I have a reproducible failure.  I'll
be happy to provide any additional detail.

>
> > Two questions then:
> >
> > A. Should the documentation be changed to reflect this fact more
> > clearly?  I feel that the current situation is a disservice to the
> > user community.
>
> Propose changes.

Sure, after we resolve the above questions.

> > B. Would it be worthwhile to improve the hibernation code to remove
> > this limitation?  Is this of interest to anybody (other than me)?
>
> Again, propose specific changes.
