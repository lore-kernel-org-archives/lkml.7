Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFF1C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFF7205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ARRkitV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfEGRXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:23:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45686 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfEGRXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:23:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id r76so3978593lja.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=u1BdfLbHAFQuPdTVB1WpvhAvzRrkkmJNUU8PH36DDjI=;
        b=ARRkitV0i38mi6ZYOWCQaRHdnDGOk/yUclCi0dkSPC291twr3CC18Z4lvRh/wlcRdY
         5IevgfijwFnUWyObhxfleMfJ7z8CZs7ChXp6CpA6Jnm+j6evE3dIXWlsvBdTuoyIkm84
         grqurOh7AGpkmWtonVe7Us5hW1YR+VgTiYIpKbz2HfVG6LekZr+aCK0lnN8mc4C0E8aX
         lC/9BZ8LGTsfhdq/vVNlmmzM17VjGQdNMKScGCt7pzgwUfOx6+LqIzemWw7lILOPGG7B
         yow36NzfOPHB8rGxzuJyMlob0yDov1nO8gv9w3pcCAp5eQr4xx8CtWI7v2cSD+9alYbf
         Q7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=u1BdfLbHAFQuPdTVB1WpvhAvzRrkkmJNUU8PH36DDjI=;
        b=fjWb1/DaIPrrahaRPR6lM9bFXBFl/IInpyVCf0gP90906VkWJ4CSE5niQk/w/OePLl
         ZDQ4aaXH3GHQ+R6Tw8JZCont/znVzLeWKp9ltL9KHQkDVBS9evk8HNnFnQhEW95/MrjS
         GsxXeC6mGd6Jpat8EBcoIvddRtWbfjuHzCawxOMfXx3ZIU2Sf2EU91HasH8AS0sM7IsN
         d7fDsUiliorz+aZI3Ng2dQucBsDQaDB43VWPExGeJFaCh/Bj7Fyy8USpCX/fHUYAvjRU
         AzAbG5NH8FbbO3wQc5i+M9spNz/5rK7si7jRwlG1hSfC0oJJV12igsCfhy1l+DBvToYX
         p2/Q==
X-Gm-Message-State: APjAAAU7Do4YpWscc8MnfGtYjnubHXMzC4K/JnWvCjfTvt+W2zj2BlnT
        pbp64/a77EwDAOlfrQM9h1KU8l7NNHvA3+da5OKg
X-Google-Smtp-Source: APXvYqytjtDNglgXvF6NDMnQSfRPy3x8pQ+7EN589dt1d0roPS0kOWlTbsE2cw5bGycgpVEYD5HHtlDqwm9tPvucuME=
X-Received: by 2002:a2e:9d0a:: with SMTP id t10mr3155031lji.95.1557249796468;
 Tue, 07 May 2019 10:23:16 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 7 May 2019 13:23:05 -0400
Message-ID: <CAHC9VhQ8aEqiKo6oj8-qMTzbs73ipEbTf5akENYc-m6xg7JRXg@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v5.2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

We've got a reasonably broad set of audit patches for the v5.2 merge
window, the highlights are below:

