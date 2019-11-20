Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCCAC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F0822312
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574238605;
	bh=JQOmElfXSzHu9Z+PGD9kkgOcTSRKyGXU0jtHg/2wKGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CEJJzDmcXiDqDLEL0QVKhk0k3Pu6/++EH/iMrWcT3WFwrtEg3spHFJnt2Sb5UD/KI
	 2XnOlvrTG/ZsoWoUZ9dfQo2GEaXYF2rw5nTFzgxdTKYxfzFol1Ow9vnETeuuzOgR/H
	 qNjLBiAb7Vnvy6jXyKFHIDZ7cQ3SIB2JqqurQzog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfKTIaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 03:30:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:41512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfKTIaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 03:30:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1D9222312;
        Wed, 20 Nov 2019 08:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574238601;
        bh=JQOmElfXSzHu9Z+PGD9kkgOcTSRKyGXU0jtHg/2wKGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GtA1+jt399FcL+Wkav+tdOgD7i/XpKJjJpYB6jRyDekk3ghuztLdnTVZTyCXIqlss
         6QbOU1JZ4RCt2pNmShKR98SjB/RqtkKW4vlxG/gtXLDn1GGWKKCefznlb0lwTdOJml
         6Px20McEVDUMhPAkLvB9I/AbNAEpuJ050xISifU8=
Date:   Wed, 20 Nov 2019 09:29:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     syzbot <syzbot+3dcb532381f98c86aeb1@syzkaller.appspotmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org,
        torvalds@linux-foundation.org
Subject: Re: WARNING in kernfs_get
Message-ID: <20191120082958.GB2862348@kroah.com>
References: <000000000000f921ae05757f567c@google.com>
 <0000000000001da6b60597c2ce91@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001da6b60597c2ce91@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 12:17:01AM -0800, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 726e41097920a73e4c7c33385dcc0debb1281e18
> Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date:   Tue Jul 10 00:29:10 2018 +0000
> 
>     drivers: core: Remove glue dirs from sysfs earlier
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17a101cee00000
> start commit:   9a568276 Merge branch 'x86-urgent-for-linus' of git://git...
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=146101cee00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=106101cee00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
> dashboard link: https://syzkaller.appspot.com/bug?extid=3dcb532381f98c86aeb1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12657f0a400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117728ae400000
> 
> Reported-by: syzbot+3dcb532381f98c86aeb1@syzkaller.appspotmail.com
> Fixes: 726e41097920 ("drivers: core: Remove glue dirs from sysfs earlier")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Again, I think this should be resolved with ac43432cb1f5 ("driver core:
Fix use-after-free and double free on glue directory")

Is there any way to run the reproducer on a newer tree?

thanks,

greg k-h
