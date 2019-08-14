Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8504DC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504C4208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PI7xit+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfHNRki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:40:38 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33589 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbfHNRki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:40:38 -0400
Received: by mail-oi1-f193.google.com with SMTP id u15so74096677oiv.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 10:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fP44QmXwF6Mg2mIRi/RT9fhyHn5OWWxhydLg4BD1uS4=;
        b=PI7xit+dZLXUlxKvwo/gXsJQxdoTcrfr0UA3Utn7IenDX7G8/2TcQ9ny8Pg3hFd7rV
         +vNYAmF+4TkNzo0Zy8YvBIiJMjk/LVE6otiLKnLO2xVODtsqGqSk/ivbhqUCQj+Stuak
         y/HotcGdP+uXTvZbmUMY3IxzZMYtEFyIm+sCFR0xh43HsUtJ3cjAuFnDwI1I9kJDukZT
         RSOFFMYbzrx4JjLJJvmqT1Ou8pRDdAkAeuz1RlyFAwjQYd1RSfL/Xa+uoKQzlvmM6Hnb
         SF/MCnq5UyD1l1YLZAsxcfl5eZceDDekHEm7WMGjP+ULqtHsAaecBNiWmd6j+D5D9RMM
         qCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=fP44QmXwF6Mg2mIRi/RT9fhyHn5OWWxhydLg4BD1uS4=;
        b=ph6MLehdg+HYMmuIeTcr8zlDG6YOiewGdfawUUwkZxm8cAOi1BVScAUcOOaq/AhIYn
         X3tVbYsKhuMbEyL70B0JNay3ymqYiT+mteFscVhWojdMn7e1YS20raZC8pFMUFhMfSL2
         LRh8/4eSGQKG0zkmnlBqdUN6OwlkXaXIyoynIbDazv21rvV3q/fWDuk24yAg2hmn0gID
         bEJ5mGOIbq6H/tASoOf9rFNo54ax44vtuukQ35K+rQyiaLwXeWcjTrLuUKF8j4f7s8y3
         F3R+GCplvZ/VPqOMJ0dgZl5v9oPdtBd0vSy7AqLxwSyZPtm9uDudJKg4C464q8GGeCe4
         YZFA==
X-Gm-Message-State: APjAAAUf6ggzcDaixb9le7hh9PiG1NohhhTwLAx6puFFg8bIyPiTctQT
        LKv5LRqlFewLQdOkHSxUmQB9iw==
X-Google-Smtp-Source: APXvYqxQ+Yi9en9HAFSs2ujE6k2WXnWNrLxAElIZEyNFBkhRps6XOhTgjPOtSAf9lXnBHHAfTYhONg==
X-Received: by 2002:a05:6638:52:: with SMTP id a18mr475292jap.75.1565804437448;
        Wed, 14 Aug 2019 10:40:37 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id a7sm270991iok.19.2019.08.14.10.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 10:40:36 -0700 (PDT)
Date:   Wed, 14 Aug 2019 10:40:35 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Logan Gunthorpe <logang@deltatee.com>,
        Greentime Hu <green.hu@gmail.com>
cc:     Rob Herring <robh@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>,
        Olof Johansson <olof@lixom.net>, greentime.hu@sifive.com,
        linux-riscv@lists.infradead.org,
        Michael Clark <michaeljclark@mac.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@vger.kernel.org
Subject: Re: [PATCH v4 2/2] RISC-V: Implement sparsemem
In-Reply-To: <0d81412d-73fc-fa56-6f84-dedda72b9cc6@deltatee.com>
Message-ID: <alpine.DEB.2.21.9999.1908141035020.18249@viisi.sifive.com>
References: <20190109203911.7887-1-logang@deltatee.com> <CAEbi=3d0RNVKbDUwRL-o70O12XBV7q6n_UT-pLqFoh9omYJZKQ@mail.gmail.com> <c4298fdd-6fd6-fa7f-73f7-5ff016788e49@deltatee.com> <CAEbi=3cn4+7zk2DU1iRa45CDwTsJYfkAV8jXHf-S7Jz63eYy-A@mail.gmail.com>
 <CAEbi=3eZcgWevpX9VO9ohgxVDFVprk_t52Xbs3-TdtZ+js3NVA@mail.gmail.com> <0926a261-520e-4c40-f926-ddd40bb8ce44@deltatee.com> <CAEbi=3ebNM-t_vA4OA7KCvQUF08o6VmL1j=kMojVnYsYsN_fBw@mail.gmail.com> <e2603558-7b2c-2e5f-e28c-f01782dc4e66@deltatee.com>
 <CAEbi=3d7_xefYaVXEnMJW49Bzdbbmc2+UOwXWrCiBo7YkTAihg@mail.gmail.com> <96156909-1453-d487-ff66-a041d67c74d6@deltatee.com> <CAEbi=3dC86dhGdwdarS_x+6-5=WPydUBKjo613qRZxKLDAqU_g@mail.gmail.com> <5506c875-9387-acc9-a7fe-5b7c10036c40@deltatee.com>
 <alpine.DEB.2.21.9999.1908130921170.30024@viisi.sifive.com> <e1f78a33-18bb-bd6e-eede-e5e86758a4d0@deltatee.com> <CAEbi=3f+JDywuHYspfYKuC8z2wm8inRenBz+3DYbKK3ixFjU_g@mail.gmail.com> <0d81412d-73fc-fa56-6f84-dedda72b9cc6@deltatee.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019, Logan Gunthorpe wrote:

> On 2019-08-14 7:35 a.m., Greentime Hu wrote:
>
> > Maybe this commit explains why it used HAVE_ARCH_PFN_VALID instead of SPARSEMEM.
> > https://github.com/torvalds/linux/commit/7b7bf499f79de3f6c85a340c8453a78789523f85
> > 
> > BTW, I found another issue here.
> > #define FIXADDR_TOP            (VMALLOC_START)
> > #define FIXADDR_START           (FIXADDR_TOP - FIXADDR_SIZE)
> > #define VMEMMAP_END    (VMALLOC_START - 1)
> > #define VMEMMAP_START  (VMALLOC_START - VMEMMAP_SIZE)
> > These 2 regions are overlapped.
> > 
> > How about this fix? Not sure if it is good for everyone.
> 
> Yes, this looks good to me. I can fold these changes into my patch and
> send a v5 to the list.

The change to FIXADDR_TOP should be separated out into its own patch - it 
probably needs to go up as a fix.


- Paul
