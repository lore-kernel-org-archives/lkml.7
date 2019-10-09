Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6961ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEB520679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570642059;
	bh=LvaFGmWDLMlpjwhFzvOngmjgOS7bg/Bp9sWp/Ptl0Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VpCjguGAK3uIY4CBfpXcG+cewRip4Tq7Ff1lACFe7rHwwAsDZD2/+m0q5ITV3mnLG
	 NKyhJENhVjjoxWR73w2QhLELEmWlVdPPmiWQuFNEE6QaOTA+Kk6XHOwQXp553CN15L
	 pQNv9oAKykfyQRStJ3om9FYMr1l5lT9Q7RgqcKJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbfJIR1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732341AbfJIRY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:24:29 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 426B6218AC;
        Wed,  9 Oct 2019 17:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570641869;
        bh=LvaFGmWDLMlpjwhFzvOngmjgOS7bg/Bp9sWp/Ptl0Ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mu3Gkbir+4qFrbyBthFMhs2W+Pf0WWfSR8Q9cMKqzZ+rSB0HRqrQDx+YtqUFJ4MVu
         MWEXUcMfgBIwlEcBFh1O+P0XTo6fGSSFLTLSu26whST4/svK0988WXtnzpMzMxTtHA
         0yPCNhd7da3QKWC20TSlDMcSLHJd3AS14uJSkGc0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 12/21] xen/efi: Set nonblocking callbacks
Date:   Wed,  9 Oct 2019 13:06:05 -0400
Message-Id: <20191009170615.32750-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170615.32750-1-sashal@kernel.org>
References: <20191009170615.32750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit df359f0d09dc029829b66322707a2f558cb720f7 ]

Other parts of the kernel expect these nonblocking EFI callbacks to
exist and crash when running under Xen. Since the implementations of
xen_efi_set_variable() and xen_efi_query_variable_info() do not take any
locks, use them for the nonblocking callbacks too.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/xen/efi.c | 2 ++
 arch/x86/xen/efi.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/xen/efi.c b/arch/arm/xen/efi.c
index b4d78959cadf0..bc9a37b3cecd6 100644
--- a/arch/arm/xen/efi.c
+++ b/arch/arm/xen/efi.c
@@ -31,7 +31,9 @@ void __init xen_efi_runtime_setup(void)
 	efi.get_variable             = xen_efi_get_variable;
 	efi.get_next_variable        = xen_efi_get_next_variable;
 	efi.set_variable             = xen_efi_set_variable;
+	efi.set_variable_nonblocking = xen_efi_set_variable;
 	efi.query_variable_info      = xen_efi_query_variable_info;
+	efi.query_variable_info_nonblocking = xen_efi_query_variable_info;
 	efi.update_capsule           = xen_efi_update_capsule;
 	efi.query_capsule_caps       = xen_efi_query_capsule_caps;
 	efi.get_next_high_mono_count = xen_efi_get_next_high_mono_count;
diff --git a/arch/x86/xen/efi.c b/arch/x86/xen/efi.c
index a18703be9ead9..4769a069d5bd8 100644
--- a/arch/x86/xen/efi.c
+++ b/arch/x86/xen/efi.c
@@ -77,7 +77,9 @@ static efi_system_table_t __init *xen_efi_probe(void)
 	efi.get_variable             = xen_efi_get_variable;
 	efi.get_next_variable        = xen_efi_get_next_variable;
 	efi.set_variable             = xen_efi_set_variable;
+	efi.set_variable_nonblocking = xen_efi_set_variable;
 	efi.query_variable_info      = xen_efi_query_variable_info;
+	efi.query_variable_info_nonblocking = xen_efi_query_variable_info;
 	efi.update_capsule           = xen_efi_update_capsule;
 	efi.query_capsule_caps       = xen_efi_query_capsule_caps;
 	efi.get_next_high_mono_count = xen_efi_get_next_high_mono_count;
-- 
2.20.1

