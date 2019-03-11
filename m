Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D51DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B122148D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qnR6Fu8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfCKWjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:39:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57222 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfCKWjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B0Gw94XzvLUuTJQdHtbRj/TquIK2BadGDBT7hCDmJeU=; b=qnR6Fu8zBLqzI7BCOAWJ2JptQ
        wD1BgzIryHtJnB6abYwVy/DGQznaPl/DNIn7/ea5/FSwyc3SwegKCszeEhwr+17LoS1xghIVhDYSf
        NHfeEkWYfGVM6C/p7nBP8ErJcWVIeqpGYzFy3Md8YtQJsKc0XhGSIMrbFOdQ1pYeE4l370nCXSI2K
        O73ReBCPOUpOYW+2txs4RIzPm+x2LWMkV6zbQ1PfRGsW4p03lYSXBFPWozlE277vyFWNry1jeJfIM
        cv5QUJ14pRaxC2j2KuyCUh57zX7tRRA29fCCIAYgtuKJSZHOTamudwD5oO2XS64q/KQHjLzc/wF7/
        H5Fz3IsLA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h3TZr-0000OM-9C; Mon, 11 Mar 2019 22:39:23 +0000
Subject: Re: [PATCH] VMCI: Use BIT() macro for bit definitions
To:     Vishnu DASA <vdasa@vmware.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Cc:     Pv-drivers <Pv-drivers@vmware.com>
References: <20190311220928.4560-1-vdasa@vmware.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8e80e76d-1793-fc45-9f89-cf8e61dc4a16@infradead.org>
Date:   Mon, 11 Mar 2019 15:38:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190311220928.4560-1-vdasa@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/19 3:09 PM, Vishnu DASA wrote:
> No functional changes, cleanup only.
> 
> Reviewed-by: Adit Ranadive <aditr@vmware.com>
> Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
> Signed-off-by: Vishnu Dasa <vdasa@vmware.com>
> ---
>  include/linux/vmw_vmci_defs.h | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 

Now this header file needs to #include <linux/bitops.h>
or <linux/bits.h> for the BIT() macro.

Do the users of this header file build cleanly anyway?
Even if so, we prefer not to depend on implicit or accidental header
file inclusions that may change in the future.

> diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
> index eaa1e762bf06..007e28053da8 100644
> --- a/include/linux/vmw_vmci_defs.h
> +++ b/include/linux/vmw_vmci_defs.h
> @@ -33,27 +33,27 @@
>  #define VMCI_MAX_DEVICES 1
>  
>  /* Status register bits. */
> -#define VMCI_STATUS_INT_ON     0x1
> +#define VMCI_STATUS_INT_ON     BIT(0)
>  
>  /* Control register bits. */
> -#define VMCI_CONTROL_RESET        0x1
> -#define VMCI_CONTROL_INT_ENABLE   0x2
> -#define VMCI_CONTROL_INT_DISABLE  0x4
> +#define VMCI_CONTROL_RESET        BIT(0)
> +#define VMCI_CONTROL_INT_ENABLE   BIT(1)
> +#define VMCI_CONTROL_INT_DISABLE  BIT(2)
>  
>  /* Capabilities register bits. */
> -#define VMCI_CAPS_HYPERCALL     0x1
> -#define VMCI_CAPS_GUESTCALL     0x2
> -#define VMCI_CAPS_DATAGRAM      0x4
> -#define VMCI_CAPS_NOTIFICATIONS 0x8
> -#define VMCI_CAPS_PPN64         0x10
> +#define VMCI_CAPS_HYPERCALL     BIT(0)
> +#define VMCI_CAPS_GUESTCALL     BIT(1)
> +#define VMCI_CAPS_DATAGRAM      BIT(2)
> +#define VMCI_CAPS_NOTIFICATIONS BIT(3)
> +#define VMCI_CAPS_PPN64         BIT(4)
>  
>  /* Interrupt Cause register bits. */
> -#define VMCI_ICR_DATAGRAM      0x1
> -#define VMCI_ICR_NOTIFICATION  0x2
> +#define VMCI_ICR_DATAGRAM      BIT(0)
> +#define VMCI_ICR_NOTIFICATION  BIT(1)
>  
>  /* Interrupt Mask register bits. */
> -#define VMCI_IMR_DATAGRAM      0x1
> -#define VMCI_IMR_NOTIFICATION  0x2
> +#define VMCI_IMR_DATAGRAM      BIT(0)
> +#define VMCI_IMR_NOTIFICATION  BIT(1)
>  
>  /* Maximum MSI/MSI-X interrupt vectors in the device. */
>  #define VMCI_MAX_INTRS 2
> @@ -463,9 +463,9 @@ struct vmci_datagram {
>   * datagram callback is invoked in a delayed context (not interrupt context).
>   */
>  #define VMCI_FLAG_DG_NONE          0
> -#define VMCI_FLAG_WELLKNOWN_DG_HND 0x1
> -#define VMCI_FLAG_ANYCID_DG_HND    0x2
> -#define VMCI_FLAG_DG_DELAYED_CB    0x4
> +#define VMCI_FLAG_WELLKNOWN_DG_HND BIT(0)
> +#define VMCI_FLAG_ANYCID_DG_HND    BIT(1)
> +#define VMCI_FLAG_DG_DELAYED_CB    BIT(2)
>  
>  /*
>   * Maximum supported size of a VMCI datagram for routable datagrams.
> @@ -694,7 +694,7 @@ struct vmci_qp_detach_msg {
>  };
>  
>  /* VMCI Doorbell API. */
> -#define VMCI_FLAG_DELAYED_CB 0x01
> +#define VMCI_FLAG_DELAYED_CB BIT(0)
>  
>  typedef void (*vmci_callback) (void *client_data);
>  
> 


-- 
~Randy
