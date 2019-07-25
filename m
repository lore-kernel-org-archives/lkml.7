Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C90AC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7930221901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfGYOHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:07:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33327 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbfGYOHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:07:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so51041841wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 07:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eFn09RalEUIKtnUE8NV4uNNiwjv0Llrv8izPJjzEejo=;
        b=YKyDIl45xecXm9XQYCv4v/1mM0UR7JdRI5SYKdJ3IuAGyVDu4uCrzXZhHdZ32F4X87
         vi7GF7L1R9ikukQYB+fjwUj0IP+CiHyrgjg0VjG5H3lVG0OmOKydf0JdngmiS7REhm8L
         Pd7QS5IotHkMsR9v40wxyBzL1S0D94JUM9Yz/W0IzYR9dP/fKz4dgCfTzo3s/6v4IFFL
         9kN80PIrAl1jIsHx/M6S0z3cR4mxpamkywFlLxQlcFmPiROHOvZ4rQamYxVkW9g+jziD
         PmR5GtGZHaPFi9Ha6voGtYBrV/6Vj3TqPcYL+HxuvG65lj4Yf53VIjJ4dg7vi2FUHwSl
         8JJQ==
X-Gm-Message-State: APjAAAXFajWFiesASM+mnkB1fymdgSMAKNbA92OBzkKUtzrXYsvFamTI
        Ujyde00RN+fBlDBYINJGsWDO9Q==
X-Google-Smtp-Source: APXvYqwQhtIOnV5ZljsfFGSDBzHtyXIAFpCL227sE7G1MAY4H2h2s62ayu8HX/oOObnUjrnXBvCHvQ==
X-Received: by 2002:adf:e2c1:: with SMTP id d1mr99702005wrj.283.1564063660364;
        Thu, 25 Jul 2019 07:07:40 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id i12sm58112809wrx.61.2019.07.25.07.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 07:07:39 -0700 (PDT)
Date:   Thu, 25 Jul 2019 16:07:37 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com, longman@redhat.com,
        dietmar.eggemann@arm.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v9 3/8] cpuset: Rebuild root domain deadline accounting
 information
Message-ID: <20190725140737.GM25636@localhost.localdomain>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-4-juri.lelli@redhat.com>
 <20190725135351.GA108579@gmail.com>
 <20190725135615.GB108579@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725135615.GB108579@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/07/19 15:56, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > 
> > * Juri Lelli <juri.lelli@redhat.com> wrote:
> > 
> > > When the topology of root domains is modified by CPUset or CPUhotplug
> > > operations information about the current deadline bandwidth held in the
> > > root domain is lost.
> > > 
> > > This patch addresses the issue by recalculating the lost deadline
> > > bandwidth information by circling through the deadline tasks held in
> > > CPUsets and adding their current load to the root domain they are
> > > associated with.
> > > 
> > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > 
> > Was this commit written by Mathieu? If yes then it's missing a From line. 
> > If not then the Signed-off-by should probably be changed to Acked-by or 
> > Reviewed-by?
> 
> So for now I'm assuming that the original patch was written by Mathieu, 
> with modifications by you. So I added his From line and extended the SOB 
> chain with the additional information that you modified the patch:
> 
>     Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>     Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>     Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
>     [ Various additional modifications. ]
>     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>     Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
> Let me know if that's not accurate!

Looks good to me, thanks. And sorry for the confusion.

Best,

Juri
