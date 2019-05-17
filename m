Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA804C46470
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 14:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E49216F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 14:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfEQOEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 10:04:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39539 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbfEQOEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 10:04:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id w8so7284915wrl.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 07:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ay0mnXwH55BT3mIc1KqqMT1PJjmGnEozvmL7TssXHuo=;
        b=QKy/Eq7Uv4eAwIqrYluh47MtR2UmDb1ZB9Z8anhBh5vBt/rh6YDbOFvS1NpdQTP1a6
         +GjpQ+zZ8JB++cM+nz85PL1V7gA9GrkhSBaJ1tXPN+wbwNI8EGIUsqUzd4Ox9dzuhg8g
         3b70BW11WlM8mnf+QfzXWtdC9eds9dRes7wXLMoUn+XWOG/yrs29QK0qaVEvhYsp+p2S
         1ldZS9+U41mJqR9P3442WUjX50ErqrNmLz68eesmkUmQnthxgpMmqTYArO2vgEr+HBq8
         Gj1sEsc+P6LzV7IKaQx14v/XIt0flDf8sOwmXitjwk2BJ1xxhc7//8Uw6pBJ1LwXcfV7
         kqBw==
X-Gm-Message-State: APjAAAWG8BN5N75eMR8eK3XoaWw82HTJz+WawxdbETGkx0bZW4V9Ia/E
        o/eSFy8Xm5OJFNjR/kQYcSXgv58ux8r+1Q==
X-Google-Smtp-Source: APXvYqzOmt30lVKUv7iRVyaFJ+WmgvnzDm6OvelTWemiW1erIRYQzcy/pRp5fFjnkNTRIiOUVuVzqw==
X-Received: by 2002:adf:ce07:: with SMTP id p7mr20887296wrn.241.1558101847058;
        Fri, 17 May 2019 07:04:07 -0700 (PDT)
Received: from [172.27.174.155] (23-24-245-141-static.hfc.comcastbusiness.net. [23.24.245.141])
        by smtp.gmail.com with ESMTPSA id v5sm15816002wra.83.2019.05.17.07.04.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 07:04:06 -0700 (PDT)
Subject: Re: [PATCH -next] kvm: fix compilation errors with mem[re|un]map()
To:     Qian Cai <cai@lca.pw>, rkrcmar@redhat.com
Cc:     karahmed@amazon.de, konrad.wilk@oracle.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1558101713-15325-1-git-send-email-cai@lca.pw>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e22619d8-3441-634e-d2c0-fe8ddd7f03e5@redhat.com>
Date:   Fri, 17 May 2019 16:04:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558101713-15325-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ThOn 17/05/19 16:01, Qian Cai wrote:
> The linux-next commit e45adf665a53 ("KVM: Introduce a new guest mapping
> API") introduced compilation errors on arm64.
> 
> arch/arm64/kvm/../../../virt/kvm/kvm_main.c:1764:9: error: implicit
> declaration of function 'memremap'
> [-Werror,-Wimplicit-function-declaration]
>                 hva = memremap(pfn_to_hpa(pfn), PAGE_SIZE, MEMREMAP_WB);
>                       ^
> arch/arm64/kvm/../../../virt/kvm/kvm_main.c:1764:9: error: this function
> declaration is not a prototype [-Werror,-Wstrict-prototypes]
> arch/arm64/kvm/../../../virt/kvm/kvm_main.c:1764:46: error: use of
> undeclared identifier 'MEMREMAP_WB'
>                 hva = memremap(pfn_to_hpa(pfn), PAGE_SIZE, MEMREMAP_WB);
>                                                            ^
> arch/arm64/kvm/../../../virt/kvm/kvm_main.c:1796:3: error: implicit
> declaration of function 'memunmap'
> [-Werror,-Wimplicit-function-declaration]
>                 memunmap(map->hva);
> 
> Fixed it by including io.h in kvm_main.c.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  virt/kvm/kvm_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 8d83a787fd6b..5c5102799c2c 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -51,6 +51,7 @@
>  #include <linux/slab.h>
>  #include <linux/sort.h>
>  #include <linux/bsearch.h>
> +#include <linux/io.h>
>  
>  #include <asm/processor.h>
>  #include <asm/io.h>
> 

Thanks---this is already included in v2 of my pull request to Linus.

Paolo
