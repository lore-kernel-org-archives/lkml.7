Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EB3ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FED82168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948145;
	bh=LsS3cLKEpGqy9ebVuNqcBko7hWdPP6FRJnuapa640F0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YxQ0D493pBOw2lnFiwOaJ/DJY6zSquo4EiBFotFVVyeTEGBJjd5q87VCss+sio4M0
	 xA++kUF/XG6saWLxeTaWQ/kRClMXVPPDFZy94zMwXfT4bvsgFqzGgfDSY1NOxR22Mn
	 3Y0D/fYrTBJUT1Qh4D07dsIZnRT8nvFMmpWdy7gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbfJAQmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731896AbfJAQmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:42:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77830205C9;
        Tue,  1 Oct 2019 16:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948141;
        bh=LsS3cLKEpGqy9ebVuNqcBko7hWdPP6FRJnuapa640F0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qtdt7GdxOx7IGgoSuvQd02wSopVeskKNUhttfM80H+ABKnTk9UlKIq0gmUcQxokLy
         NVLdb+2F9GXm+gqjzWBem241L6J1CTokji8vNC9GvBvPbY0RO3U1xe/xx7+kFz1mJl
         kz/sEThwPm+Q2HVh7e3wp81fpQJG+jw/75bRTxO0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 5.2 39/63] libnvdimm/nfit_test: Fix acpi_handle redefinition
Date:   Tue,  1 Oct 2019 12:41:01 -0400
Message-Id: <20191001164125.15398-39-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164125.15398-1-sashal@kernel.org>
References: <20191001164125.15398-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 59f08896f058a92f03a0041b397a1a227c5e8529 ]

After commit 62974fc389b3 ("libnvdimm: Enable unit test infrastructure
compile checks"), clang warns:

In file included from
../drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:15:
../drivers/nvdimm/../../tools/testing/nvdimm/test/nfit_test.h:206:15:
warning: redefinition of typedef 'acpi_handle' is a C11 feature
[-Wtypedef-redefinition]
typedef void *acpi_handle;
              ^
../include/acpi/actypes.h:424:15: note: previous definition is here
typedef void *acpi_handle;      /* Actually a ptr to a NS Node */
              ^
1 warning generated.

The include chain:

iomap.c ->
    linux/acpi.h ->
        acpi/acpi.h ->
            acpi/actypes.h
    nfit_test.h

Avoid this by including linux/acpi.h in nfit_test.h, which allows us to
remove both the typedef and the forward declaration of acpi_object.

Link: https://github.com/ClangBuiltLinux/linux/issues/660
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Link: https://lore.kernel.org/r/20190918042148.77553-1-natechancellor@gmail.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/nvdimm/test/nfit_test.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/nvdimm/test/nfit_test.h b/tools/testing/nvdimm/test/nfit_test.h
index 448d686da8b13..0bf5640f1f071 100644
--- a/tools/testing/nvdimm/test/nfit_test.h
+++ b/tools/testing/nvdimm/test/nfit_test.h
@@ -4,6 +4,7 @@
  */
 #ifndef __NFIT_TEST_H__
 #define __NFIT_TEST_H__
+#include <linux/acpi.h>
 #include <linux/list.h>
 #include <linux/uuid.h>
 #include <linux/ioport.h>
@@ -202,9 +203,6 @@ struct nd_intel_lss {
 	__u32 status;
 } __packed;
 
-union acpi_object;
-typedef void *acpi_handle;
-
 typedef struct nfit_test_resource *(*nfit_test_lookup_fn)(resource_size_t);
 typedef union acpi_object *(*nfit_test_evaluate_dsm_fn)(acpi_handle handle,
 		 const guid_t *guid, u64 rev, u64 func,
-- 
2.20.1

