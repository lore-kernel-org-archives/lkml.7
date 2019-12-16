Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3872C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78A62176D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LYUkzB4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfLPR7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:59:17 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:40933 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbfLPR7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:59:07 -0500
Received: by mail-wr1-f52.google.com with SMTP id c14so8429848wrn.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 09:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nyzpatslq3sNcFnnNYB5yVgYFR+0Qfg1Ncm4xBT+u4Q=;
        b=LYUkzB4yrQdN9CRza79KPJ+m/6u1gXDWF5EYzkXiFvsY9a5TNS/7jcPpRqwe4Lnk+F
         PGxXcw8eGl8uQeiDSMFT+JSGRsV+DYfDI3HKJ5FTgROMY+riTkoPh43NGeN4mGbWkVFV
         cb0mwnU8Pyxa9XpBI0yUywOYwwACfIxYIkpH6dyJLmh1U603KAOYjmu5WidOs2oYmFo/
         kEzrSTReq6n7bV89itS5aKXarXMZgIN5xmY7fTyeDyjyjzWOS+iZIyDwLhUX5DVHwvWk
         jiUbmSTY8FOTQdnKSxVzg4TITdmgOU5CSZ/SHg70K1th9PcfjX7FNfw6TNDKXXCgVP9r
         3MEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nyzpatslq3sNcFnnNYB5yVgYFR+0Qfg1Ncm4xBT+u4Q=;
        b=KPSP5swlC0b8USYuvnDfLbILdhgh8fLHB0taUtlzmJUQFka9pzFCFoNB8ELrAqMF1M
         Yih5N7qGoqTTk849i889geR9uy7xLZLEFm/QvxAdBQ/D8DmPRpbi9v2/Rdiecyu0RTHJ
         ZczYoT63rCxsO4fM8+1OjSaoAqOEUDXPR2zVd0zyqYK/z0dBnf5VOoQQKJXrhdM2fDC1
         7GRgbeGsSKtbUrc3f22/vKGPoMgyI6XSXHo5FuKjsDGSQrzsBIY98mMHVQyuX6ZI8jVA
         iD82fcjTtppCShLLM3Wu4Re5/sLP9wI4MVOzNr9kkKnupRc3gVTlRvPlDfT8lzwhR0ZY
         EU8w==
X-Gm-Message-State: APjAAAXvsbXhszD4o7SeEcZqqq3Ko0iiaiFswtn/bj1zMEez8jY18Ntc
        nZp+1au/zThSS/pJtaDBQF6Q3Q==
X-Google-Smtp-Source: APXvYqzMbYwu0nWUARYpSZmjUXhnLMPTtgaF2SkpXBHxeDzWYsijtfqoqpwthvfDTGGW50DgtmpwSA==
X-Received: by 2002:adf:f091:: with SMTP id n17mr32527758wro.387.1576519145294;
        Mon, 16 Dec 2019 09:59:05 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id c68sm174435wme.13.2019.12.16.09.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 09:59:04 -0800 (PST)
Date:   Mon, 16 Dec 2019 17:59:01 +0000
From:   Quentin Perret <qperret@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        amit.kucheria@verdurent.com
Subject: Re: [Patch v6 4/7] sched/fair: Enable periodic update of average
 thermal pressure
Message-ID: <20191216175901.GA157313@google.com>
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
 <1576123908-12105-5-git-send-email-thara.gopinath@linaro.org>
 <20191216143932.GT2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216143932.GT2844@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 Dec 2019 at 15:39:32 (+0100), Peter Zijlstra wrote:
> > @@ -10274,6 +10281,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
> >  
> >  	update_misfit_status(curr, rq);
> >  	update_overutilized_status(task_rq(curr));
> > +	update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure);
> >  }
> 
> My objection here is that when the arch does not have support for it,
> there is still code generated and runtime overhead associated with it.

I guess this function could be stubbed for CONFIG_CPU_THERMAL=n ?
That is, reflecting the thermal pressure in the scheduler only makes
sense when the thermal infrastructure is enabled to begin with (which is
indeed not the case for most archs).

Thanks,
Quentin
