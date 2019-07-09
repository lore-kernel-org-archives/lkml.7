Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA35C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3BB2080C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="nsdWBt1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfGISUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:20:19 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41921 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbfGISUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:20:17 -0400
Received: by mail-qk1-f194.google.com with SMTP id v22so16753591qkj.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 11:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=07lbMtNvRAMyX/POjVIPF1YJUTpi61TvrSJ6roJeVPs=;
        b=nsdWBt1+R1ve8tCsDIWPrNy0y/NCDmw+8vDsI/xQ0qqlV/ZxUzX4XqCrlGrImpvaxv
         bpKrt+60Fa3kB29M/KXQjapzKaDStgaZ7nQXw/WldmvXgddhp8rPPpJae/df0oZGQy4h
         gVHsFN7crraEJnzfrq/y9JWg5aTPEv1/kkAx1s6m3jHG5VIGRQWfIODhRs8AkBKyXXso
         fX4ZYxnGYoaxXW254flFRzCTVyUMDsXyUQPsr7UTYZJ683KQ/nPgb2LwR0NlJgTrhleL
         OVQ+4zEfOSArBal5dVyMakYw9h0xf4hFLt0LnHZ7Wi9shjUez3sbBFm0jzjbMZlB9NNl
         0NCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=07lbMtNvRAMyX/POjVIPF1YJUTpi61TvrSJ6roJeVPs=;
        b=nu+GtEv59dX/0nHh9VdXrg7/6TEDH3Twl9VGunlmpm4TVtj6ZofDfJzc03QpT3pE0t
         DevABdoxNVGejOHeEjSWuyOvWeMYun7vGkQZvU7xfLDYQM8q8Vv0i7yG0BxAjd+H9Bpa
         Z9783eVq5VMPCGmO5kfOsrdSepFfBuit9IVBEetnCgeWxXWmPpPQi9f5WsP5W8AzghR3
         beQr1eSjtEDp7z2euctuWrlOf5UiXeq5eMfuk+9IGAdHUjRhxGFuZsjLKC8LrwBZFXM+
         RwoGgfagJLCwoQ4g1WzIkCAvS7js3C3m4mDGFzuJIzc0tCO/TWMghjEBZILknf/oznVU
         PMug==
X-Gm-Message-State: APjAAAVRThCBzc9lai2PmXb6wemr1Rfk9p4g6xP2dxN29RYraUvht/KY
        YK7CUpWsuaaZDU1b59nr/XrNaw==
X-Google-Smtp-Source: APXvYqwZyzZlJCfnfaRBNAPrTgjGG/pRCaQYSyhIHt8cn7HXaH8O6U0lFii9rAJ8o1Oxephvp24BSQ==
X-Received: by 2002:a37:bf07:: with SMTP id p7mr19214845qkf.315.1562696416701;
        Tue, 09 Jul 2019 11:20:16 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id k123sm9113056qkf.13.2019.07.09.11.20.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 11:20:15 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [v2 0/5] arm64: allow to reserve memory for normal kexec kernel
Date:   Tue,  9 Jul 2019 14:20:09 -0400
Message-Id: <20190709182014.16052-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
v1 - v2
	- No changes to patches, addressed suggestion from James Morse
	  to add "arm64" tag to cover letter.
	- Improved cover letter information based on discussion.

Currently, it is only allowed to reserve memory for crash kernel, because
it is a requirement in order to be able to boot into crash kernel without
touching memory of crashed kernel is to have memory reserved.

The second benefit for having memory reserved for kexec kernel is
that it does not require a relocation after segments are loaded into
memory.

If kexec functionality is used for a fast system update, with a minimal
downtime, the relocation of kernel + initramfs might take a significant
portion of reboot.

In fact, on the machine that we are using, that has ARM64 processor
it takes 0.35s to relocate during kexec, thus taking 52% of kernel reboot
time:

kernel shutdown	0.03s
relocation	0.35s
kernel startup	0.29s

Image: 13M and initramfs is 24M. If initramfs increases, the relocation
time increases proportionally.

While, it is possible to add 'kexeckernel=' parameters support to other
architectures by modifying reserve_crashkernel(), in this series this is
done for arm64 only.

The reason it is so slow on arm64 to relocate kernel is because the code
that does relocation does this with MMU disabled, and thus D-Cache and
I-Cache must also be disabled.

Alternative solution is more complicated: Setup a temporary page table
for relocation_routine and also for code from cpu_soft_restart. Perform
relocation with MMU enabled, do cpu_soft_restart where MMU and caching
are disabled, jump to purgatory. A similar approach was suggested for
purgatory and was rejected due to making purgatory too complicated.
On, the other hand hibernate does something similar already, but there
MMU never needs to be disabled, and also by the time machine_kexec()
is called, allocator is not available, as we can't fail to do reboot,
so page table must be pre-allocated during kernel load time.

Note: the above time is relocation time only. Purgatory usually also
computes checksum, but that is skipped, because --no-check is used when
kernel image is loaded via kexec.

Pavel Tatashin (5):
  kexec: quiet down kexec reboot
  kexec: add resource for normal kexec region
  kexec: export common crashkernel/kexeckernel parser
  kexec: use reserved memory for normal kexec reboot
  arm64, kexec: reserve kexeckernel region

 .../admin-guide/kernel-parameters.txt         |  7 ++
 arch/arm64/kernel/setup.c                     |  5 ++
 arch/arm64/mm/init.c                          | 83 ++++++++++++-------
 include/linux/crash_core.h                    |  6 ++
 include/linux/ioport.h                        |  1 +
 include/linux/kexec.h                         |  6 +-
 kernel/crash_core.c                           | 27 +++---
 kernel/kexec_core.c                           | 50 +++++++----
 8 files changed, 127 insertions(+), 58 deletions(-)

-- 
2.22.0

