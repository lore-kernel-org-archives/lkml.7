Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB64C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 05:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C8A217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 05:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="nd0pExQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfHZFgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 01:36:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42470 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfHZFgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 01:36:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id p3so9857525pgb.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 22:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=KdvhWx5STJQuh3h6H3k/gde8WO2PhkrNqGMLuEz+X7g=;
        b=nd0pExQXCUmwBnwOJDaiy3haAHBnMxeK18GFfX6DKysRajp/3+t/EoL2ktvKTIPeKU
         nCXANGDj7C2dqWaS5oxRVTnt87qrrAOD3/ZfUgkLnO3TM3nVDUxwSXJ15/gChK3CYZgw
         07c304FGDN3hWgwsu5dCg/8wWOVu3wWXJbrxO5GzYIv2cpeaOVceYDIVrYCal/UwpkvP
         qkeMtnsAUxNidvn8t5zLMF9g29imsJGb4NQ1L4Z5JDFsbYO4hNcQCLMv7sKHp7g2D5FG
         5ZOLEKcepdqtx6fYiz6z8bbncNalq8Jd3UlCPJLuvYpR278wnvLKJmxnnX1SkpVJG/Iu
         pJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=KdvhWx5STJQuh3h6H3k/gde8WO2PhkrNqGMLuEz+X7g=;
        b=DOct9WzprmxHUUM7m9zur63mB7TJsTOmMsOfhkczdyoN8C3xdAlBUU4eUmkafFqsJl
         Xpg6ShHLG6rfZhqSRuos4R94pzDM4FUlCnZ7dJHsPP5SYvm0NZJj0ol8PGnb8SLGfRui
         Bfp0J9BA5PF7Ss4/PG4vl9+CoyCAF7ZWTgrflZvNr2t9SW3+oC0274KfuSyfflJ6qp7i
         nt6ABH3mNLzYhVTniHhxkHH5MDGgK8WfKNnZgePiIsBKpdTx3NiqKrHISWKwOI+NUw/p
         6cstm+1MQFMPU6V5mhHnp17SFzEmLIIxQARx2/kkcMFViYx9tu2yck6iTR7APOvnspux
         HCDQ==
X-Gm-Message-State: APjAAAUOqa+ExWms2jny3pUaOIcjnk2yCp/2BPRvhGKvnNUlOjSH9Sax
        xPU+BxAI9YGHnlczydLyFRJhXpSl710=
X-Google-Smtp-Source: APXvYqzLbNe7kZu12nUvr9UjhYpZ1XPkr1S0moFNK89fzJ/s8JVOm7N4kheB0F+Id5psYyLjnP1AQw==
X-Received: by 2002:a17:90a:cd04:: with SMTP id d4mr16762205pju.70.1566797760058;
        Sun, 25 Aug 2019 22:36:00 -0700 (PDT)
Received: from localhost ([129.41.84.71])
        by smtp.gmail.com with ESMTPSA id a128sm13260907pfb.185.2019.08.25.22.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 22:35:59 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/mm: tell if a bad page fault on data is read or write.
In-Reply-To: <4f88d7e6fda53b5f80a71040ab400242f6c8cb93.1566400889.git.christophe.leroy@c-s.fr>
References: <4f88d7e6fda53b5f80a71040ab400242f6c8cb93.1566400889.git.christophe.leroy@c-s.fr>
Date:   Mon, 26 Aug 2019 11:05:56 +0530
Message-ID: <87k1b0ij43.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> DSISR has a bit to tell if the fault is due to a read or a write.
>
> Display it.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Santosh Sivaraj <santosh@fossix.org>

> ---
>  arch/powerpc/mm/fault.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 8432c281de92..b5047f9b5dec 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -645,6 +645,7 @@ NOKPROBE_SYMBOL(do_page_fault);
>  void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
>  {
>  	const struct exception_table_entry *entry;
> +	int is_write = page_fault_is_write(regs->dsisr);
>  
>  	/* Are we prepared to handle this fault?  */
>  	if ((entry = search_exception_tables(regs->nip)) != NULL) {
> @@ -658,9 +659,10 @@ void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
>  	case 0x300:
>  	case 0x380:
>  	case 0xe00:
> -		pr_alert("BUG: %s at 0x%08lx\n",
> +		pr_alert("BUG: %s on %s at 0x%08lx\n",
>  			 regs->dar < PAGE_SIZE ? "Kernel NULL pointer dereference" :
> -			 "Unable to handle kernel data access", regs->dar);
> +			 "Unable to handle kernel data access",
> +			 is_write ? "write" : "read", regs->dar);
>  		break;
>  	case 0x400:
>  	case 0x480:
> -- 
> 2.13.3
