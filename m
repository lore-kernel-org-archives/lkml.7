Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DE1CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFF22080F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KiufJgbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfJ3S0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:26:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38420 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfJ3S0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:26:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id w8so1359022plq.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DtrACqPWLXMscKFC3fwao3dgzXOornE3kvjDu6sEkLA=;
        b=KiufJgbrRj86zsIMV1otcowQqEIoRGhhadz0y1H4HBU5AssCVh8qhcYYFYmDKdSq+S
         3WQhFQE3NXpBBvl5Dq+sqppxJ+6ZTiIVYrSB4h7tULFSM7DjtsCFkiE9aZZ8TRdkPfx2
         FXHuk3epmTxo8mMNAjdAagwx0oLzAv9l8YdjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DtrACqPWLXMscKFC3fwao3dgzXOornE3kvjDu6sEkLA=;
        b=qhEx77jVHzBhHDwf6cndVmr67+i8rhV3RLjc2Cv5EAE1q2+CuDo6ldoTFDSg7ZAFIc
         Pp2VhYMOnHjobdgikmjkOPXeDCGkx6b1RZ9HLj346AQW1/DJUp0FRuZ5Xm0X9ch0RLhz
         6lGaYBULfbEss/C7xMQR2GnFVn6iaLLoB/bXtQU+oA9fAFeB5NARy0HfIG0mWU+t687r
         9ziqMVG/Io9HJuKofwePSyLkFkWa2pM2nuhc5HIhZ+BriyZumnZof9+gDB/x1M6+UTgf
         9kSf4WwJQ9C/nFMPC4dbu7+koNogAQGqBRGgSymoXBDEq/2MUk72mMs7LogFN68cLnW5
         LYaA==
X-Gm-Message-State: APjAAAVyD0weKi4AjzSyO/SOs940UrVzBnDcBmdSOslfHmfOIptaWjbu
        EwGex0G9hC0MtmE7IHxX0JIPqw==
X-Google-Smtp-Source: APXvYqz+gOml2V+1TkezZQvv3jWGc6cqrvBZVedrnNeCwDK/e+32G9IWArX+9+GEEwDFFkiQOHkacQ==
X-Received: by 2002:a17:902:bf0a:: with SMTP id bi10mr120764plb.56.1572459972890;
        Wed, 30 Oct 2019 11:26:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i16sm594315pfa.184.2019.10.30.11.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 11:26:11 -0700 (PDT)
Date:   Wed, 30 Oct 2019 11:26:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Semmle Security Reports <security-reports@semmle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dma-mapping: Add vmap checks to dma_map_single()
Message-ID: <201910301125.A1DD6D5F53@keescook>
References: <20191029213423.28949-1-keescook@chromium.org>
 <20191029213423.28949-2-keescook@chromium.org>
 <20191030091849.GA637042@kroah.com>
 <20191030180921.GB19366@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030180921.GB19366@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 07:09:21PM +0100, Christoph Hellwig wrote:
> On Wed, Oct 30, 2019 at 10:18:49AM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Oct 29, 2019 at 02:34:22PM -0700, Kees Cook wrote:
> > > As we've seen from USB and other areas[1], we need to always do runtime
> > > checks for DMA operating on memory regions that might be remapped. This
> > > adds vmap checks (similar to those already in USB but missing in other
> > > places) into dma_map_single() so all callers benefit from the checking.
> > > 
> > > [1] https://git.kernel.org/linus/3840c5b78803b2b6cc1ff820100a74a092c40cbb
> > > 
> > > Suggested-by: Laura Abbott <labbott@redhat.com>
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  include/linux/dma-mapping.h | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > > index 4a1c4fca475a..54de3c496407 100644
> > > --- a/include/linux/dma-mapping.h
> > > +++ b/include/linux/dma-mapping.h
> > > @@ -583,6 +583,12 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
> > >  static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
> > >  		size_t size, enum dma_data_direction dir, unsigned long attrs)
> > >  {
> > > +	/* DMA must never operate on areas that might be remapped. */
> > > +	if (dev_WARN_ONCE(dev, is_vmalloc_addr(ptr),
> > > +			  "wanted %zu bytes mapped in vmalloc\n", size)) {
> > > +		return DMA_MAPPING_ERROR;
> > > +	}
> > 
> > That's a very odd error string, I know if I saw it for the first time, I
> > would have no idea what it meant.  The USB message at least gives you a
> > bit more context as to what went wrong and how to fix it.
> > 
> > How about something like "Memory is not DMA capabable, please fix the
> > allocation of it to be correct", or "non-dma-able memory was attempted
> > to be mapped, but this is impossible to to" or something else.
> 
> I've fixed the message to "rejecting DMA map of vmalloc memory" and
> applied the patch.

Great; thank you!

-- 
Kees Cook
