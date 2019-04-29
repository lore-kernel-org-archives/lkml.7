Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A3EC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8CB2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="YZxI/MTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfD2NZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 09:25:21 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40888 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfD2NZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 09:25:20 -0400
Received: by mail-yw1-f66.google.com with SMTP id t79so3670126ywc.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X9kf4JBFK1L9TXDCESs4VpTZ5WWFhznjkD+qwDCtBds=;
        b=YZxI/MTZu84kNPX0vmCPOIN20QsbPLkyEf9fmXM5keufwa34Lt2PwN490Ve/9oChXZ
         x1EimBr+XLhsPTAoPk7kT0bFs6cc8LmBvt/RaVfRuB4yBBggLxcELmGnDBGYmdbvAZ5n
         rNq/9Z1ft28qGjNWuQqbmh37yN1sfhUFvx4rcRiGrQYovoYu3fGAn+OgA8oEsph9NwEo
         eCWO/9dAFLy7+2WYWz5pgPMN0kTeoOOgnlbQWHokcwBNJ8JnwGEnE81XMB1jZbCbBp0+
         WKHDfVdmqjjstrOg0MMerxmA0BshTyayjr9RdKnKMp5v9Un6lNBDtYIXNtQMZeGbIZsC
         sSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X9kf4JBFK1L9TXDCESs4VpTZ5WWFhznjkD+qwDCtBds=;
        b=UhIDYfCpCGMbPhjurehLeQb7Arq6uzC9mLp/YUcdYNQkSsd0PPj0D956ESfpWt7Zzv
         Q8U4i9EHAvfs6NJBePW/NRHA2wnghBvyxoVj0LNvKkxu1hZDQVkWgXSbGlf/pFBaDtL1
         2VoLRw0Ri+agLPD5uknGjpI8vkYjXqPaKsYHWPufq+VbbtbQCe63asdlmhggzWBirHlU
         zf/EctTlu/sIzO1Mo7ERrymvFq0FvB/uFAjos4pZLhU1oOmdUkTRqirYsvVrXtgB5ZNM
         4wZzpYQwd5Ca937ViX+rlth6WWaXRkT+3ecM/Zrjtzb9pK11W1ZGt2E3CLmiYbR5LrA4
         geoQ==
X-Gm-Message-State: APjAAAW3cdtCb33FMAlMDGXMm+6IvV1M/7lWHKd60p7RFajvP1LLW+ku
        rd1VvogFCpjievxmjWqpi33ojUzsaBOamA==
X-Google-Smtp-Source: APXvYqyWT1Mdaz0GcnscCgwARQJx56yalbQKUAn8CvaggUEMppCjXwGgdfIj1rLJKV8jahJGn5CFoQ==
X-Received: by 2002:a0d:c445:: with SMTP id g66mr48824753ywd.61.1556544319865;
        Mon, 29 Apr 2019 06:25:19 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id t85sm2630104ywc.92.2019.04.29.06.25.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 06:25:19 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id A22AD30008B; Mon, 29 Apr 2019 16:25:18 +0300 (+03)
Date:   Mon, 29 Apr 2019 16:25:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: v5.1-rc7 fails to build on s390x (Re: Linux 5.1-rc7)
Message-ID: <20190429132518.75nlcixs3zgerv6c@kshutemo-mobl1>
References: <CAHk-=whvWQbP20g77U4QRXQDS5w+kf=V-P2QjMkgA-OwJJjHtg@mail.gmail.com>
 <20190429052136.GA21672@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429052136.GA21672@unicorn.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 07:21:36AM +0200, Michal Kubecek wrote:
> v5.1-rc7 fails to build on s390x due to
> 
> 		vmf->page = ZERO_PAGE(vmf->vm_start);
> 
> from commit 67f269b37f9b ("RDMA/ucontext: Fix regression with
> disassociate"). This is not a problem on x86_64 where ZERO_PAGE()
> doesn't use its argument but s390 version does.
> 
> I suppose the line should rather read
> 
> 		vmf->page = ZERO_PAGE(vmf->vma->vm_start);
> 
> but I'm just guessing.

I belive it has to be

		vmf->page = ZERO_PAGE(vmf->address);

-- 
 Kirill A. Shutemov
