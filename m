Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F36CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433072081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfCHWom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:44:42 -0500
Received: from namei.org ([65.99.196.166]:56176 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfCHWom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 17:44:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x28MifXS012154;
        Fri, 8 Mar 2019 22:44:41 GMT
Date:   Sat, 9 Mar 2019 09:44:41 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] security: integrity subsystem updates for v5.1
Message-ID: <alpine.LRH.2.21.1903090942560.12052@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-297363024-1552085081=:12052"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-297363024-1552085081=:12052
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Please pull these changes from Mimi Zohar:

   "Linux 5.0 introduced the platform keyring to allow verifying the IMA
    kexec kernel image signature using the pre-boot keys.  This pull
    request similarly makes keys on the platform keyring accessible for
    verifying the PE kernel image signature.*
    
    Also included in this pull request is a new IMA hook that tags tmp
    files, in policy, indicating the file hash needs to be calculated.
    The remaining patches are cleanup."

---

The following changes since commit 8bd8ea195f6d135a8d85201116314eb5237ad7e7:

  Merge tag 'v4.20-rc7' into next-general (2018-12-17 11:24:28 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-integrity

for you to fetch changes up to c7f7e58fcbf33589f11bfde0506e076a00627e59:

  integrity: Remove references to module keyring (2018-12-17 14:09:39 -0800)

----------------------------------------------------------------
Dave Howells (2):
      efi: Add EFI signature data types
      efi: Add an EFI signature blob parser

Eric Richter (1):
      x86/ima: define arch_get_ima_policy() for x86

James Morris (1):
      Merge branch 'next-integrity' of git://git.kernel.org/.../zohar/linux-integrity into next-integrity

Josh Boyer (2):
      efi: Import certificates from UEFI Secure Boot
      efi: Allow the "db" UEFI variable to be suppressed

Mimi Zohar (4):
      integrity: support new struct public_key_signature encoding field
      x86/ima: retry detecting secure boot mode
      ima: don't measure/appraise files on efivarfs
      selftests/ima: kexec_load syscall test

Nayna Jain (7):
      x86/ima: define arch_ima_get_secureboot
      ima: prevent kexec_load syscall based on runtime secureboot flag
      ima: refactor ima_init_policy()
      ima: add support for arch specific policies
      integrity: Define a trusted platform keyring
      integrity: Load certs to the platform keyring
      ima: Support platform keyring for kernel appraisal

Nikolay Borisov (1):
      ima: Use inode_is_open_for_write

Stefan Berger (1):
      docs: Extend trusted keys documentation for TPM 2.0

Thiago Jung Bauermann (1):
      integrity: Remove references to module keyring

 Documentation/security/keys/trusted-encrypted.rst  |  31 +++-
 arch/x86/kernel/Makefile                           |   4 +
 arch/x86/kernel/ima_arch.c                         |  75 ++++++++
 include/linux/efi.h                                |  34 ++++
 include/linux/ima.h                                |  15 ++
 security/integrity/Kconfig                         |  11 ++
 security/integrity/Makefile                        |   5 +
 security/integrity/digsig.c                        | 111 ++++++++----
 security/integrity/ima/Kconfig                     |  10 +-
 security/integrity/ima/ima_appraise.c              |  14 +-
 security/integrity/ima/ima_main.c                  |  21 ++-
 security/integrity/ima/ima_policy.c                | 171 +++++++++++++-----
 security/integrity/integrity.h                     |  22 ++-
 security/integrity/platform_certs/efi_parser.c     | 108 ++++++++++++
 security/integrity/platform_certs/load_uefi.c      | 194 +++++++++++++++++++++
 .../integrity/platform_certs/platform_keyring.c    |  58 ++++++
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/ima/Makefile               |  11 ++
 tools/testing/selftests/ima/config                 |   4 +
 tools/testing/selftests/ima/test_kexec_load.sh     |  54 ++++++
 20 files changed, 861 insertions(+), 93 deletions(-)
 create mode 100644 arch/x86/kernel/ima_arch.c
 create mode 100644 security/integrity/platform_certs/efi_parser.c
 create mode 100644 security/integrity/platform_certs/load_uefi.c
 create mode 100644 security/integrity/platform_certs/platform_keyring.c
 create mode 100644 tools/testing/selftests/ima/Makefile
 create mode 100644 tools/testing/selftests/ima/config
 create mode 100755 tools/testing/selftests/ima/test_kexec_load.sh
--1665246916-297363024-1552085081=:12052--
