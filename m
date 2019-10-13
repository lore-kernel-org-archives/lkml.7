Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F163C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 12:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7982F2082F
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 12:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfJMMUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 08:20:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50462 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728620AbfJMMUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 08:20:54 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4CA84C0495A1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 12:20:53 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id m20so14924495qtq.16
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 05:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sGSWm+VQXM5N7LkmMBoNiFJID9rxkV4UgGbQSywZ0lY=;
        b=BqWCIHL2a9KtHH7ST9MSnv+qFEcnryiaTTdcAgCzFQNLvtbDmlEx2LysmFvbHN3TDz
         YNYD2KGhegWz9CAbBsUuHGheVG2envpSQ+eF4EpbD769IkOalGMql+BUtJe9XZ39p/Nv
         uh0xlIUkNfeSXQ+jAhVBI84TFqLHgp44wHsMqNAE/KwEZz3r3UBwGE+pItrpushbMZVx
         npFxZXhOW1jo7riigfu6JWXrIFfQSAOz4RYQtheGo2Mkqc1TRbxNPVZ3T2vOLL+y4VpP
         KUVwynu1hhrH/gvm2VZGs51Rpio6rG/L6LJfwHHVRrYsomYCcumbSBPkH0DIYxyuA7M+
         c4LQ==
X-Gm-Message-State: APjAAAV3BHy06DxZLmdLBzMgtRd+maqGREtAIjsaqGTdErJahOD3R20D
        u7fEk4jnvmK/B8Q3BSS4XW1DqL4+zu3rBbFUwd+Gmc8xJuBAxlm1NTTvoIYQGyIBrztUMvbcIa1
        Lc5VvLsTgNmVNca/N+Rfhkhjf
X-Received: by 2002:ac8:610e:: with SMTP id a14mr27955174qtm.189.1570969252116;
        Sun, 13 Oct 2019 05:20:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyh+vun7Xp3yoPFQiELIdRCqqNlbWf3RdBCpLjK1jdAhUPgwQp14PoZIlUScyHDNFQhMA16jw==
X-Received: by 2002:ac8:610e:: with SMTP id a14mr27955160qtm.189.1570969251921;
        Sun, 13 Oct 2019 05:20:51 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id m14sm6458463qki.27.2019.10.13.05.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 05:20:51 -0700 (PDT)
Date:   Sun, 13 Oct 2019 08:20:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jan Kiszka <jan.kiszka@web.de>
Cc:     Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/virtio: Fix build
Message-ID: <20191013081541-mutt-send-email-mst@kernel.org>
References: <4b686914-075b-a0a9-c97b-9def82ee0336@web.de>
 <20191013075107-mutt-send-email-mst@kernel.org>
 <08c1e081-765b-7c3a-ed31-2059dc521fd0@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08c1e081-765b-7c3a-ed31-2059dc521fd0@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2019 at 02:01:03PM +0200, Jan Kiszka wrote:
> On 13.10.19 13:52, Michael S. Tsirkin wrote:
> > On Sun, Oct 13, 2019 at 11:03:30AM +0200, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> Various changes in the recent kernel versions broke the build due to
> >> missing function and header stubs.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >
> > Thanks!
> > I think it's already fixes in the vhost tree.
> > That tree also includes a bugfix for the test.
> > Can you pls give it a spin and report?
> 
> Mostly fixed: the xen_domain stup is missing.
> 
> Jan

That's in xen/xen.h. Do you still see any build errors?

> > Thanks!
> >
> >> ---
> >>  tools/virtio/crypto/hash.h       | 0
> >>  tools/virtio/linux/dma-mapping.h | 2 ++
> >>  tools/virtio/linux/kernel.h      | 2 ++
> >>  3 files changed, 4 insertions(+)
> >>  create mode 100644 tools/virtio/crypto/hash.h
> >>
> >> diff --git a/tools/virtio/crypto/hash.h b/tools/virtio/crypto/hash.h
> >> new file mode 100644
> >> index 000000000000..e69de29bb2d1
> >> diff --git a/tools/virtio/linux/dma-mapping.h b/tools/virtio/linux/dma-mapping.h
> >> index f91aeb5fe571..db96cb4bf877 100644
> >> --- a/tools/virtio/linux/dma-mapping.h
> >> +++ b/tools/virtio/linux/dma-mapping.h
> >> @@ -29,4 +29,6 @@ enum dma_data_direction {
> >>  #define dma_unmap_single(...) do { } while (0)
> >>  #define dma_unmap_page(...) do { } while (0)
> >>
> >> +#define dma_max_mapping_size(d)	0
> >> +
> >>  #endif
> >> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> >> index 6683b4a70b05..ccf321173210 100644
> >> --- a/tools/virtio/linux/kernel.h
> >> +++ b/tools/virtio/linux/kernel.h
> >> @@ -141,4 +141,6 @@ static inline void free_page(unsigned long addr)
> >>  #define list_for_each_entry(a, b, c) while (0)
> >>  /* end of stubs */
> >>
> >> +#define xen_domain() 0
> >> +
> >>  #endif /* KERNEL_H */
> >> --
> >> 2.16.4
