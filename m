Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BACC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B893E20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLr8ijpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfCRSgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:36:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46535 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfCRSgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:36:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id a22so11954111pgg.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 11:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K4VPW3+O7VtSE35FtNM/dNGTrhsfi9enghyv3AubiYg=;
        b=LLr8ijpGNWEv1BzA2/jYc3cvRgoXuRwJqOT3HHEgTXGPLHqJDCRM5MQ4iJkQCJR6kU
         q9ORbjeefbqD/Kllvsfe0ZY7HqPyVINgPJfZBHByWFnr+lp48UP3EED0W3ZZApKzr7v3
         ttlHhTkZx8SWzYWzF9XuTf3TK58aAXIEiwc/4nlmX9ngw4iH4iwszsE69UVa18sBnCTO
         x4Bet9SOz7I6o363DdG5Rrp/fKruiZwRc0cQVNLen4Xh2qIkjqBY/TCs1L7r/zqI706I
         eqBkO1xHvqnAXwLZ0TYdJO1J7PQWc+aLVCsZj7vTRBByn2XA/SelTxDhHHqA8QqyPONf
         jd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=K4VPW3+O7VtSE35FtNM/dNGTrhsfi9enghyv3AubiYg=;
        b=SLSFxG1j2h9cplmOWVs42yD2HYW0uW+MWEn2jZNKt3rCO5YTYZwaFJA4aSlS8GBH3W
         ddljhINT2j0xdRfrwfQdgOfEHAFaR8jo04wKqB7BEOfodg2JSuT+xD3bs9FMRtwmZqVC
         SEdpiyzsRq7ivkgfj5aSX1T30Iwk6UlSssQI+C6tK3qzEjrc1DmmdYDF8hjPyQ4+C6/R
         ylOHDMiInljGv7qyR/OBonyfn/1Z/gDo3KmftsebLUtzpHTV2+Wrlk7XSZF0ljsHoMe2
         hQemQgBn0EtZGZqIQ5AZfDNe6TKuHfxgZ4bViD2wZ3q9VKt37MJ0aFOypk9JDLIlAk34
         nsVA==
X-Gm-Message-State: APjAAAV8Zs90Tw08QvbYc/aw1CXcCbJSNHRj0yCJwgDKakv5NoDB0aT6
        nh4Cy3j16eJW93tYMYX1Y8Y=
X-Google-Smtp-Source: APXvYqzAPbK3ICS/zO5WrsgUKLAHeWFlsDRkSFvm0aI3oRvjuDsvNzfCIhrEk24etiE5bNjzWqIZzg==
X-Received: by 2002:a63:c042:: with SMTP id z2mr19038053pgi.307.1552934198785;
        Mon, 18 Mar 2019 11:36:38 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i22sm4227996pgl.8.2019.03.18.11.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 11:36:38 -0700 (PDT)
Date:   Mon, 18 Mar 2019 11:36:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Anton Vasilyev <vasilyev@ispras.ru>
Subject: Re: [PATCH] firmware: vpd: Drop __iomem usage for memremap() memory
Message-ID: <20190318183636.GA31345@roeck-us.net>
References: <20190318155457.197339-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318155457.197339-1-swboyd@chromium.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 08:54:57AM -0700, Stephen Boyd wrote:
> memremap() doesn't return an iomem pointer, so we can just use memcpy()
> and drop the __iomem annotation here. This silences a sparse warning.
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Anton Vasilyev <vasilyev@ispras.ru>
> Smgned-off-by: Stephen Boyd <swboyd@chromium.org>

Smgned ?

Other than that,

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/firmware/google/vpd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
> index c0c0b4e4e281..f240946ed701 100644
> --- a/drivers/firmware/google/vpd.c
> +++ b/drivers/firmware/google/vpd.c
> @@ -254,7 +254,7 @@ static int vpd_section_destroy(struct vpd_section *sec)
>  
>  static int vpd_sections_init(phys_addr_t physaddr)
>  {
> -	struct vpd_cbmem __iomem *temp;
> +	struct vpd_cbmem *temp;
>  	struct vpd_cbmem header;
>  	int ret = 0;
>  
> @@ -262,7 +262,7 @@ static int vpd_sections_init(phys_addr_t physaddr)
>  	if (!temp)
>  		return -ENOMEM;
>  
> -	memcpy_fromio(&header, temp, sizeof(struct vpd_cbmem));
> +	memcpy(&header, temp, sizeof(struct vpd_cbmem));
>  	memunmap(temp);
>  
>  	if (header.magic != VPD_CBMEM_MAGIC)
> -- 
> Sent by a computer through tubes
> 
