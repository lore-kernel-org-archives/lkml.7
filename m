Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C70C04AAA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73922075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="N9BE3PqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfECXw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 19:52:59 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39213 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfECXw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 19:52:58 -0400
Received: by mail-qt1-f195.google.com with SMTP id y42so8714634qtk.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 16:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y9uds37g7f4813/ZqlKEDnGn948IiuDvboVC7bPadlI=;
        b=N9BE3PqMA0nL0NvpOU63kepSs17NWxuaQGMx7Tupv6wpFQNuRqB6tenh0G/BWpJ1PP
         HEd7ZRYuplIPMrp/i3Cbd8pyLv65lE/Kcn6MATxFD0LAM764ONzAI9CGs51aZh5QkF2i
         IUvMmfzMxlcfJSqngQx2TZEML8ZbCAHWTFmHtqfhFJeQ8JVqaTAgfiqfKRaZhlNd6jZX
         Xiy8j3oAf41/Kg4WEp6FuwvI9DlafHuBxOiRzLclafXL2AMIXhBmFJmJrK5KHtm2pgmi
         Pkc8sfsyJqh6zaTpfCu0T9ewb4rk6AtpL8uJLJA4xZTB0LSOR9blqcrj5s/eIqJuMPaw
         q8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y9uds37g7f4813/ZqlKEDnGn948IiuDvboVC7bPadlI=;
        b=t+TTuajcYJMoUZMMWXQOPdchC0V0eKSTEIE+Sfu8Em+nJ01Mmta2GmlE4Xqe1x5s7d
         NEciRXfxOJ3TUPiw9U3z2Az8jOgKLUGr2w3r9AxZ6Hv9D5EjAL2pf4Zv8g2G4pZe7x94
         U9hgVft3VJo5DFN5IvvGWHhYZ4JAzQ8gm6bEVLV2yjIkvadMLm+na5p22i8iaWNb5YuZ
         LSGTKX5ac/RVLZYV3b4faWokBMgSFlfwMFbokH90uWrLaxtg7FqDxzG6ITXlCePEFhZk
         +bbj4+ZlXh9E9vZIBskklEtULnM7c2boOt31BItJupsPtUPFgElBpTmeppKkKvbChAwW
         s2QQ==
X-Gm-Message-State: APjAAAWIrAh/B64NCjRN67+T+9vyIpftu6bf3sx/IS5p2hSeE+RASEkG
        9f9P/8Dz91cMoO3FArMBkZAepg==
X-Google-Smtp-Source: APXvYqziKdH2wZvx3iC97K6c8A4weeprYaQkrXpo4FxMM1oMFrPSRq/nQcOHMobAnKPDvieS6kD22g==
X-Received: by 2002:ac8:8ad:: with SMTP id v42mr10692638qth.337.1556927577786;
        Fri, 03 May 2019 16:52:57 -0700 (PDT)
Received: from ziepe.ca ([65.119.211.164])
        by smtp.gmail.com with ESMTPSA id r1sm1636491qtp.77.2019.05.03.16.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 16:52:56 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hMhz6-0001lg-BL; Fri, 03 May 2019 20:52:56 -0300
Date:   Fri, 3 May 2019 20:52:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v13 16/20] IB/mlx4, arm64: untag user pointers in
 mlx4_get_umem_mr
Message-ID: <20190503235256.GB6660@ziepe.ca>
References: <cover.1553093420.git.andreyknvl@google.com>
 <1e2824fd77e8eeb351c6c6246f384d0d89fd2d58.1553093421.git.andreyknvl@google.com>
 <20190429180915.GZ6705@mtr-leonro.mtl.com>
 <20190430111625.GD29799@arrakis.emea.arm.com>
 <20190502184442.GA31165@ziepe.ca>
 <20190503162846.GI55449@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503162846.GI55449@arrakis.emea.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 05:28:46PM +0100, Catalin Marinas wrote:
> Thanks Jason and Leon for the information.
> 
> On Thu, May 02, 2019 at 03:44:42PM -0300, Jason Gunthorpe wrote:
> > On Tue, Apr 30, 2019 at 12:16:25PM +0100, Catalin Marinas wrote:
> > > > Interesting, the followup question is why mlx4 is only one driver in IB which
> > > > needs such code in umem_mr. I'll take a look on it.
> > > 
> > > I don't know. Just using the light heuristics of find_vma() shows some
> > > other places. For example, ib_umem_odp_get() gets the umem->address via
> > > ib_umem_start(). This was previously set in ib_umem_get() as called from
> > > mlx4_get_umem_mr(). Should the above patch have just untagged "start" on
> > > entry?
> > 
> > I have a feeling that there needs to be something for this in the odp
> > code..
> > 
> > Presumably mmu notifiers and what not also use untagged pointers? Most
> > likely then the umem should also be storing untagged pointers.
> 
> Yes.
> 
> > This probably becomes problematic because we do want the tag in cases
> > talking about the base VA of the MR..
> 
> It depends on whether the tag is relevant to the kernel or not. The only
> useful case so far is for the kernel performing copy_form_user() etc.
> accesses so they'd get checked in the presence of hardware memory
> tagging (MTE; but it's not mandatory, a 0 tag would do as well).
> 
> If we talk about a memory range where the content is relatively opaque
> (or irrelevant) to the kernel code, we don't really need the tag. I'm
> not familiar to RDMA but I presume it would be a device accessing such
> MR but not through the user VA directly. 

RDMA exposes the user VA directly (the IOVA) as part of the wire
protocol, we must preserve the tag in these cases as that is what the
userspace is using for the pointer.

So the ODP stuff will definately need some adjusting when it interacts
with the mmu notifiers and get user pages.

Jason
