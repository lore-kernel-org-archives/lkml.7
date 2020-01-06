Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8409CC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5577A20731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNPO+xcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgAFOtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 09:49:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44275 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgAFOtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 09:49:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id az3so21930351plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 06:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+5KkCEJTHet/ODA4BY5IhjTYzU8pCXl/PboQB3tDbt0=;
        b=DNPO+xcJPIOb5NfBdY4oDL5mQ8Kudtc8gAXG94lp8kAuIRFrv+dLVGPJqf6dfzkgOm
         UUBJsgmV/TLRbiboRpvF37vhVWi/YkYkgjN8w4ZLw7NhDdHBpc3csLs/mwdh1BkJU0jw
         60pIujj1h9ayvArvkYdxppSk17cALn3Kj4V/KYFIOZ9Hoa46DmCahDzTGgErbKcI/rN9
         4V28k5snUuLL9aQpboO4uEJH909fhB2x6MoGuEqwqcs+zAIdDxjbmglr7CkJKS+3q1VM
         FYG489t2bmDtTDO9Vu5+klrM1z/YohNRsSw45lq+vZjOPA09AAXbk75F2Wm4ThYFBeLL
         sE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+5KkCEJTHet/ODA4BY5IhjTYzU8pCXl/PboQB3tDbt0=;
        b=ERuXGWnjc8lTAVv39l45cDMgnzIW8XDUxKx7HkBEqaRd+SBZFNe7NHaO0bh1mfvj4E
         a14ibQHiWfGBPnyIDI3cxD+jiIjCr9MmXq0f/u9s0FEx0iNf28hXwZ6flrqKPGeWjYKQ
         jh4tItvrozigRdeJUNgWmVlx9pwon/KOiDPVhffX0rOsyq652AUDP/tSFUnQgJSQRtCE
         pkUvusfsllM6r41hcY7s3f//iz4EGYKhf13w8BhDwWSAciku75PDDJpWq/4CWBl8izz6
         3DZkxIkF14RRBLyeJodT5GYbVJbUT8KpNDRva0cm9NBOvdpZf6LAzrjHXwUCs5GWj6Na
         lteQ==
X-Gm-Message-State: APjAAAW9aF5WViCof20o2PVfwdLPiNtD2px3FU+0wPogN7vxx44CRaNu
        8yTd9lY2v7t3rK8jARsSuNDiDBBL
X-Google-Smtp-Source: APXvYqwUNnr5bXkazm8n6SVo1ldWt0K16WWb6Ivwfd1NTWhUN/ohpXbZo65QyGKFH06Ss3LjSqg7yg==
X-Received: by 2002:a17:90a:a88d:: with SMTP id h13mr40883062pjq.55.1578322186418;
        Mon, 06 Jan 2020 06:49:46 -0800 (PST)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id q22sm80480902pfg.170.2020.01.06.06.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jan 2020 06:49:45 -0800 (PST)
Date:   Mon, 6 Jan 2020 22:49:41 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, qais.yousef@arm.com,
        morten.rasmussen@arm.com, valentin.schneider@arm.com
Subject: Re: [PATCH v2] sched/fair: fix sgc->{min,max}_capacity miscalculate
Message-ID: <20200106144941.GA15532@iZj6chx1xj0e0buvshuecpZ>
References: <20200104130828.GA7718@iZj6chx1xj0e0buvshuecpZ>
 <e034b806-bb3d-98c0-5d60-53610bfe6ca0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e034b806-bb3d-98c0-5d60-53610bfe6ca0@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 10:25:49AM +0100, Dietmar Eggemann wrote:
> On 04/01/2020 14:08, Peng Liu wrote:
> 
> Could you add a hint that this is about the SD_OVERLAP path? Something
> like 'Fix sgc->{min,max}_capacity calculation for SD_OVERLAP'
> 
> > commit bf475ce0a3dd ("sched/fair: Add per-CPU min capacity to
> > sched_group_capacity") introduced per-cpu min_capacity.
> > 
> > commit e3d6d0cb66f2 ("sched/fair: Add sched_group per-CPU max capacity")
> > introduced per-cpu max_capacity.
> > 
> 
> Could we improve the description of the issue and the change a little
> bit? Something like:
> 
> In the SD_OVERLAP case, the local variable 'capacity' represents the sum
> of CPU capacity of all CPUs in the first sched group (sg) of the sched
> domain (sd).
> 
> It is erroneously used to calculate sg's min and max CPU capacity.
> To fix this use capacity_of(cpu) instead of 'capacity'.
> 
> The code which achieves this via cpu_rq(cpu)->sd->groups->sgc->capacity
> (for rq->sd != NULL) can be removed since it delivers the same value as
> capacity_of(cpu) which is currently only used for the (!rq->sd) case
> (see update_cpu_capacity()).
> A sg of the lowest sd (rq->sd or sd->child == NULL) represents a single
> CPU (and hence sg->sgc->capacity == capacity_of(cpu)).

Dietmar, thanks for your time. Indeed, it's better with a detailed description.

> 
> 
> Nit: Why not
> 
> +                       capacity += cpu_cap;
> +                       min_capacity = min(cpu_cap, min_capacity);
> +                       max_capacity = max(cpu_cap, max_capacity);
> 
> like in the !SD_OVERLAP path?
> 
> >  		}
> >  	} else  {
> >  		/*
> > 
