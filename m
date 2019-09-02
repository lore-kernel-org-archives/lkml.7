Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B06C41514
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AC621744
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2MEoF0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbfIBOMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 10:12:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45813 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731247AbfIBOMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:12:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so1477379pfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 07:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ag/7JhYH7yJn+zUotB9ZA5gzsujLYw/jdE8xn4rghuU=;
        b=T2MEoF0iiONoODGVHEO36QQ+/B7niNQ9UX2W3CWHiKon8aF4q4L22sm782D26+o2AL
         5BmiimhB+u3mDZ2Fj/1Xn1cpdEcEtiZuqH6gIUdki5JO60FAhwiWDzCpe7ITPVgeBinK
         cwJbzBKpkredYeRJs3KxYtoMoPWh/b6bAejAmA04SO3veQLaP2dLY6dtl/J3OPAPdVyp
         NHOwrNDDWtlUx/ozmTnQixaZC/q8xYwaTHdZBr0HtOU+/25L7989ImRcfh38ZqD9GQvA
         Ze6DWdz9cisOcBzMqzr01HSiPkNzkvw0LYP1SUMDENjdUmgCD90YMNOno1n+9EvHvA/4
         oEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ag/7JhYH7yJn+zUotB9ZA5gzsujLYw/jdE8xn4rghuU=;
        b=DWEyrHyZVRctj6ALlisuv845O8AumBkrJomtrII49Eay/fDqCSkiVShaCbGqs+hlgY
         5xb5LPlm7JJzqPepQomM15dysSStnbkFMlZSH6XjiObRr36g3vbOwwMJhMOQ4U3drWZ1
         +1OVlyJxNd+YhMr173rRuu/sJmmXWxEsdP2BsbfxP38j65xXDyFmUbAA6I0HC8pS6wBw
         aIw0+SxKj0PP3/hX3TOXaC+D01MlHGFp6zpljX0sj2pcj5TNIGxnegSruTQ6zO28i6ra
         MSKSBrzgZzCpPF1DPKqPEVM1LFX4VdKEEZkMMaTVr/jpnyf4MaymVhloWnlZmeGx2LUy
         +25g==
X-Gm-Message-State: APjAAAUTXUbEbgXvfaDC/qLX7jo6S+0xF4PSc5X4GJ15tee/r3QGJFO4
        Ku+Pe6tV+5Mss8Rbg4pHlQ==
X-Google-Smtp-Source: APXvYqwNUlPagl50c5LHcvRuG27nmE78Zf+ceOihvkKpaxyNd4FSTXi13bGDnH60AqHXWClUOyIbkg==
X-Received: by 2002:a62:d445:: with SMTP id u5mr14145589pfl.92.1567433549489;
        Mon, 02 Sep 2019 07:12:29 -0700 (PDT)
Received: from mark-All-Series (114-32-231-59.HINET-IP.hinet.net. [114.32.231.59])
        by smtp.gmail.com with ESMTPSA id w13sm2133525pfi.30.2019.09.02.07.12.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 07:12:28 -0700 (PDT)
Date:   Mon, 2 Sep 2019 22:12:25 +0800
From:   Peikan Tsai <peikantsai@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        devel@driverdev.osuosl.org, tkjos@android.com,
        linux-kernel@vger.kernel.org, arve@android.com,
        Joel Fernandes <joel@joelfernandes.org>, maco@android.com
Subject: Re: [PATCH] binder: Use kmem_cache for binder_thread
Message-ID: <20190902141225.GA21112@mark-All-Series>
References: <20190829054953.GA18328@mark-All-Series>
 <20190829064229.GA30423@kroah.com>
 <20190829135359.GB63638@google.com>
 <20190829152721.ttsyfwaeygmwmcu7@wittgenstein>
 <20190829185901.GA4680@mark-All-Series>
 <20190830063943.GH15257@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830063943.GH15257@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 08:39:43AM +0200, Greg KH wrote:
> On Fri, Aug 30, 2019 at 02:59:01AM +0800, Peikan Tsai wrote:
> > On Thu, Aug 29, 2019 at 05:27:22PM +0200, Christian Brauner wrote:
> > > On Thu, Aug 29, 2019 at 09:53:59AM -0400, Joel Fernandes wrote:
> > > > On Thu, Aug 29, 2019 at 08:42:29AM +0200, Greg KH wrote:
> > > > > On Thu, Aug 29, 2019 at 01:49:53PM +0800, Peikan Tsai wrote:
> > > > [snip] 
> > > > > > The allocated size for each binder_thread is 512 bytes by kzalloc.
> > > > > > Because the size of binder_thread is fixed and it's only 304 bytes.
> > > > > > It will save 208 bytes per binder_thread when use create a kmem_cache
> > > > > > for the binder_thread.
> > > > > 
> > > > > Are you _sure_ it really will save that much memory?  You want to do
> > > > > allocations based on a nice alignment for lots of good reasons,
> > > > > especially for something that needs quick accesses.
> > > > 
> > > > Alignment can be done for slab allocations, kmem_cache_create() takes an
> > > > align argument. I am not sure what the default alignment of objects is
> > > > though (probably no default alignment). What is an optimal alignment in your
> > > > view?
> > > 
> > > Probably SLAB_HWCACHE_ALIGN would make most sense.
> > > 
> > 
> > Agree. Thanks for yours comments and suggestions.
> > I'll put SLAB_HWCACHE_ALIGN it in patch v2.
> > 
> > > > 
> > > > > Did you test your change on a system that relies on binder and find any
> > > > > speed improvement or decrease, and any actual memory savings?
> > > > > 
> > > > > If so, can you post your results?
> > > > 
> > > > That's certainly worth it and I thought of asking for the same, but spoke too
> > > > soon!
> > > 
> > > Yeah, it'd be interesting to see what difference this actually makes. 
> > > 
> > > Christian
> > 
> > I tested this change on an Android device(arm) with AOSP kernel 4.19 and
> > observed
> > memory usage of binder_thread. But I didn't do binder benchmark yet.
> > 
> > On my platform the memory usage of binder_thread reduce about 90 KB as
> > the
> > following result.
> >         nr obj          obj size        total
> > 	before: 624             512             319488 bytes
> > 	after:  728             312             227136 bytes
> 
> You have more objects???
> 

Sorry, it's total objects which include some inactive objects ...
And because I tested it on an Android platform so there may be some noise.

So I try 'adb stop' and 'echo 3 > /proc/sys/vm/drop_caches' before starting
test to reduce the noise, and the result are as following.

                    objs
kzalloc              220  (kmalloc-512 alloc by binder_get_thread)

             active_objs  total objs   objperslab  slabdata
kmem_cache           194         403           13        31

Seems there are more objects when use kmemcache for binder_thread...
But as I understand it, those inactive objects can be free by kmemcahe shrink?

Also, I tested the throughput by using performace test of Android VTS.

size(bytes)	kzalloc(byte/ns)	kmemcache(byte/ns)
4		0.17			0.17
8		0.33			0.32
16		0.66			0.66
32		1.36			1.42
64		2.66			2.61
128		5.4			5.26
256		10.29			10.77
512		21.51			21.36
1k		41			40.26
2k		82.12			80.28
4k		149.24			146.95
8k		262.34			256
16k		417.96			422.2
32k		596.66			590.23
64k		600.84			601.25


