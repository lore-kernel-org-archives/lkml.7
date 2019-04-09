Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEA7C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB1B2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554835826;
	bh=JCja87Ul3jcpRkuSZO7IIHnlEqxRDIUptc29tXOWjNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rf0v2P1ALa6QuGtPjormMl0f0n2PvMsoMehMExhoOvf9ccJVjED3TmE9i0RfKeSdE
	 95rF3QBB38S3jXFZt0rMRNpmusKLuXK4bDKzJzKm/T3HR2yHo9gHEtGBrjUf4t6EmJ
	 cN4IxuDISocnR0sGfeFDhVLfg1KR9wJGZgFrY0o8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfDISuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:50:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfDISuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 14:50:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6114B218E2;
        Tue,  9 Apr 2019 18:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554835818;
        bh=JCja87Ul3jcpRkuSZO7IIHnlEqxRDIUptc29tXOWjNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIAznywxh5FnrELFFj4tcLqF+f9RI3DpFbEbAtLENB/yMVLIK30/T3PLo/fu5y9Y4
         G8rRKPmc13wsDdZFwhi/u0QjtMBAnN9WHJwQzz4IC2dfPZYQ69PtZQrdbbuRihW/GW
         GMJcwcxoRjHKH8VZ6viev72ybRk85150xVRNrOpc=
From:   Sasha Levin <sashal@kernel.org>
To:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     mark.rutland@arm.com, corbet@lwn.net, robh+dt@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 3/3] ftpm: add documentation for ftpm driver
Date:   Tue,  9 Apr 2019 14:49:58 -0400
Message-Id: <20190409184958.7476-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190409184958.7476-1-sashal@kernel.org>
References: <20190409184958.7476-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic documentation to describe the new fTPM driver.

Signed-off-by: Sasha Levin <sashal@kernel.org>
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
index 000000000000..3f19b12d9c57
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

