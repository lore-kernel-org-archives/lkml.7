Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A221CC3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 11:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8101821019
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 11:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfHQLbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 07:31:33 -0400
Received: from verein.lst.de ([213.95.11.211]:33778 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfHQLbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 07:31:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D1B4A68B02; Sat, 17 Aug 2019 13:31:28 +0200 (CEST)
Date:   Sat, 17 Aug 2019 13:31:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] mm: turn migrate_vma upside down
Message-ID: <20190817113128.GA23295@lst.de>
References: <20190814075928.23766-1-hch@lst.de> <20190814075928.23766-2-hch@lst.de> <20190816171101.GK5412@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816171101.GK5412@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 05:11:07PM +0000, Jason Gunthorpe wrote:
> -	if (args->cpages)
> -		migrate_vma_prepare(args);
> -	if (args->cpages)
> -		migrate_vma_unmap(args);
> +	if (!args->cpages)
> +		return 0;
> +
> +	migrate_vma_prepare(args);
> +	migrate_vma_unmap(args);

I don't think this is ok.  Both migrate_vma_prepare and migrate_vma_unmap
can reduce args->cpages, including possibly to 0.
