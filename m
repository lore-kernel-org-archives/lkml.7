Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE18C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD7B2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfCKR6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:58:06 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:37372 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfCKR6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:58:06 -0400
Received: by mail-ot1-f46.google.com with SMTP id b3so4779732otp.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 10:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aOZ8uHt6bncKFLR0pCiPe6i6BuhLZtI6G9d8bKnXFfo=;
        b=rClGJy72QIbINWJxMoaRDemUoIbiAU3GyHXs9KmNM0PHB33ZhyhMbU7ljQ+MmD+lac
         staKrrQ8RuFOWJ6X271LWgFdFO0cUCWLgDcitX6JFmx/Z4HCtrSLhtaNvpZe40Pmp8BP
         Ew/vUqFYuUUnVknNSTsNCEYeLFMxfTarZoybc0ImhjkrDuFF+IpOHfYbw9vGMh9yJSRq
         fMBPrKRAkTmIQF/nzW6NHDVTXOjrM2hiqbA1Zd0ACkWRj4/5hp80+1MvvvzmkSiGqiWT
         X/kct+O61MsDvmd2Ci2JZYcgKoUGUa9wrP99w3w8BDqLtLl9EqSzhz78mMr5cK8ti3C7
         9Mjg==
X-Gm-Message-State: APjAAAUm+zZt0vqef7JPEMcBwAdCEA5XYpm/WNQkqFGXc5GUrXSDm0/m
        mfjgOYsGU0Tb3h09AXKdO0o=
X-Google-Smtp-Source: APXvYqxp5i+a1trQda4sLOjRTInRPRbCvFL/JMn9u2saDcEd/Yr+cSegABrd84KRU9OwYj5rNlksQw==
X-Received: by 2002:a9d:7841:: with SMTP id c1mr21854509otm.354.1552327085287;
        Mon, 11 Mar 2019 10:58:05 -0700 (PDT)
Received: from sultan-box.localdomain ([107.193.118.89])
        by smtp.gmail.com with ESMTPSA id r9sm2522935otp.81.2019.03.11.10.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 10:58:04 -0700 (PDT)
Date:   Mon, 11 Mar 2019 10:58:00 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190311175800.GA5522@sultan-box.localdomain>
References: <20190310203403.27915-1-sultan@kerneltoast.com>
 <20190311174320.GC5721@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311174320.GC5721@dhcp22.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 06:43:20PM +0100, Michal Hocko wrote:
> I am sorry but we are not going to maintain two different OOM
> implementations in the kernel. From a quick look the implementation is
> quite a hack which is not really suitable for anything but a very
> specific usecase. E.g. reusing a freed page for a waiting allocation
> sounds like an interesting idea but it doesn't really work for many
> reasons. E.g. any NUMA affinity is broken, zone protection doesn't work
> either. Not to mention how the code hooks into the allocator hot paths.
> This is simply no no.
> 
> Last but not least people have worked really hard to provide means (PSI)
> to do what you need in the userspace.

Hi Michal,

Thanks for the feedback. I had no doubt that this would be vehemently rejected
on the mailing list, but I wanted feedback/opinions on it and thus sent it as anRFC. At best I thought perhaps the mechanisms I've employed might serve as
inspiration for LMKD improvements in Android, since this hacky OOM killer I've
devised does work quite well for the very specific usecase it is set out to
address. The NUMA affinity and zone protection bits are helpful insights too.

I'll take a look at PSI which Joel mentioned as well.

Thanks,
Sultan Alsawaf
