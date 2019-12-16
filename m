Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BF0C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B422A24650
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLPUg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 15:36:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46718 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfLPUg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 15:36:27 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so8856621wrl.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 12:36:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JF5j2QhBPiKVEsszO1fwNIEf5ztIBBW8hIVMIyB6TX8=;
        b=bT5EI8xjAl1zI9LOqE1cUECcoz/mB2+w9BRUZfvhOU4DFz/05VW3Xs/1L6p9KKonfh
         yXvOrsrzmycDu7dQMYSZZaTSqEv+yMEtzX/x3hI01pUCt7GMuYaBlkQrqG9cYrDtKGxQ
         Rf7mXpWANR19BzUwF9YKIqEAKB9r446EJMFBbcSpfVgiO8K8WyeXF7cSGAawVFZRR9US
         w5vEuglSBXdqsRO9ZKq9YStwahtyOpsfdGfU8LLPTMr+j9M9CzcnjTqE+sg2Bb1uM6bW
         g7rTIt917fqxymLmfk/lnVBjxX+SC1R2bS5K5rLdZFjV9jc3nZM6TDlP2vZFFO9/rnqM
         C9GA==
X-Gm-Message-State: APjAAAVrlayhPz1C4jR0bUX6W4/5C1ErkZVwjYKzX2K+ZwOX3OzwjV0c
        g94FzO3u74s9zCzNPgSLJbI=
X-Google-Smtp-Source: APXvYqz9kOCrk7TdGWR+j99RWSQ6+KDeJJaAl/3DJBRD938fSrWXpjD853kqh1J0TmYUVY6y872K+A==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr33173920wru.119.1576528585567;
        Mon, 16 Dec 2019 12:36:25 -0800 (PST)
Received: from a483e7b01a66.ant.amazon.com (cpc91200-cmbg18-2-0-cust94.5-4.cable.virginm.net. [81.100.41.95])
        by smtp.gmail.com with ESMTPSA id v8sm22540503wrw.2.2019.12.16.12.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 12:36:24 -0800 (PST)
Subject: Re: [PATCH v4 1/6] arm/arm64/xen: hypercall.h add includes guards
To:     Pavel Tatashin <pasha.tatashin@soleen.com>, jmorris@namei.org,
        sashal@kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        sstabellini@kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, stefan@agner.ch, yamada.masahiro@socionext.com,
        xen-devel@lists.xenproject.org, linux@armlinux.org.uk,
        andrew.cooper3@citrix.com
References: <20191204232058.2500117-1-pasha.tatashin@soleen.com>
 <20191204232058.2500117-2-pasha.tatashin@soleen.com>
From:   Julien Grall <julien@xen.org>
Message-ID: <c5dcf342-90f4-beb5-d2b1-4a37ccedfe42@xen.org>
Date:   Mon, 16 Dec 2019 20:36:23 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191204232058.2500117-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/12/2019 23:20, Pavel Tatashin wrote:
> The arm and arm64 versions of hypercall.h are missing the include
> guards. This is needed because C inlines for privcmd_call are going to
> be added to the files.
> 
> Also fix a comment.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>   arch/arm/include/asm/assembler.h       | 2 +-
>   arch/arm/include/asm/xen/hypercall.h   | 4 ++++
>   arch/arm64/include/asm/xen/hypercall.h | 4 ++++
>   include/xen/arm/hypercall.h            | 6 +++---
>   4 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 99929122dad7..8e9262a0f016 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -480,7 +480,7 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
>   	.macro	uaccess_disable, tmp, isb=1
>   #ifdef CONFIG_CPU_SW_DOMAIN_PAN
>   	/*
> -	 * Whenever we re-enter userspace, the domains should always be
> +	 * Whenever we re-enter kernel, the domains should always be

This feels unrelated from the rest of the patch and probably want an 
explanation. So I think this want to be in a separate patch.

The rest of the patch looks good to me.

Cheers,

-- 
Julien Grall
