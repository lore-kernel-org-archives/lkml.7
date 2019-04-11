Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D744C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99E720850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfDKVuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:50:46 -0400
Received: from gate.crashing.org ([63.228.1.57]:43015 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbfDKVuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:50:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x3BLoK1R006767;
        Thu, 11 Apr 2019 16:50:21 -0500
Message-ID: <068bf2f6512c10fd4ca71ea6017e27fa5928d166.camel@kernel.crashing.org>
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     davem@davemloft.net, gregkh@linuxfoundation.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        netdev@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        torvalds@linux-foundation.org
Date:   Fri, 12 Apr 2019 07:50:20 +1000
In-Reply-To: <000000000000109c700586401f48@google.com>
References: <000000000000109c700586401f48@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-11 at 05:14 -0700, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 726e41097920a73e4c7c33385dcc0debb1281e18
> Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date:   Tue Jul 10 00:29:10 2018 +0000
> 
>      drivers: core: Remove glue dirs from sysfs earlier

Greg, any idea what this is ? The log isn't terribly readable. The
above patch fixes a real bug that causes use after free and memory
corruption under some circumstances. I wonder if the BT stack is itself
manipulating stale objects ?

Ben.

> bisection log:  
> https://syzkaller.appspot.com/x/bisect.txt?x=15f69eaf200000
> start commit:   771acc7e Bluetooth: btusb: request wake pin with
> NOAUTOEN
> git tree:       upstream
> final crash:    
> https://syzkaller.appspot.com/x/report.txt?x=17f69eaf200000
> console output: 
> https://syzkaller.appspot.com/x/log.txt?x=13f69eaf200000
> kernel config:  
> https://syzkaller.appspot.com/x/.config?x=4fb64439e07a1ec0
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=91fd909b6e62ebe06131
> syz repro:      
> https://syzkaller.appspot.com/x/repro.syz?x=11770a8f200000
> C reproducer:   
> https://syzkaller.appspot.com/x/repro.c?x=128c945b200000
> 
> Reported-by: syzbot+91fd909b6e62ebe06131@syzkaller.appspotmail.com
> Fixes: 726e41097920 ("drivers: core: Remove glue dirs from sysfs
> earlier")
> 
> For information about bisection process see: 
> https://goo.gl/tpsmEJ#bisection

