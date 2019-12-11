Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CC0C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF2C2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLKVFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 16:05:53 -0500
Received: from ms.lwn.net ([45.79.88.28]:58294 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfLKVFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 16:05:53 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 603E97DF;
        Wed, 11 Dec 2019 21:05:52 +0000 (UTC)
Date:   Wed, 11 Dec 2019 14:05:51 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 24/24] Documentation: document ioctl interfaces better
Message-ID: <20191211140551.00520269@lwn.net>
In-Reply-To: <20191211204306.1207817-25-arnd@arndb.de>
References: <20191211204306.1207817-1-arnd@arndb.de>
        <20191211204306.1207817-25-arnd@arndb.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019 21:42:58 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> Documentation/process/botching-up-ioctls.rst was orignally
> written as a blog post for DRM driver writers, so it it misses
> some points while going into a lot of detail on others.
> 
> Try to provide a replacement that addresses typical issues
> across a wider range of subsystems, and follows the style of
> the core-api documentation better.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for improving the docs!  I have a few nits outside of the content
itself.

>  Documentation/core-api/index.rst |   1 +
>  Documentation/core-api/ioctl.rst | 250 +++++++++++++++++++++++++++++++
>  2 files changed, 251 insertions(+)
>  create mode 100644 Documentation/core-api/ioctl.rst

So you left the old document in place; was that intentional?

> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> index ab0eae1c153a..3f28b2f668be 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -39,6 +39,7 @@ Core utilities
>     ../RCU/index
>     gcc-plugins
>     symbol-namespaces
> +   ioctl
>  
>  
>  Interfaces for kernel debugging
> diff --git a/Documentation/core-api/ioctl.rst b/Documentation/core-api/ioctl.rst
> new file mode 100644
> index 000000000000..cb2c86ae63e7
> --- /dev/null
> +++ b/Documentation/core-api/ioctl.rst
> @@ -0,0 +1,250 @@
> +======================
> +ioctl based interfaces
> +======================
> +
> +:c:func:`ioctl` is the most common way for applications to interface

Please don't use :c:func: anymore.  If you just say "ioctl()" the right
thing will happen (which is nothing here, since there isn't anything that
makes sense to link to in the internal kernel context).

We need a checkpatch rule for :c:func: I guess.

Similarly, later on you have:

> +Timeout values and timestamps should ideally use CLOCK_MONOTONIC time,
> +as returned by ``ktime_get_ns()`` or ``ktime_get_ts64()``.  Unlike
> +CLOCK_REALTIME, this makes the timestamps immune from jumping backwards
> +or forwards due to leap second adjustments and clock_settime() calls.

Making those functions ``literal`` will defeat the automatic
cross-referencing.  Better to just say ktime_get_ns() without quotes.

[...]

> +* On the x86-32 (i386) architecture, the alignment of 64-bit variables
> +  is only 32 bit, but they are naturally aligned on most other
> +  architectures including x86-64. This means a structure like
> +
> +  ::

You don't need the extra lines here; just say "...a structure like::"

> +    struct foo {
> +        __u32 a;
> +        __u64 b;
> +        __u32 c;
> +    };
> +

Thanks,

jon
