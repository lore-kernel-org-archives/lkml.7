Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0974BC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA8D207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xn43tYA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfIYRps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 13:45:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33085 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfIYRpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 13:45:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id i30so273963pgl.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 10:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZAuGgXVozBxAOyU104EisOA4FjYX9B/ph1VDDQrfSC8=;
        b=Xn43tYA4vLlz8TCF32HKJSEtg2SCWQgDnM4HWr5KCnJiZ95YwMY/MLHvKYTRH1E1aT
         PdWtlOrtLmQsFpX6/Nz8oSHu843qAcoL2fmA8n9/w8CcwI/aKHa6pKTlbt2oTljKtHoT
         5Bpjf0YklXGfTJ+fj8CFCKXk3oYuaYYqf0yGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZAuGgXVozBxAOyU104EisOA4FjYX9B/ph1VDDQrfSC8=;
        b=rNNZB8k7BMwkbzZ89liseomk7Zg4vDen+1WmFnQwaVy/6phzLUazesFenVvMUFTvFQ
         nw+caIXoBZYyr9rBLWGRvQU1Lsy9mK7sba/J+fZv82hWzdUSaVo6N2LWqWX8INtIPNRn
         iasnmfGpuVtdAWhyhPId+5VFprfBHU2R9PNwNP8L4KGQ9DYgW1+qTv9+ZCS8BBVQ0TFz
         xWdDQKQUp+joAnrf0rbBZlVvPa6I9wei4t7inKMRGUQpIeWSgS9lnAnA+cZ6Fy09JjIb
         OAcJbKnjtWCe4pVWa0Fm+6Dvb3Uzgy2GsHIWUJmOaxuexDYft7RyR4kCTvywaqKqTrrK
         RKqg==
X-Gm-Message-State: APjAAAWns6fCh8fPQe0oFRqvcZVmWEW3eOr7J9XesmVs4beMgoRcicyS
        I8X4GVliUC6gfdrq8KQ3T7hLSg==
X-Google-Smtp-Source: APXvYqxiD1rpTlqHrtU9YEtYSpp4KVbVAbHt0Mb8WqRxgoUa9sqTYMuk4PHPkRwJMeseB+Imz6hTDA==
X-Received: by 2002:a17:90a:2744:: with SMTP id o62mr7612146pje.139.1569433545789;
        Wed, 25 Sep 2019 10:45:45 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id b3sm3467917pjp.13.2019.09.25.10.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 10:45:45 -0700 (PDT)
Date:   Wed, 25 Sep 2019 10:45:43 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] devfreq: Add tracepoint for frequency changes
Message-ID: <20190925174543.GN133864@google.com>
References: <CGME20190919174436epcas4p17bf0528950813d3326237fcc56fd9b21@epcas4p1.samsung.com>
 <20190919174423.105030-1-mka@chromium.org>
 <62b2228b-e198-2558-2afc-e5687935742b@samsung.com>
 <20190924193721.GK133864@google.com>
 <418ddd67-ca8a-3d0e-066c-38d05a7082a8@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <418ddd67-ca8a-3d0e-066c-38d05a7082a8@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 10:56:15AM +0900, Chanwoo Choi wrote:
> On 19. 9. 25. 오전 4:37, Matthias Kaehlcke wrote:
> > On Fri, Sep 20, 2019 at 10:15:57AM +0900, Chanwoo Choi wrote:
> >> Hi,
> > 
> > sorry for the delayed response, you message got buried in my
> > mailbox.
> > 
> >> On 19. 9. 20. 오전 2:44, Matthias Kaehlcke wrote:
> >>> Add a tracepoint for frequency changes of devfreq devices and
> >>> use it.
> >>>
> >>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> >>> ---
> >>> (sending v2 without much delay wrt v1, since the change in devfreq
> >>>  probably isn't controversial, and I'll be offline a few days)
> >>>
> >>> Changes in v2:
> >>> - included trace_devfreq_frequency_enabled() in the condition
> >>>   to avoid unnecessary evaluation when the trace point is
> >>>   disabled
> >>> ---
> >>>  drivers/devfreq/devfreq.c      |  3 +++
> >>>  include/trace/events/devfreq.h | 18 ++++++++++++++++++
> >>>  2 files changed, 21 insertions(+)
> >>>
> >>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> >>> index ab22bf8a12d6..e9f04dcafb01 100644
> >>> --- a/drivers/devfreq/devfreq.c
> >>> +++ b/drivers/devfreq/devfreq.c
> >>> @@ -317,6 +317,9 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
> >>>  
> >>>  	devfreq->previous_freq = new_freq;
> >>>  
> >>> +	if (trace_devfreq_frequency_enabled() && new_freq != cur_freq)
> >>> +		trace_devfreq_frequency(devfreq, new_freq);
> >>
> >> You can change as following without 'new_freq' variable
> >> because devfreq->previous_freq is the new frequency.	
> >> 	trace_devfreq_frequency(devfreq);
> > 
> > In general that sounds good.
> > 
> > devfreq essentially uses df->previous_freq as df->cur_freq, I think
> > most code using it would be clearer if we renamed it accordingly.
> > I'll send a separate patch for this.
> 
> Actually, according to reference time of the 'df->previous_freq',
> 'previous_freq' is proper or 'cur_freq is proper.
> But, In the comment of 'struct devfreq',
> it means the configured time as following: 
> 	* @previous_freq:      previously configured frequency value.

sure, I wouldn't expect the comment of a variable/field called 'previous_freq'
say that it's the current frequency.

> I think that it it not big problem to keep the name.

It's indeed not a big problem, because the code works either way, something
like 'cur_freq' would just be less confusing.

These are the functions that use 'previous_freq' and how they use it:

devfreq_set_target
devfreq_monitor_suspend
cur_freq_show
target_freq_show
trans_stat_show
devfreq_passive_notifier_call
devfreq_userspace_func
  cur freq

devfreq_update_status
  prev freq

More than 85% use the variable as current frequency, which seems like a
good argument to give it the proper name, instead of having folks wonder
why the previous frequency is used.
