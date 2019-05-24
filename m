Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D35DC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4752133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389617AbfEXPeN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:34:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33749 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389352AbfEXPeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:34:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id 66so9096850otq.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 08:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XmUFDj9D/eofBnJzPdCvp5T1ZMAct2TpjK59uIWjaGI=;
        b=HgzQliJr5FyK0loJ/uGKOgIQ9j12KWC3S3reEufRyjtqLFmRlrJMRrlBhJWS9xR6+p
         A7FgS8CqSz9iiPN7IR1z8thBZ5Xsa9soQ6wWINa9Zav3JXcsy2jw5eMRGTGlhuoKvjfZ
         fdgPS0zSSFdV4kyElBHr0HmH05ouwHK4AF1KDJtPgFA5/zF0lRAZLIVF+O736NHjPxZ5
         WQIbwDiX9M3fhTW1AM2C2L+q/QTUV31reh+eMSedPDWpG1PhoW1waX0HNGqTyRVR3P7N
         RMhTa24attaS7xemNAz4jx2/nACLd6LROshJtdlrEDbrt2dvyN3s9DCs/9W+T1qq9bz6
         EQUQ==
X-Gm-Message-State: APjAAAVDUL0QymuLJEbUMizydaY9DG4NO8eksldVC7jVQA1chhxn4ooC
        uG2sjUofMSCWQKRAMkX4Jplvb19TcjUGpUjLw6I/3g==
X-Google-Smtp-Source: APXvYqxsrFVzXtT9Acfrz6QjWXchCDlZpb53Ha0Iwr8PLUs05rv6qoQCFOXdqtNTzA0Ek/izdns14Zvmvnm+oyKNNNs=
X-Received: by 2002:a9d:30d6:: with SMTP id r22mr62722773otg.33.1558712052313;
 Fri, 24 May 2019 08:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190409204003.6428-1-jsavitz@redhat.com> <20190521143414.GJ5307@blackbody.suse.cz>
In-Reply-To: <20190521143414.GJ5307@blackbody.suse.cz>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Fri, 24 May 2019 11:33:55 -0400
Message-ID: <CAL1p7m6nfPkWoEEAjO+Gxq-ZiRY7+1jU_7dVcw2-hjC22xz-4A@mail.gmail.com>
Subject: Re: [PATCH v2] cpuset: restore sanity to cpuset_cpus_allowed_fallback()
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>,
        Phil Auld <pauld@redhat.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 10:35 AM Michal Koutný <mkoutny@suse.com> wrote:
> >       $ grep Cpus /proc/$$/status
> >       Cpus_allowed:   ff
> >       Cpus_allowed_list:      0-7
>
> (a)
>
> >       $ taskset -p 4 $$
> >       pid 19202's current affinity mask: f

> I'm confused where this value comes from, I must be missing something.
>
> Joel, is the task in question put into a cpuset with 0xf CPUs only (at
> point (a))? Or are the CPUs 4-7 offlined as well?

Good point.

It is a bit ambiguous, but I performed no action on the task's cpuset
nor did I offline any cpus at point (a).

After a bit of research, I am fairly certain that the observed
discrepancy is due to differing mechanisms used to acquire the cpuset
mask value.

The first mechanism, via `grep Cpus /proc/$$/status`, has it's value
populated by the expression (task->cpus_allowed) in
fs/proc/array.c:sched_getaffinity(), whereas the taskset utility
(https://github.com/karelzak/util-linux/blob/master/schedutils/taskset.c)
uses sched_getaffinity(2) to determine the "current affinity mask"
value from the expression (task->cpus_allowed & cpu_active_mask) in
kernel/sched/core.c:sched_getaffinty(),

I do not know if there is an explicit reason for this discrepancy or
whether the two mechanisms were simply built independently, perhaps
for different purposes.

I think the /proc/$$/status value is intended to simply reflect the
user-specified policy stating which cpus the task is allowed to run on
without consideration for hardware state, whereas the taskset value is
representative of the cpus that the task can actually be run on given
the restriction policy specified by the user via the cpuset mechanism.

By the way, I posted a v2 of this patch that correctly handles cgroup
v2 behavior.
