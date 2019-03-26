Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6614C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEB720823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iiq4Lyhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbfCZPK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:10:29 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:36192 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbfCZPK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:10:28 -0400
Received: by mail-qk1-f181.google.com with SMTP id k130so7821446qke.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 08:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ens1I6HYx+s73sg5X0epruDA2Nu2z6xk4Wt/Zsj3YSA=;
        b=iiq4Lyhmxik3caHuvg8/dqtEShSUIFZKx/dxZ5WFUC1bZOwuqkTh+ITH6XBlemU6wd
         i2HJCQ1Gz7yQxBGmP5fqnuFa0FhNSWNu9wmMoRyo4hSzfDJqWEJUdxvEc14PxxCil9WY
         XXkfRHQTEWnDNUeMLGLd+ZYVeEFplhT4eyqbYfn65tTxScmZPPIAHoMK+ERshQ6XGQwj
         Au0Quk9UsfLVa59HXn/BKYDCPZFnuh3M7rgwCAUR/pMmUhCsEDw9M8lC1RqZIe12w16n
         O5kF9OvHFnpUptrzk++MbdnAVr5mJJLXntcRoC5e9AzCZQkVbRx3Oad24vcR3q3T5kAa
         AelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ens1I6HYx+s73sg5X0epruDA2Nu2z6xk4Wt/Zsj3YSA=;
        b=VFtn+1SeXyxC5JL0T+nCDsFf5FFY7GOA1PbFD1t82wKDVHZrSNrUMw4VvAOmU2F3iP
         zicUKHH5b5Z1D17NKoMe0v09nKE76q2Y++vH/pHUAZn2ZZisxBvGO4BNH70BGepc0F+T
         5yaVdIaAh9kQUt1pe7DKXu6JkzEayG/OuoC+QpbD1lrbm6AIHbLDZb171+Vea15OZ4FD
         Mg46ZVmo554eCZt7TNtQqQ9sIxrE2MQniXwwVFcIOjjJa0Xs9vJMEe1qp6DeTYMhbn5Y
         wMGVBPCTpiHS1kx66cQtE3kzqZ53oXBzpfHJNUmcdYZEq8gr/Vee82EUFgWqMT2l4tUB
         YN0g==
X-Gm-Message-State: APjAAAV/RaRLvPTMLCCRs7EXHXvophZsc1g+zUu/kTHrLA526oUY/kwW
        N2QE5kF0aaRjscHaaHM8f3AHPA==
X-Google-Smtp-Source: APXvYqxFpJcIdj32BO6jZ8+ETFwngfR+G0qQkP2pUYhZz4Yjc/in8lCOawpwm4QnrfZvF3wYrKEF9A==
X-Received: by 2002:a37:b487:: with SMTP id d129mr24259586qkf.349.1553613027866;
        Tue, 26 Mar 2019 08:10:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id o68sm10761251qkc.89.2019.03.26.08.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 08:10:27 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1h8nic-0002Xc-EY; Tue, 26 Mar 2019 12:10:26 -0300
Date:   Tue, 26 Mar 2019 12:10:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Faisal Latif <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/nes: remove redundant check on udata
Message-ID: <20190326151026.GA9743@ziepe.ca>
References: <20190302230637.8624-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190302230637.8624-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2019 at 11:06:36PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The non-null check on udata is redundant as this check was performed
> just a few statements earlier and the check is always true as udata
> must be non-null at this point. Remove redundant the check on udata
> and the redundant else part that can never be executed.
> 
> Detected by CoverityScan, CID#1477317 ("Logically dead code")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/nes/nes_verbs.c | 73 +++++++++++++--------------
>  1 file changed, 34 insertions(+), 39 deletions(-)

Applied to for-next

Thanks,
Jason
