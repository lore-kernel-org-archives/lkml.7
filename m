Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20392C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB442218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCcv8Mak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfCVUJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:09:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40485 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfCVUJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:09:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id u9so2229709pgo.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 13:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3nmOuWwOVd8Yczty4wmaXEOpnu1RKTT07RlwP2tOJ/k=;
        b=TCcv8Mak6vX2KtH+VF94hAI1WCvGWBszOtQeEDwiNK3yqiUJ03RXvPwup4SGJRk3iD
         Bcc6kAvFvltjd/3r/JWPy+I6FEUcfiRGhk4ZgSkllVB05y3jUXjbmbyo2f3lONa9bw3x
         s77FNw5KQs0nq+z0llZIr3g9VvERi6enU6U0iH7CZouSiWURlu5QzWaurF58Cy3kDcYa
         adlJeXp0fk9IU0/ZEoeh1nAJKn+9/01DDdVWmI7P7FOVuGcLgOUbhgXqQn7JhqqkyW3a
         hZBgodru8CTUPKx2OsVsQ3dufz+zPlZXX05MhJKWff4529Qhf44Qr4wrsG3X81RRwG9r
         1CEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3nmOuWwOVd8Yczty4wmaXEOpnu1RKTT07RlwP2tOJ/k=;
        b=tARm1RToRfFTJbuQ554QcrvVnZi00dUmZZlx2LCgxBy+jKMfOeg5O6VcVz1V58BTkz
         eezGe7Vvzw7SmRu6q5b5kPtSzzea1Vqtgfw557NzdoCNAf7HQXUNmmtHAJa4HBYVso73
         z687xwbXJ+uxvCpCn0YvAybIx3+ExFLjeLMcpyl6y/3cvk7vjkJoI8BysR/TVY9OFVCX
         MbXhgiVAU0DoDJmYouDDcWXRZSEPtDJuTTNJEpDARUNRncy5ocx/N3PRmuB7gD7eABjQ
         R0Xf1kZFUucg2z3jTWDoEX1WADcPY6S45BbjCxsPS1Z35KI/IKBBHS/qlsAg5tbY8z2u
         MRog==
X-Gm-Message-State: APjAAAW04fIQeGE58DFcwaQye1CvpmHL7LAG8+o/PSOW5NBen4D9d5Hk
        MR2/yCMbS9ejUi7GNIUngc8=
X-Google-Smtp-Source: APXvYqyWfy8848bWtcf7jwol4LR56WP3+/Y4t5aRdJubflQGGODh8MPSRsoF1IR7RjKwrd9EPgMJxA==
X-Received: by 2002:a17:902:24:: with SMTP id 33mr11618962pla.259.1553285372263;
        Fri, 22 Mar 2019 13:09:32 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id b26sm7616844pgn.4.2019.03.22.13.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 13:09:31 -0700 (PDT)
Date:   Fri, 22 Mar 2019 13:09:26 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     hch@lst.de, robin.murphy@arm.com, vdumpa@nvidia.com,
        will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com,
        joro@8bytes.org, dwmw2@infradead.org, m.szyprowski@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        jonathanh@nvidia.com
Subject: Re: [PATCH v2 RFC/RFT] dma-contiguous: Get normal pages for
 single-page allocations
Message-ID: <20190322200925.GA22219@Asurada-Nvidia>
References: <20190305183202.16216-1-nicoleotsuka@gmail.com>
 <20190319144301.GG59586@arrakis.emea.arm.com>
 <20190321233248.GA6941@Asurada-Nvidia>
 <20190322105712.GB13384@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322105712.GB13384@arrakis.emea.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On Fri, Mar 22, 2019 at 10:57:13AM +0000, Catalin Marinas wrote:
> > > Do you have any numbers to back this up? You don't seem to address
> > > dma_direct_alloc() either but, as I said above, it's not trivial since
> > > some platforms expect certain physical range for DMA allocations.
> > 
> > What's the dma_direct_alloc() here about? Mind elaborating?
> 
> I just did a grep for dma_alloc_from_contiguous() in the 5.1-rc1 kernel
> and came up with __dma_direct_alloc_pages(). Should your patch cover
> this as well?

I don't get the meaning of "cover this" here. What missing part
do you refer to?
