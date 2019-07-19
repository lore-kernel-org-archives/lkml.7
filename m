Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF86C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5872184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfGSISe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 04:18:34 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44148 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfGSISe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 04:18:34 -0400
Received: by mail-qt1-f193.google.com with SMTP id 44so2499332qtg.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 01:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sTL+cs2lCU2NM5qKSibXk5W13Ib4qYAgGUjbL1vgnqk=;
        b=PVLTM3IIgNf4QOkDnjj9dygS4hpnr40ceknSnxGWE4ZHqogYdPd3vGNrc2WJZeZjpr
         WZF6CSHymbroIPeIzlLxMuveUPgtqEldv6bsA18PWLScgdbsd5Reqh4JnyeluvSBcqGM
         B6sPb+pcIylIKyKER0dC3TuD67wXqXKtHQdVsCKOJFAeZAvy4uCXUQrnkY1RKrifpdHr
         Nyp6rV83oZt4Vx22IzMpf1IZpYR6IuAecFaE3lWGv/wzWOYFOCMdE3MjzoaLrdZIqzXH
         Eq8MMJSV9xfDVrrqU8tn4/Sliv7TfAc9To6hV3vtAgREYQWoAXlZiHYytW39qGvyJxit
         VPVw==
X-Gm-Message-State: APjAAAW9sXvlTPtnsnt3A78A3hK+uNulrHwdvpXUhGuduj0XHj6uahTg
        qMamhAuTex6ZQl862+ZG7t2B1xELioY=
X-Google-Smtp-Source: APXvYqyOVP03NX9J+wWs9KFySkhmqrZ2DbvfcP3TV14OEgsQszifz1DBOqmtzYEIUWDpFuxkJs37EQ==
X-Received: by 2002:a0c:afd5:: with SMTP id t21mr36606870qvc.105.1563524313146;
        Fri, 19 Jul 2019 01:18:33 -0700 (PDT)
Received: from t460s.bristot.redhat.com (host53-206-dynamic.53-79-r.retail.telecomitalia.it. [79.53.206.53])
        by smtp.gmail.com with ESMTPSA id u16sm15479646qte.32.2019.07.19.01.18.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 01:18:32 -0700 (PDT)
Subject: Re: [PATCH v2] sched/core: Fix cpu controller for !RT_GROUP_SCHED
To:     Juri Lelli <juri.lelli@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, tj@kernel.org
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, lizefan@huawei.com, longman@redhat.com,
        cgroups@vger.kernel.org
References: <20190719063455.27328-1-juri.lelli@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <f9372197-0282-1ed8-fa0b-a2b4a723a439@redhat.com>
Date:   Fri, 19 Jul 2019 10:18:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719063455.27328-1-juri.lelli@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2019 08:34, Juri Lelli wrote:
> On !CONFIG_RT_GROUP_SCHED configurations it is currently not possible to
> move RT tasks between cgroups to which cpu controller has been attached;
> but it is oddly possible to first move tasks around and then make them
> RT (setschedule to FIFO/RR).
> 
> E.g.:
> 
>   # mkdir /sys/fs/cgroup/cpu,cpuacct/group1
>   # chrt -fp 10 $$
>   # echo $$ > /sys/fs/cgroup/cpu,cpuacct/group1/tasks
>   bash: echo: write error: Invalid argument
>   # chrt -op 0 $$
>   # echo $$ > /sys/fs/cgroup/cpu,cpuacct/group1/tasks
>   # chrt -fp 10 $$
>   # cat /sys/fs/cgroup/cpu,cpuacct/group1/tasks
>   2345
>   2598
>   # chrt -p 2345
>   pid 2345's current scheduling policy: SCHED_FIFO
>   pid 2345's current scheduling priority: 10
> 
> Also, as Michal noted, it is currently not possible to enable cpu
> controller on unified hierarchy with !CONFIG_RT_GROUP_SCHED (if there
> are any kernel RT threads in root cgroup, they can't be migrated to the
> newly created cpu controller's root in cgroup_update_dfl_csses()).
> 
> Existing code comes with a comment saying the "we don't support RT-tasks
> being in separate groups". Such comment is however stale and belongs to
> pre-RT_GROUP_SCHED times. Also, it doesn't make much sense for
> !RT_GROUP_ SCHED configurations, since checks related to RT bandwidth
> are not performed at all in these cases.
> 
> Make moving RT tasks between cpu controller groups viable by removing
> special case check for RT (and DEADLINE) tasks.
> 
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> Reviewed-by: Michal Koutný <mkoutny@suse.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel
