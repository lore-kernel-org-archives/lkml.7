Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14D9C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28FA21E6B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbfHGNIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:08:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49650 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfHGNIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:08:18 -0400
Received: from p200300ddd742df588d2c07822b9f4274.dip0.t-ipconnect.de ([2003:dd:d742:df58:8d2c:782:2b9f:4274])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hvLfH-0000vJ-Ia; Wed, 07 Aug 2019 15:07:39 +0200
Date:   Wed, 7 Aug 2019 15:07:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pingfan Liu <kernelfans@gmail.com>
cc:     Dave Young <dyoung@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Drake <drake@endlessm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, tony.luck@intel.com,
        Xunlei Pang <xlpang@linux.alibaba.com>
Subject: Re: [PATCH 0/4] x86/mce: protect nr_cpus from rebooting by broadcast
 mce
In-Reply-To: <20190807075226.GA10392@mypc>
Message-ID: <alpine.DEB.2.21.1908071504310.24014@nanos.tec.linutronix.de>
References: <1564995539-29609-1-git-send-email-kernelfans@gmail.com> <20190807025843.GA4776@dhcp-128-65.nay.redhat.com> <20190807075226.GA10392@mypc>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2019, Pingfan Liu wrote:
> On Wed, Aug 07, 2019 at 11:00:41AM +0800, Dave Young wrote:
> > Add Tony and Xunlei in cc.
> > On 08/05/19 at 04:58pm, Pingfan Liu wrote:
> > > This series include two related groups:
> > > [1-3/4]: protect nr_cpus from rebooting by broadcast mce
> > > [4/4]: improve "kexec -l" robustness against broadcast mce
> > > 
> > > When I tried to fix [1], Thomas raised concern about the nr_cpus' vulnerability
> > > to unexpected rebooting by broadcast mce. After analysis, I think only the
> > > following first case suffers from the rebooting by broadcast mce. [1-3/4] aims
> > > to fix that issue.
> > 
> > I did not understand and read the MCE details, but we previously had a
> > MCE problem, Xunlei fixed in below commit:
> > commit 5bc329503e8191c91c4c40836f062ef771d8ba83
> > Author: Xunlei Pang <xlpang@redhat.com>
> > Date:   Mon Mar 13 10:50:19 2017 +0100
> > 
> >     x86/mce: Handle broadcasted MCE gracefully with kexec
> > 
> > I wonder if this is same issue or not. Also the old discussion is in
> > below thread:
> > https://lore.kernel.org/patchwork/patch/753530/
> > 
> > Tony raised similar questions, but I'm not sure if it is still a problem
> > or it has been fixed.
> > 
>
> Xunlei's patch is the precondition of the stability for the case 2: boot
> up by "kexec -p nr_cpus="

Correct. The only dangerous issue which is then left is that an MCE hits
_before_ all CPUs have CR.MCE=1 set. That's a general issue also for cold
boot. Thanks to the brilliant hardware design, all we can do is pray....

> For case1/3, extra effort is needed.
> 
> Thanks,
> 	Pingfan
> > > 
> > > *** Back ground ***
> > > 
> > > On x86 it's required to have all logical CPUs set CR4.MCE=1. Otherwise, a
> > > broadcast MCE observing CR4.MCE=0b on any core will shutdown the machine.

Pingfan, please trim your replies and remove the useless gunk after your answer.

Thanks,

	tglx
