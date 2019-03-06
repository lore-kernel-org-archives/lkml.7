Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6840EC10F09
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394E2206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JRjGlCOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfCFBcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 20:32:16 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42955 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfCFBcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 20:32:16 -0500
Received: by mail-qk1-f194.google.com with SMTP id y140so5907961qkb.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 17:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LgoNOQGVlVerTL6CkbzBmMfQoLEg7pV/lg0gy2aIImA=;
        b=JRjGlCOKs8wItxm0entX9rujZvzkRAII4BOKp6jB5luJOeHJb9YbCs8TwIs4jpZYQI
         fbacOgDnupqZc2tg7drOzMFLGU2Gl/8abzn+R8wiqMLfrtugSLbIHWOFcuicbHZya5YR
         SW8r8Lxp3tg/F1g6Q/2VqLcjjZKtQyCyfsyMggvaRqA3ZmE8Wkbhdipj/Yfo6plmAQpq
         E8rDWp8yPzGELmZDQzL2wlbAVE/wbYwmWB8V1vVRkvw6cHZVKU8D1hf7xeGHkGrnnEWg
         s/vLSM0HqG9tR56O4eyPrpl9vMH2TRkTXyEkZE9sIm3cck+m9a+ZgjAwesZKGWHQuw+y
         Tniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LgoNOQGVlVerTL6CkbzBmMfQoLEg7pV/lg0gy2aIImA=;
        b=IGOTbpAR6eARFv+XizN6QaYkyUmedzADl2axkf7RSP3Z0mlbR9oqPsEmHB2S0PF6a2
         XMVsenNQaujQ6mSYM+zDQ/a447yJjh6a0/t3Jthtkd7HXbAMG1ZfSjLzP9XmTFg+V2c0
         nv/eNsYVqiqHFwU0dxPNbft9XZAKRquxaOtNpsdmBhAaXOxnaZXdIN42JIQVN4+j8kMi
         bHVNlm/ZrJGiiXSD6R8JGP+tx/zZCJyYJTVMrBvjAu79aWZGaLw+/mdYWEYvTh7DM6Fc
         wCMD9yb2t61CPpdS+q6+skiW07SEMw9RM4Q0hDTSlA8k/j4S68UAYM+fdjDfBRkw1/XC
         Q/ZQ==
X-Gm-Message-State: APjAAAWP4IfcO09SvjPqohBlIvzPst9yU+RfvRJLzzztCO7TxDiXTqhB
        sqW1wlQNLVtfcFvzqmrX+tA6/A==
X-Google-Smtp-Source: APXvYqwOwuDPdIm3i+RCGmlGOgPdC6Eqs32vJh04KZPR3wugqMiT1SQj4ve03YID4AqVeBJBheEcYQ==
X-Received: by 2002:a37:9f04:: with SMTP id i4mr3786299qke.221.1551835935107;
        Tue, 05 Mar 2019 17:32:15 -0800 (PST)
Received: from ziepe.ca ([24.137.65.181])
        by smtp.gmail.com with ESMTPSA id o5sm215033qkl.24.2019.03.05.17.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 17:32:14 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1h1LPp-000230-1Y; Tue, 05 Mar 2019 21:32:13 -0400
Date:   Tue, 5 Mar 2019 21:32:13 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Artemy Kovalyov <artemyko@mellanox.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "john.hubbard@gmail.com" <john.hubbard@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2] RDMA/umem: minor bug fix and cleanup in error
 handling paths
Message-ID: <20190306013213.GA1662@ziepe.ca>
References: <20190302032726.11769-2-jhubbard@nvidia.com>
 <20190302202435.31889-1-jhubbard@nvidia.com>
 <20190302194402.GA24732@iweiny-DESK2.sc.intel.com>
 <2404c962-8f6d-1f6d-0055-eb82864ca7fc@mellanox.com>
 <332021c5-ab72-d54f-85c8-b2b12b76daed@nvidia.com>
 <903383a6-f2c9-4a69-83c0-9be9c052d4be@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <903383a6-f2c9-4a69-83c0-9be9c052d4be@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 03:02:36AM +0200, Artemy Kovalyov wrote:
> 
> 
> On 04/03/2019 00:37, John Hubbard wrote:
> > On 3/3/19 1:52 AM, Artemy Kovalyov wrote:
> > > 
> > > 
> > > On 02/03/2019 21:44, Ira Weiny wrote:
> > > > 
> > > > On Sat, Mar 02, 2019 at 12:24:35PM -0800, john.hubbard@gmail.com wrote:
> > > > > From: John Hubbard <jhubbard@nvidia.com>
> > > > > 
> > > > > ...
> > 
> > OK, thanks for explaining! Artemy, while you're here, any thoughts about the
> > release_pages, and the change of the starting point, from the other part of the
> > patch:
> > 
> > @@ -684,9 +677,11 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp,
> > u64 user_virt,
> > 	mutex_unlock(&umem_odp->umem_mutex);
> > 
> >    		if (ret < 0) {
> > -			/* Release left over pages when handling errors. */
> > -			for (++j; j < npages; ++j)
> release_pages() is an optimized batch put_page() so it's ok.
> but! release starting from page next to one cause failure in
> ib_umem_odp_map_dma_single_page() is correct because failure flow of this
> functions already called put_page().
> So release_pages(&local_page_list[j+1], npages - j-1) would be correct.

Someone send a fixup patch please...

Jason
