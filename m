Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632AFC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FDB20825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555343818;
	bh=bR2KjivPoLlY6Pq+egUxPlsqFOzLQeX1Mn0byEC8zko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QZfTqS34JYx9Vue1wLU8vLe3uhkfuo3n2+Mc7Z8pZWqMMMgeNcWKmgLi5LtLksKC1
	 ZtdVrSFErumRgq7+MBq9+kpyt0ay5gwEvujrkGkOA6kGTJuwdGT8Xak+kKSbMq/nGM
	 iqP9z/M0hvW2G5hbjk5bdTL4Du1WQXt4PaT1cPQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfDOP45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:56:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbfDOP4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:56:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BCCD2183F;
        Mon, 15 Apr 2019 15:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555343815;
        bh=bR2KjivPoLlY6Pq+egUxPlsqFOzLQeX1Mn0byEC8zko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x9JR7qYkKg4dWd9FhRHhVdijDBjH5v5880HCRGnNWso/i8VQeOwt9LVxZL9M7UH1M
         bMYxwuhcfLNoyGS/T4+xZpeuTmbdQqrFDDnLODA6S1QLu0jpwYI2mCmilGKymBXDoc
         Bdvgdf+JZ6cpJ0CkKFDssF86wFiPqMN6pn/ZExU8=
From:   Sasha Levin <sashal@kernel.org>
To:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v3 2/2] ftpm: add documentation for ftpm driver
Date:   Mon, 15 Apr 2019 11:56:36 -0400
Message-Id: <20190415155636.32748-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190415155636.32748-1-sashal@kernel.org>
References: <20190415155636.32748-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic documentation to describe the new fTPM driver.

Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 Documentation/security/tpm/index.rst        |  1 +
 Documentation/security/tpm/tpm_ftpm_tee.rst | 31 +++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst

diff --git a/Documentation/security/tpm/index.rst b/Documentation/security/tpm/index.rst
index af77a7bbb070..15783668644f 100644
--- a/Documentation/security/tpm/index.rst
+++ b/Documentation/security/tpm/index.rst
@@ -4,4 +4,5 @@ Trusted Platform Module documentation
 
 .. toctree::
 
+   tpm_ftpm_tee
    tpm_vtpm_proxy
diff --git a/Documentation/security/tpm/tpm_ftpm_tee.rst b/Documentation/security/tpm/tpm_ftpm_tee.rst
new file mode 100644
index 000000000000..29c2f8b5ed10
--- /dev/null
+++ b/Documentation/security/tpm/tpm_ftpm_tee.rst
@@ -0,0 +1,31 @@
+=============================================
+Firmware TPM Driver
+=============================================
+
+| Authors:
+| Thirupathaiah Annapureddy <thiruan@microsoft.com>
+| Sasha Levin <sashal@kernel.org>
+
+This document describes the firmware Trusted Platform Module (fTPM)
+device driver.
+
+Introduction
+============
+
+This driver is a shim for a firmware implemented in ARM's TrustZone
+environment. The driver allows programs to interact with the TPM in the same
+way the would interact with a hardware TPM.
+
+Design
+======
+
+The driver acts as a thin layer that passes commands to and from a TPM
+implemented in firmware. The driver itself doesn't contain much logic and is
+used more like a dumb pipe between firmware and kernel/userspace.
+
+The firmware itself is based on the following paper:
+https://www.microsoft.com/en-us/research/wp-content/uploads/2017/06/ftpm1.pdf
+
+When the driver is loaded it will expose ``/dev/tpmX`` character devices to
+userspace which will enable userspace to communicate with the firmware tpm
+through this device.
-- 
2.19.1

