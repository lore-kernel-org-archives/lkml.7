Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8B0C10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE492186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbfDEMw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:52:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41688 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDEMw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:52:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id r4so7866811wrq.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 05:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EW1iRvrg5K6TjD6nnhdvhI3KeiKEUzEaHdll4xzFTIc=;
        b=hdAwFZvtPZt8zGaaoyers1SzbrW3IHptYjPfz7CBa0QlWKYu2pk9sP3HBm7wDxCRaT
         43tn64SAXthl27J7YUgl4Bc9PTQNOahPdK95D+Bu5dD5ZXmQRzrTwuHVw41amIA+hi5N
         eadrNGXQWcYxgni5XJ4gfM1kekUNWMhWlKjo7b1MVSzhTCIEnlhHFK0u9atRZhyoOPjB
         BxlsRyY6CMLMapRjL7ipslcKWY2koluqz45stfbVFAxcjcSp2QyxzA9Pm3oJGuiNchz9
         BmGzbedlZW7PIDYAwlcmllyFGxYPEzu3K8DfQuq2S+jADwkrQ40R7ZfVWmXu8Wq5LC7R
         Q6tQ==
X-Gm-Message-State: APjAAAXLdbK2KRVilI4geenEjyCfX8WKamBJuO0a04j+/aajuf0ds4tH
        7aVgqVAkpVqseag958A7jPokNA==
X-Google-Smtp-Source: APXvYqz1OsR7IHd1R6J2TnGo8qVvJXo1lkgzSX0htq+0Swd44QqIBWB/srudLC8xVbI5iS0mPjMlwQ==
X-Received: by 2002:adf:9427:: with SMTP id 36mr8604947wrq.128.1554468774993;
        Fri, 05 Apr 2019 05:52:54 -0700 (PDT)
Received: from localhost.localdomain ([151.29.174.33])
        by smtp.gmail.com with ESMTPSA id x14sm2761573wmj.3.2019.04.05.05.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 05:52:54 -0700 (PDT)
Date:   Fri, 5 Apr 2019 14:52:45 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v7 1/7] sched/topology: Adding function
 partition_sched_domains_locked()
Message-ID: <20190405125245.GB5453@localhost.localdomain>
References: <20190403084650.4414-1-juri.lelli@redhat.com>
 <20190403084650.4414-2-juri.lelli@redhat.com>
 <20190405120434.GS12232@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405120434.GS12232@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/04/19 14:04, Peter Zijlstra wrote:
> On Wed, Apr 03, 2019 at 10:46:44AM +0200, Juri Lelli wrote:
> > +/*
> > + * Call with hotplug lock held
> 
> Is that spelled like:
> 
> 	lockdep_assert_cpus_held();
> 
> ?

Indeed, but I had that in previous versions and we removed that in v5
because it can lead to false positives [1,2]. IIRC, problem has to do
with hotplug and the fact that rebuilding from hotplug runs the
callbacks on the newly onlined CPU, not the task that acquired the lock.

Best,

- Juri

1 - https://lore.kernel.org/lkml/20180903142801.20046-1-juri.lelli@redhat.com/
2 - https://lore.kernel.org/lkml/20180613121711.5018-2-juri.lelli@redhat.com/
