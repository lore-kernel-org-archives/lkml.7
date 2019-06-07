Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16887C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF763208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dosAQ2Nn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbfFGR5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 13:57:32 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38820 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731052AbfFGR5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:57:31 -0400
Received: by mail-qt1-f195.google.com with SMTP id n11so1176303qtl.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 10:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5MddV+Sg45RFyPQPwq6EPVm3wo3sSDcpYJ17hnXLFXU=;
        b=dosAQ2Nn0ydTmNOgvwFg2l+msfvRcAS1U5jrslXA9t4l6S08L+U1MG5oxZ2FqUa23+
         Kaf6kSeuQh7xc3qFnNyZtsUz67X5rbCIVZcfaDn0VDdpzvFwgWSbwkV0B+jNAstC1my2
         0LUJy5bvOU9ehS6dRjgtWFiq1MybK4xEgdwWtgVwqr6KWf1ahvQ5ZutRw0cbsfzb2hBo
         usV1pW8EeyEk2wC6IQ5s1qvYEXhP+KHVkIBVGyxgo3hkOeeJKMRLxDs9b1NkatMC2bCT
         DUwG96H4WkaqFfH5e86F0PwtPrMNb41hU3OtZ/7qYqgzvjXPrxKk/EZKuEJkIqhG6I0r
         JyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5MddV+Sg45RFyPQPwq6EPVm3wo3sSDcpYJ17hnXLFXU=;
        b=pcQ5qUi21z4lUSB0b6YF1JSuFNTWxDL/RgXcmtQIUgE/vsTNzwGjOT1QxN6AUPfWiL
         DGeWtPK6Yu718su8BWfmtmdI/ANZFOg1j39CshPVeeG1XMQl6RgfcYytrPt+LMKUzaEZ
         rTZq0u1ZKeNDWkeUrLncIe88JtqZW5/z4fFfxdTEiGhBdIQWrNH5yEFY+XWSt0+XH91f
         PjzNh+ciSCMzDQyKUBk82YxlrViNBpllJS5UBaoV3zoWhbThwkrl5WhKJmRUOiqeomDf
         LPEaDRQA272LUbgOb3P+dCCf8K2RAfh4h/9PkIFmbciG+nPU3YXbIzYiYDCyzcBwwzGN
         e7sg==
X-Gm-Message-State: APjAAAXlhFP2JBsSGSBMFgMAn12Fr7QG+t3FyFAUo/6NTgF+urrvknTd
        iBIPQj2knBRKyMUM1NyHTxRMIQ==
X-Google-Smtp-Source: APXvYqyW1TURwevhvnQxF+uKcNumtSWbviKcgyMAha8x4HHbW8bvgpah7hMJTZx+6UyXiYV4aAHxdw==
X-Received: by 2002:ac8:43d8:: with SMTP id w24mr47116757qtn.25.1559930250734;
        Fri, 07 Jun 2019 10:57:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id v72sm702497qkb.0.2019.06.07.10.57.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 10:57:30 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZJ7J-0006WW-Pg; Fri, 07 Jun 2019 14:57:29 -0300
Date:   Fri, 7 Jun 2019 14:57:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Lijun Ou <oulijun@huawei.com>, Wei Hu <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2][next] RDMA/hns: fix inverted logic of readl read and
 shift
Message-ID: <20190607175729.GA25014@ziepe.ca>
References: <20190531092101.28772-1-colin.king@canonical.com>
 <20190531092101.28772-2-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531092101.28772-2-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 10:21:01AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> A previous change incorrectly changed the inverted logic and logically
> negated the readl rather than the shifted readl result. Fix this by
> adding in missing parentheses around the expression that needs to be
> logically negated.
> 
> Addresses-Coverity: ("Logically dead code")
> Fixes: 669cefb654cb ("RDMA/hns: Remove jiffies operation in disable interrupt context")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
