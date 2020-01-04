Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C939C33C99
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D688824650
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="am5n50n1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgADVVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 16:21:33 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34507 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgADVVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 16:21:33 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so25023504pgf.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 13:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=plpKbdiW72DXJOvU1TVKdnl0zL4VM/YG87vawclIn4g=;
        b=am5n50n1oazIAUJ+wPBXku6ho9iqM+p9CB9klzmmA3vS9X9Fy65BjVdjbZadmAjSTF
         j7rspwpImjnIRTaPRl89iMez9Wwy0CEciZyQ+72J/Js5lZPUyCO6b6TQxTYvA33B/LUJ
         qW0Kx8ekLp+UQ+TwZjCvlGUFOndUeA4M/hX88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=plpKbdiW72DXJOvU1TVKdnl0zL4VM/YG87vawclIn4g=;
        b=pXixZbUmazB2JN4uSck9EuWoYIvUPuvm0Mn54tz/OwZkRo8AhKhVvBG1jb2hcHr/1H
         sceEHOKnVLORgJfwhgI9GpFbMxxDeFBvrqLPfQ72i4X9a2plZY33Q9vNzECYcdr4pgPc
         r4lusc4QwOjxWu8fAz+83Ry0fY32CXuAEzPvXVmGPnDWikmQDrAu/njpEUdtigZCnrRY
         4UOoWYcn5OQTtskGTbUtXIUOL9fCI60wOlTjrn9KSDNOvusQFngExTwLiU27/7u9IwYC
         YVnmM2PFDaRlkMK4Ne+Et270L0wO1NWbxrpC8OFVeE/UZnamGbYVIxN6cMnDrMcxw57O
         0Jeg==
X-Gm-Message-State: APjAAAXibVwTHxNYUmySs17eMn1ffjQGKjJOmU66GXNhnHEibK3MmueO
        t+Kq6nMgPrAGVePDMA6Dlc91aQ==
X-Google-Smtp-Source: APXvYqznm49seUa5hKAczurh81jT6PyWLH3/0O90WcjrfI7g+tRM/rvYJDn6zIYHARt2LE/nuhElqA==
X-Received: by 2002:aa7:96b7:: with SMTP id g23mr98998711pfk.108.1578172892874;
        Sat, 04 Jan 2020 13:21:32 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s18sm67570463pfh.179.2020.01.04.13.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 13:21:32 -0800 (PST)
Date:   Sat, 4 Jan 2020 16:21:31 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     madhuparnabhowmik04@gmail.com
Cc:     stefanr@s5r6.in-berlin.de, paulmck@kernel.org,
        linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, frextrite@gmail.com
Subject: Re: [PATCH] drivers: firewire: core-transaction: Pass lockdep
 condition to address_handler_list iterator
Message-ID: <20200104212131.GN189259@google.com>
References: <20200104144215.27590-1-madhuparnabhowmik04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104144215.27590-1-madhuparnabhowmik04@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2020 at 08:12:15PM +0530, madhuparnabhowmik04@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> The address_handler_list is traversed with list_for_each_entry_rcu
> with address_handler_list_lock held.
> list_for_each_entry_rcu has built-in RCU and lock checking.
> Use it for address_handler_list traversal.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> ---
>  drivers/firewire/core-transaction.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
> index 404a035f104d..a15e70027932 100644
> --- a/drivers/firewire/core-transaction.c
> +++ b/drivers/firewire/core-transaction.c
> @@ -61,6 +61,11 @@
>  #define PHY_CONFIG_ROOT_ID(node_id)	((((node_id) & 0x3f) << 24) | (1 << 23))
>  #define PHY_IDENTIFIER(id)		((id) << 30)
>  
> +static DEFINE_SPINLOCK(address_handler_list_lock);
> +static LIST_HEAD(address_handler_list);
> +
> +#define address_handler_list_lock_held() lock_is_held(&(address_handler_list_lock).dep_map)
> +
>  /* returns 0 if the split timeout handler is already running */
>  static int try_cancel_split_timeout(struct fw_transaction *t)
>  {
> @@ -485,7 +490,7 @@ static struct fw_address_handler *lookup_overlapping_address_handler(
>  {
>  	struct fw_address_handler *handler;
>  
> -	list_for_each_entry_rcu(handler, list, link) {
> +	list_for_each_entry_rcu(handler, list, link, address_handler_list_lock_held()) {
>  		if (handler->offset < offset + length &&
>  		    offset < handler->offset + handler->length)
>  			return handler;
> @@ -514,8 +519,6 @@ static struct fw_address_handler *lookup_enclosing_address_handler(
>  	return NULL;
>  }
>  
> -static DEFINE_SPINLOCK(address_handler_list_lock);
> -static LIST_HEAD(address_handler_list);
>  
>  const struct fw_address_region fw_high_memory_region =
>  	{ .start = FW_MAX_PHYSICAL_RANGE, .end = 0xffffe0000000ULL, };
> -- 
> 2.17.1
> 
