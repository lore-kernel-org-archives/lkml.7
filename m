Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668D4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4072D218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfCUQSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:18:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbfCUQSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:18:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EAE77307D973;
        Thu, 21 Mar 2019 16:18:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.32])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8D92E60BF2;
        Thu, 21 Mar 2019 16:18:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 21 Mar 2019 17:18:44 +0100 (CET)
Date:   Thu, 21 Mar 2019 17:18:41 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     syzbot <syzbot+eab6e18f95a9fe69005e@syzkaller.appspotmail.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org,
        ravi.bangoria@linux.ibm.com, rostedt@goodmis.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in delayed_uprobe_remove
Message-ID: <20190321161841.GA12297@redhat.com>
References: <000000000000ec1b3805799d0a56@google.com>
 <000000000000737c07058498aea1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000737c07058498aea1@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 21 Mar 2019 16:18:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iiuc,

#syz fix: Uprobes: Fix kernel oops with delayed_uprobe_remove()

On 03/21, syzbot wrote:
>
> syzbot has bisected this bug to:
> 
> commit a6ca88b241d5e929e6e60b12ad8cd288f0ffa256
> Author: Song Liu <songliubraving@fb.com>
> Date:   Tue Oct 2 05:36:36 2018 +0000
> 
>     trace_uprobe: support reference counter in fd-based uprobe
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12c86993200000
> start commit:   a6ca88b2 trace_uprobe: support reference counter in fd-bas..
> git tree:       linux-next
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=11c86993200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=16c86993200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2a22859d870756c1
> dashboard link: https://syzkaller.appspot.com/bug?extid=eab6e18f95a9fe69005e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137174f5400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1278485d400000
> 
> Reported-by: syzbot+eab6e18f95a9fe69005e@syzkaller.appspotmail.com
> Fixes: a6ca88b241d5 ("trace_uprobe: support reference counter in fd-based
> uprobe")

