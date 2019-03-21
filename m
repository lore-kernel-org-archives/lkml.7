Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF411C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92484218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9OV233m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfCUUMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:12:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36382 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbfCUUML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:12:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id e4so6120980edi.3;
        Thu, 21 Mar 2019 13:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3osBUvcyhyrWzc6SUUjiq7cH/vWck2Ywbs/D0tNqTdo=;
        b=W9OV233m/vjv38scInHNQBo82T9XOZd9oGX5rm7qqjAkWl+spjQ7PnRojJxebtA+u4
         b5TiI+HcPdHR2UmgeRo1zd8vxbHHhO91LW8KyjvQ6DxGCrLsvW1grs8E/2Vn/n2n5iHi
         NevpdeoPRY4K+z0tsK77qtGtCext2SGaoad5XGEreFLmt1d6J3z4OuAvIglVDwJ4R0XK
         3FVYXRkb1K3TDSLbr1ZyX6/Gf/jALP04tf3PW4C7WuUEvl0MlmxUpPR3MSHT/jGV6nYb
         UVdNxovGZWzBJFkogoR4rNIa3l6g/ULq6SzveNjeM2lINdyemY4bcT6eTm0Z/H4VUVqE
         FKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3osBUvcyhyrWzc6SUUjiq7cH/vWck2Ywbs/D0tNqTdo=;
        b=TTigqiI9a0pDkHoz12IGK7m4T2SMZ0eO32UlO6yl/IaZ/Rpg5UDrnWvuN/WVr62BOn
         8TEB6qvKcO6JsYLnndtFcmjIlJyGoI3JTnUgwtJKKO7Am9/NdBt8yUi9yxlO/Nd1SB3p
         KbshP3bDm5UjbJsaZ7rNdB8Eoy8vigXViQsQVkXse6KpcWaSqnFUI4cmDc+hhad60Czx
         Fj+cauADDZx/CUOylCkqBSyDny+VjD7GpJjbLKMJd9c5UDaUpycIQTQz/RRdbp8dUmFw
         EG563/8pTxX/KyRGzNu+O10MA6+Fh5392MFXU++hRXGPOmkMeXHKoY9xwr1e4gtwxjzb
         P7XA==
X-Gm-Message-State: APjAAAU46nUhNZxVwCBJorb66GuUHZjliK2JEXEWoUkC6b0zg3O4Mbqm
        WS4uQMIGaHJKxlIq7XgQ9+g=
X-Google-Smtp-Source: APXvYqwoYUrUsIN89koLb5FaX/LrIErDl0HtFWxUeBxeF91rrCwxzKie9OgJeOypQ+s/5xtdSK7pLA==
X-Received: by 2002:a50:90ee:: with SMTP id d43mr3806494eda.220.1553199129766;
        Thu, 21 Mar 2019 13:12:09 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4049:a600:5f8:c09d:c726:a758])
        by smtp.gmail.com with ESMTPSA id i1sm1922461edi.15.2019.03.21.13.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 13:12:08 -0700 (PDT)
Date:   Thu, 21 Mar 2019 21:12:07 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 0/4] RCU fixes for rcu_assign_pointer() usage
Message-ID: <20190321201205.pmz2bmq56uqbcvyy@ltop.local>
References: <20190321003426.160260-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321003426.160260-1-joel@joelfernandes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 08:34:22PM -0400, Joel Fernandes (Google) wrote:
> This is just a resend with scheduler patches split from the driver fixes and
> Paul's Reviewed-by(s) added.
> 
> These patches fix various sparse errors ccaused as a result of the recent check
> to add rcu_check_sparse() to rcu_assign_pointer().  The errors are due to
> missing annotations. The annotations added in the series can also help avoid
> future incorrect usages and bugs so it is a good idea to do in any case.
> 
> RFC v1 -> Patch v2:
> Made changes based on Peter Zijlstra review.
> 
> Joel Fernandes (Google) (4):
> sched/cpufreq: Annotate cpufreq_update_util_data pointer with __rcu
> sched_domain: Annotate RCU pointers properly
> rcuwait: Annotate task_struct with __rcu
> sched: Annotate perf_domain pointer with __rcu
> 
> include/linux/rcuwait.h        |  2 +-
> include/linux/sched/topology.h |  4 ++--
> kernel/sched/cpufreq.c         |  2 +-
> kernel/sched/sched.h           | 18 +++++++++---------
> kernel/sched/topology.c        | 10 +++++-----
> 5 files changed, 18 insertions(+), 18 deletions(-)

Looks good to me.

-- Luc
