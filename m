Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94454C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9CD2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="mnRv9e6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfCTRuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:50:17 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34726 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfCTRuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:50:16 -0400
Received: by mail-yw1-f67.google.com with SMTP id x129so2718769ywc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7OxuR53wdzl6MOycNBLPAiNm8PfDGfyjxkHG2qKJu7A=;
        b=mnRv9e6v2HcCo0bVRJIWgxxNQ9gK3mQplwoD8oihvwIBYSJqInQgC7ClmbDGK+UuWr
         6uSECsGkCUhek/9Xv03pcua0NzvDmnIMBY+2eitcU5RmBKdUualoP29wGj6x5ZlgmA2n
         WjXGR3qoJ4EL5SAzhovqdPOctplSSsk1ok8aGgXtYRuCkxP5eI7XkMcqOc8HErjm/2bF
         maEfYEEBqagVoC32DWdMq6M87SKv1SmqneElKqMAZw2e3ldyLWkqWrF0m9RJipqO72QD
         CVkwmQfpM7w6zkfL9sqFsWPlSWmCH7uEiN6fx+6JrT4umfGBYRctl0/nGIoqfk92ZhFw
         UOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7OxuR53wdzl6MOycNBLPAiNm8PfDGfyjxkHG2qKJu7A=;
        b=N8ZCOk91RN71O6rSGFMuqqg9vxjCG/oT/jkGZWagg/ula7i5QtsJ8FM7DZpnIoEO6t
         z/Y8zOQYK3bDgGkJIjty4xKX/CJU+MXGiNWDuYkDqNhPLE3MgxHgWcKRlGOxwjq1FKJg
         oRLM+cMPsgkgrLNgL2JN2JVNfSArT5jaCHXichWDLvx9jCBSwIpIOJ1yp96bZoiMEprK
         bnEslAspeYVKgqQfgYqz1whpnJtCKEIQkb5VKzO51nh8mIWE+IiNxozw4F2IPVtvLKmZ
         WQBc4QNnxtrXjLa7VpFiqbfsPql9o9a7hE395+2HG3earYTq2d5mz3M4LolZ2waXbrZM
         YwyQ==
X-Gm-Message-State: APjAAAWAXtQ6aV+H9gJwEc3g1JyKRYRSCsVs7YC0Dy8xqXgQ1Ny2f60Z
        ssXNRB7RAUF8MH5pwRfNusUw1A==
X-Google-Smtp-Source: APXvYqxldWzjXkiAfzdLybfhx6yN9X8PPLn81YdzE1+39b7BNbOGoHhOla+0FeGgeTdB8rPEdG6qOw==
X-Received: by 2002:a81:7a0b:: with SMTP id v11mr7762234ywc.127.1553104215466;
        Wed, 20 Mar 2019 10:50:15 -0700 (PDT)
Received: from kudzu.us (76-230-155-4.lightspeed.rlghnc.sbcglobal.net. [76.230.155.4])
        by smtp.gmail.com with ESMTPSA id 190sm1280286ywd.62.2019.03.20.10.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 10:50:14 -0700 (PDT)
Date:   Wed, 20 Mar 2019 13:50:12 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     "Mehta, Sanju" <Sanju.Mehta@amd.com>
Cc:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] NTB: ntb_perf: Increased the number of message
 retries to 1000
Message-ID: <20190320175011.GA27156@kudzu.us>
References: <1550222279-27216-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550222279-27216-1-git-send-email-Sanju.Mehta@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 09:20:07AM +0000, Mehta, Sanju wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> while waiting for the peer ntb_perf to initialize scratchpad
> registers, local side ntb_perf  might have already exhausted the
> maximum number of retries which is currently set to 500. To avoid
> this and to give little more time to the peer ntb_perf for scratchpad
> initialization, increased the number of retries to 1000
> 
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>

Series applied to my ntb branch.

Thanks,
Jon


> ---
>  drivers/ntb/test/ntb_perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 2a9d6b0..a828d0e 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -100,7 +100,7 @@ MODULE_DESCRIPTION("PCIe NTB Performance Measurement Tool");
>  #define DMA_TRIES		100
>  #define DMA_MDELAY		10
>  
> -#define MSG_TRIES		500
> +#define MSG_TRIES		1000
>  #define MSG_UDELAY_LOW		1000
>  #define MSG_UDELAY_HIGH		2000
>  
> -- 
> 2.7.4
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/1550222279-27216-1-git-send-email-Sanju.Mehta%40amd.com.
> For more options, visit https://groups.google.com/d/optout.
