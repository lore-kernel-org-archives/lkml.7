Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1044AC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25C7208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfE1T3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 15:29:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbfE1T3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 15:29:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 310337FDFE;
        Tue, 28 May 2019 19:29:46 +0000 (UTC)
Received: from krava (ovpn-204-42.brq.redhat.com [10.40.204.42])
        by smtp.corp.redhat.com (Postfix) with SMTP id 521841F8;
        Tue, 28 May 2019 19:29:43 +0000 (UTC)
Date:   Tue, 28 May 2019 21:29:42 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        ak@linux.intel.com
Subject: Re: [PATCH 1/3] perf header: Add die information in CPU topology
Message-ID: <20190528192942.GJ10611@krava>
References: <1558644081-17738-1-git-send-email-kan.liang@linux.intel.com>
 <20190528090001.GD27906@krava>
 <03a95846-5ccd-bbfa-ec95-b2cb8a83607d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03a95846-5ccd-bbfa-ec95-b2cb8a83607d@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 28 May 2019 19:29:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 03:06:16PM -0400, Liang, Kan wrote:
> 
> 
> On 5/28/2019 5:00 AM, Jiri Olsa wrote:
> > On Thu, May 23, 2019 at 01:41:19PM -0700, kan.liang@linux.intel.com wrote:
> > 
> > SNIP
> > 
> > > diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
> > > index ece0710..f6e7db7 100644
> > > --- a/tools/perf/util/cputopo.c
> > > +++ b/tools/perf/util/cputopo.c
> > > @@ -1,5 +1,6 @@
> > >   // SPDX-License-Identifier: GPL-2.0
> > >   #include <sys/param.h>
> > > +#include <sys/utsname.h>
> > >   #include <inttypes.h>
> > >   #include <api/fs/fs.h>
> > > @@ -8,9 +9,10 @@
> > >   #include "util.h"
> > >   #include "env.h"
> > > -
> > >   #define CORE_SIB_FMT \
> > >   	"%s/devices/system/cpu/cpu%d/topology/core_siblings_list"
> > > +#define DIE_SIB_FMT \
> > > +	"%s/devices/system/cpu/cpu%d/topology/die_cpus_list"
> > >   #define THRD_SIB_FMT \
> > >   	"%s/devices/system/cpu/cpu%d/topology/thread_siblings_list"
> > >   #define NODE_ONLINE_FMT \
> > > @@ -20,7 +22,26 @@
> > >   #define NODE_CPULIST_FMT \
> > >   	"%s/devices/system/node/node%d/cpulist"
> > > -static int build_cpu_topology(struct cpu_topology *tp, int cpu)
> > > +bool check_x86_die_exists(void)
> > > +{
> > > +	char filename[MAXPATHLEN];
> > > +	struct utsname uts;
> > > +
> > > +	if (uname(&uts) < 0)
> > > +		return false;
> > > +
> > > +	if (strncmp(uts.machine, "x86_64", 6))
> > > +		return false;
> > > +
> > > +	scnprintf(filename, MAXPATHLEN, DIE_SIB_FMT,
> > > +		  sysfs__mountpoint(), 0);
> > > +	if (access(filename, F_OK) == -1)
> > > +		return false;
> > > +
> > > +	return true;
> > > +}
> > 
> > we could rename this to:
> > 
> > static bool has_die(void)
> > {
> > 	static bool has_die;
> > 
> > 	if (initialized)
> > 		return has_die;
> > 
> > 	has_die = ...
> > 	initialized = true;
> > }
> > 
> > and got rid of all those 'has_die' arguments below
> 
> Yes, we can rename the function to has_die(). It looks like all the
> 'has_die' arguments can be replaced either.
> 
> But why we want a "initialized" here? to cache the value? It looks like we
> only need to call has_die() once.

right, if it's called from one place then it's ok

thanks,
jirka
