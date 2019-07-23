Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C100FC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E3B20840
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388816AbfGWQaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:30:52 -0400
Received: from verein.lst.de ([213.95.11.211]:43190 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727671AbfGWQav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:30:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9C53F68B02; Tue, 23 Jul 2019 18:30:48 +0200 (CEST)
Date:   Tue, 23 Jul 2019 18:30:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] nouveau: unlock mmap_sem on all errors from
 nouveau_range_fault
Message-ID: <20190723163048.GD1655@lst.de>
References: <20190722094426.18563-1-hch@lst.de> <20190722094426.18563-5-hch@lst.de> <20190723151824.GL15331@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723151824.GL15331@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 03:18:28PM +0000, Jason Gunthorpe wrote:
> Hum..
> 
> The caller does this:
> 
> again:
> 		ret = nouveau_range_fault(&svmm->mirror, &range);
> 		if (ret == 0) {
> 			mutex_lock(&svmm->mutex);
> 			if (!nouveau_range_done(&range)) {
> 				mutex_unlock(&svmm->mutex);
> 				goto again;
> 
> And we can't call nouveau_range_fault() -> hmm_range_fault() without
> holding the mmap_sem, so we can't allow nouveau_range_fault to unlock
> it.

Goto again can only happen if nouveau_range_fault was successful,
in which case we did not drop mmap_sem.

Also:

>  	ret = hmm_range_fault(range, true);
>  	if (ret <= 0) {
>  		if (ret == 0)
>  			ret = -EBUSY;
> -		up_read(&range->vma->vm_mm->mmap_sem);
>  		hmm_range_unregister(range);

This would hold mmap_sem over hmm_range_unregister, which can lead
to deadlock if we call exit_mmap and then acquire mmap_sem again.
