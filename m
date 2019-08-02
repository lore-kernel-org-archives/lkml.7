Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0CCC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344192182B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Bqm8lPIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404986AbfHBRYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:24:21 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36741 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404689AbfHBRYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:24:20 -0400
Received: by mail-qk1-f196.google.com with SMTP id g18so55373016qkl.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 10:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b/ZbdcC0DDz1oNoCfSGh30lpnC4X+0hWOBfmleHyzyg=;
        b=Bqm8lPIQh1rFwvAVca4MuGFlAzmCDYu5Rh+vK2o/lwsywYkM8FWq8PDerS1S494YUd
         YdRlqN86V3V07Ubkc9+u0LPC85tI9+nhfhgXLNTvG0jKt+2qsbDduSumpl+pf4RQrgiu
         /morBoV3u7YQ2MvhfXY3yuO815LwFDOzG+OPNzn+Yxd+d20QcyXCyAmyX/G2jnPicg8x
         ZmDxd4z0b8rzujaHcU5/9PkhjFkbO6/CdZXCXw4gkaClngdJY4k8vFwKphG0uzps+6rr
         fSkdfl5lEpvi8p/j3nr2rpHVff4rM27uBG1YJZnrHv0lUAHajWA+r+eYkDKDxwpzjfU8
         74YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b/ZbdcC0DDz1oNoCfSGh30lpnC4X+0hWOBfmleHyzyg=;
        b=WWGWGH0JuWbLziVkc09d5FAyp3VJlkuJ9SK6tul9HRrUFKlR2CYIlIoSyFYrVCabVf
         +zKZ1MP+UWi51yZiN1LfYeLi7zI7VKoipc1s4iDOYEE+ZlL08kBN/91J2b5EVZa7bsZu
         B9r9zUaxsfGOSww0999n98OlAIOcc3pp3lDVGtNpfuuAGr4mSQa5oHHuy8t3LNgIDMP1
         8iK2dhorp/EZaObEV3i6+SlaG2Rc7Bu7AP7GD9gd46EXOQdYXkfHR6s+8lf/DkYMGP70
         O+LHI/LkVCG9lpLVIqDsK/fh+x/wHQDjh4hrcNsPfBVRI76uz6jNC69ZJ97JzhMOyP6f
         I6PA==
X-Gm-Message-State: APjAAAWfrOqAgdD2PG3aIMv/Emf93zBpqJQzA16aQXlDkWj7Nnwq54IE
        JLgmXwFOfyJG+5e+mBSfT5aaMw==
X-Google-Smtp-Source: APXvYqz3bf1RYWu6U39GeHZIQdaItvlh7ks4r7TbDlC8NTybQtBARJwkp1RvWALo25T9mXOBSdzKwA==
X-Received: by 2002:a37:9d96:: with SMTP id g144mr92937157qke.288.1564766659730;
        Fri, 02 Aug 2019 10:24:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id l19sm41977618qtb.6.2019.08.02.10.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Aug 2019 10:24:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1htbHu-0005z3-NQ; Fri, 02 Aug 2019 14:24:18 -0300
Date:   Fri, 2 Aug 2019 14:24:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V2 7/9] vhost: do not use RCU to synchronize MMU notifier
 with worker
Message-ID: <20190802172418.GB11245@ziepe.ca>
References: <20190731084655.7024-1-jasowang@redhat.com>
 <20190731084655.7024-8-jasowang@redhat.com>
 <20190731123935.GC3946@ziepe.ca>
 <7555c949-ae6f-f105-6e1d-df21ddae9e4e@redhat.com>
 <20190731193057.GG3946@ziepe.ca>
 <a3bde826-6329-68e4-2826-8a9de4c5bd1e@redhat.com>
 <20190801141512.GB23899@ziepe.ca>
 <42ead87b-1749-4c73-cbe4-29dbeb945041@redhat.com>
 <20190802124613.GA11245@ziepe.ca>
 <20190802100414-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802100414-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 10:27:21AM -0400, Michael S. Tsirkin wrote:
> On Fri, Aug 02, 2019 at 09:46:13AM -0300, Jason Gunthorpe wrote:
> > On Fri, Aug 02, 2019 at 05:40:07PM +0800, Jason Wang wrote:
> > > > This must be a proper barrier, like a spinlock, mutex, or
> > > > synchronize_rcu.
> > > 
> > > 
> > > I start with synchronize_rcu() but both you and Michael raise some
> > > concern.
> > 
> > I've also idly wondered if calling synchronize_rcu() under the various
> > mm locks is a deadlock situation.
> > 
> > > Then I try spinlock and mutex:
> > > 
> > > 1) spinlock: add lots of overhead on datapath, this leads 0 performance
> > > improvement.
> > 
> > I think the topic here is correctness not performance improvement
> 
> The topic is whether we should revert
> commit 7f466032dc9 ("vhost: access vq metadata through kernel virtual address")
> 
> or keep it in. The only reason to keep it is performance.

Yikes, I'm not sure you can ever win against copy_from_user using
mmu_notifiers?  The synchronization requirements are likely always
more expensive unless large and scattered copies are being done..

The rcu is about the only simple approach that could be less
expensive, and that gets back to the question if you can block an
invalidate_start_range in synchronize_rcu or not..

So, frankly, I'd revert it until someone could prove the rcu solution is
OK..

BTW, how do you get copy_from_user to work outside a syscall?

Also, why can't this just permanently GUP the pages? In fact, where
does it put_page them anyhow? Worrying that 7f466 adds a get_user page
but does not add a put_page??

Jason
