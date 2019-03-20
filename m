Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3225C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBDC21850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfCTNUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:20:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727902AbfCTNSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:18:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9146031688FC;
        Wed, 20 Mar 2019 13:18:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.34])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6AC1D5D9CD;
        Wed, 20 Mar 2019 13:18:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 20 Mar 2019 14:18:45 +0100 (CET)
Date:   Wed, 20 Mar 2019 14:18:42 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     syzbot <syzbot+b70f2aabc707c69c9239@syzkaller.appspotmail.com>
Cc:     chanho.min@lge.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, pavel@ucw.cz,
        rafael.j.wysocki@intel.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: WARNING: syz-executor still has locks held!
Message-ID: <20190320131842.GA21673@redhat.com>
References: <0000000000000e4a41057b6c9792@google.com>
 <0000000000004cdec6058485b2ce@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004cdec6058485b2ce@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 20 Mar 2019 13:18:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20, syzbot wrote:
>
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

Yes, this patch was wrong, but it was reverted by a72173ecfc6774cf2d55de9fb2
(Revert "exec: make de_thread() freezable")

> final crash:    https://syzkaller.appspot.com/x/report.txt?x=16ee6217200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12ee6217200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
> dashboard link: https://syzkaller.appspot.com/bug?extid=b70f2aabc707c69c9239
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c9e26d400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e1234d400000
> 
> Reported-by: syzbot+b70f2aabc707c69c9239@syzkaller.appspotmail.com
> Fixes: c2239788 ("exec: make de_thread() freezable")

