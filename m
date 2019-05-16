Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38926C04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 19:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8B7206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 19:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="urBmpTon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfEPTgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 15:36:21 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:46382 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfEPTgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 15:36:20 -0400
Received: by mail-ot1-f74.google.com with SMTP id a2so2158638otk.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=12EGJp2weOlY59Dj7vV05HjIGESe9b6AhkqGjpcGHLg=;
        b=urBmpTon+Le+jCkO6VTthpilCEiGEBJ+NguFlbe8htRT9oOFlZjA5eX+9KFJnvJ6dR
         2/0vp/U+A9TJsDxQOXvm8q7n+U5euA0gZ3itQzOrUfZJmrp95jn8+ooqKKJmxJwp0XDQ
         Zr+jUOWN6eSmgz8L0c7geuv7GoTqDQtpRE3+1brSXH5zaDPrU8Hfdp6DkUCc42WltUQl
         JvD59vpW4r/voyvmFUCruEbvjrY613yGidXFv8PVfG53r5W8xrHZyPLQ4CdDVg+ci8i0
         feCXPZJlr57FrBcSGSBTlz0szIoU1EbRRdf7VnNreAgWtcU94E6uz/sVaLtKGpyhPlAQ
         eRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=12EGJp2weOlY59Dj7vV05HjIGESe9b6AhkqGjpcGHLg=;
        b=B0WbGYT1c5hoyAFI+TrcRmDzJnx2BMn10dmuGGXw3aeag4m+Vxf6NeU8UQVKV0o/7P
         1isSyZ5p8f0OdSDwxOBEQck8BcUAYyBNiPVBCFhlHCaoLoZB+EbH0Me2JcZkPSWPyBLK
         AP3SRqyY/ZFtIEuXzHRJlmYhkzgDNZ/FJZC7kXcDysNYUKbWN76A7oD+g6Mk8heleeMC
         xyTf0OFaMgiK7lpEMO6PITXFY1jl89i1JyTo+EUET8OWG/50liEk9hIskS71HnblrNbZ
         fW8Ptxqvo2fsRhc8odB+v0Uex8VqRyL9/51YuL6XALnGGUNxx4K0Frv5ZQKKwLoDY0uc
         iMFg==
X-Gm-Message-State: APjAAAWNy/rHyJIXuSMTYGSu2RyVo8MbDtwWMM74xWu8+C+OXUfhKWhz
        ecMg0QsmFvY2jLdsj8EaLkl8L93yAO3Q
X-Google-Smtp-Source: APXvYqx+jf/+JoigIT9JXRpeKBSCRv9kNlQwQn22no5e+MnXS9Q+xe7hKd9hgfc3nvxXXBHLakQ6J3Qv9xVD
X-Received: by 2002:aca:e387:: with SMTP id a129mr9403268oih.93.1558035379931;
 Thu, 16 May 2019 12:36:19 -0700 (PDT)
Date:   Thu, 16 May 2019 12:36:16 -0700
Message-Id: <20190516193616.252788-1-furquan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH] ACPI: PM: Clear wake-up device GPEs before enabling
From:   Furquan Shaikh <furquan@google.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajatja@google.com, furquan@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change clears GPE status for wake-up devices before enabling that
GPE. This is required to ensure that stale GPE status does
not result in pre-mature wake on enabling GPE for wake-up devices.

Without this change, here is the sequence of events that is causing
suspend aborts on recent chrome books:

1. System decides to enter sleep.
2. All devices in the system are put into low power mode.
3. This results in acpi_dev_suspend being called for each ACPI
device.
4. If the device is wake capable, then acpi_dev_suspend calls
acpi_device_wakeup_enable to enable GPE for the device.
5. If GPE status is already set, enabling GPE for the wakeup device
results in generating a SCI which is handled by acpi_ev_detect_gpe
ultimately calling wakeup_source_activate that increments wakeup
events, and thus aborting the suspend attempt.

Signed-off-by: Furquan Shaikh <furquan@google.com>
---
 drivers/acpi/device_pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index b859d75eaf9f6..e05ee3ff45683 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -721,6 +721,8 @@ static int __acpi_device_wakeup_enable(struct acpi_device *adev,
 	if (error)
 		goto out;
 
+	acpi_clear_gpe(wakeup->gpe_device, wakeup->gpe_number);
+
 	status = acpi_enable_gpe(wakeup->gpe_device, wakeup->gpe_number);
 	if (ACPI_FAILURE(status)) {
 		acpi_disable_wakeup_device_power(adev);
-- 
2.21.0.1020.gf2820cf01a-goog

