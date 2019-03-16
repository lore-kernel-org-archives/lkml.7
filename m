Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3931CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 05:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F193D21019
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 05:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKNE/4n5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfCPFTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 01:19:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36074 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfCPFTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 01:19:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id r124so7849554pgr.3;
        Fri, 15 Mar 2019 22:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wo1Qc+0+P4jKPHD/LFYya9z4OyeMRrQ0z1ytOoJ5gZ4=;
        b=kKNE/4n5rIuJ/Zi5YihHdhpe3I01iwqoy9FxGlklicywglGxgONEUfLjO9ATfL37P0
         8hiTPEi9YpBaa2coYXzhSFieRkQQClTnEA9i/Mgs4raOXS3apehE8AxiZYbMeAE5/Xp8
         tTkupH9UN+00UW5DFZMiMV/XBLiPWJlbqIO5GWYfVJ8cO5ltA7pfEyLA1TdzLLwqqPQN
         /f5NRVnkmxsOlmI3uLaDuL8AwJ1S/Rj62ErWGT0PsRCC2I4sgDTSAYy+mDEprUyPGXHt
         H6/mUMqoTMKk9+eqBG9+v5jBOkLe3QBhznOSIPteYDkIbe4NlwsZMyjEKSB9CT6Fs4ne
         DooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wo1Qc+0+P4jKPHD/LFYya9z4OyeMRrQ0z1ytOoJ5gZ4=;
        b=swlsclfVCdLEZ4ZaY0SUlpubd/wyHN2SK87PlGWmnyzcVnDUEUdGvkzSTAtGVQcgNm
         YLKZa3/vJ1WiHzjM0ObdI7OtIEG/VimSQHFhgAMi/S4MdfxuGrVdZMoNYe5eeQ6IiqfM
         ABYUXtuU7+ka28BBUppA65xmy+OO8eNHRAXkZF0gFVQfTyCTFduZj8+wZuk1y0U4BcyW
         Y1VzVcxn0SLIo1wNfLzcDg2jAeYVjKGFT2I5/2fGj6x5DGzcorYU+ZlEUzdZIfHdXfm1
         8Y0Nm52ykRqyJqptjAWjYuMSJw+c5Cx7c1u5rhe/yvYM2Cs//uMgGGxQxK+GMLnGCnw5
         w3VA==
X-Gm-Message-State: APjAAAXT5GLnn9hHsHqp+d76da1H9CpoXuh02s4d0k6zsjevii7kvjnT
        tb53N+Br0TI4FvKd6Q64fAg=
X-Google-Smtp-Source: APXvYqycDQ3ozam+4deQmJWoYurHP7El7C5D2DofqSzCbSDx8BBeWnzUr79PEUjOw1PxnIwAab9bIw==
X-Received: by 2002:a63:fe58:: with SMTP id x24mr6992352pgj.255.1552713559786;
        Fri, 15 Mar 2019 22:19:19 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id u13sm5477130pfa.169.2019.03.15.22.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 22:19:18 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sat, 16 Mar 2019 14:19:02 +0900
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] tcp: don't use __constant_cpu_to_be32
Message-ID: <20190316051902.GA27630@tigerII.localdomain>
References: <20190314061514.19586-1-sergey.senozhatsky@gmail.com>
 <CANn89iJMFfh1Pkvk9LOn3FwgAfpVjwS7q5x_8Y9zo2rzpy7w9g@mail.gmail.com>
 <20190315012012.GA748@jagdpanzerIV>
 <20190315172428.GB5481@mini-arch.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315172428.GB5481@mini-arch.hsd1.ca.comcast.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/15/19 10:24), Stanislav Fomichev wrote:
> On 03/15, Sergey Senozhatsky wrote:
> > On (03/14/19 05:42), Eric Dumazet wrote:
> > > > cpu_to_be32() is capable enough to detect __builtin_constant_p()
> > > > and to use an appropriate compile time ___constant_swahb32()
> > > > function.
> See my recent commit a0517a0f7ef23 ("selftests/bpf: use
> __bpf_constant_htons in test_prog.c") where compiler was not smart
> enough to figure it out (you can google similar issues for GCC < 4.8).

Allow me to disagree.

The error in a0517a0f7ef23 says

	error: implicit declaration of function '__builtin_bswap16'

which doesn't sound like "the compiler was not smart".

Let's look at __swab16

100 #ifdef __HAVE_BUILTIN_BSWAP16__
101 #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
102 #else
103 #define __swab16(x)                             \
104         (__builtin_constant_p((__u16)(x)) ?     \
105         ___constant_swab16(x) :                 \
106         __fswab16(x))
107 #endif

We can call __builtin_bswap16() only when the compiler has that builtin,
which is what #ifdef __HAVE_BUILTIN_BSWAP16__ for.

But this is not what tools/testing/selftests/bpf/bpf_endian.h does

# define __bpf_ntohs(x)                 __builtin_bswap16(x)
# define __bpf_htons(x)                 __builtin_bswap16(x)

So I sort of suspect that what should have been done was that
__HAVE_BUILTIN_BSWAP16__ ifdef, just like what include/uapi/linux/swab.h
does.

	-ss
