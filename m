Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E38C742BE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 13:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CB021019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 13:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="c1rnnJSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfGLNxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 09:53:42 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35076 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfGLNxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 09:53:41 -0400
Received: by mail-qt1-f196.google.com with SMTP id d23so8145831qto.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 06:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ySA+qG8mLGjvAWtAQNNIdbBEIEesJvVeG0+8zORbVak=;
        b=c1rnnJSaZkBl+toOZu3TMTVpDbOMShCLpuC63785zKppW77VuLHtZw01hKwE7tFODb
         6pdBj3Rv+xm0cyPDrn/T8KpwsSETOryCMzqZyn/TNxaWWnzZD8Bdt9uqLipRF52+o1vt
         US6TJatXNBE/f/iWbrFAF9oOD98oVzwE0QAqyZyKPwT/umZcadjTTODzBe7D/Fw3nIAJ
         QfIAu3azslSp8HGIb6EF1v723XocGdjyKnsNuYkHNp+Qv8FNQfWnKfrsooyvULYkvqrg
         u7TFKDAfaW2JOUoTp2APIxviBnuWGGEA7hBI7dVLXjwBcrfJzdCNfKUsRf1VXU9KIvrS
         nmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ySA+qG8mLGjvAWtAQNNIdbBEIEesJvVeG0+8zORbVak=;
        b=UYDrkquRTLpsxCHyoZTCLQ/SSK6uL2/3Xmv0JHcWkcxquv2UB8BAyCEgAB026tN4sn
         EQT2/gYlqjMci9B6KhzE94LUjd2jdd+0heFHFOpFvAqE5JXyl+/w+Xuh2mSgN5JBpz0W
         ZyEBg5NFQs6XBomI6dLLMCGxXapfsFbRGOUU5pNeedLB6AglsPqeRninQJjt/e4MH3yw
         IwkJ45iI+AdvrKImrc6vusFCTJMd1EHpTFYQyUopr7w0Nyp80pBG5MkOY5xa+VuAileL
         Z7AYbsHc+v4oZGQeDUYnMYNwqPXaoYg4J1/8Jz7w19OISV/7CN/RY0qsE4Wrn34olgT5
         syfg==
X-Gm-Message-State: APjAAAWpNoNl4soY7ewOVkZwzAJ8leAsPwGFxRIaBQ01bnAtjj31h5HH
        4fY5ENG9dYcUn6WsDAJSepF0kpxfxq9LzA==
X-Google-Smtp-Source: APXvYqwJxaDpsdKZpwNUqJAxTNCQQUHeHHRD2xQZCOybQGWhA8QyLofv3Ou4aBqTTIkkdFEJyM0TJg==
X-Received: by 2002:a05:6214:2c1:: with SMTP id g1mr6641902qvu.124.1562939620212;
        Fri, 12 Jul 2019 06:53:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 2sm4368996qtz.73.2019.07.12.06.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jul 2019 06:53:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlvzX-0001AG-5g; Fri, 12 Jul 2019 10:53:39 -0300
Date:   Fri, 12 Jul 2019 10:53:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Doug Ledford <dledford@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] rdma/siw: avoid smp_store_mb() on a u64
Message-ID: <20190712135339.GC27512@ziepe.ca>
References: <20190712120328.GB27512@ziepe.ca>
 <20190712085212.3901785-1-arnd@arndb.de>
 <OF05C1A780.433E36D1-ON00258435.003381DA-00258435.003F847E@notes.na.collabserv.com>
 <OF36428621.B839DE8B-ON00258435.00461748-00258435.0047E413@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF36428621.B839DE8B-ON00258435.00461748-00258435.0047E413@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 01:05:14PM +0000, Bernard Metzler wrote:
> 
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >Date: 07/12/2019 02:03PM
> >Cc: "Arnd Bergmann" <arnd@arndb.de>, "Doug Ledford"
> ><dledford@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
> >linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
> >Subject: [EXTERNAL] Re: [PATCH] rdma/siw: avoid smp_store_mb() on a
> >u64
> >
> >On Fri, Jul 12, 2019 at 11:33:46AM +0000, Bernard Metzler wrote:
> >> >diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
> >> >b/drivers/infiniband/sw/siw/siw_verbs.c
> >> >index 32dc79d0e898..41c5ab293fe1 100644
> >> >+++ b/drivers/infiniband/sw/siw/siw_verbs.c
> >> >@@ -1142,10 +1142,11 @@ int siw_req_notify_cq(struct ib_cq
> >*base_cq,
> >> >enum ib_cq_notify_flags flags)
> >> > 
> >> > 	if ((flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED)
> >> > 		/* CQ event for next solicited completion */
> >> >-		smp_store_mb(*cq->notify, SIW_NOTIFY_SOLICITED);
> >> >+		WRITE_ONCE(*cq->notify, SIW_NOTIFY_SOLICITED);
> >> > 	else
> >> > 		/* CQ event for any signalled completion */
> >> >-		smp_store_mb(*cq->notify, SIW_NOTIFY_ALL);
> >> >+		WRITE_ONCE(*cq->notify, SIW_NOTIFY_ALL);
> >> >+	smp_wmb();
> >> > 
> >> > 	if (flags & IB_CQ_REPORT_MISSED_EVENTS)
> >> > 		return cq->cq_put - cq->cq_get;
> >> 
> >> 
> >> Hi Arnd,
> >> Many thanks for pointing that out! Indeed, this CQ notification
> >> mechanism does not take 32 bit architectures into account.
> >> Since we have only three flags to hold here, it's probably better
> >> to make it a 32bit value. That would remove the issue w/o
> >> introducing extra smp_wmb(). 
> >
> >I also prefer not to see smp_wmb() in drivers..
> >
> >> I'd prefer smp_store_mb(), since on some architectures it shall be
> >> more efficient.  That would also make it sufficient to use
> >> READ_ONCE.
> >
> >The READ_ONCE is confusing to me too, if you need store_release
> >semantics then the reader also needs to pair with load_acquite -
> >otherwise it doesn't work.
> >
> >Still, we need to do something rapidly to fix the i386 build, please
> >revise right away..
> >
> >Jason
> >
> >
> 
> We share CQ (completion queue) notification flags between application
> (which may be user land) and producer (kernel QP's (queue pairs)).
> Those flags can be written by both application and QP's. The application
> writes those flags to let the driver know if it shall inform about new
> work completions. It can write those flags at any time.
> Only a kernel producer reads those flags to decide if
> the CQ notification handler shall be kicked, if a new CQ element gets
> added to the CQ. When kicking the completion handler, the driver resets the
> notification flag, which must get re-armed by the application.

This looks wrong to me.. a userspace notification re-arm cannot be
lost, so have a split READ/TEST/WRITE sequence can't possibly work?

I'd expect an atomic test and clear here?


> @@ -1141,11 +1145,17 @@ int siw_req_notify_cq(struct ib_cq *base_cq, enum ib_cq_notify_flags flags)
>  	siw_dbg_cq(cq, "flags: 0x%02x\n", flags);
>  
>  	if ((flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED)
> -		/* CQ event for next solicited completion */
> -		smp_store_mb(*cq->notify, SIW_NOTIFY_SOLICITED);
> +		/*
> +		 * Enable CQ event for next solicited completion.
> +		 * and make it visible to all associated producers.
> +		 */
> +		smp_store_mb(cq->notify->flags, SIW_NOTIFY_SOLICITED);

But what is the 2nd piece of data to motivate the smp_store_mb?

Jason
