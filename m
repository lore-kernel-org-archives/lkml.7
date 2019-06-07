Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CCDC468BD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291A220449
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbfFGWbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:31:53 -0400
Received: from linux.microsoft.com ([13.77.154.182]:32790 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbfFGWbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:31:53 -0400
Received: from jaskaran-Intel-Server-Board-S1200V3RPS-UEFI-Development-Kit.corp.microsoft.com (unknown [131.107.160.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id BA5FD20B46F1;
        Fri,  7 Jun 2019 15:31:51 -0700 (PDT)
From:   Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        jmorris@namei.org, scottsh@microsoft.com, ebiggers@google.com,
        mpatocka@redhat.com
Subject: [RFC PATCH v3 0/1] Add dm verity root hash pkcs7 sig validation.
Date:   Fri,  7 Jun 2019 15:31:39 -0700
Message-Id: <20190607223140.16979-1-jaskarankhurana@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds in-kernel pkcs7 signature checking for the roothash of
the dm-verity hash tree.
The verification is to support cases where the roothash is not secured by
Trusted Boot, UEFI Secureboot or similar technologies.
One of the use cases for this is for dm-verity volumes mounted after boot,
the root hash provided during the creation of the dm-verity volume has to
be secure and thus in-kernel validation implemented here will be used
before we trust the root hash and allow the block device to be created.

Why we are doing validation in the Kernel?

The reason is to still be secure in cases where the attacker is able to
compromise the user mode application in which case the user mode validation
could not have been trusted.
The root hash signature validation in the kernel along with existing
dm-verity implementation gives a higher level of confidence in the
executable code or the protected data. Before allowing the creation of
the device mapper block device the kernel code will check that the detached
pkcs7 signature passed to it validates the roothash and the signature is
trusted by builtin keys set at kernel creation. The kernel should be
secured using Verified boot, UEFI Secure Boot or similar technologies so we
can trust it.

What about attacker mounting non dm-verity volumes to run executable
code?

This verification can be used to have a security architecture where a LSM
can enforce this verification for all the volumes and by doing this it can
ensure that all executable code runs from signed and trusted dm-verity
volumes.

Further patches will be posted that build on this and enforce this
verification based on policy for all the volumes on the system.

How are these changes tested?

veritysetup part of cryptsetup library was modified to take a optional
root-hash-sig parameter.

Commandline used to test the changes:

veritysetup open  <data_device> <name> <hash_device> <root_hash>
 --root-hash-sig=<root_hash_pkcs7_detached_sig>

The changes for veritysetup are in a topic branch for now at:
https://github.com/jaskarankhurana/veritysetup/tree/veritysetup_add_sig

Changelog:

v3:
  - Code review feedback given by Sasha Levin.
  - Removed EXPORT_SYMBOL_GPL since this was not required.
  - Removed "This file is released under the GPLv2" since we have SPDX
    identifier.  
  - Inside verity_verify_root_hash changed EINVAL to ENOKEY when the key
    descriptor is not specified but due to force option being set it is
    expected.
  - Moved CONFIG check to inside verity_verify_get_sig_from_key.  
     (Did not move the sig_opts_cleanup to inside verity_dtr as the
     sig_opts do not need to be allocated for the entire duration the block
     device is active unlike the verity structure, note verity_dtr is called
     only if verity_ctr fails or after the lifetime of the block device.)

v2:
  - Code review feedback to pass the signature binary blob as a key that can be
Jaskaran Khurana (1):
  Adds in-kernel pkcs7 sig checking the roothash of the dm-verity hash
    tree

 drivers/md/Kconfig                |  23 ++++++
 drivers/md/Makefile               |   2 +-
 drivers/md/dm-verity-target.c     |  34 +++++++-
 drivers/md/dm-verity-verify-sig.c | 132 ++++++++++++++++++++++++++++++
 drivers/md/dm-verity-verify-sig.h |  30 +++++++
 5 files changed, 216 insertions(+), 5 deletions(-)
 create mode 100644 drivers/md/dm-verity-verify-sig.c
 create mode 100644 drivers/md/dm-verity-verify-sig.h

-- 
2.17.1

