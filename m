Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D5CC06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8260F21882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gLYuktie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfGCSIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 14:08:05 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46974 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfGCSIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:08:04 -0400
Received: by mail-qk1-f194.google.com with SMTP id r4so3494889qkm.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 11:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OYaxpn48U3skDTAdtQfXdHDeoqepuheTmkb2SxvtSV4=;
        b=gLYuktienQrDuUAp1WFjQf9xfPah11Dw6buUfEY1JFPCj3dCv2lZStTxOFPD00D+bF
         1PN46v1fKJLgrylUoqtrYdD5ziCfLs9KUieOM3uuNZ3RwDnYjbsqJt5teuV/9fTNqmcG
         6Hr9dGTWjxzYNS6rrKnwjJufd35xKzDiYyinjag153AXL6v1aXApKnruH2HQN5+u0oAD
         BHzF7u+HHQjP7y+c2ROEhyex2qPr+7U7r/R8IhkOkGNR8oc9GMEjO+bwNKYKHqfi2Xas
         6huoBd3fhDoT3jhOzUP3FY6Q/MRanmQflSwOkzE0r2uFxbTgEjRgffik6V6IqB1FXs5e
         AUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OYaxpn48U3skDTAdtQfXdHDeoqepuheTmkb2SxvtSV4=;
        b=LZABquw2hADC0V7h+do/PTi06DHQxBTHpcv8Snu/1XSXMw6kZSWsDhtgMurdE0LDUp
         96WokvXRMU3a5/yZ2ILHKCx/XwuKB/SNC4oMqxLr7hfJc0vh3UIwhR+63VCd2K13pvTm
         q7ADtffsrM4rImQUGxNDndJNeAxd3Ovf8FuYMPkMBAbiueB8P7MVVL2f3QUdNMw77RCN
         y7Go9epAX6hw3VvqLUJdJk+PWJiZVczZkd1DRAUQx59bxbIPw9GOHDx+40H+aEonAMoi
         THkeJPYc/vJbTR0fwCJgffXZYeFwuWMzsDKf652+Gyb6IeERbh4rblIczGgv023bl9W0
         0yyA==
X-Gm-Message-State: APjAAAXHZxfe/gq+qXsZxqvXQyZU6Mo7lOp/WoySUlV1pmp/ToVMliRr
        sZtcu2xaAJQuUoPYdh+ujTXgiw==
X-Google-Smtp-Source: APXvYqyPj+RA7zrPQrkcrn6bqzjUH/COcT3yrysSoSj0d+OXpkzq9JwddxUbZ+DeNDguNB5M7a3aCQ==
X-Received: by 2002:a05:620a:1116:: with SMTP id o22mr32281639qkk.82.1562177282977;
        Wed, 03 Jul 2019 11:08:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o54sm1450159qtb.63.2019.07.03.11.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 11:08:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hijfm-0006ur-5o; Wed, 03 Jul 2019 15:08:02 -0300
Date:   Wed, 3 Jul 2019 15:08:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 35/39] docs: infiniband: add it to the driver-api bookset
Message-ID: <20190703180802.GA26557@ziepe.ca>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
 <12743088687a9b0b305c05b62a5093056a4190b8.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12743088687a9b0b305c05b62a5093056a4190b8.1561724493.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 09:30:28AM -0300, Mauro Carvalho Chehab wrote:
> While this contains some uAPI stuff, it was intended to be
> read by a kernel doc. So, let's not move it to a different
> dir, but, instead, just add it to the driver-api bookset.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
>  Documentation/index.rst            | 1 +
>  Documentation/infiniband/index.rst | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index ea33cbbccd9d..e69d2fde7735 100644
> +++ b/Documentation/index.rst
> @@ -96,6 +96,7 @@ needed).
>     block/index
>     hid/index
>     iio/index
> +   infiniband/index
>     leds/index
>     media/index
>     networking/index
> diff --git a/Documentation/infiniband/index.rst b/Documentation/infiniband/index.rst
> index 22eea64de722..9cd7615438b9 100644
> +++ b/Documentation/infiniband/index.rst
> @@ -1,4 +1,4 @@
> -:orphan:
> +.. SPDX-License-Identifier: GPL-2.0
>  
>  ==========
>  InfiniBand

Should this one go to the rdma.git as well? It looks like yes

Thanks,
Jason
