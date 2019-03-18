Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28418C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E868F2184C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="wyQUWPUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfCRQ2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:28:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37775 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbfCRQ2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:28:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id q206so11747954pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 09:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I4/aNqZ3TeFwtNHzcHEcswGWbN5iU4mf8xjDmq9e6JY=;
        b=wyQUWPUUpk3tYcZBLkT1VRICEObRlaM5LZ0u6Z0S06JP/x5G2M3wJRNECDAKSWvvv5
         fZ1uyya7sLB5mK3VCSjqrxz5OG2eVdOF4e0QaLpcRomDTKbjFIRX+h4kmBBt+v1wlZan
         nAs9oC04e4pKiJKxEvMhNtZ7icfNnl9MwVwpiFE+1dtwXQt/4bnbbxqGeFokLlgyCXDg
         4oS1lwKUpn1LiYf0Srcx57FyslD7QGnreWbydi3KYWCtTj/D9+QyXtGtk67QAfI+SeD7
         X85wt1E3QskxtCenAZ/UmRnCJq/S2j1B/oezWsSCJZhjaNYXQ3ika+tMsppyFhIoPMZ2
         +DUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I4/aNqZ3TeFwtNHzcHEcswGWbN5iU4mf8xjDmq9e6JY=;
        b=UJ000wUYcYpOgfaIeAlZMyYa3q+i5ntrflX38zDHfxTAmArHPuAG1pGL4bKiXBfA/k
         oDs0ez3gP/QsF4k8OpkdkwcPu7ddVzaguwdrta6W9AnmOFsyD2Y4YUnSY8LjFxk1uPfj
         GIXhi0eqMiKH0I0vTqMeoqq6hlREtTd9gyfmIF0+Gwpxc0t4qbBkch2AAx7bYUHRIhH4
         0gqlcuKgynu1ltUj6nz3k8viIYZ4/wWgFTrN4YMdcNYjUM0xtSAD5b13RHuaqbp/Tq7y
         vX9GT6NN2YFUNz2b6TGGQxyWQ+Ctt691JB5rp8wk7G1br6scvkcfcxZ2hqMvrjDR5Z/J
         YEkQ==
X-Gm-Message-State: APjAAAWhf0l+/iA69yy2OczjrqvAl9WsC3CQhM0sKvArw1b4tpzRlrm8
        dEHLIDbDAND7uF0rYY2deC7Xrg==
X-Google-Smtp-Source: APXvYqyOWyAEJomhgR2fk0MhgkOS5KV3rbVRY9fQebNH3xDa7+tI0mYnfdyPBKA0aab4951+8oYF+g==
X-Received: by 2002:a63:a04c:: with SMTP id u12mr5415791pgn.131.1552926504111;
        Mon, 18 Mar 2019 09:28:24 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id k132sm5182705pga.40.2019.03.18.09.28.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 09:28:23 -0700 (PDT)
Date:   Mon, 18 Mar 2019 09:28:22 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tcp: don't use __constant_cpu_to_be32
Message-ID: <20190318162822.GB7431@mini-arch.hsd1.ca.comcast.net>
References: <20190314061514.19586-1-sergey.senozhatsky@gmail.com>
 <CANn89iJMFfh1Pkvk9LOn3FwgAfpVjwS7q5x_8Y9zo2rzpy7w9g@mail.gmail.com>
 <20190315012012.GA748@jagdpanzerIV>
 <20190315172428.GB5481@mini-arch.hsd1.ca.comcast.net>
 <20190316051902.GA27630@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316051902.GA27630@tigerII.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/16, Sergey Senozhatsky wrote:
> On (03/15/19 10:24), Stanislav Fomichev wrote:
> > On 03/15, Sergey Senozhatsky wrote:
> > > On (03/14/19 05:42), Eric Dumazet wrote:
> > > > > cpu_to_be32() is capable enough to detect __builtin_constant_p()
> > > > > and to use an appropriate compile time ___constant_swahb32()
> > > > > function.
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
That sounds convincing, especially since we have the following
in include/linux/compiler-gcc.h:

#if GCC_VERSION >= 40800
#define __HAVE_BUILTIN_BSWAP16__
#endif

So it does indeed look like it's not __builtin_constant_p, but rather
missing __builtin_bswap16 for gcc < 4.8.

> 
> 	-ss
