Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D950C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1E92173E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZI/ikWc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395201AbfHWOYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 10:24:30 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40979 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732212AbfHWOY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 10:24:29 -0400
Received: by mail-qk1-f193.google.com with SMTP id g17so8290217qkk.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RZxP956OaKkH9WuNbAGH2Ye8Wz/eWZMm/eoqzNqOOhE=;
        b=ZI/ikWc8jIUB67yAoz9WFASP4hZT+5jCwTs30zaoEF8U1UiI9Mv22Niptyk0X4dUox
         qWzKeMP4RgZLkkU8aYn23BGcgpoHY9rbhgof8lJfttwch8w9DrIUkz2k5T4QnpiViU5K
         WEVRy4qenD4SErBb6Q0pPeI8sxk6+az0/UnWBKVumFrvromtGqstKAD8ETYWF396RrLv
         WkrZr0JxF7Is5PhQhpdY2YeL3QcU7x0RZ2whQUCRsPPMzxkIGQil48Zf6yWvGjPiqRuL
         T3840+0QGjiIVCg5T/+t+8WlN7fpi8d5/2aKzGARumqCAiigHdumG4Oo+6J9bB/SYTl7
         H63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RZxP956OaKkH9WuNbAGH2Ye8Wz/eWZMm/eoqzNqOOhE=;
        b=HmCJC7qejAtdTBG7L8JjINKHJpwlk+fiVmJfbH+Tw3d8VYYcFKq+Iw5AKPPQnDhu+e
         15+ntUiQ14oI1724plVwmhjPjB1zK9ZxJ+YsZ0jA+g6HM6lW+OzQ9yITpBVlqD6z1QOs
         HKa32ypL8EEUO07u0L0Ai7PvnonMiechkc2H5MvEnvYMWRpITl27g410qRh/RKxx97hj
         MDuUwJxr9qPzyZ+p5z7AYql03IGd84PWvT/pNVNBqNdO8x0dJrndgo25C++u2XEG7D1w
         omQ7uCRXgfDUB3+I81oDKuZVRghmkByuhD8uKphP3OWBT/iQRaxELZiCXwBpsj00aNqO
         IK7Q==
X-Gm-Message-State: APjAAAWcdX7BZoarBvHWSMTGmddziUiB3RfkHRwrHtl7imiQg8B/3mJw
        fSlnD/GbgNZ0H+RVNGOvFdydPQ==
X-Google-Smtp-Source: APXvYqyqFda9e0GyIrw1K2507j+j0yP11wlqxsBZJJtBWlXa+xxrHR7TFaJMWg/2H/NMdtQK/oHXVw==
X-Received: by 2002:a37:a142:: with SMTP id k63mr4187227qke.487.1566570268736;
        Fri, 23 Aug 2019 07:24:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id j11sm773547qtn.20.2019.08.23.07.24.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Aug 2019 07:24:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i1AUN-0007Wh-LJ; Fri, 23 Aug 2019 11:24:27 -0300
Date:   Fri, 23 Aug 2019 11:24:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] rdma/siw: Use proper enumerated type in map_cqe_status
Message-ID: <20190823142427.GD12968@ziepe.ca>
References: <20190710174800.34451-1-natechancellor@gmail.com>
 <OFE93E0F86.E35CE856-ON00258434.002A83CE-00258434.002A83DF@notes.na.collabserv.com>
 <20190711081434.GA86557@archlinux-threadripper>
 <20190711133915.GA25807@ziepe.ca>
 <CAKwvOdnHz3uH4ZM20LGQJ3FYhLQQUYn4Lg0B-YMr7Y1L66TAsA@mail.gmail.com>
 <20190711171808.GF25807@ziepe.ca>
 <20190711173030.GA844@archlinux-threadripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711173030.GA844@archlinux-threadripper>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 10:30:30AM -0700, Nathan Chancellor wrote:
> On Thu, Jul 11, 2019 at 02:18:08PM -0300, Jason Gunthorpe wrote:
> > On Thu, Jul 11, 2019 at 10:16:44AM -0700, Nick Desaulniers wrote:
> > > On Thu, Jul 11, 2019 at 6:39 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Thu, Jul 11, 2019 at 01:14:34AM -0700, Nathan Chancellor wrote:
> > > > > Maybe time to start plumbing Clang into your test flow until it can get
> > > > > intergrated with more CI setups? :) It can catch some pretty dodgy
> > > > > behavior that GCC doesn't:
> > > >
> > > > I keep asking how to use clang to build the kernel and last I was told
> > > > it still wasn't ready..
> > > >
> > > > Is it ready now? Is there some flow that will compile with clang
> > > > warning free, on any arch? (at least the portion of the kernel I check)
> > > 
> > > $ make CC=clang ...
> > > 
> > > Let us know if you find something we haven't already.
> > > https://clangbuiltlinux.github.io/
> > > https://github.com/ClangBuiltLinux/linux/issues
> > 
> > What clang version?
> > 
> > Jason
> 
> You'll need clang-9 for x86 because of the asm-goto requirement (or a
> selective set of reverts for clang-8) but everything else should be
> good with clang-8:

The latest clang-9 packages from apt.llvm.org do seem to build the
kernel, I get one puzzling warning under RDMA:

drivers/infiniband/hw/hfi1/platform.o: warning: objtool: tune_serdes()+0x1f4: can't find jump dest instruction at .text+0x118a

And a BPF one:

kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0xd: sibling call from callable instruction with modified stack frame

Jason
