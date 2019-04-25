Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61558C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5A7206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfDYVNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:13:50 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58164 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfDYVNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:13:49 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x3PLCZWF022768;
        Fri, 26 Apr 2019 06:12:35 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Fri, 26 Apr 2019 06:12:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x3PLCTI4022751
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 26 Apr 2019 06:12:34 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC 1/2] mm: oom: expose expedite_reclaim to use oom_reaper
 outside of oom_kill.c
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, yuzhoujian@didichuxing.com,
        jrdr.linux@gmail.com, guro@fb.com, hannes@cmpxchg.org,
        ebiederm@xmission.com, shakeelb@google.com, christian@brauner.io,
        minchan@kernel.org, timmurray@google.com, dancol@google.com,
        joel@joelfernandes.org, jannh@google.com, linux-mm@kvack.org,
        lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <20190411014353.113252-1-surenb@google.com>
 <20190411014353.113252-2-surenb@google.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c745df86-b95c-e82b-42ba-519da4f448ab@i-love.sakura.ne.jp>
Date:   Fri, 26 Apr 2019 06:12:27 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411014353.113252-2-surenb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/04/11 10:43, Suren Baghdasaryan wrote:
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 3a2484884cfd..6449710c8a06 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1102,6 +1102,21 @@ bool out_of_memory(struct oom_control *oc)
>  	return !!oc->chosen;
>  }
>  
> +bool expedite_reclaim(struct task_struct *task)
> +{
> +	bool res = false;
> +
> +	task_lock(task);
> +	if (task_will_free_mem(task)) {

mark_oom_victim() needs to be called under oom_lock mutex after
checking that oom_killer_disabled == false. Since you are trying
to trigger this function from signal handler, you might want to
defer until e.g. WQ context.

> +		mark_oom_victim(task);
> +		wake_oom_reaper(task);
> +		res = true;
> +	}
> +	task_unlock(task);
> +
> +	return res;
> +}
> +
>  /*
>   * The pagefault handler calls here because it is out of memory, so kill a
>   * memory-hogging task. If oom_lock is held by somebody else, a parallel oom
> 
