Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C75C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 18:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE372086D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 18:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="moU2u1V3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733012AbfFYScz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 14:32:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36317 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732725AbfFYScz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 14:32:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so9926559pfl.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 11:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D1yWkLuPQ28KWW7K7QdlJ9HbJ+2HGPcbZ0bmcIG8Xo0=;
        b=moU2u1V3Qh8J1hPlHaZz1CymCnc1sa24lshPcARXEL6urfTJZhOxDuV4nfrO8mjbVs
         yugdY3l66uhheDa8r4QbmMwexq/mmHKgsAvf0R4EmF5zsxPsXq8HVASzWwXnepJuPSmi
         e/spoalsDXQgxxTJ+zY6UbGtmagTbQ4KQ+9F+skLXdblT9s/6tRp3nHfzZXsIaXD8NIv
         slmLmG4/Tjkm1ZbBGy2Ya/4anlhlR/+oPenq9+YlNR1RdxOtP7N68M+XQUiebj/IwRmE
         Kv5u6IwxmRZH0N5P+tEseNu2K94msKftEYgJebGbUi/1U2frF4bavWJ+w5KXGClYpT1D
         nsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D1yWkLuPQ28KWW7K7QdlJ9HbJ+2HGPcbZ0bmcIG8Xo0=;
        b=fzQc/F7aD4h793bFSBYZmtAn0JEjPv+tCi9prTSbHa7lfdjtjviM4FhiTDapZwsMi9
         DenoQ4AXBcSmqXqOqGJWgkaw2M43eZVDiTQXyWRjWoAYu+WrMQCHwAiW0JB2jRw83kRb
         yise5j8IGpc+7NGHx71VCFGiY2PGxhDw95vvwvmdFSgB/oUZ20IFHZA8q6UmWYFOqqqd
         dHVZ+bfqgAuqQ/BxuezFOeYTPqq+mUby2U78cbRv8ySCn8j6uFj+XSps/RxkkwqtAb0c
         UomNkdmT5ZH/lJwEIFrRLp4sXgpQAgd/fYC5+DeyKxHcWGLzSn6Lw7itLt5t8HXp1uYZ
         6YTw==
X-Gm-Message-State: APjAAAVNXfUcUgVk0DMZl3vIA5JL6p05wCxOUnYH+k5S4v6rOj3150KW
        aQEN4BouJS2QVMaglxuOEEUwp6h3yPoUpPL2R3LWfg==
X-Google-Smtp-Source: APXvYqyKjZ/WKdRGYvvfMtHRGXNfsMEhqydqLgglBcUWoW+MIQpM+Bv1t6eGKozRx5tmkn3zgYBW6uQjx7xYhNKsGns=
X-Received: by 2002:a63:52:: with SMTP id 79mr39875246pga.381.1561487574002;
 Tue, 25 Jun 2019 11:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190625182352.13918-1-natechancellor@gmail.com>
In-Reply-To: <20190625182352.13918-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Jun 2019 11:32:42 -0700
Message-ID: <CAKwvOdkdXRRrTSukQ4mJ6FfjqD-GJeBzOK34e+=jJzaQ3qOaiw@mail.gmail.com>
Subject: Re: [PATCH] xsk: Properly terminate assignment in xskq_produce_flush_desc
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        xdp-newbies@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 11:24 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> In file included from net/xdp/xsk_queue.c:10:
> net/xdp/xsk_queue.h:292:2: warning: expression result unused
> [-Wunused-value]
>         WRITE_ONCE(q->ring->producer, q->prod_tail);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/compiler.h:284:6: note: expanded from macro 'WRITE_ONCE'
>         __u.__val;                                      \
>         ~~~ ^~~~~
> 1 warning generated.
>
> The q->prod_tail assignment has a comma at the end, not a semi-colon.
> Fix that so clang no longer warns and everything works as expected.

oh no! -Wunderhanded-C-contest-style-use-of-comma-operator strikes again!
Great find and thanks for the fix.
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

Bj=C3=B6rn and Alexei should carefully review.  Because WRITE_ONCE is a
macro that expands to a GNU C statement expression, which returns the
last statement, this code was previously assigning q->prod_tail to
itself, now it's assigning it to q->prod_head.  I assume that was not
intentional, but am unfamiliar with the code.

>
> Fixes: c497176cb2e4 ("xsk: add Rx receive functions and poll support")
> Link: https://github.com/ClangBuiltLinux/linux/issues/544
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  net/xdp/xsk_queue.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 88b9ae24658d..cba4a640d5e8 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -288,7 +288,7 @@ static inline void xskq_produce_flush_desc(struct xsk=
_queue *q)
>         /* Order producer and data */
>         smp_wmb(); /* B, matches C */
>
> -       q->prod_tail =3D q->prod_head,
> +       q->prod_tail =3D q->prod_head;
>         WRITE_ONCE(q->ring->producer, q->prod_tail);
>  }
>
> --
> 2.22.0
>


--=20
Thanks,
~Nick Desaulniers
