Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005BCC31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF7F2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560822351;
	bh=oSzNYEyekhj/NlwHW0X2pXMLHkV8SDK6JssH3xf5sKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=S+zqEcJin7/dk6Fw5TSOZaGcG5XHftqSx0imfVHDWyzmtxXbxdyJSDn12+euINwoJ
	 ZriwZeoo2E3nOgDZt1Kht3N480h3Sf4+8pirq3AfWG7vINADaXh3rCp8eTToJgWjw5
	 kKfPwT+ejJ12DC4lef3+MGxZnuaqi4mUa9oHY1Lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfFRBpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 21:45:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfFRBpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 21:45:50 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 606D22082C;
        Tue, 18 Jun 2019 01:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560822349;
        bh=oSzNYEyekhj/NlwHW0X2pXMLHkV8SDK6JssH3xf5sKg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yNs5c0QrkZ+OIgygnIUxK1vdNmaCS4P0DJmYxw82YOS8uUEUaNn7eElyjXdJTD7e6
         AfBWK397l1VTwpLOKs0GssDSAozZx2a+g3IrfRp4gA0WGzszrWdzhMeqc4VaY4cRJc
         ay+PycslEeYEG8Qr0sSGPmcGs7WwRl+eZQ6k8OdY=
Date:   Mon, 17 Jun 2019 18:45:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot <syzbot+d0fc9d3c166bc5e4a94b@syzkaller.appspotmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yuzhoujian@didichuxing.com
Subject: Re: general protection fault in oom_unkillable_task
Message-Id: <20190617184547.5b81f7df81af46e86441ba8c@linux-foundation.org>
In-Reply-To: <CALvZod5VPLVEwRzy83+wT=aA8vsrUkvoJJZvmQxyv4YbXvrQWw@mail.gmail.com>
References: <0000000000004143a5058b526503@google.com>
        <CALvZod72=KuBZkSd0ey5orJFGFpwx462XY=cZvO3NOXC0MogFw@mail.gmail.com>
        <20190615134955.GA28441@dhcp22.suse.cz>
        <CALvZod4hT39PfGt9Ohj+g77om5=G0coHK=+G1=GKcm-PowkXsw@mail.gmail.com>
        <5bb1fe5d-f0e1-678b-4f64-82c8d5d81f61@i-love.sakura.ne.jp>
        <CALvZod4etSv9Hv4UD=E6D7U4vyjCqhxQgq61AoTUCd+VubofFg@mail.gmail.com>
        <791594c6-45a3-d78a-70b5-901aa580ed9f@i-love.sakura.ne.jp>
        <840fa9f1-07e2-e206-2fc0-725392f96baf@i-love.sakura.ne.jp>
        <c763afc8-f0ae-756a-56a7-395f625b95fc@i-love.sakura.ne.jp>
        <CALvZod5VPLVEwRzy83+wT=aA8vsrUkvoJJZvmQxyv4YbXvrQWw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019 06:23:07 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> > Here is a patch to use CSS_TASK_ITER_PROCS.
> >
> > From 415e52cf55bc4ad931e4f005421b827f0b02693d Mon Sep 17 00:00:00 2001
> > From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Date: Mon, 17 Jun 2019 00:09:38 +0900
> > Subject: [PATCH] mm: memcontrol: Use CSS_TASK_ITER_PROCS at mem_cgroup_scan_tasks().
> >
> > Since commit c03cd7738a83b137 ("cgroup: Include dying leaders with live
> > threads in PROCS iterations") corrected how CSS_TASK_ITER_PROCS works,
> > mem_cgroup_scan_tasks() can use CSS_TASK_ITER_PROCS in order to check
> > only one thread from each thread group.
> >
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> 
> Why not add the reproducer in the commit message?

That would be nice.

More nice would be, as always, a descriptoin of the user-visible impact
of the patch.

As I understand it, it's just a bit of a cleanup against current
mainline but without this patch in place, Shakeel's "mm, oom: refactor
dump_tasks for memcg OOMs" will cause kernel crashes.  Correct?
