Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3485C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F34720665
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UB8ZjQ6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbfIQQQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:16:11 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42231 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfIQQQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 12:16:11 -0400
Received: by mail-qt1-f196.google.com with SMTP id g16so5074761qto.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 09:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wUSrZbzIskB5WIv6mGXsAI6kr8i5gc29LkRGwKVeGXM=;
        b=UB8ZjQ6t2RXRP4qUcxodQZxciXCCc7sxGAk2UUoDWxaB7d5HQ3MdDo5sdwrjqxk5L4
         Oo4MhddCK3g+VR/wr0z8ftJQ7PG/yHSdJOG/z+rOmnFb+XODTEZ73B2kKPrSC2xg3z1O
         UEZwV4cfvp7L7yD7Dg74u+oJKxy3rNk0KjMj9NCYoatcjrTj59pzE+c/hoqVEYS4nbKJ
         gHcjMVekrpawig5RFqZsai39k2ibTaAOmGGaEE5xiNnsQraObvK1GTRkASUVsU1+iA8P
         u3e5/MRCd9nJT81eyF4H27txFn4LKeR9TKwkCSspUtU9S1t01/WQGyBY0pBm0LrNmVTJ
         U5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wUSrZbzIskB5WIv6mGXsAI6kr8i5gc29LkRGwKVeGXM=;
        b=ooHMZU8bhEEDvjEBpPajgYcD3zBk8cR7VWU8IkoXf2+PJXVTQRNGNcAZAUMvWvDlN9
         yxi3wU8e0d94Q2MQIPvcwF3LfbhONSMHCtqTd7QAxt1CV3zJ+y2LCr5TMi3TZdT7UeGH
         jO31EY9A5aiwagzhAs0oJc8dSvOJpLrC/Fxm9a1OmGXOSgafu3/xzTLTLQ5/2oZT5uZ5
         D4g4alPli155bqqAfE/mAtcd4VJw+ZfsjQ9aublw0W/xbA0Ggn4yKlbmLiclLGebJ6Pb
         0I1DuAi5F0pEzpx84f3OENZjR7U0wvaybvVeNZCj4EF09jOaiKqTjCgL5D65S4q8KOoI
         8dxA==
X-Gm-Message-State: APjAAAX9Td4ScDJkPObGtsI5bn83vbC/+lr7seGZ884tFYy89Z4gipN7
        juH9sP4AEEuc9BzUHAIsiXpwZw==
X-Google-Smtp-Source: APXvYqxhRx/kCEQ+mWvLpcBHWrhM2cXxzhSNrnf0x3fx4s9weIUtltlWrAZoFR448w68N1H6KAMkjw==
X-Received: by 2002:a0c:be88:: with SMTP id n8mr3759902qvi.67.1568736970347;
        Tue, 17 Sep 2019 09:16:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-223-10.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.223.10])
        by smtp.gmail.com with ESMTPSA id f144sm1325940qke.132.2019.09.17.09.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Sep 2019 09:16:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iAG9B-0003iJ-0R; Tue, 17 Sep 2019 13:16:09 -0300
Date:   Tue, 17 Sep 2019 13:16:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
Message-ID: <20190917161608.GA12866@ziepe.ca>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam>
 <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
 <20190913010937.7fc20d93@lwn.net>
 <20190913114849.GP20699@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913114849.GP20699@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 02:48:50PM +0300, Dan Carpenter wrote:

> It used to be that infiniband used "sizeof foo" instead of sizeof(foo)
> but now there is a new maintainer.

These days I run everything through checkpatch and generally don't
want to see much deviation from the 'normal' style, a few minor
clang-format quibbles and other check patch positives excluded.

This means when people touch lines they have to adjust minor things
like the odd 'sizeof foo' to make it conforming.

Like others there is a big historical mismatch and the best I hope for
is that new stuff follow the cannonical style. Trying to guess what
some appropriate mongral style is for each patch is just a waste of my
time.

I also hold drivers/infiniband as an example of why the column
alignment style is harmful. That has not aged well and is the cause of
a lot of ugly things.

> There is one subsystem where the maintainer is super strict rules that
> you can't use "I" or "we" in the commit message.  So you can't say "I
> noticed a bug while reviewing", you have to say "The code has a bug".

Ah, the imperative mood nitpick. This one is very exciting to explain
to non-native speakers. With many regular submitters I'm still at the
"I wish you would use proper grammer and sentence structure" phase..

These days I just end up copy editing most of the commit messages :(

> I don't think it's shaming, I think it's validating.  Everyone just
> insists that since it's written in the Book of Rules then it's our fault
> for not reading it.  It's like those EULA things where there is more
> text than anyone can physically read in a life time.

Yeah, I tend to agree.

The big special cases with high patch volumes (net being the classic
example) should remain special.

But everyone else is not special, and shouldn't act the same.

The work people like DanC do with static analysis is valuable, and we
should not be insisting that those contributors have to jump through a
thousand special hoops.

I have simply viewed it as the job of the maintainer to run the
process and deal with minor nit picks on the fly.

Maybe that is what we should be documenting? 

Jason
