Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD7DC3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DC020828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aSF2iwwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfH0WsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 18:48:07 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33688 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfH0WsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 18:48:06 -0400
Received: by mail-qt1-f194.google.com with SMTP id v38so843356qtb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 15:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jAdr+PRt2FqgbS5XOOCJ9tvwJq0Sqr672g8uyJKHQxE=;
        b=aSF2iwwBLFQuLQ3N3kNXqi4CQ/GTjnkvkPNw4aniyErIM3MO0qE94JDqgop+jXAoq3
         jHHWiV4hBrwmm2iTgCoiRlhwqpzuD3mb9GMj1eDsOI+G8Gw4AuMgNGE4i/bvRk5AXep4
         3QR+vmYkm6GNw7pLeIbfet89BHMr+yn7nrfaAqOOgrIEOmAm9QShaaPeo4Zh7ka1jkS0
         flHWhhQqdnPpw9YrY1Gz1VVlC/3jJZCLzkDGaOrcdJt3Ym2wbgyWdfXAsDkVJEeCfsxi
         HzmxAs0pTu4mFFQrGjFlWSK845EFVbxXJ63cZlv39gtlVKZj9nxayW/KPLVEPcmjfZNr
         cT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jAdr+PRt2FqgbS5XOOCJ9tvwJq0Sqr672g8uyJKHQxE=;
        b=VzFmQuK8OqPG/2k5UMT1/8yqSbfoblNIfHf3j1Bi2Dx23TXzYgMUh1wwZ6te40K+c/
         HJxSqBIW7TKUY6cVaU6W53xA18hGupQ5Phnk+eYe6MAK/7CI6pfJKTMhoBQV8qEe+cdW
         LJyhdxIF9c/NhpQWC6mLeKHl+AheuUuns6IOynzGedj/o5uSOulrH0K1KlTnh/kbwLCT
         iHfWJUlKkSQZN9WqV9T+DZx7NHQJ64sHmAHp0PTB6A0r+wTIbScVvRbqb68F8AlZRMf0
         mBJV+68DFCGm5VrivIDgK9TZGJBWD/82ThlpKtP3b20t81b+sJAmyianfydR9pjYjOkj
         G8mw==
X-Gm-Message-State: APjAAAX2a2I4RhngaUU++um28ZvmJSe1tumEdKA1+Y/qSADM6xl7oOo4
        HK+EdMUNtwyIT3aSSVhcNi+djA==
X-Google-Smtp-Source: APXvYqyjKFWmKMA8MMlDR3xLrO67hCPYAWB96imqMAMJ3ql8fO8EwALYjIVqzuf6Fw3X4axT++r5lQ==
X-Received: by 2002:a0c:da11:: with SMTP id x17mr841622qvj.197.1566946085712;
        Tue, 27 Aug 2019 15:48:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id y5sm462004qkj.64.2019.08.27.15.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 15:48:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i2kFw-0003mf-RO; Tue, 27 Aug 2019 19:48:04 -0300
Date:   Tue, 27 Aug 2019 19:48:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/2] mm/hmm: two bug fixes for hmm_range_fault()
Message-ID: <20190827224804.GA31299@ziepe.ca>
References: <20190823221753.2514-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823221753.2514-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 03:17:51PM -0700, Ralph Campbell wrote:
> I have been working on converting Jerome's hmm_dummy driver and self
> tests into a stand-alone set of tests to be included in
> tools/testing/selftests/vm and came across these two bug fixes in the
> process. The tests aren't quite ready to be posted as a patch.
> I'm posting the fixes now since I thought they shouldn't wait.
> They should probably have a fixes line but with all the HMM changes,
> I wasn't sure exactly which commit to use.
> 
> These are based on top of Jason's latest hmm branch.
> 
> Ralph Campbell (2):
>   mm/hmm: hmm_range_fault() NULL pointer bug
>   mm/hmm: hmm_range_fault() infinite loop

Applied to hmm.git

Thanks,
Jason
