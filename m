Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F63CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6443920659
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OPLLBr/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390018AbfJ1ORh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:17:37 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38388 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730033AbfJ1ORg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:17:36 -0400
Received: by mail-qk1-f194.google.com with SMTP id e2so41292qkn.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 07:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KcIXjOVnUdM4ahq3ItI2UTdzBoJ7szBep3RUJgsKNMg=;
        b=OPLLBr/YxqYbXp/yOBTapSj2Gj52cx4piu3vrs1Y/lc0X7F4kDzY+M4E2vhAKVGS6S
         /WrEccktrTLtpBkA2Pd2cXzjV3ulDJGMapESqu2bf6khkLCKMUlxJvMGiR+LQIAYsPYN
         kp+yo6uK0Xe1gswA3folr0aaWwLUJpwYuG9eoQS1VjxjiFr1tRIh3wFhF5oCwRNvoA4D
         dWYpKDG5VDo7JYx0YoiHOYS6q+uCbacxgtrU9TrBkcDblok81ZW14aBlabgJ8HzisBq7
         9NaGzXpwpOvMjz+vTEETSwSHuHyThBgeEu1jv6D7GayHPkIiWvEnUTaVnJ8sA55GBgsa
         NOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KcIXjOVnUdM4ahq3ItI2UTdzBoJ7szBep3RUJgsKNMg=;
        b=kXMmnF8rfPiHDo1VljIDpki0sLbnJPv1k6qj8a03PyHQGFTLUMVjahW2j+1P8LSD3M
         c/pgRWYq27IA9/K7vdKYhV5WhTf5q49jUVdycFp0VjYGaET2cs26JW0snn+FI9O81WmT
         ObMrcDbpOVr0h1uTfHJgEXct68MH6VjgM/Qic/rucw1YowhlcpU2OQztMJOH2olRhsWD
         KmEeec2JuWQvqWfkaxQIVcV+VfZFyLP7Lgp/ICeFRwo5nDmW9WQbgw9xwGKKZCkqKsyL
         fup9NDdD5sBGQhAybhH2jPcLKXPCqNxPIx4kVcGTD1ACvc1cLWuX7XJeHrb6Vqo4sg2f
         jwxw==
X-Gm-Message-State: APjAAAVU28Ic1Gofot/23p/ifqFh0LCj7i0twtibbweYRF1n73aan0BF
        0OWWxypbfLJpoxUALP7UgWOlNQ==
X-Google-Smtp-Source: APXvYqxPWlwKd2Yhb6oeWw72tYoVkd9/4Iarg072Uy8QgkHXf/D8iZoBb9zg6tf4GlXMLlA2KYnF4g==
X-Received: by 2002:a37:9b50:: with SMTP id d77mr16266180qke.349.1572272255692;
        Mon, 28 Oct 2019 07:17:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id f11sm5243892qkk.76.2019.10.28.07.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 07:17:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP5pu-0002Me-Jm; Mon, 28 Oct 2019 11:17:34 -0300
Date:   Mon, 28 Oct 2019 11:17:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ming Lei <ming.lei@redhat.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scatterlist: Speed up for_each_sg() loop macro
Message-ID: <20191028141734.GD29652@ziepe.ca>
References: <20191025213359.7538-1-sultan@kerneltoast.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025213359.7538-1-sultan@kerneltoast.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 02:33:58PM -0700, Sultan Alsawaf wrote:
> 
> Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
>  include/linux/scatterlist.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 556ec1ea2574..73f7fd6702d7 100644
> +++ b/include/linux/scatterlist.h
> @@ -146,7 +146,10 @@ static inline void sg_set_buf(struct scatterlist *sg, const void *buf,
>   * Loop over each sg element, following the pointer to a new list if necessary
>   */
>  #define for_each_sg(sglist, sg, nr, __i)	\
> -	for (__i = 0, sg = (sglist); __i < (nr); __i++, sg = sg_next(sg))
> +	for (__i = 0, sg = (sglist); __i < (nr);		\
> +	     likely(++__i % (SG_MAX_SINGLE_ALLOC - 1) ||	\
> +		    (__i + 1) >= (nr)) ? sg++ :			\
> +		    (sg = sg_chain_ptr(sg + 1)))

This is a big change in the algorithm, why are you sure it is OK?

Did you compare with just inlining sg_net?

Jason
