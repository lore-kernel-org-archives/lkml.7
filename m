Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7134EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47EDA205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfCSDHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 23:07:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbfCSDHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 23:07:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0353A308425C;
        Tue, 19 Mar 2019 03:07:36 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85F6A5D707;
        Tue, 19 Mar 2019 03:07:23 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>, linux-mm@kvack.org,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/1] userfaultfd: allow to forbid unprivileged users
Date:   Tue, 19 Mar 2019 11:07:21 +0800
Message-Id: <20190319030722.12441-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 19 Mar 2019 03:07:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the second version of the work.  V1 was here:

https://lkml.org/lkml/2019/3/11/207

I removed CC to kvm list since not necessary any more, but added
linux-api to the list as suggested by Kirill.

This one greatly simplifies the previous version, dropped the kvm
special entry and mimic the sysctl_unprivileged_bpf_disabled knob for
userfaultfd as suggested by many.  The major differences comparing to
the BPF flag are: (1) use PTRACE instead of ADMIN capability, and (2)
allow to switch the flag back and forth (BPF does not allow to switch
back to "enabled" if "disabled" once).

So the main idea of this simpler version is that we still keep the old
way as is by default but we only provide a way for admins when they
really want to turn userfaultfd off for unprivileged users.

About procfs vs sysfs: I still used the procfs way because admins can
still leverage sysctl.conf with that and also since no one yet
explicitly asked for sysfs for a better reason yet (And I just noticed
BPF just added another bpf_stats_enabled into sysctl a few weeks ago).

Please have a look, thanks.

Peter Xu (1):
  userfaultfd/sysctl: add vm.unprivileged_userfaultfd

 Documentation/sysctl/vm.txt   | 12 ++++++++++++
 fs/userfaultfd.c              |  5 +++++
 include/linux/userfaultfd_k.h |  2 ++
 kernel/sysctl.c               | 12 ++++++++++++
 4 files changed, 31 insertions(+)

-- 
2.17.1

