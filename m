Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F051AECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A4B20663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571071039;
	bh=878DuIWznyHShg4KkX2cLIzJpu5yrUZVvBHYaduUPEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dPbT4ulEYbyOMe6eOIa7VZqgJ40sf1IAgZsSDpAC57ic2V62Zg0qtwOO64REypR6u
	 XalJnI4VRv4PJC3TFjtkEGCf9vWOZAkvHqCBiSQD9XmaGvXu6Uq/hz3a2HusbspLnC
	 WpI95zJoeG4myv9ry2LzQ98CPagFJ0VW74r3edfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbfJNQhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:37:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732550AbfJNQhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:37:18 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86B0B21835;
        Mon, 14 Oct 2019 16:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571071037;
        bh=878DuIWznyHShg4KkX2cLIzJpu5yrUZVvBHYaduUPEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YgC2erON/ZOLaFpvCgMjE09GdR0Bmm3yDqH0L9s3AvEXcz6sb1/hC4PRdzPUj8cPv
         vLxMrWW+5yTiWhLHlNuezjfTM/uZloh15o0D5bS2U9NPDdoBdaphejammqHKOvCoci
         hOinQbQ2/Ybsa3vAthO7x1nAfNOhdYLYQpbZEYaY=
Date:   Mon, 14 Oct 2019 09:37:16 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Andrew Macks <andypoo@gmail.com>, stable@kernel.org,
        Greg KH <greg@kroah.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: Re: Regression in longterm 4.19: f2fs: use generic
 EFSBADCRC/EFSCORRUPTED
Message-ID: <20191014163716.GA76340@jaegeuk-macbookpro.roam.corp.google.com>
References: <CAFeYvHWC=RZJr2ZSAvRy=r1kAJU8YW-hxkZ3uBAd2OQEerKmag@mail.gmail.com>
 <CAFeYvHXQQPfu+r0kLpTXWRZJr8SFF1QyUWzOkjJYFE2_UVSrUA@mail.gmail.com>
 <20191013214440.GA20196@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013214440.GA20196@amd>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you so much for taking care of this.

Hi Greg,

Could you please cherry-pick the below commit in -stable?

38fb6d0ea34299d97b031ed64fe994158b6f8eb3
   f2fs: use EINVAL for superblock with invalid magic

Thanks,

On 10/13, Pavel Machek wrote:
> On Sat 2019-10-12 21:55:24, Andrew Macks wrote:
> > Sorry for version typo in the previous message.
> > 
> > In addition to 4.19, the issue was also backported to 4.14 and 5.2.
> > 
> > 4.14, 4.19 and 5.2 are all missing the EINVAL fix from 5.3.
> 
> Ouch.
> 
> Well, when I seen the patch, I thought "looks like the bug is not
> serious enough for -stable". I guess I should have spoken up.
> 
> Anyway, I guess we need to either revert  59a5cea41dd0a or backport
> 38fb6d0ea34299d97b too....
> 
> So I guess Greg and lists need to be cc-ed... and 
> 
> Thanks for the report and sorry for the trouble....
> 
> 								Pavel
> 
> 
> > Andrew.
> > 
> > On Sat, 12 Oct 2019 at 21:39, Andrew Macks <andypoo@gmail.com> wrote:
> > 
> > > Hi - there is a nasty regression which was recently introduced into
> > > longterm 4.19.76.
> > >
> > > 59a5cea41dd0ae706ab83f8ecd64199aadefb493 was committed to 4.19, however it
> > > introduces a regression that filesystems no longer mount if do_mounts
> > > iterates through them after F2FS.  This surfaced on one of my servers as
> > > F2FS superblock check happens before btrfs mount is attempted.
> > >
> > > With this code, my server panicked after kernel upgrade as btrfs mount
> > > wasn't attempted.
> > >
> > > This issue has already been fixed in 5.3 with this patch in July, but it
> > > was missed from the 4.19 backport.
> > >
> > > 38fb6d0ea34299d97b031ed64fe994158b6f8eb3
> > > f2fs: use EINVAL for superblock with invalid magic
> > >
> > > Andypoo.
> > >
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


