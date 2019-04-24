Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87414C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DDC2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556065319;
	bh=Bdt1EDkEUlum3F7qDy7HGfQ+9zhzsg34Q4ZJLeltAhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U1OlZaLnRVgosdr6M+vfttPMvqmwkRS1Tw8W/TlDjfBmg6eQW6NfwXzzM3Kf/qfbX
	 9+XOLQLSV9QOKqIYZpMHwNmpVcbJDV/lJmQL1lhbxRqX6XWx4h7wNFC8crnQehyS/S
	 SM7PjL7DtihGo4qJsXeYPBDJA3b+Mh3nny+V535A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfDXAV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:21:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37365 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbfDXAV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 20:21:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id w23so8339899ply.4;
        Tue, 23 Apr 2019 17:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u+YkNJXUH195AbLZVr2IK4q1fxv4Pwzn3yATf1qSgdE=;
        b=uAbX+O0NBV6Z8+Wl/P2srWv9yBo56rmsOyJ1k3ZwjDiKU0j3LkfFadDx6mvhKoSmRk
         LHXuT1eo8xTeGawnsdGKrEqQF8gU8Xi0POJ7tES7cE2Kvueke3Jjy9iilpyi4B5iMoRc
         vXH9FfYAXLc3GwUDQTLCUvXQCMpsVy9qlv06j8pnOayTWUFr7ZsN+fmLsMzf0J+TpnYb
         trJa8gzXO+nSH7QyQUWXbcmr01AuADjSssOWv2ab4O1Yf1fowxpJWIxco5V1Oc5Dfocv
         WCLbLzdVKVx2ZuKGf0xPPM0W8jCCzhM/24j4hyZgVNPlMjRDKApJvg+3tB8gjXxVwfly
         f67g==
X-Gm-Message-State: APjAAAWAyxd0lui3ZQU/qM4r3pm2ybDQ1HCTr2t6hsRQjU5uftQ8nMPM
        5jF031Uvj0hCz2pJ9CCQCZ8=
X-Google-Smtp-Source: APXvYqzH0TJahx3G25QTHrpT7CirvmVa96+uIEUmVk2f0ev6a1QsXlWLIZYTYKkd8mdZRIY/nspAuQ==
X-Received: by 2002:a17:902:a9c7:: with SMTP id b7mr28826817plr.145.1556065317294;
        Tue, 23 Apr 2019 17:21:57 -0700 (PDT)
Received: from localhost ([2601:647:4700:2953:e96c:d7df:9526:1357])
        by smtp.gmail.com with ESMTPSA id a17sm30480851pfj.123.2019.04.23.17.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 17:21:56 -0700 (PDT)
Date:   Tue, 23 Apr 2019 17:21:55 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH] fpga: stratix10-soc: fix use-after-free on s10_init()
Message-ID: <20190424002155.GA15154@archbook>
References: <1556062325-26141-1-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556062325-26141-1-git-send-email-wen.yang99@zte.com.cn>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wen,

On Wed, Apr 24, 2019 at 07:32:05AM +0800, Wen Yang wrote:
> The refcount of fw_np has already been decreased by of_find_matching_node()
> so it shouldn't be used anymore.
> This patch adds an of_node_get() before of_find_matching_node() to avoid
> the use-after-free problem.
> 
> Fixes: e7eef1d7633a ("fpga: add intel stratix10 soc fpga manager driver")
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Alan Tull <atull@kernel.org>
> Cc: Moritz Fischer <mdf@kernel.org>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: linux-fpga@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/stratix10-soc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 13851b3..215d337 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -507,12 +507,16 @@ static int __init s10_init(void)
>  	if (!fw_np)
>  		return -ENODEV;
>  
> +	of_node_get(fw_np);
>  	np = of_find_matching_node(fw_np, s10_of_match);
> -	if (!np)
> +	if (!np) {
> +		of_node_put(fw_np);
>  		return -ENODEV;
> +	}
>  
>  	of_node_put(np);
>  	ret = of_platform_populate(fw_np, s10_of_match, NULL, NULL);
> +	of_node_put(fw_np);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.9.5
> 

Thanks,
Moritz
