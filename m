Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D7FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4632F206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l7Tw9KOn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbfCLR3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:29:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40941 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfCLR3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:29:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id y124so1320868pfy.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 10:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BnlIGKGZrYnCgV86vqT27THrDHPB/iqwuTCMl0zSBBU=;
        b=l7Tw9KOnGjTqrWS+D/ZgHg+xoBbgafeXNUftb4gGynr2F+1fEu4Y8PUPGNVz5a+hnT
         rbsMQSG3jgNbgGwd6j0VfZSchUMlgIa4iC1ElZLzfKd0zbWadObDCnihQ/rNWZafJsjq
         vh7aqFCHxMaNycjuN2eYy2Z9k7GoEdzLyPbwRzBJCaJKhaJr1gbnWoqezw/YmrPCp+J6
         cBKCey//7U/TST/20HaVfEwYFSazGnnzmuP9Ia0vDpQGZzQVdCMySRItY8vXr+zrKzfG
         9sWmLGEYE8m7frhpV54Ur0tCX2y3sIEcqlItALf7CQsTd1FmLGX94PYhjuvrPKjK7GD6
         xSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=BnlIGKGZrYnCgV86vqT27THrDHPB/iqwuTCMl0zSBBU=;
        b=uAEBYjWLmYw2Y3k/h0F3232cElOaSSP0RtNKHP17S+WHJSiEE4dZypSKYYLhtkeg+K
         Qc8xupHKWSUpOXsAJjMwdwn/3Ub90u/cWJO68yE+un0DW0ZWPci+79daWDIB3wbz5kWq
         ORG7ckzfecz3Ip1hQ+eBuin8Ylpc2J0s9T/feRitahgcDKBQkRfhPMNfBsPG9JRe/xwd
         Jhv/qo1WtEZvkgF37VIRCZ6EZV3xBbcIBPjbMqTCP2jUsMi+9fZvZ7v24z5brxMFLV3j
         /avOLOe7SvvrqXOw0F5YwGWUw/YV3ItCONBq4PD2uuEuTTAvZ+BYhnIep3aV56Bc3GwW
         btIQ==
X-Gm-Message-State: APjAAAUFBIsUlMGWsbnZNQ+lzPXsD/ADkxPF2aNy8LNwL1Xh7UC+72VS
        8JcvASTYCVClq/HlTvLACwzyDLT+BOo=
X-Google-Smtp-Source: APXvYqxvG5NtxrlkSKFmYgGukin01oNznFIQPKF+XDzwjQj6apkFJPiY+jaRzqun/apLfDIkoFtTGA==
X-Received: by 2002:a63:5c66:: with SMTP id n38mr35433587pgm.15.1552411778866;
        Tue, 12 Mar 2019 10:29:38 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id s6sm12160439pfm.94.2019.03.12.10.29.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 10:29:38 -0700 (PDT)
From:   bsegall@google.com
To:     Phil Auld <pauld@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC]  sched/fair: hard lockup in sched_cfs_period_timer
References: <20190301145209.GA9304@pauld.bos.csb>
        <xm26ef7mzew2.fsf@bsegall-linux.svl.corp.google.com>
        <20190304190510.GB5366@lorien.usersys.redhat.com>
        <xm268sxtyx5u.fsf@bsegall-linux.svl.corp.google.com>
        <20190305200554.GA8786@pauld.bos.csb>
        <xm261s3lyrrl.fsf@bsegall-linux.svl.corp.google.com>
        <20190306162313.GB8786@pauld.bos.csb>
        <xm26wolbyfe9.fsf@bsegall-linux.svl.corp.google.com>
        <20190309203320.GA24464@lorien.usersys.redhat.com>
        <xm26sgvtxq4m.fsf@bsegall-linux.svl.corp.google.com>
        <20190311202536.GK25201@pauld.bos.csb>
Date:   Tue, 12 Mar 2019 10:29:37 -0700
In-Reply-To: <20190311202536.GK25201@pauld.bos.csb> (Phil Auld's message of
        "Mon, 11 Mar 2019 16:25:37 -0400")
Message-ID: <xm26o96gxapq.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Auld <pauld@redhat.com> writes:

