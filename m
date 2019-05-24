Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EFAC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D0720851
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391136AbfEXMiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 08:38:10 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:53605 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390946AbfEXMiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 08:38:09 -0400
Received: by mail-wm1-f53.google.com with SMTP id 198so9228877wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 05:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GDTl6Nm3TIbGDal74naHn6rgvGEKC0rQIjrmtNxP634=;
        b=p6MWZkIbukLunsp7FTW599xgOzCn0dqEpSC4GAdX6uuv3K/S46mQxN3Pq4fC06EYzt
         K5aW2+DNA0hnNN5fYpeJq/7QpuZRMZqhtVP7S7GZlsiiZma6TmA76fUQ/VwE8lVNGBv9
         XDgCxBVSChPsgAslPIbzJ60sprDMjU+jWEpdZRnpVQ4lYfilXDz3J8LChsQyvMCu7lar
         csK+d0smsZgu4mDod2IFnG2/p4Ok43aUxjx0mBpk6wwPWuF0rgfFIwpy3Yy5LrHqQGRu
         XzjUXraB1lgX7/cYmJIT67U/8YcwHyA6gL2l+92c1YcOCLjwNEV7iMt0/qOLwxjytnYi
         GKCA==
X-Gm-Message-State: APjAAAXHr5bpYPuljVMeHPNL9cFzW6pyHpUzEZ7q8WJNvZPTeA1w+pDu
        ZyjsqcNM6pKIdPoHDK4+YDF+Gg==
X-Google-Smtp-Source: APXvYqysf/m1G9PbjiINF9K4Vr4rduk0GW+cZ+retdH6hnVUpJ0tPxSe80ZkbPx4DEhfyNrgyrv3qg==
X-Received: by 2002:a1c:6a17:: with SMTP id f23mr15109982wmc.94.1558701487633;
        Fri, 24 May 2019 05:38:07 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q9sm4173110wmq.9.2019.05.24.05.38.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 05:38:06 -0700 (PDT)
Date:   Fri, 24 May 2019 14:38:05 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Justin Piszcz <jpiszcz@lucidpixels.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 5.1 and 5.1.1: BUG: unable to handle kernel paging request at
 ffffea0002030000
Message-ID: <20190524123805.hcuzaqyi7ouzhkfg@butterfly.localdomain>
References: <CAO9zADzXTQpv5cGp61BzsVPvWQz5xbSJv_N71jBa3zopr7CB=Q@mail.gmail.com>
 <20190520115608.GK18914@techsingularity.net>
 <CAO9zADzz9QJ9Rp_Acy5GRggfYZzDwYYNWhCvPc9XHd+G=gS5zw@mail.gmail.com>
 <20190521124310.GM18914@techsingularity.net>
 <20190524114329.hujd3qvtusz6uyfk@butterfly.localdomain>
 <20190524123146.GP18914@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524123146.GP18914@techsingularity.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 01:31:46PM +0100, Mel Gorman wrote:
> On Fri, May 24, 2019 at 01:43:29PM +0200, Oleksandr Natalenko wrote:
> > > Please use the offset 0xb9
> > > 
> > > addr2line -i -e /usr/src/linux/vmlinux `printf "0x%lX" $((0x$ADDR+0xb9))
> > > 
> > > -- 
> > > Mel Gorman
> > > SUSE Labs
> > 
> > Cc'ing myself since i observe such a behaviour sometimes right after KVM
> > VM is launched. No luck with reproducing it on demand so far, though.
> > 
> 
> It's worth testing the patch at https://lore.kernel.org/lkml/1558689619-16891-1-git-send-email-suzuki.poulose@arm.com/T/#u

On my TODO list already, thanks.

> 
> -- 
> Mel Gorman
> SUSE Labs

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
