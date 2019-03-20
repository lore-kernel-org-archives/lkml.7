Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99D2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819402184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553087819;
	bh=YgCzgdslpikSlCqb6m6tPqra6CYcWrR5JgBi/0mFXQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pSfXgrypU2NlK5+2A1KH4xZ37S/LIQ40ZO4GuZKsG0hR8NxVJBDnK6mWGG51zn43g
	 sTz0YDcpiKkp2hVVO60S31xLYIo6xFhBvdpOUwCkqbT0hVK4T2nUAfcp+3mQ1lmX1V
	 FxkLh3zYR5XvDLY8lVIJ8ab5Vq+fr4O3yhhQV7zs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfCTNQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:16:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:50068 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726366AbfCTNQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:16:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A380BAEEA;
        Wed, 20 Mar 2019 13:16:56 +0000 (UTC)
Date:   Wed, 20 Mar 2019 14:16:55 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     syzbot <syzbot+b70f2aabc707c69c9239@syzkaller.appspotmail.com>
Cc:     chanho.min@lge.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com, pavel@ucw.cz,
        rafael.j.wysocki@intel.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: WARNING: syz-executor still has locks held!
Message-ID: <20190320131655.GA8696@dhcp22.suse.cz>
References: <0000000000000e4a41057b6c9792@google.com>
 <0000000000004cdec6058485b2ce@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004cdec6058485b2ce@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-03-19 05:24:00, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit c22397888f1eed98cd59f0a88f2a5f6925f80e15
> Author: Chanho Min <chanho.min@lge.com>
> Date:   Mon Nov 12 03:54:45 2018 +0000
> 
>     exec: make de_thread() freezable
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ee6217200000
> start commit:   c2239788 exec: make de_thread() freezable
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=16ee6217200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12ee6217200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
> dashboard link: https://syzkaller.appspot.com/bug?extid=b70f2aabc707c69c9239
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c9e26d400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e1234d400000
> 
> Reported-by: syzbot+b70f2aabc707c69c9239@syzkaller.appspotmail.com
> Fixes: c2239788 ("exec: make de_thread() freezable")

Yes we do hold the cgred mutex while calling freezable_schedule but why
are we getting a warning is not really clear to me. The task should be
hidden from the freezer so why do we warn at all?
-- 
Michal Hocko
SUSE Labs
