Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CD9C76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B770223A1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AIBWSs3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389846AbfGWMrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 08:47:10 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46851 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389797AbfGWMrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:47:10 -0400
Received: by mail-qt1-f193.google.com with SMTP id h21so41680177qtn.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 05:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=piZ8i8TowZ2SsXDzt8tX5OF8nKyYqoULcyfh5zRNZ38=;
        b=AIBWSs3L6TMrqR1kjSjiMOoco1Jvz8sMlyjAm/koUlgASb3F1pge4pF62yhgDzaLyN
         8W6kJiJVRv2Ltl10P0KJ3h4Rxv4Sqan/wDHsLcdXsjf9MrtAiVLfb6MvuqzOUpw1Pvo5
         nfDvSBFzcy4NTtXExC58RlVhp7zb6QbnLZPrvQwNNigrLSQSCT0Y7gE3jAYG9SExooUW
         JtXIQ7nuInz2UXqhOw5OA3nFxJXlzY3ERVxPfPBlTt9/UEojN9Wnpkk9roKmmsv/AIWs
         aeioIMb0c14NQnQgfwpCWB/P0nQs5B9LzMw6NDgi8cvJhVre3EHc/K68PAB7f3zGy6Lb
         WGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=piZ8i8TowZ2SsXDzt8tX5OF8nKyYqoULcyfh5zRNZ38=;
        b=ECvLiWHRVCY9DtJvOWYbCZFd2oQlBepALBo/VxSyPioi8zKKkAYDb90z5VOkHyBakU
         uJYOFg63qiimB2AdyDdkWiyQeywuYODgoR3IZrggJkuoV9ztWENLTEcL7U6QOBrsiCIQ
         Nyr/trizksRu4y2FL5BlhEuA2Uh3Kyb2TinRlI98lVX1LnvpLA12oGyQtQZJBNaUcEdI
         xbrCFwYigfniaBQK9lAo+a3rMFR31iEVSfCK2X/TyLnNfveIlCplKpQi412EkfQTuzNI
         2ErRiboo3fqHGsSRNDS3tz8mqx0OTRjpI7PFGByeiBGDIUz2C4f35BCOXXEBCKW8LL80
         aa3w==
X-Gm-Message-State: APjAAAW1WWB4mNUpHJUnRuQOoeDb7uJdKk+d1XtQXCfitVS9HJc2G0oK
        JPfjK4iRAH+x4gALUd3BMgRs8Q==
X-Google-Smtp-Source: APXvYqyDweYbQsaT3Kt4MRrQs5/v1m87TpQW/FZm/84f2JQiv3oW3vaHuL2MCkVEVWkDHF7BwFh/Mg==
X-Received: by 2002:ac8:877:: with SMTP id x52mr53156167qth.328.1563886029140;
        Tue, 23 Jul 2019 05:47:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id q3sm19357570qkq.133.2019.07.23.05.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 05:47:08 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hpuCB-0004tl-I7; Tue, 23 Jul 2019 09:47:07 -0300
Date:   Tue, 23 Jul 2019 09:47:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, john.hubbard@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Boaz Harrosh <boaz@plexistor.com>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        David Airlie <airlied@linux.ie>,
        "David S . Miller" <davem@davemloft.net>,
        Ilya Dryomov <idryomov@gmail.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ming Lei <ming.lei@redhat.com>, Sage Weil <sage@redhat.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Yan Zheng <zyan@redhat.com>, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] net/xdp: convert put_page() to put_user_page*()
Message-ID: <20190723124707.GB15357@ziepe.ca>
References: <20190722223415.13269-1-jhubbard@nvidia.com>
 <20190722223415.13269-4-jhubbard@nvidia.com>
 <20190723002534.GA10284@iweiny-DESK2.sc.intel.com>
 <a4e9b293-11f8-6b3c-cf4d-308e3b32df34@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4e9b293-11f8-6b3c-cf4d-308e3b32df34@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 09:41:34PM -0700, John Hubbard wrote:

> * The leading underscores are often used for the more elaborate form of the
> call (as oppposed to decorating the core function name with "_flags", for
> example).

IMHO usually the __ version of a public symbol means something like
'why are you using this? you probably should not'

Often because the __ version has no locking or some other dangerous
configuration like that.

Jason
