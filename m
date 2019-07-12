Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558F2C742CA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27527208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="QmSMDI80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfGLPaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 11:30:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45575 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfGLPa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 11:30:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id x22so3575609qtp.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 08:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wu702WptAOAhsxDRfP3OXS4FEoD+D5sZm3CKh3FTjwY=;
        b=QmSMDI806K6oU8ImCzb9JsLwsO8VSznuzhbhIDV1OvlMdLb3JkZBbJ/92Ivdqv3Sew
         Z7Qe0Qq26NaeD2qR8Fom58E7VVaxDBDNK6Ue8HqwD5jRuFPeODklvM9ELlDLdLZIZCXG
         OE9SJg4v5yylzl+TWHxfSy3bhDW9prX77jVrXENwP3cPaOOkhGNGJVt2DRwhHngMMrDk
         jMr9uk4HYyhrLQzuZWlghtw4gINRA4kGP/nhSFxCJ92nq0mYCMnBHi6bpdi8T9aJqWrO
         5PBWovYV0fHThDmg/54NNq+oeEivOXzli/38ZrhBS+qOUucmtpVA4PzYIaRHvXQ9IMg7
         c8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wu702WptAOAhsxDRfP3OXS4FEoD+D5sZm3CKh3FTjwY=;
        b=jTfbOMajpAuPGKEoiFxv+QrDPQLWYLJlogZWT54VVxu87A1lVwN6nYoE0tsPn2Bzd3
         vFJk6JYStzZi46VEp+xEuYm15kK7nwwnGHZEQ0M8kcTO9quvnNXwQJ7lzrrwZZ/ErXcg
         buNN8kSdUeax8+XZqXzxEtGHul0Z7hVL0eJ9sFMAh/2S3VN0DwHbksC/qyh40q6pgh8g
         y5o9jwNvAhzqaSt9LxS6YO66wW0hIi96jUoC3uWqjFxW93xFvBkFcO8Mhlu8wq3JDypK
         Ew5QqppP1GFEoxI1gH5ljz7xPCv3sYwCytUKEW+BO3Xitzw41IQwPmAT+Y5jXl2kOcUI
         Q4YA==
X-Gm-Message-State: APjAAAUqRNL5Ud3+eESiNTruHkri9tPqO+O1+qtaJTFFYMi8yiIFykM+
        GkYamLtAWsdcD4oVibOzqsGP7A==
X-Google-Smtp-Source: APXvYqxlBvzD3wvRDrKYL7X7wGaNLInLmH+c+gXqWIYDX/FawG5w8l/m+Xmsh8f0lfeZ4uCTw2dEaQ==
X-Received: by 2002:ac8:32c8:: with SMTP id a8mr6715382qtb.47.1562945428748;
        Fri, 12 Jul 2019 08:30:28 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w62sm3649817qkd.30.2019.07.12.08.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 08:30:28 -0700 (PDT)
Message-ID: <1562945427.8510.28.camel@lca.pw>
Subject: Re: [PATCH v3] powerpc/setup_64: fix -Wempty-body warnings
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au
Cc:     paulus@samba.org, benh@kernel.crashing.org,
        tyreld@linux.vnet.ibm.com, joe@perches.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Fri, 12 Jul 2019 11:30:27 -0400
In-Reply-To: <1561730629-5025-1-git-send-email-cai@lca.pw>
References: <1561730629-5025-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

On Fri, 2019-06-28 at 10:03 -0400, Qian Cai wrote:
> At the beginning of setup_64.c, it has,
> 
>   #ifdef DEBUG
>   #define DBG(fmt...) udbg_printf(fmt)
>   #else
>   #define DBG(fmt...)
>   #endif
> 
> where DBG() could be compiled away, and generate warnings,
> 
> arch/powerpc/kernel/setup_64.c: In function 'initialize_cache_info':
> arch/powerpc/kernel/setup_64.c:579:49: warning: suggest braces around
> empty body in an 'if' statement [-Wempty-body]
>     DBG("Argh, can't find dcache properties !\n");
>                                                  ^
> arch/powerpc/kernel/setup_64.c:582:49: warning: suggest braces around
> empty body in an 'if' statement [-Wempty-body]
>     DBG("Argh, can't find icache properties !\n");
> 
> Fix it by using the no_printk() macro, and make sure that format and
> argument are always verified by the compiler.
> 
> Suggested-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v3: Use no_printk() macro, and make sure that format and argument are always
>     verified by the compiler using a more generic form ##__VA_ARGS__ per Joe.
> 
> v2: Fix it by using a NOP while loop per Tyrel.
> 
>  arch/powerpc/kernel/setup_64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 44b4c432a273..cea933a43f0a 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -69,9 +69,9 @@
>  #include "setup.h"
>  
>  #ifdef DEBUG
> -#define DBG(fmt...) udbg_printf(fmt)
> +#define DBG(fmt, ...) udbg_printf(fmt, ##__VA_ARGS__)
>  #else
> -#define DBG(fmt...)
> +#define DBG(fmt, ...) no_printk(fmt, ##__VA_ARGS__)
>  #endif
>  
>  int spinning_secondaries;