- The biggest change, and the source of all the arch/* changes, is the
patchset from Dmitry to help enable some of the work he is doing
around PTRACE_GET_SYSCALL_INFO.  To be honest, including this in the
audit tree is a bit of a stretch, but it does help move audit a little
further along towards proper syscall auditing for all arches, and
everyone else seemed to agree that audit was a "good" spot for this to
land (or maybe they just didn't want to merge it?  dunno.).

- We can now audit time/NTP adjustments.

- We continue the work to connect associated audit records into a single event.

As a FYI, you will likely run into two minor merge problems in
kernel/seccomp.c and arch/mips/kernel/ptrace.c; both are very similar
and have to do with the change to syscall_get_arch() and
syscall_get_arguments().  It should be easy to sort this out (you'll
see what I mean), but if you have any questions just let us know.

Please pull this for v5.2,
-Paul

--
The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

 Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20190507

for you to fetch changes up to 70c4cf17e445264453bc5323db3e50aa0ac9e81f:

 audit: fix a memory leak bug (2019-04-22 11:22:03 -0400)

----------------------------------------------------------------
audit/stable-5.2 PR 20190507

----------------------------------------------------------------
Dmitry V. Levin (13):
     Move EM_ARCOMPACT and EM_ARCV2 to uapi/linux/elf-em.h
     arc: define syscall_get_arch()
     c6x: define syscall_get_arch()
     h8300: define syscall_get_arch()
     Move EM_HEXAGON to uapi/linux/elf-em.h
     hexagon: define syscall_get_arch()
     m68k: define syscall_get_arch()
     Move EM_NDS32 to uapi/linux/elf-em.h
     nds32: define syscall_get_arch()
     nios2: define syscall_get_arch()
     Move EM_UNICORE to uapi/linux/elf-em.h
     unicore32: define syscall_get_arch()
     syscall_get_arch: add "struct task_struct *" argument

Li RongQing (1):
     audit: fix a memleak caused by auditing load module

Ondrej Mosnacek (2):
     timekeeping: Audit clock adjustments
     ntp: Audit NTP parameters adjustment

Richard Guy Briggs (3):
     audit: connect LOGIN record to its syscall record
     audit: link integrity evm_write_xattrs record to syscall event
     audit: purge unnecessary list_empty calls

Wenwen Wang (1):
     audit: fix a memory leak bug

YueHaibing (1):
     audit: Make audit_log_cap and audit_copy_inode static

arch/alpha/include/asm/syscall.h      |   2 +-
arch/arc/include/asm/elf.h            |   6 +-
arch/arc/include/asm/syscall.h        |  11 ++++
arch/arm/include/asm/syscall.h        |   2 +-
arch/arm64/include/asm/syscall.h      |   4 +-
arch/c6x/include/asm/syscall.h        |   7 +++
arch/csky/include/asm/syscall.h       |   2 +-
arch/h8300/include/asm/syscall.h      |   6 ++
arch/hexagon/include/asm/elf.h        |   6 +-
arch/hexagon/include/asm/syscall.h    |   8 +++
arch/ia64/include/asm/syscall.h       |   2 +-
arch/m68k/include/asm/syscall.h       |  12 ++++
arch/microblaze/include/asm/syscall.h |   2 +-
arch/mips/include/asm/syscall.h       |   6 +-
arch/mips/kernel/ptrace.c             |   2 +-
arch/nds32/include/asm/elf.h          |   3 +-
arch/nds32/include/asm/syscall.h      |   9 +++
arch/nios2/include/asm/syscall.h      |   6 ++
arch/openrisc/include/asm/syscall.h   |   2 +-
arch/parisc/include/asm/syscall.h     |   4 +-
arch/powerpc/include/asm/syscall.h    |  10 ++-
arch/riscv/include/asm/syscall.h      |   2 +-
arch/s390/include/asm/syscall.h       |   4 +-
arch/sh/include/asm/syscall_32.h      |   2 +-
arch/sh/include/asm/syscall_64.h      |   2 +-
arch/sparc/include/asm/syscall.h      |   5 +-
arch/unicore32/include/asm/elf.h      |   3 +-
arch/unicore32/include/asm/syscall.h  |  12 ++++
arch/x86/include/asm/syscall.h        |   8 ++-
arch/x86/um/asm/syscall.h             |   2 +-
arch/xtensa/include/asm/syscall.h     |   2 +-
include/asm-generic/syscall.h         |   5 +-
include/linux/audit.h                 |  75 +++++++++++++++++++++++
include/uapi/linux/audit.h            |  14 +++++
include/uapi/linux/elf-em.h           |   6 ++
kernel/audit.c                        |   2 +-
kernel/auditfilter.c                  |  14 ++---
kernel/auditsc.c                      | 115 +++++++++++++++++++++------------
kernel/seccomp.c                      |   4 +-
kernel/time/ntp.c                     |  22 ++++++-
kernel/time/ntp_internal.h            |   4 +-
kernel/time/timekeeping.c             |  13 +++-
security/integrity/evm/evm_secfs.c    |  10 +--
43 files changed, 331 insertions(+), 107 deletions(-)
create mode 100644 arch/m68k/include/asm/syscall.h
create mode 100644 arch/unicore32/include/asm/syscall.h

-- 
paul moore
www.paul-moore.com
