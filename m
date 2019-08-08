Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE1BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349AA2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfHHHAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:00:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34815 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfHHHAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:00:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id e8so2973248wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 00:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rpyM8r2mku1q3Z7OeG8NLWc6M46sqEuLs17+l7YtJBs=;
        b=Ge1fLKUygaLTLXNmV9pSeiezE/gtGq6KfsuHiA1ttoflYkt8KqIq2w2q8tS+xMEd6P
         wPuteGZru3kQtmTcRkYGee7d9yzoSN+z81EXErEGI8tGcpriP18Ek/GxiUsd0o7O8cG1
         EgU39utXkgqtZo+UhUyKJ31m6znc+wW6wEOTru3RH4wTre5I3hJ1Y1PAsN88YQVr47os
         hThykMetTNYkOnrAzk62AA3l369KgNFtR2Cg1zEod0O//o4pokOjTcQP7MhWottbwSPc
         Z6drtwb4WlBYep3q03Jv27LEeyz0dIihIKuH4OkCLPqvYcytJ/S+ypxzVJz9HV9DLWft
         qdpA==
X-Gm-Message-State: APjAAAUNMV6/fe3yak5U2G0yrMAeGnEginVbYr+O0Xu/yFFu/34HgjoW
        KsmpLNOW0a9SOasO76TO8zWQ/A==
X-Google-Smtp-Source: APXvYqzMqJaRfhKYmSLwEKXe/5sJ8WrTMTaguUiOhRJi2Q9MPLJPHkR5e3iJUPDdrT63zqnXb891zQ==
X-Received: by 2002:a1c:f511:: with SMTP id t17mr2413692wmh.53.1565247599806;
        Wed, 07 Aug 2019 23:59:59 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id w25sm1305257wmk.18.2019.08.07.23.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Aug 2019 23:59:58 -0700 (PDT)
Date:   Thu, 8 Aug 2019 08:59:56 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, luca.abeni@santannapisa.it,
        bristot@redhat.com, balsini@android.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 12/13] sched/deadline: Introduce deadline servers
Message-ID: <20190808065956.GE29310@localhost.localdomain>
References: <20190726145409.947503076@infradead.org>
 <20190726161358.056107990@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726161358.056107990@infradead.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/07/19 16:54, Peter Zijlstra wrote:

[...]

> +void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
> +		    dl_server_has_tasks_f has_tasks,
> +		    dl_server_pick_f pick)
> +{
> +	dl_se->dl_server = 1;
> +	dl_se->rq = rq;
> +	dl_se->server_has_tasks = has_tasks;
> +	dl_se->server_pick = pick;
> +
> +	setup_new_dl_entity(dl_se);

I think we need to postpone calling setup_new_dl_entity() to when
dl_server_start() is called for the first time. rq_clock() needs both
a caller that holds rq lock (which we can add) and an updated clock
(which I'm not sure we can do at this point in time, or maybe we can
avoid/trick the debug check?).

Thanks,

Juri
