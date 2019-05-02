Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71759C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EBC20652
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556813560;
	bh=8lL4Xr5WUmItT63oJ/eZajDIrx5MYpCIzSa07SIXztg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YAicKg7VXlyp3g6FmLr52kk38HNq2cVWS8zZgHwPLjMeuRt1GaQy6UvfFqAA08fsv
	 F1YKOvdx7Lwzi03VDqSH9SpcdkXrxY4wPztqLneJIxx8wRDPEijVzQxntjrrrKnV92
	 ip3G0ipsx0WpzGbUh+jivXJwEpSrJbg/bBd/tYLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfEBQMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:12:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33717 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfEBQMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:12:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id f23so2737259ljc.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 09:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tVCR90ukM60h/XwpKx8sUt1qsA8XF27L7aKaa1sc/2M=;
        b=g/64gIbp0B3X/vq/gXDgYMqciwD30QVCfUNcG9oypva2F607a/I6OwS5fBvheT4m1n
         2/2xkABKa/gsJeT/yaimePKHCCfdJVXcV/J2byJDcIenUWxBF0MxVk+tFCaPa2dwxj6G
         SWbYe5z0YlYLlNnnR4zFJW7iELpg6nRdbXb2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tVCR90ukM60h/XwpKx8sUt1qsA8XF27L7aKaa1sc/2M=;
        b=Da14uWK6nSamwlkVZbCZwTgc6pE0eHgqG3MJYisN0UaBCI1X2/Ckd9qlQyUJMlrYjh
         VZJZNjf2ttkMJS9KLckeMqypM+uvOJkkEFAQfSKom+/mp8kT3XLRV5kWkS1xzrICrMh9
         Lul0hizl5I5i6X3KP2CefIL8M7oY735wBMmOwH7pktC8YnzGMSWZwEfyZEY53VSeDy9t
         75sd5S/0/kKh0Xoo1/9IoI30a6uoN9Mk9MVLiDMKm2+emU9wEctfyXu1UdHiazWZAA3K
         sipOlQolaTGuhmUOZWNfekum5GZ3STsbXQ/Y1NyCriR+/BPZKedUjgDlz1PhmhkJsodS
         LETg==
X-Gm-Message-State: APjAAAWCNXJZ2Iaks91hqiQSnLKZ//6+9B4FHuRRBTLfi9X7/EelfSF1
        Uo/u4kVsMyCnEAe/BXWaxVE293eMe5U=
X-Google-Smtp-Source: APXvYqyP/1myFMYnywneGx1v5Ct6XYRuN8p9mZZ6j6gUaSs/osae4eb+AcDCdCj+ZzHldeB9QS8NjA==
X-Received: by 2002:a2e:9211:: with SMTP id k17mr2463263ljg.160.1556813556256;
        Thu, 02 May 2019 09:12:36 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id r10sm3210701ljb.81.2019.05.02.09.12.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 09:12:35 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id h21so2668927ljk.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 09:12:35 -0700 (PDT)
X-Received: by 2002:a2e:9a84:: with SMTP id p4mr1899422lji.22.1556813555043;
 Thu, 02 May 2019 09:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190429145159.GA29076@hc> <CAHk-=wjPqcPYkiWKFc=R3+18DXqEhV+Nfbo=JWa32Xp8Nze67g@mail.gmail.com>
 <20190502082741.GE13955@hc>
In-Reply-To: <20190502082741.GE13955@hc>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 May 2019 09:12:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmtMrxC1nSEHarBn8bW+hNXGv=2YeAWmTw1o54V8GKWA@mail.gmail.com>
Message-ID: <CAHk-=wjmtMrxC1nSEHarBn8bW+hNXGv=2YeAWmTw1o54V8GKWA@mail.gmail.com>
Subject: Re: [RFC] Disable lockref on arm64
To:     Jan Glauber <jglauber@marvell.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 1:27 AM Jan Glauber <jglauber@marvell.com> wrote:
>
> I'll see how x86 runs the same testcase, I thought that playing
> cacheline ping-pong is not the optimal use case for any CPU.

Oh, ping-pong is always bad.

But from past experience, x86 tends to be able to always do tight a
cmpxchg loop without failing more than a once or twice, which is all
you need for things like this.

And it's "easy" to do in hardware on a CPU: all you need to do is
guarantee that when you have a cmpxchg loop, the cacheline is sticky
enough that it stays around at the local CPU for the duration of one
loop entry (ie from one cmpxchg to the next).

Obviously you can do that wrong too, and make cachelines *too* sticky,
and then you get fairness issues.

But it really sounds like what happens for your ThunderX2 case, the
different CPU's steal each others cachelines so quickly that even when
you get the cacheline, you don't then get to update it.

Does ThunderX2 do LSE atomics? Are the acquire/release versions really
slow, perhaps, and more or less serializing (maybe it does the
"release" logic even when the store _fails_?), so that doing two
back-to-back cmpxchg ends up taking the core a "long" time, so that
the cache subsystem then steals it easily in between cmpxchg's in a
loop? Does the L1 cache maybe have no way to keep a line around from
one cmpxchg to the next?

This is (one example) where having a CPU and an interconnect that
works together matters.  And yes, it probably needs a few generations
of hardware tuning where people see problems and fix them.

                 Linus
