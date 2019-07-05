Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69703C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5AE21852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iDK20ETp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfGEJ2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:28:11 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39932 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfGEJ2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:28:10 -0400
Received: by mail-oi1-f194.google.com with SMTP id m202so6720115oig.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 02:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zS8S9H9AbLZAyLr81qb94mZjTnAH3YzyDKOLBvj6lLk=;
        b=iDK20ETpNO7KF5Suti87dkpQGGE94gt/WqR+UuMVEAldoiGs9wASNGYTNJm/jTnsMD
         eHGFCv3jGE98FwKAL0+b+QgMGmDBwnJRtC0ELAXyRv8QwlYpcLcxHtdDRDa7IVfNJQsG
         92wQuonQuWjRA9KSTw6S6YYrlfM7n3KLQNPLW/aSm3ILK805vtgd63hUPfqzk3eDWkW8
         nR3/asQvqhHOVQM0fjUCMZr+xHVQMIlo8bN07BzmFdP1LwD/bfsJzHPM2Qv04C07m+iw
         LnIf918+wXa3gSJ3/G0W7ZoThxxOLq6qI/h4F7iJTxZi4lbV7MditpnAehJVY89Zi5sU
         0nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zS8S9H9AbLZAyLr81qb94mZjTnAH3YzyDKOLBvj6lLk=;
        b=PpC2JA+Jj28I3B6dJ6x/5LFm9ktk8Er6Khx5F587kZDYMGFcffln131xNp/Icy/sAs
         fd/pU7++s6zF2moKNKGsQ34W/8VoOJBxYxfrMNwvIOnZg1NoVFyfDUROZUwWc7nchzHh
         oyv9Z9vxuZLvNQX+3gKO+ALTew9PbEmU9v4yGIDrSJFb1mq3kZb09Y5FXCG1P1ets2oe
         ypHrdWQudT6Ze7gsEp07NcQASPTNUFhXaN7CIHr4a9+eMAGtFAklUhvRREoZmC8ETcFK
         +9uFTyVuiQfgKRZ2zbDw0fsKlAAqgD/Osk5qqvyQszAOsFPUOytXxoBqXVyboJk6DsB9
         CVdQ==
X-Gm-Message-State: APjAAAUeJr1x94X+eIJhuIywg6sZlQ2A8ISvE+x+S9ANQ5F1omNpMy+e
        JQFIH/zyl2PHsssPFZyt2n6vxW/7lvL2INWH4n3ruzVl
X-Google-Smtp-Source: APXvYqxWPHLAHk5InL17x7b5nOFeiSVFxnFojoqcX5d9DBobJVe4cQ7uu+zZn6rxaWS+Gr+LQnhsauLWGZiQlqxrrPY=
X-Received: by 2002:aca:6104:: with SMTP id v4mr1529831oib.172.1562318889763;
 Fri, 05 Jul 2019 02:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190705184949.13cdd021@canb.auug.org.au>
In-Reply-To: <20190705184949.13cdd021@canb.auug.org.au>
From:   Marco Elver <elver@google.com>
Date:   Fri, 5 Jul 2019 11:27:58 +0200
Message-ID: <CANpmjNN-BYeiKk+S3sK6joknC1dnxUUgCqUPFCJuiYd2xVHWPg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jul 2019 at 10:49, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the akpm-current tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> In file included from include/linux/compiler.h:257,
>                  from arch/arm/kernel/asm-offsets.c:10:
> include/linux/kasan-checks.h:14:15: error: unknown type name 'bool'
>  static inline bool __kasan_check_read(const volatile void *p, unsigned int size)
>                ^~~~
> include/linux/kasan-checks.h:18:15: error: unknown type name 'bool'
>  static inline bool __kasan_check_write(const volatile void *p, unsigned int size)
>                ^~~~
> include/linux/kasan-checks.h:38:15: error: unknown type name 'bool'
>  static inline bool kasan_check_read(const volatile void *p, unsigned int size)
>                ^~~~
> include/linux/kasan-checks.h:42:15: error: unknown type name 'bool'
>  static inline bool kasan_check_write(const volatile void *p, unsigned int size)
>                ^~~~
>
> Caused by commit
>
>   4bb170e54bbd ("mm/kasan: change kasan_check_{read,write} to return boolean")
>
> I have added the following patch for today:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 5 Jul 2019 18:44:55 +1000
> Subject: [PATCH] mm/kasan: include types.h for "bool"
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  include/linux/kasan-checks.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.h
> index 2c7f0b6307b2..53cbf0ae14b5 100644
> --- a/include/linux/kasan-checks.h
> +++ b/include/linux/kasan-checks.h
> @@ -2,6 +2,8 @@
>  #ifndef _LINUX_KASAN_CHECKS_H
>  #define _LINUX_KASAN_CHECKS_H
>
> +#include <linux/types.h>
> +
>  /*
>   * __kasan_check_*: Always available when KASAN is enabled. This may be used
>   * even in compilation units that selectively disable KASAN, but must use KASAN
> --
> 2.20.1
>
> --
> Cheers,
> Stephen Rothwell

Apologies for the breakage -- thanks for the fix! Shall I send a v+1
or will your patch persist?
