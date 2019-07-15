Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C84C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727E520896
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563200640;
	bh=x1kicmXRcLo1s+iYZ1iAp+iUX9MVC1guF8j4JhcrXD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WzqThrZC//5D2fNcd0OMsJOftoQgxtjMpvQFSJvtmTMwxBfFVAspPHIxbzHGHPNrq
	 b0IlipCBm3mfkJWkGBKEZO/YfBtYWXos064wYs5KNcnMxSlJOjJN4qr8zHEXGoQ7qV
	 dbf07ZbhAdqqxJYL2p7EGYZsWQmDvU50iAgF5XlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390826AbfGOOX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390055AbfGOOXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:23:50 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85610217F4;
        Mon, 15 Jul 2019 14:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563200629;
        bh=x1kicmXRcLo1s+iYZ1iAp+iUX9MVC1guF8j4JhcrXD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HIqDWxjB+dEL6AZWt0O1BMwe+S03CWwQ7xPd0ORVc/pbb6b7bJEvjW1zo8MEmAmda
         J4SW9w30VWx/KXUZU4iT3efBUtPJ5vJxBN9WJ0Rs2kvxT3RzOK/rObAOyHe8xDczyV
         my6ySYE+pWe3bxnbYjUN/Ole1zLP+kkoN2YbDZPg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 096/158] acpi/arm64: ignore 5.1 FADTs that are reported as 5.0
Date:   Mon, 15 Jul 2019 10:17:07 -0400
Message-Id: <20190715141809.8445-96-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715141809.8445-1-sashal@kernel.org>
References: <20190715141809.8445-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

[ Upstream commit 2af22f3ec3ca452f1e79b967f634708ff01ced8a ]

Some Qualcomm Snapdragon based laptops built to run Microsoft Windows
are clearly ACPI 5.1 based, given that that is the first ACPI revision
that supports ARM, and introduced the FADT 'arm_boot_flags' field,
which has a non-zero field on those systems.

So in these cases, infer from the ARM boot flags that the FADT must be
5.1 or later, and treat it as 5.1.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Graeme Gregory <graeme.gregory@linaro.org>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/acpi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index ed46dc188b22..970f15c76bac 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -154,10 +154,14 @@ static int __init acpi_fadt_sanity_check(void)
 	 */
 	if (table->revision < 5 ||
 	   (table->revision == 5 && fadt->minor_revision < 1)) {
-		pr_err("Unsupported FADT revision %d.%d, should be 5.1+\n",
+		pr_err(FW_BUG "Unsupported FADT revision %d.%d, should be 5.1+\n",
 		       table->revision, fadt->minor_revision);
-		ret = -EINVAL;
-		goto out;
+
+		if (!fadt->arm_boot_flags) {
+			ret = -EINVAL;
+			goto out;
+		}
+		pr_err("FADT has ARM boot flags set, assuming 5.1\n");
 	}
 
 	if (!(fadt->flags & ACPI_FADT_HW_REDUCED)) {
-- 
2.20.1

