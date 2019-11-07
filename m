Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF309C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C297921882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HtcOTn3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfKGT2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:28:01 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:38516 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfKGT2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:28:00 -0500
Received: by mail-wm1-f46.google.com with SMTP id z19so3757932wmk.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 11:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gv7piqE0NJN9u+0/VWapMYLQDSNoGwEvnT95iHm9RBo=;
        b=HtcOTn3ZWuljOuXCKi45eCAIudeUIys2Dkd9s1VzbtZBEhaaoS8zOnRZwxOfvhBLUL
         20VFcYDA4SLxa8GFKo1Lj+z4zT43fdIOMwT/N+cJe98m9j8UdntCOsyL0JEGk4otgB5l
         RIFqOT130uNTHlN/Dt2C1kIeTZpmdasLP/YMFnmD6M1fxfQd9wtHu1U2WjswYfNyvrea
         r6usN/YEMsHo/YZeJAJNdfU8syPHGIo9fa8me7orjakE58e3i+Dm9qXVSDoNbAmv+kJb
         nm2WOuXdWaqLkoDqMGTfP8U5ac40hmssQCOifSwsQnl4H/N3SGk0jWeHexVorbAqXxVb
         99Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gv7piqE0NJN9u+0/VWapMYLQDSNoGwEvnT95iHm9RBo=;
        b=cevlnzBe85Shw9mDO/fyDhAYBlKfDgmveiKHPmlxEclJNLIllMyA4vzoXZiV5+2yRa
         d+3PB9Roxb2FMpahOChqmFkC/Ke7Iqmh25bjkdansMshvbdavLgr6Ar3QIzLWdh30if5
         Va94pskT+Tt4PnzMAUg7bgGGvT/qCeKsDH8t66Di5Yco/MruH415m3gmlFarYA7ZiWiV
         JtdlnK9O1n2j2qsKq3d0FxCZc8sQiN8k2KdEbnG77sdEqygkEM6T8PqZpWQsFrgVXB2M
         oxsdZwYNrzIoDcuXAUS8vUs2WNHOZ7HZJbDLdiiPtMW+d5KudPEVEc8i4LEvtJ0r1vnI
         Z53g==
X-Gm-Message-State: APjAAAVBD8MwfbuquQ+4i9Sl9zi4ljykRIf8Sqh2GSOMnnXrPvmvBzDC
        bgQjre2D1Moz2rHLHoYPd98+cg==
X-Google-Smtp-Source: APXvYqxREIEDk8O6HqF7vSZ9tSUM1PBDhhLxYdS4Yag/N3kjj8SeQRoalxsyu/NnPxvHHEwkS9Yp1g==
X-Received: by 2002:a1c:6405:: with SMTP id y5mr4840693wmb.175.1573154877932;
        Thu, 07 Nov 2019 11:27:57 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id j67sm3096216wmb.43.2019.11.07.11.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 11:27:57 -0800 (PST)
Date:   Thu, 7 Nov 2019 19:27:53 +0000
From:   Quentin Perret <qperret@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, linux-kernel@vger.kernel.org,
        aaron.lwe@gmail.com, valentin.schneider@arm.com, mingo@kernel.org,
        pauld@redhat.com, jdesfossez@digitalocean.com,
        naravamudan@digitalocean.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        kernel-team@android.com, john.stultz@linaro.org
Subject: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191107192753.GA55494@google.com>
References: <20191028174603.GA246917@google.com>
 <20191106120525.GX4131@hirez.programming.kicks-ass.net>
 <33643a5b-1b83-8605-2347-acd1aea04f93@virtuozzo.com>
 <20191106165437.GX4114@hirez.programming.kicks-ass.net>
 <20191106172737.GM5671@hirez.programming.kicks-ass.net>
 <831c2cd4-40a4-31b2-c0aa-b5f579e770d6@virtuozzo.com>
 <20191107132628.GZ4114@hirez.programming.kicks-ass.net>
 <20191107153848.GA31774@google.com>
 <20191107184356.GF4114@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107184356.GF4114@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 Nov 2019 at 19:43:56 (+0100), Peter Zijlstra wrote:
> But you mean something like:
> 
> 	for (class = prev->sched_class; class; class = class->next) {
> 		if (class->balance(rq, rf))
> 			break;
> 	}
> 
> 	put_prev_task(rq, prev);
> 
> 	for_each_class(class) {
> 		p = class->pick_next_task(rq);
> 		if (p)
> 			return p;
> 	}
> 
> 	BUG();
> 
> like?

Right, something like that, though what I had was basically doing the
pull from within the pick_next_task_*() functions directly, like we were
doing before. I'm now seeing how easy it is to get this wrong, and that
even good-looking code in this area can be broken in very subtle ways,
so I didn't feel comfortable refactoring again so close to rc7. If you
feel more confident, I'm more than happy to test a patch implemeting the
above :)

> I had convinced myself we didn't need that, but that DL to RT case is
> pesky and might require it after all.

Yep, I don't see a way to avoid iterating all classes to do the balance,
one way or another ...

Thanks,
Quentin
