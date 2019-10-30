Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1659ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 03:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D982087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 03:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdCkPyBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfJ3Dz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 23:55:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40571 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726747AbfJ3Dz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 23:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572407724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/Osp18ZGaauicuQBN22/VVW26zqOBdrsyRolzW/ayRA=;
        b=DdCkPyBOEyZdHS64jybtYkAC8190FdTBNujvnXeA+MDRv7veMLg9FFl0ag7uq+4YeGmZpA
        YUHGgcKnhxvLw9xCJ3j3Fir85gNBIlmsnSdOw5APeJ/c6yGDKfpW61L+LgbfY0xTnAKNwA
        6AVqKrS/dsieamJkjMEGX1c62l368qk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-8gycuxj4Pja867KQWqeJ-Q-1; Tue, 29 Oct 2019 23:55:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F3BB1005500;
        Wed, 30 Oct 2019 03:55:19 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A9DA60C4B;
        Wed, 30 Oct 2019 03:55:06 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, bhe@redhat.com, dyoung@redhat.com, jgross@suse.com,
        dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, d.hatayama@fujitsu.com,
        horms@verge.net.au, kexec@lists.infradead.org
Subject: [PATCH 0/2 v8] x86/kdump: Fix 'kmem -s' reported an invalid freepointer when SME was active
Date:   Wed, 30 Oct 2019 11:54:59 +0800
Message-Id: <20191030035501.23713-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 8gycuxj4Pja867KQWqeJ-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
active(https://bugzilla.kernel.org/show_bug.cgi?id=3D204793).

The low 1M region will always be reserved when the crashkernel kernel
command line option is specified. And this way makes it unnecessary to
do anything with the low 1M region, because the memory allocated later
won't fall into the low 1M area.

This series includes two patches:
[1] x86/kdump: always reserve the low 1M when the crashkernel option
    is specified
    The low 1M region will always be reserved when the crashkernel
    kernel command line option is specified, which ensures that the
    memory allocated later won't fall into the low 1M area.

[2] x86/kdump: clean up all the code related to the backup region
    Remove the backup region and clean up.

Changes since v1:
[1] Add extra checking condition: when the crashkernel option is
    specified, reserve the low 640k area.

Changes since v2:
[1] Reserve the low 1M region when the crashkernel option is only
    specified.(Suggested by Eric)

[2] Remove the unused crash_copy_backup_region()

[3] Remove the backup region and clean up

[4] Split them into three patches

Changes since v3:
[1] Improve the first patch's log

[2] Improve the third patch based on Eric's suggestions

Changes since v4:
[1] Correct some typos, and also improve the first patch's log

[2] Add a new function kexec_reserve_low_1MiB() in kernel/kexec_core.c
    and which is called by reserve_real_mode(). (Suggested by Boris)

Changes since v5:
[1] Call the cmdline_find_option() instead of strstr() to check the
    crashkernel option. (Suggested by Hatayama)

[2] Add a weak function kexec_reserve_low_1MiB() in kernel/kexec_core.c,
    and implement the kexec_reserve_low_1MiB() in arch/x86/kernel/
    machine_kexec_64.c so that it does not cause the compile error
    on non-x86 kernel, and also ensures that it can work well on x86
    kernel.

Changes since v6:
[1] Move the kexec_reserve_low_1MiB() to arch/x86/kernel/crash.c and
    also move its declaration function to arch/x86/include/asm/crash.h
    (Suggested by Dave Young)

[2] Adjust the corresponding header files.

Changes since v7:
[1] Change the function name from kexec_reserve_low_1MiB() to
    crash_reserve_low_1M().

Lianbo Jiang (2):
  x86/kdump: always reserve the low 1M when the crashkernel option is
    specified
  x86/kdump: clean up all the code related to the backup region

 arch/x86/include/asm/crash.h       |   6 ++
 arch/x86/include/asm/kexec.h       |  10 ---
 arch/x86/include/asm/purgatory.h   |  10 ---
 arch/x86/kernel/crash.c            | 102 ++++++++---------------------
 arch/x86/kernel/machine_kexec_64.c |  47 -------------
 arch/x86/purgatory/purgatory.c     |  19 ------
 arch/x86/realmode/init.c           |   2 +
 7 files changed, 34 insertions(+), 162 deletions(-)

--=20
2.17.1

