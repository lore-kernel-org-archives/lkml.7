Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F66AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3CC02075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfCKJhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:37:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbfCKJhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:37:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D0F77C057F3C;
        Mon, 11 Mar 2019 09:37:14 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C95C05D705;
        Mon, 11 Mar 2019 09:37:02 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        kvm@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>, linux-mm@kvack.org,
        Marty McFadden <mcfadden8@llnl.gov>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-fsdevel@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/3] userfaultfd: allow to forbid unprivileged users
Date:   Mon, 11 Mar 2019 17:36:58 +0800
Message-Id: <20190311093701.15734-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 11 Mar 2019 09:37:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(The idea comes from Andrea, and following discussions with Mike and
 other people)

This patchset introduces a new sysctl flag to allow the admin to
forbid users from using userfaultfd:

  $ cat /proc/sys/vm/unprivileged_userfaultfd
  [disabled] enabled kvm

  - When set to "disabled", all unprivileged users are forbidden to
    use userfaultfd syscalls.

  - When set to "enabled", all users are allowed to use userfaultfd
    syscalls.

  - When set to "kvm", all unprivileged users are forbidden to use the
    userfaultfd syscalls, except the user who has permission to open
    /dev/kvm.

This new flag can add one more layer of security to reduce the attack
surface of the kernel by abusing userfaultfd.  Here we grant the
thread userfaultfd permission by checking against CAP_SYS_PTRACE
capability.  By default, the value is "disabled" which is the most
strict policy.  Distributions can have their own perferred value.

The "kvm" entry is a bit special here only to make sure that existing
users like QEMU/KVM won't break by this newly introduced flag.  What
we need to do is simply set the "unprivileged_userfaultfd" flag to
"kvm" here to automatically grant userfaultfd permission for processes
like QEMU/KVM without extra code to tweak these flags in the admin
code.

Patch 1:  The interface patch to introduce the flag

Patch 2:  The KVM related changes to detect opening of /dev/kvm

Patch 3:  Apply the flag to userfaultfd syscalls

All comments would be greatly welcomed.  Thanks,

Peter Xu (3):
  userfaultfd/sysctl: introduce unprivileged_userfaultfd
  kvm/mm: introduce MMF_USERFAULTFD_ALLOW flag
  userfaultfd: apply unprivileged_userfaultfd check

 fs/userfaultfd.c               | 121 +++++++++++++++++++++++++++++++++
 include/linux/sched/coredump.h |   1 +
 include/linux/userfaultfd_k.h  |   5 ++
 init/Kconfig                   |  11 +++
 kernel/sysctl.c                |  11 +++
 virt/kvm/kvm_main.c            |   7 ++
 6 files changed, 156 insertions(+)

-- 
2.17.1

