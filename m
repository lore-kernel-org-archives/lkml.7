Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16413C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 15:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E789D2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 15:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfK2PFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 10:05:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35624 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfK2PFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 10:05:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id n5so15446927wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 07:05:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pZkLmZsrqg1ZnWrCcircX/cCYDfgls/suzoB3wFMSt8=;
        b=aYoowPgB4TwVPykgXsC3r8j1Kl3PlR19Us64akXQkor5XEv+pcl1sEqP+n6ruK1umG
         c6Xk3gtOb2EtTeBs516NEwGX3zKrB/v9VnYJqOM71q+s4N7BiyRdN1gzC22aXiy4yI/F
         M/tT3BEeOyyQ8FtzLQjwYWn3tlaxh/w+vfp7p6NFPi3A1ieBjeXYBa1PLVTN4dTK6FL+
         2nEf2dkN4oWHnjhAgxck067bcRxLZHmiyA/z0w5NBdXMaac/S55BpwJYGQH0OIAgwwdu
         oZEJRKT6EuEyXgYA4jpR4k+CAPTcyz2CVj0YS9400As4L4KZzuDPMfq4mygcjx8gxwo2
         S0lw==
X-Gm-Message-State: APjAAAXS3Zhf2mqpyqiF8GRKkzuoYm+U/Y9SstY01LDB8BnmadlSaoE2
        YtGLTkYhBvy3+jFaQte0qKw=
X-Google-Smtp-Source: APXvYqwT6VfzJAERtpYV8+32n7D+mlAnpiG8/vdvqUfElCD9W0Nhlic8udiNMZcbdIiCFN37E1HUpA==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr14066014wmi.152.1575039913718;
        Fri, 29 Nov 2019 07:05:13 -0800 (PST)
Received: from a483e7b01a66.ant.amazon.com (54-240-197-236.amazon.com. [54.240.197.236])
        by smtp.gmail.com with ESMTPSA id a15sm29699212wrx.81.2019.11.29.07.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2019 07:05:13 -0800 (PST)
Subject: Re: [PATCH 1/3] arm/arm64/xen: use C inlines for privcmd_call
To:     Pavel Tatashin <pasha.tatashin@soleen.com>, jmorris@namei.org,
        sashal@kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        sstabellini@kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, stefan@agner.ch, yamada.masahiro@socionext.com,
        xen-devel@lists.xenproject.org, linux@armlinux.org.uk
References: <20191127184453.229321-1-pasha.tatashin@soleen.com>
 <20191127184453.229321-2-pasha.tatashin@soleen.com>
From:   Julien Grall <julien@xen.org>
Message-ID: <957930d0-8317-9086-c7a1-8de857f358c2@xen.org>
Date:   Fri, 29 Nov 2019 15:05:11 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191127184453.229321-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/11/2019 18:44, Pavel Tatashin wrote:
> diff --git a/arch/arm64/include/asm/xen/hypercall.h b/arch/arm64/include/asm/xen/hypercall.h
> index 3522cbaed316..1a74fb28607f 100644
> --- a/arch/arm64/include/asm/xen/hypercall.h
> +++ b/arch/arm64/include/asm/xen/hypercall.h
> @@ -1 +1,29 @@
> +#ifndef _ASM_ARM64_XEN_HYPERCALL_H
> +#define _ASM_ARM64_XEN_HYPERCALL_H
>   #include <xen/arm/hypercall.h>
> +#include <linux/uaccess.h>
> +
> +static inline long privcmd_call(unsigned int call, unsigned long a1,
> +				unsigned long a2, unsigned long a3,
> +				unsigned long a4, unsigned long a5)

I realize that privcmd_call is the only hypercall using Software PAN at 
the moment. However, dm_op needs the same as hypercall will be issued 
from userspace as well.

So I was wondering whether we should create a generic function (e.g. 
do_xen_hypercall() or do_xen_user_hypercall()) to cover the two hypercalls?

> diff --git a/include/xen/arm/hypercall.h b/include/xen/arm/hypercall.h
> index b40485e54d80..624c8ad7e42a 100644
> --- a/include/xen/arm/hypercall.h
> +++ b/include/xen/arm/hypercall.h
> @@ -30,8 +30,8 @@
>    * IN THE SOFTWARE.
>    */
>   
> -#ifndef _ASM_ARM_XEN_HYPERCALL_H
> -#define _ASM_ARM_XEN_HYPERCALL_H
> +#ifndef _ARM_XEN_HYPERCALL_H
> +#define _ARM_XEN_HYPERCALL_H

This change feels a bit out of context. Could you split it in a separate 
patch?

>   
>   #include <linux/bug.h>
>   
> @@ -41,9 +41,9 @@
>   
>   struct xen_dm_op_buf;
>   
> -long privcmd_call(unsigned call, unsigned long a1,
> -		unsigned long a2, unsigned long a3,
> -		unsigned long a4, unsigned long a5);
> +long arch_privcmd_call(unsigned int call, unsigned long a1,
> +		       unsigned long a2, unsigned long a3,
> +		       unsigned long a4, unsigned long a5);
>   int HYPERVISOR_xen_version(int cmd, void *arg);
>   int HYPERVISOR_console_io(int cmd, int count, char *str);
>   int HYPERVISOR_grant_table_op(unsigned int cmd, void *uop, unsigned int count);
> @@ -88,4 +88,4 @@ MULTI_mmu_update(struct multicall_entry *mcl, struct mmu_update *req,
>   	BUG();
>   }
>   
> -#endif /* _ASM_ARM_XEN_HYPERCALL_H */
> +#endif /* _ARM_XEN_HYPERCALL_H */
> 

Cheers,

-- 
Julien Grall
