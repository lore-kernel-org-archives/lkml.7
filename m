Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A1BC282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6289217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a/c5aNCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbfEXRSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:18:17 -0400
Received: from mail-yw1-f54.google.com ([209.85.161.54]:42933 "EHLO
        mail-yw1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731460AbfEXRSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:18:17 -0400
Received: by mail-yw1-f54.google.com with SMTP id s5so3904105ywd.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7fjzoEk7VHLdIfi/lCjGQJd6xWD7AQcbop/UJoQp2cg=;
        b=a/c5aNCzXO7PLBa6Ssaqn9PV4rrkGxnsM1xHZvBruNhViUf57ByhvKw3LDYheK9AVn
         7xJweo6a0bX6nCiUyOF7CyQkSOrwCnrRYJodZ7ZURffExgzgfwIZtij7VsdWYDlFMm4J
         CeQpx3k3MuKNFnJsl8HBdrM9eCTBqU2bjRihv6CICpP+ObFN3uYNQbM08yATD9rZYezo
         piWyxLCsiAi33onCQZ2vc9k53xG1v6VSYYloF6+HRn+tDtjZuHI2YULEcjbfU8sP7s9a
         LQDhUD/jirMOuLBVgP1pGxJ/WeylORNTxm5AX/+Ce1SLL+O7QVCsp/KxF6araNp75DBt
         JthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7fjzoEk7VHLdIfi/lCjGQJd6xWD7AQcbop/UJoQp2cg=;
        b=j2LQPcC2egaqGh+jK3Ot6orfhCCdl0kW5ms4ejo7V0ZO3qx9EZGpvNMDgpI0jjnFt6
         IdrVODES61pkylktJE903oXzoPWZT7YIAnWmj4Emojp/KBmbIIVxVd5fkFitvbYuat+S
         n2bZF8N1H583v5DFsLq9eT8lalOJOR+O9Y51hNx4HhLaK6hq88V7SCukDPFI/UuqBHtv
         30k/+Itow5oQ4eqeOdqX1CKHIbhOLV5oOERquWlukO1p0TkP5Liazqo36XdOUTok+h+k
         hZ+XFD5t9SLzcXqkl4cuJenz+Xb1+BWP4L2fhNfIOKLUJ0nwFmwicdVFjIiN8kZinPH2
         J9mg==
X-Gm-Message-State: APjAAAXUkb2dRvzsiC0o/ysabcDZwJNtzPqeaY/cJMdC/k6lEo/4L9XO
        GdBJu3aPH/OMBIPOHNfmQpvGp+fCSrRvtfhNUWr5QQ==
X-Google-Smtp-Source: APXvYqzyCi24bS0zt4t5z9+kM3048deoltYoGq6J2shC7KVjEfqjZWrRksXqNV+c9NbCgXa7Mb/kKqN3XyJrvZZBLfc=
X-Received: by 2002:a81:7cc2:: with SMTP id x185mr11843465ywc.10.1558718295643;
 Fri, 24 May 2019 10:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190523174349.GA10939@cmpxchg.org> <20190523183713.GA14517@bombadil.infradead.org>
 <CALvZod4o0sA8CM961ZCCp-Vv+i6awFY0U07oJfXFDiVfFiaZfg@mail.gmail.com>
 <20190523190032.GA7873@bombadil.infradead.org> <20190523192117.GA5723@cmpxchg.org>
 <20190523194130.GA4598@bombadil.infradead.org> <20190523195933.GA6404@cmpxchg.org>
 <20190524161146.GC1075@bombadil.infradead.org> <20190524170642.GA20546@cmpxchg.org>
In-Reply-To: <20190524170642.GA20546@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 24 May 2019 10:18:04 -0700
Message-ID: <CALvZod5=N_hwGLFzCZY=DG0RfwzSt2sjJDcPZtCRy-NcBsLL+w@mail.gmail.com>
Subject: Re: xarray breaks thrashing detection and cgroup isolation
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 10:06 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, May 24, 2019 at 09:11:46AM -0700, Matthew Wilcox wrote:
> > On Thu, May 23, 2019 at 03:59:33PM -0400, Johannes Weiner wrote:
> > > My point is that we cannot have random drivers' internal data
> > > structures charge to and pin cgroups indefinitely just because they
> > > happen to do the modprobing or otherwise interact with the driver.
> > >
> > > It makes no sense in terms of performance or cgroup semantics.
> >
> > But according to Roman, you already have that problem with the page
> > cache.
> > https://lore.kernel.org/linux-mm/20190522222254.GA5700@castle/T/
> >
> > So this argument doesn't make sense to me.
>
> You haven't addressed the rest of the argument though: why every user
> of the xarray, and data structures based on it, should incur the
> performance cost of charging memory to a cgroup, even when we have no
> interest in tracking those allocations on behalf of a cgroup.
>
> Which brings me to repeating the semantics argument: it doesn't make
> sense to charge e.g. driver memory, which is arguably a shared system
> resource, to whoever cgroup happens to do the modprobe / ioctl etc.
>
> Anyway, this seems like a fairly serious regression, and it would make
> sense to find a self-contained, backportable fix instead of something
> that has subtle implications for every user of the xarray / ida code.

Adding to Johannes point, one concrete example of xarray we don't want
to charge is swapper_spaces. Swap is a system level resource. It does
not make any sense to charge the swap overhead to a job and also it
will have negative consequences like pinning zombies.

Shakeel
