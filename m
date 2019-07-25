Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0852C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B1B21851
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="htDNAyfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389294AbfGYQ56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:57:58 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37853 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388878AbfGYQ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:57:58 -0400
Received: by mail-qt1-f194.google.com with SMTP id y26so49765299qto.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8ZhTHUGF4BS+/P0Rb9TkAvrSGyWNOTQnBdMjw8j9VFk=;
        b=htDNAyfJo63MPyQIOStcJbrDyJUyecGKpxeCN1ks947EiKLGO6CkCJUa5x9dB8TbfM
         Bwa4LWWkuzh21QnmjaMFAu3m5IR49XdNmcF4wOtSSrK+u0XluA/A2E7xA5BPmrybm48Y
         0pGFEC6moPikmfzYE2HUddJb3GtOpFE5/myj46UxS8Q2j+z9Akz7qEcHASdhynLEi8ti
         EWDMZOxToSy3V5vbC072JeLcbrHcrK1gBxFzhIzA3sbbibgjAld23GDDUphR5R3syQoq
         Sn4n0EuCgjmafw8N85d6zjA5+wtvqzL90zBkgGmvH5I5hr6RKppNg+qoVTjLLZRWQqNs
         DCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8ZhTHUGF4BS+/P0Rb9TkAvrSGyWNOTQnBdMjw8j9VFk=;
        b=ehXqdWSdi9bYog3h3t5Bpbr8wU8vf1ZQ7zzxp2cyD8SsUtXS/xchU1eSMm25kyl+FX
         2viWl2MwvlfQqRkgAMaW4fmyE37VZifcwGDbIIKt9dqGU6mvG017j8OLg1Gqswj4TCqA
         sUr/a2X5XhAvVhFWM23raxKW0ru5qGjA3Djc3maJ7HDPbinjgNyAi6w1DG3glOeikD/5
         LuRETcmJsFux5LZyr2KkpFNYplIgCQG2dZ4ffkPhtamlCasuVAn6Qb0/DOpYqYvgaLQb
         1w4hxQPXQzGBXYZjfhKevaVSavY+b8jI9fP5Yz7hp8klkWyaXWqKX+UopgpI0IakamfN
         5Q7w==
X-Gm-Message-State: APjAAAV3y9kkYsbywXvtX73WcFhi8Rf5YhEzgxBE8mLe0V2ypLfN2WDP
        8yljYMKEfmkzmo9RPM8gVElNwQ==
X-Google-Smtp-Source: APXvYqwHQPucPMO5kUMNQPJH7Vr25vk90HiYOq2HrHUamu9EDlxdlfqXGcMUBX1+WOCtwiIPISXbag==
X-Received: by 2002:a0c:db93:: with SMTP id m19mr62622768qvk.96.1564073877389;
        Thu, 25 Jul 2019 09:57:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id a67sm23661396qkg.131.2019.07.25.09.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 09:57:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqh40-0007U5-DH; Thu, 25 Jul 2019 13:57:56 -0300
Date:   Thu, 25 Jul 2019 13:57:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: hw: qedr: Remove Unneeded variable rc
Message-ID: <20190725165756.GA28745@ziepe.ca>
References: <20190716173712.GA12949@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716173712.GA12949@hari-Inspiron-1545>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 11:07:12PM +0530, Hariprasad Kelam wrote:
> fix below issue reported by coccicheck
> drivers/infiniband/hw/qedr/verbs.c:2454:5-7: Unneeded variable: "rc".
> Return "0" on line 2499
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next, thanks

Jason
