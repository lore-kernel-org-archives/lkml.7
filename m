Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F1FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC0321473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfDATQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:16:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:51418 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfDATQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 15:16:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 12:16:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,297,1549958400"; 
   d="scan'208";a="127737922"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga007.jf.intel.com with ESMTP; 01 Apr 2019 12:16:50 -0700
Date:   Mon, 1 Apr 2019 12:16:50 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     syzbot <syzbot+01bc9e7a8a3f138b71cf@syzkaller.appspotmail.com>
Cc:     dvyukov@google.com, hpa@zytor.com, jmattson@google.com,
        karahmed@amazon.de, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: WARNING in free_loaded_vmcs (2)
Message-ID: <20190401191650.GB24070@linux.intel.com>
References: <000000000000b239d705736497a3@google.com>
 <000000000000b0ddb205855cad54@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000b0ddb205855cad54@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 09:53:01PM -0700, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 8fcc4b5923af5de58b80b53a069453b135693304
> Author: Jim Mattson <jmattson@google.com>
> Date:   Tue Jul 10 09:27:20 2018 +0000
> 
>     kvm: nVMX: Introduce KVM_CAP_NESTED_STATE
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17fba63f200000
> start commit:   60c1f892 Merge tag 'dma-mapping-4.19-2' of git://git.infra..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1407a63f200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1007a63f200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4c7e83258d6e0156
> dashboard link: https://syzkaller.appspot.com/bug?extid=01bc9e7a8a3f138b71cf
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a6513e400000
> 
> Reported-by: syzbot+01bc9e7a8a3f138b71cf@syzkaller.appspotmail.com
> Fixes: 8fcc4b5923af ("kvm: nVMX: Introduce KVM_CAP_NESTED_STATE")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Blech, this is horribly stale.  Fixed by commit 5bea5123cbf0 ("KVM: VMX:
check nested state and CR4.VMXE against SMM").

#syz fix: KVM: VMX: check nested state and CR4.VMXE against SMM
