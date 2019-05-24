Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0858AC282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6642175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="eGczKoO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390554AbfEXQ1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 12:27:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43944 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390337AbfEXQ1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 12:27:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id w33so11791428edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 09:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5uGnJY6+WIJldncn5/DuJlJfSiMsN3sDHc0cFO6evKw=;
        b=eGczKoO2oK1LxqRDUeq+D7nDJHBIb4XMUraNpLr4yOcOAsFgoTd33a5I2wq/sPLj5m
         cv4CL9Pysa7bfIL+Jn+vSSY2Z0bldZYmz/9YA39+pTt/iA6nk2Z39gXEHUQfsENbPGDq
         9COrk8k8zvaBOZH4FfeULv1UGUcPpYkvd+miQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=5uGnJY6+WIJldncn5/DuJlJfSiMsN3sDHc0cFO6evKw=;
        b=VqP9aL/WEG3CkIqLCRqPWWauuGfsQbTvnxAQBRQats0u68Z2LqHRdHpewipA9C8sAj
         hN0Ll3ivsjMF7PGHeLxi/esCgMsBeRofEEcdzKf1rrq7jdkh9IYcdglqmtYR3ng2p8Wv
         GN4wVIOzlrft/zLhRfSwmf9hx1EIrN828ZLcuLxd/xVkZECoZ8yjzKXphIDWETrh/xF4
         ZnlKv85OfYnANQJV6wVEtp4ryFYHlJ4uP8ZYOlrUqQEcB61XkKI5eOxRDEv0EKX+j9oQ
         k0/JNrsOscFb6HEhLxfC1he3PNAakQBChoH2ehYPBgvWdbJLNQ2aN41+YX1TI2PrbKIs
         wcig==
X-Gm-Message-State: APjAAAX3IH4pYJLvrYiR7zhAGmHCW+OY1I6xW4BunZ0rvCSxY4syL5Ob
        CYvWjxwWQjcOvdNZslzR1nRg+/FdZ8I=
X-Google-Smtp-Source: APXvYqz+Z4CiuIPAkdi1mB6lLRW1WTeonKTLCscAeQw4ulK7kt9ebJAos6eSJA0Dpqv9o1VxaTHnkw==
X-Received: by 2002:a17:906:6a02:: with SMTP id o2mr57101777ejr.164.1558715233065;
        Fri, 24 May 2019 09:27:13 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id m16sm418816ejj.57.2019.05.24.09.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 09:27:12 -0700 (PDT)
Date:   Fri, 24 May 2019 18:27:09 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
        Dave Airlie <airlied@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jerome Glisse <jglisse@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        linux-mm@kvack.org, dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: RFC: Run a dedicated hmm.git for 5.3
Message-ID: <20190524162709.GD21222@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
        Dave Airlie <airlied@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        linux-mm@kvack.org, dri-devel <dri-devel@lists.freedesktop.org>
References: <20190523150432.GA5104@redhat.com>
 <20190523154149.GB12159@ziepe.ca>
 <20190523155207.GC5104@redhat.com>
 <20190523163429.GC12159@ziepe.ca>
 <20190523173302.GD5104@redhat.com>
 <20190523175546.GE12159@ziepe.ca>
 <20190523182458.GA3571@redhat.com>
 <20190523191038.GG12159@ziepe.ca>
 <20190524064051.GA28855@infradead.org>
 <20190524124455.GB16845@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524124455.GB16845@ziepe.ca>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 09:44:55AM -0300, Jason Gunthorpe wrote:
> On Thu, May 23, 2019 at 11:40:51PM -0700, Christoph Hellwig wrote:
> > On Thu, May 23, 2019 at 04:10:38PM -0300, Jason Gunthorpe wrote:
> > > 
> > > On Thu, May 23, 2019 at 02:24:58PM -0400, Jerome Glisse wrote:
> > > > I can not take mmap_sem in range_register, the READ_ONCE is fine and
> > > > they are no race as we do take a reference on the hmm struct thus
> > > 
> > > Of course there are use after free races with a READ_ONCE scheme, I
> > > shouldn't have to explain this.
> > > 
> > > If you cannot take the read mmap sem (why not?), then please use my
> > > version and push the update to the driver through -mm..
> > 
> > I think it would really help if we queue up these changes in a git tree
> > that can be pulled into the driver trees.  Given that you've been
> > doing so much work to actually make it usable I'd nominate rdma for the
> > "lead" tree.
> 
> Sure, I'm willing to do that. RDMA has experience successfully running
> shared git trees with netdev. It can work very well, but requires
> discipline and understanding of the limitations.
> 
> I really want to see the complete HMM solution from Jerome (ie the
> kconfig fixes, arm64, api fixes, etc) in one cohesive view, not
> forced to be sprinkled across multiple kernel releases to work around
> a submission process/coordination problem.
> 
> Now that -mm merged the basic hmm API skeleton I think running like
> this would get us quickly to the place we all want: comprehensive in tree
> users of hmm.
> 
> Andrew, would this be acceptable to you?
> 
> Dave, would you be willing to merge a clean HMM tree into DRM if it is
> required for DRM driver work in 5.3?
> 
> I'm fine to merge a tree like this for RDMA, we already do this
> pattern with netdev.
> 
> Background: The issue that is motivating this is we want to make
> changes to some of the API's for hmm, which mean changes in existing
> DRM, changes in to-be-accepted RDMA code, and to-be-accepted DRM
> driver code. Coordintating the mm/hmm.c, RDMA and DRM changes is best
> done with the proven shared git tree pattern. As CH explains I would
> run a clean/minimal hmm tree that can be merged into driver trees as
> required, and I will commit to sending a PR to Linus for this tree
> very early in the merge window so that driver PR's are 'clean'.
> 
> The tree will only contain uncontroversial hmm related commits, bug
> fixes, etc.
> 
> Obviouisly I will also commit to providing review for patches flowing
> through this tree.

Sure topic branch sounds fine, we do that all the time with various
subsystems all over. We have ready made scripts for topic branches and
applying pulls from all over, so we can even soak test everything in our
integration tree. In case there's conflicts or just to make sure
everything works, before we bake the topic branch into permanent history
(the main drm.git repo just can't be rebased, too much going on and too
many people involvd).

If Jerome is ok with wrestling with our scripting we could even pull these
updates in while the hmm.git tree is evolving.

Cheers, Daniel
(drm co-maintainer fwiw)
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
