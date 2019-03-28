Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C946AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D78A20685
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KUzptJy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfC1Ter (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:34:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37364 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfC1Ten (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:34:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so69347wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 12:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gWnbQGQJOqdaM9GqZg5HDHDpO0vrT5dYlIu9zqFadZk=;
        b=KUzptJy9UipXep89qvMvbGfXDUdDjdr+6nPFKmj7/gSzBurxTWQjI79XXsGWlcKkX8
         eUI91hE5IICTaY3qNcONeuO/qm2ENp6uk84COKYgw/fmTHXQXDhs43SU925LF93Xym/B
         eJBG6475ZjyWL9xuN/JcrrOXlkCiJmx8O4Am25RbaZIpIxjerGr4Ko8c3zdY78LmUu1y
         AcUrEfM8tOaC6+EuEAEvn17racR8i318hzoi1Zf5o/F1ot+XipNqNYwz3Xfze2OjC+Jd
         TWVj5ME6fK5b0U/HCAAM0rGu3UmpFsMdl2uCyNkpJD+pBqFWTsTMfaoqfosuaY8EYRDS
         Bkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gWnbQGQJOqdaM9GqZg5HDHDpO0vrT5dYlIu9zqFadZk=;
        b=f8RpIT1TNPYPy9gW236fONmRCn3pAlU6kvE0Y6YmrdtPUaQErsRNVLcxxIOU3AxzQ+
         6HFC0EIdY4k9RqEzysRF/mgqT96uU2ysNzQbFNYWwUNbiVx1UuWXESAe/GVwzB8TQLxc
         MkSyoluQWj6DCg9PIPcNRL4qgmSkfssDLHF+XGNOSFMl92pAET/AhxfFy4WNP78JY4Ln
         lZavVLPzYuTE7wP0TIwpB2R3Em9WzfuH2cM+6YAr9E/wMZba/XpPkTGs1jCkLjYOMDPH
         W0oNANh5I5lYKxarbgKyopElkYCX6nwzAG4dyqhfDXFgL64MI8jhtAaIkQUDM7NhcFRL
         9Yvw==
X-Gm-Message-State: APjAAAU5bq1/n2zl5lCCeQUORIXlc4BiR/gzh1u2al0HGq0ZjMijI8dk
        mxjlF0AAk5Z9St8DLYjF3Hc1Dw==
X-Google-Smtp-Source: APXvYqw3fXbsC0wE3yOx3nf3lZfmC9eYRwp9XQD/hsSGec9j1xHKhdJl7IMW5z6T5Vq2qcjfUzYGzA==
X-Received: by 2002:a1c:1aca:: with SMTP id a193mr1140540wma.40.1553801681532;
        Thu, 28 Mar 2019 12:34:41 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:dd62:8a50:1468:989d])
        by smtp.gmail.com with ESMTPSA id d6sm27739186wrx.62.2019.03.28.12.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 12:34:40 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Marcin Benka <mbenka@marvell.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Robert Richter <rrichter@marvell.com>
Subject: [PATCH 3/5] efi/arm: Show SMBIOS bank/device location in cper and ghes error logs
Date:   Thu, 28 Mar 2019 20:34:27 +0100
Message-Id: <20190328193429.21373-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328193429.21373-1-ard.biesheuvel@linaro.org>
References: <20190328193429.21373-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcin Benka <mbenka@marvell.com>

Run dmi_memdev_walk() for arch arm* as other archs do. This improves
error logging as the memory device handle is translated now to the
DIMM entry's name provided by the DMI handle.

Before:

 {1}[Hardware Error]:   DIMM location: not present. DMI handle: 0x0038

After:

 {1}[Hardware Error]:   DIMM location: N0 DIMM_A0

Signed-off-by: Marcin Benka <mbenka@marvell.com>
Signed-off-by: Robert Richter <rrichter@marvell.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/arm-runtime.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 0c1af675c338..4a0dfe4ab829 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -167,6 +167,7 @@ static int __init arm_dmi_init(void)
 	 * itself, depends on dmi_scan_machine() having been called already.
 	 */
 	dmi_scan_machine();
+	dmi_memdev_walk();
 	if (dmi_available)
 		dmi_set_dump_stack_arch_desc();
 	return 0;
-- 
2.20.1

