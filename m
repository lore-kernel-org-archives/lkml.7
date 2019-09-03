Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC88C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC25222D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Y0dYwB/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfICPCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:02:49 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33564 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfICPCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:02:49 -0400
Received: by mail-qt1-f193.google.com with SMTP id r5so15047818qtd.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=98UJ89ZiZ75QQYhHn10zS32n71fYy3DwoNcRQRVS5xk=;
        b=Y0dYwB/xEIg2VC6kphV8moKQMLXSqjyrxIDvPmAgzYa7jRAFu+rhArsFpgpxNorwxF
         gHTeIuv/iD4Osf2V9qXXedGunN+ouk+dYxB/wokeKoDvPfNrjfb1JlTrJ2lG+Iu2xoe8
         JAbKHDYsO+QD2AGmQ2Q0w+50if55VPTX6DUbkWsl7ddh3kYlzHhS70XKbYo+sutA8I3H
         LEJJiwbr0XaAYu5yLRW4Jtm0uQBwIfiDkSBfI4x0S/BRs0uUDHQ0ARjWz59xZLqbkBPf
         J+hyZOZ41bFrhG7YcJvCAOxiTz+SvDl87P2/LOc+17Xg84onz/vXt6zb68kOdAIN4K0V
         LRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=98UJ89ZiZ75QQYhHn10zS32n71fYy3DwoNcRQRVS5xk=;
        b=Qa2Y5fYb3i/dm18M0I1S5NeAxmiEeseTCO8eRIdKDBfPi58tu4YuhONqeR4jZKB1Ad
         U5zzAukW6Q+9U0DG293aGZkNpSJjzPc274JkW8mg6jfunZ8ZNljn7IaS5EMtJ0XVht9i
         qpQGxgyxbcDGEHJHQupn5hk0jx9l0YIZAy5Tj3v3f1Fy8Qeb6J2+g9abQBF6/uH9oQ44
         m2WBgZrQ5+HPU6xELD5NTgX0PwcVC3Vre8hFikFA9vpc3hLqjDA5TrgpZEgsPXdEtncr
         IJVT8cVEf0C/WthlwZTzAI59vOdDYg0K7PqUE5IDC77DVF6iSl0CEZRHON6eK8FG3J3K
         tN5g==
X-Gm-Message-State: APjAAAWYCZ9gQ4h1FYXCdoG2uPaQepTpTRdyJn4ZFFXQgf7hF8xGjaKK
        5JScZNlAQvkCdsEXTVwpzBiNcA==
X-Google-Smtp-Source: APXvYqzTAE6mfgfo1ByrawGaOyifrsk7CtcAySIiPJNBqNzUp8BpFsqQkls2qLZH4XeyuvxZZpIQaw==
X-Received: by 2002:ac8:6a0a:: with SMTP id t10mr19414483qtr.0.1567522968447;
        Tue, 03 Sep 2019 08:02:48 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z5sm98214qki.55.2019.09.03.08.02.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 08:02:47 -0700 (PDT)
Message-ID: <1567522966.5576.51.camel@lca.pw>
Subject: Re: [RFC PATCH] mm, oom: disable dump_tasks by default
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Date:   Tue, 03 Sep 2019 11:02:46 -0400
In-Reply-To: <20190903144512.9374-1-mhocko@kernel.org>
References: <20190903144512.9374-1-mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-03 at 16:45 +0200, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> dump_tasks has been introduced by quite some time ago fef1bdd68c81
> ("oom: add sysctl to enable task memory dump"). It's primary purpose is
> to help analyse oom victim selection decision. This has been certainly
> useful at times when the heuristic to chose a victim was much more
> volatile. Since a63d83f427fb ("oom: badness heuristic rewrite")
> situation became much more stable (mostly because the only selection
> criterion is the memory usage) and reports about a wrong process to
> be shot down have become effectively non-existent.

Well, I still see OOM sometimes kills wrong processes like ssh, systemd
processes while LTP OOM tests with staight-forward allocation patterns. I just
have not had a chance to debug them fully. The situation could be worse with
more complex allocations like random stress or fuzzy testing.

> 
> dump_tasks can generate a lot of output to the kernel log. It is not
> uncommon that even relative small system has hundreds of tasks running.
> Generating a lot of output to the kernel log both makes the oom report
> less convenient to process and also induces a higher load on the printk
> subsystem which can lead to other problems (e.g. longer stalls to flush
> all the data to consoles).

It is only generate output for the victim process where I tested on those large
NUMA machines and the output is fairly manageable.

> 
> Therefore change the default of oom_dump_tasks to not print the task
> list by default. The sysctl remains in place for anybody who might need
> to get this additional information. The oom report still provides an
> information about the allocation context and the state of the MM
> subsystem which should be sufficient to analyse most of the oom
> situations.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/oom_kill.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index eda2e2a0bdc6..d0353705c6e6 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -52,7 +52,7 @@
>  
>  int sysctl_panic_on_oom;
>  int sysctl_oom_kill_allocating_task;
> -int sysctl_oom_dump_tasks = 1;
> +int sysctl_oom_dump_tasks;
>  
>  /*
>   * Serializes oom killer invocations (out_of_memory()) from all contexts to
