Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C835EC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5E320866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfFEOUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:20:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:37964 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727893AbfFEOUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:20:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18EDEAF03;
        Wed,  5 Jun 2019 14:20:05 +0000 (UTC)
Date:   Wed, 5 Jun 2019 16:20:03 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        lizefan@huawei.com, tj@kernel.org, bristot@redhat.com,
        luca.abeni@santannapisa.it, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Fix cpu controller for !RT_GROUP_SCHED
Message-ID: <20190605142003.GD4255@blackbody.suse.cz>
References: <20190605114935.7683-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605114935.7683-1-juri.lelli@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 01:49:35PM +0200, Juri Lelli <juri.lelli@redhat.com> wrote:
> Existing code comes with a comment saying the "we don't support RT-tasks
> being in separate groups".
I'm also inclined to this check not being completely correct.

This guard also prevents enabling cpu controller on unified hierarchy
with !CONFIG_RT_GROUP_SCHED. (If there are any kernel RT threads in root
cgroup, they can't be migrated to the newly create cpu controller's root
in cgroup_update_dfl_csses().)

I considered relaxing the check to non-root cgroups only, however, as
your example shows, it doesn't prevent reaching the avoided state by
other paths. I'm not that familiar with RT sched to tell whether
RT-priority tasks in different task_groups break any assumptions.

Michal
