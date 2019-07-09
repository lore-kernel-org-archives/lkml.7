Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E476C73C5A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF87D2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nJSBYwdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfGITdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 15:33:23 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46337 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfGITdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 15:33:22 -0400
Received: by mail-qk1-f194.google.com with SMTP id r4so16872758qkm.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 12:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TqnFX/ucbxcY5k2LU8B7XgzLfUpDzAFYa9LXap9J5UU=;
        b=nJSBYwdxUv5VMP0rEUMz93pcWQ28dTbOLxoOwrWHLWCf1MSxkLTpKz2x8fxtV2+E/R
         tXsUU3isWUYxjOPUM6t0qCMv560B5H1unNR0QcR5JPw3ycBYCoKo4LDe/wsMqNEhL/zl
         ZczdjxlpNisocOP3/OhjpkUf2xKW2V9mrCM6eDI3EmS5aK4e6AbXWsFA/MaZCNHhyEnk
         w4Z42pcMYK3A/nvN2x/95LPHdAv9lAcaP70awzU4Hvnyy2CUphCP4NqDwoLxyz/O5kpd
         AcIgjMsPHoTqJr8TeoXVzKWAKEnMRS83pZDgNEkgwGuWMagj18LeXUOa06mYcaDBm5pC
         i90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TqnFX/ucbxcY5k2LU8B7XgzLfUpDzAFYa9LXap9J5UU=;
        b=dU5zFgFMH35ueqzq8BzFId83tad+ZAQjxYAOo7xrD7kAySxb3HeSk2Gnt6qK4RR4ek
         wAYNjvQAhINp9hERV6Bl7yBxcEB0SAp25LvaS5vs+gpIVZiSP6FdooOfSAgPeUHfMif2
         2RwuNfCjeeQeHiMpK1lK+pmXlIHm6/7fGgS6Df0CDH9lpvzALDmTvIDKH9rdsGVTcf6N
         P41sRFdwu/xmmqpRp2r8Qrk95b2rs15ubF/BNP4+zmO8vW8i/tIZ7b9WmBhElmqS4L35
         7hxC8fbXJ7C0Ik72PzOjB/4LVaz0VrgNWvHK2UG7dcviuYZnWOeylyqeiOW1+4zhhUtt
         enVg==
X-Gm-Message-State: APjAAAX6JJMqIwV0JpRV18JVxR/uTIMpAmG3GaAr2crxBwyVFQWgZF8M
        blL/blZlkU7XsZYYn7qPet7mxg==
X-Google-Smtp-Source: APXvYqwJv1A9aQVqldMtbeBQ5nnec3iTfBKL3S6OeKUyA3kkYjNI/CON0uVEHClqFsFEEJNKMO/I9A==
X-Received: by 2002:a05:620a:1006:: with SMTP id z6mr2854127qkj.312.1562700801760;
        Tue, 09 Jul 2019 12:33:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 67sm9662013qkh.108.2019.07.09.12.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Jul 2019 12:33:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hkvrc-0003nt-Rl; Tue, 09 Jul 2019 16:33:20 -0300
Date:   Tue, 9 Jul 2019 16:33:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: hmm_range_fault related fixes and legacy API removal v2
Message-ID: <20190709193320.GD3422@ziepe.ca>
References: <20190703220214.28319-1-hch@lst.de>
 <20190705123336.GA31543@ziepe.ca>
 <20190709143038.GA3092@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190709143038.GA3092@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 04:30:38PM +0200, Christoph Hellwig wrote:
> On Fri, Jul 05, 2019 at 09:33:36AM -0300, Jason Gunthorpe wrote:
> > On Wed, Jul 03, 2019 at 03:02:08PM -0700, Christoph Hellwig wrote:
> > > Hi Jérôme, Ben and Jason,
> > > 
> > > below is a series against the hmm tree which fixes up the mmap_sem
> > > locking in nouveau and while at it also removes leftover legacy HMM APIs
> > > only used by nouveau.
> >
> > As much as I like this series, it won't make it to this merge window,
> > sorry.
> 
> Note that patch 4 fixes a pretty severe locking bug, and 1-3 is just
> preparation for that.  

Yes, I know, but that code is all marked STAGING last I saw, so I
don't feel an urgency to get severe bug fixes in for it after the
merge window opens.

I'd like to apply it to hmm.git when rc1 comes out with Ralph's test
result..

Jason
