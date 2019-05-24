Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36894C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 22:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7142184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 22:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558736843;
	bh=SDoIvluJch9/n7yS60HKo4yatPF0jkw/bEYV06KPYVM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=YVA6nZKqdelZTWbYixLRJlQJXw79PpSFvwWIwvLykUjaBKA9Ib+zn6lVKhb8n/dUh
	 3ogFpGnw+h1ehT7QOb1PV1ByNWqDay71ZdnJos88s9gSn2E1gb1USJ8hb0dI7gRlDi
	 gcXZx5NvkYPGKC15rH0O816bRIvpf42KcjVkIYW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404392AbfEXW1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 18:27:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404343AbfEXW1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 18:27:21 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 786DF21848;
        Fri, 24 May 2019 22:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558736841;
        bh=SDoIvluJch9/n7yS60HKo4yatPF0jkw/bEYV06KPYVM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=St9heaFc1DBQI4jtZg82szDgH3oHDso9H4ueTv1e3yw8VjnbQ68w00gU6ToxklC1J
         NMLfhfeMdLwB4zP+yqchvWdqMGG5CFEZil6VqhXwtuyqZPtknjvFGZLTr9JEzeR4rr
         SkpHSrHEZeyhx1MyGGtorXkeliIVadoW0Gkygj2k=
Date:   Sat, 25 May 2019 00:27:17 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [5.2-rc1 regression]: nvme vs. hibernation
In-Reply-To: <20190524154429.GE15192@localhost.localdomain>
Message-ID: <nycvar.YFH.7.76.1905250023380.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905241706280.1962@cbobk.fhfr.pm> <20190524154429.GE15192@localhost.localdomain>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019, Keith Busch wrote:

> > Something is broken in Linus' tree (4dde821e429) with respec to 
> > hibernation on my thinkpad x270, and it seems to be nvme related.
> > 
> > I reliably see the warning below during hibernation, and then sometimes 
> > resume sort of works but the machine misbehaves here and there (seems like 
> > lost IRQs), sometimes it never comes back from the hibernated state.
> > 
> > I will not have too much have time to look into this over weekend, so I am 
> > sending this out as-is in case anyone has immediate idea. Otherwise I'll 
> > bisect it on monday (I don't even know at the moment what exactly was the 
> > last version that worked reliably, I'll have to figure that out as well 
> > later).
> 
> I believe the warning call trace was introduced when we converted nvme to
> lock-less completions. On device shutdown, we'll check queues for any
> pending completions, and we temporarily disable the interrupts to make
> sure that queues interrupt handler can't run concurrently.

Yeah, the completion changes were the primary reason why I brought this up 
with all of you guys in CC.

> On hibernation, most CPUs are offline, and the interrupt re-enabling
> is hitting this warning that says the IRQ is not associated with any
> online CPUs.
> 
> I'm sure we can find a way to fix this warning, but I'm not sure that
> explains the rest of the symptoms you're describing though.

It seems to be more or less reliable enough for bisect. I'll try that on 
monday and will let you know.

Thanks,

-- 
Jiri Kosina
SUSE Labs
