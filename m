Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B97C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49DF20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555052535;
	bh=huF1WeTQXAJdjK34mlj9CQ6/dNC7sBFmNCZ2tTua4us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tMw+DwiWStV1HOIBzBIZSewosjV6y5yfbXHxG9c5onEc96MPDNABLfsIz/iYfUDUk
	 3E46AppvC4ggHtVU6aY1qwW18dlqI82t+IbuNaLTIbMaN+GQIi1DLaEr9123cF8FNJ
	 hbMSuVjzc5OOgsISLK4tGWD57WaP+gDSbQlRu8bM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfDLHCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:02:14 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:33068 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfDLHCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 03:02:14 -0400
Received: by mail-wm1-f43.google.com with SMTP id z6so3589331wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 00:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P6Guw5DNzP4WMMN4GIRaVZXcR0xZ7IxQ6inbYGmvNWA=;
        b=q2ISWhD4/pLEPf0x14gdH3NTsPQwxYvvmxJaKk0BWD886x/oY62hrKcDe8WC6Zzdt9
         NVyerZDqJ9rF8OwMDOP5KI3o1WcTu1cnXuNZrCN/0Rlmwo5UtzKm1bvSAi0eH85sOqDR
         EchAw7lfxdGT0wFHTjdfR46XWCxLP6/QWN3Mbr/Ul31DTRGC2wiI/1hVmJg4qFpPwJQQ
         o6+5norGW/8SYvE/vr0jp8FK2PTSvsL/TZqODC84VCNkGzjAKfDULQh0ExXEsX2QChM1
         1KfJBAJkvkchuE29oSRrPaO+iolnshxWjrX+hRWXJ/g5fC8TjsLT//tcnkuJVcTuJk7j
         SeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=P6Guw5DNzP4WMMN4GIRaVZXcR0xZ7IxQ6inbYGmvNWA=;
        b=p87O2ANmCM4Kl2d1Aza/1ew7f+7zq49CMlyeCfr6IBn7DEAjxeR7uEGfclBtOVZVAm
         lqD1lLy0RciLJbaWlU5fnh643ixdkJ+tgDgMZDBQRbukLKB/h9CURMg4OmmQFxlinBal
         ty9Zx+uaMOWDso7Mqnuz0c5E+IIhj7/j+YTq1JU+tPfITk89Eowbq3FJaIoPNHjw88yC
         6fNO6WZDm1VHZsoIpZWbUG+xZWer49/6BqrMQwl+9Yn+TTktioBt2G3Fcx+8/AWRy3W/
         Y93XuVtoYvNS6LUEuKtcsiq7qYV7D9MJUw+HC1v5CojMpMeYiHkxDO3+NnSqcghauCtD
         cmUA==
X-Gm-Message-State: APjAAAVZmk1M382puewzckS/RHp2SoMHq7zpzn5I2szIsvnEoNJkQqRl
        c64CN+aYlKrCHRqK2UKJHEdS8mEu
X-Google-Smtp-Source: APXvYqxt5twvrB2BvXfxbxUKVyDguGl7T8TVR5QIVBKWaidigFL2LfBAnGc6j9NzRyYUelikuRmMpg==
X-Received: by 2002:a1c:3d6:: with SMTP id 205mr9210090wmd.66.1555052532602;
        Fri, 12 Apr 2019 00:02:12 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t76sm11314172wmt.8.2019.04.12.00.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 00:02:11 -0700 (PDT)
Date:   Fri, 12 Apr 2019 09:02:09 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH-tip v3 02/14] locking/rwsem: Make owner available even if
 !CONFIG_RWSEM_SPIN_ON_OWNER
Message-ID: <20190412070209.GC129493@gmail.com>
References: <20190410184231.6748-1-longman@redhat.com>
 <20190410184231.6748-3-longman@redhat.com>
 <20190411081224.GB4038@hirez.programming.kicks-ass.net>
 <29aca54a-536e-6e46-7e18-658914c34548@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29aca54a-536e-6e46-7e18-658914c34548@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> On 04/11/2019 04:12 AM, Peter Zijlstra wrote:
> > On Wed, Apr 10, 2019 at 02:42:19PM -0400, Waiman Long wrote:
> >> The owner field in the rw_semaphore structure is used primarily for
> >> optimistic spinning. However, identifying the rwsem owner can also be
> >> helpful in debugging as well as tracing locking related issues when
> >> analyzing crash dump. The owner field may also store state information
> >> that can be important to the operation of the rwsem.
> >>
> >> So the owner field is now made a permanent member of the rw_semaphore
> >> structure irrespective of CONFIG_RWSEM_SPIN_ON_OWNER.
> > sem->owner is still initialized under CONFIG_RWSEM_SPIN_ON_OWNER.
> 
> Oh, you are right. I missed that part. I will fix it in the next version.

Could you please post the next series against tip:WIP.locking/core, which 
is already being dogfood-ed in -tip and which I'm running on my desktop? 
I'll backmerge any fixes as needed/requested.

Thanks,

	Ingo
