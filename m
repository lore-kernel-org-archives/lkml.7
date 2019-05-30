Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8FCC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE4D25FD3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DaZtLdpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfE3Snd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 14:43:33 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39423 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfE3Snc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 14:43:32 -0400
Received: by mail-qk1-f195.google.com with SMTP id i125so4569188qkd.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vUie64/qC+90Uz/gKolRXnUiAy4nHqngEGJ4fSt7KR8=;
        b=DaZtLdpScPYOOF/BjxCxP3yGwR9TR5PeBbqHHquAFF79GiEXdykaOA1nAEk1QxqUYY
         3KZGTVPojYgQlSQ5Gv3C+gId0iQBm7z0qKiQ8SJrtxHFqNDmmMQDiZ5lZWqWC0Jz4dtf
         Rc+k9fHE98G8sueQYP0tWzZGODkOO5GFgkeIJ5kQhjt1Jd/CKDSaOfs4erhVpNWMEKUQ
         OV8CPaUjCHIzblfU6Uuoj3XSHO3nSvjN0w3gqZPNT6fUVnOeUze7kqdzPmM3nn3A79+e
         ENs8NXSyuFFopnP+cct7CRx0SFtGRSkRqXk9OumLDpbJJ1p+2LBmFAMUN7RWFq1Cc9KE
         XQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vUie64/qC+90Uz/gKolRXnUiAy4nHqngEGJ4fSt7KR8=;
        b=AoY1jUzcm48AkBE0pcTLNQu7Ky/he9Gyk7sdqzgK/SDUDrSInQGsBoY+f2smIvhQvN
         VGy5w1bpHKUOQGmZXhHqdi0l6vCKlu9ylsQfDDBj5+u939Ow1tdAbWQ7BPMdB/q/Yd3Y
         HwS2eq2BbzdKaxoI5cuSSOqPpPtTq7ffKJxK579r0JQ9UWMW4GTVlnL0fyR1u/8avy0i
         VH1BntKRsCLG5eE12c7Rvq//N0ba/bJvNfMCHE1BmIYxrvf5224VJ4LIqm5MsjBVuUv4
         py8vwAZrdHgQv09n1j6UjtJy934CourC0YcjZ/8VZ/uDRYYYPvm7KDtLyZKjGpJUjHbR
         HIVQ==
X-Gm-Message-State: APjAAAVRTBe8U0RAp6gsS+GeU2bNoiLBjxBtVZFTFDeiusKftd0WVbxh
        Y1lgLSLOzCEBcq0Yn6fPMePbWg==
X-Google-Smtp-Source: APXvYqxLbqSRX5R4cR9BBYQXTcp54f3lB3QkcHo6jQRSMrdnMZAsFM01QpFSNz+egvbe8hz1F2Y7cw==
X-Received: by 2002:a05:620a:12d9:: with SMTP id e25mr4647750qkl.279.1559241811722;
        Thu, 30 May 2019 11:43:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id p1sm307063qti.83.2019.05.30.11.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 11:43:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hWQ1S-0007kH-Up; Thu, 30 May 2019 15:43:30 -0300
Date:   Thu, 30 May 2019 15:43:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] IB/hfi1: Use struct_size() helper
Message-ID: <20190530184330.GC29724@ziepe.ca>
References: <20190529151528.GA24148@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529151528.GA24148@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 10:15:28AM -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes, in particular in the
> context in which this code is being used.
> 
> So, replace the following form:
> 
> sizeof(struct opa_port_status_rsp) + num_vls * sizeof(struct _vls_pctrs)
> 
> with:
> 
> struct_size(rsp, vls, num_vls)
> 
> and so on...
> 
> Also, notice that variable size is unnecessary, hence it is removed.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
>  drivers/infiniband/hw/hfi1/mad.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Applied to for-next, thanks

Jason
