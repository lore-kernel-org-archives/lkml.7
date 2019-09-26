Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAD4C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014E4222C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPLq14wS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfIZMxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 08:53:16 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42689 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfIZMxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 08:53:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so1034911pls.9;
        Thu, 26 Sep 2019 05:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TZOZE+f2hac3gdmfNW1xLrjqhpR8KNKRDn13kJ7v7JE=;
        b=UPLq14wS1rKlTb/sbQmaLf+w1Mm+f9YUBoRADz9PLBcs8c95uE4SkQ+nV3zdtyA28K
         1Pg3B4tF2ezpCEfp2WK5vm54tktvdNi/RkW0fGtpxE4DFahUZgGd0NaCbgP2UkVQTtsD
         g9SKAFz/0gP/XAUJWTNbnoN0jSz1jJ5TdmWJxJC0tH33r7rc8PRWwDtow4+lEH1BxZ/g
         /+K1an4xAWI+rM567nakdbBt00YiHK7a7HCmGWEbmctRJY68QryAnwdJmuKC9aHRMyK+
         +3n5CTSkjryWoM6JE6rTRc7NwyRis/6TzZlnroxfLK9f+j4Q7o7CU7l2QU2kGpfxyHmp
         rdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TZOZE+f2hac3gdmfNW1xLrjqhpR8KNKRDn13kJ7v7JE=;
        b=SPg1B+7azjoROqVZu7t2Kjww2cCv5Rdr8NuiTQWcyHLMM/etKR2E7rz8VsJ+ok81fm
         ZABghKqfH5STuyfEUkfZ17K6j1rhFQgbTMpB4R2Kmjq2sUTID7ohniGHGil1upB7bFIs
         J7EFYlCxbij9wh/ePCtBOifpWqbf2zEFboV36sAQkT79WkEZ8eC3Wb/lfG8byRn0tfHz
         5Lsu2v5okyGiicrsJ2q2jyEI7bcb4ceLvaj1jTg1mrKVq4oFy8KP60SPAmr8VIRqGdaM
         fHrBztc97dISgTCy1HL6o8xwkoIFWVQFdLgsoK3uWqs9ku1Dqjujp0llHKv7LHs0AzI6
         2JyQ==
X-Gm-Message-State: APjAAAUGvh6+bmWQ/bfXP3pGFAOa4zRh8TW+MVmem1eVv7UXOgyviCKb
        2pOdzuOptQDOwiUYDSmzr/g=
X-Google-Smtp-Source: APXvYqwBuxHuJpQ7R68t4YE8dpJpMHAmfzrPXx4/EaIC4upBpwuXzYcnfmLXprAIpiVJtH+KCRl36g==
X-Received: by 2002:a17:902:b20a:: with SMTP id t10mr3704897plr.277.1569502393574;
        Thu, 26 Sep 2019 05:53:13 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k184sm4325854pge.57.2019.09.26.05.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Sep 2019 05:53:12 -0700 (PDT)
Date:   Thu, 26 Sep 2019 05:53:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Fix a signedness bug in
 tcpm_fw_get_caps()
Message-ID: <20190926125310.GA9967@roeck-us.net>
References: <20190925110219.GN3264@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925110219.GN3264@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 02:02:19PM +0300, Dan Carpenter wrote:
> The "port->typec_caps.data" and "port->typec_caps.type" variables are
> enums and in this context GCC will treat them as an unsigned int so they
> can never be less than zero.
> 
> Fixes: ae8a2ca8a221 ("usb: typec: Group all TCPCI/TCPM code together")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 96562744101c..d3b63e000ae2 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4410,7 +4410,7 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>  	ret = fwnode_property_read_string(fwnode, "data-role", &cap_str);
>  	if (ret == 0) {
>  		port->typec_caps.data = typec_find_port_data_role(cap_str);
> -		if (port->typec_caps.data < 0)
> +		if ((int)port->typec_caps.data < 0)
>  			return -EINVAL;

Doesn't that also cause a warning about overwriting error return codes ?
I would prefer something like

		ret = typec_find_port_data_role(cap_str);
		if (ret < 0)
			return ret;
		port->typec_caps.data = ret;

Guenter

>  	}
>  
> @@ -4419,7 +4419,7 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>  		return ret;
>  
>  	port->typec_caps.type = typec_find_port_power_role(cap_str);
> -	if (port->typec_caps.type < 0)
> +	if ((int)port->typec_caps.type < 0)
>  		return -EINVAL;
>  	port->port_type = port->typec_caps.type;
>  
> -- 
> 2.20.1
> 
