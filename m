Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1ABCA9EC1
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34F121721
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXx8A7MF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfJ2BrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 21:47:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34092 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfJ2BrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 21:47:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id e4so4044616pgs.1;
        Mon, 28 Oct 2019 18:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H6F8R3JCUcijrcISpIqaMmNlxSaXg/x1o4VoaEKW7pk=;
        b=FXx8A7MF3sJ3zC6HOzUkYCd4JgIvMFGOij89BPl1oBNkhVhIQy8MBcYE6kIaP4o18T
         1FnhC0liEmZ+aWibVa5X2qPGXABYY7JTRVZ7rSGM/YVIpBzTcjg0/T+CTeE+2QzRMmlu
         K9HLqCA/REDocLdmaCrprjQwaLZIsWwE/7u7e47G4X5LqPVLJD1bfTmX0wesfRwCIU4B
         fWiRyNEzP5CDzabefSWJraYujLkh8X/RLOKReSlysYLGEq6r8vUMQaqQmA16G+lJMuxA
         af7qJpEXrfT6WS+GD+o5FOFo/v/Ced8Z6tjSy5UNozc+irkcvN/A2nJA9d3k45ipIck6
         AfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=H6F8R3JCUcijrcISpIqaMmNlxSaXg/x1o4VoaEKW7pk=;
        b=Uz/iIrmOoj7aln5BUM3TDHfjgugWBgT2xjamtsvrkyFEemNJeD8tATz4+g1X1NioFj
         qkitgAKUAfXz9GsTB7r4Tl9kd1msRyszuAOGTtIvRVyyuS64UAkl4+EM4mSWOoq8zKV0
         SKe+cc0wNWTE1a3Qy0fg6D9oCaVtRByLE7AXSN42pJkLjAOluTDitj/WCRaqFFzY5aVj
         ERj5anlrLBYj4x14pXr9BkcV+1ARhmUeyQ1j3q5QbzQnMbKVRfjhi7rqxKmUrm/NwJBb
         /QFeghthu6GIn2J9y/FK81YfNedWEQWEEzYtxWX7Ol+5LmttDIC40UUHINsLgHPZZwWU
         2FxA==
X-Gm-Message-State: APjAAAWkTzdzW7fYUtvwqCyk2ECk26XXP8pHS09ZNePOwz6+yB0bM16y
        H0rjs6YMNiWWJ0MBO2gzj5w=
X-Google-Smtp-Source: APXvYqzWXN7iBuH3BLVP3Cl3cNjR0RXYx1DS5rGdd+gD6dwpidBa7wGsQ7kcjOzpWsCvJIettD1qXw==
X-Received: by 2002:a17:90b:157:: with SMTP id em23mr2978709pjb.22.1572313635249;
        Mon, 28 Oct 2019 18:47:15 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f7sm12356156pfa.150.2019.10.28.18.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 18:47:14 -0700 (PDT)
Date:   Mon, 28 Oct 2019 18:47:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ina3221) Fix read timeout issue
Message-ID: <20191029014712.GA22268@roeck-us.net>
References: <20191022005922.30239-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022005922.30239-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 05:59:22PM -0700, Nicolin Chen wrote:
> After introducing "samples" to the calculation of wait time, the
> driver might timeout at the regmap_field_read_poll_timeout call,
> because the wait time could be longer than the 100000 usec limit
> due to a large "samples" number.
> 
> So this patch sets the timeout limit to 2 times of the wait time
> in order to fix this issue.
> 
> Fixes: 5c090abf945b ("hwmon: (ina3221) Add averaging mode support")
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/ina3221.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index ef37479991be..f335d0cb0c77 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -213,7 +213,7 @@ static inline int ina3221_wait_for_data(struct ina3221_data *ina)
>  
>  	/* Polling the CVRF bit to make sure read data is ready */
>  	return regmap_field_read_poll_timeout(ina->fields[F_CVRF],
> -					      cvrf, cvrf, wait, 100000);
> +					      cvrf, cvrf, wait, wait * 2);
>  }
>  
>  static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
