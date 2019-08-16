Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79C7C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 15:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB5921743
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 15:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oy5sZFjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfHPPOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 11:14:55 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36167 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfHPPOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 11:14:54 -0400
Received: by mail-qk1-f193.google.com with SMTP id d23so5059788qko.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fov2CgaO1O1CFkZX4IfqnTZnTK7C3zpSvYgzXGSY56g=;
        b=oy5sZFjQp1BCVaEwQsb3+KNPFbSHSZHWPBMzBnqM3YkM8M6TeLN/TchFjkEdsICSuJ
         1C+Aqtldy/Y4ldUDXhcLTuhfNncF7+Dyd3fNJ1bom3uP8hS9LridrmdEdsAQXWEZtKjz
         7XP3pkdVorvFX0x7VQ1DMygwaFOvfV+UwasgUORcn3BEim4b1kFT8oE06M97uDUrjOv5
         mMHA/Z8hsM7HRGW+maHrZQD/1QDaaYGCk/ab/4r4vI2lVu52wx2id8gV5icj3phd9BLt
         KUOXu736r5AT7W/9wY/TxeK4Ryn6yfFSyNCnwDYASLlBBEV0NjKDADW49yLgEKf3SWZn
         2lUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fov2CgaO1O1CFkZX4IfqnTZnTK7C3zpSvYgzXGSY56g=;
        b=G5xoIeveoZ6f0tU3wLezmJtb0F1U/h8EZhSmgZg9r8uYp8a0DL0NJt0Pbr3OpxMasw
         I6W/Fy3iCWyeNpOZ6mlEYwaBu5/b5o32G8Z0zPN5NLCmQ4x+KqGFfSn8qj/Qsp1J5rc6
         wXElEqU2qnS8B83+IEVlDYgnszoARq6Cy8s2TW+Vqivd1kHvlxftmqUsbMFjQE0V9qi6
         997hrk5OKSR4FW/peAQBBRbNSXNgJ0IzF1lDzJa8JenUCC/kcmJmytBD6NBahR1tyGiB
         aUkPhjeyP8zKDP3eaPDnTrXc85H9EzS1/mUv+GouCZbat/L0r+RcCsXMz4whfGpxJ3eG
         51Xg==
X-Gm-Message-State: APjAAAW90WCXCkvfWcnzKl5EHwquBiHF9cJEu4CUo/Dg19yTEO+k7NI+
        j2mPWG1InwlRmyqXBU6/hN9rmQ==
X-Google-Smtp-Source: APXvYqxJQYOJO15q7RlRP/vufAQqFSxN3g0+gtugu+v5p95C5icfuXRjyKSuaK0zmQH83GKJGhGMfA==
X-Received: by 2002:a05:620a:1590:: with SMTP id d16mr9385834qkk.18.1565968493491;
        Fri, 16 Aug 2019 08:14:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o127sm3158342qkd.104.2019.08.16.08.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Aug 2019 08:14:53 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hydwK-0003JY-LJ; Fri, 16 Aug 2019 12:14:52 -0300
Date:   Fri, 16 Aug 2019 12:14:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org,
        Gavin Shan <shangw@linux.vnet.ibm.com>,
        Andrea Righi <andrea@betterlinux.com>
Subject: Re: [PATCH v3 hmm 00/11] Add mmu_notifier_get/put for managing mmu
 notifier registrations
Message-ID: <20190816151452.GA8562@ziepe.ca>
References: <20190806231548.25242-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806231548.25242-1-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 08:15:37PM -0300, Jason Gunthorpe wrote:
> This series is already entangled with patches in the hmm & RDMA tree and
> will require some git topic branches for the RDMA ODP stuff. I intend for
> it to go through the hmm tree.

> Jason Gunthorpe (11):
>   mm/mmu_notifiers: hoist do_mmu_notifier_register down_write to the
>     caller
>   mm/mmu_notifiers: do not speculatively allocate a mmu_notifier_mm
>   mm/mmu_notifiers: add a get/put scheme for the registration
>   misc/sgi-gru: use mmu_notifier_get/put for struct gru_mm_struct
>   hmm: use mmu_notifier_get/put for 'struct hmm'
>   drm/radeon: use mmu_notifier_get/put for struct radeon_mn
>   drm/amdkfd: fix a use after free race with mmu_notifer unregister
>   drm/amdkfd: use mmu_notifier_put

Other than these patches:

>   RDMA/odp: use mmu_notifier_get/put for 'struct ib_ucontext_per_mm'
>   RDMA/odp: remove ib_ucontext from ib_umem
>   mm/mmu_notifiers: remove unregister_no_release

This series has been applied.

I will apply the ODP patches when the series they depend on is merged
to the RDMA tree

Any further acks/remarks I will annotate, thanks in advance

Thanks to all reviewers,
Jason
