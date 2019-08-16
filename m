Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C76AC41514
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A9420665
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="I8NWKYwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfHPQbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 12:31:23 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33037 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfHPQbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:31:22 -0400
Received: by mail-qt1-f195.google.com with SMTP id v38so6751069qtb.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 09:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q07PDQQFTsBG0+IljaPmiFmWlKr48/NTXtftkV/guY4=;
        b=I8NWKYwa4+LMYIEL3v6vTz8y0vEwzbwwf2hFe9gwajh+1WXmOIgwGm77LQD0FK550N
         YmOgkBjEo+LxcVe3peySHrZqigyvY2ximEDABzQ24c1Y/aeMeENxU8q1MpRNsx2C0Yv2
         P6CSLX3qtWaTwMmlTJL7KqJuknLioR6OoiPRfqOUzT18MBUSa+JPVZhYJjZ5IkxM+Lpz
         IZPRCrp30aBEarURJEXC86jWyfx6cw5XV1zVfBpopUAIovi8AWgC/U7SbaB+i16OrJ3p
         glzrqXekDG7gZ9V2khdjtXapxYuhmKY9k6i12vc/eo2Vl+/8TFgLmknlVdSqNNh+ddMB
         VBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q07PDQQFTsBG0+IljaPmiFmWlKr48/NTXtftkV/guY4=;
        b=qTaLhh7+0iU+D3edDZHzkJFH8aXnGh9LGjTpvWJ8ek6TT34AZJWcDEdik8nozLizB2
         orT85D+kqPhhbJGF83rS3DWqzqFskkKYXV0gT8IICxB+f9FvRmmT0JU8erpCWpEoV7Cb
         dOaEkFdJu9bGXYQ7Sr/gTJnqMcP/Wd+oZcVPV/7ZmPlpwgGEjMuF+SO4Lw4t96LbSOkT
         J5qv10WcEG8znBh8CWWj+qx3gqeg+iaLB7zEPQbDcjoXHGeuwdWePEBm1myovDjkTYSk
         zDmxWXxkbxFLbsrjH+jtJ63V/mRnyGNpk1KpS2z0Fv8tEg90ITKlTHZNRI136riG4XqF
         AFow==
X-Gm-Message-State: APjAAAWOquFgPSqNJJWMx0mU1Unh1UBuTVOuKc05ZjwGnGHoWMHukHEe
        uXOZMMZgZ6HErBayb2p2YEnrrA==
X-Google-Smtp-Source: APXvYqyOu4QUIxVU7pL68pfhAnBIR85+JknyfuXMsLG/1jKGE4MxqYbqiE8sQom1Us1Ccd0ZveLEZw==
X-Received: by 2002:aed:3e6f:: with SMTP id m44mr9484086qtf.220.1565973081751;
        Fri, 16 Aug 2019 09:31:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id m10sm2903557qka.43.2019.08.16.09.31.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Aug 2019 09:31:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hyf8K-0007ns-SK; Fri, 16 Aug 2019 13:31:20 -0300
Date:   Fri, 16 Aug 2019 13:31:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Kara <jack@suse.cz>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] mm/gup: introduce vaddr_pin_pages_remote()
Message-ID: <20190816163120.GF5398@ziepe.ca>
References: <90e5cd11-fb34-6913-351b-a5cc6e24d85d@nvidia.com>
 <20190814234959.GA463@iweiny-DESK2.sc.intel.com>
 <2cbdf599-2226-99ae-b4d5-8909a0a1eadf@nvidia.com>
 <ac834ac6-39bd-6df9-fca4-70b9520b6c34@nvidia.com>
 <20190815132622.GG14313@quack2.suse.cz>
 <20190815133510.GA21302@quack2.suse.cz>
 <0d6797d8-1e04-1ebe-80a7-3d6895fe71b0@suse.cz>
 <20190816154404.GF3041@quack2.suse.cz>
 <20190816155220.GC3149@redhat.com>
 <20190816161355.GL3041@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816161355.GL3041@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 06:13:55PM +0200, Jan Kara wrote:

> > For 3 we do not need to take a reference at all :) So just forget about 3
> > it does not exist. For 3 the reference is the reference the CPU page table
> > has on the page and that's it. GUP is no longer involve in ODP or anything
> > like that.
> 
> Yes, I understand. But the fact is that GUP calls are currently still there
> e.g. in ODP code. If you can make the code work without taking a page
> reference at all, I'm only happy :)

We are working on it :)

Jason
