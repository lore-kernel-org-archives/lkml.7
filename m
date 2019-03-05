Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF948C10F03
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4DB20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cIbA4txX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfCEAxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:53:42 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33706 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCEAxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:53:42 -0500
Received: by mail-qt1-f196.google.com with SMTP id z39so7301397qtz.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 16:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XVYt//8tLSfx+WH6Lmq9iHXTEUimc3qP6GGB8yuMZP4=;
        b=cIbA4txXePxhYRMosF0K4Lf0pYeh5EsSFPuqs/QO/VWfnll6mD6fAdE5bLAsxDDV8b
         pMcaqaJ3cAphmez5ynHwcu+nAOnX0lNGpa7CfwAzx/1IBdJnNYHnEs0njSfozkQkDnv/
         /BDWuTYiFElCsWZmnR2f6Eftcm3hsGd/oyx8aEzIscAlTcejvxOn6sJPgios4EMa8IiL
         l4INWPvsR6ZjJr6mAb5ZQR8azH8ilI7Fvz8bLkbr+OXB0/VIqrZFmE581eaxUEa3760i
         o773UgVIyzIPBn4hPNDtc3ZZbNSV3pZYH07dyPgrK9oDQdUm6/M/bazP0dozLWDejXAZ
         kJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XVYt//8tLSfx+WH6Lmq9iHXTEUimc3qP6GGB8yuMZP4=;
        b=cNzf7beVUWM19WPI4mY4mPuItwTOKR+ioVh7VfLUpGsKkY/p5qeYBIO+ePmLPw/kVW
         qO8DT6kJ4ihJjLotFh/ZSJgKcQg/XUOjYQ0psGGGdVo3QJVmcHuknk0/dZOXJzKBD0Y0
         pdgr7f8RQZRhQnwDW++WJE1LXHUiejsGUesTev0bnru1DtYtZkt3kezNWFNvTptmGVpC
         6mXOhZYDrWQbIsVrVjFkHQjsaunj791YimGdr/VIGAOixC1x5MtYekNpJQ6DJSnoEEKL
         +0SqzGPEmUlnu7r9gJ0EG9daRV95WxUFYHsm5H4gchHwhXcYbk2hErdxKbUmZyGilwqW
         /QaQ==
X-Gm-Message-State: APjAAAUzU1CrbRjHBorR67mrqSZqNHPajed3SB66qtGLEorfy+2NFCJq
        HkcaDq0IsLpybRIZcrSNXwKyUg==
X-Google-Smtp-Source: APXvYqwgYquIrGrypPfGh12coX509Dw+mf6crd2NMr+KYucqtQsXeX7lvPZECuSr4ZCtq072yEeFpw==
X-Received: by 2002:ac8:2b2e:: with SMTP id 43mr16897084qtu.33.1551747221098;
        Mon, 04 Mar 2019 16:53:41 -0800 (PST)
Received: from ziepe.ca ([24.137.65.181])
        by smtp.gmail.com with ESMTPSA id d80sm4140972qkg.83.2019.03.04.16.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 16:53:40 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1h0yKw-0002jB-Vl; Mon, 04 Mar 2019 20:53:38 -0400
Date:   Mon, 4 Mar 2019 20:53:38 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        "john.hubbard@gmail.com" <john.hubbard@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2] RDMA/umem: minor bug fix and cleanup in error
 handling paths
Message-ID: <20190305005338.GK8613@ziepe.ca>
References: <20190302032726.11769-2-jhubbard@nvidia.com>
 <20190302202435.31889-1-jhubbard@nvidia.com>
 <20190302194402.GA24732@iweiny-DESK2.sc.intel.com>
 <2404c962-8f6d-1f6d-0055-eb82864ca7fc@mellanox.com>
 <20190303165550.GB27123@iweiny-DESK2.sc.intel.com>
 <bef8680b-acc5-9f13-f49e-8f36f1939387@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bef8680b-acc5-9f13-f49e-8f36f1939387@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 03:11:05PM -0800, John Hubbard wrote:

> get_user_page(): increments page->_refcount by a large amount (1024)
> 
> put_user_page(): decrements page->_refcount by a large amount (1024)
> 
> ...and just stop doing the odd (to me) technique of incrementing once for
> each tail page. I cannot see any reason why that's actually required, as
> opposed to just "raise the page->_refcount enough to avoid losing the head
> page too soon".

I'd very much like to see this in the infiniband umem code - the extra
work and cost of touching every page in a huge page is very much
undesired.

Jason
