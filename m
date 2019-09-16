Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B812FC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838C9214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="L/2doCf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388272AbfIPOAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 10:00:51 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36258 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388202AbfIPOAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 10:00:51 -0400
Received: by mail-qk1-f194.google.com with SMTP id s18so43878qkj.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 07:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0fqYDlxr0N5uVIkkaGGnEEYiGH2WIRzI/5NcWh0y3w0=;
        b=L/2doCf0astVHUJLnwTi6wtOwayW2zOox9g4ymEojf7QWssFRtvD/Pw/LXP/pHMM2a
         qi/IK76Z5NEMGbVOzfUcNqoF8tVBFEvKvfzeKYudMEGqpk4uSUzWVMDIW6pR0T4Lqgpw
         z73SeLDbtyzQ9QGMR8sc3NkLGN8TJI4KC++oOAZ2TGe5SfZDujfncgWD2Ws6mmaYDvfB
         fBzuuOK+v+thMVPpcFsCxyJhcJdguY+le2GxBggAaYLYl2o867oHKsXW58UbuVXGNysf
         1SgO8V2745rN/m2MgyGeDlq57bHlNu49Yciww4zaGDUW4aGuVYJ1Bw2NGA1LL2Ft8huJ
         u4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0fqYDlxr0N5uVIkkaGGnEEYiGH2WIRzI/5NcWh0y3w0=;
        b=RSZL1fJFzB3+N5Lwtj8VufqH8wZKM++OI+EV1E46lTRv6ClX8PvayYrUewCQ3yJ+Cv
         ueCLqG00N0hBqzMzAvc/VAC/PqwM1nmSJ25/9c0s2Eo4aSGdPQvylIE1lo3PVZ60MMfB
         RQZ8nbdMpBkstk1nqt69yuBbMUnUVkMwXkk1y2UJlsYwdhE13IpgW+dFYpF7EQmd5aus
         mgCtuID7a9UYtICzZWIjrE5eNNY4BvJZPYBz4AUjbsIUNAm6EbEC0ALJBjvC4OEGsy1l
         pYOjoMzZHhiadxbsKklye9lL2j8M6b5W5m2MUBInUmTk/AeXIXwSH+1melLo3rafILG+
         JeHQ==
X-Gm-Message-State: APjAAAW7rfJip4W+uOAWSr3+OZJQb4Q5E3yAVVw5ufPSlu9/LmiQXW9K
        cF0doqjVexN1ytu4e6Xidth50A==
X-Google-Smtp-Source: APXvYqxxB3zBTqNVBTFNdr7OQD6ICS1BkiBLFKIZmh86Es3HLPuJb96ZUnqJM48IjKPlU5hha4ShGg==
X-Received: by 2002:a37:a3d0:: with SMTP id m199mr51483qke.492.1568642448678;
        Mon, 16 Sep 2019 07:00:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-223-10.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.223.10])
        by smtp.gmail.com with ESMTPSA id b130sm18702024qkc.100.2019.09.16.07.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Sep 2019 07:00:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i9rYd-0001b8-Kn; Mon, 16 Sep 2019 11:00:47 -0300
Date:   Mon, 16 Sep 2019 11:00:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/bnxt_re: fix spelling mistake "missin_resp" ->
 "missing_resp"
Message-ID: <20190916140047.GA6108@ziepe.ca>
References: <20190911092856.11146-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911092856.11146-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 10:28:56AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a literal string, fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/bnxt_re/hw_counters.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
