Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E834CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25662075A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gvCCbLOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389631AbfJVXDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 19:03:12 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:40828 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730034AbfJVXDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 19:03:12 -0400
Received: by mail-il1-f195.google.com with SMTP id d83so8600052ilk.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 16:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=FCNSpvhucdslU4xdhlUj1eji96TKzrd4QEx7zlNJdXU=;
        b=gvCCbLOIKWTljdF4xlr9PMDzTM+XPkwYupgcnkTFkWUWvEOvNUNgBK3weffnZMZNn+
         Ghs0fgjmCqPEoAg8e3W7Ff4o4zsQECeZTGFDRd83PgGZuD/lZsaPWQzEb/f0d/rfvfPo
         a/1i3Las7Uz/UnynRVaTZEl4Qbaob6K41EbYxjD0Y3pZeWTXnZc4GSEWHEHWBHxuYMsh
         33ONw0DyDd0kEJf/T+f7G1tvAvQw7SXOHR7jxmAf/63pVXIxTuBA5rE2jn3eH76CVJVi
         F5bJcvR4qUCI1RUGpPFU9GnXtVwAnIjmbBiGPtpxLG1kbPcKx5Vcjg92d5NBp4pdBqvt
         F2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=FCNSpvhucdslU4xdhlUj1eji96TKzrd4QEx7zlNJdXU=;
        b=cbe0tPJaBFKV0gKSwGQg54M3Th6Yg44N7xXXtLvJcDP8+B7/5irfVQ0ZledVbu8unf
         3i6HUjF4jfn996QMAsmJMtF+egGgYzVFVGtsPgspL26TsgbLkzsoFlcsIytA7V4VCVwc
         Ne1TL3WE3RExvWgLRpi+E0HkWjUrQF81KofzrH5A3vvP7AV8WSEarsvYDS3KXqZUrbBu
         EZiWLTrSUMvG3wKduiiClPzFD3xx4isWzW0+z1aS4FhQEa09MYQoFmtjeQgBgAzGfhcY
         aL5NvncPf2gHnfxDYkqYAyfWFP3tr+/nfEAiOOWMn+du2+U32C3PFJkEmXmbf/gyHqjL
         bjHQ==
X-Gm-Message-State: APjAAAX5HlirtxDBXAep24cH7l599dcNv87PMHIt9Mo8uBZYvwjjT3oR
        cNj3xHSF9/viubqeJIFqog/DsQ==
X-Google-Smtp-Source: APXvYqx5+7e2i1TygQBtYul2CZ+dTQLBLh4OyjITtN3933T1jRnJPAzZcgf6MWL1RshfohIFNIyYzQ==
X-Received: by 2002:a92:b00f:: with SMTP id x15mr11505916ilh.280.1571785391511;
        Tue, 22 Oct 2019 16:03:11 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id y5sm3011061ioa.13.2019.10.22.16.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 16:03:10 -0700 (PDT)
Date:   Tue, 22 Oct 2019 16:03:08 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     torvalds@linux-foundation.org
cc:     keescook@chromium.org, david.abdurachmanov@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V SECCOMP support for v5.4-rc5
Message-ID: <alpine.DEB.2.21.9999.1910221600320.25457@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 5bf4e52ff0317db083fafee010dc806f8d4cb0cb:

  RISC-V: fix virtual address overlapped in FIXADDR_START and VMEMMAP_START (2019-10-15 22:47:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.4-rc5

for you to fetch changes up to 7326fcbeea619b95c9b380ddee0a94f5f9ea6a48:

  riscv: add support for SECCOMP and SECCOMP_FILTER (2019-10-16 08:27:25 -0700)

----------------------------------------------------------------
RISC-V SECCOMP support for v5.4-rc5

This pull request contains a single change: the addition of SECCOMP
support for RISC-V for v5.4-rc5.  Normally, I'd consider this too
large for this point in the -rc releases.  However, we've heard that
v5.4 is likely to be a long-term support release, and adding it in now
should help the distribution and security folks.  The changes look
relatively bounded, and the only reason we've been sitting on it until
now is because we've been waiting for a trivial ack from the
tools/testing maintainer.  That hasn't come.  Since the change to that
subsystem is quite minor, we think it should be OK with her, so,
sending it now.

If you have a different opinion about whether this patch should go in
now, we're fine with requeuing it for v5.5-rc1.

----------------------------------------------------------------
David Abdurachmanov (1):
      riscv: add support for SECCOMP and SECCOMP_FILTER

 arch/riscv/Kconfig                            | 14 ++++++++++++++
 arch/riscv/include/asm/seccomp.h              | 10 ++++++++++
 arch/riscv/include/asm/thread_info.h          |  5 ++++-
 arch/riscv/kernel/entry.S                     | 27 +++++++++++++++++++++++++--
 arch/riscv/kernel/ptrace.c                    | 10 ++++++++++
 tools/testing/selftests/seccomp/seccomp_bpf.c |  8 +++++++-
 6 files changed, 70 insertions(+), 4 deletions(-)
 create mode 100644 arch/riscv/include/asm/seccomp.h
