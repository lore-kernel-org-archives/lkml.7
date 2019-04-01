Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515C0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E46A2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfDATVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:21:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:3384 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfDATVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 15:21:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 12:21:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,297,1549958400"; 
   d="scan'208";a="157231484"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga002.fm.intel.com with ESMTP; 01 Apr 2019 12:21:19 -0700
Date:   Mon, 1 Apr 2019 12:21:19 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     syzbot <syzbot+ab5d7a5d0fc0c7518f6d@syzkaller.appspotmail.com>
Cc:     hpa@zytor.com, jmattson@google.com, karahmed@amazon.de,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: WARNING in enter_vmx_operation
Message-ID: <20190401192119.GC24070@linux.intel.com>
References: <00000000000005dc880574b12567@google.com>
 <000000000000c6c95105854d4f1d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c6c95105854d4f1d@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 03:33:00AM -0700, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 8fcc4b5923af5de58b80b53a069453b135693304
> Author: Jim Mattson <jmattson@google.com>
> Date:   Tue Jul 10 09:27:20 2018 +0000
> 
>     kvm: nVMX: Introduce KVM_CAP_NESTED_STATE
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16dc157d200000
> start commit:   3f16503b Merge branch 'fixes' of git://git.kernel.org/pub/..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=15dc157d200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11dc157d200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=49927b422dcf0b29
> dashboard link: https://syzkaller.appspot.com/bug?extid=ab5d7a5d0fc0c7518f6d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132365a6400000
> 
> Reported-by: syzbot+ab5d7a5d0fc0c7518f6d@syzkaller.appspotmail.com
> Fixes: 8fcc4b5923af ("kvm: nVMX: Introduce KVM_CAP_NESTED_STATE")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Likewise, this is variant on the bug fixed by commit 5bea5123cbf0 ("KVM: VMX:
check nested state and CR4.VMXE against SMM").

#syz fix: KVM: VMX: check nested state and CR4.VMXE against SMM
