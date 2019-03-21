Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907B9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6233620850
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="Zbwd6lRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfCUJ5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:57:45 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45997 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbfCUJ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:57:44 -0400
Received: by mail-ot1-f65.google.com with SMTP id e5so3873264otk.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 02:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vHpSHzt5NHpVPS+Oump3k8LaMq2C3znc7HaOk8IZ0jU=;
        b=Zbwd6lRwwOgLY40BiW5v1/GNCPVeznZQvbIpgXsvSa2suE1fJa0JJhgS49FwtFJqwF
         pnn+93jdrvMeTw23XaB+uJE9mRMm6RWdgbMy1Bo0O9bawomDAI7aPngLl2epX6NtJ0QI
         dy2RatDWDrKbmYiSRjrEJrlCB9r/MUlDiy2lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vHpSHzt5NHpVPS+Oump3k8LaMq2C3znc7HaOk8IZ0jU=;
        b=Nbufq9FROEkGnC/vw0u8QDb6G/nxtBg5yMFhH+d12JpTwWWcLqyPoQO947vhki3860
         /b236UGTMAlfLULglBh2OqEyoZMu8TQYcw6Dm8Wac7WDr3EDaCcdaKi71r4wRGEA2fKp
         1KAPEooyWVVQibiYg5vQd0Pj+tUtHr6nruEZCRMdeVf9Q/kyMX6hr0B4htdiTzJQdAQQ
         6+yv9KutUU0eLz8li/m1Qw37NNuf4OPcKxfvGfALSxVl6umWXmwqYywAjVdUemdMv+am
         HZY5vy40F8hE7W4jHbU9NqqdVnlFT0PaUw6q6h3beC8xMfSZrQRMKqvU9DNtTSzBwzR0
         1uBA==
X-Gm-Message-State: APjAAAW+inpUCYa2E4bfqW0DTUYA0jrSZ1WiFs0so1thw7W25s37KE8l
        MtJC8VxOVTHeHVldR/Cb4b9cUpmHQzV00NhsYHLH7g==
X-Google-Smtp-Source: APXvYqyzXuM6PasJZNuclivssrPk8OJ3KJmvms3AG4loHQT4XFVx82wCYEgcdA8rF/h+iNBmKpKpBw4GuPPzk3fGuYU=
X-Received: by 2002:a9d:7f89:: with SMTP id t9mr1784851otp.169.1553162263800;
 Thu, 21 Mar 2019 02:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190320173332.18105-1-alban@kinvolk.io> <20190320173332.18105-4-alban@kinvolk.io>
 <20190320142346.3b552895@cakuba.netronome.com>
In-Reply-To: <20190320142346.3b552895@cakuba.netronome.com>
From:   Alban Crequy <alban@kinvolk.io>
Date:   Thu, 21 Mar 2019 10:57:32 +0100
Message-ID: <CADZs7q7+SATGjCCdiDBfGbTBJh11V6s=o4RAAKhaKvFjfo7O_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/7] tools: bpftool: implement map exec command
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Alban Crequy <alban.crequy@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Iago_L=C3=B3pez_Galeiras?= <iago@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 10:23 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Wed, 20 Mar 2019 18:33:29 +0100, Alban Crequy wrote:
> > From: Alban Crequy <alban@kinvolk.io>
> >
> > The map exec commands allows to open an existing map and pass the file
> > descriptor to a child process. This enables applications to use an
> > existing BPF map even when they don't support bpffs.
> >
> > Example of usage:
> >     # bpftool map exec pinned /sys/fs/bpf/foo fd 99 cmd -- readlink /proc/self/fd/99
> >     anon_inode:bpf-map
>
> Would you mind telling us a little more about the use for this feature?
> It seems fairly limited.  If it's about probing objects (finding out if
> they are a map or a program) perhaps we can add a command just for that?

I needed to know the name of the map too. I was preparing a demo based
on python bcc tools (opensnoop) but with added feature that requires
using a pinned map, created and maintained externally. At the moment,
the python API for bcc does not support pinning or using external
maps. Ideally, this should be added in the python API (some discussion
on https://github.com/iovisor/bcc/issues/2223) but meanwhile, I use a
workaround by executing bpftool from the python code.

Arguably, my use case is a temporary hack until we have better support
in python bcc. But other tools implements similar commands to pass
file descriptors between processes: "ip netns exec" and "tc exec bpf".
So I think it could be useful for other scripting use cases.

In my demo, I used the two hacks:
- if the pinned map fd is not given to the python script, re-execute
itself with bpftool:
os.execvp("bpftool", ["bpftool", "map", "exec", "pinned", pin_path,
"fd", "90", "cmd", "--"] + sys.argv)
- once we have the fd 90 (number specified above) of the pinned map in
the python script, overwrite the empty fd created by bcc:
os.dup2(90, 6)
I call dup2() between the bpf map creation and the bpf program
creation. To check which map fd to overwrite, I just call
os.system("bpftool map show fd 6...").


Thanks a lot for the reviews. I'll need some time to address it (maybe
a week or 2).

> (I guess bpftool -f isn't really the cleanest way of getting at that
> info.)
>
> > Documentation and bash completion updated as well.
> >
> > Signed-off-by: Alban Crequy <alban@kinvolk.io>
