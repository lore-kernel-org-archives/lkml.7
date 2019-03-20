Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F8CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074042184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="iNfJLn1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfCTVEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:04:06 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45491 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfCTVEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 17:04:06 -0400
Received: by mail-yw1-f67.google.com with SMTP id j128so3145996ywg.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 14:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c7mFoY9c1LOx2DLi8HmPtRRejYVacIC2KISLRsK7znE=;
        b=iNfJLn1VEvAICGg6+J8aTGo2WHwUAblrU8TC4P4d/YRBZXKDhFuHuWPyZ+0OcodA2R
         g7V3avx9WoHGDQcWiV6r3LM0LpMba9yJ3IUAj0x5QC+zKlzOmO4kgXtaoS+5XNfH35f6
         y3Q95eLIBZnLlHIgU2hmV3Z3aaaWgB2xG+sNBTD2NsA89KSRqyVkPML3RtWfJhtmFNdq
         uyW97pDsEiNY89ljQeenu9r/FX9qo6fKteLpOe4Ty8207DbRYrXxQ18O75u7haf4V8Sk
         XGHF1f5dd/S4jj+izKUS5beIisOqtB2HANTsNRLdkYtB97haZMPGFXeQ0p9W+YOT5XOm
         1Frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c7mFoY9c1LOx2DLi8HmPtRRejYVacIC2KISLRsK7znE=;
        b=ATZxbSZ66Ejo5CbM+jSRexhnVEPIezvE4VuMgZDOe6Zdtm7LCkVFGfaTkvMaVSuHY7
         sJCmJErvPCYNm9GrezvneqiaO28n9xYHy50AB3EEkCvzg5ZtPrhFOBQ8/y71WFYHKYan
         92yrlEQHEtzM+r1l3FW/7yZxmLH9IfihW2mRy0N3/E4Bw5limfvwvT4NMEJKKoDnzH3l
         NW6gNd238eT5wpgRXfhihjKSxdCk4SsycULUf6dKZHvgFqmwuYdoiwFVA4jCz/Z4p9dQ
         wgZRysD/X2cx0KHQZMFlHj/BzqU9auDze9SSrmFFETFfBMfaDomIrAeReNuDpw1CtOXT
         LNuA==
X-Gm-Message-State: APjAAAUhQBDW4Wv9h/Lq7YI5L3Wk+b9e8md/bd8lroaRO9cZFqfx0iRd
        IDdL/KkjZEgNsvdu34ceJ0gh9g==
X-Google-Smtp-Source: APXvYqyTEHhGxdOJ0WUla4LiMKIGI1B1SD0+iCGoWa94KCfF7DznKo6uv1EmkH63I8BFjx4vQCSD9w==
X-Received: by 2002:a25:d601:: with SMTP id n1mr28266ybg.342.1553115845368;
        Wed, 20 Mar 2019 14:04:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:b52c])
        by smtp.gmail.com with ESMTPSA id 79sm1444881ywr.110.2019.03.20.14.04.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 14:04:04 -0700 (PDT)
Date:   Wed, 20 Mar 2019 17:04:03 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, lizefan@huawei.com,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v6 6/7] refactor header includes to allow kthread.h
 inclusion in psi_types.h
Message-ID: <20190320210403.GE19382@cmpxchg.org>
References: <20190319235619.260832-1-surenb@google.com>
 <20190319235619.260832-7-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319235619.260832-7-surenb@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 04:56:18PM -0700, Suren Baghdasaryan wrote:
> kthread.h can't be included in psi_types.h because it creates a circular
> inclusion with kthread.h eventually including psi_types.h and complaining
> on kthread structures not being defined because they are defined further
> in the kthread.h. Resolve this by removing psi_types.h inclusion from the
> headers included from kthread.h.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

> @@ -26,7 +26,6 @@
>  #include <linux/latencytop.h>
>  #include <linux/sched/prio.h>
>  #include <linux/signal_types.h>
> -#include <linux/psi_types.h>
>  #include <linux/mm_types_task.h>
>  #include <linux/task_io_accounting.h>
>  #include <linux/rseq.h>

Ah yes, earlier versions of the psi patches had a psi_task struct or
something embedded in task_struct. It's all just simple C types now.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
