Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C45CC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC281206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfDZOPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:15:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfDZOPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:15:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 41F0E30842A0;
        Fri, 26 Apr 2019 14:15:08 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-116-103.phx2.redhat.com [10.3.116.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F08C4277D6;
        Fri, 26 Apr 2019 14:15:05 +0000 (UTC)
Date:   Fri, 26 Apr 2019 10:15:04 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Fr?d?ric Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
Message-ID: <20190426141503.GB16477@lorien.usersys.redhat.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
 <20190424140013.GA14594@sinkpad>
 <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
 <20190425095508.GA8387@gmail.com>
 <20190425144619.GX18914@techsingularity.net>
 <20190425185343.GA122353@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425185343.GA122353@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 26 Apr 2019 14:15:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 08:53:43PM +0200 Ingo Molnar wrote:
> Interesting. This strongly suggests sub-optimal SMT-scheduling in the 
> non-saturated HT case, i.e. a scheduler balancing bug.
> 
> As long as loads are clearly below the physical cores count (which they 
> are in the early phases of your table) the scheduler should spread tasks 
> without overlapping two tasks on the same core.
> 
> Clearly it doesn't.
> 

That's especially true if there are cgroups with different numbers of
tasks in them involved. 

Here's an example showing the average number of tasks on each of the 4 numa
nodes during a test run. 20 cpus per node. There are 78 threads total, 76
for lu and 2 stress cpu hogs. So fewer than the 80 CPUs on the box. The GROUP
test has the two stresses and lu in distinct cgroups. The NORMAL test has them
all in one. This is from 5.0-rc3+, but the version doesn't matter. It's
reproducible on any kernel. SMT is on, but that also doesn't matter here.

The first two lines show where the stress jobs ran and the second show where
the 76 threads of lu ran.

GROUP_1.stress.ps.numa.hist      Average    1.00   1.00
NORMAL_1.stress.ps.numa.hist     Average    0.00   1.10   0.90

lu.C.x_76_GROUP_1.ps.numa.hist   Average    10.97  11.78  26.28  26.97
lu.C.x_76_NORMAL_1.ps.numa.hist  Average    19.70  18.70  17.80  19.80

The NORMAL test is evenly balanced across the 20 cpus per numa node.  There
is between a 4x and 10x performance hit to the lu benchmark between group
and normal in any of these test runs. In this particular case it was 10x:

============76_GROUP========Mop/s===================================
min     q1      median  q3      max
3776.51 3776.51 3776.51 3776.51 3776.51
============76_GROUP========time====================================
min     q1      median  q3      max
539.92  539.92  539.92  539.92  539.92
============76_NORMAL========Mop/s===================================
min     q1      median  q3      max
39386   39386   39386   39386   39386
============76_NORMAL========time====================================
min     q1      median  q3      max
51.77   51.77   51.77   51.77   51.77


This a bit off topic, but since balancing bugs was mentioned and I've been
trying to track this down for a while (and learning the scheduler code in
the process) I figured I'd just throw it out there :)


Cheers,
Phil

-- 
