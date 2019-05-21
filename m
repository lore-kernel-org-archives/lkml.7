Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56523C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B44B21773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558433701;
	bh=F0HI4YyVZmieWlFjzE85g4A4YpjP9XxqQp2oP8pArNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jcG1vrgizVboTLk1xw1UCSFbtSMa77agVxTA7LED+4ER/M4MhUk6VvCFwEhJgHFuV
	 tYGJXvbNLVeutq5/UXTYl3xPVc2fKwyXSOfbVhpjNWS1i7h2T9i+WFHHJKmr4JUbEa
	 ms/rbRWvIZSUI/sehkW4trvB676CwuO8VFPQn6cU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfEUKPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:15:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:60584 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726138AbfEUKPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:15:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AB8E2AAA8;
        Tue, 21 May 2019 10:14:58 +0000 (UTC)
Date:   Tue, 21 May 2019 12:14:57 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com, ira.weiny@intel.com,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        james.morse@arm.com, cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, mgorman@techsingularity.net,
        osalvador@suse.de, ard.biesheuvel@arm.com
Subject: Re: [PATCH V4 3/4] arm64/mm: Hold memory hotplug lock while walking
 for kernel page table dump
Message-ID: <20190521101457.GK32329@dhcp22.suse.cz>
References: <1558329516-10445-1-git-send-email-anshuman.khandual@arm.com>
 <1558329516-10445-4-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558329516-10445-4-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-05-19 10:48:35, Anshuman Khandual wrote:
> The arm64 page table dump code can race with concurrent modification of the
> kernel page tables. When a leaf entries are modified concurrently, the dump
> code may log stale or inconsistent information for a VA range, but this is
> otherwise not harmful.
> 
> When intermediate levels of table are freed, the dump code will continue to
> use memory which has been freed and potentially reallocated for another
> purpose. In such cases, the dump code may dereference bogus addresses,
> leading to a number of potential problems.
> 
> Intermediate levels of table may by freed during memory hot-remove,
> which will be enabled by a subsequent patch. To avoid racing with
> this, take the memory hotplug lock when walking the kernel page table.

I've had a comment on this patch in the previous version which didn't
get answered completely AFAICS. If you really insist then please make
sure to describe why does this really matter because this will make
any further changes to the hotplug locking harder and I would to see
that it is worth the additional trouble.

Thanks!
-- 
Michal Hocko
SUSE Labs
