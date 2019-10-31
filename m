Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404EECA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104D620862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d413wvAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfJaJMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 05:12:16 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:41171 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfJaJMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 05:12:16 -0400
Received: by mail-il1-f193.google.com with SMTP id z10so4706995ilo.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 02:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Lv73JiCWLtWEy3FTQd5lrp9xehnWHWF4XPkKNuD8mk=;
        b=d413wvAa80v4t9WpIAhVU5WrSgcRhEoG1wqderlTcVxTEhPKdUhGRNSrdi0TNzc/CE
         qrkw169FM2yEwPxLe9F0W3u9H4U7huhPt75shmNH9GyTP62O/ueRAep0lDUfGw9bmvi8
         OOFppavA/c3e1s9m1TO1qk5v0NBBFl2vbwLnQMo54fvqU4vTLVzSN70X2fDVI+ZeptiR
         dF3bwq3rLcKfzvaBkE/D3Z1P5gS38yVPLt8MlqwOsAMha1Dw+AZfOjeqqCmp99yEe+Wk
         5Ms4uamyqLBYwELFj8wDnNwXdEW2WstZ+dVmYVA7YXr954pxXmWSk1XZgRSEmwKWTuZw
         uo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Lv73JiCWLtWEy3FTQd5lrp9xehnWHWF4XPkKNuD8mk=;
        b=iqWA7t3LvjTUhqOGo3OIuStI85vDAiOwN4XTS5B6qkZFpFla8xCJL9u+8rCvp3jWxq
         99DmhJShgbmLcY2lsuEWkJBWSQPC2lFX6d8xzFLp7JRWfF3rf5HWGNyxxw+96Flb3qPB
         QvBPeFNGU+XHBjgIVQ6AH3/cxd1fAjYhAsPgnji1in3NMQ+hhQd+x7kTJSjg13uvyOpj
         MeKGdBTglVNnrxRzcBRTrZmz7Stn5no/Ud9EpGYwQFyFkE2RW7EVNG9lbCLYXc6WiyH4
         hxLw1Ihywc6bx54+p98MCyOKV+RdcYhjFbEvoCoa+aonEhQGE7vJxR8gg3IQLcsXpuMf
         XNGQ==
X-Gm-Message-State: APjAAAUJ0NBFY7BO67AofV+MMebpWpJ3q3c1RJ+9H7L5bf3xA5OCSJIy
        Fo0PmiM5/c/uHu3tCOxMoWLoaf3fkZvpfMwc6pudvA==
X-Google-Smtp-Source: APXvYqwu/n0bt4kp50fbDqNEWwn/uTi7f06BsDkIGArLX1Abm1dnVf9tdBF6QkkY7iklEfJ3v8LSGjasEzjduBDX54U=
X-Received: by 2002:a92:af99:: with SMTP id v25mr5251483ill.167.1572513135396;
 Thu, 31 Oct 2019 02:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <5eba2fb4af9ebc7396101bb9bd6c8aa9c8af0710.1571899508.git.viresh.kumar@linaro.org>
 <20191030164714.GH28938@suse.de>
In-Reply-To: <20191030164714.GH28938@suse.de>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 31 Oct 2019 14:42:03 +0530
Message-ID: <CAKohpo=hssu_uvb1J=0Od=KziAQVSMmbBt9zxa4mYttKhFJwFw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Make sched-idle cpu selection consistent throughout
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2019 at 22:17, Mel Gorman <mgorman@suse.de> wrote:

> As the patch stands, I think a fork-intensive workload where each
> process is doing small amounts of work will suffer from overloading
> domains and have variable performance depending on how quickly the load
> balancer reacts.

Just wanted to clarify this slightly in case it is confusing. Once a
newly forked
(non SCHED_IDLE) task gets placed on a sched-idle CPU, it won't remain
sched-idle anymore and we will again start looking for a fully idle CPU. So,
we won't put everything on a small set of CPUs, but just one SCHED_NORMAL
task on a CPU unless we are out of idle CPUs.

Do you have some specific test in mind which I can run to test this ?

--
Viresh
