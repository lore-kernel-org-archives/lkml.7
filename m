Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580DFC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B342054F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii2p9txP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfDZUVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 16:21:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43133 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfDZUVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 16:21:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id z9so2109907pgu.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 13:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xOvO4DcMT8uPegtVLmOyrU3VxEBRiA2n9CIhn6aAJ68=;
        b=ii2p9txP3BYuOY93nFf/w0HYe9ra/B7vAHZ+9juH+lGZ55/EQwGyUCd59Os9PKdumV
         G72WdZNpUTNojDLkcnd5MX2svV0PL0ZQXHvst6MlcGqqh4P1sbUy+WY3tUp/1aj4E8+B
         LJCQmWof2vuAtlNEgPqAWUKo95+cZA7VE+G3dHu4RK/R3XfQU68lrU5RivFbLdeYpkZl
         IhLAHKrOCRnJZsDdaFu2hiwqrGYzkGd/T4ZdRHKO2zzIWNsmudUKtqaH+Po5paMF2Jvt
         4b4+o1xVKdrmajpzJFylyufsUh9kViP+kE33XfjkkDevnHFKFtrcXxXRP1ow618Wh79e
         O9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xOvO4DcMT8uPegtVLmOyrU3VxEBRiA2n9CIhn6aAJ68=;
        b=bWPQe2O+Ls3yQ8SzR4cZk8ziXp7v7bXfFzzNP6vxjHYpVaCYm7VSrlHdW5kJKFv1Y/
         WCV8dPlz0D+caPw+HuOUj9gwMciUbQIEUNzAXhuRrZBLlLB6mEZ2biVtUPnJU9x9eNTp
         fj6rmgIeQ8H8L/RjhbEHHcfPDTFVNJHdPSwVI+ypcIktnp8TDVZ6aOfDQdSRt853locq
         6eY0Wlp3PUfLdgM5Fd5LhIHVPKTm7DpTVvQBHbDchveqXTbsegbwhQz2B68muLuHNFFy
         rr16784k2Fx/7BdHFOGW0hV7Q0a2Z59JI9XwgQmuFx1i3LmTvqMOFFXLaM6qrzsC+0hY
         Il+A==
X-Gm-Message-State: APjAAAVOFpe2D8V/s78w4glikmDbAunppt+esuMcinobk3EeRh02PJde
        QVyfbpX1pivT5wG7jLXi7iY=
X-Google-Smtp-Source: APXvYqxww6o5Q4xL9x+BE+D1ofzetryWJAOJJcASB73A0QVw1aCU+osPcAXysawPPrwtEWFeFvaTKA==
X-Received: by 2002:aa7:8008:: with SMTP id j8mr20736592pfi.120.1556310077730;
        Fri, 26 Apr 2019 13:21:17 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 4sm35290987pfn.159.2019.04.26.13.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 13:21:17 -0700 (PDT)
Date:   Fri, 26 Apr 2019 13:21:12 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     robin.murphy@arm.com, vdumpa@nvidia.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, joro@8bytes.org,
        m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        tony@atomide.com
Subject: Re: [PATCH v2 RFC/RFT 1/5] ARM: dma-mapping: Add fallback normal
 page allocations
Message-ID: <20190426202110.GA11129@Asurada-Nvidia.nvidia.com>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
 <20190326230131.16275-2-nicoleotsuka@gmail.com>
 <20190424150638.GA22191@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424150638.GA22191@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 05:06:38PM +0200, Christoph Hellwig wrote:
> > +			if (!dma_release_from_contiguous(dev, page, count))
> > +				__free_pages(page, get_order(size));
> 
> Same for dma_release_from_contiguous - drop the _from, pass the
> actual size, and handle the free_pages fallback.

What do you think of dma_free_contiguous() instead? I feel "free"
is a bit more commonly used (in dma-mapping.h) and it's shorter.

Thanks
