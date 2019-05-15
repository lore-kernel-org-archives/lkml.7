Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67E8C04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E02920881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="nMdKe4p3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfEOQBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:01:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33740 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfEOQBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:01:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id m32so305940qtf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2C5ZLXS5pnK1SekssJfYLby68kNl/Hg91yqFVlQmDMw=;
        b=nMdKe4p3aF+xVyxfSk0pT8Zlqzg6/bn0U+5PqM0uOEZbamU2dToVvVrtN1ODTZKa0X
         EFkVsBDayJ2NH3cs7kMkrA1sYkJSKH7rRTHYhXvjPOx9CTVgQgCWE7Lj2XmmrwVM9hf+
         T5psHQVnACl/TqF+KUv18k3P/VR2QhgByTB1xwMGgmqa/mnfQD1M4JGZcuwvfOFFtxRz
         CItw9xiMnUyGWj6YFfe0jVyKELSEInBr+SoekmkF7yEPzwjMmBZHiTU7469kTxaRUd5x
         TN6749/HLAk/HJl7jGdpNlnbOhNeM5C7tzfPOwSxCOjB65QuEoEa8VHvIRnQfO/GWGLR
         o5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2C5ZLXS5pnK1SekssJfYLby68kNl/Hg91yqFVlQmDMw=;
        b=GW/fKQX2eA8ZHIRhnapXKShPrQMG/pqDsg1t+Ez90Bxo3EOjpbwuOZu/nJjB4hhPaF
         /3QG1SjWhbQqu8OY8kQaqQQokoMVxJaOCWzqA3Mt0kCA0wUJaXiioheE58fNIwxFAap9
         vjZkpLuu5bC+4sdasVim5H+byyw/+L3X2zjZhs8i51+u56biJmzXnYWO5nVRQAXqrQWJ
         jX2pJd1Dnv1AQgRcltZfA09dUxnmWTf+VHkasVTBOLARB1mOTBA4A46dDQJhCX9TvyUq
         e8lAPp5btHLjYZaEYGpFHFgoX0FGYBDu8IVvs+jd3Nx3VfcF7CzvJc8sCq3o+1esWZQ5
         EZuA==
X-Gm-Message-State: APjAAAVstU2lNS9ARpdsHp7mmML/ZfQJm77rGzA0wrW04LarkovJtfvU
        03rENCM5gwch9MUCrzjmuGmNTQ==
X-Google-Smtp-Source: APXvYqwV4+KcNeGJbIdrCbzY3gisqJkBjc81DjssqjrPCuGEYTm4AuvHyXhtYW5MdQ4zAHHbU5Ue8w==
X-Received: by 2002:a0c:9ac8:: with SMTP id k8mr34276654qvf.132.1557936109209;
        Wed, 15 May 2019 09:01:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::bca1])
        by smtp.gmail.com with ESMTPSA id z63sm1204403qkb.7.2019.05.15.09.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 09:01:48 -0700 (PDT)
Date:   Wed, 15 May 2019 12:01:47 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     josef@toxicpanda.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: filemap: correct the comment about VM_FAULT_RETRY
Message-ID: <20190515160146.te5tpydtclguxs6a@macbook-pro-91.dhcp.thefacebook.com>
References: <1556234531-108228-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556234531-108228-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 07:22:11AM +0800, Yang Shi wrote:
> The commit 6b4c9f446981 ("filemap: drop the mmap_sem for all blocking
> operations") changed when mmap_sem is dropped during filemap page fault
> and when returning VM_FAULT_RETRY.
> 
> Correct the comment to reflect the change.
> 
> Cc: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
