Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BB3C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B16206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfE1OJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 10:09:41 -0400
Received: from foss.arm.com ([217.140.101.70]:58202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfE1OJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 10:09:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0836D80D;
        Tue, 28 May 2019 07:09:40 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F8363F5AF;
        Tue, 28 May 2019 07:09:36 -0700 (PDT)
Date:   Tue, 28 May 2019 15:09:34 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mgorman@techsingularity.net,
        james.morse@arm.com, robin.murphy@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        ira.weiny@intel.com
Subject: Re: [PATCH V3 2/4] arm64/mm: Hold memory hotplug lock while walking
 for kernel page table dump
Message-ID: <20190528140934.GC26178@lakrids.cambridge.arm.com>
References: <1557824407-19092-1-git-send-email-anshuman.khandual@arm.com>
 <1557824407-19092-3-git-send-email-anshuman.khandual@arm.com>
 <20190515165847.GH16651@dhcp22.suse.cz>
 <20190516102354.GB40960@lakrids.cambridge.arm.com>
 <20190516110529.GQ16651@dhcp22.suse.cz>
 <20190522164212.GD23592@lakrids.cambridge.arm.com>
 <20190527072001.GB1658@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527072001.GB1658@dhcp22.suse.cz>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 09:20:01AM +0200, Michal Hocko wrote:
> On Wed 22-05-19 17:42:13, Mark Rutland wrote:
> > On Thu, May 16, 2019 at 01:05:29PM +0200, Michal Hocko wrote:
> > > On Thu 16-05-19 11:23:54, Mark Rutland wrote:
> > > > On Wed, May 15, 2019 at 06:58:47PM +0200, Michal Hocko wrote:
> > > > > On Tue 14-05-19 14:30:05, Anshuman Khandual wrote:

> > I don't think that it's reasonable for this code to bring down the
> > kernel unless the kernel page tables are already corrupt. I agree we
> > should minimize the impact on other code, and I'm happy to penalize
> > ptdump so long as it's functional and safe.
> > 
> > I would like it to be possible to use the ptdump code to debug
> > hot-remove, so I'd rather not make the two mutually exclusive. I'd also
> > like it to be possible to use this in-the-field, and for that asking an
> > admin to potentially crash their system isn't likely to fly.
> 
> OK, fair enough.
> 
> > > > > I am asking because I would really love to make mem hotplug locking less
> > > > > scattered outside of the core MM than more. Most users simply shouldn't
> > > > > care. Pfn walkers should rely on pfn_to_online_page.
> > 
> > Jut to check, is your plan to limit access to the hotplug lock, or to
> > redesign the locking scheme?
> 
> To change the locking to lock hotpluged ranges rather than having a
> global lock as the operation is inherently pfn range scoped.

Ok. That sounds like something we could adapt the ptdump code to handle
without too much pain (modulo how much of that you want to expose
outside of the core mm code).

> > > > I'm not sure if that would help us here; IIUC pfn_to_online_page() alone
> > > > doesn't ensure that the page remains online. Is there a way to achieve
> > > > that other than get_online_mems()?
> > > 
> > > You have to pin the page to make sure the hotplug is not going to
> > > offline it.
> > 
> > I'm not exactly sure how pinning works -- is there a particular set of
> > functions I should look at for that?
> 
> Pinning (get_page) on any page of the range will deffer the hotremove
> operation and therefore the page tables cannot go away as well.
> 
> That being said, I thought the API is mostly for debugging and "you
> should better know what you are doing" kinda thing (based on debugfs
> being used here). If this is really useful in its current form and
> should be used also while the hotremove is in progress then ok.
> Once we actually get to rework the locking then we will have another
> spot to handle but that's the life.

Great.

FWIW, I'm happy to rework the ptdump code to help with that.

Thanks,
Mark.
