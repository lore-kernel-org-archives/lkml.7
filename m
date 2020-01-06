Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982DEC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 17:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64914207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 17:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578331142;
	bh=N4PyN/ioMxd3f4CHCcX1fBkgPLk3L3vfRcqZXGCf8RY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=rEMGnoV6trRxKDz41YbFtjN+cTOULwrYSST5Oe/rJmUV8dH2/vtyvuI0mlg2uWyVK
	 QKZLPg+VZVY3GQW8KteVNDxQvNPq4rDDANXw5c8oTSl44JUyhjHqfbBB2QnTpAGRaE
	 VMGvmdYhCpeJltChTVRWHSFmbvNPqbKuNnmQqqj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgAFRTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 12:19:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:44878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgAFRTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 12:19:01 -0500
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 728B420715;
        Mon,  6 Jan 2020 17:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578331140;
        bh=N4PyN/ioMxd3f4CHCcX1fBkgPLk3L3vfRcqZXGCf8RY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=cXduWxmAnxmAWU+Be8dJklvJXJp2oMHir6bdtrEv4Fwteh29LQqkUPXJrQdp7MmFI
         LyNyn5AajDUcvvQ71zsBXr7megMtaKNtQLY7lxFbOY2kX68djp+bMVoHInuvY5ZRJV
         EXL6FiABUErJtEpNG7I2bz6x8X+1KhyrhtM5fy+g=
Date:   Mon, 6 Jan 2020 09:18:54 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
cc:     jmorris@namei.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        sstabellini@kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, stefan@agner.ch, yamada.masahiro@socionext.com,
        xen-devel@lists.xenproject.org, linux@armlinux.org.uk,
        andrew.cooper3@citrix.com, julien@xen.org
Subject: Re: [PATCH v5 1/6] arm/arm64/xen: hypercall.h add includes guards
In-Reply-To: <20200102211357.8042-2-pasha.tatashin@soleen.com>
Message-ID: <alpine.DEB.2.21.2001060918470.732@sstabellini-ThinkPad-T480s>
References: <20200102211357.8042-1-pasha.tatashin@soleen.com> <20200102211357.8042-2-pasha.tatashin@soleen.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2020, Pavel Tatashin wrote:
> The arm and arm64 versions of hypercall.h are missing the include
> guards. This is needed because C inlines for privcmd_call are going to
> be added to the files.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Julien Grall <julien@xen.org>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>

> ---
>  arch/arm/include/asm/xen/hypercall.h   | 4 ++++
>  arch/arm64/include/asm/xen/hypercall.h | 4 ++++
>  include/xen/arm/hypercall.h            | 6 +++---
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/xen/hypercall.h b/arch/arm/include/asm/xen/hypercall.h
> index 3522cbaed316..c6882bba5284 100644
> --- a/arch/arm/include/asm/xen/hypercall.h
> +++ b/arch/arm/include/asm/xen/hypercall.h
> @@ -1 +1,5 @@
> +#ifndef _ASM_ARM_XEN_HYPERCALL_H
> +#define _ASM_ARM_XEN_HYPERCALL_H
>  #include <xen/arm/hypercall.h>
> +
> +#endif /* _ASM_ARM_XEN_HYPERCALL_H */
> diff --git a/arch/arm64/include/asm/xen/hypercall.h b/arch/arm64/include/asm/xen/hypercall.h
> index 3522cbaed316..c3198f9ccd2e 100644
> --- a/arch/arm64/include/asm/xen/hypercall.h
> +++ b/arch/arm64/include/asm/xen/hypercall.h
> @@ -1 +1,5 @@
> +#ifndef _ASM_ARM64_XEN_HYPERCALL_H
> +#define _ASM_ARM64_XEN_HYPERCALL_H
>  #include <xen/arm/hypercall.h>
> +
> +#endif /* _ASM_ARM64_XEN_HYPERCALL_H */
> diff --git a/include/xen/arm/hypercall.h b/include/xen/arm/hypercall.h
> index b40485e54d80..babcc08af965 100644
> --- a/include/xen/arm/hypercall.h
> +++ b/include/xen/arm/hypercall.h
> @@ -30,8 +30,8 @@
>   * IN THE SOFTWARE.
>   */
>  
> -#ifndef _ASM_ARM_XEN_HYPERCALL_H
> -#define _ASM_ARM_XEN_HYPERCALL_H
> +#ifndef _ARM_XEN_HYPERCALL_H
> +#define _ARM_XEN_HYPERCALL_H
>  
>  #include <linux/bug.h>
>  
> @@ -88,4 +88,4 @@ MULTI_mmu_update(struct multicall_entry *mcl, struct mmu_update *req,
>  	BUG();
>  }
>  
> -#endif /* _ASM_ARM_XEN_HYPERCALL_H */
> +#endif /* _ARM_XEN_HYPERCALL_H */
> -- 
> 2.17.1
> 
