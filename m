Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CA1C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 16:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AB72173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 16:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="lh1neXWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388106AbfGPQ4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 12:56:44 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41976 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbfGPQ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 12:56:44 -0400
Received: by mail-qk1-f195.google.com with SMTP id v22so15132312qkj.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 09:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Lzzb/85EG5OgOgZivNuRXqXu1x2wo0l3U6fbMwd+XY=;
        b=lh1neXWXugGNV0dD3EYhMNUpg7DZEDvz1t0tPOAnKx+unFKLPJPHDaTqfhAhJrO1ZH
         mNDj0YIw9TasLeLCzxrWbrrpvlNFANnKcnhW+RYEYFz1veXLvn464WK7Uldc+ROkhHU6
         gdElKf2YCz/I9fx4lW976vyQZemYOJOs0W/FJt9XWP/+Uk3iHkG2NaYBcvmDvF9L/Gcb
         lylbDHe/GsntFtMCjRbO98XFP4ShcUE2rJZKzH53KEv7x85o17zAKq89GXy3kTt5A9Lb
         K4rqNY0m41+yBjl4R+5BymQAPQSDBNeOFvlftEQZd4uTQfNuhWaPVVfcdvQzOPmWX6Lg
         POrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Lzzb/85EG5OgOgZivNuRXqXu1x2wo0l3U6fbMwd+XY=;
        b=g/OC+J3krw2NFVibpwVGLQ/P6TX9nVBEcMsAFd3il6oIZE+9dgq2Ru2p93kOeGO83l
         LaI06Gkt63SayQfMOiqZfLMp+k0Ga1regah3XZXWWR+WymVdoeEbH9U+JzWErr2462IS
         aikytZVOu/6RCpYSnRwMOTz5yDVPi6eRwLWPw9rVmfZxZP9/mccmTt2juxfQ3+ok4aVd
         vbtMlAnLN3JIIiK4NKnzYWpjXKR+NVVrtoCV6P2e/f1Vxy+/OpjMmkgg5/iahSeAyN3m
         7vAFH/4hk+PXaoEJG0SgHIGsg+R2m3mVEyksliKmM7DvO4qqWf4NOm+YZp13EFPNvGBJ
         ktxQ==
X-Gm-Message-State: APjAAAVSPR7eHWEzC3mpJ+FlmLZJ6fw0gr3jeonUll64rqPO1gBkvyL2
        fasNCn88ibz0IiSEeMTr9Rs=
X-Google-Smtp-Source: APXvYqz9+3MPpBLc2mmfXv0e2ASGs2pqg3VhykHLyEYnWb9ZZDcdSJoSxY9+HqM4r5uxzR7M4+5VFA==
X-Received: by 2002:a37:c20a:: with SMTP id i10mr20823361qkm.76.1563296202999;
        Tue, 16 Jul 2019 09:56:42 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id f20sm8519538qkh.15.2019.07.16.09.56.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 09:56:42 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC v1 0/4] arm64: MMU enabled kexec kernel relocation
Date:   Tue, 16 Jul 2019 12:56:37 -0400
Message-Id: <20190716165641.6990-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added identity mapped page table, and keep MMU enabled while
kernel is being relocated from sparse pages to the final
destination during kexec.

More description about the problem I am trying to solve here, can be
found here:
https://lore.kernel.org/lkml/20190709182014.16052-1-pasha.tatashin@soleen.com/

This patch series works in terms, that I can kexec-reboot both in QEMU
and on a physical machine. However, I do not see performance improvement
during relocation. The performance is just as slow as before with disabled
caches.

Am I missing something? Perhaps, there is some flag that I should also
enable in page table? Please provide me with any suggestions.

Pavel Tatashin (4):
  arm64, mm: identity mapped page table
  arm64, kexec: interface preparation for mmu enabled kexec
  arm64, kexec: add kexec's own identity page table
  arm64: Keep MMU on while kernel is being relocated

 arch/arm64/include/asm/ident_map.h  |  26 ++++++
 arch/arm64/include/asm/kexec.h      |   5 +-
 arch/arm64/kernel/cpu-reset.S       |   8 --
 arch/arm64/kernel/cpu-reset.h       |   7 +-
 arch/arm64/kernel/machine_kexec.c   | 128 +++++++++++++++++++++-------
 arch/arm64/kernel/relocate_kernel.S |  36 +++++---
 arch/arm64/mm/Makefile              |   1 +
 arch/arm64/mm/ident_map.c           |  99 +++++++++++++++++++++
 8 files changed, 255 insertions(+), 55 deletions(-)
 create mode 100644 arch/arm64/include/asm/ident_map.h
 create mode 100644 arch/arm64/mm/ident_map.c

-- 
2.22.0

