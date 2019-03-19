Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5905DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03FA42075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Pzk0QqxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfCSTWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 15:22:46 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43320 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfCSTWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 15:22:46 -0400
Received: by mail-oi1-f196.google.com with SMTP id 67so16902017oif.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 12:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QpOCzTu2ICVtHjUFEypqr/tEcKPKIGlSqe0MmxpE9Yg=;
        b=Pzk0QqxM5xbc/a8IC7pU41NatT+aPUeUl3rePDdJK+m7UD3/tB8HFkBLxNXfkt3AAN
         TbnoBuYCiERFJrxLLWciXc88zLXiJnY7yrOgbbx7i9b/dHplqs7Xsz3pS2wlSmyIYpQE
         zriWAJwh+R25ppQ9fMaMyInoKcBpgWpfIAspaSw3Ty3gWpSiFPi4xVP4+6l91TK95blQ
         tTw/qFw3BKf30bnhH7EMHQtEd83Kaw3/QZNBZscXR8LJeHlVc8c0dUK6/y4FonxEaj4e
         EH/Qe/YKs6sCxH+/liVJzSOa+Q04SAizNkfKDkROU28hYcCxlxRkXGlaafGjH4wh/WKS
         J7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QpOCzTu2ICVtHjUFEypqr/tEcKPKIGlSqe0MmxpE9Yg=;
        b=Bv1+iehKfkkChrc2Ey1+DNkrCi8kakgHRL39OwM5Zn5RdW05Himd2ZNovj9j/J/adk
         vu7P9esFmefWo/ePX4HdF2dbOhN2dLH0K0fzW/79rajkfljTTNdrhteHpy4aGf87WsIg
         kofJPYem5KROcMwIcCxvXkfkjo4on/6CoCeaNS9JuJqLHnWALxU3B7c6YssHjVJiz7UQ
         To4Ew3hA7mjLIGuMiaqrnvhgkja1IJvDhXPULUDcJd3dWyb2bAz4bOks6osgyyUxpF8b
         kdsisLiNpgaQiA33GC+NRh5+YiMdRXcF8ED+6jqxLk/ZjO/HxFdZ/IboG9st7niotVuw
         HTsg==
X-Gm-Message-State: APjAAAUo708Trl2GMIfUpE0lQQZvyTf/y42nSaazKZ0VIMZ1X/3QksyA
        xwWRqcpZsHoj/n6iBri4O9U39Q==
X-Google-Smtp-Source: APXvYqzgbHmdlYs+kBrRHpGuP7/ST9wj2DrM/keeIu/kARVmD3cjJb3V4lbYhSxLlV5BPvvDBpcXRQ==
X-Received: by 2002:aca:efd4:: with SMTP id n203mr2554789oih.7.1553023364763;
        Tue, 19 Mar 2019 12:22:44 -0700 (PDT)
Received: from ziepe.ca (ip-198-214-84-236.utguest.org. [198.214.84.236])
        by smtp.gmail.com with ESMTPSA id b130sm5678846oif.54.2019.03.19.12.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 12:22:43 -0700 (PDT)
Received: from jgg by LT-JGG-7470.mtl.com with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1h6KJv-0000zA-4H; Tue, 19 Mar 2019 16:22:43 -0300
Date:   Tue, 19 Mar 2019 16:22:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jeff Xie <chongguiguzi@gmail.com>
Cc:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com,
        dledford@redhat.com, nux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband:qplib_fp:move spin_lock_bh to spin_lock in
 tasklet
Message-ID: <20190319192242.GA3773@ziepe.ca>
References: <1553013397-29263-1-git-send-email-chongguiguzi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553013397-29263-1-git-send-email-chongguiguzi@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 12:36:37AM +0800, Jeff Xie wrote:
> It is unnecessary to call spin_lock_bh in a tasklet.
> 
> Signed-off-by: Jeff Xie <chongguiguzi@gmail.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I'm curious, how did you prove this was always in a tasklet?

Jason
