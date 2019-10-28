Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208ABCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F135621744
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbfJ1Q37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:29:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35625 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731006AbfJ1Q36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:29:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id x6so1789681pln.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 09:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/8Rur5Pty80k5lMPnsEahXbKqsft7F2CsN6kEZIOz70=;
        b=sZGHfis8SxT7PDy4BnFG9d9khmAs7D0xY82w0NiROTk9y8cAL3Mfm+JccTBx502v0l
         5FHTEHkYaJ1JrxXYPynO22BJluJsmBBkLWru2W+2fEFEUTUljaicTXxihoxENqZyWfTY
         9LS08zGaB9x9E5MMsfOA5MeKQJ2/GoQvmSM3F5zr4Dqs6KS+IjTeT8TA1NfrBq74ekc/
         WtE9PcZFYj8TUxEvwfjVGysIaCRwiEDl3YbUeRr6ndrNG55FoGtHmXoQqfLPgdA7Nbf9
         ImCrpp6hY24/zfZGmT+x28YDaT6qBN2JSwp+cAm4C9lXlRwvg1UvvwHONOyVfiqXp0dh
         M3PQ==
X-Gm-Message-State: APjAAAX9f7rqV7iPvPM1d6oyTy2IjpF9q6x+fmeg4u7ZfKSZJrNaX5Jq
        iCpTYnlZyX+Zs0xVZLkbm47Owb+CsDU=
X-Google-Smtp-Source: APXvYqyB3RWH6nYv7x0esbua2q9ojgiV2P6KlFMaQB7idk9fb+6U1s2NeegBOpsT8MQU5oDDsG5ZKw==
X-Received: by 2002:a17:902:a98b:: with SMTP id bh11mr20116578plb.321.1572280197972;
        Mon, 28 Oct 2019 09:29:57 -0700 (PDT)
Received: from sultan-box.localdomain ([104.200.129.62])
        by smtp.gmail.com with ESMTPSA id v2sm11423626pgf.39.2019.10.28.09.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:29:57 -0700 (PDT)
Date:   Mon, 28 Oct 2019 09:29:55 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ming Lei <ming.lei@redhat.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scatterlist: Speed up for_each_sg() loop macro
Message-ID: <20191028162955.GB32593@sultan-box.localdomain>
References: <20191025213359.7538-1-sultan@kerneltoast.com>
 <20191028141734.GD29652@ziepe.ca>
 <20191028161848.GA32593@sultan-box.localdomain>
 <20191028162320.GF29652@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028162320.GF29652@ziepe.ca>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 01:23:20PM -0300, Jason Gunthorpe wrote:
> On Mon, Oct 28, 2019 at 09:18:48AM -0700, Sultan Alsawaf wrote:
> > On Mon, Oct 28, 2019 at 11:17:34AM -0300, Jason Gunthorpe wrote:
> > > This is a big change in the algorithm, why are you sure it is OK?
> > 
> > I'm sure it's OK because the test module I provided in the commit message
> > encapsulates all the possible edge cases of sg chaining:
> > -An sglist with >=1 && <=(SG_MAX_SINGLE_ALLOC-1) nents (no chaining, the last
> >  element in the array is unused)
> > -An sglist with SG_MAX_SINGLE_ALLOC nents (no chaining, the last element in the
> >  array isn't an sg chain link)
> > -An sglist with >SG_MAX_SINGLE_ALLOC && <=2*(SG_MAX_SINGLE_ALLOC-1) nents (there
> >  is one chain to another array, and the other array's last element is unused)
> > -An sglist with (2*SG_MAX_SINGLE_ALLOC)-1 nents (there is one chain to another
> >  array, and the other array's last element isn't an sg chain link)
> > -An sglist with 2*SG_MAX_SINGLE_ALLOC nents (there are two chains to other
> >  arrays, and the 3rd array contains 2 sgs & its last element is unused)
> > -An sglist with >2*SG_MAX_SINGLE_ALLOC && <(3*SG_MAX_SINGLE_ALLOC)-1 nents
> >  (there are two chains to other arrays, and the 3rd array's last element isn't
> >  an sg chain)
> 
> This testing is making assumptions about how 'nr' is used and the
> construction of the sgl though
> 
> If any chains are partially populated, or for some reason the driver
> starts at a different sgl, it will break. You'll need to somehow
> show none of those possibilities are happening.

I haven't personally witnessed any for_each_sg() use that starts at a different
sgl, but this is something I considered as well. The optimal solution would be
to alter for_each_sg() to replace the `sg` and `nr` arguments with a single
sg_table pointer argument instead. Users that genuinely need to start at a
different sgl can just craft their own for-loop with sg_next.

This would require changes to a lot of files though, and I wanted to see how the
mailing list felt about this change before embarking on that.

Sultan
