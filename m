Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6C1C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1E12175B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfCUTYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 15:24:07 -0400
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:48447 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbfCUTYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 15:24:06 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id B431DB8852
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 19:24:04 +0000 (GMT)
Received: (qmail 27968 invoked from network); 21 Mar 2019 19:24:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Mar 2019 19:24:04 -0000
Date:   Thu, 21 Mar 2019 19:24:03 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@kernel.org>, vbabka@suse.cz,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: mempolicy: remove MPOL_MF_LAZY
Message-ID: <20190321192403.GF3189@techsingularity.net>
References: <1553041659-46787-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190321145745.GS8696@dhcp22.suse.cz>
 <75059b39-dbc4-3649-3e6b-7bdf282e3f53@linux.alibaba.com>
 <20190321165112.GU8696@dhcp22.suse.cz>
 <60ef6b4a-4f24-567f-af2f-50d97a2672d6@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <60ef6b4a-4f24-567f-af2f-50d97a2672d6@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 10:25:08AM -0700, Yang Shi wrote:
> 
> 
> On 3/21/19 9:51 AM, Michal Hocko wrote:
> > On Thu 21-03-19 09:21:39, Yang Shi wrote:
> > > 
> > > On 3/21/19 7:57 AM, Michal Hocko wrote:
> > > > On Wed 20-03-19 08:27:39, Yang Shi wrote:
> > > > > MPOL_MF_LAZY was added by commit b24f53a0bea3 ("mm: mempolicy: Add
> > > > > MPOL_MF_LAZY"), then it was disabled by commit a720094ded8c ("mm:
> > > > > mempolicy: Hide MPOL_NOOP and MPOL_MF_LAZY from userspace for now")
> > > > > right away in 2012.  So, it is never ever exported to userspace.
> > > > > 
> > > > > And, it looks nobody is interested in revisiting it since it was
> > > > > disabled 7 years ago.  So, it sounds pointless to still keep it around.
> > > > The above changelog owes us a lot of explanation about why this is
> > > > safe and backward compatible. I am also not sure you can change
> > > > MPOL_MF_INTERNAL because somebody still might use the flag from
> > > > userspace and we want to guarantee it will have the exact same semantic.
> > > Since MPOL_MF_LAZY is never exported to userspace (Mel helped to confirm
> > > this in the other thread), so I'm supposed it should be safe and backward
> > > compatible to userspace.
> > You didn't get my point. The flag is exported to the userspace and
> > nothing in the syscall entry path checks and masks it. So we really have
> > to preserve the semantic of the flag bit for ever.
> 
> Thanks, I see you point. Yes, it is exported to userspace in some sense
> since it is in uapi header. But, it is never documented and MPOL_MF_VALID
> excludes it. mbind() does check and mask it. It would return -EINVAL if
> MPOL_MF_LAZY or any other undefined/invalid flag is set. See the below code
> snippet from do_mbind():
> 

That does not explain the motivation behind removing it or what we gain.
Yes, it's undocumented and it's unlikely that anyone will. Any potential
semantics are almost meaningless with mbind but there are two
possibilities. One, mbind is relaxed to allow migration within allowed
nodes and two, interleave could initially interleave but allow migration
to local node to get a mix of average performance at init and local
performance over time. No one tried taking that option so far but it
appears harmless to leave it alone too.

-- 
Mel Gorman
SUSE Labs
