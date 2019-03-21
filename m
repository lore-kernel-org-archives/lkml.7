Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687E5C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36043218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553197545;
	bh=uhnH0vJdVj3wEVkCT5S3rq0gNoL6zmPao8NKuhDBBQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MAp8GDbkS9fg68ynN1AOUK7J4B2Uh5zwCbPULH9eON1GiloB1mQi9NrmOfZE1gE7t
	 SpEnLPZHKLI+HT88KB1SwnrkAOhLi4adMK9EGJ+yJ/U7H9Eef8hWfNJg2fWq18RJtP
	 lezXvnIamXnT2OvB/XnzFf/mcDyqND5OQGg+TsLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfCUTpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 15:45:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:46198 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727909AbfCUTpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 15:45:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0AC07AF46;
        Thu, 21 Mar 2019 19:45:41 +0000 (UTC)
Date:   Thu, 21 Mar 2019 20:45:39 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mgorman@techsingularity.net, vbabka@suse.cz,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: mempolicy: remove MPOL_MF_LAZY
Message-ID: <20190321194539.GY8696@dhcp22.suse.cz>
References: <1553041659-46787-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190321145745.GS8696@dhcp22.suse.cz>
 <75059b39-dbc4-3649-3e6b-7bdf282e3f53@linux.alibaba.com>
 <20190321165112.GU8696@dhcp22.suse.cz>
 <60ef6b4a-4f24-567f-af2f-50d97a2672d6@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60ef6b4a-4f24-567f-af2f-50d97a2672d6@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21-03-19 10:25:08, Yang Shi wrote:
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
> ...
> #define MPOL_MF_VALID    (MPOL_MF_STRICT   |     \
>              MPOL_MF_MOVE     |     \
>              MPOL_MF_MOVE_ALL)
> 
> if (flags & ~(unsigned long)MPOL_MF_VALID)
>         return -EINVAL;
> 
> So, I don't think any application would really use the flag for mbind()
> unless it is aimed to test the -EINVAL. If just test program, it should be
> not considered as a regression.

I have overlook that MPOL_MF_VALID doesn't include MPOL_MF_LAZY. Anyway,
my argument still holds that the bit has to be reserved for ever because
it used to be valid at some point of time and not returning EINVAL could
imply you are running on the kernel which supports the flag.
 
> > > I'm also not sure if anyone use MPOL_MF_INTERNAL or not and how they use it
> > > in their applications, but how about keeping it unchanged?
> > You really have to. Because it is an offset of other MPLO flags for
> > internal usage.
> > 
> > That being said. Considering that we really have to preserve
> > MPOL_MF_LAZY value (we cannot even rename it because it is in uapi
> > headers and we do not want to break compilation). What is the point of
> > this change? Why is it an improvement? Yes, nobody is probably using
> > this because this is not respected in anything but the preferred mem
> > policy. At least that is the case from my quick glance. I might be still
> > wrong as it is quite easy to overlook all the consequences. So the risk
> > is non trivial while the benefit is not really clear to me. If you see
> > one, _document_ it. "Mel said it is not in use" is not a justification,
> > with all due respect.
> 
> As I elaborated above, mbind() syscall does check it and treat it as an
> invalid flag. MPOL_PREFERRED doesn't use it either, but just use MPOL_F_MOF
> directly.

As Mel already pointed out. This doesn't really sound like a sound
argument. Say we would remove those few lines of code and preserve the
flag for future reservation of the flag bit. I would bet my head that it
will not be long before somebody just goes and clean it up and remove
because the flag is unused. So you would have to put a note explaining
why this has to be preserved. Maybe the current code is better to
document that. It would be much more sound to remove the code if it was
causing a measurable overhead or a maintenance burden. Is any of that
the case?

-- 
Michal Hocko
SUSE Labs
