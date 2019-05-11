Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32959C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 17:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F218D2173B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 17:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557595687;
	bh=SarPsF9wVdDjeaHDnr3nVckP4R3JfsrB7CQ+qWWWYaI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1w+wrll9bkWIhX/TqPO+8562rzBJmNthiQusbVHKWwqriRCXAWfWuoEgTAbOQEaMo
	 l1ZP3aLdKEjw/9USZAZKNObsizOKanTcIjUEhQJ1UBEoqk0EGeHbxRBBEbQW8YptQ/
	 yYawNuIRkreVFV/lEKBFU3X0PTgabotrQ+Jp3jK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfEKR2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 13:28:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39085 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfEKR2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 13:28:05 -0400
Received: by mail-lj1-f194.google.com with SMTP id q10so7634824ljc.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 10:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/KXVrXCOoOJzYs9luHiRMdkROvz6GYngOgjcnMA4n3A=;
        b=Hety9aPlucNn5YIwnDgl8T3xjH+kXuoGBPFuY/OFtMOJcXBxT9yY1dN0jhbCAtXCK0
         Fa6aOPlBmmvU40A7F6POImQufHmWg9Vb9DX0ym6/HYmPb7jC+B4zImEGQr9edmzZr+8E
         D7AZsufzimvvqZsX7ErQ2Z7DvHrgK4oj1AIJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/KXVrXCOoOJzYs9luHiRMdkROvz6GYngOgjcnMA4n3A=;
        b=tL59STHlG7KvxthADOomAYvJB4kUae69/1ayg///TD2z2nC8hNBQv3/KwCk6g/W0xs
         q/FqxycDbiTNbjPqna07X9FLR9mT0G43kpeRGilRNR+/fYD4VFhEfq8dbc0vDnOrX4RB
         KU65908uviUY72JjuYA/tDDnOWjcguv7Dcz0+b5MgCUaU1FgRsfA1oSRaywVyWypvFgT
         T0zwLLF26tZIGFagVkFOX6Y1eTdItM1BliLZZD9HnOv65ZZNlQFwXDYqIFj5yR/NpZyd
         vf2yiU1lOfQ7lO8Y+b/za9/UBrqvkJo01OtPs0qzypRTazVbbSgvbEhYwNhM5SzsIpOA
         7nag==
X-Gm-Message-State: APjAAAWHrnHIQCbXlKMUFIh+ug9JTPnd/cpXlpgqPQCRFB7MS6eFZZCd
        FtirHJwbzRUEJlx8udY/BSKc6R7y+Ks=
X-Google-Smtp-Source: APXvYqz+ZJWd7jdDD7+oFtJkTWk4TwOIH4Pwmav3jgzA2uXD4QU+hRbfz5xoosLcdDOvPHrOvOD/7A==
X-Received: by 2002:a2e:801a:: with SMTP id j26mr9153479ljg.2.1557595682015;
        Sat, 11 May 2019 10:28:02 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id w17sm1498713ljj.31.2019.05.11.10.28.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 10:28:01 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id w1so5064263ljw.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 10:28:01 -0700 (PDT)
X-Received: by 2002:a2e:9d86:: with SMTP id c6mr9078356ljj.135.1557595287924;
 Sat, 11 May 2019 10:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190506165439.9155-1-cyphar@cyphar.com> <20190506165439.9155-6-cyphar@cyphar.com>
 <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
 <20190506191735.nmzf7kwfh7b6e2tf@yavin> <20190510204141.GB253532@google.com>
 <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com>
 <20190510225527.GA59914@google.com> <C60DC580-854D-478D-AF23-5F29FB7C3E50@amacapital.net>
In-Reply-To: <C60DC580-854D-478D-AF23-5F29FB7C3E50@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 May 2019 13:21:11 -0400
X-Gmail-Original-Message-ID: <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com>
Message-ID: <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 1:00 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
> A better =E2=80=9Cspawn=E2=80=9D API should fix this.

Andy, stop with the "spawn would be better".

Spawn is garbage. It's garbage because it's fundamentally too
inflexible, and it's garbage because it is quite complex to try to
work around the inflexibility by having those complex "action pointer
arrays" to make up for its failings.

And spawn() would fundamentally have all the same permission issues
that you now point to execve() as having, so it doesn't even *solve*
anything.

You've said this whole "spawn would fix things" thing before, and it's
wrong. Spawn isn't better. Really. If fixes absolutely zero things,
and the only reason for spawn existing is because VMS and NT had that
broken and inflexible model.

There's at least one paper from some MS people about how "spawn()" is
wonderful, and maybe you bought into the garbage from that. But that
paper is about how they hate fork(), not because of execve(). And if
you hate fork, use "vfork()" instead (preferably with an immediate
call to a non-returning function in the child to avoid the stack
re-use issue that makes it so simple to screw up vfork() in hard to
debug ways).

execve() is a _fine_ model. That's not the problem in this whole issue
at all - never was, and never will be.

The problem in this discussion is (a) having privileges you shouldn't
have and (b) having other interfaces that make it easyish to change
the filesystem layout to confuse those entities with privileges.

So the reason the open flags can be problematic is exactly because
they effectively change filesystem layout. And no, it's not just
AT_THIS_ROOT, although that's the obvious one. Things like "you can't
follow symlinks" can also effectively change the layout: imagine if
you have a PATH-like lookup model, and you end up having symlinks as
part of the standard filesystem layout.. Now a "don't follow symlinks"
can turn the *standard* executable into something that isn't found,
and then you might end up executing something else instead (think root
having '.' as the last entry in path, which some people used to
suggest as the fix for the completely bad "first entry" case)..

Notice? None of the real problems are about execve or would be solved
by any spawn API. You just think that because you've apparently been
talking to too many MS people that think fork (and thus indirectly
execve()) is bad process management.

                Linus
