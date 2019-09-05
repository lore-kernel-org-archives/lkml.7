Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BCFC43140
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 22:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C95D20828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 22:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y1yQmcMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390419AbfIEWhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 18:37:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33895 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731969AbfIEWhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 18:37:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id r12so2878980pfh.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 15:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=GjBspe2tpCYYNWjl2LkWvULdU+0U6Dxr2p5C7+1bhNo=;
        b=Y1yQmcMalmEQm/Vqme6jPHNnMCdfGOzjjTtdcAIQEZZxyHtB2fOyO9RcDwAenVynP1
         oU2EWbBV8k3A/zrgzHKlhFl+OCjJA7+iFcROUVfqu0zVQJtdvGeCfe7NjlSjJt95b1D/
         +sI71E2Mgibu6zo1UdRBXiR6W+COpXDLAoZJKjTAFkblQQyepPHdb4Yw2B60eqK0bc/c
         5EZFQrraRiPZCgjeT/i0tuIlybmJBkDEeBq26FP+YjU3DIMEx+nkahOJs0NYOvvE8G4b
         wnhaXgd+jxqZlunLBkPxADJY04Lpuw8sXJbBOQ+cwbRupYKGQyxmFyerDToQmxrK9FHT
         swJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=GjBspe2tpCYYNWjl2LkWvULdU+0U6Dxr2p5C7+1bhNo=;
        b=Z3dXioqv6vpxeUPXfvRiQYfAMtP4AyZ1OojN8ulsMN24ofRa8/tcxBSFxAe5LXD+5B
         wFKIP3X4kcMfvPoIqkbA8lsL50bXTLW1u3Q8dQaIg0PisRhLKUp5VlDllnaM5DmSNcFJ
         jxgqPLGFjgyBmdFZmzNKunIyMTPv2HT/kSxor4OknlcHLzqMnyHJN12uIPm+4+tP5Gp6
         qSolNvqYpo4FT+OvOdGtfnnVaIuoHb0rNOdaVX8R2eYnI35e52V2oaw5ztRNYnjz4E9H
         wqqtNyZPX3y9oqCycO4s6RT802pl8iIeTBt3UeAW13wsbVNWNXJ3uyYwBRy3/zf4rHRA
         lsvw==
X-Gm-Message-State: APjAAAV5xjFaDgb0vOKqjKaxYubqaYQyp0fPEnvNr7i5f1XrR2p6mM61
        WVaKBW68dQ+zLlszVU39S/Q16A==
X-Google-Smtp-Source: APXvYqzoKno8KkgU8EqN4eXlIDNTHy2pjuloFOR5UxHRMSEDann6aIsDU+iY4ucPt4NGFSgWYqVMFg==
X-Received: by 2002:a17:90a:32c8:: with SMTP id l66mr6539209pjb.44.1567723038296;
        Thu, 05 Sep 2019 15:37:18 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id l72sm8557163pjb.7.2019.09.05.15.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 15:37:17 -0700 (PDT)
Date:   Thu, 5 Sep 2019 15:37:16 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Jianxiong Gao <jxgao@google.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [bug] __blk_mq_run_hw_queue suspicious rcu usage
In-Reply-To: <20190905060627.GA1753@lst.de>
Message-ID: <alpine.DEB.2.21.1909051534050.245316@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1909041434580.160038@chino.kir.corp.google.com> <20190905060627.GA1753@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019, Christoph Hellwig wrote:

> > Hi Christoph, Jens, and Ming,
> > 
> > While booting a 5.2 SEV-enabled guest we have encountered the following 
> > WARNING that is followed up by a BUG because we are in atomic context 
> > while trying to call set_memory_decrypted:
> 
> Well, this really is a x86 / DMA API issue unfortunately.  Drivers
> are allowed to do GFP_ATOMIC dma allocation under locks / rcu critical
> sections and from interrupts.  And it seems like the SEV case can't
> handle that.  We have some semi-generic code to have a fixed sized
> pool in kernel/dma for non-coherent platforms that have similar issues
> that we could try to wire up, but I wonder if there is a better way
> to handle the issue, so I've added Tom and the x86 maintainers.
> 
> Now independent of that issue using DMA coherent memory for the nvme
> PRPs/SGLs doesn't actually feel very optional.  We could do with
> normal kmalloc allocations and just sync it to the device and back.
> I wonder if we should create some general mempool-like helpers for that.
> 

Thanks for looking into this.  I assume it's a non-starter to try to 
address this in _vm_unmap_aliases() itself, i.e. rely on a purge spinlock 
to do all synchronization (or trylock if not forced) for 
purge_vmap_area_lazy() rather than only the vmap_area_lock within it.  In 
other words, no mutex.

If that's the case, and set_memory_encrypted() can't be fixed to not need 
to sleep by changing _vm_unmap_aliases() locking, then I assume dmapool is 
our only alternative?  I have no idea with how large this should be.
