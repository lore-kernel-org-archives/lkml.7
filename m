Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BEFC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 19:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297C72053B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 19:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tGna0vMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfLFTG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 14:06:27 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36772 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfLFTG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 14:06:26 -0500
Received: by mail-oi1-f194.google.com with SMTP id c16so755091oic.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 11:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dCoyUX/5uAtal6ZdIEgcK6WKycD1wXBsD+TcqDOxUhY=;
        b=tGna0vMTY/fa+Qc8LL2bd+yRBF6a0oSh7cxQKO1GgTha4NjB489UxfAT7ecVTBh2/c
         Ykjw4+briCdIEQSIm+NkSg5YK/5chS27VUPWc1xiz1cla6LT4OmyvT7datwO/FzuvBcV
         yBbkGJogk7P0YUFDk1BTSPLLQcbujc+b/m78bCiJGjZ1tN/HoYKzQSm9mFcTZz/hW//Q
         fUKHHfwbTbea7HberxXWzz0NeX9iDbMzTnzcP1/mUh5EMlFo7nvkOKvjsTMjN/ZCAZG4
         QoACZGrEMFHsV/4/XmEgs83tTUzEADDPyJpv2y5ebpeDFUyHSZ9+e95vTEshNK3J2wIf
         tMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dCoyUX/5uAtal6ZdIEgcK6WKycD1wXBsD+TcqDOxUhY=;
        b=ephJq++JpEcYndInfFcu8KUDFXoqXKCPD+LOUNQN6L4YOv6oJp0q9H0vNW41rY5z6d
         go8FjxN52MQ2PVlcIp1iJCVprjEMCs5FReMlO5ZIeR2MhTAqix1vFVJK+O7YtVyKYltU
         6LwWjl8+D7hBnSfC7GJTuhZqb8iKmX2nowU5ClyqB5anbbz9e4el0gmv0rwhM+fd5lTq
         K4xnA4LXCkfg6YxEf2+b8zKev0EzO5r6DxeDHX9wOHYRFpePb6pZX0xEwwPisLsDtD7i
         AAf0SaM8f4thvOKxGted+N4guZCdqUPeO7QniFQa8zzNEj0ELAGJ93H8M3xF2QTpcIF9
         F2eA==
X-Gm-Message-State: APjAAAUclILUgz4Vw4Z/rRCAGZAD18SVTXpXHR/Hjx4DU2FRBcOl7nb+
        PnZ24kW6CL+GTmPWc1XEtNOHFRaAlU02CSjPeaJ5tw==
X-Google-Smtp-Source: APXvYqwGMk/a1yrSprvBYpjj3s4h0rhubXdv7IhhetipCyPsZFgTTmzUBmDc9AcRT/KEEFqZwEEqvaDRUGCct3x/X1g=
X-Received: by 2002:aca:4a08:: with SMTP id x8mr14002912oia.39.1575659185815;
 Fri, 06 Dec 2019 11:06:25 -0800 (PST)
MIME-Version: 1.0
References: <20191205234450.GA26369@ircssh-2.c.rugged-nimbus-611.internal>
 <20191206141045.GA22803@cisco> <CAMp4zn-Ni-nHrQgn34jV6gzanTiF+wxPrr_zqM47McZQ8TKa5w@mail.gmail.com>
 <CAG48ez23UZYRytSNYd74pZuCXPXtOQjZeixP18CL0XZEz-NP0w@mail.gmail.com>
In-Reply-To: <CAG48ez23UZYRytSNYd74pZuCXPXtOQjZeixP18CL0XZEz-NP0w@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 6 Dec 2019 20:05:59 +0100
Message-ID: <CAG48ez07Ne7tCM_TSLcZV0ZCceMYpzwV9WPPtzosic5KGiATvA@mail.gmail.com>
Subject: Re: [RFC PATCH] ptrace: add PTRACE_GETFD request
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 8:05 PM Jann Horn <jannh@google.com> wrote:
> On Fri, Dec 6, 2019 at 8:03 PM Sargun Dhillon <sargun@sargun.me> wrote:
> > On Fri, Dec 6, 2019 at 6:10 AM Tycho Andersen <tycho@tycho.ws> wrote:
> > > On Thu, Dec 05, 2019 at 11:44:53PM +0000, Sargun Dhillon wrote:
> > > > take action on an FD on behalf of the tracee. For example, this
> > > > can be combined with seccomp's user notification feature to extract
> > > > a file descriptor and call privileged syscalls, like binding
> > > > a socket to a privileged port.
> > >
> > > This can already be accomplished via injecting parasite code like CRIU
> > > does; adding a ptrace() command like this makes it much nicer to be
> > > sure, but it is redundant.
> > >
> > How can you do this if the tracee doesn't have privilege? For example,
> > if the tracee doesn't have CAP_SYS_BIND_SERVICE, how could you
> > get it to bind to a port that's privileged without taking the file descriptor
> > and doing it in a process that does have CAP_SYS_BIND_SERVICE?
>
> (You can let the parasite send the fd to the tracer via
> SCM_CREDENTIALS if you have previously set up a unix domain socket for
> this.)

Eh, sorry, of course I meant SCM_RIGHTS.