> On Mon, Mar 11, 2019 at 10:44:25AM -0700 bsegall@google.com wrote:
>> Phil Auld <pauld@redhat.com> writes:
>> 
>> > On Wed, Mar 06, 2019 at 11:25:02AM -0800 bsegall@google.com wrote:
>> >> Phil Auld <pauld@redhat.com> writes:
>> >> 
>> >> > On Tue, Mar 05, 2019 at 12:45:34PM -0800 bsegall@google.com wrote:
>> >> >> Phil Auld <pauld@redhat.com> writes:
>> >> >> 
>> >> >> > Interestingly, if I limit the number of child cgroups to the number of 
>> >> >> > them I'm actually putting processes into (16 down from 2500) the problem
>> >> >> > does not reproduce.
>> >> >> 
>> >> >> That is indeed interesting, and definitely not something we'd want to
>> >> >> matter. (Particularly if it's not root->a->b->c...->throttled_cgroup or
>> >> >> root->throttled->a->...->thread vs root->throttled_cgroup, which is what
>> >> >> I was originally thinking of)
>> >> >> 
>> >> >
>> >> > The locking may be a red herring.
>> >> >
>> >> > The setup is root->throttled->a where a is 1-2500. There are 4 threads in
>> >> > each of the first 16 a groups.  The parent, throttled, is where the 
>> >> > cfs_period/quota_us are set. 
>> >> >
>> >> > I wonder if the problem is the walk_tg_tree_from() call in unthrottle_cfs_rq(). 
>> >> >
>> >> > The distribute_cfg_runtime looks to be O(n * m) where n is number of 
>> >> > throttled cfs_rqs and m is the number of child cgroups. But I'm not 
>> >> > completely clear on how the hierarchical cgroups play together here. 
>> >> >
>> >> > I'll pull on this thread some. 
>> >> >
>> >> > Thanks for your input.
>> >> >
>> >> >
>> >> > Cheers,
>> >> > Phil
>> >> 
>> >> Yeah, that isn't under the cfs_b lock, but is still part of distribute
>> >> (and under rq lock, which might also matter). I was thinking too much
>> >> about just the cfs_b regions. I'm not sure there's any good general
>> >> optimization there.
>> >>
>> >
>> > It's really an edge case, but the watchdog NMI is pretty painful.
>> >
>> >> I suppose cfs_rqs (tgs/cfs_bs?) could have "nearest
>> >> ancestor with a quota" pointer and ones with quota could have
>> >> "descendants with quota" list, parallel to the children/parent lists of
>> >> tgs. Then throttle/unthrottle would only have to visit these lists, and
>> >> child cgroups/cfs_rqs without their own quotas would just check
>> >> cfs_rq->nearest_quota_cfs_rq->throttle_count. throttled_clock_task_time
>> >> can also probably be tracked there.
>> >
>> > That seems like it would add a lot of complexity for this edge case. Maybe
>> > it would be acceptible to use the safety valve like my first example, or
>> > something like the below which will tune the period up until it doesn't
>> > overrun for ever.  The down side of this one is it does change the user's
>> > settings, but that could be preferable to an NMI crash.
>> 
>> Yeah, I'm not sure what solution is best here, but one of the solutions
>> should be done.
>> 
>> >
>> > Cheers,
>> > Phil
>> >
>> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> > index 310d0637fe4b..78f9e28adc7b 100644
>> > --- a/kernel/sched/fair.c
>> > +++ b/kernel/sched/fair.c
>> > @@ -4859,16 +4859,42 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
>> >  	return HRTIMER_NORESTART;
>> >  }
>> >  
>> > +extern const u64 max_cfs_quota_period;
>> > +s64 cfs_quota_period_autotune_thresh = 100 * NSEC_PER_MSEC;
>> > +int cfs_quota_period_autotune_shift  = 4; /* 100 / 16 = 6.25% */
>> 
>> Letting it spin for 100ms and then only increasing by 6% seems extremely
>> generous. If we went this route I'd probably say "after looping N
>> times, set the period to time taken / N + X%" where N is like 8 or
>> something. I think I'd probably perfer something like this to the
>> previous "just abort and let it happen again next interrupt" one.
>
> Okay. I'll try to spin something up that does this. It may be a little 
> trickier to keep the quota proportional to the new period. I think that's 
> important since we'll be changing the user's setting.
>
> Do you mean to have it break when it hits N and recalculates the period or 
> reset the counter and keep going?
>

In theory you should be fine doing it once more I think? And yeah,
keeping the quota correct is a bit more annoying given you have to use
fixed point math.
