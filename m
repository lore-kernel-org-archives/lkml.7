Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA878C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFB12075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAIVwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:52:45 -0500
Received: from shells.gnugeneration.com ([66.240.222.126]:60058 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgAIVwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:52:45 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jan 2020 16:52:45 EST
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 09BEB1A40239; Thu,  9 Jan 2020 13:46:04 -0800 (PST)
Date:   Thu, 9 Jan 2020 13:46:04 -0800
From:   Vito Caputo <vcaputo@pengaru.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Michal Hocko <mhocko@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: OOM killer not nearly agressive enough?
Message-ID: <20200109214604.nfzsksyv3okj3ec2@shells.gnugeneration.com>
References: <20200107204412.GA29562@amd>
 <20200109115633.GR4951@dhcp22.suse.cz>
 <20200109210307.GA1553@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109210307.GA1553@duo.ucw.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 10:03:07PM +0100, Pavel Machek wrote:
> On Thu 2020-01-09 12:56:33, Michal Hocko wrote:
> > On Tue 07-01-20 21:44:12, Pavel Machek wrote:
> > > Hi!
> > > 
> > > I updated my userspace to x86-64, and now chromium likes to eat all
> > > the memory and bring the system to standstill.
> > > 
> > > Unfortunately, OOM killer does not react:
> > > 
> > > I'm now running "ps aux", and it prints one line every 20 seconds or
> > > more. Do we agree that is "unusable" system? I attempted to do kill
> > > from other session.
> > 
> > Does sysrq+f help?
> 
> May try that next time.
> 
> > > Do we agree that OOM killer should have reacted way sooner?
> > 
> > This is impossible to answer without knowing what was going on at the
> > time. Was the system threshing over page cache/swap? In other words, is
> > the system completely out of memory or refaulting the working set all
> > the time because it doesn't fit into memory?
> 
> Swap was full, so "completely out of memory", I guess. Chromium does
> that fairly often :-(.
> 

Have you considered restricting its memory limits a la `ulimit -m`?

I've taken to running browsers in nspawn containers for general
isolation improvements, but this also makes it easy to set cgroup
resource limits like memcg.  i.e. --property MemoryMax=2G

This prevents the browser from bogging down the entire system, but it
doesn't prevent thrashing before FF OOMs within its control group.

I do feel there's a problem with the kernel's reclaim algorithm, it
seems far too willing to evict file-backed pages that are recently in
use.  But at least with memcg this behavior is isolated to the cgroup,
though it still generates a crapload of disk reads from all the
thrashing.

Regards,
Vito Caputo
