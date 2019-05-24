Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5436EC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4662175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="g/ueHChD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbfEXRGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:06:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37708 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbfEXRGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:06:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id a23so5694330pff.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nd2Lj9Q7aDsjzQ8w/THzJxRiwvjWHcaNNXAaDuTseEo=;
        b=g/ueHChDmzv10RhToAZSHSTBKjmteHa2+GUrTouq4WT3zsId5XyPYsDLo0VEZ2lsk8
         xxwdc+zYgqElB7Hvgr2sCKnjTYGslk7l0zl7pL6buSlo4cp3mxDXesT1bju4whIW9YTD
         Xuy4SOumA5cjyBIoyw9VlY9FgRNaGt/IqUr+XyQYlD5nDnja70C44raTby78ZUIDd1gl
         a5Sp9sBHrPzzyBHOEJQJe5yj3Kd+hIFzn2zlMyvZHtC4Byo12tj+FkG/59LC1tfn7w8G
         Pxe7hqzs2TKDKBOdg5W94Xk89woskg4bqexiagAxDpcv/zg5EhumBoaR1/Fa0bIqYdRx
         aAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nd2Lj9Q7aDsjzQ8w/THzJxRiwvjWHcaNNXAaDuTseEo=;
        b=YdBBuVY6JV8jq5cKzv3NRIpaA0I92NtfFzciogsNmvgjAkmDBeqwiaLRtQMN6snSzE
         YNslh9uYAkBdq2Bdr1aq7XJ2M4+7xjwNJLSArN2MekVY1jvmxiJGOiONmG2IBfVqchHk
         7Mm+g1CGAYlTgQQbn4wKwKJBKbcrlX8AJDZD6dmu8u7AMtcoITF73Op6g2Z4QFJMUe77
         RI7JwtBt1R6+jcQUPE3APArnxf83BvgpVa7yokxKt10WZ4bOcleMD45bv2oIFcLbs9Vf
         wH0onr/8IaTqYEtsGfaUuuqpF3MtA0dJwCAITxy71gpXlbp/XrGVZibT8ms4QLgmjEy4
         3kDw==
X-Gm-Message-State: APjAAAXqssDvYXvEGw8dqUgwqZlshRKiYsHT+lonLp9/mTdMP4puOwA6
        l1r5Cc9BWzquyM2M+sVLHReW9w==
X-Google-Smtp-Source: APXvYqyCulQRmI3PhrXkVMrT+R32nDK0uKlw4vnyyo1uY2kcnPUkhXPwQBLT45X7DGw97sr105YGzg==
X-Received: by 2002:a17:90a:a616:: with SMTP id c22mr10749010pjq.46.1558717605295;
        Fri, 24 May 2019 10:06:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::805])
        by smtp.gmail.com with ESMTPSA id h5sm3485126pfk.163.2019.05.24.10.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 10:06:44 -0700 (PDT)
Date:   Fri, 24 May 2019 13:06:42 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: xarray breaks thrashing detection and cgroup isolation
Message-ID: <20190524170642.GA20546@cmpxchg.org>
References: <20190523174349.GA10939@cmpxchg.org>
 <20190523183713.GA14517@bombadil.infradead.org>
 <CALvZod4o0sA8CM961ZCCp-Vv+i6awFY0U07oJfXFDiVfFiaZfg@mail.gmail.com>
 <20190523190032.GA7873@bombadil.infradead.org>
 <20190523192117.GA5723@cmpxchg.org>
 <20190523194130.GA4598@bombadil.infradead.org>
 <20190523195933.GA6404@cmpxchg.org>
 <20190524161146.GC1075@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524161146.GC1075@bombadil.infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 09:11:46AM -0700, Matthew Wilcox wrote:
> On Thu, May 23, 2019 at 03:59:33PM -0400, Johannes Weiner wrote:
> > My point is that we cannot have random drivers' internal data
> > structures charge to and pin cgroups indefinitely just because they
> > happen to do the modprobing or otherwise interact with the driver.
> > 
> > It makes no sense in terms of performance or cgroup semantics.
> 
> But according to Roman, you already have that problem with the page
> cache.
> https://lore.kernel.org/linux-mm/20190522222254.GA5700@castle/T/
> 
> So this argument doesn't make sense to me.

You haven't addressed the rest of the argument though: why every user
of the xarray, and data structures based on it, should incur the
performance cost of charging memory to a cgroup, even when we have no
interest in tracking those allocations on behalf of a cgroup.

Which brings me to repeating the semantics argument: it doesn't make
sense to charge e.g. driver memory, which is arguably a shared system
resource, to whoever cgroup happens to do the modprobe / ioctl etc.

Anyway, this seems like a fairly serious regression, and it would make
sense to find a self-contained, backportable fix instead of something
that has subtle implications for every user of the xarray / ida code.
