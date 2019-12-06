Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,PDS_BTC_ID,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0B6C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD442464E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pVaEs/7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfLFNO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:14:56 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34561 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfLFNO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 08:14:56 -0500
Received: by mail-ot1-f65.google.com with SMTP id a15so5769113otf.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 05:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZoSZp9ZzspcRVMqcug2BOifenKWThAPMs8ZQHw9EX40=;
        b=pVaEs/7sVuWiIJMj3Jgcc702YDx40mew6E9pnFyXHYY3cl6yI7+FTWUhKrzENWTyOD
         bvVQv1ZzZTbAVtigUVfLcJxvSIsTkEeymIvsSsDTGFhhwScUd5P02HN8XfOQY76UNEG9
         HmWZ64z7Ia+TjWSa02CxkRhNMau6QwnH2jEXSmtqWHIcObIwPBXiDMaPYXbrz1VdXMLL
         bkk0IspiQiAQIEd7ou2wjQfhRLfIeu2vi2Skbq0UnBCHISRTXNOkGKg63XbtkY9Er+t7
         iX9sSDLiX7YSQo/EOSASdxpqLVef84dFGEavyadRhS7diGhMZ5InFR47VA6Uj7BONoAD
         RtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZoSZp9ZzspcRVMqcug2BOifenKWThAPMs8ZQHw9EX40=;
        b=e49nxNbiY16pk96yyBWgPplRvj0HDjYV9D7JLOvKjM/mzUwdtPa/LRIEK2JSzlQG+m
         mGaLrk2RkuZTRYAXuE48DrjygKdRaNhG4xtvYI6s7/Vq6yUJ/fyzcy5aD9R0iBOGiOwv
         QxBWs7wbjwdYyx2L3i0xbENk6m8p7PWZach/L2Gj9F6bZwiACLRQ1XGUb9X4T7kQMc81
         CQx0/MJWzrGSPhU2yX8wqY3e+wDINeMeBwwMMwON8VY8UoQ7x3kQPvGWwe0dSHKjGouY
         DOL8QWeRXpWyKnCIY8kHVNMKYnsy4XHYf8Cf1sFXfpyjHK/5CCOnSM8PaAdw56RteT0K
         fd4g==
X-Gm-Message-State: APjAAAW1955XH4CEPmvm918+d+WJW5L4vgNryoetWLFbEHrvKEbSCpyx
        slcjSOstk5s6F+qBW+GYvgyXr5Esgm4W3skzjhesf0ozU4kUhg==
X-Google-Smtp-Source: APXvYqzoTDlUCtq5xOKPek/B8zeMFIY/7HIchhvNSNqebfpXm/R9u1OpfWk6gJ50yZOlq11DXRgRE15Bq8h8S5yb2Uk=
X-Received: by 2002:a9d:7f12:: with SMTP id j18mr11190523otq.17.1575638094349;
 Fri, 06 Dec 2019 05:14:54 -0800 (PST)
MIME-Version: 1.0
References: <46cee2a09d53921057cd4b87d1ed3796a2ab15bb.1575637022.git.andreyknvl@google.com>
In-Reply-To: <46cee2a09d53921057cd4b87d1ed3796a2ab15bb.1575637022.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 6 Dec 2019 14:14:43 +0100
Message-ID: <CANpmjNPb988whEFQW+msYpdco=_=CXwG1mj+apy7U7ARJ3s0CQ@mail.gmail.com>
Subject: Re: [PATCH] kcov: fix struct layout for kcov_remote_arg
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Dec 2019 at 14:05, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Make the layout of kcov_remote_arg the same for 32-bit and 64-bit code.
> This makes it more convenient to write userspace apps that can be compiled
> into 32-bit or 64-bit binaries and still work with the same 64-bit kernel.
> Also use proper __u32 types in uapi headers instead of unsigned ints.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>
> Hi Andrew,
>
> We've noticed failures on 32 bit syzbot instances when the kcov patches
> got merged into mainline. The reason is that the layout of kcov_remote_arg
> depends on the alignment rules, which are different for 32/64 bit code.
> We can deal with this issue in syzkaller [1], but I think it would be
> cleander to get this fixed in the kernel.
>
> I hope this patch is acceptable, since the change has just been merged and
> is not included into a release kernel version. The patch breaks the newly
> introduced kcov API for 32 bit apps.
>
> Sorry for not testing it with 32 bit code earlier.
>
> Thanks!
>
> [1] https://github.com/google/syzkaller/commit/ba97c611a36b7729d489ebca5f97183c2ba7a90a
>
>  Documentation/dev-tools/kcov.rst |  7 ++++---
>  include/uapi/linux/kcov.h        | 11 ++++++-----
>  2 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
> index 36890b026e77..744df2bae1ed 100644
> --- a/Documentation/dev-tools/kcov.rst
> +++ b/Documentation/dev-tools/kcov.rst
> @@ -251,9 +251,10 @@ selectively from different subsystems.
>  .. code-block:: c
>
>      struct kcov_remote_arg {
> -       unsigned        trace_mode;
> -       unsigned        area_size;
> -       unsigned        num_handles;
> +       uint32_t        trace_mode;
> +       uint32_t        area_size;
> +       uint32_t        num_handles;
> +       uint32_t        reserved;
>         uint64_t        common_handle;
>         uint64_t        handles[0];
>      };
> diff --git a/include/uapi/linux/kcov.h b/include/uapi/linux/kcov.h
> index 409d3ad1e6e2..53267f9f1665 100644
> --- a/include/uapi/linux/kcov.h
> +++ b/include/uapi/linux/kcov.h
> @@ -9,11 +9,12 @@
>   * and the comment before kcov_remote_start() for usage details.
>   */
>  struct kcov_remote_arg {
> -       unsigned int    trace_mode;     /* KCOV_TRACE_PC or KCOV_TRACE_CMP */
> -       unsigned int    area_size;      /* Length of coverage buffer in words */
> -       unsigned int    num_handles;    /* Size of handles array */
> -       __u64           common_handle;
> -       __u64           handles[0];
> +       __u32   trace_mode;     /* KCOV_TRACE_PC or KCOV_TRACE_CMP */
> +       __u32   area_size;      /* Length of coverage buffer in words */
> +       __u32   num_handles;    /* Size of handles array */
> +       __u32   reserved;

The kernel provides __aligned_u64 for this purpose (32/64 bit uapi
compatibility). Is adding an explicit 'reserved' better here? If so,
it'd be good to document.

Thanks,
-- Marco
