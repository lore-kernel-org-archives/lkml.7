Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35774C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF3F22CE8
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566241671;
	bh=WS4yyGbjYC4B18bcnZZce1vQWWAiLGBgWJOziVVpZ4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lJgX6WGLmIo/8DGqLmzaNocpQPTujRHFZkYV3pD5ICthJltu3rnefXsfsccgsI6eM
	 cf+kwD4VXpY9w+U2UN+1NUrlviu/O/rUqzSmBxc2MB4Wqf5sojTBYk4A+otZiCwZvs
	 GQ/y7Y1oqaDj3C4Z61Q82s8F0l6+/xUMpm46IdXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfHSTHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:07:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38275 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbfHSTHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:07:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so9851261wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 12:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sNWwP1tlQd65Dlqk5XPAYFUMjoVn08FaFSTdKZriNo4=;
        b=WN0lOnh+97cgzg1TdyLdrWptQMrfMbm4/icy+ElZTkYOvddnQ0xGFh5BI7ViSp8T3v
         3ntdyGHtUOsr5iqIzwpI8vnmNXqLY2i375b9v80Vomb5VkWszwbIB/2unQ0n5iNCGdUE
         1Qtojkd2y3QoBWKUUKe/BMMp7Z41dzzDYGpxc1x6C7uD6iQgzwX4uX9HErFgDKcRaQZe
         Ttr+ZvaZRk6uMPYKFY0Ic11bSypRbXDO7spD+fazZ9VsnMNPFP785Ff2ytKiSyib5yrK
         3ugPq6V2WiKadkcghzdtos14h1zqHLunsG2HN3wYI/sPtAXIX9l7ELN3CpoiPhJmgmBV
         Uu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sNWwP1tlQd65Dlqk5XPAYFUMjoVn08FaFSTdKZriNo4=;
        b=Tfcu8NzpxeWzEwTKaL5pGrEGVSNri2j34uJ3Kv4Ut1DenqJ2nNcHhPsQc3qrp1g+bk
         2YJPRJ36XxldZQOb7L48UQKWfO/UhGYjSfGIV0o+lIjaaBR6NZGnQN5UqWHu0TWkLeX4
         usbbQ/9hetr+37ckGtrqwbalVh1DRGHCYWVNWNb6szbBGlu3hVV/wjp6JlV2mYy6BX1E
         Q7u6In2gQ1+Lwkhz6685aLDluGkykgCRhSz2mBcgrvBqDk6L2WuxTbumkvokP0VspySy
         /Qc5Ht20kKq/Mh6vaUlI0nAYVbR85DuMSsrPVMAabbsnFVy7iDuJdnHts3tEPXMHF7PQ
         xbUQ==
X-Gm-Message-State: APjAAAUqSncl6u+OFqU6hdMzH0z8aZY38HnrPg/1Va+5BvNraw/RMyn3
        H8RtcDpI+Zx0M5Y4Ih442dY=
X-Google-Smtp-Source: APXvYqw3sJi3cQdvuaiUhUKVukbsliGshKPvNj45ESDjQaEqKLVpD0TFIejHrSrX+W4UFzxfnBMeLg==
X-Received: by 2002:adf:e801:: with SMTP id o1mr30323810wrm.45.1566241667689;
        Mon, 19 Aug 2019 12:07:47 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id p13sm18884766wrw.90.2019.08.19.12.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 12:07:47 -0700 (PDT)
Date:   Mon, 19 Aug 2019 21:07:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 15/44] posix-cpu-timer: Comsolidate thread group sample
 code
Message-ID: <20190819190745.GA68079@gmail.com>
References: <20190819143141.221906747@linutronix.de>
 <20190819143802.812020601@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819143802.812020601@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


in the title:

  s/Comsolidate
   /Consolidate

* Thomas Gleixner <tglx@linutronix.de> wrote:

> cpu_clock_sample_group() and cpu_timer_sample_group() are almost the
> same. Before the rename one called thread_group_cputimer() and the other
> thread_group_cputime(). Really intuitive function names.
> 
> Consolidate the functions and also avoid the thread traversal when
> the thread group accounting is already active.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/posix-cpu-timers.c |   59 +++++++++++++----------------------------
>  1 file changed, 20 insertions(+), 39 deletions(-)
> 
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -294,29 +294,37 @@ thread_group_start_cputime(struct task_s
>  }
>  
>  /*
> - * Sample a process (thread group) clock for the given group_leader task.
> - * Must be called with task sighand lock held for safe while_each_thread()
> - * traversal.
> + * Sample a process (thread group) clock for the given task clkid. If the
> + * groups cputime accounting is already enabled, read the atomic
> + * store. Otherwise a full update is required.  task sighand lock must be
> + * held to protect the task traversal on a full update.

 s/groups
  /group's

 s/task sighand
  /Task sighand

Thanks,

	Ingo
