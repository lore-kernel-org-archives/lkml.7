Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C84C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E05208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406773AbfHIMQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 08:16:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44077 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfHIMQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:16:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so98029916wrf.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 05:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dKnNcxO/SH3Z8UOygzTGmouoajQ3hut2OapA+pyA0Sk=;
        b=Z9JvlTYqn5SkaUhdKSLfvSEHvQWBZLt8x0Ft1537YTK1Mwu8QGMyTO360YNCEEQGzS
         A1KGUgrK5Us4NDiQYMen3imXXAnv0vRT5mo4NorBMSuW8uBd4Db/stSnNgp6d5oBEfPS
         Od07Wpf0mVkiJ9Kska0bP5Rrr+qjPuuVgPf8lveMMX5O2WsWYwHAqLcryR/eCdTHLISP
         OAl6l7BwQHwTbPVq29z/SaHMhGZUefPZxcuyPx8Q5wGLmUn0V58Mvb+Q+GGmWftJ2KX9
         715ib9d88fDrqS+CUT7ydwbFW2fQRBhFJnhf77daEASJOk8VtqU3WAyMDzQ8sMpU+FVy
         dHvQ==
X-Gm-Message-State: APjAAAXEr/GANq61qUVoFirl3QWJ+GYvUQWrlTZjSlP2Waqfc/G4eDQN
        Pg5z4reccFRUqggFc7WPUEsu9g==
X-Google-Smtp-Source: APXvYqy6V0bMNkkWpoNIoqG7/jvb8tmPFpGos6GGp8b3uAdG8cGYOebvtgU+DVaaeRwlxIKnHP8aRA==
X-Received: by 2002:a5d:4fc8:: with SMTP id h8mr23983716wrw.177.1565352992323;
        Fri, 09 Aug 2019 05:16:32 -0700 (PDT)
Received: from localhost.localdomain (mi-18-41-148.service.infuturo.it. [151.18.41.148])
        by smtp.gmail.com with ESMTPSA id v3sm144491wrq.34.2019.08.09.05.16.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 05:16:31 -0700 (PDT)
Date:   Fri, 9 Aug 2019 14:16:28 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        bristot@redhat.com, balsini@android.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 12/13] sched/deadline: Introduce deadline servers
Message-ID: <20190809121628.GM29310@localhost.localdomain>
References: <20190726145409.947503076@infradead.org>
 <20190726161358.056107990@infradead.org>
 <b85f1f95-40e5-852b-f897-1379414354c9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b85f1f95-40e5-852b-f897-1379414354c9@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/19 11:17, Dietmar Eggemann wrote:
> On 7/26/19 4:54 PM, Peter Zijlstra wrote:
> 
> [...]
> 
> > +void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
> > +		    dl_server_has_tasks_f has_tasks,
> > +		    dl_server_pick_f pick)
> > +{
> > +	dl_se->dl_server = 1;
> > +	dl_se->rq = rq;
> > +	dl_se->server_has_tasks = has_tasks;
> > +	dl_se->server_pick = pick;
> > +
> > +	setup_new_dl_entity(dl_se);
> 
> IMHO, this needs rq locking because of the rq_clock(rq) in
> setup_new_dl_entity().
> 
> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/sched/sched.h:1119
> dl_server_init+0x118/0x178
> ...
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G        W
> 5.3.0-rc3-00013-ga33cf033cc99-dirty #10
> [    0.000000] Hardware name: ARM Juno development board (r0) (DT)
> ...
> [    0.000000] Call trace:
> [    0.000000]  dl_server_init+0x118/0x178
> [    0.000000]  fair_server_init+0x5c/0x68
> [    0.000000]  sched_init+0x2c8/0x474
> [    0.000000]  start_kernel+0x290/0x514
> 
> [...]

Right.. noticed the same and had a similar thinking the other day (1st
hunk): 20190808094546.GJ29310@localhost.localdomain
