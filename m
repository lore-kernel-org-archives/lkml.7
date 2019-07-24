Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E800C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF57229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="GJVHWb7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfGXPzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:55:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32893 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfGXPze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 11:55:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id i11so47573452edq.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 08:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XRJqhDHx7Uz3bLvE/9qsXUPLXq2ZvJ6ES+tCrdeydl0=;
        b=GJVHWb7On5d8QH0JS1KBa6k/6lt7ksj0E0OwizyveGSnLr0z04TYjCyRU78n2/++jE
         R3CDZVBstiPt94TnRwdVhJhpDS2+6P+JJI1MTjsw1XyoZ5UUMw3QZFJKnR3NjFyLNInW
         TZGSW2o80wbRh0LqvfHdMTQRNl0JC55h+fHUPOr7LasgZlEdu5H1up4SX7/ty4M636jy
         C0ubX2i5+XcMhNoL5lYkF2Ek4gDcf3ST1E7rO7R6Qdi/r0q/KEXNGks3kwwcVo0R0m1g
         3f+PsI+XTG1YVUusS3hi/qo4L7Azz3HwENh2rBURg0P5iMOaTHQD7Qp0EIfRQls4xwDM
         2iLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XRJqhDHx7Uz3bLvE/9qsXUPLXq2ZvJ6ES+tCrdeydl0=;
        b=fod/IGrdEdnoMHVtwPIlIg7Qv+zMb57Yggxk2uNLoke1QXDrxWN3svnJJwh6IdugpV
         sk1YMit/mLftVE3EqEYmqOCZEadNsp1cd25dev2EsCJBKIC2Cxfb8jP4okgPg2hcctXP
         necmaxoO7YYI0ZTn8WSvni/i1w5qx7obfLpzqqz/VXZfN7yCS0LTW8EX3+Wa4fF9sZMX
         nf3+Mma9GlnD+JpgkQPv6yzVNwqGBIXGXcxngm1d05suMwLq9kpUnDZGxX3Rb3xWJwrQ
         41sfmknddv4hOENlkqD8uY+17OLq3j8zTeH7lpEj0DNDtQSMMeF8Zua0/0AFt5p68ET1
         eQcg==
X-Gm-Message-State: APjAAAWihVDGQK/s3pWBSMFO3aOV4abvE54k9skRbtiScxtd0FNYhWP9
        EqkiaIY4k3BolH9FDZGFGts=
X-Google-Smtp-Source: APXvYqx9XAXP+lQcuBCtq0McEBVhakGbx6bv1s1MBRFOqKTBD7Y6h12RDBl4c4tj6bQaCkfELh3Qrg==
X-Received: by 2002:aa7:c313:: with SMTP id l19mr60539847edq.258.1563983732973;
        Wed, 24 Jul 2019 08:55:32 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c48sm13305270edb.10.2019.07.24.08.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 08:55:31 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 8F26810169F; Wed, 24 Jul 2019 18:55:30 +0300 (+03)
Date:   Wed, 24 Jul 2019 18:55:30 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Lianbo Jiang <lijiang@redhat.com>
Subject: Re: [PATCH] dma-direct: Force unencrypted DMA under SME for certain
 DMA masks
Message-ID: <20190724155530.hlingpcirjcf2ljg@box>
References: <10b83d9ff31bca88e94da2ff34e30619eb396078.1562785123.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10b83d9ff31bca88e94da2ff34e30619eb396078.1562785123.git.thomas.lendacky@amd.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 07:01:19PM +0000, Lendacky, Thomas wrote:
> @@ -351,6 +355,32 @@ bool sev_active(void)
>  }
>  EXPORT_SYMBOL(sev_active);
>  
> +/* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
> +bool force_dma_unencrypted(struct device *dev)
> +{
> +	/*
> +	 * For SEV, all DMA must be to unencrypted addresses.
> +	 */
> +	if (sev_active())
> +		return true;
> +
> +	/*
> +	 * For SME, all DMA must be to unencrypted addresses if the
> +	 * device does not support DMA to addresses that include the
> +	 * encryption mask.
> +	 */
> +	if (sme_active()) {
> +		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
> +		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
> +						dev->bus_dma_mask);
> +
> +		if (dma_dev_mask <= dma_enc_mask)
> +			return true;

Hm. What is wrong with the dev mask being equal to enc mask? IIUC, it
means that device mask is wide enough to cover encryption bit, doesn't it?

> +	}
> +
> +	return false;
> +}

-- 
 Kirill A. Shutemov
