Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA2CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3882087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6OBewAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfCHN20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:28:26 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33420 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCHN2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:28:25 -0500
Received: by mail-pf1-f196.google.com with SMTP id i19so14184886pfd.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 05:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FyjpcBkC3+QXgBsEHjZu+57owpddRjqMxQQ5rKRaBBs=;
        b=m6OBewAWjkywbpCPTSZabjiZXhK9buy+zAMSO87deXEe85TsdqiOb82Ps2UO9CaQwj
         SdTfU95zwNKBM3pwRRNO/1GwzPAygbEFDWXL2MRjqR5MtUcp6OZ6P88u36nSn3uQYkk5
         Iw7dypPK0jor2LxLRL4mOcoIqGjdpVOrdGaPhkCY7cZRbiVfKcszX4i9YDVZrbAjb3Uk
         8PAylcobfSsQ73t/dXOTVgoUorAjAbtXboW+Pr3fPMDS9KiIDS50MFl5h39BwdlVlA2K
         GrLLBo1K/6nu1mtaxtwg3b+/P8ByJI5Yrwg5awMFQ7W121ITksrDtw2gYsmvfeO6OQa9
         GhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FyjpcBkC3+QXgBsEHjZu+57owpddRjqMxQQ5rKRaBBs=;
        b=CXgKTkqwr+LwAq6j64cUfn/0wKhr29FbFx4oJtXY5CI3JNf9wUnc24vVOzb8K13IS8
         GnHI98QeK76lBwcHhcN30aT2FaOdtNLPBKMRKoheh4ZeJXOrgHHNG8EsmplqbkLzTQhH
         mx+CM3LQLLDu7ypQUfAJoghNuUlMz8HSWnlKLvchslxYDQrVmzHymgDrMxbwOnKxZe5G
         lLIiYOA9tNCuDwZJwFf08tLM7n+6vBf7rOj0+2sAVRRbfLw9qnUiTWmEACv/aZtcabbH
         acPfcuSmMfHV7w18ETkng93y1LFy8DAFA+ikM3Nw8/c6MtbFPDjVS4aASq57UR7RtjYu
         j4RA==
X-Gm-Message-State: APjAAAXsegOFjPT4DECVGO4EIP5KhIlNTfYaxqtaxkTkTAl3JDMtol/k
        5uk91LVLir0HoPV8uSmOg/Q70SiS7cJ+m+MtMD0LPw==
X-Google-Smtp-Source: APXvYqyu0BPW0Y9CUwYxR0k8WbBupMRI6PneB77HpPmxRnIqWxoBwJhmZog67CqS6mTUUH4Fzm4ztWenK+uQk7wDVBI=
X-Received: by 2002:a65:6651:: with SMTP id z17mr15878595pgv.95.1552051704883;
 Fri, 08 Mar 2019 05:28:24 -0800 (PST)
MIME-Version: 1.0
References: <20190307185244.54648-1-cai@lca.pw>
In-Reply-To: <20190307185244.54648-1-cai@lca.pw>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 8 Mar 2019 14:28:14 +0100
Message-ID: <CAAeHK+xdGubYXJiJi7J=1NH+-iB_yhXgoMWqacf=xh5UnugO1A@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix variable 'tag' set but not used warning
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 7:53 PM Qian Cai <cai@lca.pw> wrote:
>
> set_tag() compiles away when CONFIG_KASAN_SW_TAGS=n, so make
> arch_kasan_set_tag() a static inline function to fix warnings below.
>
> mm/kasan/common.c: In function '__kasan_kmalloc':
> mm/kasan/common.c:475:5: warning: variable 'tag' set but not used
> [-Wunused-but-set-variable]
>   u8 tag;
>      ^~~
>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  mm/kasan/kasan.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 3e0c11f7d7a1..3ce956efa0cb 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -163,7 +163,10 @@ static inline u8 random_tag(void)
>  #endif
>
>  #ifndef arch_kasan_set_tag
> -#define arch_kasan_set_tag(addr, tag)  ((void *)(addr))
> +static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
> +{
> +       return addr;
> +}
>  #endif
>  #ifndef arch_kasan_reset_tag
>  #define arch_kasan_reset_tag(addr)     ((void *)(addr))
> --
> 2.17.2 (Apple Git-113)
>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

Thanks!
