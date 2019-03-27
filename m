Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2AEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E6D2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjRrlJ/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391466AbfC0Sml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:42:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33070 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbfC0Smi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:42:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id bg8so3717328plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 11:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dVB+Wj9UZO7gQ/N+/6EyF4+bcwcw/DAMjGzAnDrQl2g=;
        b=bjRrlJ/9a192FSR7+f6s8erxI31x3OnSPNfpJSBLxziDSPitgVkHFMoFCDRJbCH6oU
         u9iFun+TCamlYJio2pnj4hM6Y5k6j2uI4tJvKsLHlgu0zg2G5i1IvUCquMRCVJe5X1Ix
         9o9HgmZTSIH0bYzWTGitYEjezfTsSmzez95vc7RvUSl1F1DMzHuUEt1qWGEl9CoMxN1d
         fkwyEsa22SEJ5ri6Ko/udr4UpomS2ZXd22suhF9XgJ4Kj8zyVqtspIEZjJaCQ6Mt/HAf
         i2a1/NZ1TwIyzRSQSVD7ud1y3oLa/GiEEMUG6Xa418xmo8akQYdLKXGg+45EyweRMBK5
         TuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dVB+Wj9UZO7gQ/N+/6EyF4+bcwcw/DAMjGzAnDrQl2g=;
        b=BuxP4ARrjltw6i6YNXc11gQdxbvCwzRocmjAoK6HWSy8xxFfkFA1OatPUuLf9LuWse
         kH4hCaMDzDgvuhFHM7iNgzphKevHa7oCndVeF1xiqE1jDIj9b4ZSQTJUHgaifQGvL9SH
         QrpSirxpOHrRDe9rUtIzyxiX84MsCWWFYnfed/s1HdvVlgzDYrJ0bOT19ELk8cV+NiF1
         G1UksdYn0QQijfEcbdWmdQJ6c/95NUHDNJHhYqYFxZLCmsCfJz8DJkkbt1fIhrko3kb5
         suHy15lawrRtLN/Z4Yr3waiEhzTuSldPUi7TipOrqomcKDuhIdX1dtxaWGIwH0FKa9zr
         xOTg==
X-Gm-Message-State: APjAAAXlz4N3jWJ75Rv+45CwYgs8XTIrZ/w1khxVf5WD4ELNsi23N94c
        FAvpCbsR1OV0VhhXY5jo90Q=
X-Google-Smtp-Source: APXvYqxgRRn7KJSKtuGuYE8Ppsl/RqXLOPI66I6wIDpcKeTKvGEvQFNlyFwPaxWqgfeISfhR4eFEdA==
X-Received: by 2002:a17:902:2983:: with SMTP id h3mr39436984plb.332.1553712157170;
        Wed, 27 Mar 2019 11:42:37 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id v18sm28129738pfm.165.2019.03.27.11.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 11:42:36 -0700 (PDT)
Date:   Wed, 27 Mar 2019 11:42:32 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     robin.murphy@arm.com, vdumpa@nvidia.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, joro@8bytes.org,
        m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        tony@atomide.com
Subject: Re: [PATCH v2 RFC/RFT 0/5] Save single pages from CMA area
Message-ID: <20190327184231.GA13287@Asurada-Nvidia>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
 <20190327080821.GB20336@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327080821.GB20336@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 09:08:21AM +0100, Christoph Hellwig wrote:
> On Tue, Mar 26, 2019 at 04:01:26PM -0700, Nicolin Chen wrote:
> > This series of patches try to save single pages from CMA area bypassing
> > all CMA single page alloctions and allocating normal pages instead, as
> > all addresses within one single page are contiguous.
> > 
> > We had once applied the PATCH-5 but reverted it as actually not all the
> > callers handled the fallback allocations. Per Robin's suggestion, let's
> > stuff alloc_pages()/free_page() fallbacks to those callers before having
> > PATCH-5.
> 
> Given the problems this has caused so far I'd like to see a good
> explanation of why this optimization is so important that all the churn
> is even worth it..

With certain downstream user cases, we had run into a CMA exhaustion
situation, and this was one of the changes that eased the problem. I
have all the reasoning in the PATCH-5 commit message. And what Robin
tested can also justify for it:
https://lore.kernel.org/patchwork/patch/1004934/#1190139

Thanks
