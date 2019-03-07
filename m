Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AD1C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D80220854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqoz3bkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfCGP72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:59:28 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36708 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfCGP72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:59:28 -0500
Received: by mail-ed1-f65.google.com with SMTP id g9so13894378eds.3;
        Thu, 07 Mar 2019 07:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6eZ42+5uHfqNutpf/blYlgoSh21KgioZXCYaxr8IDTw=;
        b=sqoz3bkgQRKcB46jQ6b8/6cddBHzu2fs/5qAoWxML+GV4BbJwwI/Gqf1qqvwaxBtlV
         ugypQjKWhvd590Ii7gb2gBNzn8uqGu0XG4rmNJRrPyTP/i8tbZQtMvzUDX6PhS0dcRwq
         1cvk+Eak6Q1CQ4pVH2ApKWn38mAYBUCQwsbZvXhrvpso7rfSz0BvBd1sPvvqYFKCDOjO
         V6c/angT4PyhyEL82HGAdYcm/3IaWZeRox9eapNlWLXh1pwMDxIZ6yFQaQ9oiMtNykkj
         tNrkC1Z6t/PuA+QcqhxP1QimfW0rptKdA+d0XILwNavMKb/oZC5gnNFnvYfiL0etv41r
         uEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6eZ42+5uHfqNutpf/blYlgoSh21KgioZXCYaxr8IDTw=;
        b=DudpVF/wp71tLGkAldKDu9cR9NqMxjiqhcWwU/u1XXp+a6a1s+dlL1oKORckjWCXe+
         cUZAhw70XZfxb4xbYEFcuaCFeelz1B4/GK+s+F+GUGkGHEMPmbiUf9xU2KGpGfhKvqH8
         DlISjdPzUMAinA6w9WNtiijpEzBU6NZLdtRKlagIpLAxkH9YdD0fGta0WCYwmpe8l/eP
         PVwePFgbG2Ay39eFu5sOfaukVHPfOLw1SXWC8QlZydfUyp0tM7dwQjedo5QEeX64IB/A
         JRvSwXIZZqBiyI7kZFFqrWDMrsoiXjpvdj+NX++3lfj8IFArnSEYovV4nlgU1Ir+Z+ct
         pVmw==
X-Gm-Message-State: APjAAAWwsV2q6Ify/Uf0nkuAYT8FZD1tGIEqkPWbC14jBjM3NKLMpFLI
        7DF3wOkVvh03fNpogbwWCZcdxPEFO8kx7w==
X-Google-Smtp-Source: APXvYqyMl5/lRqmHuqbowFmvekdbrvbwNlWHrK7AFhjbcXWaV+JH1oCtD4Vgu8t/1fJDeY1GOjLVbQ==
X-Received: by 2002:a50:9154:: with SMTP id f20mr28113695eda.68.1551974365768;
        Thu, 07 Mar 2019 07:59:25 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id s24sm1434843edd.23.2019.03.07.07.59.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Mar 2019 07:59:25 -0800 (PST)
Date:   Thu, 7 Mar 2019 08:59:23 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christian Benvenuti <benve@cisco.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] enic: fix build warning without
 CONFIG_CPUMASK_OFFSTACK
Message-ID: <20190307155923.GA22197@archlinux-ryzen>
References: <20190307155230.2923527-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307155230.2923527-1-arnd@arndb.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 04:52:24PM +0100, Arnd Bergmann wrote:
> The enic driver relies on the CONFIG_CPUMASK_OFFSTACK feature to
> dynamically allocate a struct member, but this is normally intended for
> local variables.
> 
> Building with clang, I get a warning for a few locations that check the
> address of the cpumask_var_t:
> 
> drivers/net/ethernet/cisco/enic/enic_main.c:122:22: error: address of array 'enic->msix[i].affinity_mask' will always evaluate to 'true' [-Werror,-Wpointer-bool-conversion]
> 
> As far as I can tell, the code is still correct, as the truth value of
> the pointer is what we need in this configuration. To get rid of
> the warning, use cpumask_available() instead of checking the
> pointer directly.
> 
> Fixes: 322cf7e3a4e8 ("enic: assign affinity hint to interrupts")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> v2: use cpumask_available() instead of open-coding a copy
> ---
>  drivers/net/ethernet/cisco/enic/enic_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index 9a7f70db20c7..733d9172425b 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c
> @@ -119,7 +119,7 @@ static void enic_init_affinity_hint(struct enic *enic)
>  
>  	for (i = 0; i < enic->intr_count; i++) {
>  		if (enic_is_err_intr(enic, i) || enic_is_notify_intr(enic, i) ||
> -		    (enic->msix[i].affinity_mask &&
> +		    (cpumask_available(enic->msix[i].affinity_mask) &&
>  		     !cpumask_empty(enic->msix[i].affinity_mask)))
>  			continue;
>  		if (zalloc_cpumask_var(&enic->msix[i].affinity_mask,
> @@ -148,7 +148,7 @@ static void enic_set_affinity_hint(struct enic *enic)
>  	for (i = 0; i < enic->intr_count; i++) {
>  		if (enic_is_err_intr(enic, i)		||
>  		    enic_is_notify_intr(enic, i)	||
> -		    !enic->msix[i].affinity_mask	||
> +		    !cpumask_available(enic->msix[i].affinity_mask) ||
>  		    cpumask_empty(enic->msix[i].affinity_mask))
>  			continue;
>  		err = irq_set_affinity_hint(enic->msix_entry[i].vector,
> @@ -161,7 +161,7 @@ static void enic_set_affinity_hint(struct enic *enic)
>  	for (i = 0; i < enic->wq_count; i++) {
>  		int wq_intr = enic_msix_wq_intr(enic, i);
>  
> -		if (enic->msix[wq_intr].affinity_mask &&
> +		if (cpumask_available(enic->msix[wq_intr].affinity_mask) &&
>  		    !cpumask_empty(enic->msix[wq_intr].affinity_mask))
>  			netif_set_xps_queue(enic->netdev,
>  					    enic->msix[wq_intr].affinity_mask,
> -- 
> 2.20.0
> 
