Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD65BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 00:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A351F2173E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 00:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="hYL+u0eQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbfHWAwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 20:52:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40325 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730401AbfHWAwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 20:52:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so4697615pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 17:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hzy36hhVXFi6wqDa1Z1jG9B3/csgmeqFSkjTTR5TT8o=;
        b=hYL+u0eQoTbpWIVtYnginblV5imhgI8XxMCyi9l7/HBpQMrxDA/vdrxCnNultRSBkY
         P5JMBNUxfa2VHB72aDX+cgK5x5Pg+SVWjdRnWHlGNng1tFEMrua/lr9A/QngXcR9+PIr
         z8i7RNwUNfD9CTp7+geP9YlxQpiKIiEyRI9jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hzy36hhVXFi6wqDa1Z1jG9B3/csgmeqFSkjTTR5TT8o=;
        b=X5w9Uc+DZp09/NBqgzX9287NoqLKKyZ5klu1TAzznGXBMBYP+yGE32fILS7bc5bmkh
         uqctiKWKQf3y46N475ewptKxNjhmz8DHWROXAIhRD5/7FzipjQeEn37g/3Lndz2X6rgc
         bz6O0Rob6byHejVHRZOp/LjRifciRBXDgMmxGBBtXOOWN4APp+qAj8ZwqK7Tm76Ig8vv
         1/DV+wcDWKYnxYMk3AuLOiqQx0ZNlezYwCyHyDptEbqKiOfjMMTirnp+Ls/KTTE/3yKX
         Yqa7CwgcuJdF74x/4IncTH4/HS2Noi5uXSVYzTbWNetlcMcQyumrFH84zLec9xDY07nx
         Al9g==
X-Gm-Message-State: APjAAAX8xDt2UWS2Sokq76hv7Ke/UGhssByMmYv5BrVTw0Ng2dZsLOb5
        /sufZBrszdoAqmjLgVC0+6Lnsd7m8Ew=
X-Google-Smtp-Source: APXvYqyGds7sD98KClwP8vPM/hhwyoxGqLWwe/lQvhK2aDW5qJOTjJFAOfarEo2F9FxknbT8y5v6yg==
X-Received: by 2002:a63:7d49:: with SMTP id m9mr1704700pgn.161.1566521540968;
        Thu, 22 Aug 2019 17:52:20 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g1sm460656pgg.27.2019.08.22.17.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 17:52:20 -0700 (PDT)
Date:   Thu, 22 Aug 2019 20:52:18 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 3/3] rcu: Disable use_softirq on PREEMPT_RT
Message-ID: <20190823005218.GA36261@google.com>
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-4-swood@redhat.com>
 <20190822135953.GB29841@google.com>
 <c44d6ab34f2f4e4a5d36036cc8b356a3f4f3519b.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c44d6ab34f2f4e4a5d36036cc8b356a3f4f3519b.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 02:31:17PM -0500, Scott Wood wrote:
> On Thu, 2019-08-22 at 09:59 -0400, Joel Fernandes wrote:
> > On Wed, Aug 21, 2019 at 06:19:06PM -0500, Scott Wood wrote:
> > > I think the prohibition on use_softirq can be dropped once RT gets the
> > > latest RCU code, but the question of what use_softirq should default
> > > to on PREEMPT_RT remains.
> > 
> > Independent of the question of what use_softirq should default to, could
> > we
> > test RT with latest RCU code now to check if the deadlock goes away?  That
> > way, maybe we can find any issues in current RCU that cause scheduler
> > deadlocks in the situation you pointed. The reason I am asking is because
> > recently additional commits [1] try to prevent deadlock and it'd be nice
> > to
> > ensure that other conditions are not lingering (I don't think they are but
> > it'd be nice to be sure).
> > 
> > I am happy to do such testing myself if you want, however what does it
> > take
> > to apply the RT patchset to the latest mainline? Is it an achievable feat?
> 
> I did run such a test (cherry picking all RCU patches that aren't already in
> RT, plus your RFC patch to rcu_read_unlock_special, rather than applying RT
> to current mainline) with rcutorture plus a looping kernel build overnight,
> and didn't see any splats with or without use_softirq.

Cool, that's good to know you didn't see splats!

thanks,

 - Joel

