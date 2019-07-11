Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF85AC742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 19:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C3320863
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 19:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WfctH2ke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfGKTq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 15:46:28 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34673 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbfGKTq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 15:46:28 -0400
Received: by mail-qk1-f196.google.com with SMTP id t8so4641156qkt.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 12:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0MV3Xo8JXCmgPVPj78lec025mCDr/1718DU+JOppzoA=;
        b=WfctH2kez7F8xf8pjozxz28muLcSmecGPp9EI7So4GsVHGxF7SDpICIcvDHC1JXn8p
         P86t62V30/1dmxJXPNqrtlEHW9cgm0f5FyJfwlBVcq3YasFS7ETZZQvmogrpLHaa7uOM
         7NbiZbwZp2GA/SX6zrq3GxfYIDznH9v7yWLCC8dbvNc8PwHLxI7TvjV9gdthli9cOeOu
         DHFLfK3nsnu4ttTWt8P33qOTOxTzEBa7Ne0dOy3SLh3E7xCeimipp+1WGjvmFEGN7fo7
         JoRnyDfZNylUrQO052pWCoN/88mot5CdDfRBp7a4/Tyr7SlLexn9/scgIqreDrP5VOuN
         rzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0MV3Xo8JXCmgPVPj78lec025mCDr/1718DU+JOppzoA=;
        b=s8ZDczLmp4y66WIvD7BuOM++VbkNz21ly+Znd96eeCMBdHWHfeW3UycCKjF0aecMVP
         B5sM9CixJIG3D22q2ZeZtR56TA0F/ndOJ+K3TaUqWb8yWhhXHCczyz3bmKIgC5vfROyW
         wl2whZUYTgyXzqZ0qnX35cjr874WV6wXotbVVGfMchh2Vk1vhMb1cCe+QkK8wxMfJ+t/
         l9e9niExegp8fsrxeb+yAsVBjPxvxw/wwJLQVjQR+5IpQ1Yww/GFwxxst6NbuYH96eoX
         wfIlBtRh5iCFQVukYQPG1eF0Y7ZQV33JhnOfut61m1VKA32InE7tholElF2H60G2ixyU
         OfOw==
X-Gm-Message-State: APjAAAU4ytqhHwESxBB+w/tihJPZsgCH6D/ST3G24mMDxkPtGtl3xQvx
        km2r4GpAjjjQwSkRxJhH+blUdQ==
X-Google-Smtp-Source: APXvYqzjwdP+mZ7dRkBy3VJYWZpIAzR3fAEad0kJ+VLPyzuhPdeZhdwijUigUy10iMlGPnMN0HUT3Q==
X-Received: by 2002:a37:9a96:: with SMTP id c144mr37475qke.468.1562874387437;
        Thu, 11 Jul 2019 12:46:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id a6sm2363257qkd.135.2019.07.11.12.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 12:46:26 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlf1O-0002M5-5F; Thu, 11 Jul 2019 16:46:26 -0300
Date:   Thu, 11 Jul 2019 16:46:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Douglas Anderson <dianders@chromium.org>, stable@vger.kernel.org,
        groeck@chromium.org, gregkh@linuxfoundation.org,
        sukhomlinov@google.com, Arnd Bergmann <arnd@arndb.de>,
        Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: Fix TPM 1.2 Shutdown sequence to prevent future TPM
 operations
Message-ID: <20190711194626.GI25807@ziepe.ca>
References: <20190711162919.23813-1-dianders@chromium.org>
 <20190711163915.GD25807@ziepe.ca>
 <20190711183533.lypj2gwffwheq3qu@linux.intel.com>
 <20190711194313.3w6gkbayq7yifvgg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711194313.3w6gkbayq7yifvgg@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 10:43:13PM +0300, Jarkko Sakkinen wrote:
> On Thu, Jul 11, 2019 at 09:35:33PM +0300, Jarkko Sakkinen wrote:
> > > Careful with this, you can't backport this to any kernels that don't
> > > have the sysfs ops locking changes or they will crash in sysfs code.
> > 
> > Oops, I was way too fast! Thanks Jason.
> 
> Hmm... hold on a second.
> 
> How would the crash realize? I mean this is at the point when user space
> should not be active. 

Not strictly, AFAIK

> Secondly, why the crash would not realize with
> TPM2? The only thing the fix is doing is to do the same thing with TPM1
> essentially.

TPM2 doesn't use the unlocked sysfs path

Jason
