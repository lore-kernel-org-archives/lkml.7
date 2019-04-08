Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6016FC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CE62087F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="fC7aTane"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfDHQ3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:29:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44322 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfDHQ3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:29:42 -0400
Received: by mail-io1-f66.google.com with SMTP id u12so11549233iop.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 09:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JxUh/OucTkUnste2gji40rqFftSK1RiXeYIa1yKo4X0=;
        b=fC7aTanep76q8hrkn2bRA+1MhgAecBx1NVeZ6SnmWztMpRHbqNA+nhtsc7nblv4jh+
         Mw2fSaTdhwZpUWKETeFYg9dfLnySdfPqhxrfbONVeQnUeJ8G/FwSouUko1Q8fIZmdHPd
         N5u/8WHqgNo4iBd8igyTSXuersOErsWCKppzyUS2NlZHYkO9EuB6zlw14jvA4KUJrRLX
         gCC3vameDfRPNYA/I/RIx9rOKb/pYTao38SyEJI+CzgbgQioo2ZyZd4+YSMQNXJvled2
         /jv4xKMMXNqJwzcwfk0P/3IMqByVTjAWpki/dwzF7UIkKEl55XbQibrCwokRxEFqObgq
         n6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JxUh/OucTkUnste2gji40rqFftSK1RiXeYIa1yKo4X0=;
        b=WUHD3OLhW0RIbttKd075Y66DKsr0pCi+Qe8+NAezxmCOVSqkQBfS8LXLjiGtc4s6cg
         9GA+9cGkdSb0R6Hch60iU88g+J8EcIbDc/FsGpWJu03ZjjUqUADGBGgiRi5lelwSW57V
         Jv+Hs42nyn6U1LH0GfbwlvPB4f03zIDwQVLfBUnaaDvj4eOU9UKBKEsdwJkSTu17ZXgR
         g4ZsL4UcyME8iliMNgxdEYTuLHSf+FsIkrwbwnQfxdpJSyAwskfysmdc5a3/tkxYAszs
         AALmEigvQ1wbKbXgCvC8tLM7PJBzL+8PPNjJS07jk7wiJlVYT0UZeTnSDz1bnyrcSVdB
         77Dg==
X-Gm-Message-State: APjAAAXts7wDz1xW5seBBbTn9yyDKJAiIhKKqLn49lVVP5466H42Q0VP
        iqaWJgJIz/dFVr/RSh+aOzRWPICpHtuDSDzoSkoPiQ==
X-Google-Smtp-Source: APXvYqzy5BhwGp0WoQaSBw9IupUhwbj3pvLAZOUeLWitYMX06RR6ROp4zAIcW72SetiAgcOsh7kb+FUvfjaCFmt6aC8=
X-Received: by 2002:a5d:8745:: with SMTP id k5mr840528iol.200.1554740981462;
 Mon, 08 Apr 2019 09:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190320163116.39275-1-joel@joelfernandes.org>
In-Reply-To: <20190320163116.39275-1-joel@joelfernandes.org>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 8 Apr 2019 09:29:30 -0700
Message-ID: <CAOesGMheoZda84OSz9spQ7p66wot5S_9aaqaKC=QYp+8utASXA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] Provide in-kernel headers to make extending kernel easier
To:     joel@joelfernandes.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        qais.yousef@arm.com, dietmar.eggemann@arm.com,
        linux@manojrajarao.com, Andrew Morton <akpm@linux-foundation.org>,
        ast@kernel.org, atishp04@gmail.com, dancol@google.com,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, karim.yaghmour@opersys.com,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        mhiramat@kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 20, 2019 at 9:31 AM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> Introduce in-kernel headers and other artifacts which are made available
> as an archive through proc (/proc/kheaders.tar.xz file). This archive makes
> it possible to build kernel modules, run eBPF programs, and other
> tracing programs that need to extend the kernel for tracing purposes
> without any dependency on the file system having headers and build
> artifacts.
>
> On Android and embedded systems, it is common to switch kernels but not
> have kernel headers available on the file system. Further once a
> different kernel is booted, any headers stored on the file system will
> no longer be useful. By storing the headers as a compressed archive
> within the kernel, we can avoid these issues that have been a hindrance
> for a long time.
>
> The best way to use this feature is by building it in. Several users
> have a need for this, when they switch debug kernels, they donot want to
> update the filesystem or worry about it where to store the headers on
> it. However, the feature is also buildable as a module in case the user
> desires it not being part of the kernel image. This makes it possible to
> load and unload the headers from memory on demand. A tracing program, or
> a kernel module builder can load the module, do its operations, and then
> unload the module to save kernel memory. The total memory needed is 3.8MB.
>
> By having the archive available at a fixed location independent of
> filesystem dependencies and conventions, all debugging tools can
> directly refer to the fixed location for the archive, without concerning
> with where the headers on a typical filesystem which significantly
> simplifies tooling that needs kernel headers.
>
> The code to read the headers is based on /proc/config.gz code and uses
> the same technique to embed the headers.
>
> To build a module, the below steps have been tested on an x86 machine:
> modprobe kheaders
> rm -rf $HOME/headers
> mkdir -p $HOME/headers
> tar -xvf /proc/kheaders.tar.xz -C $HOME/headers >/dev/null
> cd my-kernel-module
> make -C $HOME/headers M=$(pwd) modules
> rmmod kheaders
>
> Additional notes:
> (1) external modules must be built on the same arch as the host that
> built vmlinux. This can be done either in a qemu emulated chroot on the
> target, or natively. This is due to host arch dependency of kernel
> scripts.
>
> (2)
> If module building is used, since Module.symvers is not available in the
> archive due to a cyclic dependency with building of the archive into the
> kernel or module binaries, the modules built using the archive will not
> contain symbol versioning (modversion). This is usually not an issue
> since the idea of this patch is to build a kernel module on the fly and
> load it into the same kernel. An appropriate warning is already printed
> by the kernel to alert the user of modules not having modversions when
> built using the archive. For building with modversions, the user can use
> traditional header packages. For our tracing usecases, we build modules
> on the fly with this so it is not a concern.
>
> (3) I have left IKHD_ST and IKHD_ED markers as is to facilitate
> future patches that would extract the headers from a kernel or module
> image.
>
> (v4 was Tested-by the following folks,
>  v5 only has minor changes and has passed my testing).
> Tested-by: qais.yousef@arm.com
> Tested-by: dietmar.eggemann@arm.com
> Tested-by: linux@manojrajarao.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Sorry to be late at the party with this kind of feedback, but I find
the whole ".tar.gz in procfs" to be an awkward solution, especially if
there's expected to be userspace tooling that depends on this
long-term.

Wouldn't it be more convenient to provide it in a standardized format
such that you won't have to take an additional step, and always have
it in a known location?

Something like:

 - Pseudo-filesystem, that can just be mounted under
/sys/kernel/headers or something (similar to debugfs or
/proc/device-tree).
 - Exporting something like a squashfs image instead, allowing
loopback mounting of it (or by providing a pseudo-/dev entry for it),
again allowing direct export of the contents and avoiding the
extracted directory from being out of sync with currently running
kernel.

Having to copy and extract the tarball is the most awkward step, IMHO.
I also find the waste of kernel memory for it to be an issue, but
given that it can be built as a module I guess that's the obvious
solution for those who care about memory consumption.


-Olof
