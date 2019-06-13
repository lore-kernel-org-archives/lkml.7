Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB285C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B422082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ez3y4b43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfFMP37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:29:59 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39375 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731692AbfFMP3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:29:55 -0400
Received: by mail-qt1-f195.google.com with SMTP id i34so23016126qta.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 08:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zI+cml8WbrmbJ9toyFXRrApWdKeWP1klnItjSAKRPGg=;
        b=ez3y4b43vsN45W2H2bDstmo6Om2wBZpYtJKgMMjQ9NBoecm8EqzxMc/rNSpmMUBedy
         80Ex/NCrVk0GjamXc8tFY6oZxMeqGSAa2XxliMKTTtJWm/Hdv+7/O2TlnSRLVmYLMjc1
         8QLaCJlqlQNIG4Wtw5O1fja9ybK4S3vwEG6x4PLpKGnKhfBKyUDjUSuJ7Daf2FmV0ukB
         Fiy/FGLk6V0O5Od1WI6hEe1YQb2rKTshssT0ZDeknDIfsjbY9xOSOCaaERP1VJPOdnB9
         Me1HNUVA3ivb0wrw4Jz0PdvTbXzAgXVoN/LwODHkV6bcRV7ByakROGDgfhqlpDrkzCce
         zwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zI+cml8WbrmbJ9toyFXRrApWdKeWP1klnItjSAKRPGg=;
        b=Kf7Pk0qC4d9cLmpXPfpQ5GIT/Sb3GgZsn/llAdiDOKMnTOFik1MCB6xsjF6kd/DOMg
         WYzPIfBmrsOg4ilWaRHgqEOqbEnVj3CxweA7eP1Idi9TKNpO0SPg3uPe0u0fMYoAcIUY
         QpYRl4nDIPTLtXiqGBo0Opcla+G5/e4OD+unPPtwzFlPjfbymproWrp5MiHp1/byAkld
         UvwiAosBUyvWVrM0it7bIkezpK922VnNVwm39OXaiVQkAXAdY1lCGZD6lpmizNAOsWiu
         /0N47tlXR6RhSAO5EV/j4aM4xQoLYl/KIwbd5vg8NP/Q+NdqqjYc5rf8NAJT/I2z7uR+
         4LVA==
X-Gm-Message-State: APjAAAV8q6dyBnBdPOVNUE9l2av+vHP0fCZNFdSpO8TKqQnBaGdRKtsL
        xSNdhhkpKB3KG2WElIIfJJi1Vg==
X-Google-Smtp-Source: APXvYqxumou76h8DgPuXHGACUFtVz1bj3RAtdr2UUPeKh8lpCv3ZK4QnjNs+8s/8x74HDjzAfBeu7Q==
X-Received: by 2002:a0c:b163:: with SMTP id r32mr4246320qvc.169.1560439794791;
        Thu, 13 Jun 2019 08:29:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id s66sm1645906qkh.17.2019.06.13.08.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 08:29:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbRfl-0001zA-RQ; Thu, 13 Jun 2019 12:29:53 -0300
Date:   Thu, 13 Jun 2019 12:29:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
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
Message-ID: <20190613152953.GD22901@ziepe.ca>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
 <20190607110426.GB12765@quack2.suse.cz>
 <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
 <20190608001036.GF14308@dread.disaster.area>
 <20190612123751.GD32656@bombadil.infradead.org>
 <20190613002555.GH14363@dread.disaster.area>
 <20190613032320.GG32656@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613032320.GG32656@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 08:23:20PM -0700, Matthew Wilcox wrote:
> On Thu, Jun 13, 2019 at 10:25:55AM +1000, Dave Chinner wrote:
> > On Wed, Jun 12, 2019 at 05:37:53AM -0700, Matthew Wilcox wrote:
> > > That's rather different from the normal meaning of 'exclusive' in the
> > > context of locks, which is "only one user can have access to this at
> > > a time".
> > 
> > Layout leases are not locks, they are a user access policy object.
> > It is the process/fd which holds the lease and it's the process/fd
> > that is granted exclusive access.  This is exactly the same semantic
> > as O_EXCL provides for granting exclusive access to a block device
> > via open(), yes?
> 
> This isn't my understanding of how RDMA wants this to work, so we should
> probably clear that up before we get too far down deciding what name to
> give it.
> 
> For the RDMA usage case, it is entirely possible that both process A
> and process B which don't know about each other want to perform RDMA to
> file F.  So there will be two layout leases active on this file at the
> same time.  It's fine for IOs to simultaneously be active to both leases.
> But if the filesystem wants to move blocks around, it has to break
> both leases.
> 
> If Process C tries to do a write to file F without a lease, there's no
> problem, unless a side-effect of the write would be to change the block
> mapping, in which case either the leases must break first, or the write
> must be denied.
> 
> Jason, please correct me if I've misunderstood the RDMA needs here.

Yes, I think you've captured it

Based on Dave's remarks how frequently a filesystem needs to break the
lease will determine if it is usuable to be combined with RDMA or
not...

Jason
