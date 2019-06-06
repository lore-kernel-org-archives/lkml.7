Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28E1C28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C5120665
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Nd8WTWlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfFFOQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:16:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44807 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbfFFOQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:16:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id x47so2770301qtk.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 07:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=x2NtpsySZzA58TAtpw74/PYyujX/rnY3kx7DMxb/EUc=;
        b=Nd8WTWlw6G8cHAWZuKjxZwj5zy6tEAcuyngG0C5pWS3Q64zshz9FFMmsw/wVABqHjx
         /5XKwSWCvOkg9pIGKc0qS6JDn+H3ehfGrK3u0JCKeduZWtPM9OtjSjNzyXW2XKS2REji
         xGHU/vfM1Yo68cA6FIVjlFGE47N8bKH21YZ40A8Fo27l6IlkPldOL8T8rIt5U5afEc3K
         SgY1NGcQHj59crXbjdmKfZPslad6GKeDUHTwM3QpQfoAMbvF6Qk8LiiQJYzcABYNteXQ
         CNr/hKnecVB0PmXLGj7TsxQgnMPaFUV4B86MKvKELTpiyGarIWaKHzp9fTNpplATL0s5
         ggmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=x2NtpsySZzA58TAtpw74/PYyujX/rnY3kx7DMxb/EUc=;
        b=eK50QHGsfAquZY8ZLeAG9jyfpjEK0WlXFL6U9mI8Pe3p71GXQzgPXENwWBE7l898Uq
         Z6prMsaQVyy7YaOxZ7KJxoVYY3EDKUdNQhlm9clr9b6Af4bekMd4WA/dZJjvkfHGjSSj
         XlWGRsNUehMtRrQxBhwPpbq4+AK40PzHTiIEI+0eJ5fO2U8WlQ1OZs/sq/ixv7DAP4Uy
         PM85UrC1nYrzbs+3KrawE2Vt/o+ZawMnGizlx0B4P6qryS/w6prl5txVKfwBFVuKmk3Q
         ZVNJCgPed22Oa2ASaH+/kuPH+WKLxdeR0ZWtZjo0ZFiPA+OoOvTMq3YkTtQ/aBrxDadY
         zPmg==
X-Gm-Message-State: APjAAAUzenGpOAoO4xcqpATpQIkkUWR4lvjWPDXBbBRoiqYtcm1RenP9
        gTqZy6SMEgPZlbuUaPVSAuqAJg==
X-Google-Smtp-Source: APXvYqy4Bg3zzTDW43K2iOXSRQidq0DVY1LfO6HtCYvj44blfzhGJ5iIlkfyINA3yHm65CSJF4pPEA==
X-Received: by 2002:aed:22a9:: with SMTP id p38mr17862714qtc.188.1559830605359;
        Thu, 06 Jun 2019 07:16:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id k40sm1507614qta.50.2019.06.06.07.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 07:16:45 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYtC8-0000l9-Dz; Thu, 06 Jun 2019 11:16:44 -0300
Date:   Thu, 6 Jun 2019 11:16:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     rcampbell@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>
Subject: Re: [PATCH 2/5] mm/hmm: Clean up some coding style and comments
Message-ID: <20190606141644.GA2876@ziepe.ca>
References: <20190506232942.12623-1-rcampbell@nvidia.com>
 <20190506232942.12623-3-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190506232942.12623-3-rcampbell@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 04:29:39PM -0700, rcampbell@nvidia.com wrote:
> From: Ralph Campbell <rcampbell@nvidia.com>
> 
> There are no functional changes, just some coding style clean ups and
> minor comment changes.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
>  include/linux/hmm.h | 71 +++++++++++++++++++++++----------------------
>  mm/hmm.c            | 51 ++++++++++++++++----------------
>  2 files changed, 62 insertions(+), 60 deletions(-)

Applied to hmm.git, thanks

Jason
