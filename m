Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB575C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A61F2067B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DLXDmicD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfIQMiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:38:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34362 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfIQMiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:38:24 -0400
Received: by mail-ed1-f65.google.com with SMTP id p10so1366912edq.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 05:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fH6+7o6syLPR5DJ6dWMuF/JhEQdUQSof99mG97G17Lc=;
        b=DLXDmicD7OOygC/JbgTNNCd/yyvrqLEAeJjGJmlDK0oGZk9W/ggiZUTdchxnkcsXM8
         Vv5Z7HaPznKekmQEIk0ZszDwjFUAmdymDVf1jnqytM0+vrXcrR2kkHveOg7WrLu/UA9R
         Xj3xkM7N2F2t7yUZ1K5MhJ8JPKbpy/U1nkscY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=fH6+7o6syLPR5DJ6dWMuF/JhEQdUQSof99mG97G17Lc=;
        b=tJmO2GRu2e4gZAuquFZPxMlfaTnk7eEuYuEDpNh+DL4ubM7KQ3KsO9c4lxCjRkD/Qh
         LRdvgtDG5LMkrjKBR9NaiYDcWSzRvceakPQdUzu/oXyxrNUFkomV5CcR/hMpwHezb0yp
         zknIMSu3o8xCxgsg0CtoCn3QywfDoy8UpiopYXJ+NwnGJvELZJqKyDSHYOK44I2nU6Gj
         I8UVeBgXbUACX2Q6GGNND5Y4BPQxPLuFkH9K41Dlb9n6yVdvvTQpe0/LZO1gMe9gAEev
         pkQBGXGyh05j1H2tr27V6LjmHJGAV5EoGlk1tLwAQPB6WKzchzjnhA2gGXt2zhMpPzni
         YDjw==
X-Gm-Message-State: APjAAAXj0cw1Bis5PEA16nAFtDL/YYqggxJ92woy90rWF77iDSKN9wBT
        JN8zEoFdPKZpDU8kEON7U7mHlg==
X-Google-Smtp-Source: APXvYqwBU1dsPChIDGRc3R9W2EEapfs3WzNcvzVlPYxnGXDgQG7xfszeXgYUPZzJ79foYSp0UpwCFw==
X-Received: by 2002:a17:906:1941:: with SMTP id b1mr4432288eje.141.1568723900313;
        Tue, 17 Sep 2019 05:38:20 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id c21sm409131edy.70.2019.09.17.05.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 05:38:19 -0700 (PDT)
Date:   Tue, 17 Sep 2019 14:38:17 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     Steven Price <steven.price@arm.com>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: Prevent race when handling page fault
Message-ID: <20190917123817.GO3958@phenom.ffwll.local>
Mail-Followup-To: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Steven Price <steven.price@arm.com>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190905121141.42820-1-steven.price@arm.com>
 <20190913172454.GA5387@kevin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913172454.GA5387@kevin>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 01:24:54PM -0400, Alyssa Rosenzweig wrote:
> I'm conflicted on this series.
> 
> On the one hand, userspace should obviously not be able to crash the
> kernel. So the crash should be fixed in one way or another.
> 
> On the other hand, userspace really has to supply all the BOs it uses
> for correctness. I realize the DDK doesn't do this but... it probably
> should, umm...
> 
> Would it be possible to check for the NULL pointer in the kernel and
> skip printing information that would require a dereference? (Without
> having to play games with reference counts). Presumably that might fix
> crashes in other corner cases.

Yeah if this is the blob doing something funny I guess the right action
would be to kill that context and ban it from doing more funny things. So
not just trying to bail out without crashing.

