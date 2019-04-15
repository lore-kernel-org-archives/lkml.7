Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BB4C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7862087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfDOVVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:21:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42860 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbfDOVVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:21:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C348E374;
        Mon, 15 Apr 2019 14:21:35 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.29.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2F1723F68F;
        Mon, 15 Apr 2019 14:21:35 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, Dave.Martin@arm.com,
        shankerd@codeaurora.org, julien.thierry@arm.com,
        mlangsdo@redhat.com, stefan.wahren@i2se.com,
        Andre.Przywara@arm.com, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [v8 00/10] arm64: add system vulnerability sysfs entries
Date:   Mon, 15 Apr 2019 16:21:19 -0500
Message-Id: <20190415212129.1112-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm64 machines should be displaying a human readable
vulnerability status to speculative execution attacks in
/sys/devices/system/cpu/vulnerabilities 

This series enables that behavior by providing the expected
functions. Those functions expose the cpu errata and feature
states, as well as whether firmware is responding appropriately
to display the overall machine status. This means that in a
heterogeneous machine we will only claim the machine is mitigated
or safe if we are confident all booted cores are safe or
mitigated.

v7->v8: Fix latent build break when KVM_INDIRECT_VECTORS is not set.
	Revert v7 ssbd tristate back to default safe bool. Since
	       __ssb_safe should be reliable now, make overall print
	       more dependent on it.
	Tweak ssbd message to indicate prctl support.

v6->v7: Invert ssb white/black list logic so that we only mark
	       cores in the whitelist not affected when the firmware
	       fails to respond. Removed reviewed/tested tags for
	       just patch 9 because of this.

v5->v6:
	Invert meltdown logic to display that a core is safe rather
	       than mitigated if the mitigation has been enabled on
	       machines that are safe. This can happen when the
	       mitigation was forced on via command line or KASLR.
	       This means that in order to detect if kpti is enabled
	       other methods must be used (look at dmesg) when the
	       machine isn't itself susceptible to meltdown.
	Trivial whitespace tweaks.

Jeremy Linton (6):
  arm64: Provide a command line to disable spectre_v2 mitigation
  arm64: add sysfs vulnerability show for meltdown
  arm64: Always enable spectrev2 vulnerability detection
  arm64: add sysfs vulnerability show for spectre v2
  arm64: Always enable ssb vulnerability detection
  arm64: add sysfs vulnerability show for speculative store bypass

Marc Zyngier (2):
  arm64: Advertise mitigation of Spectre-v2, or lack thereof
  arm64: Use firmware to detect CPUs that are not affected by Spectre-v2

Mian Yousaf Kaukab (2):
  arm64: add sysfs vulnerability show for spectre v1
  arm64: enable generic CPU vulnerabilites support

 .../admin-guide/kernel-parameters.txt         |   8 +-
 arch/arm64/Kconfig                            |   1 +
 arch/arm64/include/asm/cpufeature.h           |   4 -
 arch/arm64/kernel/cpu_errata.c                | 249 +++++++++++++-----
 arch/arm64/kernel/cpufeature.c                |  58 +++-
 5 files changed, 232 insertions(+), 88 deletions(-)

-- 
2.20.1

