Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CC7C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBA420708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZPNwk6af"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKVU1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:27:01 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33333 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfKVU1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 15:27:00 -0500
Received: by mail-qt1-f196.google.com with SMTP id y39so9307737qty.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 12:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TuEJSat07gB1IHltKZEvc+y9sVWtpqAObc38RVhlHg0=;
        b=ZPNwk6afKIW5LdcIqrEVpFENUsOBQjX7BOurhZoa9oUBIsHu1KKcmUKaWCot2Q+48Z
         SGX4FOcognZAAp7qk1OyjjPiiR3ZS9bJzC6+k4M09o9xN5OPVPdFnHs4uD0+aCHzdvUl
         n2ZkL3ip5FLLzoLFnrg3S+wkYJtn5JMasBIkeM6Tfob2uKznZ0Y86d77OqQaTrrLwvt1
         EZX2qVp5UVqdXnJSPUN403GQBGujUnFUfKr7+GkQvDXRgp6HLpyY+1xunABdnLI/Snyy
         xDy5l78e0J7pDTy8SMlNua2a0swLp4IC6UpLZjUIHtQL35Vb0VFRQ59cCnNECJCTAEoA
         Mp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TuEJSat07gB1IHltKZEvc+y9sVWtpqAObc38RVhlHg0=;
        b=dKAsFjAh8ksUj3JqJt7JPT/1PPSjwTBaC6A4/dndzuyBTmc767Y1IWbXk+4eYkF1wR
         7bDKS5u5sAYoZAT9tXJjuXHMxIlRBUhXpI+moR+ZaPE2C4bLizlOEqcYOKJ3oAwiXToi
         jW9mFo5nNg7meTL1ObImeeDSNU7zi/IfoWJgP4HZuQbYJJHfPYR4XFWsfagfrpd4VFkd
         KuFB4vizM8gJ7TXzgqaZlth/7ykAdbzSlCtf4PMMBUOOQc90FdkUm8VQnGNNIf44r4R+
         4UFOFWY3e0uRXqt0g7t80aA13q6VZDYfUlWO10BhPlFiMu8yxGPqP9aYe1+k42gxNwwW
         dq8g==
X-Gm-Message-State: APjAAAVTAjTN3Z4rXeRRDuDoIZN5ilOeqfUbgUpPlVd0ww42TarhZvAV
        aAecEEZl6UHIjsKfkW3O1ByHRw==
X-Google-Smtp-Source: APXvYqzkWEbBdtWdJtN3F5QnaVFyACvDHG6QXr8Rgqs/FHE1QO0QMaRfW07+SVgpG840pdDY+8eSjg==
X-Received: by 2002:ac8:2432:: with SMTP id c47mr16453020qtc.74.1574454419946;
        Fri, 22 Nov 2019 12:26:59 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id r48sm4048719qte.49.2019.11.22.12.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Nov 2019 12:26:59 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iYFW6-0002OB-U5; Fri, 22 Nov 2019 16:26:58 -0400
Date:   Fri, 22 Nov 2019 16:26:58 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/hfi1: remove redundant assignment to variable ret
Message-ID: <20191122202658.GA9162@ziepe.ca>
References: <20191122154814.87257-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122154814.87257-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 03:48:14PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable ret is being initialized with a value that is never
> read and it is being updated later with a new value. The
> initialization is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
>  drivers/infiniband/hw/hfi1/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
