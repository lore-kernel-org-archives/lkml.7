Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E7BC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D20020820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dY+hZk+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbfFJR1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:27:15 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44214 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbfFJR1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:27:14 -0400
Received: by mail-ua1-f67.google.com with SMTP id p5so3351860uar.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 10:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DWQqcRf25bxZ70yE81nwepgbf101hBdf3laz0rjRo/E=;
        b=dY+hZk+1sXqFyBZ/kCyAfR/TE0/L7YI/W3F22WM780uWwVvlhahc4tD3fPJvc2nVvP
         qixzLJ718KmoUqyXVk48IRU5/1fzBhcftWZTltvD2ErlQOp0gbxSTjF68rTGp0acNFvY
         tmc45CbUWL+biKVmW2kb71RzXXmctVEYwWEACbMJp5Yk6EMIDbIMaLWC0IV8juw2yM+g
         fsAwSrgUY1kzu46sxSl6AJdOQsohrMFL3BgThWUZxijXayzRWRhG/ibpyI7MtzuVjxVh
         DTHNHeyCjvohcDuhk5XkfHdozzxgFcM02LbN+nOQzE32E/3eB9mJ0CWtT71EjkLFRBuZ
         E/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DWQqcRf25bxZ70yE81nwepgbf101hBdf3laz0rjRo/E=;
        b=q+pH+PxjdEdwsqwowcxE7EaUaTS6h72OiBiGBVxOaCssHGRVcn9B75WGFs1UGhN2qv
         On9IsO8tVELGa1HPMhOvZYNsW+nsM1DmciVcELEe+zPi8elXjeeNs/V5+NoKRNOATFSr
         mkb4z9e7QyNTPNNvebNVQ5DzzpbXbmI/NkLz6DrHNALzQj8+tx/IXmk5MDGpmF9Nicy2
         lrN6eMVgyJnbsRC/CytO6nP07KFkHU7Ep7d5l5l7bKvfE6fx876yv37yhZTGJ2xKMHxJ
         uW5cunxnfkOB3CLKdjdUCvmuxo9tA4PXVKhXfvBI+oZ543NZ5RJL9hPmDqaHBaUYriVj
         mzCw==
X-Gm-Message-State: APjAAAUFKSnZ4JtdPtCGE1uma1SztuW+hQc77Wd2xcFVBMzzU9rICKxM
        bZ8o6Td4e4FpMvONCxVVJZI/1Q==
X-Google-Smtp-Source: APXvYqy3N5pogkPzqAYXI5ISuNS396Bf5IYoRhpef5JO5okHEacgVPEjT8l7OFDCTer38zTjRBzVsQ==
X-Received: by 2002:ab0:628d:: with SMTP id z13mr16231434uao.39.1560187633916;
        Mon, 10 Jun 2019 10:27:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id v142sm3201988vke.38.2019.06.10.10.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 10:27:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1haO4e-0000NU-RQ; Mon, 10 Jun 2019 14:27:12 -0300
Date:   Mon, 10 Jun 2019 14:27:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3 13/33] docs: infiniband: convert docs to ReST and
 rename to *.rst
Message-ID: <20190610172712.GG18468@ziepe.ca>
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
 <09036fdb89c4bec94cb92d25398c026afdb134e7.1560045490.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09036fdb89c4bec94cb92d25398c026afdb134e7.1560045490.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 11:27:03PM -0300, Mauro Carvalho Chehab wrote:
> The InfiniBand docs are plain text with no markups.
> So, all we needed to do were to add the title markups and
> some markup sequences in order to properly parse tables,
> lists and literal blocks.
> 
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  .../{core_locking.txt => core_locking.rst}    |  64 ++++++-----
>  Documentation/infiniband/index.rst            |  23 ++++
>  .../infiniband/{ipoib.txt => ipoib.rst}       |  24 ++--
>  .../infiniband/{opa_vnic.txt => opa_vnic.rst} | 108 +++++++++---------
>  .../infiniband/{sysfs.txt => sysfs.rst}       |   4 +-
>  .../{tag_matching.txt => tag_matching.rst}    |   5 +
>  .../infiniband/{user_mad.txt => user_mad.rst} |  33 ++++--
>  .../{user_verbs.txt => user_verbs.rst}        |  12 +-
>  drivers/infiniband/core/user_mad.c            |   2 +-
>  drivers/infiniband/ulp/ipoib/Kconfig          |   2 +-
>  10 files changed, 174 insertions(+), 103 deletions(-)
>  rename Documentation/infiniband/{core_locking.txt => core_locking.rst} (78%)
>  create mode 100644 Documentation/infiniband/index.rst
>  rename Documentation/infiniband/{ipoib.txt => ipoib.rst} (90%)
>  rename Documentation/infiniband/{opa_vnic.txt => opa_vnic.rst} (63%)
>  rename Documentation/infiniband/{sysfs.txt => sysfs.rst} (69%)
>  rename Documentation/infiniband/{tag_matching.txt => tag_matching.rst} (98%)
>  rename Documentation/infiniband/{user_mad.txt => user_mad.rst} (90%)
>  rename Documentation/infiniband/{user_verbs.txt => user_verbs.rst} (93%)

Looks OK to me, do you want to run these patches through the docs tree
or through RDMA?

Given that we've generally pushed doc updates through rdma, I think
I'd prefer the latter? Jonathan?

Thanks,
Jason
