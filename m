Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352A5C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 20:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC4420692
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 20:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfZcs/S7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfINUbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 16:31:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40526 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfINUbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 16:31:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id l3so12432649wru.7;
        Sat, 14 Sep 2019 13:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=zmjqwoEujswmzOMWnrm7/sgwjAMLZkcd4FdRC15UyXQ=;
        b=XfZcs/S7s6Wkz+SP+k7XiOOcO3Ob7J+ME8H3ClAbfpUsOlk+7e+XmJoYJ90uymJLBG
         E6AoEGjZO28yWGhXnXrbo58MzCaKJeSCPiGvuYX1S4m4A+lr0HvC345t2whx0TInLmDY
         c0weyaoKtdWTy/R4TVOWJEnty8CJIci3DE/GkN0bxFz7XMAHGh4SjaYSlxK4f/SrnmF3
         G7wrLvV/65X3YUqhHO/jXOaT9IdTyCjLc8aJzBHhqjp95xkE1b17hEsBMScePyIY0rmq
         3u5o9rtpLwhn7Cbwzzg0dAxfB9t7XtxoMDT2XydW+QiNgrpTRACNWOVwn7c2trTgSMLO
         SZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=zmjqwoEujswmzOMWnrm7/sgwjAMLZkcd4FdRC15UyXQ=;
        b=HsjSC3mywkQurikIN+yMdZz2x056gUZU7x5Ug0NIwqKvg9GReJV58ICF9yA0LwcDt5
         cWhMvLpYCbMhH2EGGmkWIj1d4DR6EgB2Fwumfka192FIIn4Ld71PLGKh6eGAPWn2xyLD
         5mJhKSkEeQB+Gp4knIl6CukxvgMVRb/W0UNb1itILuVyDIZhpWicp8eooJ9cjPLmlHUH
         2RbDHBOS5CebnLUb5axqdbCYiVSahjxu2EZSlSnjf3J6BY5q7p/5Lbf87Tfu4YWBl/6o
         db4+1sth+2JuydQp67OAYLj1CKwGKrLwz7mMwLXQCBWT7BgA/qy1jlJe5GRw1hTqrDbL
         v63A==
X-Gm-Message-State: APjAAAUMR39bWh5UVkt+qiR3LZ1W6IdwhFCO2Oepuv3D9yddI6BAdzs9
        +4oQISLDh8WNclthNU66epkvVI2e
X-Google-Smtp-Source: APXvYqzfMRYOJEbOogXLihWhheBsIKNRktkWoeiG2QV8DfVt0dnArXXm7xWZCRmkHxUocGYnQZok9g==
X-Received: by 2002:a5d:6b0b:: with SMTP id v11mr41860769wrw.10.1568493109388;
        Sat, 14 Sep 2019 13:31:49 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id h17sm12126785wme.6.2019.09.14.13.31.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Sep 2019 13:31:48 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, rkrcmar@redhat.com,
        kvm@vger.kernel.org
Subject: [GIT PULL] Final batch of KVM changes for Linux 5.3.
Date:   Sat, 14 Sep 2019 22:31:41 +0200
Message-Id: <1568493101-32728-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit a7f89616b7376495424f682b6086e0c391a89a1d:

  Merge branch 'for-5.3-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup (2019-09-13 09:52:01 +0100)

are available in the git repository at:


  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to a9c20bb0206ae9384bd470a6832dd8913730add9:

  Merge tag 'kvm-s390-master-5.3-1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into kvm-master (2019-09-14 09:25:30 +0200)

----------------------------------------------------------------

The main change here is a revert of reverts.  We recently simplified some
code that was thought unnecessary; however, since then KVM has grown quite
a few cond_resched()s and for that reason the simplified code is prone to
livelocks---one CPUs tries to empty a list of guest page tables while the
others keep adding to them.  This adds back the generation-based zapping of
guest page tables, which was not unnecessary after all.

On top of this, there is a fix for a kernel memory leak and a couple of
s390 fixlets as well.

----------------------------------------------------------------
Fuqian Huang (1):
      KVM: x86: work around leak of uninitialized stack contents

Igor Mammedov (1):
      KVM: s390: kvm_s390_vm_start_migration: check dirty_bitmap before using it as target for memset()

Paolo Bonzini (2):
      KVM: nVMX: handle page fault in vmread
      Merge tag 'kvm-s390-master-5.3-1' of git://git.kernel.org/.../kvms390/linux into kvm-master

Sean Christopherson (1):
      KVM: x86/mmu: Reintroduce fast invalidate/zap for flushing memslot

Thomas Huth (1):
      KVM: s390: Do not leak kernel stack data in the KVM_S390_INTERRUPT ioctl

 arch/s390/kvm/interrupt.c       |  10 ++++
 arch/s390/kvm/kvm-s390.c        |   4 +-
 arch/x86/include/asm/kvm_host.h |   2 +
 arch/x86/kvm/mmu.c              | 101 +++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/vmx/nested.c       |   4 +-
 arch/x86/kvm/x86.c              |   7 +++
 6 files changed, 124 insertions(+), 4 deletions(-)
