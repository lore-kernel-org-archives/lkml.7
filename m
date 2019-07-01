Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300E8C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066D120B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+J3BWcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfGAVtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:49:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46995 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAVtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:49:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id 81so7180417pfy.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 14:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qrAn2xUKRq25y9kmzyaSOl6EHUIG32pV7WxMNDG8GTU=;
        b=r+J3BWcpMj4stnUQYC0UzYxus0LNbXZ5INvJM2e5T4JIlGrVQqhWSbGBRKIyPr535q
         8T93C+kbCyES+mBJZR9vt94+hsAfRX4P5uErBtHBheWxL238GDa9in27SoyF8aMms66F
         IHIpfeMYQEQS8gasoKDX/WcpFaaAK/v/gFJ0VEHsCTN4MtrbkqP+ia5TDYgUpZKobLmP
         wblE/51iRadAFKuCgP6eWWFUWjzAhQr5oDFH8HsC3KkFmT3AvD9cz3OpPpna9NegTqKu
         wyuxVglV4HU+6Agumkq3w1jx5uipzIUPZfJYhIQYn21ZRvT6cIRDz/M+2RrOFoiFYeH9
         dN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qrAn2xUKRq25y9kmzyaSOl6EHUIG32pV7WxMNDG8GTU=;
        b=L1R93hUO1l5ik2l0BhpTtQA4LeeUyfxm6APO5eDYkQtpYkcG25dSUywHwb4AWSnvCs
         vpa0avETJMjK8WA86uDWG/O5n8i0VODNBtA5Ad+6tuXWsC7rBVBJjCh1KnXQ0+6dTRYK
         O2oFeDVDkfWmuJtQktVKSiVsd5K22KRuye0x7dv+H0HRnRpjF4tbiWWcMYbIj+h+FKH4
         ft6/Vx/o1G6x/qI01HC6TQQ6GTogTqoDH4OpAT7Ca3Ui01jBDMIrzO8PCn3/Y0WFovJU
         etLvCxnqNTz61O6S8y58EXF2i0KSDCNUbwgvovvDQCNameF8trvoVyTFRo0tGNad66mm
         vdRw==
X-Gm-Message-State: APjAAAX9ZPDLyViSnFz4hXKK0KLoZP7SGM8WJBwbendB960A+Nm4+IXg
        qBT/bCP6oU4AYMwFYupYEsnHfZtnk6k=
X-Google-Smtp-Source: APXvYqybnVoHn0Mqql3MjYii8qxRZOBUD7/F4uVFfVlZKVv479rac3TNe4yf3ed1olx5G9I8U1x/2g==
X-Received: by 2002:a17:90a:26a1:: with SMTP id m30mr1595227pje.59.1562017794264;
        Mon, 01 Jul 2019 14:49:54 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id a3sm463514pje.3.2019.07.01.14.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Jul 2019 14:49:53 -0700 (PDT)
Date:   Mon, 1 Jul 2019 14:50:17 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: Fix calculation overflow in __finalise_sg()
Message-ID: <20190701215016.GA16247@Asurada-Nvidia.nvidia.com>
References: <20190622043814.5003-1-nicoleotsuka@gmail.com>
 <20190701122158.GE8166@8bytes.org>
 <91a389be-fd76-c87f-7613-8cc972b69685@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91a389be-fd76-c87f-7613-8cc972b69685@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Mon, Jul 01, 2019 at 01:39:55PM +0100, Robin Murphy wrote:
> > > The max_len is a u32 type variable so the calculation on the
> > > left hand of the last if-condition will potentially overflow
> > > when a cur_len gets closer to UINT_MAX -- note that there're
> > > drivers setting max_seg_size to UINT_MAX:
> > >    drivers/dma/dw-edma/dw-edma-core.c:745:
> > >      dma_set_max_seg_size(dma->dev, U32_MAX);
> > >    drivers/dma/dma-axi-dmac.c:871:
> > >      dma_set_max_seg_size(&pdev->dev, UINT_MAX);
> > >    drivers/mmc/host/renesas_sdhi_internal_dmac.c:338:
> > >      dma_set_max_seg_size(dev, 0xffffffff);
> > >    drivers/nvme/host/pci.c:2520:
> > >      dma_set_max_seg_size(dev->dev, 0xffffffff);
> > > 
> > > So this patch just casts the cur_len in the calculation to a
> > > size_t type to fix the overflow issue, as it's not necessary
> > > to change the type of cur_len after all.
> > > 
> > > Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > 
> > Looks good to me, but I let Robin take a look too before I apply it,
> > Robin?
> I'll need to take a closer look at how exactly an overflow would happen here

It was triggered by a test case that was trying to map a 4GB
dma_buf (1000+ nents in the scatterlist). This function then
seemed to reduce the nents by merging most of them, probably
because they were contiguous.

> (just got back off some holiday), but my immediate thought is that if this
> is a real problem, then what about 32-bit builds where size_t would still
> overflow?

I think most of callers are also using size_t type for their
size parameters like dma_buf, so the cur_len + s_length will
unlikely go higher than UINT_MAX. But just in case that some
driver allocates a large sg with a size parameter defined in
64-bit and uses this map() function, so it might be safer to
change to "size_t" here to "u64"?

Thank you
Nicolin
