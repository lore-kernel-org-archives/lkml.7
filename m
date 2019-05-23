Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20BFC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A642070D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E49P5qe4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731184AbfEWQqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 12:46:54 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34205 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731042AbfEWQqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:46:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id p27so10175358eda.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 09:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9BT48q8YZdsRfqqlq1WI5BEP04XlG5qRgRWBn7AKc74=;
        b=E49P5qe4m5z50mIcZEFehNywPQzUR2sTrsCDp7+OSPu94TJ5WPj6g4JT9ATXEEeN3i
         sVisvRi5Iane1ywRX7NtNSo3bNtGHc1/a+az/W4fDtuLbc87twSTs3T0FLCMzkd4h2Md
         gYqXEQpvkqs6D68Zg+Ty8k4Krc7l8H9ylcfFcgvPPCyCJIb/bxO7pV+eW4TIDQ1pP65F
         VBI41rxflmLGOaf9XKr3FvdLQzoT4CwXzRDXWwwCpwTv7K7RqP4KRnsI4SoPh/1+3M4A
         tb8wyvbpzyy2DMmmFuNtV7vOUBxU+FQSy2xfqaMS0VyejqGZ5NXkT2vhnC3uz5q07kaj
         eonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9BT48q8YZdsRfqqlq1WI5BEP04XlG5qRgRWBn7AKc74=;
        b=ZImnOHXij2rcvDLqFPeebjftlS8zvL9ND9UNB1qqVgQfu4BcrOC8liqfEfTHhcUF07
         5Nj2ankcy2DYYo3rvKY5uV61nLoxXJaxFH41B6U5NtJo9UsEZl14M2IWNqrxWx9PP01R
         YpQmkmX9S8Wwz54pOkl9pM5u/cm9XUmeD2g+Zs0w/z7AWp+O25OIOI0mWuOux5OAuhS3
         VcnkVRr5UrBq1b8qvvjJTEk86j9D2suZsek3HDpbtrjU9FRZFnGFzrsfULbpI6DFSwIC
         1UYvBRbGppcVxo2nhvKFiN8VZo5tpG2m+rKhr8WFtwPjiQsg2K89kmXrCGvD5Il6WuBN
         h3lg==
X-Gm-Message-State: APjAAAW0SO7fiwSUym4RXvVFDdKG7+4xfOB/Sz/9A4jfXwsY5enPkksm
        DcPA4h10jSQrdDxS6IW4HNmLmvYqFrBYEAQz4yDU6g==
X-Google-Smtp-Source: APXvYqxjRFBRjmxhMpY4EXrqj+b8yMDt6Q4S9LXD/g+esQ+xRVqrmJdaiutfxvQN1Y7ApAH+JmdaizeahP1PUhJevGI=
X-Received: by 2002:a17:906:1f93:: with SMTP id t19mr28144676ejr.48.1558630010971;
 Thu, 23 May 2019 09:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAAzmS69VFrTPzZ8DY_NPPTZYtBssocRnQOFAyo3VbSTO4CesbA@mail.gmail.com>
 <20190523161532.122421-1-natechancellor@gmail.com>
In-Reply-To: <20190523161532.122421-1-natechancellor@gmail.com>
From:   Stephen Hines <srhines@google.com>
Date:   Thu, 23 May 2019 09:46:38 -0700
Message-ID: <CAAzmS6_ENnGayTm6fbbbk8dojXrKUEB1P2_ZtP914_GCOaVOoQ@mail.gmail.com>
Subject: Re: [PATCH] misc: sgi-xp: Properly initialize buf in xpc_get_rsvd_page_pa
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Cliff Whickman <cpw@sgi.com>, Robin Holt <robinmholt@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me. :) Since I don't contribute to the Linux kernel
directly, I appreciate you picking this up.

Thanks,
Steve

On Thu, May 23, 2019 at 9:20 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/misc/sgi-xp/xpc_partition.c:73:14: warning: variable 'buf' is
> uninitialized when used within its own initialization [-Wuninitialized]
>         void *buf = buf;
>               ~~~   ^~~
> 1 warning generated.
>
> Initialize it to NULL, which is more deterministic.
>
> Fixes: 279290294662 ("[IA64-SGI] cleanup the way XPC locates the reserved page")
> Link: https://github.com/ClangBuiltLinux/linux/issues/466
> Suggested-by: Stephen Hines <srhines@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> Thanks Steve for the suggestion, don't know why that never crossed my
> mind...
>
> I tried to follow buf all the way down in get_partition_rsvd_page to see
> if there would be any dereferences and I didn't see any but I could
> have easily missed something.
>
>  drivers/misc/sgi-xp/xpc_partition.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/sgi-xp/xpc_partition.c b/drivers/misc/sgi-xp/xpc_partition.c
> index 3eba1c420cc0..782ce95d3f17 100644
> --- a/drivers/misc/sgi-xp/xpc_partition.c
> +++ b/drivers/misc/sgi-xp/xpc_partition.c
> @@ -70,7 +70,7 @@ xpc_get_rsvd_page_pa(int nasid)
>         unsigned long rp_pa = nasid;    /* seed with nasid */
>         size_t len = 0;
>         size_t buf_len = 0;
> -       void *buf = buf;
> +       void *buf = NULL;
>         void *buf_base = NULL;
>         enum xp_retval (*get_partition_rsvd_page_pa)
>                 (void *, u64 *, unsigned long *, size_t *) =
> --
> 2.22.0.rc1
>
