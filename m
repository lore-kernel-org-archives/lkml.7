Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18435C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0FA20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px2QTwwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfCGPOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:14:43 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34163 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfCGPOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:14:42 -0500
Received: by mail-ed1-f68.google.com with SMTP id a16so13780229edn.1;
        Thu, 07 Mar 2019 07:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Al0gMUiptC3pGkCnIsL4iS5CkzCA3B5rSRiNXpe/8Po=;
        b=Px2QTwwI9FHwdPpckmfLm+y0x3fxzKp5PM0QAB1HaPHpDYV+jEEV426sWAedYpM9Qx
         V7+0bXQshmKfihlZUoNyV6YoG1/yaLLvsdsHLG8MfwXd1QaZDNYJPOFWfap+H5gbixUJ
         Aj8ZpxtKaLpQ3vr3hHFxwN6zDOCpy6QueDqmENf5Et6XhQm0jzht2KA18lIr85oAn2ki
         8ZFknfHAofjlsLO8zLF/ktR8Kl8IuOOKsY3gdkriio+PdnUUrFM8f8FLjSQ0wzR+1qh/
         Gw8AvvMdweX2np+8Z/scrPjNDARdBZxPHhTLVYQmXcM/WKnkJhCNj0eArgaK2gKibCxe
         FtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Al0gMUiptC3pGkCnIsL4iS5CkzCA3B5rSRiNXpe/8Po=;
        b=awMTOteDQT59YzHQUuP6XfF9ueZPxE31q4nRJgbgoYDSlIQ1U9KOBnoCuRpSJUCpIT
         qPzQJ474zPoeOmkVuxsZOTa8zYGUcO8qtwoA9gLdnOZQRWPfWc7QElnd7YpG73Na+U7m
         B8gXVPaEOXPc0+f3JQivFvE/wD9ToTIicB1lLw/etwU+BXkrT6lHvtcCYPLjczGHxnqV
         f7WM80jl8D8kxpGfJcmO9SmKC9Q3Pv60C/mXTa42lEYyZZLpRYY6Cf/F/tiUGl1riYux
         CUAqumggA69eI1Z3ctWEL19aGjmi3wFKFpEnImuTAyTjs4Cj1R7w7hIi+bLH58FwJvgI
         VU9g==
X-Gm-Message-State: APjAAAWzOmj9JTAikFcOYR0+/YLVAF1JpO6ptcyueC9JqKwDY3hc/Vse
        uJ9hPg4zoCsVbwGKLSXhwgk=
X-Google-Smtp-Source: APXvYqy2KjzMLnsqMkxKTU26p5atbCYIYlkbUXGNNgFi0fHOsTbmq631GPNGgjM0sj4qBFmZDm8q3g==
X-Received: by 2002:a17:906:e9cc:: with SMTP id kb12mr8339861ejb.81.1551971679760;
        Thu, 07 Mar 2019 07:14:39 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id q24sm1413612edg.20.2019.03.07.07.14.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Mar 2019 07:14:38 -0800 (PST)
Date:   Thu, 7 Mar 2019 08:14:37 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christian Benvenuti <benve@cisco.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] enic: fix build warning without CONFIG_CPUMASK_OFFSTACK
Message-ID: <20190307151437.GA20201@archlinux-ryzen>
References: <20190307093311.3406888-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307093311.3406888-1-arnd@arndb.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 10:33:02AM +0100, Arnd Bergmann wrote:
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
> the pointer is what we need in this configuration.  To get rid of the
> warning, I split out the check into a separate function, and hide that
> portion if CONFIG_CPUMASK_OFFSTACK is disabled.
> 
> Fixes: 322cf7e3a4e8 ("enic: assign affinity hint to interrupts")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/cisco/enic/enic_main.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index 9a7f70db20c7..f652a8bd163e 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c
> @@ -112,6 +112,15 @@ static struct enic_intr_mod_range mod_range[ENIC_MAX_LINK_SPEEDS] = {
>  	{3,  6}, /* 10 - 40 Gbps */
>  };
>  
> +static inline int enic_affinity_mask_empty(struct enic *enic, int i)
> +{
> +#ifdef CONFIG_CPUMASK_OFFSTACK
> +	if (!enic->msix[i].affinity_mask)
> +		return 1;
> +#endif
> +	return cpumask_empty(enic->msix[i].affinity_mask);
> +}
> +
>  static void enic_init_affinity_hint(struct enic *enic)
>  {
>  	int numa_node = dev_to_node(&enic->pdev->dev);
> @@ -119,8 +128,7 @@ static void enic_init_affinity_hint(struct enic *enic)
>  
>  	for (i = 0; i < enic->intr_count; i++) {
>  		if (enic_is_err_intr(enic, i) || enic_is_notify_intr(enic, i) ||
> -		    (enic->msix[i].affinity_mask &&
> -		     !cpumask_empty(enic->msix[i].affinity_mask)))
> +		    !enic_affinity_mask_empty(enic, i))
>  			continue;
>  		if (zalloc_cpumask_var(&enic->msix[i].affinity_mask,
>  				       GFP_KERNEL))
> @@ -148,8 +156,7 @@ static void enic_set_affinity_hint(struct enic *enic)
>  	for (i = 0; i < enic->intr_count; i++) {
>  		if (enic_is_err_intr(enic, i)		||
>  		    enic_is_notify_intr(enic, i)	||
> -		    !enic->msix[i].affinity_mask	||
> -		    cpumask_empty(enic->msix[i].affinity_mask))
> +		    enic_affinity_mask_empty(enic, i))
>  			continue;
>  		err = irq_set_affinity_hint(enic->msix_entry[i].vector,
>  					    enic->msix[i].affinity_mask);
> @@ -161,8 +168,7 @@ static void enic_set_affinity_hint(struct enic *enic)
>  	for (i = 0; i < enic->wq_count; i++) {
>  		int wq_intr = enic_msix_wq_intr(enic, i);
>  
> -		if (enic->msix[wq_intr].affinity_mask &&
> -		    !cpumask_empty(enic->msix[wq_intr].affinity_mask))
> +		if (!enic_affinity_mask_empty(enic, wq_intr))
>  			netif_set_xps_queue(enic->netdev,
>  					    enic->msix[wq_intr].affinity_mask,
>  					    i);
> -- 
> 2.20.0
> 

A slightly less intrusive change would be using cpumask_available, which
was specifically introduced for this purpose in commit f7e30f01a9e2
("cpumask: Add helper cpumask_available()").
