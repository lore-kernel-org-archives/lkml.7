Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E988C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7224220663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575962485;
	bh=KsI6sxjYQ9tBfzTk1W4uVyWgH5WinlSmKliYhqmdvQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Gp0FoqmYsCOk9OTcFgcO50ZnEWygAnpxH7WzKnXME/v65VwzkPTTRXPkiZf7BX6DZ
	 FiInMins2Qg1hrYTsjapfVe2liPzfmnFjW+uvAb8mrYvAz+LHF62Up4cJzqDGJN90b
	 RqH/XXW1f1ZntQiyj53PgzXW0ZBDL5p/QvxHlem0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfLJHVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 02:21:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36414 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfLJHVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 02:21:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so18787283wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 23:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0wzzYMYPOjwNkj7Xx3adHoIqgjf64yRUp1Mn9AIQMBk=;
        b=TrJKbPXQuNU2MI0whFuy8Pmww7i0cZhZQrEBMjMRLn1C8wq5SmwDN+3oOZJhky272N
         9piWMmRafRzxZezVKl2uVdsz/F/tVOJr4FfInsbzNfplu7Cf12dx2lbAuBtn4ktAo56+
         3GFGCjlIoljPn1Um8F+EZjRe+pyGZE0dQIYZdQH2DPCenVsBqOLxPLiSZ019/yjSmhtw
         J1EQXgZahSCTV9ZXeEjEbW5u1bq690IPR61WCxy16UHqcLS6IHVShKxgZICfGIqjf2Vl
         3OdII1oeU3oRaCQgqPtuif/VlQdNpmz87p5FbVPcsuexyR52ZEe1uw+FcGn+gK0tGG/c
         68tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0wzzYMYPOjwNkj7Xx3adHoIqgjf64yRUp1Mn9AIQMBk=;
        b=pN7beMTPGukx3f7QBsAKJkPr/WojgrE6uNk3KNIbCSt0rLHnPwn4eEq8TvN7JNC2oq
         scYu8VoayKFTMyy79c636RsBkw/8Z0TEsjyO7Xc4gECNANNY4clHBlYbc4m1fzkHsaDs
         BPnQSFGK/6J6sUfceRZH/NHEyGEeqKIXKe/Dc/FOJ2m29cSDfB/YbCt7+EwiC6rNC/DI
         44iJK8vBr18D9lYKJZKihqDg/zBkPYmXpvpkyDSJqeAPitSoDxdG6UVwbk+rIEzbRATV
         KK15CYHgOgbgeKqRusAnU63QrBxeVFj779zmiEgW/D9nH/uW0q4IaI/w3SDbLf+NG8rd
         TVkg==
X-Gm-Message-State: APjAAAWalZAWRjr/TrejxdQb8OM8I+h6YsdWxLvGGDTrpUAWeNxtTF+P
        QWjB08+fbzIveY+MoSbdsC0=
X-Google-Smtp-Source: APXvYqyzTRZQdHx1wPH5LNDW3EZ7lT+kBqbKJoBM+b9yUc7IjQ8zmHxkDaJDLAumks3fcelUWX4UjA==
X-Received: by 2002:a5d:4749:: with SMTP id o9mr1352317wrs.242.1575962481867;
        Mon, 09 Dec 2019 23:21:21 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id n1sm2201159wrw.52.2019.12.09.23.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 23:21:21 -0800 (PST)
Date:   Tue, 10 Dec 2019 08:21:19 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Subject: Re: [RFC PATCH] sched/wait: Make interruptible exclusive waitqueue
 wakeups reliable
Message-ID: <20191210072119.GA114501@gmail.com>
References: <CAHk-=whiKy63tpFVUUS1sH07ce692rKcoo0ztnHw5UaPaMg8Ng@mail.gmail.com>
 <20191209091813.GA41320@gmail.com>
 <20191209102759.GA123769@gmail.com>
 <20191209130005.GB5388@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209130005.GB5388@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@redhat.com> wrote:

> On 12/09, Ingo Molnar wrote:
> >
> > Any consumed exclusive event is handled in finish_wait_exclusive() now:
> >
> > +               } else {
> > +                       /* We got removed from the waitqueue already, wake up the next exclusive waiter (if any): */
> > +                       if (interrupted && waitqueue_active(wq_head))
> > +                               __wake_up_locked_key(wq_head, TASK_NORMAL, NULL);
> 
> See my previous email, I don't think we need this...
> 
> But if we do this, then __wake_up_locked_key(key => NULL) doesn't look right.
> It should use the same "key" which was passed to __wake_up(key) which removed
> us from list.
> 
> Currently this doesn't really matter, the only user of prepare_to_wait_event()
> which relies on the "keyed" wakeup is ___wait_var_event() and it doesn't have
> "exclusive" waiters, but still.
> 
> Hmm. and it seems that init_wait_var_entry() is buggy? Again, currently this
> doesn't matter, but don't we need the trivial fix below?
> 
> Oleg.
> 
> --- x/kernel/sched/wait_bit.c
> +++ x/kernel/sched/wait_bit.c
> @@ -179,6 +179,7 @@ void init_wait_var_entry(struct wait_bit
>  			.bit_nr = -1,
>  		},
>  		.wq_entry = {
> +			.flags	 = flags,
>  			.private = current,
>  			.func	 = var_wake_function,
>  			.entry	 = LIST_HEAD_INIT(wbq_entry->wq_entry.entry),

Yeah, agreed.

Thanks,

	Ingo
