Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF979C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD91217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N/0LPK/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfDYIBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:01:35 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36867 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfDYIBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:01:35 -0400
Received: by mail-ot1-f66.google.com with SMTP id c16so18646523otn.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 01:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r7k3jNtM4rfpF/e+3MiSDVH4Z9psz3XqZDdZqFJQYhE=;
        b=N/0LPK/JZ2wVFsnXwBZ1WWvWMfON5jfkymx9HbHeCik8bJA0XpabaLFvqj5h5NRrPW
         FgvVQ8OSaurUeuCyCWAic4Qpad3Chs8mEA9DoR5ykduHUabG+q5R3vE3p4SNeGoy2lw8
         +rGV2Iv6PTdSsed4mC4MAbrbTNHTvnYGrQjshUoS0TMthk5jAMHlHjju5DvIKOzzVlJo
         /IPfIa7ygKTYA9H5n2KvwhDIW0PVMr6tZvABQqxGXsDCuLgdN1LSMggAjrZYgP54gQLu
         Tz/LiTlquwpVCNFzvKN79lNf//jNTl/5rgnyZixCOXyjMXbe/6GkoXXmDMbKzHHGYS5p
         EWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r7k3jNtM4rfpF/e+3MiSDVH4Z9psz3XqZDdZqFJQYhE=;
        b=p+5cLuaafJ9tX/mejCLKSRFx8SmBiuRSejRd3sH5yk0hzoYj1lZzN6nl1WZJS7d88y
         EHaSq84sp+u/iYwLorZC/PRprArDXwlnES0pJQJYlWGGxi6eb5eqqxCRkuzPoSdmlEnb
         1/gUckLcXudyKHj6xQkxfsMPUV/sEGXwhEuMi1uxz08kvlzt+pUA0sO3tsIVMamSadn4
         Yt08ChJ2zWzGqEBVT/deSYEganwIIJZE3Ald+vqaNgRH0F6qloVxUldAvmEvZ5yJUYoN
         Lmk/PN6oVkahb5CECK+8BADV7LQAKgEiqZyQA6wJWtnxRuKmPwx9XdcSsGzLMdx0bwdM
         ZfCQ==
X-Gm-Message-State: APjAAAVw8Mbxa3O0/lCAC4FiqRZjPXmcAx10w9OrhZRP9P/6gnmjeXeA
        ElsZJvw1OLt9tYsCMVUXIKK+IrstfGD52EEyR97WsD7h4YE=
X-Google-Smtp-Source: APXvYqwsgZLmqSxFgX+ZSDMJ6HzlLjEMVAoxSKqm0j8G3bSM4Q457dq5wW0WljStj3jiDZYlAKwszXRDqhsa4YAWzfM=
X-Received: by 2002:a05:6830:1692:: with SMTP id k18mr20781806otr.216.1556179293739;
 Thu, 25 Apr 2019 01:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8XO3atijveUR0irCM2z3hsr8Rm9piwTbBp0NTwvzJt9+MHdw@mail.gmail.com>
 <d0c9c052-6153-6336-f296-15ad5611f21b@gmail.com>
In-Reply-To: <d0c9c052-6153-6336-f296-15ad5611f21b@gmail.com>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Thu, 25 Apr 2019 11:01:22 +0300
Message-ID: <CAD8XO3b0m5Qn1Ey3gu3HPmcOanN-yjCYBJZEUEu754X=5jAtOA@mail.gmail.com>
Subject: Re: RFC: zero copy recv()
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019 at 18:59, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 04/23/2019 11:23 PM, Maxim Uvarov wrote:
> > Hello,
> >
> > On different conferences I see that people are trying to accelerate
> > network with putting packet processing with protocol level completely
> > to user space. It might be DPDK, ODP or AF_XDP  plus some network
> > stack on top of it. Then people are trying to test this solution with
> > some existence applications. And in better way do not modify
> > application binaries and just LD_PRELOAD sockets syscalls (recv(),
> > sendto() and etc). Current recv() expects that application allocates
> > memory and call will "copy" packet to that memory. Copy per packet is
> > slow.  Can we consider about implementing zero copy API calls
> > friendly? Can this change be accepted to kernel?
>

Hello Eric, thanks for responding.

> Generic zero copy is hard.
>

yes that is true.

> As soon as you have multiple consumers in different domains for the data,
> you need some kind of multiplexing, typically using hardware capabilities.
>
> For TCP, we implemented zero copy last year, which works quite well
> on x86 if your network uses MTU of 4096+headers.
>
> tools/testing/selftests/net/tcp_mmap.c  reaches line rate (100Gbit) on
> a single TCP flow, if using a NIC able to perform header split.
>

That is great work. But isn't there context switches on
getsockopt(TCP_ZEROCOPY_RECEIVE) and read() per packet?

I played with AF_XDP where one core can be isolated and do polling of
umem pool memory and some other core can do softirq processing.
And polling of umem is really fast - about 96ns on 2.5Ghz x86 laptop
and no context switches on umem polling core.

But in general for tcp_mmap.c code if getsockopt()+read() will be
changed to one zero copy call, something like recvmsg_zc() then it can
be LD_PRELOADED.
mmap() can be also moved under socket creation to simplify api. Does
it look reasonable?

> But the model is not to run a legacy application with some LD_PRELOAD
> hack/magic, sorry.
>
More likely that legacy applications will like to use zero copy
networking. Once api will be stable they will support it, especially
if api can be used with minimal changes for apps.
Than it will be quite easy to LD_PRELOAD hack or change application to
use some other IP stack.

Maxim.
