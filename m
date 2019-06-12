Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3355EC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BE821743
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560355369;
	bh=dimwybp2MWtfWr4zH9aMyGxS7EXOgNSmoxRuLK+Ncqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZV/V25JxCql1dL0bKGKi6ysRgWzi+6jc08YdfM17ESDNkjcHobRB1l1bIGw8hb1Yl
	 ocu2fp0eapctgBo1V49OW/Cma4CF9ZqD6cMm8TR7i/ig5Uo2nDa2heGsXTqiEV5kCz
	 jis+Sc7DlNUmNEXNRdErLzzajFLDXGQXx6UJRH/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440205AbfFLQCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:02:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40860 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406604AbfFLQCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:02:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so6634906pfp.7;
        Wed, 12 Jun 2019 09:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q/SueBbtj7C5fFQ+1HnrwXXVgHlOaQMtNQZKJDih2vk=;
        b=O2IfSoEdPeOtqvYc61BZ6k3//eUBsMkInNpkQAdhysvx5DQ3SdYRIa4kcfKFNZZiUf
         gnZiXeSVkjhFpwuXlNh0ekQU9A13LIBL1boBvvOujQQdHY6GA0eSL5Gnqvg6nq8Nfeuc
         3fp+jTtqUacUT5N2RJ51BAY8KHD3RLw3T0WANZ7Fdcv8ap6gs4icNXGB8NJwKRnjHgbx
         5lD/T9jSf8m6NvX1y/agOfMFhQMjhe9A0JGL45PHag1/zVPKZOOpYu8c3TGhLn+7hxSO
         UoCiIyN+Kca/fLHpXlP7m4CqcwCd5anviByK0K7OR9KQ3wgNCj125XtlSdLups1CYqYK
         GJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q/SueBbtj7C5fFQ+1HnrwXXVgHlOaQMtNQZKJDih2vk=;
        b=QkZKCTJgO+CRCncQ+ZB0St41hMjdD9sz251zs0EQUzh5kXC8B/ntA3HOmjeNkoZACJ
         HnmiDHOUuA4VyMexl+O9vUkCUGJcS9hbzCuZMJN5+UmGkpjLgQXGGJeC5MVeY02VFFYe
         IcO1A1/QfT1zOD7zmcXGj1Ah5Qo74PyKYaEXmujEoF5rqrJ6XGwvTHqE0rwFHeRrd0SS
         XwFPpNejsvqM+CqcVYlFnaJzttvm2ZPnBNoQk35qqxCWlKghdAlwSGMQ5FBm6YkuFmLU
         U2Fyl4E9AJYn1wBWPcMuLQTfqOP0A37oaun5y2AXuXNgFueOPvvMio6qcHq7YTBTd7nw
         mjqQ==
X-Gm-Message-State: APjAAAWxjq5umXq+CbN6NO6YbCqSzin2dkEAKcC79EnPL+SJ9J5VxGbL
        OtvJZGAXYQ8g8oKrzo3xY7o=
X-Google-Smtp-Source: APXvYqxG8p2oJB3BYWG5XIejEtw3Ow6zJoP+BBfkx5+yZm7Z3tUHMhdrYVY2YkHPFCPijmjru4t8NA==
X-Received: by 2002:a65:484d:: with SMTP id i13mr25259329pgs.27.1560355366687;
        Wed, 12 Jun 2019 09:02:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::c431])
        by smtp.gmail.com with ESMTPSA id d187sm14370pfa.38.2019.06.12.09.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 09:02:45 -0700 (PDT)
Date:   Wed, 12 Jun 2019 09:02:44 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Phil Auld <pauld@redhat.com>, Waiman Long <longman@redhat.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org
Subject: Re: [RESEND PATCH v3] cpuset: restore sanity to
 cpuset_cpus_allowed_fallback()
Message-ID: <20190612160244.GP3341036@devbig004.ftw2.facebook.com>
References: <1560354648-23632-1-git-send-email-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560354648-23632-1-git-send-email-jsavitz@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 11:50:48AM -0400, Joel Savitz wrote:
> In the case that a process is constrained by taskset(1) (i.e.
> sched_setaffinity(2)) to a subset of available cpus, and all of those are
> subsequently offlined, the scheduler will set tsk->cpus_allowed to
> the current value of task_cs(tsk)->effective_cpus.
> 
> This is done via a call to do_set_cpus_allowed() in the context of 
> cpuset_cpus_allowed_fallback() made by the scheduler when this case is
> detected. This is the only call made to cpuset_cpus_allowed_fallback()
> in the latest mainline kernel.
> 
> However, this is not sane behavior.

While not perfect (we'll need to stop updating task's cpumask from
cpuset to make), this is still a signifcant improvement.

 Acked-by: Tejun Heo <tj@kernel.org>

If there's no objection, I'll route it through the cgroup tree.

Thanks.

-- 
tejun
