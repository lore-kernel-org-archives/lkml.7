Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F743C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268AD206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569180272;
	bh=9zoyOyktiRtH8YkllJBaaJyXkixplE8SKeCBP01NexQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1ncNAN/wBk6wEa4RaNf9uN7Y2zI/EBKNtVvTOx65tIYwvhmjCB0Xq/10tvsW+X7/O
	 +Fmmz3M23uaN4MOTUVViIye6wLW6/CdZ5SWFjm4kdmNfhBz4oE+/M9bU54Oy7hhezm
	 XWCdjEHljE/QVZAEh3t+2r4sV/8DxMj0zoRd/4Po=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393389AbfIVTYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:24:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393167AbfIVSwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:52:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 763B921479;
        Sun, 22 Sep 2019 18:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178373;
        bh=9zoyOyktiRtH8YkllJBaaJyXkixplE8SKeCBP01NexQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MHpKJZG/DpVjRJDb2H/9r66UJdqWqiv32riBxQEmngmCriMzzzIcGjS5JEYCK/D2H
         e6BAdHzGH1AaHdConrbOLn637+Mfa4QWZ6D78u7i28j+r6umgg2qklDrB0qXvU3zIW
         M6mV7hFsrrm53/BZr48eLLJk4EK+ciNnguj+mmws=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Stone <ahs3@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 123/185] ACPI / CPPC: do not require the _PSD method
Date:   Sun, 22 Sep 2019 14:48:21 -0400
Message-Id: <20190922184924.32534-123-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184924.32534-1-sashal@kernel.org>
References: <20190922184924.32534-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Stone <ahs3@redhat.com>

[ Upstream commit 4c4cdc4c63853fee48c02e25c8605fb65a6c9924 ]

According to the ACPI 6.3 specification, the _PSD method is optional
when using CPPC.  The underlying assumption is that each CPU can change
frequency independently from all other CPUs; _PSD is provided to tell
the OS that some processors can NOT do that.

However, the acpi_get_psd() function returns ENODEV if there is no _PSD
method present, or an ACPI error status if an error occurs when evaluating
_PSD, if present.  This makes _PSD mandatory when using CPPC, in violation
of the specification, and only on Linux.

This has forced some firmware writers to provide a dummy _PSD, even though
it is irrelevant, but only because Linux requires it; other OSPMs follow
the spec.  We really do not want to have OS specific ACPI tables, though.

So, correct acpi_get_psd() so that it does not return an error if there
is no _PSD method present, but does return a failure when the method can
not be executed properly.  This allows _PSD to be optional as it should
be.

Signed-off-by: Al Stone <ahs3@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/cppc_acpi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 15f103d7532b0..3b2525908dd8c 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -365,8 +365,10 @@ static int acpi_get_psd(struct cpc_desc *cpc_ptr, acpi_handle handle)
 	union acpi_object  *psd = NULL;
 	struct acpi_psd_package *pdomain;
 
-	status = acpi_evaluate_object_typed(handle, "_PSD", NULL, &buffer,
-			ACPI_TYPE_PACKAGE);
+	status = acpi_evaluate_object_typed(handle, "_PSD", NULL,
+					    &buffer, ACPI_TYPE_PACKAGE);
+	if (status == AE_NOT_FOUND)	/* _PSD is optional */
+		return 0;
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-- 
2.20.1

