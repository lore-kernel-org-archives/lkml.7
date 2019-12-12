Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23742C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C18214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfLLIQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 03:16:55 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42710 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfLLIQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 03:16:54 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so863931otd.9;
        Thu, 12 Dec 2019 00:16:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ewr89PonhWcgQjjMfRXnUYggn4igO3v85xYb+oGoz0c=;
        b=XNT1JDqjfoaOHfMOlVUsVNvOgfjlLXhYnufQ1cU0/Fa6fDHBopULqfi63PkFPeVFlg
         znXK5xmMa7S8B7Leg+rhfoUKja/rPLSOlb7uhX2u5iL5GCaTd4mn9oEt048Ec/BjIrfX
         XgRrx1AIZIkUwSZV/3kW6088Tr7NRHIC1kC0OV3y5vqaL9rIa5RAu3APZ00CHYb+51gt
         96qSgi1NgLqwJp0bVTgNinjOoOwnLWSYRuVKlRgKyjIE0tR7zlrf5NJLv0K6aQcbZGfp
         pi7wtWRk9m+X+n4JN9BxE28/dFmTThVC/yA1m6Hu/U83RfMgKgFSFSVeYjpSrFxp5TJ8
         1kTw==
X-Gm-Message-State: APjAAAU4Q/2vbuHVRYOTq1lAqtuZk4jhQDC24NPrag/of9lzcHpFfGcw
        EoP8SvN7Rw1Vn4VwHEfdD7YEvHS/nxMQ7tV0Xsc=
X-Google-Smtp-Source: APXvYqzG9ZYt3uBwcdCm4dU8hq16ZX7u/oPyLUqMuF3MVZpIJkp+3Lze2iN7nOOizTD0C1A2hDfmvNSvEV/OKJdYmNA=
X-Received: by 2002:a9d:7984:: with SMTP id h4mr6910500otm.297.1576138612708;
 Thu, 12 Dec 2019 00:16:52 -0800 (PST)
MIME-Version: 1.0
References: <20191211204306.1207817-1-arnd@arndb.de> <20191211204306.1207817-25-arnd@arndb.de>
In-Reply-To: <20191211204306.1207817-25-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Dec 2019 09:16:41 +0100
Message-ID: <CAMuHMdW=eG9WWbeL0Od6dVzE7ydpBvVybvkn+cGFtyBR77sP6A@mail.gmail.com>
Subject: Re: [PATCH 24/24] Documentation: document ioctl interfaces better
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, Dec 11, 2019 at 9:53 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Documentation/process/botching-up-ioctls.rst was orignally
> written as a blog post for DRM driver writers, so it it misses
> some points while going into a lot of detail on others.
>
> Try to provide a replacement that addresses typical issues
> across a wider range of subsystems, and follows the style of
> the core-api documentation better.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/core-api/ioctl.rst
> @@ -0,0 +1,250 @@
> +======================
> +ioctl based interfaces
> +======================
> +
> +:c:func:`ioctl` is the most common way for applications to interface
> +with device drivers. It is flexible and easily extended by adding new
> +commands and can be passed through character devices, block devices as
> +well as sockets and other special file descriptors.
> +
> +However, it is also very easy to get ioctl command definitions wrong,
> +and hard to fix them later without breaking existing applications,
> +so this documentation tries to help developers get it right.
> +
> +Command number definitions
> +==========================
> +
> +The command number, or request number, is the second argument passed to
> +the ioctl system call. While this can be any 32-bit number that uniquely
> +identifies an action for a particular driver, there are a number of
> +conventions around defining them.

Interesting. I never realized the action is 32-bit in the kernel, but
unsigned long in userspace...

> +
> +``include/uapi/asm-generic/ioctl.h`` provides four macros for defining
> +ioctl commands that follow modern conventions: ``_IOC``, ``_IOR``,
> +``_IOW``, and ``_IORW``. These should be used for all new commands,
> +with the correct parameters:
> +
> +_IO/_IOR/_IOW/_IOWR

This says _IO....

> +   The macro name determines whether the argument is used for passing
> +   data into kernel (_IOW), from the kernel (_IOR), both (_IOWR) or is

into the kernel
, or is

> +   not a pointer (_IOC). It is possible but not recommended to pass an
> +   integer value instead of a pointer with _IOC.

...which is not explained here, but _IOC is?

> +
> +type
> +   An 8-bit number, often a character literal, specific to a subsystem
> +   or driver, and listed in :doc:`../ioctl/ioctl-number`
> +
> +nr
> +  An 8-bit number identifying the specific command, unique for a give
> +  value of 'type'
> +
> +size
> +  The name of the data type pointed to by the argument, the command
> +  number encodes the ``sizeof(size)`` value in a 13-bit or 14-bit integer,
> +  leading to a limit of 8191 bytes for the maximum size of the argument.
> +  Note: do not pass sizeof(type) type into _IOR/IOW, as that will lead
> +  to encoding sizeof(sizeof(type)), i.e. sizeof(size_t).

Looks like "size" could be renamed, to make this more obvious?

> +Timestamps
> +==========
> +
> +Traditionally, timestamps and timeout values are passed as ``struct
> +timespec`` or ``struct timeval``, but these are problematic because of
> +incompatible definitions of these structures in user space after the
> +move to 64-bit time_t.
> +
> +The __kernel_timespec type can be used instead to be embedded in other
> +data structures when separate second/nanosecond values are desired,
> +or passed to user space directly. This is still not ideal though,
> +as the structure matches neither the kernel's timespec64 nor the user
> +space timespec exactly. The get_timespec64() and put_timespec64() helper
> +functions canbe used to ensure that the layout remains compatible with

