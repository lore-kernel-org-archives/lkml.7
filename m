Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0901CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 04:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01BE214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 04:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbfCLEI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 00:08:58 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36448 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfCLEI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 00:08:57 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h3YiL-0003ts-SD; Tue, 12 Mar 2019 04:08:30 +0000
Date:   Tue, 12 Mar 2019 04:08:29 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+1505c80c74256c6118a5@syzkaller.appspotmail.com>
Cc:     airlied@linux.ie, akpm@linux-foundation.org, amir73il@gmail.com,
        chris@chris-wilson.co.uk, darrick.wong@oracle.com,
        david@fromorbit.com, dri-devel@lists.freedesktop.org,
        dvyukov@google.com, eparis@redhat.com, hannes@cmpxchg.org,
        hughd@google.com, intel-gfx@lists.freedesktop.org, jack@suse.cz,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        jrdr.linux@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mingo@redhat.com, mszeredi@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
        rodrigo.vivi@intel.com, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Subject: Re: INFO: rcu detected stall in sys_sendfile64 (2)
Message-ID: <20190312040829.GQ2217@ZenIV.linux.org.uk>
References: <00000000000010b2fc057fcdfaba@google.com>
 <0000000000008c75b50583ddb5f8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008c75b50583ddb5f8@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 08:59:00PM -0700, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 34e07e42c55aeaa78e93b057a6664e2ecde3fadb
> Author: Chris Wilson <chris@chris-wilson.co.uk>
> Date:   Thu Feb 8 10:54:48 2018 +0000
> 
>     drm/i915: Add missing kerneldoc for 'ent' in i915_driver_init_early
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13220283200000
> start commit:   34e07e42 drm/i915: Add missing kerneldoc for 'ent' in i915..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=10a20283200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=17220283200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=abc3dc9b7a900258
> dashboard link: https://syzkaller.appspot.com/bug?extid=1505c80c74256c6118a5
> userspace arch: amd64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c4dc28c00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15df4108c00000
> 
> Reported-by: syzbot+1505c80c74256c6118a5@syzkaller.appspotmail.com
> Fixes: 34e07e42 ("drm/i915: Add missing kerneldoc for 'ent' in
> i915_driver_init_early")

Umm...  Might be a good idea to add some plausibility filters - it is,
in theory, possible that adding a line in a comment changes behaviour
(without compiler bugs, even - playing with __LINE__ is all it would
take), but the odds that it's _not_ a false positive are very low.
