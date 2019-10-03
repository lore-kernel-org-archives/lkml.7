Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0DAC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DD1215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119556;
	bh=K0AEGtS3ru3m5o3GBWv+/gtrDrzTVL4cNuryvWAlht0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B3oQLaQxJycf7xQyV6EE40nQUIsTkBRHBn7HQWSHMwBrQHnfmx3tr0Lgzi+GqU6ln
	 vcxZuIoyziZslVN69IzRTC6T3eNPvCshjzzy5pQtmJCIGlyckNR8YfiVjSeEIxvEpU
	 jymZ/mKS5lCrm15IcUaEzleLt/kqG5dXu57uy5Cg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389484AbfJCQTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389709AbfJCQTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:19:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C76A720865;
        Thu,  3 Oct 2019 16:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119553;
        bh=K0AEGtS3ru3m5o3GBWv+/gtrDrzTVL4cNuryvWAlht0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t6tlhJ4bzlOm1ol8NaEO7meXIscNecLOElvCyNcHEYt/AZ6YuVIFqmQ591vX6vwuj
         jX24s4Pg4hCMpAYu33wxHZ5gD+y+QScOH1Ra1hpikUJ6l6aljHc8QBCNbu/jUqMprj
         zNVdXaq+yIXOyq2uFwcm4k5/pFjVMPXuEblI4u84=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Stone <ahs3@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 106/211] ACPI / CPPC: do not require the _PSD method
Date:   Thu,  3 Oct 2019 17:52:52 +0200
Message-Id: <20191003154511.236352636@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index d9ce4b162e2ce..a1aa59849b964 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -369,8 +369,10 @@ static int acpi_get_psd(struct cpc_desc *cpc_ptr, acpi_handle handle)
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



