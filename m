Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49775C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A443214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dbPP9lBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfCLPxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:53:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36116 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfCLPxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:53:10 -0400
Received: by mail-qt1-f193.google.com with SMTP id b3so3117313qtj.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QcPGxotBvu4iLj90nikA7ZEmDk5xqgqrWN30Zzt/GHo=;
        b=dbPP9lBM9Vpwl8UqgK2FiG73wqfxxhFr5e/jw73ZhZcIhH6CkbAN6oCvQDucYiWs5I
         JDALIPaDkwHb9EbDQOT2uIcCJchKq5aPZRNB+scgKHVFC8HZwrEMpA+W4lU0Fb1Vx7qV
         aq/C8eg1BT488SLziv9InsoOWyVPjr0B+KEaidQrgJH3iJpsAYV7a/nHR4BVRH6NXQoK
         ZqK6wD7Ox7rAvobJjG2GPPrEUhdKDozEkuDMO1KsUBEfGcWVTg8yl1yk6lpURTBJiYp8
         TFAty+mWGYB7KnRqfP3UkkDJdWQjjlSll/wWP6+tv3C+L2De8lgUqO+G7NZV7xowViW0
         cOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QcPGxotBvu4iLj90nikA7ZEmDk5xqgqrWN30Zzt/GHo=;
        b=n9BssC01dVBDpE66j0aQidhkKAmjiGct74gRTLYSziC8/j6u2re+GkegT1+65ouj1I
         n/kFS+ZmtI3ONBhsoSgAlLqsrBIPX2/bmp1GwZgOTuqdrTKn00dgeEV/tCEJX61GD/dd
         pUWQ23G8U8JGzS/DIrrjENU23yTH1suoyBo9E0d7o9IeUihGyswH/pc5W2WR6EFr/8ft
         S8WXONxX9yUAduWDkm/XvXk0WUWFuCHJLMyST3nb9cpwtB8U1h9mHwRlO6TRRpHyujS0
         vWn6Or3FSsSNXxWaunR1wevSMH9my+/euiJfMD+L5JV7olpbkBfUQ7tNb79p4IDkJRTe
         EsZw==
X-Gm-Message-State: APjAAAX+fvir01VByvGjQ8ZiONI2F71BmiUpKgrHUhOKmj7frHRufABU
        dvOtSLAf7VHsBW/fsy6jzOubVA==
X-Google-Smtp-Source: APXvYqx+bB0cu7zBn/5pp5qfiV/PWk0wKQn1c5Yq7D+NffNMoWoccLsBRobU7B2oICXVHxWT2ZqYPA==
X-Received: by 2002:ac8:5297:: with SMTP id s23mr29738624qtn.371.1552405989409;
        Tue, 12 Mar 2019 08:53:09 -0700 (PDT)
Received: from ziepe.ca ([24.137.65.181])
        by smtp.gmail.com with ESMTPSA id h18sm4893517qkj.50.2019.03.12.08.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 08:53:08 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1h3jiF-0002rT-AW; Tue, 12 Mar 2019 12:53:07 -0300
Date:   Tue, 12 Mar 2019 12:53:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Christopher Lameter <cl@linux.com>, john.hubbard@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 0/1] mm: introduce put_user_page*(), placeholder
 versions
Message-ID: <20190312155307.GD20037@ziepe.ca>
References: <20190306235455.26348-1-jhubbard@nvidia.com>
 <010001695b4631cd-f4b8fcbf-a760-4267-afce-fb7969e3ff87-000000@email.amazonses.com>
 <20190308190704.GC5618@redhat.com>
 <01000169703e5495-2815ba73-34e8-45d5-b970-45784f653a34-000000@email.amazonses.com>
 <20190312153528.GB3233@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312153528.GB3233@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 11:35:29AM -0400, Jerome Glisse wrote:
> > > > Yes you now have the filesystem as well as the GUP pinner claiming
> > > > authority over the contents of a single memory segment. Maybe better not
> > > > allow that?
> > >
> > > This goes back to regressing existing driver with existing users.
> > 
> > There is no regression if that behavior never really worked.
> 
> Well RDMA driver maintainer seems to report that this has been a valid
> and working workload for their users.

I think it is more O_DIRECT that is the history here..

In RDMA land long term GUPs of file backed pages tend to crash the
kernel (what John is trying to fix here) so I'm not sure there are
actual real & tested users, only people that wish they could do this..

Jason
