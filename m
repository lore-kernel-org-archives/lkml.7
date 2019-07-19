Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F209AC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5E821873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563508752;
	bh=yJmRyrzBt/ZQZo6dAZhH1BB6xNTq2RP6aEkDuFKhFlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VbRv2+kb+pxLIefFN/4rLc6YH7j7OO5n8JrjyoKW+DAz9VjKPnMNsTo5av7UuewmX
	 O82IwC98TdA4IH6TSbP0KKyLzIiqKtWtj7gS1fzv7VBRce1upNZ4hnSaAEulTRuUZT
	 pqQ1Fo530l1lsPF+29fkHL3OcaMFDtKkFgxiY41o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfGSD7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 23:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728429AbfGSD7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 23:59:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AE11218D0;
        Fri, 19 Jul 2019 03:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508742;
        bh=yJmRyrzBt/ZQZo6dAZhH1BB6xNTq2RP6aEkDuFKhFlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X1AehkT5+mFNEYjaYZ7AVpLXYlpSnHgh0vdkbvCz5699szOCDrX+WuoqylCVP4kwX
         gTxKFO5551fNZrVa+Q8pMbbBzrkEDnO+BfLJidjRtp09isWYIm63nToh07fUImQag6
         i6vcZ2thNwK74Au3GcY3DjeGitMFsO4BZTaYtfTI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>,
        Daniel Drake <drake@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 063/171] platform/x86: asus-wmi: Increase input buffer size of WMI methods
Date:   Thu, 18 Jul 2019 23:54:54 -0400
Message-Id: <20190719035643.14300-63-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>

[ Upstream commit 98e865a522983f2afde075648ec9d15ea4bb9194 ]

The asus-nb-wmi driver is matched by WMI alias but fails to load on TUF
Gaming series laptops producing multiple ACPI errors in the kernel log.

The input buffer for WMI method invocation size is 2 dwords, whereas
3 are expected by this model.

FX505GM:
..
Method (WMNB, 3, Serialized)
{
    P8XH (Zero, 0x11)
    CreateDWordField (Arg2, Zero, IIA0)
    CreateDWordField (Arg2, 0x04, IIA1)
    CreateDWordField (Arg2, 0x08, IIA2)
    Local0 = (Arg1 & 0xFFFFFFFF)
    ...

Compare with older K54C:
...
Method (WMNB, 3, NotSerialized)
{
    CreateDWordField (Arg2, 0x00, IIA0)
    CreateDWordField (Arg2, 0x04, IIA1)
    Local0 = (Arg1 & 0xFFFFFFFF)
    ...

Increase buffer size to 3 dwords. No negative consequences of this change
are expected, as the input buffer size is not verified. The original
function is replaced by a wrapper for a new method passing value 0 for the
last parameter. The new function will be used to control RGB keyboard
backlight.

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Reviewed-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-wmi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 9b18a184e0aa..abfa99d18fea 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -85,6 +85,7 @@ static bool ashs_present(void)
 struct bios_args {
 	u32 arg0;
 	u32 arg1;
+	u32 arg2; /* At least TUF Gaming series uses 3 dword input buffer. */
 } __packed;
 
 /*
@@ -211,11 +212,13 @@ static void asus_wmi_input_exit(struct asus_wmi *asus)
 	asus->inputdev = NULL;
 }
 
-int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval)
+static int asus_wmi_evaluate_method3(u32 method_id,
+		u32 arg0, u32 arg1, u32 arg2, u32 *retval)
 {
 	struct bios_args args = {
 		.arg0 = arg0,
 		.arg1 = arg1,
+		.arg2 = arg2,
 	};
 	struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -247,6 +250,11 @@ int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval)
 
 	return 0;
 }
+
+int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval)
+{
+	return asus_wmi_evaluate_method3(method_id, arg0, arg1, 0, retval);
+}
 EXPORT_SYMBOL_GPL(asus_wmi_evaluate_method);
 
 static int asus_wmi_evaluate_method_agfn(const struct acpi_buffer args)
-- 
2.20.1

