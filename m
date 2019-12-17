Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FA5C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A993624682
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Mpu/CQwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfLQK2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:28:49 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:54316 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfLQK2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xIsVCSCddGcBczzhrJmpWdldvcvD8/SOoTohcqfDdpc=; b=Mpu/CQwP505C8biFNOIztuq5H
        RtEPYQbkrn288Xfq4TohizM2O4bz7zIrNfn3c8ST3u+aEsIkzbBO1wXLiCanTbMxTeihL7x4uRdzQ
        2d9Kz0AvwC1Qrihh/ZBP1c1FMweIV/RGnSDW/GSgfW/ooLn2T+plH8ltRcjO/62630LsxyJXhBpjG
        PXipzJ9uizk93dUJzqUmdhyNdlGkfyiwivC6qf8/i7mv03DCiVr2CrHvNctKEXbeRpv07ZOruJhdJ
        193cpkjwBS8sxOvmph3UfpU7J++zH9R9NH4IkEiTTm7L+vzn6x/MDq4SV6pDDqm2SGuotgBhSiHW7
        gnMQEQL9w==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:50030)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ihA5j-0005M5-7h; Tue, 17 Dec 2019 10:28:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ihA5f-0003KB-Ca; Tue, 17 Dec 2019 10:28:31 +0000
Date:   Tue, 17 Dec 2019 10:28:31 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     akpm@linux-foundation.org, Vincent Whitchurch <rabinv@axis.com>,
        treding@nvidia.com, linux-arm-kernel@lists.infradead.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm/sections: Check for overflow in memory_contains()
Message-ID: <20191217102831.GP25745@shell.armlinux.org.uk>
References: <20191217102238.14792-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217102238.14792-1-vincent.whitchurch@axis.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:22:38AM +0100, Vincent Whitchurch wrote:
> ARM uses memory_contains() from its stacktrace code via this function:
> 
>  static inline bool in_entry_text(unsigned long addr)
>  {
>  	return memory_contains(__entry_text_start, __entry_text_end,
>  			       (void *)addr, 1);
>  }
> 
> addr is taken from the stack and can be a completely invalid.  If addr
> is 0xffffffff, there is an overflow in the pointer arithmetic in
> memory_contains() and in_entry_text() incorrectly returns true.
> 
> Fix this by adding an overflow check.  The check is done on unsigned
> longs to avoid undefined behaviour.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  include/asm-generic/sections.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
> index d1779d442aa5..e6e1b381c5df 100644
> --- a/include/asm-generic/sections.h
> +++ b/include/asm-generic/sections.h
> @@ -105,7 +105,15 @@ static inline int arch_is_kernel_initmem_freed(unsigned long addr)
>  static inline bool memory_contains(void *begin, void *end, void *virt,
>  				   size_t size)
>  {
> -	return virt >= begin && virt + size <= end;
> +	unsigned long membegin = (unsigned long)begin;
> +	unsigned long memend = (unsigned long)end;
> +	unsigned long objbegin = (unsigned long)virt;
> +	unsigned long objend = objbegin + size;
> +
> +	if (objend < objbegin)
> +		return false;
> +
> +	return objbegin >= membegin && objend <= memend;

Would merely changing to:

	return virt >= begin && virt <= end - size;

be sufficient ?  Is end - size possible to underflow?

>  }
>  
>  /**
> -- 
> 2.20.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
