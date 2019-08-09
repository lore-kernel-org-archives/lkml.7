Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB257C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA37214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565380313;
	bh=iQmjrc8icRNlm8zTtoeKKOtyh+t4mqH3IgTzrEM81vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PbGep53yBpz0GVTNPQ/vvsAzFNejldFkW+MvB8wQYRAXcYtct8lpaZbAwvyAp22XY
	 UKvhFv6rWewf9/LGSDzT5bqqtthgeEJaskR7TkmJCpoHq0LwZgOf3AiaSDnZTyqNDN
	 rN0D94X1Zwob9SK2WPcvUXV5HK5a9f+VODm2Hu0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfHITvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 15:51:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46148 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfHITvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 15:51:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so45333967plz.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 12:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UTaxKlCQs2rMVT6dmaq6PY1yYeN42Xa3IY6ykXZ99rU=;
        b=X5jbCbSt7LWdP+qRf6NRaovZM+xTLresTbLwJFTU/UKWOf+c2rHZ4iMP7HANLtNGB9
         DJCH89i9Zootjgx+LcTuCQ4a9BFpSFdRNBISBu98SLZmt/xs9IWda8IG5B5RgzqK0pau
         Qvn0d98h/1x/OkiK/DawjQFfHT19CXwlahxOvDcUzCWaT5qaUXVMdzXHGl8AJrswL5wu
         VXe3CTxgmobItKcJvk0u0L/biSUSf26jRprng6edIxolwJKciXI/Ck/dqQZWiXEjyq4N
         EvBOh9HPVStSbSsnn0P7Kk3ksSOuPyqD/zEDlub51H7Axaw6F5tM49lh8VNJzoyhNRoj
         RPog==
X-Gm-Message-State: APjAAAW7p4bRCNikLUZ93M0FgXn2AJ54x7uXyXu5u4jz6IcH0bZObsAd
        svgIH2M7s/9M5Bgn69Cm/ZGiQg==
X-Google-Smtp-Source: APXvYqwJIsjHm9/3r8AONPEu+5ScceQ+yC2jFmx3vHPuhwPESekE53KUkPxX83lynaQO8jTUwealAA==
X-Received: by 2002:a17:902:968c:: with SMTP id n12mr21482416plp.59.1565380311248;
        Fri, 09 Aug 2019 12:51:51 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id a15sm137192004pfg.102.2019.08.09.12.51.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 12:51:50 -0700 (PDT)
Date:   Fri, 9 Aug 2019 12:51:49 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        atull@kernel.org
Subject: Re: [PATCH v4 08/12] fpga: dfl: make uinit callback optional
Message-ID: <20190809195149.GA2788@archbox>
References: <1564914022-3710-1-git-send-email-hao.wu@intel.com>
 <1564914022-3710-9-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564914022-3710-9-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2019 at 06:20:18PM +0800, Wu Hao wrote:
> This patch makes uinit callback of sub features optional. With
> this change, people don't need to prepare any empty uinit callback.
> 
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/dfl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 87eaef6..c0512af 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -259,7 +259,8 @@ void dfl_fpga_dev_feature_uinit(struct platform_device *pdev)
>  
>  	dfl_fpga_dev_for_each_feature(pdata, feature)
>  		if (feature->ops) {
> -			feature->ops->uinit(pdev, feature);
> +			if (feature->ops->uinit)
> +				feature->ops->uinit(pdev, feature);
>  			feature->ops = NULL;
>  		}
>  }
> -- 
> 1.8.3.1
> 