can be

> +user space and the padding is treated correctly.
> +
> +As it is cheap to convert seconds to nanoseconds, but the opposite
> +requires an expensive 64-bit division, a simple __u64 nanosecond value
> +can be simpler and more efficient.
> +
> +Timeout values and timestamps should ideally use CLOCK_MONOTONIC time,
> +as returned by ``ktime_get_ns()`` or ``ktime_get_ts64()``.  Unlike
> +CLOCK_REALTIME, this makes the timestamps immune from jumping backwards
> +or forwards due to leap second adjustments and clock_settime() calls.
> +
> +``ktime_get_real_ns()`` can be used for CLOCK_REALTIME timestamps that
> +may be required for timestamps that need to be persistent across a reboot

Drop "may be required for timestamps that"?

> +or between multiple machines.

> +Structure layout
> +----------------
> +
> +Compatible data structures have the same layout on all architectures,
> +avoiding all problematic members:
> +
> +* ``long`` and ``unsigned long`` are the size of a register, so
> +  they can be either 32 bit or 64 bit wide and cannot be used in portable

32-bit or 64-bit (for consistency with the rest of the document)

> +  data structures. Fixed-length replacements are ``__s32``, ``__u32``,
> +  ``__s64`` and ``__u64``.
> +
> +* Pointers have the same problem, in addition to requiring the
> +  use of ``compat_ptr()``. The best workaround is to use ``__u64``
> +  in place of pointers, which requires a cast to ``uintptr_t`` in user
> +  space, and the use of ``u64_to_user_ptr()`` in the kernel to convert
> +  it back into a user pointer.
> +
> +* On the x86-32 (i386) architecture, the alignment of 64-bit variables
> +  is only 32 bit, but they are naturally aligned on most other

32-bit

> +  architectures including x86-64. This means a structure like
> +
> +  ::
> +
> +    struct foo {
> +        __u32 a;
> +        __u64 b;
> +        __u32 c;
> +    };
> +
> +  has four bytes of padding between a and b on x86-64, plus another four
> +  bytes of padding at the end, but no padding on i386, and it needs a
> +  compat_ioctl conversion handler to translate between the two formats.
> +
> +  To avoid this problem, all structures should have their members
> +  naturally aligned, or explicit reserved fields added in place of the
> +  implicit padding.
> +
> +* On ARM OABI user space, 16-bit member variables have 32-bit
> +  alignment, making them incompatible with modern EABI kernels.
> +  Conversely, on the m68k architecture, all struct members have at most
> +  16-bit alignment. These rarely cause problems as neither ARM-OABI nor

"have at most 16-bit alignment" sounds a bit weird to me, as a member
may have a greater alignment.
"struct members are not guaranteed to have an alignment greater than 16-bit"?

> +  m68k are supported by any compat mode, but for consistency, it is best
> +  to completely avoid 16-bit member variables.
> +
> +
> +* Bitfields and enums generally work as one would expect them to,
> +  but some properties of them are implementation-defined, so it is better
> +  to avoid them completely in ioctl interfaces.
> +
> +* ``char`` members can be either signed or unsigned, depending on
> +  the architecture, so the __u8 and __s8 types should be used for 8-bit
> +  integer values, though char arrays are clearer for fixed-length strings.
> +
> +Information leaks
> +=================
> +
> +Uninitialized data must not be copied back to user space, as this can
> +cause an information leak, which can be used to defeat kernel address
> +space layout randomization (KASLR), helping in an attack.
> +
> +As explained for the compat mode, it is best to not avoid any padding in

best to avoid any implicit padding?

> +data structures, but if there is already padding in existing structures,
> +the kernel driver must be careful to zero out the padding using
> +``memset()`` or similar before copying it to user space.
> +
> +Subsystem abstractions
> +======================
> +
> +While some device drivers implement their own ioctl function, most
> +subsystems implement the same command for multiple drivers.  Ideally the
> +subsystem has an .ioctl() handler that copies the arguments from and
> +to user space, passing them into subsystem specific callback functions
> +through normal kernel pointers.
> +
> +This helps in various ways:
> +
> +* Applications written for one driver are more likely to work for
> +  another one in the same subsystem if there are no subtle differences
> +  in the user space ABI.
> +
> +* The complexity of user space access and data structure layout at done

is done

> +  in one place, reducing the potential for implementation bugs.
> +
> +* It is more likely to be reviewed by experienced developers
> +  that can spot problems in the interface when the ioctl is shared
> +  between multiple drivers than when it is only used in a single driver.
> +
> +Alternatives to ioctl
> +=====================
> +
> +There are many cases in which ioctl is not the best solution for a
> +problem. Alternatives include

:

> +
> +* System calls are a better choice for a system-wide feature that
> +  is not tied to a physical device or constrained by the file system
> +  permissions of a character device node
> +
> +* netlink is the preferred way of configuring any network related
> +  objects through sockets.
> +
> +* debugfs is used for ad-hoc interfaces for debugging functionality
> +  that does not need to be exposed as a stable interface to applications.
> +
> +* sysfs is a good way to expose the state of an in-kernel object
> +  that is not tied to a file descriptor.
> +
> +* configfs can be used for more complex configuration than sysfs
> +
> +* A custom file system can provide extra flexibility with a simple
> +  user interface but add a lot of complexity in the implementation.

adds ... to

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
