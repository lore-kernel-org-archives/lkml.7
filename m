Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C653C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFB22190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553276621;
	bh=P04ycmRQabKa/iPZr0GWLzGOmbAlXTRlfFFLOj7omBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GGc9UQPJUGROLHIOeuWNi67lHA9xg1dNOPTmbB/9siV+zhBf2UjnM1+Wm58z8sz8+
	 DIkEXVHKWjaBwWedyCmUe+PzJezDvuo2MxlKXnHz38V8L9e9H27FwEwPpH4jbcSDmE
	 butXINVDGZiNYAFaVF43VUGta4fwlZUoXoCJFXvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfCVRnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:43:39 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:32908 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfCVRnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:43:39 -0400
Received: by mail-yw1-f66.google.com with SMTP id l5so2248715ywa.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 10:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PxGrj3YpzJKFMovhkJSQsQJvxgAYX8oxnUko0NLoCPs=;
        b=cd37aVQqUsw7LSQEVoWJemXqGaTVjozyQg0gr0yBmgwWBXN+ofpblQ9GvifVPHu9/n
         IiA8gVX+k/6pEXOK/gcbNzRc8tSI83Eh8UnJIjGDqEUByjYf1I3lfZgMD3EmrxVfO16h
         lf9v27qhfitXG8IQqd27v8V8dl/5erztpFnukO9/p3ZDMfqivxj3f1m0GwlKhgEeokCp
         C0o70v9nHtCtlBYXyb/+KsN69Q8WBe122nqUgXEUUcj4SKCeR+PL2T+vnetXYpejPgWE
         TvLlqu+xRFjSPB4CeaZGhOT+EG7GxIcvGe0t5CXNl7w0RXpfZWGaL+gfvLTWySOWjsnV
         1LqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PxGrj3YpzJKFMovhkJSQsQJvxgAYX8oxnUko0NLoCPs=;
        b=V5i5/cpfD/ALe1GTts34zkmpXpSSVjOm55AFRN+UTftLcmL8B9b5KTsV3XsajR3D/w
         eIw1Ap/0nOJdQpctG84WTWkKc2KL0uqIa/uY6vo/qFNOUvSR4HZaaUTxBnNJfGZaQqhe
         UV65a/joezyFH0asWhjB5FmoTCEHHrCV6DldRYiLcBD5UdDJaeCW0sYURCM02vh3i7L6
         F3SdOVemmHQ1HvyR2rWtXaRbkeVUTCs2uNBC2mcGHrs2dU7jIGrd6jT+ehtwBZTixfVW
         OCNvY5oSAvFmzBaZkS4JpIzaApWTrD6UMTYSwI5owZvJJYQdF6MCaT99U85JjqNOpIU0
         x9qg==
X-Gm-Message-State: APjAAAVjJo3FhVwqdSXTANIiV6UvVHPfxGBah8/fiJYGi07Ha4oAE9l4
        xgvrVUyY0+CWbaGn6siBuEg=
X-Google-Smtp-Source: APXvYqzD1z8khaelCCdFCHMyik+Z5Xn/bVFEVH2LYJSkA7D6GQyP17QP/CY3h/UFzufeg4p7B2o31g==
X-Received: by 2002:a25:5785:: with SMTP id l127mr9152244ybb.395.1553276618250;
        Fri, 22 Mar 2019 10:43:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::bab1])
        by smtp.gmail.com with ESMTPSA id t126sm4583929ywa.83.2019.03.22.10.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 10:43:37 -0700 (PDT)
Date:   Fri, 22 Mar 2019 10:43:34 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] workqueue: Use normal rcu
Message-ID: <20190322174334.GC69236@devbig004.ftw2.facebook.com>
References: <20190313165548.19713-1-bigeasy@linutronix.de>
 <20190313165548.19713-2-bigeasy@linutronix.de>
 <20190321205935.7ndo5k5zumc77h37@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321205935.7ndo5k5zumc77h37@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Mar 21, 2019 at 09:59:35PM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-03-13 17:55:47 [+0100], To linux-kernel@vger.kernel.org wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > There is no need for sched_rcu. The undocumented reason why sched_rcu
> > is used is to avoid a few explicit rcu_read_lock()/unlock() pairs by
> > the fact that sched_rcu reader side critical sections are also protected
> > by preempt or irq disabled regions.
> > 
> > Replace rcu_read_lock_sched with rcu_read_lock and acquire the RCU lock
> > where it is not yet explicit acquired. Replace local_irq_disable() with
> > rcu_read_lock(). Update asserts.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > [bigeasy: mangle changelog a little]
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> A gentle ping.

We can switch but it doesn't really say why we'd want to.  Can you
please explain why this is better?

Thanks.

-- 
tejun
