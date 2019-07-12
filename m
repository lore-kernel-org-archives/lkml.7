Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2F2C742CA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AB620863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfGLPp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 11:45:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:16716 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbfGLPp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 11:45:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2019 08:45:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,483,1557212400"; 
   d="scan'208";a="318031854"
Received: from yanbeibe-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.32.118])
  by orsmga004.jf.intel.com with ESMTP; 12 Jul 2019 08:45:20 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     tweek@google.com, matthewgarrett@google.com,
        jorhand@linux.microsoft.com, rdunlap@infradead.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v4] tpm: Document UEFI event log quirks
Date:   Fri, 12 Jul 2019 18:44:32 +0300
Message-Id: <20190712154439.10642-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some weird quirks when it comes to UEFI event log. Provide a
brief introduction to TPM event log mechanism and describe the quirks
and how they can be sorted out.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
v4: - Unfortanely -> Unfortunately
v3: - Add a section for refs and use a bullet list to enumerate them.
    - Remove an invalid author info.
v2: - Fix one typo.
    - Refine the last paragraph to better explain how the two halves
      of the event log are concatenated.
 Documentation/security/tpm/index.rst         |  1 +
 Documentation/security/tpm/tpm_event_log.rst | 55 ++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/security/tpm/tpm_event_log.rst

diff --git a/Documentation/security/tpm/index.rst b/Documentation/security/tpm/index.rst
index af77a7bbb070..db566350bcd5 100644
--- a/Documentation/security/tpm/index.rst
+++ b/Documentation/security/tpm/index.rst
@@ -4,4 +4,5 @@ Trusted Platform Module documentation
 
 .. toctree::
 
+   tpm_event_log
    tpm_vtpm_proxy
diff --git a/Documentation/security/tpm/tpm_event_log.rst b/Documentation/security/tpm/tpm_event_log.rst
new file mode 100644
index 000000000000..f00f7a1d5e92
--- /dev/null
+++ b/Documentation/security/tpm/tpm_event_log.rst
@@ -0,0 +1,55 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+TPM Event Log
+=============
+
+This document briefly describes what TPM log is and how it is handed
+over from the preboot firmware to the operating system.
+
+Introduction
+============
+
+The preboot firmware maintains an event log that gets new entries every
+time something gets hashed by it to any of the PCR registers. The events
+are segregated by their type and contain the value of the hashed PCR
+register. Typically, the preboot firmware will hash the components to
+who execution is to be handed over or actions relevant to the boot
+process.
+
+The main application for this is remote attestation and the reason why
+it is useful is nicely put in the very first section of [1]:
+
+"Attestation is used to provide information about the platform’s state
+to a challenger. However, PCR contents are difficult to interpret;
+therefore, attestation is typically more useful when the PCR contents
+are accompanied by a measurement log. While not trusted on their own,
+the measurement log contains a richer set of information than do the PCR
+contents. The PCR contents are used to provide the validation of the
+measurement log."
+
+UEFI event log
+==============
+
+UEFI provided event log has a few somewhat weird quirks.
+
+Before calling ExitBootServices() Linux EFI stub copies the event log to
+a custom configuration table defined by the stub itself. Unfortunately,
+the events generated by ExitBootServices() don't end up in the table.
+
+The firmware provides so called final events configuration table to sort
+out this issue. Events gets mirrored to this table after the first time
+EFI_TCG2_PROTOCOL.GetEventLog() gets called.
+
+This introduces another problem: nothing guarantees that it is not called
+before the Linux EFI stub gets to run. Thus, it needs to calculate and save the
+final events table size while the stub is still running to the custom
+configuration table so that the TPM driver can later on skip these events when
+concatenating two halves of the event log from the custom configuration table
+and the final events table.
+
+References
+==========
+
+- [1] https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/
+- [2] The final concatenation is done in drivers/char/tpm/eventlog/efi.c
-- 
2.20.1

