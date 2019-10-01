Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB89EC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD85E2168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948734;
	bh=Ssy2G1RYYjVy0ZSes0pBTBlvxbNL8z8gD+60zY8RVcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lGYAGfHlX+VWf7jY05ppDLuqjU/wMVR+CXBHqmdioajLaNt0Zxq7O80CLiTOWOm47
	 GU4iQKzlK0xqDhGis2hSoyHJZFzRWY2Ad+fZMRUOtb2P2PXmUfRFD72/FCIBfgSWup
	 1ZlbP4ClG+Nbojver0NNU/cft3j2wjW1RCykXhfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733281AbfJAQwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733140AbfJAQny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:43:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE3F9205C9;
        Tue,  1 Oct 2019 16:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948233;
        bh=Ssy2G1RYYjVy0ZSes0pBTBlvxbNL8z8gD+60zY8RVcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vQdUnSa8BVN6caz+bFzQy4D9yEgFkvlbmsJfZC5QoG7kWb4s7bJn/d0k8/Yo+qcqZ
         05ncWgCMNOLFKMpBSq1885wtjS9DIUHkv7FoR5JwebBUrNyxIkleJPINR/gxC6I2hp
         K7xgha5JaJVaIAcsuvAVIJUCydTfbeXHBhp1RiSg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.19 29/43] libnvdimm/nfit_test: Fix acpi_handle redefinition
Date:   Tue,  1 Oct 2019 12:42:57 -0400
Message-Id: <20191001164311.15993-29-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164311.15993-1-sashal@kernel.org>
References: <20191001164311.15993-1-sashal@kernel.org>
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
index 33752e06ff8d0..3de57cc8716b9 100644
--- a/tools/testing/nvdimm/test/nfit_test.h
+++ b/tools/testing/nvdimm/test/nfit_test.h
@@ -12,6 +12,7 @@
  */
 #ifndef __NFIT_TEST_H__
 #define __NFIT_TEST_H__
+#include <linux/acpi.h>
 #include <linux/list.h>
 #include <linux/uuid.h>
 #include <linux/ioport.h>
@@ -234,9 +235,6 @@ struct nd_intel_lss {
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

