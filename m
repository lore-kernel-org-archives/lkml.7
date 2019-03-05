Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFECC00319
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FC32064A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfCES5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:57:05 -0500
Received: from namei.org ([65.99.196.166]:55540 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfCES5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:57:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x25Iv3ig020498;
        Tue, 5 Mar 2019 18:57:03 GMT
Date:   Wed, 6 Mar 2019 05:57:03 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] security subsystem changes for v5.1
Message-ID: <alpine.LRH.2.21.1903060540160.19551@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull these changes for the security subsystem.

Summary:

- Extend LSM stacking to allow sharing of cred, file, ipc, inode, and task 
blobs. This paves the way for more full-featured LSMs to be merged, and is 
specifically aimed at LandLock and SARA LSMs. This work is from Casey and 
Kees.

- There's a new LSM from Micah Morton: "SafeSetID gates the setid family 
of syscalls to restrict UID/GID transitions from a given UID/GID to only 
those approved by a system-wide whitelist."  This feature is currently 
shipping in ChromeOS.



---

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

for you to fetch changes up to 468e91cecb3218afd684b8c422490dfebe0691bb:

  keys: fix missing __user in KEYCTL_PKEY_QUERY (2019-03-04 15:48:37 -0800)

----------------------------------------------------------------
Ben Dooks (1):
      keys: fix missing __user in KEYCTL_PKEY_QUERY

Casey Schaufler (19):
      LSM: Add all exclusive LSMs to ordered initialization
      procfs: add smack subdir to attrs
      Smack: Abstract use of cred security blob
      SELinux: Abstract use of cred security blob
      SELinux: Remove cred security blob poisoning
      SELinux: Remove unused selinux_is_enabled
      AppArmor: Abstract use of cred security blob
      TOMOYO: Abstract use of cred security blob
      Infrastructure management of the cred security blob
      SELinux: Abstract use of file security blob
      Smack: Abstract use of file security blob
      LSM: Infrastructure management of the file security
      SELinux: Abstract use of inode security blob
      Smack: Abstract use of inode security blob
      LSM: Infrastructure management of the inode security
      LSM: Infrastructure management of the task security
      SELinux: Abstract use of ipc security blobs
      Smack: Abstract use of ipc security blobs
      LSM: Infrastructure management of the ipc security blob

Gustavo A. R. Silva (1):
      security: mark expected switch fall-throughs and add a missing break

James Morris (3):
      Merge tag 'v5.0-rc1' into next-general
      Merge tag 'blob-stacking-security-next' of https://git.kernel.org/.../kees/linux into next-general
      Merge tag 'v5.0-rc3' into next-general

Kees Cook (20):
      LSM: Introduce LSM_FLAG_LEGACY_MAJOR
      LSM: Provide separate ordered initialization
      LSM: Plumb visibility into optional "enabled" state
      LSM: Lift LSM selection out of individual LSMs
      LSM: Build ordered list of LSMs to initialize
      LSM: Introduce CONFIG_LSM
      LSM: Introduce "lsm=" for boottime LSM selection
      LSM: Tie enabling logic to presence in ordered list
      LSM: Prepare for reorganizing "security=" logic
      LSM: Refactor "security=" in terms of enable/disable
      LSM: Separate idea of "major" LSM from "exclusive" LSM
      apparmor: Remove SECURITY_APPARMOR_BOOTPARAM_VALUE
      selinux: Remove SECURITY_SELINUX_BOOTPARAM_VALUE
      LSM: Split LSM preparation from initialization
      LoadPin: Initialize as ordered LSM
      Yama: Initialize as ordered LSM
      LSM: Introduce enum lsm_order
      capability: Initialize as LSM_ORDER_FIRST
      TOMOYO: Update LSM flags to no longer be exclusive
      LSM: Ignore "security=" when "lsm=" is specified

Mathieu Malaterre (4):
      capabilities:: annotate implicit fall through
      security: keys: annotate implicit fall through
      security: keys: annotate implicit fall throughs
      security: keys: annotate implicit fall throughs

Micah Morton (8):
      LSM: generalize flag passing to security_capable
      LSM: add SafeSetID module that gates setid calls
      LSM: add SafeSetID module that gates setid calls
      LSM: Add 'name' field for SafeSetID in DEFINE_LSM
      LSM: SafeSetID: 'depend' on CONFIG_SECURITY
      LSM: SafeSetID: remove unused include
      LSM: SafeSetID: add selftest
      LSM: Update function documentation for cap_capable

Petr Vorel (1):
      LSM: Update list of SECURITYFS users in Kconfig

Tetsuo Handa (6):
      LSM: Make lsm_early_cred() and lsm_early_task() local functions.
      apparmor: Adjust offset when accessing task blob.
      tomoyo: Swicth from cred->security to task_struct->security.
      tomoyo: Coding style fix.
      tomoyo: Allow multiple use_group lines.
      tomoyo: Bump version.

