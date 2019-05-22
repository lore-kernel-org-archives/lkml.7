Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906FBC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 23:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A04C206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 23:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q1hKWyHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfEVX5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 19:57:40 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36168 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEVX5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 19:57:40 -0400
Received: by mail-qt1-f195.google.com with SMTP id a17so4680558qth.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 16:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ep9uVHpBGZswzwZ+H/eF/1/q1Yi9oKaegrCzMMn+v2w=;
        b=Q1hKWyHArMJk0cuB6S0l9Ps4LFjPimg+ITsAv/pNx1HPV30Y0Dw5vtjo5ZJdvu6uDU
         uPLkBnGxRltUikh5/RqnfW79NkePV+iLYOoOU2MZW0dGzUcIeDu2UjkmOW+72KOG+Z95
         Os8nZL84gacPJsIDatNU8+oDl61IP9Wf+bHI48QXLL3m+HTuFfmqe0aTGUECJYAeXj1U
         C6AYMQYiU26cdRliq/8oE9WKABTISlXuBsRwuKf6ehITMVfulLupiuy5N/Ac+bHWvVWh
         9ESy3JVc3OeFWxRykU8wGeRnSFhJHV66xh0QhkSgpXG/QexM/GevHVjean7GbYVYi+8w
         4y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ep9uVHpBGZswzwZ+H/eF/1/q1Yi9oKaegrCzMMn+v2w=;
        b=fOAE5/tjcuuC6vVT39GlMeRYV7hOT8dS0GxAcZqrrgfQDN/9ivRTDRLp5ht4iLbFct
         taZhiOcf02Klg2+9WKtKYziuj6xMeYoRyI/cXLAkttZ3p09wT2XBKWyEZnLJPtuo2lFn
         TzzfSd0jL/Cb6zTPjyw0zBo9dF09sGC7yJizApbazVxV3zVzpBXcoOIWqAOtd4yF2OAm
         6QUEfrfevEW8CBcLEDoabTWGC8a/0zHfiev8lamvfHujt1cIFKuMZogd2Bs3URqPyOlK
         rJ4k1Be758S43Yw2BNXcnIuwQFRgKxV5q6sX1V4uOQNg+1kd3sCciDgA8h+ggg6edMn+
         I3qw==
X-Gm-Message-State: APjAAAWWEkJJ0lBUKL+rre7sCx0HBIbn6FRSJCkB+o6hsgteo/peK3CC
        62Zr7PyLk2cbSfmSlGzIsyY6Wg==
X-Google-Smtp-Source: APXvYqzaonhnkp/bUloxWlJ3maBzgQam/abanIz+C6FRxel/0h/X8xe2Qu7CLsQrUUqePsk4cAL/DQ==
X-Received: by 2002:aed:2494:: with SMTP id t20mr75861244qtc.135.1558569459047;
        Wed, 22 May 2019 16:57:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id q66sm12719518qke.66.2019.05.22.16.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 16:57:38 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTb73-0001PC-MU; Wed, 22 May 2019 20:57:37 -0300
Date:   Wed, 22 May 2019 20:57:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
Message-ID: <20190522235737.GD15389@ziepe.ca>
References: <20190411181314.19465-1-jglisse@redhat.com>
 <20190506195657.GA30261@ziepe.ca>
 <20190521205321.GC3331@redhat.com>
 <20190522005225.GA30819@ziepe.ca>
 <20190522174852.GA23038@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522174852.GA23038@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 01:48:52PM -0400, Jerome Glisse wrote:

> > > So attached is a rebase on top of 5.2-rc1, i have tested with pingpong
> > > (prefetch and not and different sizes). Seems to work ok.
> > 
> > Urk, it already doesn't apply to the rdma tree :(
> > 
> > The conflicts are a little more extensive than I'd prefer to handle..
> > Can I ask you to rebase it on top of this branch please:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=wip/jgg-for-next
> > 
> > Specifically it conflicts with this patch:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/jgg-for-next&id=d2183c6f1958e6b6dfdde279f4cee04280710e34

There is at least one more serious blocker here:

config ARCH_HAS_HMM_MIRROR
        bool
        default y
        depends on (X86_64 || PPC64)
        depends on MMU && 64BIT

I can't loose ARM64 support for ODP by merging this, that is too
serious of a regression.

Can you fix it?

Thanks,
Jason
