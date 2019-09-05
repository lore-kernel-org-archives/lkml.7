Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D05AC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5980522CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Rf1Dy9DJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387501AbfIEM0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:26:11 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37726 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731294AbfIEM0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:26:11 -0400
Received: by mail-qk1-f193.google.com with SMTP id s14so1887197qkm.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 05:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bo/kDWZp3bZZn3zakUhkg0ajor/kZS2pwWQ9iXAnPOc=;
        b=Rf1Dy9DJhqJAwIS4qIRCwfL+woHUrzX2/AEYlsJMpQHsESybDA8+/WuEII9w3/yWFM
         27tnkefv9zimlG9bX/5TCZp4wtsJtvSJdV+g1nShVSEHze/4n0XCrtxc/riMwcAbkoio
         vpMZcjlpm60NZ13BUk3DmefkQQ1E24qr80aMrocI6brskeHTBsHCv5B9hytfGOTmsLTy
         hld14RW3fYlT2OYsXtRVUCbUXrsRpFZdHVQ+LMCcfOlHFxLLPu7OsgW0RbdUCwuF4C7h
         pS1/u4TSWZ0H9jFTGSkSRaVsNQOqPIavsHAr+Udo6UM22UB+pt/c5K+7ADt4pa3K0xOu
         rZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bo/kDWZp3bZZn3zakUhkg0ajor/kZS2pwWQ9iXAnPOc=;
        b=XXuA++kTbsekjYfWMYN5XOhyZPyVULqHBunubTk0fD8LVdnFiEs7mXUIZp3UUZc8Tq
         305hHqq4pAXl1LfJqOXS7zVr02UVmjW05fnyUAruwtqJYH5ykycbLvMh9VCX78xMiif9
         pX2hEPkOmxCVC3O6EhjOnbEWUJ+wosSnVNkQMScglX+fl4WwV63IoPPoFTj/rCIUc9fO
         GgdFsFwOcdP2EUCMRRtZv2ApmpHAe7HWYn5oFdqY6ridTr3o8n8a8m/NSnOLsTY+I4DT
         LIpcxvL4ewLHfihO51XRHtAcXplpehFqPFTxEyaM4RUQghJvRjfoYG57lt6JuWDl/Yp6
         JBrA==
X-Gm-Message-State: APjAAAUPUnzYbxXOcOkOYOGuXI5Ud8S2dvjd28UPltp9Ag7m7WPaCVxA
        M7o/LoH3WYyRx4cp9JsJ+FtosA==
X-Google-Smtp-Source: APXvYqzrQ9dpro1Q2JB+WgiKIba61kIkoKO9xg2/x0erj1XWRalJyAP9GSJkxkeepAlE1qgNXbCb7Q==
X-Received: by 2002:a37:9f93:: with SMTP id i141mr2284503qke.304.1567686369652;
        Thu, 05 Sep 2019 05:26:09 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z123sm1019144qke.96.2019.09.05.05.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 05:26:08 -0700 (PDT)
Message-ID: <1567686367.5576.89.camel@lca.pw>
Subject: Re: [PATCH] x86/kaslr: simplify the code in mem_avoid_memmap()
From:   Qian Cai <cai@lca.pw>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        Borislav Petkov <bp@alien8.de>
Cc:     bhe@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 05 Sep 2019 08:26:07 -0400
In-Reply-To: <1566483962-10046-1-git-send-email-cai@lca.pw>
References: <1566483962-10046-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping. Please take a look at this trivial patch.

On Thu, 2019-08-22 at 10:26 -0400, Qian Cai wrote:
> If "i >= MAX_MEMMAP_REGIONS" already when entering mem_avoid_memmap(),
> even without the return statement the loop will not run anyway. The only
> time it needs to set "memmap_too_large = true" in this situation is
> "memmap_too_large" is "false" currently. Hence, the code could be
> simplified.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/x86/boot/compressed/kaslr.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/kaslr.c
> b/arch/x86/boot/compressed/kaslr.c
> index 2e53c056ba20..35c6942fb95b 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -176,9 +176,6 @@ static void mem_avoid_memmap(char *str)
>  {
>  	static int i;
>  
> -	if (i >= MAX_MEMMAP_REGIONS)
> -		return;
> -
>  	while (str && (i < MAX_MEMMAP_REGIONS)) {
>  		int rc;
>  		unsigned long long start, size;
> @@ -206,7 +203,7 @@ static void mem_avoid_memmap(char *str)
>  	}
>  
>  	/* More than 4 memmaps, fail kaslr */
> -	if ((i >= MAX_MEMMAP_REGIONS) && str)
> +	if (i >= MAX_MEMMAP_REGIONS && !memmap_too_large)
>  		memmap_too_large = true;
>  }
>  
