Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E635EC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C169B2199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfGVIcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:32:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45929 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfGVIcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:32:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so38393509wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 01:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R9bzahhq3ljNlfBNBmXOt8CPhPYVWX1wy9gOZA82RJA=;
        b=cECxVKR2yN4NqkYnC4fU8POXmr8r/0xiF+07wP7emRed7kl9Pp/HfZjD1BLVmkM4De
         8R2fVx1+8Wmqfmpeb7loFaf4zed+lVUxWnZSW+zAEEDup8qHHY6V4+B9BXx3IrLa9S0/
         oG7qlOKPszBD92gtowCvkHukaN10BnKkEqx08/muYK1LGL3m/efByX0HPkofoQGVXgws
         u6gJZQIWEkvilp3KMyJ0KxiNhPe91LhkPA0SQ3KBv6XtwpatArt+Y43P9rnAosWnLV6+
         WZN3PvVCT2cV0AW5GG0T7rJn7ISdxwd2xgFDDYT8hhcVuFPe7JklMnZP6zWTvE7wDsUK
         Yc5Q==
X-Gm-Message-State: APjAAAUhTHiToyAe3emt7xBtETTxpB7JhfaBYshEQydt2vhKHse5gHRK
        xJq66zm9RHrViqpNYVuGy10Xow==
X-Google-Smtp-Source: APXvYqzJ4NshqzNR5HOD2m25St6NhYG/iWTOz3OYMgjlr9YRkiANXvso2vpl4fBH9Y+XtOi7i5PyFQ==
X-Received: by 2002:adf:f68b:: with SMTP id v11mr9008216wrp.116.1563784338289;
        Mon, 22 Jul 2019 01:32:18 -0700 (PDT)
Received: from localhost.localdomain ([151.15.230.231])
        by smtp.gmail.com with ESMTPSA id x18sm34282815wmi.12.2019.07.22.01.32.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 01:32:17 -0700 (PDT)
Date:   Mon, 22 Jul 2019 10:32:14 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com, longman@redhat.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v9 2/8] sched/core: Streamlining calls to task_rq_unlock()
Message-ID: <20190722083214.GF25636@localhost.localdomain>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-3-juri.lelli@redhat.com>
 <50f00347-ffb3-285c-5a7d-3a9c5f813950@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50f00347-ffb3-285c-5a7d-3a9c5f813950@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/19 10:21, Dietmar Eggemann wrote:
> On 7/19/19 3:59 PM, Juri Lelli wrote:
> > From: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> [...]
> 
> > @@ -4269,8 +4269,8 @@ static int __sched_setscheduler(struct task_struct *p,
> >  			 */
> >  			if (!cpumask_subset(span, &p->cpus_allowed) ||
> 
> This doesn't apply cleanly on v5.3-rc1 anymore due to commit
> 3bd3706251ee ("sched/core: Provide a pointer to the valid CPU mask").
> 
> >  			    rq->rd->dl_bw.bw == 0) {
> > -				task_rq_unlock(rq, p, &rf);
> > -				return -EPERM;
> > +				retval = -EPERM;
> > +				goto unlock;
> >  			}
> >  		}
> >  #endif

Thanks for reporting. The set is based on cgroup/for-next (as of last
week), though. I can of course rebase on tip/sched/core or mainline if
needed.

Best,

Juri

