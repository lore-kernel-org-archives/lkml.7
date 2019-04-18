Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F087BC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE10320674
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEHSGtlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389076AbfDRNps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:45:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40724 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRNpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:45:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so1138880pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 06:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WAyhqaJHuB9SLip6ulwD6Xpt12xd5vhBTW8mwoourWY=;
        b=MEHSGtlWJYwLWC5QDKh3slBm02EP+pv8YHdmjkDfgtds+aS1uiHX+hnAA31k5l3kTI
         wBH9EUPKlAPXzxWR7jOw2E0fZdIUf3pqEzdlP1uJEAxpMctu1G/8UbTPh3g2S0VxtDfx
         OU9jJ+78fL/4CwbYkgGH6w5dwKYkvNjSYStzJAhKeqvDlZuvnkNFDrfj+/BlyKkBsmnf
         LXJEimEDaJKG/3mmvL25ZNlZ0OfDjN5Lj7wwXiMmfYxWB4CWbUd1fwxmRJRpYUXSI+Ox
         pYjJtElodSbgE55i8MwIBuFuncjDRuW4bRgGtJcQ6ft2X83Jg+yLWAXsh0XGTrOY3rUD
         JaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WAyhqaJHuB9SLip6ulwD6Xpt12xd5vhBTW8mwoourWY=;
        b=jHRxEiy+US2PtQuDzcSRTI4VLIgCRyd8qnvjZxlD1BCNnY78WFKrC2TZYOclAktdgX
         1/GK7YB7QyPRYzIVpzKGCPymx+ah4pCYV18Yn6MEvPDGhHLeip2x9Aczf6zDVcwFHSqf
         ugP233oCO0zH5CX9/ut6SJq3bwHSpx7wtXHkCsU3pf3khvjCVA3hz53NBBjPyc35JHrc
         7yz/8Rk8uRdfCy+HAMWhyrT8uy3ZhnBqJlEB4sfkwPs9EI8gyVJ4Wb2XzUcm38uQeZLc
         djDlpCnDQSW7lgYp6TZM0o7yRjI5q8q0Gfyl/uQLYTDF74RG7kWFkjXgsPxGM9MAdlVk
         EcqQ==
X-Gm-Message-State: APjAAAUdzY/g9wQC8SDvOSpfS/IWzn+24M1T3L0PJ5KI8+l4gz0psrxg
        Be7eN/5jN3Dl0/ulCAb3Xop96Vv8
X-Google-Smtp-Source: APXvYqwukvZaO4RI8cYioVXB8dX5i2WtB9NC7fROj9IVERnz7+3EJLzYYbuofJwUV4XzHvG1mi/q9Q==
X-Received: by 2002:a63:fc5a:: with SMTP id r26mr84599540pgk.97.1555595147244;
        Thu, 18 Apr 2019 06:45:47 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id x6sm7060170pfb.171.2019.04.18.06.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 06:45:46 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 18 Apr 2019 23:43:56 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 07/10] vsprintf: Consolidate handling of unknown
 pointer specifiers
Message-ID: <20190418144356.GB16037@tigerII.localdomain>
References: <20190417115350.20479-1-pmladek@suse.com>
 <20190417115350.20479-8-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417115350.20479-8-pmladek@suse.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/17/19 13:53), Petr Mladek wrote:
[..]
>  char *ip_addr_string(char *buf, char *end, const void *ptr,
>  		     struct printf_spec spec, const char *fmt)
>  {
> +	char *err_fmt_msg;
> +
>  	switch (fmt[1]) {
>  	case '6':
>  		return ip6_addr_string(buf, end, ptr, spec, fmt);
> @@ -1457,7 +1459,8 @@ char *ip_addr_string(char *buf, char *end, const void *ptr,
>  		}}
>  	}
>  
> -	return ptr_to_id(buf, end, ptr, spec);
> +	err_fmt_msg = fmt[0] == 'i' ? "(%pi?)" : "(%pI?)";
> +	return string_nocheck(buf, end, err_fmt_msg, spec);
>  }

We cannot err on fmt[0] here, can we. Both %pi and %pI are OK
and handled by pointer():

	switch (fmt[0]) {
	case 'I':
	case 'i':
		return ip_addr_string(buf, end, ptr, spec, fmt);


It's fmt[1] which can be unrecognized:

	switch (fmt[1]) {
	case '6':
	case '4':
	case 'S':
	}

	-ss
