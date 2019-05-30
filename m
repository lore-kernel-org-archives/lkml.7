Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D84BC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F9925FCD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZirqxKHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfE3SnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 14:43:04 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42704 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfE3SnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 14:43:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id s15so8217319qtk.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VBqnOCwAufhv1CAkJNFrNgoB3p+UUmETtTsgShdBDzI=;
        b=ZirqxKHDbcQyX/wT2VcnFrxa+MadSKmLIeFPmm2qePE5jPeAY/tkaSbtoTcSPBLUw1
         XQonZZ052/RP/N5oXy86+rOYc2mKXcVbAy9HK6QsppaNYGas1F5w2UMmkGazwJ6z3UiL
         OiW0BCXPfNlvKpvkIVdU4Qb92nnZ5gd/Xva4mPHOzx0Iv650aNoU21Pzv7wKxI6D5GVc
         cTSE7p1jhfP0K+fwDT397eJl0KfLMh5YA7b+axJ0DknCvs/c9/TqohpHrU3+jhLCXKZE
         69LjcttrxDXLYnTfItzQsUAyLFzkktCWrORihZZXgdks18qJv6JXx6ey8m7K18UQs+jy
         nOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VBqnOCwAufhv1CAkJNFrNgoB3p+UUmETtTsgShdBDzI=;
        b=VwXWjLA83EN7FFsNunT5z/ugmPgHLyAGDVpqnkYda7gUIsGEqOI16uVXCYxF9tIrIx
         W3Eaa9vjD3PxXB10gHwf8MxZyj0bYGVZNAA0PIjuAO41R2YllWO9MIBbvVu41X/PklNY
         p1M7V1S1AON4BUeY7IEVpBLNaCgLKqqgDkflyZDGR+p6xB5oPYXjasY9JkYG6ie0Wbh4
         5rpvt9VfbOzFp/wWtAVWjYsdVrL1GXOUjHIrl03FJ9EoLnPWhbDPZNgmdqBKKfECECUV
         CpMjObg2uWY5FhuJDNLyHVvVILWDl7tK1mZD972uMus71R/R5AVa/ElYQVGBjwsJsLix
         o0cw==
X-Gm-Message-State: APjAAAWMxdd5E7w5TjwETmJsd422nrrXbCBHFXDL/u+qQ1NcyoEMP50b
        +GbNlHI0+HKtkAW7EWLMk8WOWA==
X-Google-Smtp-Source: APXvYqwPw3ZZtX5hJ8gOZ8HYrYQCfzjrvzRdC+YXqEmilsw9jjKKngQZluuntDNPMp/bLHSIhiaPrw==
X-Received: by 2002:ac8:2291:: with SMTP id f17mr4973765qta.51.1559241783221;
        Thu, 30 May 2019 11:43:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id v186sm2093104qkc.36.2019.05.30.11.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 11:43:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hWQ10-0007jq-6J; Thu, 30 May 2019 15:43:02 -0300
Date:   Thu, 30 May 2019 15:43:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] IB/rdmavt: Use struct_size() helper
Message-ID: <20190530184302.GA29724@ziepe.ca>
References: <20190529151248.GA24080@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529151248.GA24080@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 10:12:48AM -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes, in particular in the
> context in which this code is being used.
> 
> So, replace the following form:
> 
> sizeof(struct rvt_sge) * init_attr->cap.max_send_sge + sizeof(struct rvt_swqe)
> 
> with:
> 
> struct_size(swq, sg_list, init_attr->cap.max_send_sge)
> 
> and so on...
> 
> Also, notice that variable size is unnecessary, hence it is removed.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
>  drivers/infiniband/sw/rdmavt/qp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied to for-next, thanks

Jason
