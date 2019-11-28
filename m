Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC42C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDE12176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aYsQAOKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfK1IVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 03:21:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45218 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfK1IVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 03:21:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so4094384wrj.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 00:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VOI036BPUwrbZowHT5GDUEXOWOhQmQWDUMNaY8GO7tI=;
        b=aYsQAOKb1A7PKWIf5wGzlAze4eWPmdGPLKe1SsRZU2k+tm4SMPOV4cgWHesnBHGp+S
         UhuJTmeX6pC8+bfFMrJo8ASo5EZgv85U5ojeERcDI6qYQAaU/NdssXIMa4sf40VLFh7d
         7QRRyOvSR6Obq94UORxMiHh7CN+v/LEBj9X0XichLgfdrZezNY4/lhr9mI89UJcIWmN5
         Gib8pPmxplFkJrhJLjiE8xQxxltLaNGhNaQwJbSxtz+OqQUxUJOfoWUpo4Y+8gVUi46T
         qTLyVE8LlvEBsMD81mpln4RLMc4Gd7X3TvzNnjUotecTl3zoL1Ootn/mU1cM2egiLCeO
         YEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VOI036BPUwrbZowHT5GDUEXOWOhQmQWDUMNaY8GO7tI=;
        b=MhyEtC/9wCZqRKhFti/b1TacHYpqTfEajWqq+O67SVxp/n9VTP5/q6q0cPatKg5F9A
         s0pTixBQLn3PLkrHpSyZHCwj2Fk+BAXWs3CKHUmcZ6Hc6dhVjjQhgDEO5/fzxfLh7yxB
         fcdI+ArRazjH/Mo/g0+Jm2r2RRJr7N6qtFcqduEetXyLAoDNotKrkRw7Sq/zzQJ6JJ3m
         0czrQPm5Mf19HuoCyKopHbkp3IOvRaRkaxcY3hXza0GjdK5n3NeN3MuKja8T1cs+3HFY
         ZP5spF8vAd6WILwasWAs639WdaP4RAwzqvN3NTdnSoHqLwRlgbCY7jWvhDd3AVzwyaun
         p+jQ==
X-Gm-Message-State: APjAAAWMWn7upghIGgd7/Z/sVTvoQWdESAfwlxC0PcjP+9GcvKkZCWj5
        +kV6h3jnPUAdVhO6GkiMbSWtWA==
X-Google-Smtp-Source: APXvYqwnYPAyBuUvcvS1pBiBRsm7B8Y/eawgeM5AHpFMzHjgdUnfsDOjjE//piFuuaBq8Ij9fBLegg==
X-Received: by 2002:a5d:43c3:: with SMTP id v3mr38726407wrr.324.1574929290712;
        Thu, 28 Nov 2019 00:21:30 -0800 (PST)
Received: from apalos.home (athedsl-4476713.home.otenet.gr. [94.71.27.49])
        by smtp.gmail.com with ESMTPSA id q3sm502890wrn.33.2019.11.28.00.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 00:21:30 -0800 (PST)
Date:   Thu, 28 Nov 2019 10:21:27 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: ale: ensure vlan/mdb deleted when no
 members
Message-ID: <20191128082127.GA16359@apalos.home>
References: <20191127155905.22921-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127155905.22921-1-grygorii.strashko@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 05:59:05PM +0200, Grygorii Strashko wrote:
> The recently updated ALE APIs cpsw_ale_del_mcast() and
> cpsw_ale_del_vlan_modify() have an issue and will not delete ALE entry even
> if VLAN/mcast group has no more members. Hence fix it here and delete ALE
> entry if !port_mask.
> 
> The issue affected only new cpsw switchdev driver.
> 
> Fixes: e85c14370783 ("net: ethernet: ti: ale: modify vlan/mdb api for switchdev")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/net/ethernet/ti/cpsw_ale.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
> index 929f3d3354e3..a5179ecfea05 100644
> --- a/drivers/net/ethernet/ti/cpsw_ale.c
> +++ b/drivers/net/ethernet/ti/cpsw_ale.c
> @@ -396,12 +396,14 @@ int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
>  	if (port_mask) {
>  		mcast_members = cpsw_ale_get_port_mask(ale_entry,
>  						       ale->port_mask_bits);
> -		mcast_members &= ~port_mask;
> -		cpsw_ale_set_port_mask(ale_entry, mcast_members,
> +		port_mask = mcast_members & ~port_mask;
> +	}
> +
> +	if (port_mask)
> +		cpsw_ale_set_port_mask(ale_entry, port_mask,
>  				       ale->port_mask_bits);
> -	} else {
> +	else
>  		cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
> -	}

The code assumed calls cpsw_ale_del_mcast() should have a port mask '0' when
deleting an entry. Do we want to have 'dual' functionality on it? 
This will delete mcast entries if port mask is 0 or port mask matches exactly
what's configured right?

>  	cpsw_ale_write(ale, idx, ale_entry);
>  	return 0;
> @@ -478,6 +480,10 @@ static void cpsw_ale_del_vlan_modify(struct cpsw_ale *ale, u32 *ale_entry,
>  	members = cpsw_ale_get_vlan_member_list(ale_entry,
>  						ale->vlan_field_bits);
>  	members &= ~port_mask;
> +	if (!members) {
> +		cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
> +		return;
> +	}

This makes sense the call was missing 

>  
>  	untag = cpsw_ale_get_vlan_untag_force(ale_entry,
>  					      ale->vlan_field_bits);
> -- 
> 2.17.1
> 


Thanks
/Ilias
