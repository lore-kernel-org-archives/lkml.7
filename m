Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F64CC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7861216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ctSiEsOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfGVNlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:41:55 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:44048 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfGVNlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:41:55 -0400
Received: by mail-qk1-f176.google.com with SMTP id d79so28571544qke.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r7jurWEbcB87wkHM6FBIF/d6ZCsIeD3qrag1BaWvzr0=;
        b=ctSiEsOEiyiwu0n3CEQABL3/Tosruh5w/+6uzF92xLW34JmyfhThCGBMfVUaYt9dcx
         eW2R16GiG0XcoxTfHQmNNe2NbtDmD4V4zDlbn3sIafmR+axGp5w7q8jG/t+N5A5vd1+2
         T8limk/5bxxJguypRZGjOMgCVjJ3UuJ440SlT4VBiuew99yPu+wjBAGDyiX6h7A0CwOA
         dwL0M70N/ZKBJ7e/9dDovVWnU15MNgA7ZpwwgLu6rerH2A7rFP/VNIWBW0CDFkWJkGIk
         02tVH4RCMUcpMeH+V7LrZ4lwFpUMFWob0uRUx2w20StfeAVPWAbvrasBs/AM3w8QAsz1
         Qvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r7jurWEbcB87wkHM6FBIF/d6ZCsIeD3qrag1BaWvzr0=;
        b=EE3YVWRws8tBPLovmiLG6itbMuKa8LNdH5JFG/2/GzWgeDUjihGgrmgINephSezh95
         puvh5seFwFgl22HVPcHBh3WKwDBGhBMPBL79x2vRVdgHfDw3niB5jyP5Eqt13GVfxOpQ
         NIO8miMvSi762B1/dO9RXjUAOhqv8Uav1jMZBnQPHPSNv03SiWkRZIVzMJMD8mn4T58U
         6lTHrymHu6aDY9KNRZ8We0uUeM3141yyJNjN3jOjZ9rREe5z0L+jrvde6ngts04Uxi8a
         Mjv52VmMsPkU4ckCEpO+rN3kqOZOG44QZq5wd9Wnk3CacoY6UVeELFkA+DpAFy6reF3C
         LYow==
X-Gm-Message-State: APjAAAV4PvIg7z8ApqrN8IFiNF5ODUTNIjFMGRuYOGGW66XXWNLQWaXt
        zD3acuzcEaG5caEkXwYNK1LVLw==
X-Google-Smtp-Source: APXvYqxGgJ5n0Ggl2+5KtjzE7HLyY29aRN+3J2KTmJj1bDyPcTuyXmhCmMkJ3yMp7O1QI/DGhNTc3w==
X-Received: by 2002:a37:a6d8:: with SMTP id p207mr42748278qke.387.1563802913858;
        Mon, 22 Jul 2019 06:41:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id x8sm17451291qkl.27.2019.07.22.06.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 06:41:52 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hpYZc-0003Vr-7E; Mon, 22 Jul 2019 10:41:52 -0300
Date:   Mon, 22 Jul 2019 10:41:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, aarcange@redhat.com,
        akpm@linux-foundation.org, christian@brauner.io,
        davem@davemloft.net, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, hch@infradead.org,
        james.bottomley@hansenpartnership.com, jasowang@redhat.com,
        jglisse@redhat.com, keescook@chromium.org, ldv@altlinux.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        namit@vmware.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        wad@chromium.org
Subject: Re: RFC: call_rcu_outstanding (was Re: WARNING in __mmdrop)
Message-ID: <20190722134152.GA13013@ziepe.ca>
References: <0000000000008dd6bb058e006938@google.com>
 <000000000000964b0d058e1a0483@google.com>
 <20190721044615-mutt-send-email-mst@kernel.org>
 <20190721081933-mutt-send-email-mst@kernel.org>
 <20190721131725.GR14271@linux.ibm.com>
 <20190721210837.GC363@bombadil.infradead.org>
 <20190721233113.GV14271@linux.ibm.com>
 <20190722035042-mutt-send-email-mst@kernel.org>
 <20190722115149.GY14271@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722115149.GY14271@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 04:51:49AM -0700, Paul E. McKenney wrote:

> > > > Would it make sense to have call_rcu() check to see if there are many
> > > > outstanding requests on this CPU and if so process them before returning?
> > > > That would ensure that frequent callers usually ended up doing their
> > > > own processing.
> > > 
> > > Unfortunately, no.  Here is a code fragment illustrating why:

That is only true in the general case though, kfree_rcu() doesn't have
this problem since we know what the callback is doing. In general a
caller of kfree_rcu() should not need to hold any locks while calling
it.

We could apply the same idea more generally and have some
'call_immediate_or_rcu()' which has restrictions on the caller's
context.

I think if we have some kind of problem here it would be better to
handle it inside the core code and only require that callers use the
correct RCU API.

I can think of many places where kfree_rcu() is being used under user
control..

Jason
