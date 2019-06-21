Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BB5C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CCB2089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lktPUZjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfFUIlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 04:41:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34231 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfFUIlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 04:41:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so5740382wrl.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 01:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yKNFfzwEYl5/zmQazFDSNcBME8+4rbQsszyA7NJfvIc=;
        b=lktPUZjlhyjev2c/H8gl+b491BD8xfz0ChaGXpiJhMKTBq72aRixQo8wDTp4pOWWB5
         SrzZv/cyUMJhMaJJcrtby/qw1GMuNyZtBN5w0eP/n/K0b1yyFPG9cfKRTqO1ku69fYuX
         vPsO4HZ2wS6H0/JDSUs16OwS4k40YMBYeG+vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yKNFfzwEYl5/zmQazFDSNcBME8+4rbQsszyA7NJfvIc=;
        b=nXeZ0aF0nGl7N2d1LhcWT0G9qSf2pxa7IPb5X1s3Jz+Mpu7Ys2/ge+34rYJlI0slWK
         7kFww5oth5DDprWbbiuNH3Lxwg5rZE84YHyKx3UWHxsSxUTsIEUUhal1wc/Xaq2M3jcC
         SyUtHjukRj0yWxq2rhuIe2zkMr1PbFTGy6nmr9o+gl/PnbVe6aN8FlKMFwtReAtB3Mkt
         ZzHJpgpMVQtGQxjQ7UA9R26L1bqH6oS+QZYLYfa2w01R4CNY1WT9yzkOTZm54PipL6kt
         BtCLhKCEUg6FqatRuEayXFODwTpz+KZqcgfaiU/aZXoQf9dpC234fT8c8b3WPw75c1p/
         Kscw==
X-Gm-Message-State: APjAAAW6TaJDKEdMyMtRc0SgMtDO9Ik65kPsXUd7AZkX3Ye6+AxbEHFn
        JKVX9frAjmse7tQ0rjLPBYZxGg==
X-Google-Smtp-Source: APXvYqz3OqhXLRIgQgn7kziOC0JYPYQY419sagNtgzwSQ1M6Cj0jD4+bPUFJRkselh6xL3YqtDYsJw==
X-Received: by 2002:a5d:4e50:: with SMTP id r16mr9487976wrt.227.1561106497090;
        Fri, 21 Jun 2019 01:41:37 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id g11sm1753970wru.24.2019.06.21.01.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 01:41:36 -0700 (PDT)
Date:   Fri, 21 Jun 2019 10:41:29 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] tools: memory-model: Improve data-race detection
Message-ID: <20190621084129.GA6827@andrea>
References: <Pine.LNX.4.44L0.1906201153470.1512-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1906201153470.1512-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 11:55:58AM -0400, Alan Stern wrote:
> Herbert Xu recently reported a problem concerning RCU and compiler
> barriers.  In the course of discussing the problem, he put forth a
> litmus test which illustrated a serious defect in the Linux Kernel
> Memory Model's data-race-detection code.
> 
> The defect was that the LKMM assumed visibility and executes-before
> ordering of plain accesses had to be mediated by marked accesses.  In
> Herbert's litmus test this wasn't so, and the LKMM claimed the litmus
> test was allowed and contained a data race although neither is true.
> 
> In fact, plain accesses can be ordered by fences even in the absence
> of marked accesses.  In most cases this doesn't matter, because most
> fences only order accesses within a single thread.  But the rcu-fence
> relation is different; it can order (and induce visibility between)
> accesses in different threads -- events which otherwise might be
> concurrent.  This makes it relevant to data-race detection.
> 
> This patch makes two changes to the memory model to incorporate the
> new insight:
> 
> 	If a store is separated by a fence from another access,
> 	the store is necessarily visible to the other access (as
> 	reflected in the ww-vis and wr-vis relations).  Similarly,
> 	if a load is separated by a fence from another access then
> 	the load necessarily executes before the other access (as
> 	reflected in the rw-xbstar relation).
> 
> 	If a store is separated by a strong fence from a marked access
> 	then it is necessarily visible to any access that executes
> 	after the marked access (as reflected in the ww-vis and wr-vis
> 	relations).
> 
> With these changes, the LKMM gives the desired result for Herbert's
> litmus test and other related ones.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Reported-by: Herbert Xu <herbert@gondor.apana.org.au>

For the entire series:

Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>

Two nits, but up to Paul AFAIAC:

 - This is a first time for "tools: memory-model:" in Subject; we were
   kind of converging to "tools/memory-model:"...

 - The report preceded the patch; we might as well reflect this in the
   order of the tags.

Thanks,

  Andrea
