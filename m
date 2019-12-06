Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2201EC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34AF24673
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gCNs62mW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfLFNpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:45:49 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43607 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfLFNpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 08:45:49 -0500
Received: by mail-ot1-f66.google.com with SMTP id p8so5789567oth.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 05:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sre7idJ66ns9HmqMMb7e5mWZwsJ1nL57ygQluA76u3k=;
        b=gCNs62mWzKEv6640t6pTWokgoQ7DetFtygvJZvPhmcA1HyAdqHQ6kC1kMhsRglY3xc
         Gfto8kjaJAehVU3wfcHfrglM+DenPz6KRsE303NkoS64BQ1pXY4/qtZAI6rUVHUz13v0
         vFQPgZTBP8n0wLEC008FGzkb6ydvILQQD55XchGNft2YiTIDsScXuNcq1D9Fqn2SXNks
         /MynJBZCkLwB/tqNncT0cq/qlrZb/6acEzcorGaI5RHXWA1d0N9KyEE8xu6wY3dh6iET
         7FktlNTrOhopuOY1ekUlDuhsy5tnuHIF2eq1qeJnAd4srVGSj5eNIa9H6f23odMZxT/j
         gG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sre7idJ66ns9HmqMMb7e5mWZwsJ1nL57ygQluA76u3k=;
        b=sbmGTQu7Q1Zf9oYQ0qXj2tUvEbaj/u9JvkMtN3CjEmrslIvdOFlbqW/wZzGu8tFpaH
         eh9V3/v1stprko+ShGEQUEVM9hWOCPlqpMAruRZyNEEYxle/F/ufj2tpCuoxHlltTe/g
         yp7WVNWksZljNmv6BXYJrVjl3uPxotgRswUHqYouCCw9ZJWh39DGbX1VVncKb+EBXzpg
         6a0KCAoBDnj3UTK37i6B/hw4rpAtTX4JQjCXOolXcBETFOwoOg/Z0+zlbgQqbsP0H3rW
         Fa20oML6S/SxsN3vyVsTYRcuGXBlBqH6wV+GwQnnIKu38ho3y4lcM2Yej6KPiO3m49qh
         VSfQ==
X-Gm-Message-State: APjAAAUJV/KfPavzGG2IJorCbqMdCi1P/UyqKobcRXA/ZQE1b/7anmo1
        dEm7yb/yUb9rIsP/aIoHt3MMI3HJD/lFPxg8Lx3OfA==
X-Google-Smtp-Source: APXvYqy1ytWcZ4+jFawCM3T2yZXO4KBaIpQ3boyExdFNcnIbciwVGfRsCvJMHJrbaNtbpnERU5/k69RnTqppOG3ekEg=
X-Received: by 2002:a05:6830:1d6a:: with SMTP id l10mr9493578oti.233.1575639948274;
 Fri, 06 Dec 2019 05:45:48 -0800 (PST)
MIME-Version: 1.0
References: <9e91020876029cfefc9211ff747685eba9536426.1575638983.git.andreyknvl@google.com>
In-Reply-To: <9e91020876029cfefc9211ff747685eba9536426.1575638983.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 6 Dec 2019 14:45:37 +0100
Message-ID: <CANpmjNMVW_=8Mg3gERZFKd7NyJS3AS2e7nO33B0PczAsXm7xqg@mail.gmail.com>
Subject: Re: [PATCH v2] kcov: fix struct layout for kcov_remote_arg
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Jacky . Cao @ sony . com" <Jacky.Cao@sony.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Dec 2019 at 14:31, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Make the layout of kcov_remote_arg the same for 32-bit and 64-bit code.
> This makes it more convenient to write userspace apps that can be compiled
> into 32-bit or 64-bit binaries and still work with the same 64-bit kernel.
> Also use proper __u32 types in uapi headers instead of unsigned ints.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: Marco Elver <elver@google.com>

Thanks!

> ---
>
> Changes v1->v2:
> - Use __aligned_u64 instead of adding a __u32 reserved field.
>
>  Documentation/dev-tools/kcov.rst | 10 +++++-----
>  include/uapi/linux/kcov.h        | 10 +++++-----
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
> index 36890b026e77..1c4e1825d769 100644
> --- a/Documentation/dev-tools/kcov.rst
> +++ b/Documentation/dev-tools/kcov.rst
> @@ -251,11 +251,11 @@ selectively from different subsystems.
>  .. code-block:: c
>
>      struct kcov_remote_arg {
> -       unsigned        trace_mode;
> -       unsigned        area_size;
> -       unsigned        num_handles;
> -       uint64_t        common_handle;
> -       uint64_t        handles[0];
> +       __u32           trace_mode;
> +       __u32           area_size;
> +       __u32           num_handles;
> +       __aligned_u64   common_handle;
> +       __aligned_u64   handles[0];
>      };
>
>      #define KCOV_INIT_TRACE                    _IOR('c', 1, unsigned long)
> diff --git a/include/uapi/linux/kcov.h b/include/uapi/linux/kcov.h
> index 409d3ad1e6e2..1d0350e44ae3 100644
> --- a/include/uapi/linux/kcov.h
> +++ b/include/uapi/linux/kcov.h
> @@ -9,11 +9,11 @@
>   * and the comment before kcov_remote_start() for usage details.
>   */
>  struct kcov_remote_arg {
> -       unsigned int    trace_mode;     /* KCOV_TRACE_PC or KCOV_TRACE_CMP */
> -       unsigned int    area_size;      /* Length of coverage buffer in words */
> -       unsigned int    num_handles;    /* Size of handles array */
> -       __u64           common_handle;
> -       __u64           handles[0];
> +       __u32           trace_mode;     /* KCOV_TRACE_PC or KCOV_TRACE_CMP */
> +       __u32           area_size;      /* Length of coverage buffer in words */
> +       __u32           num_handles;    /* Size of handles array */
> +       __aligned_u64   common_handle;
> +       __aligned_u64   handles[0];
>  };
>
>  #define KCOV_REMOTE_MAX_HANDLES                0x100
> --
> 2.24.0.393.g34dc348eaf-goog
>
