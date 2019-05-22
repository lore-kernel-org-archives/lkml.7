Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0300C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 23:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EB92173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 23:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfEVXrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 19:47:08 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63673 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfEVXrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 19:47:08 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4MNkTcY073322;
        Thu, 23 May 2019 08:46:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Thu, 23 May 2019 08:46:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4MNkTFI073309;
        Thu, 23 May 2019 08:46:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x4MNkTqj073305;
        Thu, 23 May 2019 08:46:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201905222346.x4MNkTqj073305@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH] =?ISO-2022-JP?B?a2VybmVsL2h1bmdfdGFzay5jOiBNb25pdG9yIGtpbGxl?=
 =?ISO-2022-JP?B?ZCB0YXNrcy4=?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Liu Chuansheng <chuansheng.liu@intel.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
MIME-Version: 1.0
Date:   Thu, 23 May 2019 08:46:29 +0900
References: <20190523073925.169563ed@canb.auug.org.au> <20190522144300.5ea06345efd9a831803105b7@linux-foundation.org>
In-Reply-To: <20190522144300.5ea06345efd9a831803105b7@linux-foundation.org>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 23 May 2019 07:39:25 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > > I put an example patch into my subversion repository:
> > > 
> > >   svn checkout https://svn.osdn.net/svnroot/tomoyo/branches/syzbot-patches/
> > > 
> > > To fetch up-to-date debug printk() patches:
> > > 
> > >   cd syzbot-patches
> > >   svn update
> > > 
> > > Does this work for you?
> > 
> > Neither will fit into my normal workflow.
> > 
> > So, tell me, what are you trying to do?  What does you work depend on?
> > Just Linus' tree, or something already in linux-next?  Why would you
> > want to keep moving your patch(es) on top of linux-next?

"[PATCH] printk: Monitor change of console loglevel." is targeted for
linux-next only, and I estimate that this patch will be removed in a
week or so, for syzbot can reproduce this problem using linux-next and
syzbot will blacklist testcases causing this problem.

"[PATCH] kernel/hung_task.c: Monitor killed tasks." is targeted for upstream, for
syzbot is hitting this problem in any tree and this will be a kernel's problem.
But for feasibility check, for now I want to try this patch on only linux-next.
I guess we need to tune (e.g. add sysctl) before sending to linux.git tree.

I am seeking for an approach which is less burden for both of you. But it
seems that using Andrew's route seems to fit better for Stephen's workflow.

> 
> um, I can carry developer-only linux-next debug patches.
> 

OK. Then, will you carry these patches?

Regards.
