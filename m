Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35856C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B55020883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KyX4N9fq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfE0Tgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 15:36:46 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35595 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfE0Tgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 15:36:45 -0400
Received: by mail-oi1-f195.google.com with SMTP id a132so12586481oib.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 12:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8wOkTICbGGgSQKfMenc3seaDZ/KLgjroUdiof+HnQ4s=;
        b=KyX4N9fqFU6gT9OH1da4ukXI54+PtAJWkozfkY5dUnyUl5SliiI+ox0dC1m6ecKZkq
         2cbeynpQeQdlLyOhc4lLQPmNFVaaUFHrjJECflBdQMk+kPLdR9ZOcMMFL5uRCwKatFeb
         tTuV1ATMZeoqPCVAxo0v7AvtjchgMA3H3KoZ4cGjCUSRYRZjRouCFPSdlCdiIYGaTkEL
         N707cRBDzsjTd7MxleiRRg27FLy+pSktaDy092UqsDWvyOv01ZFtZ6aDYKcck3lXKsWQ
         QYJk7Y8LfRDDa0Fx6Qylo9I0yvrAkm4kgPWIZUqvAg63Tjkxf/jCRM8G82NSuPvj6fkE
         hHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wOkTICbGGgSQKfMenc3seaDZ/KLgjroUdiof+HnQ4s=;
        b=iM3XmgdtO/9T8N2GZzsw9YcfbSauxW+htEvI6avMI/TkwXlmU1QF+0L0rNjARkrcBp
         fDf7lgWu0A0Ww0homEs1YggmDznj+ai/Lyvw52IZYeko7/FTtgKoRfl08DIoJuy9hkPb
         GvW+vJ3K83YHtIX1NDt8CZB0DKdehgJL5CqYagtnLYOwEi7v9K7EARvtZjwBFLLKql+x
         FZ/+1ajMwOSZWqoE/CHT+NPFCTvaSz7SVvJDuSGj9vCfe2hlOkr8O+jDdGQDn1nnryKH
         YAMX7wxjx9MOLkwAB0RTRo50bOSOguZKJ0Rd2sSfiyX60ZEoF6//XOaBP0zk3yTLjFLj
         32Ug==
X-Gm-Message-State: APjAAAXYyEJVp8c2pjXiaGq/4YJnDuoPqqXEDT4AO/Nb4Pug3g9HaRDM
        YFHV56iawXTJ+eNBpnT3SsrwK1ZhrIZazNQoRFzw2A==
X-Google-Smtp-Source: APXvYqzjis5QKOqN7UmcaChzDsoUV0+dmtf01xdFNdjoZUGPORQ++uXNnITdfqBZARKJxYLU5wQK2Caza/hcN5eqwcc=
X-Received: by 2002:aca:c48c:: with SMTP id u134mr364457oif.39.1558985804503;
 Mon, 27 May 2019 12:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190526102612.6970-1-christian@brauner.io> <CAHk-=wieuV4hGwznPsX-8E0G2FKhx3NjZ9X3dTKh5zKd+iqOBw@mail.gmail.com>
 <20190527104239.fbnjzfyxa4y4acpf@brauner.io> <CAHk-=wjnbK5ob9JE0H1Ge_R4BL6D0ztsAvrM6DN+S+zyDWE=7A@mail.gmail.com>
In-Reply-To: <CAHk-=wjnbK5ob9JE0H1Ge_R4BL6D0ztsAvrM6DN+S+zyDWE=7A@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 27 May 2019 21:36:18 +0200
Message-ID: <CAG48ez2wyDhM-V1hs5ya1R4x7wHT=T8XLOYCPUyw97kzzLhbhg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fork: add clone6
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Kees

On Mon, May 27, 2019 at 9:27 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, May 27, 2019 at 3:42 AM Christian Brauner <christian@brauner.io> wrote:
> > Hm, still pondering whether having one unsigned int argument passed
> > through registers that captures all the flags from the old clone() would
> > be a good idea.
>
> That sounds like a reasonable thing to do.
>
> Maybe we could continue to call the old flags CLONE_XYZ and continue
> to pass them in as "flags" argument, and then we have CLONE_EXT_XYZ
> flags for a new 64-bit flag field that comes in through memory in the
> new clone_args thing?

With the current seccomp model, that would have the unfortunate effect
of making it impossible to filter out new clone flags - which would
likely mean that people who want to sandbox their code would not use
the new clone() because they don't want their sandboxed code to be
able to create time namespaces and whatever other new fancy things
clone() might support in the future. This is why I convinced Christian
to pass flags in registers for the first patch version.

The alternative I see would be to somehow extend seccomp to support
argument structures that are passed in memory - that would probably
require quite a bit of new plumbing though, both in the kernel and in
userspace code that configures seccomp filters.
