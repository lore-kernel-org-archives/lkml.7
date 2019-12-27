Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97D5C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 16:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC5020CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 16:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577464581;
	bh=saOyowJ7uyY9gUuA6lkNUqoCxJUMqAWkV+VrH02LNAw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hQibpDxYSnw+wBeX1gYwDth5aKYiIetCG9GwW3o5YuoCAqwf3SoYLtJ02MaRwSuCD
	 D82Z1bsXRHdwqZfP+YfMkLOp292G4ZpaAkayrUvDRP+Q+XUuKHf3t3TZkpRLf8tejG
	 YPtfu6zY6/L3BTJizLdi1S5mLIPH7kncHxUAnV9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfL0QgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 11:36:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfL0QgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 11:36:20 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F2B1208C4;
        Fri, 27 Dec 2019 16:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577464579;
        bh=saOyowJ7uyY9gUuA6lkNUqoCxJUMqAWkV+VrH02LNAw=;
        h=From:To:Cc:Subject:Date:From;
        b=Wa3bfY+Gsu9wIHH2naA7mjTeUGL36HKsu1ayiq7zYYeHa9GBX7+y4ADhJAoxCSK1T
         YtZ/+r2PlMhx/578rf84OpGHQ4kNTcpe+CF1QrGHvfyhboLqu2r2rpyLQxCLuVhQBy
         T4GnwdqEv3J94Zch5nJUpHwGkXinrA2pw4qjTOZ0=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH 0/2] x86/context-tracking: Remove last remaining calls to exception_enter/exception_exit()
Date:   Fri, 27 Dec 2019 17:36:10 +0100
Message-Id: <20191227163612.10039-1-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to the cleanups from Andy Lutomirski over the years, those calls
can now be removed. This will allow for nice things in the future for
x86 support on full nohz:

* Remove TIF_NOHZ and use a per-cpu switch to enable, disable context
  tracking.

* Avoid context tracking on housekeepers.

* Dynamically enable/disable context tracking on CPU on runtime and
  therefore allow runtime enable/disable of nohz_full

* Make nohz_full a property of cpuset.

Frederic Weisbecker (2):
  x86/context-tracking: Remove exception_enter/exit() from
    do_page_fault()
  x86/context-tracking: Remove exception_enter/exit() from
    KVM_PV_REASON_PAGE_NOT_PRESENT async page fault

 arch/x86/kernel/kvm.c |  4 ----
 arch/x86/mm/fault.c   | 39 ++++++++++++---------------------------
 2 files changed, 12 insertions(+), 31 deletions(-)

-- 
2.23.0