Plus I guess the commit message should be a bit clearer in explaining
what's actually going on here :-)
-Daniel
> 
> On Thu, Sep 05, 2019 at 01:11:41PM +0100, Steven Price wrote:
> > When handling a GPU page fault addr_to_drm_mm_node() is used to
> > translate the GPU address to a buffer object. However it is possible for
> > the buffer object to be freed after the function has returned resulting
> > in a use-after-free of the BO.
> > 
> > Change addr_to_drm_mm_node to return the panfrost_gem_object with an
> > extra reference on it, preventing the BO from being freed until after
> > the page fault has been handled.
> > 
> > Signed-off-by: Steven Price <steven.price@arm.com>
> > ---
> > 
> > I've managed to trigger this, generating the following stack trace.
> > 
> > Unable to handle kernel NULL pointer dereference at virtual address 00000090
> > pgd = 33a6a181
> > [00000090] *pgd=00000000
> > Internal error: Oops: 5 [#1] SMP ARM
> > Modules linked in:
> > CPU: 0 PID: 81 Comm: irq/60-mmu Not tainted 5.3.0-rc1+ #4
> > Hardware name: Rockchip (Device Tree)
> > PC is at panfrost_mmu_map_fault_addr+0x140/0x3a0
> > LR is at _raw_spin_unlock+0x20/0x3c
> > pc : [<c0508944>]    lr : [<c07ced10>]    psr: 20030013
> > sp : ec643e88  ip : ea70ce24  fp : ec5fe840
> > r10: 00000001  r9 : 00000000  r8 : 000178c9
> > r7 : 00000000  r6 : 178c9f00  r5 : ec5fe940  r4 : ea70ce08
> > r3 : 00000000  r2 : 00000000  r1 : ec640e00  r0 : ec5fe940
> > Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > Control: 10c5387d  Table: 29f8406a  DAC: 00000051
> > Process irq/60-mmu (pid: 81, stack limit = 0x4b907106)
> > Stack: (0xec643e88 to 0xec644000)
> > 3e80:                   ec640e00 c07cede0 c0c0b200 ec640e00 00000000 00000000
> > 3ea0: 000178c9 00000000 c0c0b200 c07cede0 eef91040 ec5fe840 00000001 00000000
> > 3ec0: 00010001 010003c3 000000c3 00000001 178c9f00 c0508c98 eef91050 00000000
> > 3ee0: ec643f34 c07c9188 00000001 c0167854 00000000 ec643ef8 c0c08448 c07c933c
> > 3f00: 00000000 ec643f04 fffefffe 3d182b17 ee193468 ee193400 ec5db3c0 ec5db3c0
> > 3f20: c0183840 ec5db3e4 c0cb2874 c0183b08 00000001 c018385c ffffe000 ee193400
> > 3f40: ec5db3c0 c0183b8c c0c08448 00000000 60000013 00000000 c01839b8 3d182b17
> > 3f60: ffffe000 ec5d0500 ec5db380 ec642000 ec5db3c0 c0183a64 00000000 ed025cd8
> > 3f80: ec5d0538 c0146cfc ec642000 ec5db380 c0146bc0 00000000 00000000 00000000
> > 3fa0: 00000000 00000000 00000000 c01010b4 00000000 00000000 00000000 00000000
> > 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> > [<c0508944>] (panfrost_mmu_map_fault_addr) from [<c0508c98>] (panfrost_mmu_irq_handler_thread+0xf4/0x248)
> > [<c0508c98>] (panfrost_mmu_irq_handler_thread) from [<c018385c>] (irq_thread_fn+0x1c/0x58)
> > [<c018385c>] (irq_thread_fn) from [<c0183b8c>] (irq_thread+0x128/0x240)
> > [<c0183b8c>] (irq_thread) from [<c0146cfc>] (kthread+0x13c/0x154)
> > [<c0146cfc>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> > Exception stack(0xec643fb0 to 0xec643ff8)
> > 3fa0:                                     00000000 00000000 00000000 00000000
> > 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > Code: 1affffec eaffffe8 e5143004 e59d2014 (e5933090)
> > ---[ end trace 04eadc3009b8f507 ]---
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_mmu.c | 38 ++++++++++++++++---------
> >  1 file changed, 24 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> > index 842bdd7cf6be..115925e7460a 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> > @@ -392,9 +392,11 @@ void panfrost_mmu_pgtable_free(struct panfrost_file_priv *priv)
> >  	free_io_pgtable_ops(mmu->pgtbl_ops);
> >  }
> >  
> > -static struct drm_mm_node *addr_to_drm_mm_node(struct panfrost_device *pfdev, int as, u64 addr)
> > +static struct panfrost_gem_object *
> > +addr_to_drm_mm_node(struct panfrost_device *pfdev, int as, u64 addr)
> >  {
> > -	struct drm_mm_node *node = NULL;
> > +	struct panfrost_gem_object *bo = NULL;
> > +	struct drm_mm_node *node;
> >  	u64 offset = addr >> PAGE_SHIFT;
> >  	struct panfrost_mmu *mmu;
> >  
> > @@ -406,14 +408,17 @@ static struct drm_mm_node *addr_to_drm_mm_node(struct panfrost_device *pfdev, in
> >  
> >  		priv = container_of(mmu, struct panfrost_file_priv, mmu);
> >  		drm_mm_for_each_node(node, &priv->mm) {
> > -			if (offset >= node->start && offset < (node->start + node->size))
> > +			if (offset >= node->start &&
> > +			    offset < (node->start + node->size)) {
> > +				bo = drm_mm_node_to_panfrost_bo(node);
> > +				drm_gem_object_get(&bo->base.base);
> >  				goto out;
> > +			}
> >  		}
> >  	}
> > -
> >  out:
> >  	spin_unlock(&pfdev->as_lock);
> > -	return node;
> > +	return bo;
> >  }
> >  
> >  #define NUM_FAULT_PAGES (SZ_2M / PAGE_SIZE)
> > @@ -421,29 +426,28 @@ static struct drm_mm_node *addr_to_drm_mm_node(struct panfrost_device *pfdev, in
> >  int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as, u64 addr)
> >  {
> >  	int ret, i;
> > -	struct drm_mm_node *node;
> >  	struct panfrost_gem_object *bo;
> >  	struct address_space *mapping;
> >  	pgoff_t page_offset;
> >  	struct sg_table *sgt;
> >  	struct page **pages;
> >  
> > -	node = addr_to_drm_mm_node(pfdev, as, addr);
> > -	if (!node)
> > +	bo = addr_to_drm_mm_node(pfdev, as, addr);
> > +	if (!bo)
> >  		return -ENOENT;
> >  
> > -	bo = drm_mm_node_to_panfrost_bo(node);
> >  	if (!bo->is_heap) {
> >  		dev_WARN(pfdev->dev, "matching BO is not heap type (GPU VA = %llx)",
> > -			 node->start << PAGE_SHIFT);
> > -		return -EINVAL;
> > +			 bo->node.start << PAGE_SHIFT);
> > +		ret = -EINVAL;
> > +		goto err_bo;
> >  	}
> >  	WARN_ON(bo->mmu->as != as);
> >  
> >  	/* Assume 2MB alignment and size multiple */
> >  	addr &= ~((u64)SZ_2M - 1);
> >  	page_offset = addr >> PAGE_SHIFT;
> > -	page_offset -= node->start;
> > +	page_offset -= bo->node.start;
> >  
> >  	mutex_lock(&bo->base.pages_lock);
> >  
> > @@ -452,7 +456,8 @@ int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as, u64 addr)
> >  				     sizeof(struct sg_table), GFP_KERNEL | __GFP_ZERO);
> >  		if (!bo->sgts) {
> >  			mutex_unlock(&bo->base.pages_lock);
> > -			return -ENOMEM;
> > +			ret = -ENOMEM;
> > +			goto err_bo;
> >  		}
> >  
> >  		pages = kvmalloc_array(bo->base.base.size >> PAGE_SHIFT,
> > @@ -461,7 +466,8 @@ int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as, u64 addr)
> >  			kfree(bo->sgts);
> >  			bo->sgts = NULL;
> >  			mutex_unlock(&bo->base.pages_lock);
> > -			return -ENOMEM;
> > +			ret = -ENOMEM;
> > +			goto err_bo;
> >  		}
> >  		bo->base.pages = pages;
> >  		bo->base.pages_use_count = 1;
> > @@ -499,12 +505,16 @@ int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as, u64 addr)
> >  
> >  	dev_dbg(pfdev->dev, "mapped page fault @ AS%d %llx", as, addr);
> >  
> > +	drm_gem_object_put_unlocked(&bo->base.base);
> > +
> >  	return 0;
> >  
> >  err_map:
> >  	sg_free_table(sgt);
> >  err_pages:
> >  	drm_gem_shmem_put_pages(&bo->base);
> > +err_bo:
> > +	drm_gem_object_put_unlocked(&bo->base.base);
> >  	return ret;
> >  }
> >  
> > -- 
> > 2.20.1
> > 



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
