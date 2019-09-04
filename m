Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DD3C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F36B208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567619643;
	bh=XtIQ3IEZQK8J7KE1x2tgy3dqY/Y0tjtiTzE0O8jxX+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mndKZl2VHJ73Up6qwp33lLsM4hsmHNtGQNms/qLNaTOQTJg1VkVlBsSaMecXZ9VEU
	 Lq7/JZGDlpmgCWw4FBVZTmVUmT3WEkAcjiYilJsZzkLTbCWAh1BgL4SmCeB4pqGi70
	 O69OUxffFBuf86I87RAQN/rmXiqOsrceGJcmSpCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbfIDRyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:54:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35715 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731633AbfIDRyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:54:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id g7so22269674wrx.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 10:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZqXCk5KX1lKBB5KfBUnA9fP6d+VfeiwpyxR9UeQIid0=;
        b=C17cXKGlO2CS3202OtJVhSRM0yivbeK5q8wrudl5l2p7PRLWO6t02XaKPSgn+/NKy/
         2VdLclCJorKzweIVxEsz4QM9a93P0K0d9HIPfFKX4U9fEpb4sy5KOLHmBvsh1FLBU5RS
         Qv9OkBq6z5LOcj6JIJoXVS3Kc7poANRTPgE+sEusHkhp34GL0W524vf4V7NQHWkDFeey
         IWm/6Uw3qXNll05tOM1iPHpbt0LXWYDvfsCro5Hd2Rmc1vGeg9WMM5PS9g1NrOTuytwM
         xlOgFpDmc+R6DqNfcg2bPCQbnfN7+tbX7/rIQaWK7y74OkSO+KyOWjtApXoIotYGP21u
         SYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZqXCk5KX1lKBB5KfBUnA9fP6d+VfeiwpyxR9UeQIid0=;
        b=RcgQNc2paIgmWLoGG+dmAA++/P8MM9TLYAFoS3hma3fHHQNowP6Yvne/+0IWbGQT8K
         JgLz248iKg2ZBdDr0ZOnBYTGGGitcR04a3Gx+ZOFu6wlTl//jaxKR+CbzpGQH/bzsh4K
         MBYfZdDfxGGeyMHV4CQ2mDyX1QBTJfk3cD3P4eL8jc74K2UCIdDycSbB5mchsQXlnHIr
         +QWbaugCZ+HMkinJ3+DbChXplu/mui5rPCi5cb1VvBSaNQDZMPoWZy5IxiWY9Udkx9/T
         gdYCryM1XTXg5VZunxIeXSkiZCyH/VeJtiscrPnjQfqUzZegrAMGB6QwKBL0G+xD1o9n
         OWHw==
X-Gm-Message-State: APjAAAXiXudSl4yjnM6BIPq0ULRcwCPwC1uy8lSXtkQbFUjlJyctEBQE
        J0F+gYfUxA+lhpgKEXaI8vLz53MK
X-Google-Smtp-Source: APXvYqyCl9pb46pi8COBra5uUbYIVNUB2iVzimilPbJncvo+uDfpS9W0Kuc5Nc4NoUEK8S0EAlKpOg==
X-Received: by 2002:adf:e68a:: with SMTP id r10mr3213270wrm.63.1567619640531;
        Wed, 04 Sep 2019 10:54:00 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q192sm4812978wme.23.2019.09.04.10.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 10:53:59 -0700 (PDT)
Date:   Wed, 4 Sep 2019 19:53:57 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3] sched/core: Fix uclamp ABI bug, clean up and
 robustify sched_read_attr() ABI logic and code
Message-ID: <20190904175357.GA110926@gmail.com>
References: <20190903171645.28090-1-cascardo@canonical.com>
 <20190903171645.28090-2-cascardo@canonical.com>
 <20190904075532.GA26751@gmail.com>
 <20190904084934.GA117671@gmail.com>
 <20190904085519.GA127156@gmail.com>
 <db065b81-c373-f291-ad48-f556a209cc95@arm.com>
 <20190904103925.GA60962@gmail.com>
 <20190904131932.GG4101@calabresa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904131932.GG4101@calabresa>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thadeu Lima de Souza Cascardo <cascardo@canonical.com> wrote:

> There is one odd behaviour now, which is whenever size is set between 
> VER0 and VER1, we will have a partial struct filled up, instead of 
> getting E2BIG or EINVAL.

Well, that's pretty much by design: user-space is asking for 'usize' 
bytes of information, and the kernel provides it if it can.

This way the kernel can keep backwards compatibility indefinitely, 
without new kernels having to be aware of the zillions of prior ABI 
versions that were due to slow expansion of the ABI. (This actually 
happened to the perf ABI, which was expanded dozens of times already.)

> > +static int
> > +sched_attr_copy_to_user(struct sched_attr __user *uattr,
> > +			struct sched_attr *kattr,
> > +			unsigned int usize)
> >  {
> > -	int ret;
> > +	unsigned int ksize = sizeof(*kattr);
> >  
> > -	if (!access_ok(uattr, usize))
> > +	if (!access_ok(uattr, ksize))
> >  		return -EFAULT;
> >  
> 
> I believe this should be either usize or kattr->size and moved below 
> (or just reuse min(usize,ksize)).
> 
> Otherwise, an old binary that uses the old ABI (that is, VER0 as size) 
> may get EFAULT here. This should almost never in practice. I tried, but 
> I could hardly use an address that would fail access_ok. But, 
> theoretically, that still breaks ABI.

I agree that this is mostly theoretical, as currently these sizes are 
limited between VER0 and PAGE_SIZE - and hardly anyone puts these 
structures near the very end of virtual memory.

But checking 'usize' is arguably the more correct value, as that's the 
size of the user-space buffer. I've done this change in the latest 
version of the fix.

Thanks,

	Ingo
