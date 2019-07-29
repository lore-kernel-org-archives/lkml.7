Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB66C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C80206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nJsQ4APg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfG2NmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:42:20 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38005 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfG2NmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:42:20 -0400
Received: by mail-qk1-f193.google.com with SMTP id a27so44151559qkk.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 06:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IfCi/dO4p77O3IWTYEfGSy4zB7Nta8rM4/jOE2XnS8Q=;
        b=nJsQ4APgOoZKWhWllwsjb96+i0qhmQEeAZoJPpvZ7IRi45JcZ4aJ73OIzM/eQyaUnj
         cECyIAjga8y9r0g6jwWXTceVpE8vSjf7ITPRMKxtuSYgsvmU9cmJfFVeuciMyvvrTXV3
         bCDkRsrT1XhW76iE4zhBeSShPMwbofiGuD/7eJFAmpHmfjMq8n6AGD3PrjTD90iT+wlu
         xqG+DNf7NXV58GYrtJFtJcqXG/HG5Kqg+jlZUBKDXR3o4Kcj3NuT6KXMm0z4cSACwjfR
         1qt/RGK+gCv+DJoJGRWPCYWZg/G0eK1ha5P3K2C3vWhevK9hYVjDE5BZM9eQ8PjNINxB
         lcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IfCi/dO4p77O3IWTYEfGSy4zB7Nta8rM4/jOE2XnS8Q=;
        b=EnBsH370alq0MQf5XQUAQNi1OYUYuyWyKXGJPV5yNwPbW7jVJj2ne3m4ErKTMCabyv
         TlmKNCR1FB16opy4eL9N9oPvpyfc7JNBbVbclqttifmVRC9fH5mJg465so6vsuRVqIzV
         LhSITXuPY1Q8OnQuUzlQZM9aXYphs5nZE70G02IgYAxSI/gdfKqTfSjl2NVjg2NHdGEe
         nq9gvoCWOw8EZGq1dMeGJFp9gjhfk9aGTyj8Wf/BsBEztwNRXkiKdVo3Do/h4nBwRWUe
         em6WVsBV3REJg+yKend4nDRJrZNgtyx+jyfksHht2bWPa91FvvFHnRGxMHWJ8BpYf8Yn
         epZg==
X-Gm-Message-State: APjAAAUU4eSYqkwN7mqs2xkx5k0zCB4iz7TXX4mAXrshiNxqhXOAHffk
        dVNJBTDS4byVK+GyucNctX5rcZ04W6QlhA==
X-Google-Smtp-Source: APXvYqw5wO1rHdWS2OfTb/oy25JsTnkZ80tIy0+oxpGcEdhSoOTxEjjkfXN855pvFFcNiA5ipseW5w==
X-Received: by 2002:a37:d245:: with SMTP id f66mr73336727qkj.59.1564407739075;
        Mon, 29 Jul 2019 06:42:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id m4sm24934229qka.70.2019.07.29.06.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 06:42:18 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hs5ur-0006fl-RS; Mon, 29 Jul 2019 10:42:17 -0300
Date:   Mon, 29 Jul 2019 10:42:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Henriques <lhenriques@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH] mm: Make kvfree safe to call
Message-ID: <20190729134217.GA17990@ziepe.ca>
References: <20190726210137.23395-1-willy@infradead.org>
 <20190729092830.GB10926@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729092830.GB10926@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 11:28:30AM +0200, Michal Hocko wrote:
> On Fri 26-07-19 14:01:37, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > Since vfree() can sleep, calling kvfree() from contexts where sleeping
> > is not permitted (eg holding a spinlock) is a bit of a lottery whether
> > it'll work.  Introduce kvfree_safe() for situations where we know we can
> > sleep, but make kvfree() safe by default.
> 
> So now you have converted all kvfree callers to an atomic version. Is
> that really desirable? Aren't we adding way too much work to be done in
> a deferred context? If not then why a regular vfree cannot do this
> already and then we do not need vfree_atomic and kvfree_safe.

I know infiniband has kvfree calls under user control, mayne uses of
kvfree are related to allocating kernel memory for some potentially
large user data on the syscall path.. 

I'm also nervous about making them all queuing.

If we added kvfree_atomic() & a warning how many places would hit the
warning and need conversion?

Jason
