Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA505C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5F62173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="MfU7zanx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389451AbfGRINq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 04:13:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44159 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387777AbfGRINo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 04:13:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so12228993pfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 01:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WEPQWB9mL7qVaCOqVBJLCz5vsDHBMIw1+BdS4ATmzgQ=;
        b=MfU7zanxbv9W4UR9Jm9cRC1ssg0R8tJalTrmiDVVaixvRRDkLeAVGFMA/uNkbpOa+D
         jvpp9Z5eb417ob7VF4kFtVHZC48Lck2SAulQIXeJgt1v8Dl7LeD5SOsZ2Mbw/OPTZDQR
         9CrmsuhLaWXhojYzNwye0Px6EFygP/7sSZUBBK/dh8/PlRTfwvsVYh3w0WVGd4sm32W8
         OfFCrOH5636iRoq5zvvnmEI0Gwp093U9jrZm8W6O9jCtw75PA8Hmnzyi+lPlhfYn3h1s
         z/y3Qu9eORQGiqfnYehet7qlxgR+YqMzKt9G4yVGU7yp5SdTh1GSD+3b8ywVvgFXWIJ4
         +d9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WEPQWB9mL7qVaCOqVBJLCz5vsDHBMIw1+BdS4ATmzgQ=;
        b=XzLKjEqauHrMdakV2m0SZnX8ChO0avvcq5ArS+n3WBiilBAdX7LNcMzqPXUqo7/XQN
         0eb2oHvSHE9w51U+2cj/d7KvF3I2du5bhJ+EbvIBh1BG1oERC/l3+Cpk0Mwub9EJwpXO
         TN7l0N4AXPgbzxlsuJh1QddvvDWiSt6VnPJj0X7qj11Z26CRw9gKTu0w1DCD1lW6Embw
         KTbc+APq90DlHpMLwCxntq5HX4jFdfTPR7wNPBjZyZfbRF6N3ns4at/TEkemYgBVvJfU
         1bwjID0hdwxQO8+wa4fbodxz7Hn7+N4Vg5+Dkha2tnNl5F2Rz/FF0YUdIgGi1vXvU361
         H2AQ==
X-Gm-Message-State: APjAAAWfaDPHbOoDM2qZcTyZ2/8g1TyDSOWMFh/m0lNPc3Gwx8liQPsO
        b+Oh/xxgQ7JCH8nqpaPtK2Q=
X-Google-Smtp-Source: APXvYqwYbAyTAJi5PUBKz5SoezdiiL/6tSMEnS1yZRWW4nvvCzwLv5HlG+A48+VgqzdCLGCq9W2gxg==
X-Received: by 2002:a63:490a:: with SMTP id w10mr45466506pga.6.1563437623905;
        Thu, 18 Jul 2019 01:13:43 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id f72sm37999820pjg.10.2019.07.18.01.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 01:13:43 -0700 (PDT)
Subject: Re: [PATCH v2 04/13] powerpc/pseries/svm: Add helpers for
 UV_SHARE_PAGE and UV_UNSHARE_PAGE
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>
References: <20190713060023.8479-1-bauerman@linux.ibm.com>
 <20190713060023.8479-5-bauerman@linux.ibm.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <4fcc84ae-b93a-b5f1-fba4-b0e2af7b727c@ozlabs.ru>
Date:   Thu, 18 Jul 2019 18:13:37 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190713060023.8479-5-bauerman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/07/2019 16:00, Thiago Jung Bauermann wrote:
> From: Ram Pai <linuxram@us.ibm.com>
> 
> These functions are used when the guest wants to grant the hypervisor
> access to certain pages.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/ultravisor-api.h |  2 ++
>   arch/powerpc/include/asm/ultravisor.h     | 15 +++++++++++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/ultravisor-api.h b/arch/powerpc/include/asm/ultravisor-api.h
> index fe9a0d8d7673..c7513bbadf57 100644
> --- a/arch/powerpc/include/asm/ultravisor-api.h
> +++ b/arch/powerpc/include/asm/ultravisor-api.h
> @@ -25,6 +25,8 @@
>   #define UV_UNREGISTER_MEM_SLOT		0xF124
>   #define UV_PAGE_IN			0xF128
>   #define UV_PAGE_OUT			0xF12C
> +#define UV_SHARE_PAGE			0xF130
> +#define UV_UNSHARE_PAGE			0xF134
>   #define UV_PAGE_INVAL			0xF138
>   #define UV_SVM_TERMINATE		0xF13C
>   
> diff --git a/arch/powerpc/include/asm/ultravisor.h b/arch/powerpc/include/asm/ultravisor.h
> index f5dc5af739b8..f7418b663a0e 100644
> --- a/arch/powerpc/include/asm/ultravisor.h
> +++ b/arch/powerpc/include/asm/ultravisor.h
> @@ -91,6 +91,21 @@ static inline int uv_svm_terminate(u64 lpid)
>   
>   	return ucall(UV_SVM_TERMINATE, retbuf, lpid);
>   }
> +
> +static inline int uv_share_page(u64 pfn, u64 npages)
> +{
> +	unsigned long retbuf[UCALL_BUFSIZE];
> +
> +	return ucall(UV_SHARE_PAGE, retbuf, pfn, npages);


What is in that retbuf? Can you pass NULL instead?


> +}
> +
> +static inline int uv_unshare_page(u64 pfn, u64 npages)
> +{
> +	unsigned long retbuf[UCALL_BUFSIZE];
> +
> +	return ucall(UV_UNSHARE_PAGE, retbuf, pfn, npages);
> +}
> +
>   #endif /* !__ASSEMBLY__ */
>   
>   #endif	/* _ASM_POWERPC_ULTRAVISOR_H */
> 

-- 
Alexey
