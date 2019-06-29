Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CE0C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 15:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5624C215EA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 15:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G57SADTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfF2PJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 11:09:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32790 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfF2PJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 11:09:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id m4so3922323pgk.0;
        Sat, 29 Jun 2019 08:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4PDRDSdPlik/3Dz2WUeVgJcUfwA9IGRhonB1MM/wefg=;
        b=G57SADTMggL8n0pIpOEwPt5rucFLcFzaP0n3oeowJewkuuCijNkliMNKU+dGOlJ2fq
         EgAKCtiA3mOadRCmiaX8mEmLoId9NM33CuXBJlIVjavZ/WnnrRH6vZHvEDKKT/5R/aNr
         Y5VefnWEapcSksrsGqA6l2yPB2FUYnOh6Vi+ec1DRkT7wk27vt4ez6cL1TsEWp+WmJJD
         9czSVDIssaRJU7VtpsTT4SisHJVQZCK2gJ5Zlmlmi/1yGLJ9FoIo0IwwGlCR0OXlLBsy
         u8gp3kAJF4pXyVF54QHX3ujHIFjdgstGjSggr8TMM7tCgzpMymyRIkW7A3k/oUiZp/ow
         4BnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4PDRDSdPlik/3Dz2WUeVgJcUfwA9IGRhonB1MM/wefg=;
        b=X7cLS9IVUS5iluhdNhB2qi7aMkNE4AThbuJYpXcTT3mjed+niEQkX9aqO84WaNKgXG
         j6egxcWXHh7/5EuXTM8ZtOhAIJGd/9ocfpOeHogPceDL9VI047db4e08MSyz6+BIRRhU
         quIwLmUtdnPxeYUUvSs/V300l82Vv7BIxm2DgWgz1UtEfHqTzd/64wiE12J/Q3/njGTX
         2Obwl8czSjSku6kKlr32OdPTwUCBkhWRsox1+F7ASj3Hyiy9UK32pHY3j9Z6OU39mYQx
         7lHOSDjZdpFV+flQsl4ZRDfjYSc6tuJAdxNBzfu0Lm1E6zw9XNp/s5cWDzZ6QgAPGd0D
         84Yw==
X-Gm-Message-State: APjAAAWIpjpJZCDa6kkZXmta5Hk9dcw3i0prgvcbZdTT+SzPzgRVKA7C
        e9aK1iRDyaxnUV0Z898inh0=
X-Google-Smtp-Source: APXvYqyDBBSk+rR6gLpGBEL0OVOHp9fl5zjs/iRj+V1a6MYIR50eUUkJF3Dx9enR+JvisdUNTLheWg==
X-Received: by 2002:a17:90a:634a:: with SMTP id v10mr20203751pjs.16.1561820957173;
        Sat, 29 Jun 2019 08:09:17 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b3sm10519235pfp.65.2019.06.29.08.09.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 08:09:16 -0700 (PDT)
Date:   Sat, 29 Jun 2019 08:09:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] dma-direct: handle DMA_ATTR_NO_KERNEL_MAPPING in
 common code
Message-ID: <20190629150915.GA817@roeck-us.net>
References: <20190614144431.21760-1-hch@lst.de>
 <20190614144431.21760-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614144431.21760-7-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 04:44:30PM +0200, Christoph Hellwig wrote:
> DMA_ATTR_NO_KERNEL_MAPPING is generally implemented by allocating
> normal cacheable pages or CMA memory, and then returning the page
> pointer as the opaque handle.  Lift that code from the xtensa and
> generic dma remapping implementations into the generic dma-direct
> code so that we don't even call arch_dma_alloc for these allocations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This patch results in build failures for mips:nlm_xlp_defconfig and
mips:cavium_octeon_defconfig.

kernel/dma/direct.c:144: undefined reference to `arch_dma_prep_coherent'

Reverting the patch fixes the problem.

Guenter
