Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57329C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0DF2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oC/bR3dP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfH0Pwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:52:41 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42797 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfH0Pwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:52:41 -0400
Received: by mail-qk1-f193.google.com with SMTP id 201so17388840qkm.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 08:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6lrUQjg09W/CYM9ClcXNjxE0QVh6IyAkViPvOSjzfzA=;
        b=oC/bR3dP+V6QA0ryrp2Q5gukrhxwTxWGqUa4c5vEsZoDDuMZE8u8XWgvaANi6aYmn5
         kOFVUPTtT65NdqiMlddOfAw1S02Saa7YodAHtYo3Hz8tbcKNV8NM6MtZOTaj105pdrSy
         e8fr0I+zgUjP37DiaflDF+RtDPJebz++manAmhh2//MT/GoNGSUiRpNiAW4S/E7wzNWq
         s9/30/jHgFtPrWaEwp0nC3T3hsfW6MgmYVZ/Y+gJLeiIn/cuovL2AGwa/qtwY+E19NJ+
         SORxM5ivQHxJxUcpSWTb7HbkxRlFbqK7GTDiVZej+yqeIPZG7fmwfpQhehfEzdbvjm9R
         0cKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6lrUQjg09W/CYM9ClcXNjxE0QVh6IyAkViPvOSjzfzA=;
        b=f4ADPv/ssmPvvrXbsBDAN0QXz1faI+RvGLOTbbcfZSOEHRCPFST/wFkxobUciP6G4E
         fxTgMc2gC3Gj0+dUyroQqhWcUkt8DDhs9MQrxwgjfesdFhxG5pb4KMLgakSh632CuygF
         1uZQrPAf1xKvJ35pLxds7CNjb2ptKAbfBkh1HsfXp7IFiONjfjeC2rGe1jcyFDzFzDXH
         /SU+PFyvU+cRahM1dlIFoH6tOBPZVQpyspBVIcsNoH+3ydRgLP7Rw/LWYQx2CcGeYS8G
         iP541U1iKH5cyJqLm5aK7vjZxyLhxstPus29P/ulMi1WqdH9WZTDR/tZlFrhlqmBeCdx
         aZUA==
X-Gm-Message-State: APjAAAXZxOHLmJRp5IkUyT9ickJfDsAnCP47JYmgX7wLR4VVgYpw3qYM
        wVdgYQENDp+0GzWSwTKak0PmRw==
X-Google-Smtp-Source: APXvYqyUG6WklpHvBbsoklMcXBZJhAec8BZF3MrQ5LSq8fMd8YxJID2nO0xhjXKRoobutfRjmk8IYQ==
X-Received: by 2002:a37:8381:: with SMTP id f123mr21349287qkd.316.1566921160105;
        Tue, 27 Aug 2019 08:52:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id x68sm8700999qkc.16.2019.08.27.08.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 08:52:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i2dlv-0003zK-93; Tue, 27 Aug 2019 12:52:39 -0300
Date:   Tue, 27 Aug 2019 12:52:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     leon@kernel.org, dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: Merge two enums into a single one
Message-ID: <20190827155239.GA15262@ziepe.ca>
References: <1566665546-8209-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566665546-8209-1-git-send-email-jrdr.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2019 at 10:22:26PM +0530, Souptick Joarder wrote:
> These two enums can be merged into a single one wihtout effecting
> their caller if those were created without intension.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>  include/uapi/rdma/mlx5-abi.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/include/uapi/rdma/mlx5-abi.h b/include/uapi/rdma/mlx5-abi.h
> index 624f5b53..c89363a 100644
> +++ b/include/uapi/rdma/mlx5-abi.h
> @@ -461,13 +461,10 @@ enum mlx5_ib_mmap_cmd {
>  	MLX5_IB_MMAP_DEVICE_MEM                 = 8,
>  };
>  
> -enum {
> -	MLX5_IB_CLOCK_INFO_KERNEL_UPDATING = 1,
> -};
> -
>  /* Bit indexes for the mlx5_alloc_ucontext_resp.clock_info_versions bitmap */
>  enum {
>  	MLX5_IB_CLOCK_INFO_V1              = 0,
> +	MLX5_IB_CLOCK_INFO_KERNEL_UPDATING = 1,
>  };

The enums are used in different contexts, I don't think this is an
improvement

Jason
