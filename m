Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB651C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 21:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA1B216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 21:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="b/X/epPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfIQV7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 17:59:24 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45726 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfIQV7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 17:59:24 -0400
Received: by mail-oi1-f195.google.com with SMTP id o205so4216802oib.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 14:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EW2X0pQcIs7IJCWHWbHBXgfW46P4WEaokqNG2sfuxAw=;
        b=b/X/epPQZvb6OMWkt3514aW9hqQaZrBWb5oRo9t5edo0vozE7mTuXDkbTXriqLoDW/
         7Lpvi/9JIpTNEoEaggzKS3c9BnQE/bWnb654MfzXAJiqtGubvaYUNoeRQY5b0fpbxhcD
         FTdD9L29UX/qm8jcbV9FJoD37EPZivjfBJJ4vawRi5z28eD2KZR6xqWnVyQPBTyuPwm4
         57f5Fk4dstqlRQm2abRzRFEVRoccjyPyyr1CAFZ3Umi45T5j+YTVY3kiUmY2xOx7v0QB
         NVpC00klzKEkF/2JKk87Y1cjVR5AdEYKn3OYS7BunXeat8pzVAqYYlu1dzWT6FLQo/pa
         tSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EW2X0pQcIs7IJCWHWbHBXgfW46P4WEaokqNG2sfuxAw=;
        b=pd9UI2vEJJaRqdLQJXp99r0mPwnBwO1JjUr/tsLUSB5S7lkkM+RqgzwvOWDo4YtLoW
         hVF4nzkgnGKMyQoh86Cwj+q035H0WLdQc15BCurzZOKbmDg12Nmr+fz3pT3yQv88RDIj
         ZbWjbc9yi4WBiXUW0UsfVTFPC8jj9UJr3Re2oHwbk6brzr1+qkj7hEJWSiLw90DA8BKr
         30yFp8z7ZQM2CdVwVsGet+/eIlBocUrKTUD8MOQCiOfFCYYhTtfrFLd1EWf839Gi4p6m
         1O3T/VhbJHXz0bqb83+a44eX5I7GemLwHrUZN2P4o/d6nn9y0/ysAgrUFIIUAW/LLcoV
         Dm+A==
X-Gm-Message-State: APjAAAVpHCyxsLdDwmlesbwepCbBFsX+RFo5HO0eZ/+8z3kvZ1Ew5raI
        aiXEHQ6y+S7WbwfWQv2AaK2xSTJmXh/wrIY6WqyZqOTp
X-Google-Smtp-Source: APXvYqzQPYBb+qMxeV1bDUw+oSHDBJ2boy2cSrkRRU5vlbjTkrG6EugFukBx4w0hTijgZ77pPvyEDk3fuZbESEyn/gI=
X-Received: by 2002:aca:eb09:: with SMTP id j9mr212586oih.105.1568757563411;
 Tue, 17 Sep 2019 14:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam> <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
 <20190913010937.7fc20d93@lwn.net> <20190913114849.GP20699@kadam> <20190917161608.GA12866@ziepe.ca>
In-Reply-To: <20190917161608.GA12866@ziepe.ca>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 17 Sep 2019 14:59:11 -0700
Message-ID: <CAPcyv4jR9ufeXyXOwnnPBC2kbHNfamZu93s4hM371=j-sACAjA@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 9:16 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Sep 13, 2019 at 02:48:50PM +0300, Dan Carpenter wrote:
>
> > It used to be that infiniband used "sizeof foo" instead of sizeof(foo)
> > but now there is a new maintainer.
>
> These days I run everything through checkpatch and generally don't
> want to see much deviation from the 'normal' style, a few minor
> clang-format quibbles and other check patch positives excluded.
>
> This means when people touch lines they have to adjust minor things
> like the odd 'sizeof foo' to make it conforming.
>
> Like others there is a big historical mismatch and the best I hope for
> is that new stuff follow the cannonical style. Trying to guess what
> some appropriate mongral style is for each patch is just a waste of my
> time.
>
> I also hold drivers/infiniband as an example of why the column
> alignment style is harmful. That has not aged well and is the cause of
> a lot of ugly things.
>
> > There is one subsystem where the maintainer is super strict rules that
> > you can't use "I" or "we" in the commit message.  So you can't say "I
> > noticed a bug while reviewing", you have to say "The code has a bug".
>
> Ah, the imperative mood nitpick. This one is very exciting to explain
> to non-native speakers. With many regular submitters I'm still at the
> "I wish you would use proper grammer and sentence structure" phase..
>
> These days I just end up copy editing most of the commit messages :(
>
> > I don't think it's shaming, I think it's validating.  Everyone just
> > insists that since it's written in the Book of Rules then it's our fault
> > for not reading it.  It's like those EULA things where there is more
> > text than anyone can physically read in a life time.
>
> Yeah, I tend to agree.
>
> The big special cases with high patch volumes (net being the classic
> example) should remain special.
>
> But everyone else is not special, and shouldn't act the same.
>
> The work people like DanC do with static analysis is valuable, and we
> should not be insisting that those contributors have to jump through a
> thousand special hoops.
>
> I have simply viewed it as the job of the maintainer to run the
> process and deal with minor nit picks on the fly.
>
> Maybe that is what we should be documenting?

In theory, yes, in practice, as long as there is an exception to the
rule, it comes down to a question of "is this case special like net or
not?". I'd rather not waste time debating that on a per-subsystem
basis vs just getting it all documented for contributors.

I do think it is worth clarifying in the guidelines of writing a
profile to make an effort to not be special, and that odd looking
rules will be questioned (like libnvdimm statement continuation), but
lets not fight the new standards fight until it becomes apparent where
the outliers lie.
