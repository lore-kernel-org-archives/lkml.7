Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E859C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382B220578
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="FBMROBQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfD2MR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 08:17:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37855 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbfD2MR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:17:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id y5so14499722wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 05:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a7DlJaTbTNvFX68xDqMIysKa66WvtISND+ST6l40r4o=;
        b=FBMROBQeOH6h3eUXycnL1eVmXPv/W8DNxbzlOukDZhwV0KHK/Bidvn6Znnb/U+NnPk
         u0RE93Fi6qEqRz3WHdtssqlNLBYqALzZNYi2cvX3pqZhoknJdPhbEv1+demtMX2b1auw
         RNcO/FMauPbBwXsG1jLIOsAXLhML5U7WA1mU6THHF5s+XKnVcL9rg/jlMcNnaQsM21jD
         Yeo78SOTIXjGee3DJDGMe2PHZqyFV4RX04b/CdKviREP2/LUUy5pc7Yc07TkimC1ib9L
         Ex/ZAXrNt+AwXyu30jKwR1cqPTv4PS6DRb4tUYiRCTbbrSGFyG28OHLfKodLjWI9qpVQ
         6Jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a7DlJaTbTNvFX68xDqMIysKa66WvtISND+ST6l40r4o=;
        b=MJn3acCNchdBmEomkM+l3weyxXjyzkd8DlpbpPEnbI67vorgRFQz9AY4VhGiDP+JO5
         KNMADFXzu/f3lLj2+l+bHSOyqtNeFLiE/ngiCpInwcg+JbGQicA8scslEy/3qRlqe54O
         z83+T6esMgRLb+fshQp7DkfaKuVb38n7xh2qQP7Dp8fA7qDKBGa40DjQ+z/n5Cev8uUy
         hykpuy6zcuz/ZW3JYCUSOEWNEZqKjwNig5S005fq1MOWh1NDX4dNBoHFPSNBxV0ppUPQ
         Quptk28YajP3k722OZ9vGuAVb5ClaNUNcKyT4Ep56XiCAalSMYkflGj3ojULR+ayu2Nd
         bG5w==
X-Gm-Message-State: APjAAAUm4bOFB2ld4UBf4DYBbKoH/Umob2Z31nKyG+KDKqYHhQ6fPf3H
        rG8udcgfJzrVDnbkKapEjjdotgps/r6tSU4W22LciA==
X-Google-Smtp-Source: APXvYqztmcN6GpEmbERFxt6fPz3VDi6tdTf4b4mpj6GJ7H7zw4lc4d5VvjVO5bFyvWno2N9/vT5K6bH1uJjKQ/t9m3o=
X-Received: by 2002:a1c:c142:: with SMTP id r63mr17922446wmf.97.1556540275726;
 Mon, 29 Apr 2019 05:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190424165051.13614-1-tmurphy@arista.com> <20190426140429.GG24576@8bytes.org>
 <CAPL0++6_Hyozhf+eA2LM=t_Vuq8HaDzcczAUm0S4=DAw4jmMpA@mail.gmail.com> <20190429115916.GA5349@infradead.org>
In-Reply-To: <20190429115916.GA5349@infradead.org>
From:   Tom Murphy <tmurphy@arista.com>
Date:   Mon, 29 Apr 2019 13:17:44 +0100
Message-ID: <CAPL0++7G4zNp76z_8bzV84ky2vXeoX2jTCLSCC-CCWZMgwP5Pw@mail.gmail.com>
Subject: Re: [PATCH v1] iommu/amd: flush not present cache in iommu_map_page
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Tom Murphy <murphyt7@tcd.ie>, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        James Sewart <jamessewart@arista.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 12:59 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Apr 27, 2019 at 03:20:35PM +0100, Tom Murphy wrote:
> > I am working on another patch to improve the intel iotlb flushing in
> > the iommu ops patch which should cover this too.
>
> So are you looking into converting the intel-iommu driver to use
> dma-iommu as well?  That would be great!

Yes. My patches depend on the "iommu/vt-d: Delegate DMA domain to
generic iommu" patch which is currently being reviewed.
