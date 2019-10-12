Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3B1C47404
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 02:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80334214E0
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 02:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfJLCV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 22:21:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbfJLCV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 22:21:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4CBF110C0930;
        Sat, 12 Oct 2019 02:21:56 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8115710018F8;
        Sat, 12 Oct 2019 02:21:45 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, bhe@redhat.com, dyoung@redhat.com, jgross@suse.com,
        dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, kexec@lists.infradead.org
Subject: [PATCH 0/3 v3] x86/kdump: Fix 'kmem -s' reported an invalid freepointer when SME was active
Date:   Sat, 12 Oct 2019 10:21:37 +0800
Message-Id: <20191012022140.19003-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Sat, 12 Oct 2019 02:21:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In purgatory(), the main things are as below:

[1] verify sha256 hashes for various segments.
    Lets keep these codes, and do not touch the logic.

[2] copy the first 640k content to a backup region.
    Lets safely remove it and clean all code related to backup region.

This patch series will remove the backup region, because the current
handling of copying the first 640k runs into problems when SME is
active.

The low 1MiB region will always be reserved when the crashkernel kernel
command line option is specified. And this way makes it unnecessary to
do anything with the low 1MiB region, because the memory allocated later
won't fall into the low 1MiB area.

This series includes three patches:
[1] Fix 'kmem -s' reported an invalid freepointer when SME was active
    The low 1MiB region will always be reserved when the crashkernel
    kernel command line option is specified, which ensures that the
    memory allocated later won't fall into the low 1MiB area.
    
[2] x86/kdump cleanup: remove the unused crash_copy_backup_region()
    The crash_copy_backup_region() has never been used, so clean
    up the redundant code.

[3] x86/kdump: clean up all the code related to the backup region
    Remove the backup region and clean up.

Changes since v1:
[1] Add extra checking condition: when the crashkernel option is
    specified, reserve the low 640k area.

Changes since v2:
[1] Reserve the low 1MiB region when the crashkernel option is only
    specified.(Suggested by Eric)

[2] Remove the unused crash_copy_backup_region()

[3] Remove the backup region and clean up

[4] Split them into three patches

Lianbo Jiang (3):
  x86/kdump: Fix 'kmem -s' reported an invalid freepointer when SME was
    active
  x86/kdump cleanup: remove the unused crash_copy_backup_region()
  x86/kdump: clean up all the code related to the backup region

 arch/x86/include/asm/crash.h       |  1 -
 arch/x86/include/asm/kexec.h       | 10 ----
 arch/x86/include/asm/purgatory.h   | 10 ----
 arch/x86/kernel/crash.c            | 91 ++++++------------------------
 arch/x86/kernel/machine_kexec_64.c | 47 ---------------
 arch/x86/purgatory/purgatory.c     | 19 -------
 arch/x86/realmode/init.c           | 11 ++++
 7 files changed, 27 insertions(+), 162 deletions(-)

-- 
2.17.1

