Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEAAC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 09:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C831A207FA
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 09:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfI2JQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 05:16:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfI2JQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 05:16:59 -0400
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 362DB85536
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 09:16:59 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id b17so5167694pfo.23
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 02:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P6VGb1/+Qfi2DI180P7/GtJ06kqrwHJMEdoHnmE9Gwg=;
        b=Q9Ug6u8eVaiJft/7hPU9eb1Fn+G1chxAJpfB7JzibWkjK3jpgARjceOzueqRKxzryQ
         mersuqR1y1/B7kEPKp+MndWG5Y/A05hHWygmp6QJ2Bt9e6JM9xyG+jgalrHolLVgZK4b
         xpWln2HCjzKQnQnNdoMiQ68ElX9lIcvuhfon3xf3Nc/vM7FosVRuCAUFWKU51mN+Bac8
         IZeraoZzMzFIK0RgSOdeGS1HO0QCMTcn1obL6TlT+eKog1BWjceP53X+fAXXFeuBSBHF
         LQA1Fn+Y3uDc/NUPY6R5s5S+iHhUV6GtBJVuYtmDzqXs+JTZqO525zwbsVLZ8FieWILS
         lk5Q==
X-Gm-Message-State: APjAAAVc8W4d37U0157NCN/nPPxfyS0tguztIslXGWrasQj6k3NvYm9O
        S/y1B3oyCpj4XBAob2zigVIgQ7Vc4YLTo0kws6HOUDl3TSSrH8EkxqJi5uP/NXrALYAhZc02cf4
        XczGyhm1IKEXW1sdCZpdi0EI4
X-Received: by 2002:a62:cf82:: with SMTP id b124mr14756297pfg.159.1569748618773;
        Sun, 29 Sep 2019 02:16:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyXjYVu6huJ3qsbdp5C5bVuAZKEs+4sotE2dY/cWXMPEirvmKQ1SfQ1LlVODij9fedALcPlNA==
X-Received: by 2002:a62:cf82:: with SMTP id b124mr14756272pfg.159.1569748618540;
        Sun, 29 Sep 2019 02:16:58 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u11sm12215952pgb.75.2019.09.29.02.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 02:16:56 -0700 (PDT)
Date:   Sun, 29 Sep 2019 17:16:41 +0800
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Matthew Wilcox <willy@infradead.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v5 16/16] mm/userfaultfd: Honor FAULT_FLAG_KILLABLE in
 fault path
Message-ID: <20190929091641.GA8642@xz-x1>
References: <20190926093904.5090-1-peterx@redhat.com>
 <20190926093904.5090-17-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190926093904.5090-17-peterx@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 05:39:04PM +0800, Peter Xu wrote:
> @@ -490,8 +512,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>  	up_read(&mm->mmap_sem);
>  
>  	if (likely(must_wait && !READ_ONCE(ctx->released) &&
> -		   (return_to_userland ? !signal_pending(current) :
> -		    !fatal_signal_pending(current)))) {
> +		   userfaultfd_signal_pending(vmf->flags))) {

Sorry, here it should be "!userfaultfd_signal_pending(vmf->flags)".

-- 
Peter Xu
