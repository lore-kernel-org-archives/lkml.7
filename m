Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA48BC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4F82089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380014;
	bh=qO9j38kTvRaom9Dympgw2PZ3SD1mqzGyLVqm6MafZvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hp8XiDw9a82rxhkHU0i1ucf6dju38GdJCmarqlD7s0tTcFCweItszrEvuWViDUiVi
	 Ptv0wGa9zk79aRS5bIq8cZYWcYGbSXVlBzHEb7r+HrNDEM0BRV+/eH2Fn1y6mcLx64
	 yPfBUO5UxCIGJBDS+z7AlpGw20iwPUu3LvhLuvoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388286AbfIMNGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387443AbfIMNGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:06:53 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6A18206A5;
        Fri, 13 Sep 2019 13:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380012;
        bh=qO9j38kTvRaom9Dympgw2PZ3SD1mqzGyLVqm6MafZvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DmLuAT95jpNYwx9mcqkIJBKYgBFryoL4/2NE56owCBA/8l9guoozSKta/pl1FKLao
         Ee00LCjo3EWu2DiGr/XxqrCHMqZySU/dJzXcIbr1Vmdkc9PrtyyQroCAtUSzUrWWPY
         jCLDKEymWrMobIA5yZQB5s21gjO45xSONyJBjH28=
Date:   Fri, 13 Sep 2019 14:02:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        bp@alien8.de, carlo@caione.org, catalin.marinas@arm.com,
        devicetree@vger.kernel.org, hpa@zytor.com, jmattson@google.com,
        joro@8bytes.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, narmstrong@baylibre.com,
        rkrcmar@redhat.com, robh+dt@kernel.org,
        sean.j.christopherson@intel.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, wanpengli@tencent.com, will.deacon@arm.com,
        x86@kernel.org,
        syzbot <syzbot+46f1dd7dbbe2bfb98b10@syzkaller.appspotmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: KASAN: slab-out-of-bounds Read in handle_vmptrld
Message-ID: <20190913130226.GB403359@kroah.com>
References: <000000000000a9d4f705924cff7a@google.com>
 <87lfutei1j.fsf@vitty.brq.redhat.com>
 <5218e70e-8a80-7c5f-277b-01d9ab70692a@redhat.com>
 <20190913044614.GA120223@kroah.com>
 <db02a285-ad1d-6094-6359-ba80e6d3f2e0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db02a285-ad1d-6094-6359-ba80e6d3f2e0@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 09:34:32AM +0200, Paolo Bonzini wrote:
> On 13/09/19 06:46, Greg Kroah-Hartman wrote:
> > USB drivers expect kmalloc to return DMA-able memory.  I don't know
> > about specific alignment issues, that should only an issue for the host
> > controller being used here, which you do not say in the above list.
> 
> I have no idea, this is just the analysis of a syzkaller report.  From 
> the backtrace, it's one that ends up calling kmalloc; all of them should
> have the same issue with KASAN.
> 
> The specific alignment requirement for this bug comes from this call in
> usbdev_mmap:
> 
> 	if (remap_pfn_range(vma, vma->vm_start,
> 			virt_to_phys(usbm->mem) >> PAGE_SHIFT,
> 			size, vma->vm_page_prot) < 0) {
> 
> > We have had some reports that usbdev_mmap() does not do the "correct
> > thing" for all host controllers, but a lot of the DMA work that is in
> > linux-next for 5.4-rc1 should have helped resolve those issues.  What
> > tree are you seeing these bug reports happening from?
> 
> It's in master, but the relevant code is the same in linux-next; in fact
> in this case there is no DMA involved at all.  hcd_buffer_alloc hits
> the case "some USB hosts just use PIO".
> 
> On those host controllers, it should be reproducible with just this:
> 
> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index 7fcb9f782931..cc0460730bce 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -905,9 +905,12 @@ EXPORT_SYMBOL_GPL(__usb_get_extra_descriptor);
>  void *usb_alloc_coherent(struct usb_device *dev, size_t size, gfp_t mem_flags,
>  			 dma_addr_t *dma)
>  {
> +	void *buf;
>  	if (!dev || !dev->bus)
>  		return NULL;
> -	return hcd_buffer_alloc(dev->bus, size, mem_flags, dma);
> +	buf = hcd_buffer_alloc(dev->bus, size, mem_flags, dma);
> +	WARN_ON_ONCE(virt_to_phys(buf) & ~PAGE_MASK);
> +	return buf;
>  }
>  EXPORT_SYMBOL_GPL(usb_alloc_coherent);

Look at linux-next, we "should" have fixed up hcd_buffer_alloc() now to
not need this type of thing.  If we got it wrong, please let us know and
then yes, a fix like this would be most appreciated :)

thanks,

greg k-h

>  
> 
> and CONFIG_KASAN=y or possibly just CONFIG_DEBUG_SLAB=y.  mmap-ing /dev/usb
> should warn if my analysis is correct.
> 
> If you think the above patch makes sense, I can test it and submit it formally.
> 
> Paolo
