Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FBFC352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9710821721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570448233;
	bh=DeDtg5BYyoH5R50tZVdT+sUkRN+LeIt0NG34SdtAwG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QPI/pUakMk5SqHArtHYCo8+bSpWMquO/Rry0x57CCk7vzunAS5P1OCIcIXEP+RSx2
	 Rd6WIjRP0i4xijgOa5Jbm0+bj33FqNhn8DSAHQJxwcd2xC2JCr8UdcqNPsCNwrCfUT
	 fP+Mv2DzDrfkrDyZHrNJc1UuohyDsMoDEp7yeC5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfJGLhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:37:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:48546 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727394AbfJGLhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:37:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6C7FAE65;
        Mon,  7 Oct 2019 11:37:10 +0000 (UTC)
Date:   Mon, 7 Oct 2019 13:37:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, john.ogness@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191007113710.GH2381@dhcp22.suse.cz>
References: <20191007080742.GD2381@dhcp22.suse.cz>
 <FB72D947-A0F9-43E7-80D9-D7ACE33849C7@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FB72D947-A0F9-43E7-80D9-D7ACE33849C7@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-10-19 07:04:00, Qian Cai wrote:
> 
> 
> > On Oct 7, 2019, at 4:07 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > I do not think that removing the printk is the right long term solution.
> > While I do agree that removing the debugging printk __offline_isolated_pages
> > does make sense because it is essentially of a very limited use, this
> > doesn't really solve the underlying problem.  There are likely other
> > printks from zone->lock. It would be much more saner to actually
> > disallow consoles to allocate any memory while printk is called from an
> > atomic context.
> 
> No, there is only a handful of places called printk() from
> zone->lock. It is normal that the callers will quietly process
> “struct zone” modification in a short section with zone->lock
> held.

It is extremely error prone to have any zone->lock vs. printk
dependency. I do not want to play an endless whack a mole.

> No, it is not about “allocate any memory while printk is called from an
> atomic context”. It is opposite lock chain  from different processors which has the same effect. For example,
> 
> CPU0:                 CPU1:         CPU2:
> console_owner
>                             sclp_lock
> sclp_lock                                 zone_lock
>                             zone_lock
>                                                  console_owner

Why would sclp_lock ever take a zone->lock (apart from an allocation).
So really if sclp_lock is a lock that might be taken from many contexts
and generate very subtle lock dependencies then it should better be
really careful what it is calling into.

In other words you are trying to fix a wrong end of the problem. Fix the
console to not allocate or depend on MM by other means.
-- 
Michal Hocko
SUSE Labs
