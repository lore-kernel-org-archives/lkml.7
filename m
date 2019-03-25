Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F459C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4201B205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hF9oT9PX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbfCYRbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:31:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42959 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCYRbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:31:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id cv12so274539plb.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 10:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fIU86oE+jQ0Yd0olvbzoJq3YAdF1N4vYXbtyrqL8kZg=;
        b=hF9oT9PXzvQRfqIGbtMUuKcXVNKxOSQ+cfEyJ9956lqnZANaQcnGcjUPnnmdRkGZUg
         Ko9WAE8X2CDPkX1iPOTbnSIiQjZ0dBE7ZmZpXjOh5RM8TT2lTXT5aO1SV967FZS+LHBT
         sEmhTzRl9q/0+Ihny+YK26I85deCiHsB0/Ye/M+EwDlGe+vHT8an4PICssjLG4CC7BLk
         QuW74fl6/MMwSJe9/R7Lj3SQ01SHZxNQb1F3j1saFmZBjPrSUcJ6607im8OQvK7zQ/2O
         iBYO6cx31uPgrvD4Bdm58XmTNRTYI55ZqKJdTclc7sJO76EgzfxWPtilZdA4/PJH4pvq
         UFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fIU86oE+jQ0Yd0olvbzoJq3YAdF1N4vYXbtyrqL8kZg=;
        b=oD+H0Mvu4D7VrfDiOhyU4jgtoWUJ0wEhKZNtQSCxWxDK3QHJDOrnYipZ5NthFaq/DR
         VAmLdrj6YywA2zfJ5j6INDQKLQrariXS+qxk0wxIdojqUCUhWtdIVTH4+oOS0t/MbJBE
         c3Aj911u70XlsHHVMF82/w2nHKbS209WTNMtX+BLQruHD34wHt/fu+PGnHlJSYlf9DxX
         V4tFkHVkUSqrSdGrPJmRV3r9G2d/E/yxVRog1tGHKMPVD1eVyaPHdq/74wJqC/0pVJ5G
         cZpY7Hjoa4uouJvtgteflZpSWSxTGi+ZM9WmFW1/RP4oleG8I+GtyA3ld5migvCo5i/g
         dOdA==
X-Gm-Message-State: APjAAAWXD9BV6ZVHpjoxcDoyapLDwPsR/E37FGWJ39jz/qjI05AXQnLY
        1RqyOUMuCRYBIIgzJsWNQYXipzl3SLEF8OXghvhcvw==
X-Google-Smtp-Source: APXvYqz/KOpaTDmJ9VQq3Z6oKCoOoFlqX6ADB2ovXmR9prFEc3vYCBBKoxW+xhjH5BLjVNDA4ObaEFbByPkH3r2vjyM=
X-Received: by 2002:a17:902:8e82:: with SMTP id bg2mr26684589plb.217.1553535081625;
 Mon, 25 Mar 2019 10:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190325124930.1435409-1-arnd@arndb.de>
In-Reply-To: <20190325124930.1435409-1-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Mar 2019 10:31:10 -0700
Message-ID: <CAKwvOdkLmJaDH8XdCQBJkiFztme3_c7-AE+Z47imkdYA0n4ShQ@mail.gmail.com>
Subject: Re: [PATCH] chelsio: use BUG() instead of BUG_ON(1)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vishal Kulkarni <vishal@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Casey Leedom <leedom@chelsio.com>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        Arjun Vynipadath <arjun@chelsio.com>, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 5:49 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> clang warns about possible bugs in a dead code branch after
> BUG_ON(1) when CONFIG_PROFILE_ALL_BRANCHES is enabled:
>
>  drivers/net/ethernet/chelsio/cxgb4/sge.c:479:3: error: variable 'buf_size' is used uninitialized whenever 'if'
>       condition is false [-Werror,-Wsometimes-uninitialized]
>                 BUG_ON(1);
>                 ^~~~~~~~~
>  include/asm-generic/bug.h:61:36: note: expanded from macro 'BUG_ON'
>  #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
>                                    ^~~~~~~~~~~~~~~~~~~
>  include/linux/compiler.h:48:23: note: expanded from macro 'unlikely'
>  #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/net/ethernet/chelsio/cxgb4/sge.c:482:9: note: uninitialized use occurs here
>         return buf_size;
>                ^~~~~~~~
>  drivers/net/ethernet/chelsio/cxgb4/sge.c:479:3: note: remove the 'if' if its condition is always true
>                 BUG_ON(1);
>                 ^
>  include/asm-generic/bug.h:61:32: note: expanded from macro 'BUG_ON'
>  #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
>                                ^
>  drivers/net/ethernet/chelsio/cxgb4/sge.c:459:14: note: initialize the variable 'buf_size' to silence this warning
>         int buf_size;
>                     ^
>                      = 0
>
> Use BUG() here to create simpler code that clang understands
> correctly.

This is more concise and better expresses what we want to do here.
Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c | 2 +-
>  drivers/net/ethernet/chelsio/cxgb4/sge.c           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
> index 3130b43bba52..02959035ed3f 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
> @@ -2620,7 +2620,7 @@ static inline struct port_info *ethqset2pinfo(struct adapter *adap, int qset)
>         }
>
>         /* should never happen! */
> -       BUG_ON(1);
> +       BUG();
>         return NULL;
>  }
>
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
> index 88773ca58e6b..b3da81e90132 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
> @@ -476,7 +476,7 @@ static inline int get_buf_size(struct adapter *adapter,
>                 break;
>
>         default:
> -               BUG_ON(1);
> +               BUG();
>         }
>
>         return buf_size;
> --
> 2.20.0
>


-- 
Thanks,
~Nick Desaulniers
