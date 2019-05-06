Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC87C04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EFD20C01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153682;
	bh=sx1pPAWwYCqiei8ugsKwF71A33BMH82+O9H5YI+MoGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CDUCF0kJIVZXF0pVzZ3ui2tC6pe+OjCv8QAtylJ+J+iQk38gKifIN+jqW50u/NkKZ
	 tGmDHtl1yvGz+1QsT8n5tCGkyTSdvceItRMNaFH6MgPNVoHcFuFkRwPJFlbIrb6sBP
	 VB1nGIHBJxAq4D7krCF/QCuHo78FDlJ+AB/V7zzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfEFOlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:41:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728208AbfEFOlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:41:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4155A2087F;
        Mon,  6 May 2019 14:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153677;
        bh=sx1pPAWwYCqiei8ugsKwF71A33BMH82+O9H5YI+MoGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oSqeyZzfwWYEXtLh+BIjVr44VTfk3uMw3YbCrbI8IJdoT2lkgOCRzT6n8z83s6au4
         lv74ZoxpAUn9KsO32CBu/xGjLIQ/5qD8cZ28VAFliSgCbEZrAeBldyAreIt0viDwi8
         ZOcA4KV8cnBF5ER+sEMbIdSwhqeesGC8JNN2sw+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 54/99] arm64: fix wrong check of on_sdei_stack in nmi context
Date:   Mon,  6 May 2019 16:32:27 +0200
Message-Id: <20190506143058.974732530@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.899356316@linuxfoundation.org>
References: <20190506143053.899356316@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1c41860864c8ae0387ef7d44f0000e99cbb2e06d ]

When doing unwind_frame() in the context of pseudo nmi (need enable
CONFIG_ARM64_PSEUDO_NMI), reaching the bottom of the stack (fp == 0,
pc != 0), function on_sdei_stack() will return true while the sdei acpi
table is not inited in fact. This will cause a "NULL pointer dereference"
oops when going on.

Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Wei Li <liwei391@huawei.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/sdei.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 5ba4465e44f0..ea94cf8f9dc6 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -94,6 +94,9 @@ static bool on_sdei_normal_stack(unsigned long sp, struct stack_info *info)
 	unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
 	unsigned long high = low + SDEI_STACK_SIZE;
 
+	if (!low)
+		return false;
+
 	if (sp < low || sp >= high)
 		return false;
 
@@ -111,6 +114,9 @@ static bool on_sdei_critical_stack(unsigned long sp, struct stack_info *info)
 	unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
 	unsigned long high = low + SDEI_STACK_SIZE;
 
+	if (!low)
+		return false;
+
 	if (sp < low || sp >= high)
 		return false;
 
-- 
2.20.1



