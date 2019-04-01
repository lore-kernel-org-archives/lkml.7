Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18628C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4B320857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfDAT7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:59:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:12631 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfDAT7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 15:59:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 12:59:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,297,1549958400"; 
   d="scan'208";a="312262015"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga005.jf.intel.com with ESMTP; 01 Apr 2019 12:58:59 -0700
Date:   Mon, 1 Apr 2019 12:58:59 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     syzbot <syzbot+1c69d94fe42901b029c1@syzkaller.appspotmail.com>
Cc:     dvhart@infradead.org, hpa@zytor.com, jmattson@google.com,
        karahmed@amazon.de, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: general protection fault in kvm_lapic_hv_timer_in_use
Message-ID: <20190401195859.GA25411@linux.intel.com>
References: <0000000000006af1a90573251240@google.com>
 <0000000000009f67a70585603de2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009f67a70585603de2@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 02:08:00AM -0700, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 8fcc4b5923af5de58b80b53a069453b135693304
> Author: Jim Mattson <jmattson@google.com>
> Date:   Tue Jul 10 09:27:20 2018 +0000
> 
>     kvm: nVMX: Introduce KVM_CAP_NESTED_STATE
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127b4f43200000
> start commit:   234b69e3 ocfs2: fix ocfs2 read block panic
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=117b4f43200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=167b4f43200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa12be50bca08d8
> dashboard link: https://syzkaller.appspot.com/bug?extid=1c69d94fe42901b029c1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e14956400000
> 
> Reported-by: syzbot+1c69d94fe42901b029c1@syzkaller.appspotmail.com
> Fixes: 8fcc4b5923af ("kvm: nVMX: Introduce KVM_CAP_NESTED_STATE")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Another ancient bug, fixed by commit 26b471c7e2f7 ("KVM: nVMX: Fix bad
cleanup on error of get/set nested state IOCTLs")

#syz fix: KVM: nVMX: Fix bad cleanup on error of get/set nested state IOCTLs
