Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3654C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52A92086D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sw7bvDrv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfDLRsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:48:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34044 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfDLRsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:48:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so5557277pgq.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 10:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HKnx1tzlaFZ7SqGC9kBY+iFbHES55PRRHEdN5N68KnA=;
        b=sw7bvDrvkTeb8L4xM7I0mPfoH7cdvD/pJ/Q90NQsHWmDs3tRZTTtBP7QcmRWsCDS3Z
         WP+osa2hcaQ3mtMsN/LSe5sJ1JRfZF2n1EXSV7SArMPp+34em/MQfGdv93vcG11uTd1z
         2yaNQYI6smbXDbq6CAaPbz9XoQ45Twti3r79lUuXcrTLTqXUYChopxukXEBkqmnOQPOM
         oEJgGmANV8Zp+lJEpznDTDzwJ1WpZ3IVDfQM7CGzBsMhgmxXwMz/GVMzk7Un1f1gv9VF
         2jUd0XtsuNYuJJpA0aGDua7yXUKY0VhtF7J1zU+R1VQ9HUDp9Z1wk21HLuViDS0F9ytu
         bIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HKnx1tzlaFZ7SqGC9kBY+iFbHES55PRRHEdN5N68KnA=;
        b=YS40E3D8/UFD5Y3pg8QEnq76Tpm8BAzCxjBSvwlFJJNz47XTvPu433NZVoalMyvus8
         aneEjnmgTFY/RO/98pjSEo7knKGI6BxEg0hEMqOR1dbsrWVbwaUtod8tZyKNJaoV8QSD
         z2J6F+ZTvmRHhChybCNOpUmfUPqHD8KlGThyDmq7wulS8KjjatphTYHgNLWWCqPKcFhG
         826jOeS3IrJlNp8FOnQZkunJbpC8vCVSdFc1ldp2xJiZMvUzVbpZk+8EmO2LqN4/tauR
         FjPEajiR2294MCwxIIcyfnAGvD5qWIMoNxWKWCUXM2n9zpXiLdIU4QXG1d5AJzv79FEt
         JRNw==
X-Gm-Message-State: APjAAAWBeTHkfPnsTY/2DGaGpTfg6YFgoQBoA6Gaps1LpopEfidFnxqO
        mO1Wbepo4lbjBaKDnctTFRbMIg==
X-Google-Smtp-Source: APXvYqxR1qjXyHp447aG5R1oad5ROXf5YTUKZ4TLDNBtjExkjJNFv5yi2R35Doiyjhs60DWl/NaZqA==
X-Received: by 2002:a62:7648:: with SMTP id r69mr38616559pfc.114.1555091301611;
        Fri, 12 Apr 2019 10:48:21 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t64sm94998331pfa.86.2019.04.12.10.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 10:48:20 -0700 (PDT)
Date:   Fri, 12 Apr 2019 10:48:17 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andygro@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update email for Qualcomm SoC maintainer
Message-ID: <20190412174817.GY1843@tuxbook-pro>
References: <1554872204-9026-1-git-send-email-agross@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554872204-9026-1-git-send-email-agross@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09 Apr 21:56 PDT 2019, Andy Gross wrote:

> This patch changes the email for Andy Gross to agross@kernel.org.
> 
> Signed-off-by: Andy Gross <agross@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e17ebf7..cf39fb06 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1984,7 +1984,7 @@ W:	http://www.armlinux.org.uk/
>  S:	Maintained
>  
>  ARM/QUALCOMM SUPPORT
> -M:	Andy Gross <andy.gross@linaro.org>
> +M:	Andy Gross <agross@kernel.org>
>  M:	David Brown <david.brown@linaro.org>
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
> -- 
> 2.7.4
> 
