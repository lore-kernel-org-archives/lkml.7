Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6478CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE852086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QxtJAsT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfJaScj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 14:32:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38197 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbfJaScj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:32:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id c13so4945628pfp.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 11:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UdKQ8XtlFhrxjB/2FoCKcqQ3brlpYi/JXe5PVcH9caE=;
        b=QxtJAsT2wVxqpRtct1RwB955RUPrhUvDLNXew5qo+8fOUP0xG8kcnNvRRcHMFdxylt
         ertJQZocQ4BpqrnjXqUNgPn9XUCo2ORwFbEpmwMAyYCTbXXxHiDYeiGnL4MlYSJPiMvn
         laGV6sCXpwK2xNKlRJoOIoSA7gcOMoxs/WOTGkp1SfTPUioy1Hn0t4qRRYmfKMd+iBVk
         Jz0/2DaUzSp46Jfql9Ce/pzb2rN1bbwddfIDEhMrDlT1AUcxutZGRs5q/MjE+T/kkBB9
         uvQXWJWJDzV0eW9Ai2gAiy5eun1SC9zB2vwDZRgC9Nu76i/1daaMejFaVfsDhdNsE53+
         y6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UdKQ8XtlFhrxjB/2FoCKcqQ3brlpYi/JXe5PVcH9caE=;
        b=a8u0cJcxQ9nnrXwfX2ASZPc0mPeAymSIE03cpR8XcuUZ1RdQuQ46LXzRhdjxwMmDQt
         7APuSI1wRUY2b8dkSBnwPWZbV3mDYyJXI2RvTDRnCSjSx8H03L0SEGvXIxvCNkXMltAT
         wGzjhN4SXiqPbtC4FKYmw9sr05Gfq0ZrGfsXwWiA31Vt76OGgSRjdKUhrtL54GZS3mOS
         g/quBfUol5cckmJgEPV8IUbO7v5byyWOZ8XhP90LXwKZ/eh2wFjpz3fou2gE/Vcp21Hu
         7KhcOflEoNQdEnrht+e/bH6KA0bXPsRtqdgoJxuY7cZSYTScYFuEeH+bYWTiTs7uorpq
         Ic9Q==
X-Gm-Message-State: APjAAAVhz0NYjXBdciDvyxVTALoUW6B1tRUDNaGjdBB+zDy8osaffF40
        RzWQLHrfBvjDbI2/7zmYndeqMQ==
X-Google-Smtp-Source: APXvYqwDLNRAdPzBepswCinv15VBKdWOO7bk/v7vyE7xYWILhRKYqsMcJhtBXxVVyrs9SgJbyM4Fyw==
X-Received: by 2002:a65:66c9:: with SMTP id c9mr7961884pgw.341.1572546756719;
        Thu, 31 Oct 2019 11:32:36 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v19sm4071780pff.46.2019.10.31.11.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 11:32:35 -0700 (PDT)
Date:   Thu, 31 Oct 2019 11:32:33 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 2/2] interconnect: Remove unused module exit code from
 core
Message-ID: <20191031183233.GM1929@tuxbook-pro>
References: <1572546532-19248-1-git-send-email-jcrouse@codeaurora.org>
 <1572546532-19248-3-git-send-email-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572546532-19248-3-git-send-email-jcrouse@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 31 Oct 11:28 PDT 2019, Jordan Crouse wrote:

> The interconnect core is currently always built in:
> 
>  menuconfig INTERCONNECT
> 	bool "On-Chip Interconnect management support"
> 
> So remove the module_exit function and symbolically rename module_init
> to device_initcall to drive home the point.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> 
>  drivers/interconnect/core.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index c498796..61aba50 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -805,12 +805,7 @@ static int __init icc_init(void)
>  	return 0;
>  }
>  
> -static void __exit icc_exit(void)
> -{
> -	debugfs_remove_recursive(icc_debugfs_dir);
> -}
> -module_init(icc_init);
> -module_exit(icc_exit);
> +device_initcall(icc_init);
>  
>  MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
>  MODULE_DESCRIPTION("Interconnect Driver Core");
> -- 
> 2.7.4
> 
