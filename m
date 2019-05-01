Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DF2C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCFC2085A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9Gy2M+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfEATYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 15:24:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43154 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfEATYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 15:24:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id n8so8578684plp.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 12:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hF6fNKlhWYgrPc17wR/AXCapWmsiWzeqUovI/sNlDvo=;
        b=n9Gy2M+OdEVC80XuMGmxjU81J0AVS7+2rco21taXmSACRKNhQOtBYnVj3rDyTp7kJo
         5GRfqvrawVTfvndMWCdx2aZZNd/oNI2eRj7kjmz5hVAG69lDsm0JU+qpoD0vE4uwi3eK
         zATG8dhRIkDgWpB7SnV0F/4msBzekFhGZw1e3TwDeZkwWfXZWZ/MT76z+2vFCgbCj4JR
         SotP1RtK7esW2k3SkOZyzIVjVoasV+BDepMHV9bZXyUoYjiwL94ZaeNgHJ4bOiD/885y
         bSbJXtEQwB2oUz/TL3IVh1D2PiTChIm4LFeHSKCD4ftXt9CXsp5ZXIsCfj9LVe8e1xXX
         kRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hF6fNKlhWYgrPc17wR/AXCapWmsiWzeqUovI/sNlDvo=;
        b=A8i19qz3udd5lbeWtJY8K4qqE1zdJlQCjTN2wMANW6xdhtjO5XY/6HpYmcx+VGrgIE
         SeWv9iPOfhAKyMOZVjCSRml97ae5S1H6hMkYO4Jh+mGSagTsTSBUgqxMGNKUopwYA+wU
         ADgBk8SbG5iOwHohNIHoLCVeXxnC2th6ygvMQgjXxaUDRd+uzB0QkF3Lg5j5VGNaREai
         oAVIcY1dlXHVvjG3XWhBluctYqNKBXOKMTEsS0DfQQ9vhHXCY6LqyAIcXSGJio9678oe
         FRmMfiYzKpyM2fgCOlUuLAwezb21u8XM2HVRRVVH4897bXAD/GMPGOZavYDpplOM0x59
         nh7A==
X-Gm-Message-State: APjAAAUYUq7xWCQapbJXx77aWoJ9L6w1qxFHzTgRNjz3yq5q7XYoqekZ
        tpAwLZty0klyPQXGHWGcw2c=
X-Google-Smtp-Source: APXvYqy1jVE0MyKKlrK0SoUTj5YOCa0gPHBNRhCLy07Q9zFHM+JQiWrmKSvfoL1ZHuzvAAJmqHo4VA==
X-Received: by 2002:a17:902:1c7:: with SMTP id b65mr9398715plb.2.1556738640687;
        Wed, 01 May 2019 12:24:00 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q80sm75239448pfa.66.2019.05.01.12.23.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 12:23:59 -0700 (PDT)
Date:   Wed, 1 May 2019 12:23:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] mm/hmm: add ARCH_HAS_HMM_MIRROR ARCH_HAS_HMM_DEVICE
 Kconfig
Message-ID: <20190501192358.GA21829@roeck-us.net>
References: <20190417211141.17580-1-jglisse@redhat.com>
 <20190501183850.GA4018@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190501183850.GA4018@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 02:38:51PM -0400, Jerome Glisse wrote:
> Andrew just the patch that would be nice to get in 5.2 so i can fix
> device driver Kconfig before doing the real update to mm HMM Kconfig
> 
> On Wed, Apr 17, 2019 at 05:11:41PM -0400, jglisse@redhat.com wrote:
> > From: Jérôme Glisse <jglisse@redhat.com>
> > 
> > This patch just add 2 new Kconfig that are _not use_ by anyone. I check
> > that various make ARCH=somearch allmodconfig do work and do not complain.
> > This new Kconfig need to be added first so that device driver that do
> > depend on HMM can be updated.
> > 
> > Once drivers are updated then i can update the HMM Kconfig to depends
> > on this new Kconfig in a followup patch.
> > 

I am probably missing something, but why not submit the entire series together ?
That might explain why XARRAY_MULTI is enabled below, and what the series is
about. Additional comments below.

> > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Leon Romanovsky <leonro@mellanox.com>
> > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Ralph Campbell <rcampbell@nvidia.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > ---
> >  mm/Kconfig | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 25c71eb8a7db..daadc9131087 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -676,6 +676,22 @@ config ZONE_DEVICE
> >  
> >  	  If FS_DAX is enabled, then say Y.
> >  
> > +config ARCH_HAS_HMM_MIRROR
> > +	bool
> > +	default y
> > +	depends on (X86_64 || PPC64)
> > +	depends on MMU && 64BIT
> > +
> > +config ARCH_HAS_HMM_DEVICE
> > +	bool
> > +	default y
> > +	depends on (X86_64 || PPC64)
> > +	depends on MEMORY_HOTPLUG
> > +	depends on MEMORY_HOTREMOVE
> > +	depends on SPARSEMEM_VMEMMAP
> > +	depends on ARCH_HAS_ZONE_DEVICE

This is almost identical to ARCH_HAS_HMM except ARCH_HAS_HMM
depends on ZONE_DEVICE and MMU && 64BIT. ARCH_HAS_HMM_MIRROR
and ARCH_HAS_HMM_DEVICE together almost match ARCH_HAS_HMM,
except for the ARCH_HAS_ZONE_DEVICE vs. ZONE_DEVICE dependency.
And ZONE_DEVICE selects XARRAY_MULTI, meaning there is really
substantial overlap.

Not really my concern, but personally I'd like to see some
reasoning why the additional options are needed .. thus the
question above, why not submit the series together ?

Thanks,
Guenter

> > +	select XARRAY_MULTI
> > +
> >  config ARCH_HAS_HMM
> >  	bool
> >  	default y
> > -- 
> > 2.20.1
> > 
