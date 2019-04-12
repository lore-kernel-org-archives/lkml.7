Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439DFC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1206D2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfDLNVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:21:53 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:32862 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726780AbfDLNVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:21:53 -0400
X-IronPort-AV: E=Sophos;i="5.60,341,1549926000"; 
   d="scan'208";a="378402087"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 15:21:51 +0200
Date:   Fri, 12 Apr 2019 15:21:42 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Pavel Machek <pavel@ucw.cz>
cc:     syzbot <syzbot+e1a4f80c370d2381e49f@syzkaller.appspotmail.com>,
        Julia.Lawall@lip6.fr, bp@alien8.de, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, dave.jiang@intel.com,
        haozhong.zhang@intel.com, hpa@zytor.com,
        jacek.anaszewski@gmail.com, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org, rkrcmar@redhat.com,
        rpurdie@rpsys.net, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: WARNING in untrack_pfn
In-Reply-To: <20190412130112.GA8384@amd>
Message-ID: <alpine.DEB.2.20.1904121520350.22857@hadrien>
References: <000000000000f70a0e0571ad8ffb@google.com> <0000000000007b03eb058653caea@google.com> <20190412130112.GA8384@amd>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Apr 2019, Pavel Machek wrote:

> On Fri 2019-04-12 04:42:01, syzbot wrote:
> > syzbot has bisected this bug to:
> >
> > commit c68729119f4d2993bec3c9cb999ad76de5aeddba
> > Author: Julia Lawall <Julia.Lawall@lip6.fr>
> > Date:   Sat Jul 15 09:58:19 2017 +0000
> >
> >     leds: tlc591xx: add missing of_node_put
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12cda0f3200000
> > start commit:   23203e3f Merge branch 'akpm' (patches from Andrew)
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=11cda0f3200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16cda0f3200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=861a3573f4e78ba1
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e1a4f80c370d2381e49f
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17836d15400000
> >
> > Reported-by: syzbot+e1a4f80c370d2381e49f@syzkaller.appspotmail.com
> > Fixes: c68729119f4d ("leds: tlc591xx: add missing of_node_put")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> Can you revert c68729119f4d2993bec3c9cb999ad76de5aeddba on master and
> see  if it fixes the problem? Because this is hard to believe...

Likewise, it seems hard to believe that the change is a problem.  But
could the problem be elsewhere and triggered by this code?

julia

>
> 									Pavel
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
