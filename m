Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C74C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 19:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F632467B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 19:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J4JUk+kA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfLFTF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 14:05:56 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36363 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfLFTF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 14:05:56 -0500
Received: by mail-ot1-f68.google.com with SMTP id i4so6738284otr.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 11:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hzdm6u920Zu54Rz956W5+h57WY85ZdtVdfqXsUs3cp8=;
        b=J4JUk+kAi6AePh5EdVHtj8RlKN+OE+UFUQe7FYgJcHltk0WRhaTjkhwU0wmPbDnDYT
         FHN6EPvuf2yqeZgSsN2mcLncQnH+GKBoisvS0RTjO29r/4ZFHaMZW2oAcLb0fFQ9PCYR
         3/m6PxAtt0Myu+OkS0UtrNRV2TBUhDx4ZvrAh7GkEZMz0/Qw7KfWmOxsXZBTbTUzp5hu
         XWOXwZophPiJ/xN0LrLP0vbeWf5BM2qzWJERF76i7s+q0t0Uqe+aSoj6HoHpKxo8Rkvl
         avIcEBovZU9/+4BAogk9vMAJ31pOIUmps1j6aWPGKdaa79nyj3uXKg3DqUM7ZBfsm916
         yDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hzdm6u920Zu54Rz956W5+h57WY85ZdtVdfqXsUs3cp8=;
        b=rEisooPwT+HF79abEpANRoyYintbvzFKiZNP17BuIH2XWCxU3jsAM/JnyAi53SHllI
         XFkiefC0NRgRFuFxWZ6IMlC+vhgESLktKvi9jo6Wkca+GGwXJ8H7ZMlJ6wJsM3shwYXw
         Tr25VkQZyU92vLdsxpEp27PeXN8rOG4gKZHKrDe9mMr8HEd1jiAP96pPpMKzOyC/+LQC
         HgsyGmWSgkrMBgq/z4hh1clTJARe8jW9zy8SZ5olkqW8NeL2Tvif0/SNClb1Ya8gQsy9
         j4lKoW8M+bNdidApGHoZndFaVpuMX54El6HFR22tFzh4CLdf5CUKOfo9/ovGQBcvtRnx
         cSqQ==
X-Gm-Message-State: APjAAAU4bc55pmPpJ6rR+spuI1bMfRS0CokiJwXdeKJEzdu5jgaY9KIG
        RwkWpTvhrhIJvVl/LGw5patMTdmIZGwgrcSnTUSCgn5v
X-Google-Smtp-Source: APXvYqxBlAYMU2VRo65PaVig+MDoNvZGl/Bqu9L0uwzVZ+XAIRFSFEQftz1iNNNkf7nXZPvV1h2pHfuCiVPBh1GsvNg=
X-Received: by 2002:a9d:3b8:: with SMTP id f53mr12592920otf.180.1575659154739;
 Fri, 06 Dec 2019 11:05:54 -0800 (PST)
MIME-Version: 1.0
References: <20191205234450.GA26369@ircssh-2.c.rugged-nimbus-611.internal>
 <20191206141045.GA22803@cisco> <CAMp4zn-Ni-nHrQgn34jV6gzanTiF+wxPrr_zqM47McZQ8TKa5w@mail.gmail.com>
In-Reply-To: <CAMp4zn-Ni-nHrQgn34jV6gzanTiF+wxPrr_zqM47McZQ8TKa5w@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 6 Dec 2019 20:05:28 +0100
Message-ID: <CAG48ez23UZYRytSNYd74pZuCXPXtOQjZeixP18CL0XZEz-NP0w@mail.gmail.com>
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

On Fri, Dec 6, 2019 at 8:03 PM Sargun Dhillon <sargun@sargun.me> wrote:
> On Fri, Dec 6, 2019 at 6:10 AM Tycho Andersen <tycho@tycho.ws> wrote:
> > On Thu, Dec 05, 2019 at 11:44:53PM +0000, Sargun Dhillon wrote:
> > > take action on an FD on behalf of the tracee. For example, this
> > > can be combined with seccomp's user notification feature to extract
> > > a file descriptor and call privileged syscalls, like binding
> > > a socket to a privileged port.
> >
> > This can already be accomplished via injecting parasite code like CRIU
> > does; adding a ptrace() command like this makes it much nicer to be
> > sure, but it is redundant.
> >
> How can you do this if the tracee doesn't have privilege? For example,
> if the tracee doesn't have CAP_SYS_BIND_SERVICE, how could you
> get it to bind to a port that's privileged without taking the file descriptor
> and doing it in a process that does have CAP_SYS_BIND_SERVICE?

(You can let the parasite send the fd to the tracer via
SCM_CREDENTIALS if you have previously set up a unix domain socket for
this.)
