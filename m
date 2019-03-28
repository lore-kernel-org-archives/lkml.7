Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89776C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEA6206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoAGbE6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfC1A4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:56:10 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:46104 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfC1A4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:56:09 -0400
Received: by mail-io1-f47.google.com with SMTP id b9so15740558iot.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 17:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=60D39l3x32wsz7KIGkp7b/pV+xyExCbdKVPxeH3ihjg=;
        b=UoAGbE6D4bnIJDxz7weXnVaVO6O0nBA7BIm+QTPQ6EfSeT1Ztdtsa7CjUQTwMEvtQ2
         P5lZt7JKnLAod+VHnQkfQ0WcH9iizkL6bXVZSxjdy42nnfwMUKO746iKm9+Q5b6gl2Tz
         i03turBlaAV38UoihBegcmzc99AYIOUckIGwezvEH8q1+7vDdKBAUtVvRQciXj3AUFuP
         DZvhWmSttq3uG0f3eKDDfsXpaEZrBFnFy5/e4AqUlIfIwLIuyrucCDgEtJjC3DGW4Q8G
         fOwELk1bJfIWGBqpEjj9tbJlDZEOIfhTid6jMuSGqBdTHxjTNyXmQSoDBs1mw807Gt0e
         mEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=60D39l3x32wsz7KIGkp7b/pV+xyExCbdKVPxeH3ihjg=;
        b=Ha0FSWQ13gMvMpv3z43ls51UxyNvNKesh1l9iNRJxediLwgyj2UJ3KwOO4wBwLhL9Z
         aOVfBGUzKHpEikQrRbiF91yT7mgOd3LGVQNiAZD831v7sXygeKcHHEY5IKv0MTzadC8g
         kshTg5VsedVXD+ZPWXPQcf6iPk+SPtbe6n8wkVh1NKAJI2xEM7WiMhR7UKD0gHgGKdkt
         cYsYRkrg5OVlLM3wDk6FxBhBx/0ZFOit7Dl3kYhpQ5dHkG8iJX6iJ5SdE+mXlxRm0V5f
         3j/Qmwv6X/mujagIDwKjmfw4IGco3pCo++2GWhd75rLic15x+8tJ88cnA7ecvJItkOY2
         B/XA==
X-Gm-Message-State: APjAAAViv67XYDruv+/eoMLrY70wWU0P76rf9VOoBECFZsx3has5NVx5
        +QP7MbQEOWZYliPgP5nOhvQ=
X-Google-Smtp-Source: APXvYqycr6ZZ/smUzgsFBrsLdMIAUjmGSVOhMJjm36+JBrDWoD71r2RKui/+fmMeOD0ON7lojFAwFg==
X-Received: by 2002:a6b:3709:: with SMTP id e9mr3763891ioa.282.1553734568798;
        Wed, 27 Mar 2019 17:56:08 -0700 (PDT)
Received: from bat.mindbit.ro (CPE00fc8d79db03-CM00fc8d79db00.cpe.net.fido.ca. [72.140.67.131])
        by smtp.gmail.com with ESMTPSA id u66sm10224390ioe.74.2019.03.27.17.56.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 27 Mar 2019 17:56:08 -0700 (PDT)
Message-ID: <182b993b34ee0dc80dab150984f08d33efaf5eda.camel@gmail.com>
Subject: Re: pick_next_task() picking the wrong task [v4.9.163]
From:   Radu Rendec <radu.rendec@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Date:   Wed, 27 Mar 2019 20:56:06 -0400
In-Reply-To: <20190323101540.GC6058@hirez.programming.kicks-ass.net>
References: <CAD5jUk9s6+dXxAGWNWGbNRZ60QUKN0B37R=pYwci=SDOSSFmFg@mail.gmail.com>
         <20190323101540.GC6058@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-03-23 at 11:15 +0100, Peter Zijlstra wrote:
> On Fri, Mar 22, 2019 at 05:57:59PM -0400, Radu Rendec wrote:
> > Hi Everyone,
> > 
> > I believe I'm seeing a weird behavior of pick_next_task() where it
> > chooses a lower priority task over a higher priority one. The scheduling
> > class of the two tasks is also different ('fair' vs. 'rt'). The culprit
> > seems to be the optimization at the beginning of the function, where
> > fair_sched_class.pick_next_task() is called directly.  I'm running
> > v4.9.163, but that piece of code is very similar in recent kernels.
> > 
> > [...]
> > 
> > I instrumented pick_next_task() with trace_printk() and I am sure that
> > every time the wrong task is picked, flow goes through the optimization
> 
> That's weird, because when you wake a RT task, the:
> 
>   rq->nr_running == rq->cfs.h_nr_running
> 
> condition should not be true. Maybe try adding trace_printk() to all
> rq->nr_running manipulation to see what goes wobbly?

The answer is in enqueue_top_rt_rq(): it returns before touching the run
queue counters because rt_rq_throttled(rt_rq) is true. So basically this
is RT throttling kicking in. I confirmed by disabling RT throttling and
testing again.

So there's nothing wrong with the scheduler. The "sched_wakeup: comm=.."
trace was a bit misleading. What happens when RT throttling kicks in is
that the task is woken (and probably changes state to TASK_RUNNING) but
not actually added to the run queue.

Thanks again for looking into this and sorry about the noise!

Best regards,
Radu Rendec


