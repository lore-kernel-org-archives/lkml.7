Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81709CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B10020873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2zjqng+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfJaSmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 14:42:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28817 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729266AbfJaSmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572547367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZSsdqJhl6ZW/kSO6yi2GIKnYCjUBLbvAa6wqGbCDtAs=;
        b=a2zjqng+6GCW6F7YjeYehH+7qZ2gciB00qLyi1cKx5sgvxD9vwkjVxLs63A+dTfDPuU7nu
        1hoKO8azzMo/sfq86WOntvMJ5W3oq/Svlevos2EeuCmR8snz+5qvt8bayjFxnwupG6+Ly+
        XoRiejsh0QDadZHcCT8IBB8sjUQogEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-ouUEUTrANWCtVkqw569iAQ-1; Thu, 31 Oct 2019 14:42:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 384F585B6EE;
        Thu, 31 Oct 2019 18:42:41 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 035775D6D8;
        Thu, 31 Oct 2019 18:42:38 +0000 (UTC)
Date:   Thu, 31 Oct 2019 14:42:37 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, Dario Faggioli <dfaggioli@suse.com>,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
Message-ID: <20191031184236.GE5738@pauld.bos.csb>
References: <cover.1572437285.git.vpillai@digitalocean.com>
MIME-Version: 1.0
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ouUEUTrANWCtVkqw569iAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineeth,

On Wed, Oct 30, 2019 at 06:33:13PM +0000 Vineeth Remanan Pillai wrote:
> Fourth iteration of the Core-Scheduling feature.
>=20
> This version was aiming mostly at addressing the vruntime comparison
> issues with v3. The main issue seen in v3 was the starvation of
> interactive tasks when competing with cpu intensive tasks. This issue
> is mitigated to a large extent.
>=20
> We have tested and verified that incompatible processes are not
> selected during schedule. In terms of performance, the impact
> depends on the workload:
> - on CPU intensive applications that use all the logical CPUs with
>   SMT enabled, enabling core scheduling performs better than nosmt.
> - on mixed workloads with considerable io compared to cpu usage,
>   nosmt seems to perform better than core scheduling.
>=20
> v4 is rebased on top of 5.3.5(dc073f193b70):
> https://github.com/digitalocean/linux-coresched/tree/coresched/v4-v5.3.5
>=20
> Changes in v4
> -------------
> - Implement a core wide min_vruntime for vruntime comparison of tasks
>   across cpus in a core.
> - Fixes a typo bug in setting the forced_idle cpu.
>=20
> Changes in v3
> -------------
> - Fixes the issue of sibling picking up an incompatible task
>   - Aaron Lu
>   - Vineeth Pillai
>   - Julien Desfossez
> - Fixes the issue of starving threads due to forced idle
>   - Peter Zijlstra
> - Fixes the refcounting issue when deleting a cgroup with tag
>   - Julien Desfossez
> - Fixes a crash during cpu offline/online with coresched enabled
>   - Vineeth Pillai
> - Fixes a comparison logic issue in sched_core_find
>   - Aaron Lu
>=20
> Changes in v2
> -------------
> - Fixes for couple of NULL pointer dereference crashes
>   - Subhra Mazumdar
>   - Tim Chen
> - Improves priority comparison logic for process in different cpus
>   - Peter Zijlstra
>   - Aaron Lu
> - Fixes a hard lockup in rq locking
>   - Vineeth Pillai
>   - Julien Desfossez
> - Fixes a performance issue seen on IO heavy workloads
>   - Vineeth Pillai
>   - Julien Desfossez
> - Fix for 32bit build
>   - Aubrey Li
>=20
> TODO
> ----
> - Decide on the API for exposing the feature to userland
> - Investigate the source of the overhead even when no tasks are tagged:
>   https://lkml.org/lkml/2019/10/29/242
> - Investigate the performance scaling issue when we have a high number of
>   tagged threads: https://lkml.org/lkml/2019/10/29/248
> - Try to optimize the performance for IO-demanding applications:
>   https://lkml.org/lkml/2019/10/29/261
>=20
> ---
>=20
> Aaron Lu (3):
>   sched/fair: wrapper for cfs_rq->min_vruntime
>   sched/fair: core wide vruntime comparison
>   sched/fair : Wake up forced idle siblings if needed
>=20
> Peter Zijlstra (16):
>   stop_machine: Fix stop_cpus_in_progress ordering
>   sched: Fix kerneldoc comment for ia64_set_curr_task
>   sched: Wrap rq::lock access
>   sched/{rt,deadline}: Fix set_next_task vs pick_next_task
>   sched: Add task_struct pointer to sched_class::set_curr_task
>   sched/fair: Export newidle_balance()
>   sched: Allow put_prev_task() to drop rq->lock
>   sched: Rework pick_next_task() slow-path
>   sched: Introduce sched_class::pick_task()
>   sched: Core-wide rq->lock
>   sched: Basic tracking of matching tasks
>   sched: A quick and dirty cgroup tagging interface
>   sched: Add core wide task selection and scheduling.
>   sched/fair: Add a few assertions
>   sched: Trivial forced-newidle balancer
>   sched: Debug bits...
>=20
>  include/linux/sched.h    |   9 +-
>  kernel/Kconfig.preempt   |   6 +
>  kernel/sched/core.c      | 847 +++++++++++++++++++++++++++++++++++++--
>  kernel/sched/cpuacct.c   |  12 +-
>  kernel/sched/deadline.c  |  99 +++--
>  kernel/sched/debug.c     |   4 +-
>  kernel/sched/fair.c      | 346 +++++++++++-----
>  kernel/sched/idle.c      |  42 +-
>  kernel/sched/pelt.h      |   2 +-
>  kernel/sched/rt.c        |  96 ++---
>  kernel/sched/sched.h     | 246 +++++++++---
>  kernel/sched/stop_task.c |  35 +-
>  kernel/sched/topology.c  |   4 +-
>  kernel/stop_machine.c    |   2 +
>  14 files changed, 1399 insertions(+), 351 deletions(-)
>=20
> --=20
> 2.17.1
>=20

Unless I'm mistaken 7 of the first 8 of these went into sched/core
and are now in linux (from v5.4-rc1). It may make sense to rebase on=20
that and simplify the series.


Cheers,
Phil
--=20

