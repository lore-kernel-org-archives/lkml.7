Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A059DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699532192D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138553;
	bh=Sfz8QK3jCiXmFM7EoM7Sh7Gr9CUk2zx1w+gyq8OSzMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LbVFOPAJRcXvrH6PmO8JjiDKtE+xQw2cHct5XdWJ2BJFp44KL4R0sjF/7OUoO+wE9
	 nbDe4IY5aomJ+voB4xCqqLIxky0GTWvrHMwbVv0KAryDsssfnA6ebOuXLcmvfjh/8q
	 iVtY75mIwh25QKOz8hatsHEAeU/9LL2n8si9ksjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfDARJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729406AbfDARJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:09:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4DD721924;
        Mon,  1 Apr 2019 17:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138549;
        bh=Sfz8QK3jCiXmFM7EoM7Sh7Gr9CUk2zx1w+gyq8OSzMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G5s5XvoTDhLjc4igmyDXhHA1M5cjLYdLXGouwnsnwnlXekI1N7t+QWtwlhrJb+S3Q
         +tSs4NmY7oJz0lAd+SRk+680fppyTGlCnXUe+Ly69y53cDifdUeBeNjbZPthT3nICT
         DPHVzSN8OxjXOGiNOB7YTVeB8MCJXkrZhQ9/VAcs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 5.0 099/146] ACPI / CPPC: Fix guaranteed performance handling
Date:   Mon,  1 Apr 2019 19:01:51 +0200
Message-Id: <20190401170057.118148030@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

commit edef1ef134180149694b86386277076f566d165c upstream.

As per the ACPI specification, "Guaranteed Performance Register" is
a "Buffer" field and it cannot be "Integer", so treat the "Integer"
type for "Guaranteed Performance Register" field as invalid and
ignore its value in that case.

Also save one cpc_read() call when "Guaranteed Performance Register"
is not present, which means a register defined as:
"Register(SystemMemory, 0, 0, 0, 0)".

Fixes: 29523f095397 ("ACPI / CPPC: Add support for guaranteed performance")
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: 4.20+ <stable@vger.kernel.org> # 4.20+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/cppc_acpi.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1108,8 +1108,13 @@ int cppc_get_perf_caps(int cpunum, struc
 	cpc_read(cpunum, nominal_reg, &nom);
 	perf_caps->nominal_perf = nom;
 
-	cpc_read(cpunum, guaranteed_reg, &guaranteed);
-	perf_caps->guaranteed_perf = guaranteed;
+	if (guaranteed_reg->type != ACPI_TYPE_BUFFER  ||
+	    IS_NULL_REG(&guaranteed_reg->cpc_entry.reg)) {
+		perf_caps->guaranteed_perf = 0;
+	} else {
+		cpc_read(cpunum, guaranteed_reg, &guaranteed);
+		perf_caps->guaranteed_perf = guaranteed;
+	}
 
 	cpc_read(cpunum, lowest_non_linear_reg, &min_nonlinear);
 	perf_caps->lowest_nonlinear_perf = min_nonlinear;


