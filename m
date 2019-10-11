Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692B6ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401AD206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OGEl8+OX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfJKSjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 14:39:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42818 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbfJKSjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 14:39:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id q12so6575115pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 11:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lwWZ1BSEiAs6avMUbGhrgTIvNodesvQRhyRgPzlrHsQ=;
        b=OGEl8+OXDAIs8vJC1UB0yr5NA4I9xd/0/Uc6k8efasx0S90iUqOOdUJdjiaZTNQpOk
         Z4otOBVHj6ZB05PknrEdkOUDQxIcBdkg8SmYUgX2VLIZRoQcLurAoIfkExCBhrLpQfFP
         F/Jzv71PvpMamtM0I7nx5+Cnx7DYmvotb5y9Lr4Byh4tw8+EboCI20DKJ+S/qLoD/ecM
         OTpcvvP592CAKBkzScEvOnTQ80jr7eHK4NMyGOv4bcrzWrfnqTvoxxBnWZxGLYFknbOD
         BM+R72yblf+mENBnsN0hapKq7yaOlVO4gE5HRSmvLWN2wdKwot/kz3MAYteXNZyn6/MR
         djVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lwWZ1BSEiAs6avMUbGhrgTIvNodesvQRhyRgPzlrHsQ=;
        b=pX0DvJZxWG6hyfB2lmcYSmGfhDp+E9Hzbyb8w/q1BKxsFVoIz239FYqf3o4FVVZ5zB
         tgcFMB0f2BCCXEDwyBsd4oqUhCh+DzqcV/txillzvBo+0iia4+rgn3JP6IkINWjmhGrf
         R3NhXYhsuD+0E73WuEAIV1sk73Db6rgi/vkqomOaaWxhcRGkojSGZqGK3DbAshxNKwxs
         VXkGCoG7gwfmw0i2a61VqrooukIVrP+UIHW9J6CXmNpOUQrv7Kwo0NnKuEaCEvHFHADr
         /C4hAwHnzY3nkm9qHeY1vWi6AvknjE/wjDERC47+aUGkwUOQWEHFnkmuw0d+oERprraa
         vpNQ==
X-Gm-Message-State: APjAAAXyt8K4F8+Bzg6bAEN3luX5QF0MMe/Gvz1YBPPJRI2QwcYiuwI2
        koReaG+GCZsJp/w1cZLpSQDYaQ==
X-Google-Smtp-Source: APXvYqyWDMUhtm6lJueqy/HUEdKliXxg7NyE8TkTIUdm5qMsSZ5p7RDl7MDX95I1LPZLE3rI7eaq/w==
X-Received: by 2002:a63:77cc:: with SMTP id s195mr5854243pgc.147.1570819182473;
        Fri, 11 Oct 2019 11:39:42 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c62sm13279165pfa.92.2019.10.11.11.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 11:39:41 -0700 (PDT)
Date:   Fri, 11 Oct 2019 11:39:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Chris Lew <clew@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        aneela@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rpmsg: glink: Set tail pointer to 0 at end of FIFO
Message-ID: <20191011183939.GA30457@tuxbook-pro>
References: <1530148797-31904-1-git-send-email-clew@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530148797-31904-1-git-send-email-clew@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27 Jun 18:19 PDT 2018, Chris Lew wrote:

> When wrapping around the FIFO, the remote expects the tail pointer to
> be reset to 0 on the edge case where the tail equals the FIFO length.
> 

Applied

Thanks,
Bjorn

> Signed-off-by: Chris Lew <clew@codeaurora.org>
> ---
>  drivers/rpmsg/qcom_glink_smem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
> index 2b5cf2790954..7a276be598d6 100644
> --- a/drivers/rpmsg/qcom_glink_smem.c
> +++ b/drivers/rpmsg/qcom_glink_smem.c
> @@ -109,7 +109,7 @@ static void glink_smem_rx_advance(struct qcom_glink_pipe *np,
>  	tail = le32_to_cpu(*pipe->tail);
>  
>  	tail += count;
> -	if (tail > pipe->native.length)
> +	if (tail >= pipe->native.length)
>  		tail -= pipe->native.length;
>  
>  	*pipe->tail = cpu_to_le32(tail);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
