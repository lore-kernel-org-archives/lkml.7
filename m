Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A1BC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4669020717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556216644;
	bh=T+djvlY0Op+8S3e7Uszj+n9b7B01U5JjCvF/LyluHgk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=JNcSRdbrmy4FRlIa8fEta6KaYITELIqx5Lfoc/6Gw3p1CyZnu0pKe8jE3SQkRTxEE
	 eor/YWqESv8dh7Io60GioekJfggmY+A8B5yWRhqZioAdujmJouCQBBTwbHzp1iEkVt
	 rNJsyTx7614QEsSXq6etXgV/pAyyN8DDRmjnPWEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfDYSYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfDYSYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:24:02 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68DCB2067C;
        Thu, 25 Apr 2019 18:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556216642;
        bh=T+djvlY0Op+8S3e7Uszj+n9b7B01U5JjCvF/LyluHgk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=u786UzOpCF6Ug+94YeYrTOW7fN+dYxNLT6KG8YL3s6fjLNVjTPsvIoJPZW0UnZFYe
         xbXlZSXL6Bl8wPQjpVlehi2WToz5pQpb70URZ44/p3MGaljxRLaXpSkBZ5S6D7MxVN
         pgoUVrVxRK/GRTeGGKUwcpmxUzldvW0j8kgDR6+0=
Message-ID: <342ef35feb1110197108068d10e518742823a210.camel@kernel.org>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu, 25 Apr 2019 14:23:59 -0400
In-Reply-To: <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
References: <20190425174739.27604-1-idryomov@gmail.com>
         <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-25 at 11:02 -0700, Linus Torvalds wrote:
> On Thu, Apr 25, 2019 at 10:48 AM Ilya Dryomov <idryomov@gmail.com> wrote:
> > dentry name handling fixes from Jeff and a memory leak fix from Zheng.
> > Both are old issues, marked for stable.
> 
> Hmm. You probably should have talked to Al about the dentry name
> issue, because he'd most likely have pointed you towards our helper
> function for exactly this thing:
> 
>     struct name_snapshot stable;
> 
>     take_dentry_name_snapshot(&stable, dentry);
>     ... use stable.name ..
>     release_dentry_name_snapshot(&stable);
> 
> which doesn't need any extra memory allocation outside of some fairly
> limited stack allocation for the 'name_snapshot' itself, because it
> knows about the dentry name rules, and
> 
>  - for inline names, it copies it under the d_lock into the fixed
> DNAME_INLINE_LEN-sized buffer
> 
>  - for out-of-line names, it knows that the name allocation is stable
> and ref-counted, and just increments the refcount and uses the
> existing name pointer.
> 
> now, maybe you need to always do that name allocation anyway (looking
> at the diff it looks like you often do that for other cases), so maybe
> the name snapshot capability isn't all that useful for you and the
> above wouldn't have helped, but I suspect you might not even have
> realized that there was an option like this.
> 
> I've pulled this, but maybe Jeff wants to look at whether that
> snapshotting model could have helped.
> 
>                        Linus

Thanks for the info! I think it would have.

I took a quick look at the dcache code to see if we had something like
that before I did this, but I guess I didn't look closely enough. Those
routines do look nicer than my hand-rolled version.

I'll look at spinning up a patch to switch that over in the near future.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

