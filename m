Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D98AC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 09:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE71A206D9
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 09:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573983969;
	bh=5aX+TgcPFlPOgDbNv8lKP1niB9lY6s3AE7rkVvvAOjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zngdUUJGKmaLsKlz+HzSgMTjfsbINEdHgVCXXvNl3dBlTLtIrFLfDx2jPESkKylrp
	 rPv+GydpBRy3lwMoO9lPVYImmSKCjqSS+py1iV99ZuBg8LRoRXGoBmjHauxrQTZa4Z
	 0BInxNb5tnn7omZeQKXNkMfVXTPFf/NISH5OZvXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfKQJp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 04:45:56 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39197 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfKQJp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 04:45:56 -0500
Received: by mail-wm1-f68.google.com with SMTP id t26so15481279wmi.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 01:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WTfyDj6WShqhYiwMEsLuSNRdbUAyTCprS60Eet6bDCI=;
        b=OLhDViCivVMGBdCFGLSIcm8RPV8G5K/MDtZe30bIYsppgmyo1ItwPzVE1rUBsJ9Kr1
         YtOWuKa6uPZRz675eQKJgDspIG5DhR806ss1OH4kElN4YtkSWl+vWwgIyKeOaROEabK9
         3vHePVuwYJkUOYP40ivbjUtlGuzHj/OkhzwdjaicEGGpor/KvMG8daRpEvfTbdXzHTea
         CJdsNBcrIuyWz3qL9ol9wqnnkDP4z/72fB8V4IQGggqHrn9bbKK2fUClZbl0fETDFwFH
         hwWOfjSVkZYBHkmupbB4K0K73sysQOMIfO5M2KJ0pJ1tYPYZpmTDtoc67ZuT9nKuLvUs
         yKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WTfyDj6WShqhYiwMEsLuSNRdbUAyTCprS60Eet6bDCI=;
        b=MoQfD/iJ9r6G4cMgRqvD60SAjh+qfO7DaxUpnu5YjS45HscMIbRolrUXDOIHarB2Nk
         0yW+KHIb960V9YRLAq/LzUVFKisKui2rxFsbrM/s7ifcJYrkEpfnEYCVAGVM0Y9aaGVe
         7gO07v3QHX/nQnXzrfVq0mJ+Yyl831xRU3vEsfm1bK8gjVwKWZ6eKiiRlUcGWbHrJOv3
         X7cEqMqf1lt/M5QI80eKyPnIGx/DUDxci+GaI8SupLMoWXKXBbHn1Hz3r98jtWr/tv9H
         nBqAec26OH3OWJV2lnlUfQtnZynukInL1KqanlO2tDQMEXy/BMLeY1S97mnfaXg9rZoO
         jpnQ==
X-Gm-Message-State: APjAAAWyIqiURRLqC3qWe50Hi55pmtNuiVq3S166TqZf+hXLKs6ICbdv
        aw69DIsAM/i4A8qF08R87T5nZ9ql
X-Google-Smtp-Source: APXvYqzu3p4Kn0WeT96dew95wU3M2Zfgskq0Ndc+0t8Sb7IyOMPF9c9pvEWZIjl2S1BUl0khYHHXtA==
X-Received: by 2002:a1c:3b82:: with SMTP id i124mr21955202wma.122.1573983952395;
        Sun, 17 Nov 2019 01:45:52 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id l4sm16132078wml.33.2019.11.17.01.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 01:45:51 -0800 (PST)
Date:   Sun, 17 Nov 2019 10:45:49 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] scheduler fixes
Message-ID: <20191117094549.GB126325@gmail.com>
References: <20191116213742.GA7450@gmail.com>
 <ab6f2b5a-57f0-6723-c62f-91a8ce6eddac@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab6f2b5a-57f0-6723-c62f-91a8ce6eddac@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Valentin Schneider <valentin.schneider@arm.com> wrote:

> Hi,
> 
> On 16/11/2019 21:37, Ingo Molnar wrote:
> > Peter Zijlstra (1):
> >       sched/core: Avoid spurious lock dependencies
> > 
> > Qais Yousef (1):
> >       sched/uclamp: Fix incorrect condition
> > 
> > Valentin Schneider (2):
> >       sched/uclamp: Fix overzealous type replacement
> 
> This one got a v2 (was missing one location), acked by Vincent:
> 
>   20191115103908.27610-1-valentin.schneider@arm.com

I've picked v2 up instead. I suspect it's not really consequential as 
enums don't really get truncated by compilers, right? Is there any other 
negative runtime side effect possible from the imprecise enum/uint 
typing?

> >       sched/topology, cpuset: Account for housekeeping CPUs to avoid empty cpumasks
> 
> And this one is no longer needed, as Michal & I understood (IOW the fix in
> rc6 is sufficient), see:
> 
>   c425c5cb-ba8a-e5f6-d91c-5479779cfb7a@arm.com

Ok.

I'm inclined to just reduce sched/urgent back to these three fixes:

  6e1ff0773f49: sched/uclamp: Fix incorrect condition
  b90f7c9d2198: sched/pelt: Fix update of blocked PELT ordering
  ff51ff84d82a: sched/core: Avoid spurious lock dependencies

and apply v2 of the uclamp_id type fix to sched/core. This would reduce 
the risks of a Sunday pull request ...

Thanks,

	Ingo
