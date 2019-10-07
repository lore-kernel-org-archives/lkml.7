Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70E4ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D34820673
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570465238;
	bh=k8bWCaLv3Ck5619zahS0wFoXqqRWueQQozvCIHASccE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K8HwAUwchxL8AYf8Isb79CqMzbzzZD+s6epNEGHF59E2ShJM0Zl/Ln/Gq9l94JA/S
	 f3MBzkLGr19IEE8i8Qv7rQKEGNE9N7byPtutn6wX82cJozvaZYG13/kug8nSqoi3F6
	 lXcdNpuTKj1cYeFFFlEyJcrxsw7iFsVtmhwkHypw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbfJGQUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:20:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37127 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbfJGQUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:20:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id p14so15121278wro.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 09:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ri8vm/ezKRwl75wbz/HtUEr3mN+iWcsdAOxE2zd9lHk=;
        b=WXyI0aW3CwE7lqT5tFsUTIugOYQHUXQ+vQRCRFNRRaPPgIh+acnw6gKmC9jsBTk8dV
         xPJIvztdT9NHJ8s9C+rCiWDJyalwKUt2s3TJOLWblAYXTgLbtBTQsl2NrB1DWJG1Ux+D
         +dN14ONSTKK0psQLym7IbNZK4ee20whqIZjmBE4oEjelxJzCC00cY4k8msPiNMBYw/1x
         HXflbePn80on+pYk7FD0Wn0qeouyaxrltMPMWUCj9LVTTxJ0Yvh0T+oJLW+bzY9TwkOi
         gjvtlw4FQuTV4xHSWfJAdHg/+BRfJNy6kzYd7n8yDzGDHr9P8IXmOBy1Pa933kgtQm9l
         i9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ri8vm/ezKRwl75wbz/HtUEr3mN+iWcsdAOxE2zd9lHk=;
        b=An0DyzY7kqHKWwTkv7lqal1pTk7oTdkHHOswMdVRndzSu0DgxiIjxBzShNKoUl2CcP
         B2K7TXrIAdeK3YYDmJ9ZLtOk1dFrPGo1U0IX0lxisYUj2zS2Tv5Pl+e21eCVVkezPv0K
         lRVBxZNgAStpPbGOmywBdT4+9pXnBix7keBZgTOLYZnh5i768le2gplxi73+9oAf7v46
         CIngPtY/FHeGb5PVV4J+L8z+rZf7zoP+nz4bpWWfpsb0h0/G2fYcSpJ5iv+Pgi0YlafF
         Y+vk9ijYUyth5kzz3al0IoMAmtkcwNZkmz3TgSSWujisuHbk5SGBbBhnOTDhtYuhre0o
         gfkw==
X-Gm-Message-State: APjAAAVAq5ZyVlilW2PBF4EvWSEYPtPTRh3EGdOQQzZToJCJBemzSXf/
        nV8xz/mXuA3Nsu4fjw9bFbCJgVCk
X-Google-Smtp-Source: APXvYqwtO3UT2MrnRVuLaGSAfB8Gj0CM9mX0HD+I1pm9FrENgbC5spDPfCMGm6TsL822aawUTxpY0Q==
X-Received: by 2002:adf:ec91:: with SMTP id z17mr24448592wrn.346.1570465234474;
        Mon, 07 Oct 2019 09:20:34 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g1sm15825119wrv.68.2019.10.07.09.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 09:20:33 -0700 (PDT)
Date:   Mon, 7 Oct 2019 18:20:31 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 0/2] vtime: Remove pair of seqcount on context switch
Message-ID: <20191007162031.GA7676@gmail.com>
References: <20191003161745.28464-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003161745.28464-1-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Frederic Weisbecker <frederic@kernel.org> wrote:

> Extracted from a larger queue that fixes kcpustat on nohz_full, these
> two patches have value on their own as they remove two write barriers
> on nohz_full context switch.
> 
> Frederic Weisbecker (2):
>   vtime: Rename vtime_account_system() to vtime_account_kernel()
>   vtime: Spare a seqcount lock/unlock cycle on context switch
> 
>  arch/ia64/kernel/time.c          |  4 +--
>  arch/powerpc/kernel/time.c       |  6 ++--
>  arch/s390/kernel/vtime.c         |  4 +--
>  include/linux/context_tracking.h |  4 +--
>  include/linux/vtime.h            | 38 ++++++++++++------------
>  kernel/sched/cputime.c           | 50 ++++++++++++++++++--------------
>  6 files changed, 57 insertions(+), 49 deletions(-)

Which tree is this against? Doesn't apply cleanly to v5.4-rc2 nor v5.3. 
Does it have any prereqs perhaps?

Thanks,

	Ingo
