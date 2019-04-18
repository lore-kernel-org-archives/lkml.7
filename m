Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E75C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0012183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555591723;
	bh=+F97449T7IAvQwuTrW1iePk7ifpPBIV/f7q90QsVQiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=blFLfnpMtxCQQ5VaVJFcEcpFSbCvTXrwP/LC5IbICKdSGKjkeBYvHgTxOprxy62V+
	 FSrnZLQgZdUqMRJPiFAgPbtfEHJtyuCkVaoqXgbtPS3Rc6LTvsNfZd9jaxJVPEIR1B
	 dey5YSqoVD/7Ao3N7el4knyzMlLMvqdQrE0qjcVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389013AbfDRMsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:48:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38965 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733205AbfDRMsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:48:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so2829045wrn.6;
        Thu, 18 Apr 2019 05:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MCFgAqBpz/w0Z9dtUSYXfFyNheJYJrXxFA3vkZvBVqY=;
        b=dHpFEoyfhbSkefs55muUV5ojGuvPmMqqyGhpfSakH1iE5Uu8DsaVAmcyJTcXx1LprA
         4UWUP+WITFQmE/hw6rdsYqYc8bYbkG7Otkk6Xk1uPQpHax1dS46uBBYoN56MQES9v6vP
         u/Mk/3M4CBP9wdnBkTLHwil+tZAuIN3izKAx27u6Gifc/aRg+K9Y4Y1JeXtHamwQgVrP
         7UQoE+regS+2358gFzH4PVFmMVLWTY1JuFEjp2o5GcJjaoXqQc4EHn4r0CPKVUyT0uGu
         Hkw87T4vfmp48TAdwclUBaifQth3bO2azEfrYevVLouFtSdKq3GFhHcrdr9pLIyWtMlJ
         rlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MCFgAqBpz/w0Z9dtUSYXfFyNheJYJrXxFA3vkZvBVqY=;
        b=iYSdcXksxvxxfaHgamZPGBz1Uy9tXD/T08T02iMUe2wxhDe0JYGlm2BsJw9nsJhZ1n
         WXZP+Egomp5Jjpw7zXpS5l60EVQievHEusp2hHcbmQLBo4R7Cx+GY06zO/drK5V0LjYB
         hHFX1tzMjnsng6pLtrGY/EiRbYSPpxWV2MV60aBkp7Jlaij399Bhzn7GalpK5HutviD5
         ss97nPlknSfKbWFHvR1sUUHpRfRzJz6xmfmXQZTIQB+iW+SSylAD8CtfK9ZW6ALrg/ff
         YsZL7OrGvmL1mzPtB0nFVxiyv93f/LtXyqv6SZCqX2YTK5hC/yWDKmE9Ez+Gmh7Q9ELa
         jY3A==
X-Gm-Message-State: APjAAAWXLMDvl+MK2pHBm5+Wpm63mz4nA6qlUnl3gVIh4Uio+xRKlxt2
        rPqwsDmicbkhtKVTfBYkaO8=
X-Google-Smtp-Source: APXvYqwRj312AxC1AsWn+GCRLTRdsOaKxPeSq/oeWEPfklpdCFmdWj4pdh1dvnL3EyjsTHL/vk707A==
X-Received: by 2002:adf:f405:: with SMTP id g5mr4098421wro.310.1555591719525;
        Thu, 18 Apr 2019 05:48:39 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a187sm2775783wma.32.2019.04.18.05.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 05:48:38 -0700 (PDT)
Date:   Thu, 18 Apr 2019 14:48:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com, peterz@infradead.org,
        yuehaibing@huawei.com
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] sched/core: Make some functions static
Message-ID: <20190418124836.GB104512@gmail.com>
References: <20190322143153.14416-1-yuehaibing@huawei.com>
 <tip-16e671afb70f28eb189136d1395c59dafecd270a@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-16e671afb70f28eb189136d1395c59dafecd270a@git.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot for YueHaibing <tipbot@zytor.com> wrote:

> Commit-ID:  16e671afb70f28eb189136d1395c59dafecd270a
> Gitweb:     https://git.kernel.org/tip/16e671afb70f28eb189136d1395c59dafecd270a
> Author:     YueHaibing <yuehaibing@huawei.com>
> AuthorDate: Fri, 22 Mar 2019 22:31:53 +0800
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Thu, 18 Apr 2019 14:19:25 +0200
> 
> sched/core: Make some functions static
> 
> Fix these sparse warnings:
> 
>   kernel/sched/core.c:6576:11: warning: symbol 'max_cfs_quota_period' was not declared. Should it be static?
>   kernel/sched/core.c:6577:11: warning: symbol 'min_cfs_quota_period' was not declared. Should it be static?
>   kernel/sched/core.c:6657:5: warning: symbol 'tg_set_cfs_quota' was not declared. Should it be static?
>   kernel/sched/core.c:6670:6: warning: symbol 'tg_get_cfs_quota' was not declared. Should it be static?
>   kernel/sched/core.c:6683:5: warning: symbol 'tg_set_cfs_period' was not declared. Should it be static?
>   kernel/sched/core.c:6693:6: warning: symbol 'tg_get_cfs_period' was not declared. Should it be static?
>   kernel/sched/fair.c:2596:6: warning: symbol 'task_tick_numa' was not declared. Should it be static?

So unless this is somehow version dependent or other changes interfered, 
this patch wasn't tested very well:

 kernel/sched/fair.o: In function `sched_cfs_period_timer':
 fair.c:(.text+0x920c): undefined reference to `max_cfs_quota_period'
 fair.c:(.text+0x9214): undefined reference to `max_cfs_quota_period'

skipping it for now.

Thanks,

	Ingo
