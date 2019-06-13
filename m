Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4E9C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1121D21721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="V4uYx3PC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfFMXpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 19:45:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45025 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfFMXpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 19:45:31 -0400
Received: by mail-qt1-f193.google.com with SMTP id x47so445619qtk.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 16:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3+t+8plqnMDu5LItEINv+R5LzGXlbnOEW8lA7KqYoSA=;
        b=V4uYx3PC9/Kgy2M4ZekgvRKvGqR7t7tO5empinBcdD/vjjrTDNXNvOpJr4/tQqqwEv
         pgwxcXIhwGK63QcFR+H2l9DHorWqNbCBtL/l6TDJJHIPYNsX9L9ltGsrgYOW3djbfTBk
         +CXWBZJDK9oBlsTLuRXbHuNYYhdEA1G3FVTmNkzNArpZNxg9Y+HQQ0VSyzjYgYXSbRs9
         dsl1IHcwMZEtpAJdgQWfZ90e/nLGeyYk/+rPuZQscIiBjl8tNgkwswTbzSy2Qj7AjBEY
         8qq4PDFRq3uqJPA6SKTJGsY5tJs7i3mv34NRvdlqzlDhrOcr5qUMSiJ4ZEoA8UNdsYha
         GrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3+t+8plqnMDu5LItEINv+R5LzGXlbnOEW8lA7KqYoSA=;
        b=lQNiFttc4EN9kkZrK5zAUCt3L9OG/WVq9sCzXXmd5i6phm9i5YIIjwO0gfzBG/Gwj2
         8qqsT/a767HbGh7IDjfMLSFQF6MsHX7ogKKqaqUnHlzaEDJ3mpSXQq+8i1Hh5hL+ANX9
         fw0APlmBAtK1FxHxbc063DoQGszR8CBdlyPpLGyCI5ORbulnzXdVp9/n3cOJR2wpTD+D
         On4zhgiNGeAvS8OzsSEbW0rhSd0LMCNJ8Yc3Cl71xDWBvRaVbFo8xg5zcFcG5IgxuFsY
         oc4g4S0o5DezrZAEljmSJLHrYpYFENZ1lPitmlTx6s9fbJ2aNVzzxssUlTmWwOehHyGD
         TWkw==
X-Gm-Message-State: APjAAAUeFaVhuNSHFhd81bunOZJIOdDeRynCKF39nnDU6eRX5eVdy177
        1bKOp65umQAZzZAJh6wETD/AcQ==
X-Google-Smtp-Source: APXvYqyYGz8y4mU0RR/vAVXwfFNX88unrTDt/8bHx6WUKQJx5OGFlsQT6pP8kmmk4D4YyMl9wIuX5A==
X-Received: by 2002:ac8:2f7b:: with SMTP id k56mr66798515qta.376.1560469531072;
        Thu, 13 Jun 2019 16:45:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o6sm757625qtc.47.2019.06.13.16.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 16:45:30 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbZPO-00019B-4b; Thu, 13 Jun 2019 20:45:30 -0300
Date:   Thu, 13 Jun 2019 20:45:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Jeff Layton <jlayton@kernel.org>, linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190613234530.GK22901@ziepe.ca>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
 <20190607110426.GB12765@quack2.suse.cz>
 <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
 <20190608001036.GF14308@dread.disaster.area>
 <20190612123751.GD32656@bombadil.infradead.org>
 <20190613002555.GH14363@dread.disaster.area>
 <20190613152755.GI32656@bombadil.infradead.org>
 <20190613211321.GC32404@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613211321.GC32404@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 02:13:21PM -0700, Ira Weiny wrote:
> On Thu, Jun 13, 2019 at 08:27:55AM -0700, Matthew Wilcox wrote:
> > On Thu, Jun 13, 2019 at 10:25:55AM +1000, Dave Chinner wrote:
> > > e.g. Process A has an exclusive layout lease on file F. It does an
> > > IO to file F. The filesystem IO path checks that Process A owns the
> > > lease on the file and so skips straight through layout breaking
> > > because it owns the lease and is allowed to modify the layout. It
> > > then takes the inode metadata locks to allocate new space and write
> > > new data.
> > > 
> > > Process B now tries to write to file F. The FS checks whether
> > > Process B owns a layout lease on file F. It doesn't, so then it
> > > tries to break the layout lease so the IO can proceed. The layout
> > > breaking code sees that process A has an exclusive layout lease
> > > granted, and so returns -ETXTBSY to process B - it is not allowed to
> > > break the lease and so the IO fails with -ETXTBSY.
> > 
> > This description doesn't match the behaviour that RDMA wants either.
> > Even if Process A has a lease on the file, an IO from Process A which
> > results in blocks being freed from the file is going to result in the
> > RDMA device being able to write to blocks which are now freed (and
> > potentially reallocated to another file).
> 
> I don't understand why this would not work for RDMA?  As long as the layout
> does not change the page pins can remain in place.

Because process A had a layout lease (and presumably a MR) and the
layout was still modified in way that invalidates the RDMA MR.

Jason
