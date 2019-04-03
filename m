Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D29BC10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581C6206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfDCLy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:54:58 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:33406 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbfDCLy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 07:54:57 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hBeTn-0000HN-LC; Wed, 03 Apr 2019 13:54:55 +0200
Date:   Wed, 3 Apr 2019 13:54:55 +0200
From:   Florian Westphal <fw@strlen.de>
To:     syzbot <syzbot+537175332b212b4d885b@syzkaller.appspotmail.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: BUG: using __this_cpu_read() in preemptible code in sk_mc_loop
Message-ID: <20190403115455.aqghw2n6yutnuc73@breakpoint.cc>
References: <0000000000004bf9c805859e36d4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004bf9c805859e36d4@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+537175332b212b4d885b@syzkaller.appspotmail.com> wrote:
> syzbot found the following crash on:

> HEAD commit:    e1427237 macsec: add noinline tag to avoid a frame size wa..
> git tree:       net-next
[..]

> The bug was bisected to:
> 
> commit 97cdcf37b57e3f204be3000b9eab9686f38b4356
> Author: Florian Westphal <fw@strlen.de>
> Date:   Mon Apr 1 14:42:13 2019 +0000
> 
>     net: place xmit recursion in softnet data
[..]
> BUG: using __this_cpu_read() in preemptible [00000000] code:
> syz-executor284/7845
> caller is dev_recursion_level include/linux/netdevice.h:3052 [inline]

#syz dup: BUG: using __this_cpu_read() in preemptible code in ip6_finish_output
