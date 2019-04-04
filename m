Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AB9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C55920693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfDDQpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:45:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727353AbfDDQpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:45:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED709308793A;
        Thu,  4 Apr 2019 16:45:05 +0000 (UTC)
Received: from treble.redhat.com (ovpn-125-158.rdu2.redhat.com [10.10.125.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EFE2608BB;
        Thu,  4 Apr 2019 16:44:58 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jon Masters <jcm@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH RFC 0/5] cpu/speculation: Add 'cpu_spec_mitigations=' cmdline options
Date:   Thu,  4 Apr 2019 11:44:10 -0500
Message-Id: <cover.1554396090.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 04 Apr 2019 16:45:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keeping track of the number of mitigations for all the CPU speculation
bugs has become overwhelming for many users.  It's getting more and more
complicated to decide which mitigations are needed for a given
architecture.  Complicating matters is the fact that each arch tends to
it own custom way to mitigate the same vulnerability.

Most users fall into a few basic categories:

a) they want all CPU speculation mitigations off;

b) they want all reasonable mitigations on, with SMT enabled even if
   it's vulnerable; or

c) they want all reasonable mitigations on, with SMT disabled if
   vulnerable.

Define a set of curated, arch-independent options, each of which is an
aggregation of existing options:

- cpu_spec_mitigations=off: Disable all mitigations.

- cpu_spec_mitigations=auto: [default] Enable all the default
  mitigations, but leave SMT enabled, even if it's vulnerable.

- cpu_spec_mitigations=auto,nosmt: Enable all the default mitigations,
  disabling SMT if needed by a mitigation.


Josh Poimboeuf (5):
  cpu/speculation: Add 'cpu_spec_mitigations=' cmdline options
  x86/speculation: Add support for 'cpu_spec_mitigations=' cmdline
    options
  powerpc/speculation: Add support for 'cpu_spec_mitigations=' cmdline
    options
  s390/speculation: Add support for 'cpu_spec_mitigations=' cmdline
    options
  arm64/speculation: Add support for 'cpu_spec_mitigations=' cmdline
    options

 .../admin-guide/kernel-parameters.txt         | 42 +++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c                |  4 ++
 arch/arm64/kernel/cpufeature.c                |  6 +++
 arch/powerpc/kernel/security.c                |  6 +--
 arch/powerpc/kernel/setup_64.c                |  2 +-
 arch/s390/kernel/nospec-branch.c              |  4 +-
 arch/x86/include/asm/processor.h              |  1 +
 arch/x86/kernel/cpu/bugs.c                    | 32 ++++++++++++--
 arch/x86/kvm/vmx/vmx.c                        |  2 +
 arch/x86/mm/pti.c                             |  4 +-
 include/linux/cpu.h                           |  8 ++++
 kernel/cpu.c                                  | 15 +++++++
 12 files changed, 116 insertions(+), 10 deletions(-)

-- 
2.17.2

