Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35342C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EDB2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uyKcSgko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387988AbfB1XMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:12:51 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:35306 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387939AbfB1XMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:49 -0500
Received: by mail-pl1-f201.google.com with SMTP id d17so16232733pls.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0c4DnPm/cx2jzTzIvXsNGvNdz/XPR522PUMTkwR1KuQ=;
        b=uyKcSgkoAKvFlpnGAcowfxwKxFJXbTANnMFv51NpWe1AQ9/g7xJ6nr0sF8jaUuyoul
         uheLayLR/gi5715AElFU1bWdzgUWltb5IZ0nXAomZakOxNSpH+KCAecD8F8akvxCHdlC
         62ZkceTDBnB2i4cqSDOvE/aLMZ7zRpKy25snYHxLAmT9nWEi2kONGe2/F3wKJWB6g3W+
         uXs1Q/e78G7v51pN6kV0j+y1Q0Wb6SDhobx6DQmfNW5yielNATjHv2sEohO/V+QpdFRN
         H7o5fhkzSZxYHkWXpUYVUApxgbUEgszPFqoPnDXUK9xPMae+MagL9xmcTnvSB+X1Dn9t
         U0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0c4DnPm/cx2jzTzIvXsNGvNdz/XPR522PUMTkwR1KuQ=;
        b=Vx5owwNtD7NhMFHN7W0SGq4RyBrOXm/fY0laPrwVmw64F29/tzc55zUFkosHZ347NC
         rqPedopS03VAfg1pu4PHDEL1Zkiqv6FxG9t43h5broBt/vpII96UxPS5rgfSp5tt2fId
         qlKdHkG/yAK4GGCwS4Xg7RhSc7/qvt9HpRqFTF+wwNAKqD+phM2832cD67ndA1rv2sCD
         jNXBc+jKdw7KqK07LhSgdWaMe/zql7i7czjLFnZY1+LcmZ651ykWBByu6PiafVExe9O0
         srqs/ilX22M8uLdr2u6VSTHzPHMIZzR0lfJtHPOtCa81DnslC15YgVA5Hz9Qemtv/JaO
         jPBA==
X-Gm-Message-State: AHQUAuZ4qMXw7hOV6/ULl+794zhyJkXvFv5zpbZdmdyQJnH/F8DVCH2P
        b9pW9YQwYXVdMMpHzlcIUKrRNwODo27Tv/E0jxSDqQ==
X-Google-Smtp-Source: APXvYqzzwt9UewHcrRVj6+HEeD5KRfke8EwJHrMZ3x/xl5bWeZh/LV7ynXZIZ1SmpY4ZfYIcAJ/6gy/8Lm/ElX7bMzL/fA==
X-Received: by 2002:a62:121a:: with SMTP id a26mr972694pfj.47.1551395568702;
 Thu, 28 Feb 2019 15:12:48 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:53 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-17-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 17/27] acpi: Disable APEI error injection if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linn Crosetto <linn@hpe.com>

ACPI provides an error injection mechanism, EINJ, for debugging and testing
the ACPI Platform Error Interface (APEI) and other RAS features.  If
supported by the firmware, ACPI specification 5.0 and later provide for a
way to specify a physical memory address to which to inject the error.

Injecting errors through EINJ can produce errors which to the platform are
indistinguishable from real hardware errors.  This can have undesirable
side-effects, such as causing the platform to mark hardware as needing
replacement.

While it does not provide a method to load unauthenticated privileged code,
the effect of these errors may persist across reboots and affect trust in
the underlying hardware, so disable error injection through EINJ if
the kernel is locked down.

Signed-off-by: Linn Crosetto <linn@hpe.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/apei/einj.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index fcccbfdbdd1a..9fe6bbab2e7d 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -518,6 +518,9 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	int rc;
 	u64 base_addr, size;
 
+	if (kernel_is_locked_down("ACPI error injection"))
+		return -EPERM;
+
 	/* If user manually set "flags", make sure it is legal */
 	if (flags && (flags &
 		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))
-- 
2.21.0.352.gf09ad66450-goog