Wei Yongjun (2):
      LSM: Make some functions static
      LSM: fix return value check in safesetid_init_securityfs()

 Documentation/admin-guide/LSM/SafeSetID.rst        | 107 ++++
 Documentation/admin-guide/LSM/index.rst            |  14 +-
 Documentation/admin-guide/kernel-parameters.txt    |  12 +-
 MAINTAINERS                                        |  11 +-
 fs/proc/base.c                                     |  64 +-
 fs/proc/internal.h                                 |   1 +
 include/linux/capability.h                         |   5 +
 include/linux/cred.h                               |   1 -
 include/linux/lsm_hooks.h                          |  45 +-
 include/linux/security.h                           |  43 +-
 include/linux/selinux.h                            |  35 --
 kernel/capability.c                                |  45 +-
 kernel/cred.c                                      |  13 -
 kernel/seccomp.c                                   |   4 +-
 kernel/sys.c                                       |  10 +-
 security/Kconfig                                   |  45 +-
 security/Makefile                                  |   2 +
 security/apparmor/Kconfig                          |  16 -
 security/apparmor/capability.c                     |  14 +-
 security/apparmor/domain.c                         |   4 +-
 security/apparmor/include/capability.h             |   2 +-
 security/apparmor/include/cred.h                   |  16 +-
 security/apparmor/include/file.h                   |   5 +-
 security/apparmor/include/lib.h                    |   4 +
 security/apparmor/include/task.h                   |  18 +-
 security/apparmor/ipc.c                            |   3 +-
 security/apparmor/lsm.c                            |  67 +--
 security/apparmor/resource.c                       |   2 +-
 security/apparmor/task.c                           |   6 +-
 security/commoncap.c                               |  28 +-
 security/integrity/ima/ima_appraise.c              |   1 +
 security/integrity/ima/ima_policy.c                |   4 +
 security/integrity/ima/ima_template_lib.c          |   1 +
 security/keys/keyctl.c                             |   2 +-
 security/keys/keyring.c                            |   1 +
 security/keys/process_keys.c                       |   3 +
 security/keys/request_key.c                        |   4 +
 security/loadpin/loadpin.c                         |   8 +-
 security/safesetid/Kconfig                         |  14 +
 security/safesetid/Makefile                        |   7 +
 security/safesetid/lsm.c                           | 277 +++++++++
 security/safesetid/lsm.h                           |  33 ++
 security/safesetid/securityfs.c                    | 193 ++++++
 security/security.c                                | 648 ++++++++++++++++++---
 security/selinux/Kconfig                           |  15 -
 security/selinux/Makefile                          |   2 +-
 security/selinux/exports.c                         |  23 -
 security/selinux/hooks.c                           | 362 +++---------
 security/selinux/include/audit.h                   |   3 -
 security/selinux/include/objsec.h                  |  38 +-
 security/selinux/selinuxfs.c                       |   4 +-
 security/selinux/ss/services.c                     |   1 -
 security/selinux/xfrm.c                            |   4 +-
 security/smack/smack.h                             |  44 +-
 security/smack/smack_access.c                      |   6 +-
 security/smack/smack_lsm.c                         | 317 ++++------
 security/smack/smackfs.c                           |  18 +-
 security/tomoyo/audit.c                            |  31 +-
 security/tomoyo/common.c                           | 199 +++++--
 security/tomoyo/common.h                           |  51 +-
 security/tomoyo/condition.c                        |  59 +-
 security/tomoyo/domain.c                           |  76 ++-
 security/tomoyo/file.c                             |  20 +
 security/tomoyo/gc.c                               |  19 +
 security/tomoyo/group.c                            |   5 +
 security/tomoyo/load_policy.c                      |   8 +-
 security/tomoyo/memory.c                           |   9 +-
 security/tomoyo/mount.c                            |   2 +
 security/tomoyo/realpath.c                         |  18 +-
 security/tomoyo/securityfs_if.c                    |  30 +-
 security/tomoyo/tomoyo.c                           | 160 +++--
 security/tomoyo/util.c                             |  23 +-
 security/yama/yama_lsm.c                           |   8 +-
 tools/testing/selftests/safesetid/.gitignore       |   1 +
 tools/testing/selftests/safesetid/Makefile         |   8 +
 tools/testing/selftests/safesetid/config           |   2 +
 tools/testing/selftests/safesetid/safesetid-test.c | 334 +++++++++++
 .../testing/selftests/safesetid/safesetid-test.sh  |  26 +
 78 files changed, 2674 insertions(+), 1090 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/SafeSetID.rst
 delete mode 100644 include/linux/selinux.h
 create mode 100644 security/safesetid/Kconfig
 create mode 100644 security/safesetid/Makefile
 create mode 100644 security/safesetid/lsm.c
 create mode 100644 security/safesetid/lsm.h
 create mode 100644 security/safesetid/securityfs.c
 delete mode 100644 security/selinux/exports.c
 create mode 100644 tools/testing/selftests/safesetid/.gitignore
 create mode 100644 tools/testing/selftests/safesetid/Makefile
 create mode 100644 tools/testing/selftests/safesetid/config
 create mode 100644 tools/testing/selftests/safesetid/safesetid-test.c
 create mode 100755 tools/testing/selftests/safesetid/safesetid-test.sh
