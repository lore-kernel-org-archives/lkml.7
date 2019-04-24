Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48946C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8C82183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPlQwqKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389133AbfDXTir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:38:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34138 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDXTir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:38:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so9844602pfd.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 12:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gt37LcZrQPa+TVFY3hiGvxib7Pgjtqj0YnN2XvJD4vw=;
        b=PPlQwqKk9Cano+RcLs4BXcQoNOMDz0ZTmEbFr3Dph4+TWcEyF2lHobLKPfUPc0guCL
         VuJKbYTLqPa6lUXqZqO9qqg/+dSBWdLiDcnCdnQs4V8O3pZm2cQ56dkRIJ4869w+znU+
         WGmPyIF/Gp7jO/KTOgVz5N2S7d9dv7nEAaV3iCzx+Hl9wYMuutYcHVomADdaofVr0tMl
         L8uDBWNLQ8TqxeKFsOppbGjDol51x5tT18wHHKdn0MmSzaMgLN/eMgdx0mRBuCDvFaNp
         zBcWBA3bKUc6ZZ6fkGQhdQIIvCiu4+aJXgu2RRb9V6gqz19DC6vWy1nkONy9VrPJYmD/
         614g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gt37LcZrQPa+TVFY3hiGvxib7Pgjtqj0YnN2XvJD4vw=;
        b=mIGMmBAqyx+LWBdHAUOp7buoB00jjanliCdo0Xx+tKGb85oDGRTll6eLkDV103fV01
         GMFtzCSVPsKb0Jv0dW34MTFYoQPXZ/HX7aK1/U1JFerYL8MyQ8hZ6AwEebi7JPRAw9kh
         yOuPRQlV6AB8vYEnViuyAc1LGzINh4EWxrN0zafoJBgn0Z37iN4DPizSPCQuWcv7fvHT
         MOtZiggmZ/cReH6dJjAt7kLRPeENLLGIrNLWlENevfQv9NLVD81Q8pWmlhVVPOX6M7gE
         SAD6tl3W7bImiq38FgQ1lSaa8WDUlUO5nPUa28Hx1l9sUDyVSTJ6g1bv/VC8vWF8yYcd
         Abhg==
X-Gm-Message-State: APjAAAU+1FnzFIfifsQiEmqp5mFsDykQxZOgURE84O7Crtfeh41Z5c+T
        1RUAKJ73b50Q0opYx067i5I=
X-Google-Smtp-Source: APXvYqy6dfj/Q7qcYcnC9q8nuVjXxrC9oFUtPdUS8oVrD9JdpSnWzoVJDDsr+eYqSVRCowjtUkZvvA==
X-Received: by 2002:a65:6201:: with SMTP id d1mr15539968pgv.28.1556134726459;
        Wed, 24 Apr 2019 12:38:46 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id f87sm32296503pff.56.2019.04.24.12.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 12:38:45 -0700 (PDT)
Date:   Wed, 24 Apr 2019 12:38:41 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     robin.murphy@arm.com, vdumpa@nvidia.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, joro@8bytes.org,
        m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        tony@atomide.com
Subject: Re: [PATCH v2 RFC/RFT 1/5] ARM: dma-mapping: Add fallback normal
 page allocations
Message-ID: <20190424193840.GA30240@Asurada-Nvidia.nvidia.com>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
 <20190326230131.16275-2-nicoleotsuka@gmail.com>
 <20190424150638.GA22191@lst.de>
 <20190424183310.GA6168@Asurada-Nvidia.nvidia.com>
 <20190424192652.GA29032@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424192652.GA29032@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 09:26:52PM +0200, Christoph Hellwig wrote:
> On Wed, Apr 24, 2019 at 11:33:11AM -0700, Nicolin Chen wrote:
> > I feel it's similar to my previous set, which did most of these
> > internally except the renaming part. But Catalin had a concern
> > that some platforms might have limits on CMA range [1]. Will it
> > be still okay to do the fallback internally?
> > 
> > [1: https://www.spinics.net/lists/arm-kernel/msg714295.html ]
> 
> Catalins statement is correct, but I don't see how it applies to
> your patch.  Your patch just ensures that the fallback we have
> in most callers is uniformly applied everywhere.  The non-iommu
> callers will still need to select a specific zone and/or retry
> just the page allocator with other flags if the CMA (or fallback)
> page doesn't match what they need.  dma-direct does this correctly
> and I think the arm32 allocator does as well, although it is a bit
> hard to follow sometimes.

Okay. I will revise and submit the patches then. I think we
can still discuss on this topic once we have the changes.

Thanks
