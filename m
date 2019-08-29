Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A9FC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1613A22CEA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MFWmCdLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfH2TJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:09:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32879 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbfH2TJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:09:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id n190so2102494pgn.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 12:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=REnHj/EWqJBFRPAqiny/Na+szdlJ2JK7cCM/8YDJ4Wc=;
        b=MFWmCdLF+LwePY3Zth/JgwrB6iisib3W48GnTPFjr8rFBaiyaqlfqL664fwmmfrMar
         UjFDKUDVtYc9Tr0x9PYJn2DlKlWeWu6qcpMz8QfbdRPiJEBOfRzfY/B3ZJZ9MYDQIj36
         RTx5Lyz26OhXT2oFBeTNM5LY0x/fcQfTZAi+rAb8tCAZW9eVBsfO051/OHO1zCd2at80
         qPgMx3f2IaNBnxbsmxOPBGlADw6HDFRWRc00Nzfuk282+DJqcGd43P/ImMY2A73C5ptP
         XPn/JoznaW+iw/z2UK4e2QC4Ph6BTxsrocfXtiBrorLxkW4nc8vZo55adXGSuXCAc8h9
         0vVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=REnHj/EWqJBFRPAqiny/Na+szdlJ2JK7cCM/8YDJ4Wc=;
        b=B5m5O2gIGexgbMuICeMFfkZEthar97j5tt/D3InNpwFOzed15c+Ll7R+CqvB4fIRXj
         AJZqMo12snXsQS82Mz0nutFb85O8Y8y2fexMgKBGcx4zRvP2xTr0dflZiPigUZhvARNd
         HEkpD3houfvTz9L7Zqp8i1QhsePRDWrdLda1L7+RrfbVPtKrMu3Qpiw16FLlvIV7es+c
         /OR63z6if1QV46TuNKH/D7Fn+mUNA5qGLhSBBlPYoEKYqmraidCWvAAUGwUuPPShGr/3
         LRjCgidMMZWWi+8v21n7yk3+qiTSihQ0B8ADqQPtj88RG1LCedbcNcSAgVXR0bnWv+Cx
         XLIg==
X-Gm-Message-State: APjAAAU1ibdyeHhoWZTcoRlWZnSdrr9RtL+cYps507re0be+VGhbSsCD
        VvBgQDoMKEvjNOgFJoJpTQuMPg==
X-Google-Smtp-Source: APXvYqxOlXUr8Ltf38dWyE0JRNEtXL3FY/R3/1FGtaqR11AgbcZU9BVM8q2BE+w45XKeozEms02+XA==
X-Received: by 2002:a17:90a:f011:: with SMTP id bt17mr11500065pjb.21.1567105797871;
        Thu, 29 Aug 2019 12:09:57 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b24sm2710244pgw.66.2019.08.29.12.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 12:09:57 -0700 (PDT)
Date:   Thu, 29 Aug 2019 12:09:55 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rpmsg: glink: Use struct_size() helper
Message-ID: <20190829190955.GP6167@minitux>
References: <20190829181721.GA22554@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829181721.GA22554@embeddedor>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 29 Aug 11:17 PDT 2019, Gustavo A. R. Silva wrote:

> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct {
> 	...
> 	struct intent_pair intents[];
> } __packed * msg;
> 
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> So, replace the following form:
> 
> sizeof(*msg) + sizeof(struct intent_pair) * count
> 
> with:
> 
> struct_size(msg, intents, count)
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thanks!

> ---
>  drivers/rpmsg/qcom_glink_native.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index f46c787733e8..621f1afd4d6b 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -892,7 +892,7 @@ static void qcom_glink_handle_intent(struct qcom_glink *glink,
>  		struct intent_pair intents[];
>  	} __packed * msg;
>  
> -	const size_t msglen = sizeof(*msg) + sizeof(struct intent_pair) * count;
> +	const size_t msglen = struct_size(msg, intents, count);
>  	int ret;
>  	int i;
>  	unsigned long flags;
> -- 
> 2.23.0
> 
