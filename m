Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC8AECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FF120679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570642225;
	bh=IUj/HxYB2rHKVhwAa6+OElvjVYWfgUzquy9H1go8RzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g2jYbdu9QCvXXMOYCK3Mv77e4RDVA2km8Xum3WG9lmkPJoO9TPrlgULPUbr0sYeH2
	 a0aadIYcXnhGvqV4psJxkBCGabzMeumJh2B5KrkPb+EMfybd7VghJpfG16V1eb2rzP
	 mV0BaneIUAkrlV5ogSE7/zZaC7j20j1DK0W6ljTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbfJIRaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:30:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730490AbfJIRYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:24:08 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4888921A4A;
        Wed,  9 Oct 2019 17:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570641848;
        bh=IUj/HxYB2rHKVhwAa6+OElvjVYWfgUzquy9H1go8RzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvfyTwF+qi7cb2S5vNnRVSz94NSpvxfLCE//wAFIVJPLiV4YNdtAxRL5lCqxoCHd+
         RYK3r5UTjExM3HQ5IirQJqR3K5JvtCwuYHWTYuo+FtNtE9prXlzs1VWoqX1fi+v0lu
         7B0Bw5+uvUkpO6ID9tEmO6MekfhZRO8Q2vaU/roY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 14/26] xen/efi: Set nonblocking callbacks
Date:   Wed,  9 Oct 2019 13:05:46 -0400
Message-Id: <20191009170558.32517-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170558.32517-1-sashal@kernel.org>
References: <20191009170558.32517-1-sashal@kernel.org>
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
index 1804b27f9632a..66bcdeeee639a 100644
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

