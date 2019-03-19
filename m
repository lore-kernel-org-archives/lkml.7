Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22175C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28ED20854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfCSGSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:18:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:25636 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfCSGSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 02:18:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 23:18:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,496,1544515200"; 
   d="scan'208";a="128177379"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006.jf.intel.com with ESMTP; 18 Mar 2019 23:18:54 -0700
Subject: [PATCH 0/6] security/keys/encrypted: Break module dependency chain
From:   Dan Williams <dan.j.williams@intel.com>
To:     keyrings@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Keith Busch <keith.busch@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, ecryptfs@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Mar 2019 23:06:15 -0700
Message-ID: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With v5.1-rc1 all the nvdimm sub-system regression tests started failing
because the libnvdimm module failed to load in the qemu-kvm test
environment.  Critically that environment does not have a TPM. Commit
240730437deb "KEYS: trusted: explicitly use tpm_chip structure..."
started to require a TPM to be present for the trusted.ko module to load
where there was no requirement for that before.

Rather than undo the "fail if no hardware" behavior James points out
that the module dependencies can be broken by looking up the key-type by
name. Remove the dependencies on the "key_type_trusted" and
"key_type_encrypted" symbol exports, and clean up other boilerplate that
supported those exports in different configurations.

---

Dan Williams (6):
      security/keys/encrypted: Allow operation without trusted.ko
      security/keys/encrypted: Clean up request_trusted_key()
      libnvdimm/security: Drop direct dependency on key_type_encrypted
      security/keys/ecryptfs: Drop direct dependency on key_type_encrypted
      security/integrity/evm: Drop direct dependency on key_type_encrypted
      security/keys/encrypted: Drop export of key_type_encrypted


 drivers/nvdimm/security.c                        |   11 ++++-
 fs/ecryptfs/ecryptfs_kernel.h                    |   22 -----------
 fs/ecryptfs/keystore.c                           |   12 ++++++
 include/keys/encrypted-type.h                    |    2 -
 include/linux/key.h                              |    1 
 security/integrity/evm/evm_crypto.c              |    9 ++++
 security/keys/encrypted-keys/Makefile            |    3 -
 security/keys/encrypted-keys/encrypted.c         |   35 ++++++++++++++++-
 security/keys/encrypted-keys/encrypted.h         |   12 ------
 security/keys/encrypted-keys/masterkey_trusted.c |   46 ----------------------
 security/keys/internal.h                         |    2 -
 security/keys/key.c                              |    1 
 12 files changed, 65 insertions(+), 91 deletions(-)
 delete mode 100644 security/keys/encrypted-keys/masterkey_trusted.c
