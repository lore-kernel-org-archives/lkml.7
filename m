Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF82CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 07:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A12E218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 07:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ig0VVUCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfCPHSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 03:18:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33724 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfCPHSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 03:18:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id i7so4754762pgq.0;
        Sat, 16 Mar 2019 00:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u3sbC08reZvYgVlfbGuyoWFBbGQX/mrKJKS2EaNa590=;
        b=Ig0VVUCXLwWKypLRgko1GdyHDN/OGtLBM1tdqcSaJn37WK2tODETNQJrHaXpulHQNr
         7QbLr4whMAvP3rDHLr5EqBrsTI/0kGGZsGgznFxKrUnQh001ZkaKM39CqqtxkhntdmWV
         YputxoxLhWUXAlp03EaEJrK3dPeqsI8wKAa5DynZwzabZ67fo62zoEEkHuppvbeiKOhu
         pXCrsxp1bStMBEz4feKIgWgHljtPFJ03I104+WRArNHQGqtZ/YjGDEN8KVrmQJr+6mOc
         ZkVnZ7p5TVZ5NKpgjXkaQ1dvDu3gCEwtTcrT1zt/b2Yy8oUU75NOQIqQdjWNvpkGgT3z
         +g0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u3sbC08reZvYgVlfbGuyoWFBbGQX/mrKJKS2EaNa590=;
        b=exm8XPO8Tjvl5l8ZCfy/36cSc7qqeSwu6KDDBk14w7WxX4KY23vPopACg7IuJFlSAq
         e+19KdVJ3XHlgRN75Lj9uelJWvbh2zTw4ohZIxxeyyyZ/tytyZeeWmKaRFVoDlaKu1SO
         BITm0HeUFoU9X46+ibELK7qWIgNkgyxdJ5H0m9JaZTN23YDMFOF60KzndmUnQwLS3N2z
         Nl21MaMfNksnDUp/ihNhujhkpyTRymahrYBCtY93TEz/Vwha+zDKHuhGrp20Uz/MWbO5
         7rI/7jUE+7E2Wv4MAVDVKReyOxwFQUdCejYuZa48oQXhHyvvXoEcatZfbhTa13LQS/87
         /QhQ==
X-Gm-Message-State: APjAAAW+dyxQzW1fapQzw59Z6GXWZX1m0AMpuuwcnbNys42rROTGNqcw
        J9fuIpHdMe+unE5f9j66ZJo=
X-Google-Smtp-Source: APXvYqyEAoCRcZwyK5RiLw/M5Pwr6wjhBGFADmLBxZ98Qopekt+Zl/JF3qEY6ws5tRWani2yyvqizg==
X-Received: by 2002:a65:6644:: with SMTP id z4mr5731477pgv.198.1552720727956;
        Sat, 16 Mar 2019 00:18:47 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id x62sm8866700pfx.117.2019.03.16.00.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Mar 2019 00:18:46 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sat, 16 Mar 2019 16:18:41 +0900
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] tcp: don't use __constant_cpu_to_be32
Message-ID: <20190316071841.GA30386@tigerII.localdomain>
References: <20190314061514.19586-1-sergey.senozhatsky@gmail.com>
 <CANn89iJMFfh1Pkvk9LOn3FwgAfpVjwS7q5x_8Y9zo2rzpy7w9g@mail.gmail.com>
 <20190315012012.GA748@jagdpanzerIV>
 <20190315172428.GB5481@mini-arch.hsd1.ca.comcast.net>
 <20190316051902.GA27630@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316051902.GA27630@tigerII.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/16/19 14:19), Sergey Senozhatsky wrote:
> > See my recent commit a0517a0f7ef23 ("selftests/bpf: use
> > __bpf_constant_htons in test_prog.c") where compiler was not smart
> > enough to figure it out (you can google similar issues for GCC < 4.8).
> 
> Allow me to disagree.
> 
> The error in a0517a0f7ef23 says
> 
> 	error: implicit declaration of function '__builtin_bswap16'
> 
> which doesn't sound like "the compiler was not smart".
> 
> Let's look at __swab16
> 
> 100 #ifdef __HAVE_BUILTIN_BSWAP16__
> 101 #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
> 102 #else
> 103 #define __swab16(x)                             \
> 104         (__builtin_constant_p((__u16)(x)) ?     \
> 105         ___constant_swab16(x) :                 \
> 106         __fswab16(x))
> 107 #endif
> 
> We can call __builtin_bswap16() only when the compiler has that builtin,
> which is what #ifdef __HAVE_BUILTIN_BSWAP16__ for.
> 
> But this is not what tools/testing/selftests/bpf/bpf_endian.h does
> 
> # define __bpf_ntohs(x)                 __builtin_bswap16(x)
> # define __bpf_htons(x)                 __builtin_bswap16(x)
> 
> So I sort of suspect that what should have been done was that
> __HAVE_BUILTIN_BSWAP16__ ifdef, just like what include/uapi/linux/swab.h
> does.

E.g.

#define ____const(x)	printf("const %d\n", (x))
#define ____noconst(x)	printf("noconst %d\n", (x))
#define const_test(x)	(__builtin_constant_p(x) ? ____const((x)) : ____noconst((x)))

The compiler should optimize out !__builtin_constant_p (dead code elimination
phase - dce), if it can compile the code in the first place.

So if we replace ____noconst with

#define ____noconst(x)	printf2("noconst %d\n", (x))

then compiler wouldn't be able to compile the code and thus wouldn't
be able to perform dce.

__builtin_constant_p, unlike `#if 0', is not handled by the preprocessor.

Verified with gcc 8.3, gcc 4.9, gcc 4.7 at compiler explorer website
https://gcc.godbolt.org/ - GCC is smart enough to figure out
__builtin_constant_p and do dce, given that it compile the code.

	-ss
