Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737DEC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495F52075B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="REmo1GJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387405AbfEWSFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 14:05:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36472 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731093AbfEWSFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 14:05:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id v80so3674299pfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 11:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EGvOP3+NbBL/ooRQ1YmiUrB6TsdEmMLRkxxwgSQubSk=;
        b=REmo1GJpTDjXtFLbJ30rqVT5Q+QhHvY/DfM7u/X3ZhgyxYtXiLgOrIv9AqVBnIlpBk
         WHQ84d0bgZ2SYfsYN1b38aDnU8CIy4FS1jaMhJI+5vxzalfT5PkYcxuZMEIN+uWcx29/
         6BzJbP4Q3WYBbB50N2akYp1ooKcSWAiqS3YIWiDBcfx5jh4t+3GII9UUnkfsQxtPOtmL
         0l5RgM/SPdp5wtgYZ5k+bgLrdsSwODkXemkZkG+51mpCSd3XMD5Gu9YLn9bPTnvMwgCY
         pzrU5vnCXi9w//aLp8uWF7SKdXpuSgMkhTiFl1aWHKIjnOumzAZY6rqd7FrGnwmUJVtk
         xMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EGvOP3+NbBL/ooRQ1YmiUrB6TsdEmMLRkxxwgSQubSk=;
        b=QFDYtZFJLoFNXxiBA76KQj5CfRDNho24RZlCGSEASJhguRwGxcl2AeD0sDi1xYg7HQ
         RjqKT79LRGB/JKjSIk4uGdG0nIQNysfI173HLF+VOXDP8085Z02m/Yej/3q7wOvaT4Py
         JgYyUovIefpb/Y9N1u4+aj9rNTbTrv9bE9iaJut1W71I5cGY1r//QPSdq+7Wo6UDr8wp
         eRLN4WgXh95HvY3iBqmib0x6siDpL5aNqDzksMYle5xesCDDyHrat/5OF4O8WU8BAw0+
         OjLpH9guib4Lp/9gSTn5hpzfDioGxIH1dmm2Ul1xDYOqkPp0aa+d0wFuBQg8aptTWCmf
         kV1Q==
X-Gm-Message-State: APjAAAWgAlwX7kugsk5Jun2nUV3PMWm9hA6W1Mg7kCFJdmk+zH8iqqOH
        B1Rhi8qYnO3HrGj3fjSPndT1rGSNXgv9cI2eRQe61A==
X-Google-Smtp-Source: APXvYqwGqANO+lMOF4dqDY4P959QJyrsr85rubnefFl4yoImZ3JpCsbFjLU2m2dk+muHvoihFa+M85drOfcK5RrMuj4=
X-Received: by 2002:a63:a709:: with SMTP id d9mr31338141pgf.263.1558634739788;
 Thu, 23 May 2019 11:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAAzmS69VFrTPzZ8DY_NPPTZYtBssocRnQOFAyo3VbSTO4CesbA@mail.gmail.com>
 <20190523161532.122421-1-natechancellor@gmail.com>
In-Reply-To: <20190523161532.122421-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 23 May 2019 11:05:28 -0700
Message-ID: <CAKwvOdmjQvCh__ZH+gLLgcKy4u1n5cgJQPU1WRuitEp+UZra5w@mail.gmail.com>
Subject: Re: [PATCH] misc: sgi-xp: Properly initialize buf in xpc_get_rsvd_page_pa
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Cliff Whickman <cpw@sgi.com>, Robin Holt <robinmholt@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Stephen Hines <srhines@google.com>, tony.luck@intel.com,
        rja@sgi.com, fenghua.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

From https://github.com/ClangBuiltLinux/linux/issues/466#issuecomment-488781917
I tried to follow the rabbit hole, but eventually these void* get
converted to u64's and passed along to function that I have no idea
whether they handle the value `(u64)(void*)0` or not.  Either way,
they definitely don't handle uninitialized values/UB.

I was going to cc Robin who's already cc'ed, but looks like this code
was last touched 7-10 years ago. + Tony and Fenghua for ia64 since
sn_partition_reserved_page_pa is defined in
arch/ia64/include/asm/sn/sn_sal.h.

In absence of consensus, I'll prefer NULL to uninitialized.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Thanks Nathan for following up on this.

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


-- 
Thanks,
~Nick Desaulniers
