Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49D0C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32FF21921
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbfGVNeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:34:22 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38067 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfGVNeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:34:22 -0400
Received: by mail-qt1-f194.google.com with SMTP id n11so38497045qtl.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jQJN9DULZLKDWOm0dpoiua+cqLKY8sRI6jmek37s8zY=;
        b=GtJPz9jBPJzkFfEb90NdAaPFadAPVwOvAL/HiO+as87VWgegA/12RN0J3AXWvRg/O/
         yFWHnq/RHktK8csEUWKt5xWzx+uAxzOz/rjy5zgsui/i0g0Lqa3A87Kq9QLM3HNHxOS+
         VSV6TCbeMon4re1ZZmeVrpUt8W8Pv6Rx3+EBYJvpYoH7K6nXiEjyUJc79mTL8fZLn1k+
         LyUKsf6iuZ0ngkdorqYXXshrEkd6RE8PLxNa++ym2ChWjg4d+4y7pIN0D0CqreM49Qjn
         ndQFqZEMcFAAFKWhT6DEE+yTrHtxnpNUOPaiu2PZVfEm22RqA3HrOi4iuy9VvJNxrVbt
         7IBw==
X-Gm-Message-State: APjAAAX8U4Xlmor4EyKI/+Bxsac52yIglqbg+fgmfumuVHz2uxIZfepb
        0wvURyWXpSqRi4gO0yCH3/g0J4D2MuGqkhvwKAs3RI1D
X-Google-Smtp-Source: APXvYqxQW1DekiCteGUizjTypPf/QO4XURErkMAxOCtWM5a6p4L3ukY2FobFKZF+jzz7Ys0LEswav553xfFSEUaWrwI=
X-Received: by 2002:ac8:5311:: with SMTP id t17mr48218724qtn.304.1563802461127;
 Mon, 22 Jul 2019 06:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190721142308.30306-1-yamada.masahiro@socionext.com>
 <de9e94ee-9c01-1c0c-4359-b637319a298f@linux.intel.com> <s5hftmy8byl.wl-tiwai@suse.de>
 <ec306745-052d-f52c-2cce-d8915822d4ff@linux.intel.com>
In-Reply-To: <ec306745-052d-f52c-2cce-d8915822d4ff@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 22 Jul 2019 15:34:04 +0200
Message-ID: <CAK8P3a2tLuqu+upt0nW8dUzXc+t_kEJwVhLcqY8TXydHLb_nCw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: use __u32 instead of uint32_t in
 uapi headers
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 3:16 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 7/22/19 7:56 AM, Takashi Iwai wrote:
> > On Mon, 22 Jul 2019 14:49:34 +0200,
> > Pierre-Louis Bossart wrote:
> >>
> >>
> >>
> >> On 7/21/19 9:23 AM, Masahiro Yamada wrote:
> >>> When CONFIG_UAPI_HEADER_TEST=y, exported headers are compile-tested to
> >>> make sure they can be included from user-space.
> >>>
> >>> Currently, header.h and fw.h are excluded from the test coverage.
> >>> To make them join the compile-test, we need to fix the build errors
> >>> attached below.
> >>>
> >>> For a case like this, we decided to use __u{8,16,32,64} variable types
> >>> in this discussion:
> >>>
> >>>     https://lkml.org/lkml/2019/6/5/18
> >>
> >> these files are shared with the SOF project and used as is (with minor
> >> formatting) for the firmware compilation. I am not sure I understand
> >> the ask here, are you really asking SOF to use linux-specific type
> >> definitions?
> >
> > Actually this is linux-kernel UAPI header files, so yes, we should
> > follow the convention there as much as possible.
> >
> > So far we haven't been strict about these types.  But now we have a
> > unit test for checking it, so it's a good opportunity to address the
> > issues.
>
> Maybe a bit of background. For SOF we split the includes in 4 directories
>
> https://github.com/thesofproject/sof/tree/master/src/include
>
> - sof: internal includes for firmware only
> - ipc: definitions of the structures for information exchanged over the
> IPC channel. This directory is used as is by the Linux kernel and
> mirrored in include/sound/sof
> - user: definitions needed for firmware tools, e.g. to generate the
> image or parse the trace. this directory is not used by the Linux kernel.
> - kernel: definitions for the firmware format, needed for the loader to
> parse the firmware files. This is not directly used by applications
> running on the target, it really defines the content passed to the
> kernel with request_firmware. This directory is mirrored in the Linux
> include/uapi/sound/sof directory.
>
> Our goal is to minimize the differences and allow deltas e.g. for
> license or comments. We could add a definition for __u32 when linux is
> not used, I am just not sure if these two files really fall in the UAPI
> category and if the checks make sense.

If you can build all the SOF user space without these headers being
installed to /usr/include/sound/sof/, you can move them from
include/uapi/sound/sof to include/sounds/sof and leave the types
unchanged.

         Arnd
