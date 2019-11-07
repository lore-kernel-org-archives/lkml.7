Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62CFC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABBA2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKGHZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 02:25:30 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36675 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfKGHZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 02:25:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id c22so1192665wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 23:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sr15vGZZX2ej4ww+noyT+e+hFOhTxt/7+3VG1604M8Q=;
        b=kzTe/sHgTiZkKhMsvPzizMSVo4EKq5w/lvi8m5wyTbQ0SkuCE2yLThADS4JG5LV1PJ
         aafGjd55ze1KpF75vgwhGys8mOgofBXkuDTgv+oL8RNiooBRJDfLxoSjCyAm3YVOPdU/
         752Yc/zKmbJDaFyDdegxZlqyvqS8h1gk5qC6oFl2RchluSy5IRI8wEPeBoELmoXEvnqt
         NZOf+oFAvenpA+c/BV4DXYR7zSoSTd5S0HBD6hzT4J4Abx6ihCoEMSktm6Hlev/956fr
         /9tXoHUDGvmTkUhR6drg8qwUiDHXt+0KnhRepP81cS7LYoBSce7W9qfnd81zF2Q3pmIy
         ensQ==
X-Gm-Message-State: APjAAAWyNGU3FYDZPYvN2Wv1XtU8Ga5BYPgOybqM2oujOZBUWP0DCjoc
        a9iyyvkHqeO/xDCawXd/7RE=
X-Google-Smtp-Source: APXvYqxZG71wG02513xnV4cEsXC/w4JvAfrwYrjkjG0dOhTsLJxkk8gq+Ke4U85wNBnoXeLq7IZJPQ==
X-Received: by 2002:a1c:7708:: with SMTP id t8mr1416461wmi.29.1573111527953;
        Wed, 06 Nov 2019 23:25:27 -0800 (PST)
Received: from darkstar ([109.70.119.5])
        by smtp.gmail.com with ESMTPSA id 36sm1841166wrj.42.2019.11.06.23.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 23:25:27 -0800 (PST)
Date:   Thu, 7 Nov 2019 07:25:25 +0000
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: core: fix compilation error when cgroup not
 selected
Message-ID: <20191107072525.GA19642@darkstar>
References: <20191105112212.596-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191105112212.596-1-qais.yousef@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ +Randy ]

Hi Qais,

On 05-Nov 11:22, Qais Yousef wrote:
> When cgroup is disabled the following compilation error was hit
> 
> 	kernel/sched/core.c: In function ‘uclamp_update_active_tasks’:
> 	kernel/sched/core.c:1081:23: error: storage size of ‘it’ isn’t known
> 	  struct css_task_iter it;
> 			       ^~
> 	kernel/sched/core.c:1084:2: error: implicit declaration of function ‘css_task_iter_start’; did you mean ‘__sg_page_iter_start’? [-Werror=implicit-function-declaration]
> 	  css_task_iter_start(css, 0, &it);
> 	  ^~~~~~~~~~~~~~~~~~~
> 	  __sg_page_iter_start
> 	kernel/sched/core.c:1085:14: error: implicit declaration of function ‘css_task_iter_next’; did you mean ‘__sg_page_iter_next’? [-Werror=implicit-function-declaration]
> 	  while ((p = css_task_iter_next(&it))) {
> 		      ^~~~~~~~~~~~~~~~~~
> 		      __sg_page_iter_next
> 	kernel/sched/core.c:1091:2: error: implicit declaration of function ‘css_task_iter_end’; did you mean ‘get_task_cred’? [-Werror=implicit-function-declaration]
> 	  css_task_iter_end(&it);
> 	  ^~~~~~~~~~~~~~~~~
> 	  get_task_cred
> 	kernel/sched/core.c:1081:23: warning: unused variable ‘it’ [-Wunused-variable]
> 	  struct css_task_iter it;
> 			       ^~
> 	cc1: some warnings being treated as errors
> 	make[2]: *** [kernel/sched/core.o] Error 1
> 
> Fix by protetion uclamp_update_active_tasks() with
> CONFIG_UCLAMP_TASK_GROUP
> 
> Fixes: babbe170e053 ("sched/uclamp: Update CPU's refcount on TG's clamp changes")
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>

Thanks for posting this again.

We now have three "versions" of this same fix, including:
 - the original bug report by Randy and a fix from me here:
   Message-ID: <8736gv2gbv.fsf@arm.com>
   https://lore.kernel.org/linux-next/8736gv2gbv.fsf@arm.com/
 - and a follow up patch from Arnd:
   Message-ID: <20190918195957.2220297-1-arnd@arndb.de>
   https://lore.kernel.org/lkml/20190918195957.2220297-1-arnd@arndb.de/

So, I guess now we just have to pick the one with the changelog we
prefer. :)

In all cases we should probably add:

  Reported-by: Randy Dunlap <rdunlap@infradead.org>
  Tested-by: Randy Dunlap <rdunlap@infradead.org>

Best,
Patrick

> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index dd05a378631a..afd4d8028771 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1073,6 +1073,7 @@ uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
>  	task_rq_unlock(rq, p, &rf);
>  }
>  
> +#ifdef CONFIG_UCLAMP_TASK_GROUP
>  static inline void
>  uclamp_update_active_tasks(struct cgroup_subsys_state *css,
>  			   unsigned int clamps)
> @@ -1091,7 +1092,6 @@ uclamp_update_active_tasks(struct cgroup_subsys_state *css,
>  	css_task_iter_end(&it);
>  }
>  
> -#ifdef CONFIG_UCLAMP_TASK_GROUP
>  static void cpu_util_update_eff(struct cgroup_subsys_state *css);
>  static void uclamp_update_root_tg(void)
>  {
> -- 
> 2.17.1
> 

-- 
#include <best/regards.h>

Patrick Bellasi
