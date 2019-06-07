Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CB7C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBAD208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EZ20ECrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbfFGSFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:05:10 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43933 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729921AbfFGSFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:05:10 -0400
Received: by mail-qt1-f196.google.com with SMTP id z24so3301411qtj.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1u8QA5gDOKeNLVCd2bIEH+QLN4jvjcMRS9RX5LydFVo=;
        b=EZ20ECrHM9ckS09YSKff5zWQ4PQXOp2h3ff9oZ8Yz1H0GRPOYbX/p4Q/p6elbds5Ho
         Dervbbi1ZXm+hC1mme6oG/EF2SslLChrdLL9aaOJTlo04u1OWPPiCRq2t96ZDZQb3dGQ
         nrkDFXm5UKgGSbnkKT80uvxIl+g505IYmvsBgVR7C0R1ntFng+00hvy4Husorjg91trl
         X7Kp3pvDUZNzzG4k3gGGDYPirrVpqz05FrFBoaAsDisDVZXnGMON86CRHcoK/pMy2BHe
         i8paEjz3b+IwtyYXPrQ+g2usQYJgNu2cTPuDsaYgOlbvjU84YljcMISrvLTjp1BfSWeH
         V/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1u8QA5gDOKeNLVCd2bIEH+QLN4jvjcMRS9RX5LydFVo=;
        b=dZ2x5uR2GflmL4kl621roecvUp6Nsm6LWjnk6FJzxtaVwcfTW4+hQmbGhrL7EKQ7AU
         9/zP4qMyTFKFUtkA06q6YIPT+rdq/SZB8HZHGEmyag5GWTNTJBCK1ZE1//Q+IvVozT3m
         /EY2iKTcDgxZ5oIkHibXxer3ueNCzKxHrrnwhGEv1O/nxCs4Z215DdBkZWWj69ZUJ9Sm
         admTU40FSESvJYibUlHPExAxr3GhPw9GKL3KFHNZZk5q7aBnPwPkrv8hIwGCW8z1rb+h
         Zexl8M8F+HQARgpAPGz/Rr9KM4qpdqcDoudvT/Nm28wMEnOhP2do3k30qF5Fo8DFe7Xw
         w1nw==
X-Gm-Message-State: APjAAAW7vnXEREIX+gqhji41ehqwSgC4YxQ6dq7mws7RzftuGw9okFpX
        J8x0bSieBcrlgni5COYztOJAoQ==
X-Google-Smtp-Source: APXvYqwY1xXf3g4oZc2oTXnuhHygmo24ORh16m5jKK1MJW0iJrr9WhUZgH8WbbTfQR24AG1VLpdySA==
X-Received: by 2002:aed:2961:: with SMTP id s88mr46611186qtd.120.1559930709358;
        Fri, 07 Jun 2019 11:05:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id k7sm1167641qth.88.2019.06.07.11.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 11:05:08 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZJEi-0007ai-Gq; Fri, 07 Jun 2019 15:05:08 -0300
Date:   Fri, 7 Jun 2019 15:05:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/ucma: Use struct_size() helper
Message-ID: <20190607180508.GA29136@ziepe.ca>
References: <20190604154222.GA8938@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604154222.GA8938@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 10:42:22AM -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes, in particular in the
> context in which this code is being used.
> 
> So, replace the following form:
> 
> sizeof(*resp) + (i * sizeof(struct ib_path_rec_data))
> 
> with:
> 
> struct_size(resp, path_data, i)
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/infiniband/core/ucma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next, thanks

Jason
