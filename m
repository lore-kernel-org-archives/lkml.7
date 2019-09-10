Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E137C49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9A2216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E8zBDg+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437151AbfIJRnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 13:43:22 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37354 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbfIJRnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:43:21 -0400
Received: by mail-vs1-f67.google.com with SMTP id q9so11877623vsl.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 10:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iZFN9sZS2h8SFWG+P0x7nyGva9yupkamPkDWX3SwdVA=;
        b=E8zBDg+tTwWnNy6Z4n8i89oWK6PRu64Hw71Y7M42Z/TQwydXy//2zYP/oDlh9/X5Wk
         Sp93Eh4WKbfU0Sp/Qizmwi3ZEgM/181PPLN7uNYURu6dFIOzvjT9ggjvNNPm/NnT5usp
         4mloXyqX1j/ipt5bGlTOqpUldlnrlz9OdIjY1bQeZu3uvVd6hJTv4i8I/5ne7DvJC6wO
         tVUuJbONRHGV63jNWKH06cva+nh6anS0I+z/x8XoGpFPoejFwncsxWA9nR6wmG/a1e0O
         XiZOYKL0hlmmUH7CkcAXsV62Wor73r3yfRuxZl0GzVmyq6QMQkbRIGpu24nb28C4DtLx
         TVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iZFN9sZS2h8SFWG+P0x7nyGva9yupkamPkDWX3SwdVA=;
        b=h41Y72eMSv2Oh4eFWhmiGLGfYdx9TB6nK4rsL2OgMPLBMiY5p/R4yvAKROALWAGVa6
         bqAUHMcjrpYDQPKvfFoULGaWWG+iet8snofqqyc/73oX2EjIthEl+HAOYW9Ljtzp937X
         HnziLAqs7kNClNWBxs2lqP+sKj6LTDdGp79rsUwTeSd8gTka4PbdqUH3wi5W5/CoV4tP
         Za+sV0m7NBnISZq66L5Fct1XlJahqAWNCTSn0D7qTbk4E9x+fP2bs10IT4o5eHJ11820
         28wHLPFk4uIkRZnoSpfhRvyc941Io1Nw57TjQKV/GaR93ucWmkwaCZoIwjItpqZjVGU2
         SZFA==
X-Gm-Message-State: APjAAAV7HXXuFGSSHu+nlRgsRCaQI61XETGuvAWQn0Lvuslh0glU0itk
        L62PLgYO7dTllIyFsWM/ED9/ficS1RXo9c9ZL/qoEQ==
X-Google-Smtp-Source: APXvYqwztIyJeOVDg7mHYVMP5EiFipb+OaSO/GlDtBUviPUH8Ju2PrPm1ueyE3eP7+PRthYsLhXBYb4deBGXOUAj3c4=
X-Received: by 2002:a67:1043:: with SMTP id 64mr2413213vsq.114.1568137400264;
 Tue, 10 Sep 2019 10:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190905005313.126823-1-dancol@google.com> <CALCETrU2Wycgdfo8vLZQUnx1J9ro=6ddSkP37BhsfBkKL1mbMA@mail.gmail.com>
In-Reply-To: <CALCETrU2Wycgdfo8vLZQUnx1J9ro=6ddSkP37BhsfBkKL1mbMA@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 10 Sep 2019 10:42:43 -0700
Message-ID: <CAKOZuevMiomDQwzrHVb4qU6nhKOiENWsEmFhVKrBvjVNa0ff+w@mail.gmail.com>
Subject: Re: [RFC] Add critical process prctl
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 9:57 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Wed, Sep 4, 2019 at 5:53 PM Daniel Colascione <dancol@google.com> wrote:
> >
> > A task with CAP_SYS_ADMIN can mark itself PR_SET_TASK_CRITICAL,
> > meaning that if the task ever exits, the kernel panics. This facility
> > is intended for use by low-level core system processes that cannot
> > gracefully restart without a reboot. This prctl allows these processes
> > to ensure that the system restarts when they die regardless of whether
> > the rest of userspace is operational.
>
> The kind of panic produced by init crashing is awful -- logs don't get
> written, etc.

True today --- but that's a separate problem, and one that can be
solved in a few ways, e.g., pre-registering log buffers to be
incorporated into any kexec kernel memory dumps. If a system aiming
for reliability can't diagnose panics, that's a problem with or
without my patch.

> I'm wondering if you would be better off with a new
> watchdog-like device that, when closed, kills the system in a
> configurable way (e.g. after a certain amount of time, while still
> logging something and having a decent chance of getting the logs
> written out.)  This could plausibly even be an extension to the
> existing /dev/watchdog API.

There are lots of approaches that work today: a few people have
suggested just having init watch processes, perhaps with pidfds. What
I worry about is increasing the length (both in terms of time and
complexity) of the critical path between something going wrong in a
critical process and the system getting back into a known-good state.
A panic at the earliest moment we know that a marked-critical process
has become doomed seems like the most reliable approach, especially
since alternatives can get backed up behind things like file
descriptor closing and various forms of scheduling delay.
