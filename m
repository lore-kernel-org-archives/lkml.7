Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ECEC282E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A540920656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YQdEZys6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfDVI1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:27:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36344 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfDVI1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 04:27:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck15so5498778plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 01:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4XvCMF0UP4cOVAyeNW8diOpkjGfJffibt2Vb31D8xuM=;
        b=YQdEZys63aWPr/FjBO8AIjy9OMJRWWs6slc+Ga3T4hhfiFyK6UjJ+fiRtYBhmxxSht
         i6+3cKiq7MnAJU+PfbRLXy3Qrr1cFfX5/imMpeWCSDHer4eOVp4Dm1JhDXqJh8iVmIoE
         SDFiCe8DY3evJEHT14xbsh6/Lg0mPHWw3iIhVVvXZ6E570FcnrIOR+rxV0vAs9LvSh4A
         5h/QYUTfjqscoL0TuffciRAr1w3dne5WAgGF5IaokXOggcMmqKOwbKkORM9+n7r3X2lp
         W0dpceTm/bvF0nDS98nKN2iyxIr+MYIWZY9BHzuGLumJOCZwl6K5OjNOhrmq/NEFi0wz
         DGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4XvCMF0UP4cOVAyeNW8diOpkjGfJffibt2Vb31D8xuM=;
        b=EaJ7IY6dDcgfPGFFp3ePH9/TnwHnJYL1eIoIqUV71E4xlxxeB87MCjx3Zu1d7aZIEs
         KPhdZ+s8XHnld8YdT1pYn7265+GmnLSER17U07G9zFt861IZew6HhUTl488Zk/IaPE/K
         x55bFAcD0kTDVpxXXP2J7Pw2VDyEnX0gpa8cTGsvSX542Wsd4d3hiZGxKGNDNBNTjYxD
         RW9rNEW4sjQfylY6ndbNsU0UyUeJmfm2T8/azoYY3SSTDJw39D30U7+WLtG3MeZQ/GYB
         dyRbbzhLUcHSC4zkZbhhpgf+wKjNQWW660A3IcXVr8iuaPePFIK4GDKs1xSD/wqFcaCX
         himw==
X-Gm-Message-State: APjAAAUqfPKqDHctJCi7LQMwXs8LmvdLfJPGuVU7J8HsAkfYU4EWR9iF
        ooZ7ZJ9H9zCADju9L+Nrpg9ctg==
X-Google-Smtp-Source: APXvYqysC+/1QM/K0fRkySTZQ9bgOnX344+3NACrhoQDLycitgt2vtZwTNsMRWkljqNL42VF+ZPrWg==
X-Received: by 2002:a17:902:e610:: with SMTP id cm16mr16662286plb.189.1555921673595;
        Mon, 22 Apr 2019 01:27:53 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id b7sm20940013pfj.67.2019.04.22.01.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 01:27:52 -0700 (PDT)
Date:   Mon, 22 Apr 2019 13:57:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] PM / Domains: Don't kfree() the virtual device in
 the error path
Message-ID: <20190422082750.vha36l3pgwkpfnn5@vireshk-i7>
References: <20190418102757.1246-1-ulf.hansson@linaro.org>
 <20190418102757.1246-2-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418102757.1246-2-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-04-19, 12:27, Ulf Hansson wrote:
> It's not correct to call kfree(dev) when device_register(dev) has failed.
> Fix this by calling put_device(dev) instead.
> 
> Fixes: 3c095f32a92b ("PM / Domains: Add support for multi PM domains per device to genpd")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index ecac03dcc9b2..7fec69aebf46 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2528,7 +2528,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>  
>  	ret = device_register(virt_dev);
>  	if (ret) {
> -		kfree(virt_dev);
> +		put_device(virt_dev);
>  		return ERR_PTR(ret);
>  	}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
