Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9EBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172C120643
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WIUI0I3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfCTWeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:34:07 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:50536 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfCTWeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:34:07 -0400
Received: by mail-qk1-f202.google.com with SMTP id d8so22272249qkk.17
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 15:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fwvS1CCeK/9mxSvkHjON/M6m7Jcgc0dvN8k4BI8hC0s=;
        b=WIUI0I3Oba+9hV5dGc2k6eBV6T/Zq/Bu1J0cYkyXUMDETJZcYihFO3+V9kOD5L49SV
         UE75YWqQmNnTXyGPjaDfFsJWtrYyIu2clVtfm5KR4/dUpCEwb6+gGJ1WKJFppk9htYYW
         PqcNvdzwOv9SNzW3s9Eu2q3yyGsZFtWEeU2/YhLRqzCZlLk46W2Bhc1Opindf4Yui1Vi
         BkObjVJUnL25X486Qk6UhZGN65FRzeOMt0pp6PPXEQFAu8HKAFzOTA8PeWyTiKkk7KxM
         I84EYmYLyswLTghPe5ri5DsljyX0ANDb68SFXonSgiT22LrJ/HNvW4VUpLNer6LdMoUz
         wT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fwvS1CCeK/9mxSvkHjON/M6m7Jcgc0dvN8k4BI8hC0s=;
        b=oi2KjuTNHfjTwPBZc5G57aDEqPfhvNlnDFoCoIbu/R3gI+Rzz7rNvJsmnks7IPeASy
         OpjQAEGzmuZ8evYSIG46XgmTF5TwEVI38O/Tdk952bjc4rbZugiZFfxz4U91pGzzkf04
         nkerBvPlhceBVXzAv+p4BvMStk8kI0LUkoRBQhi5f0yG8dCO4dgU9rp95wdCMv8Ucebo
         h0bEXo8qwDG/Ub7Rs4ge/fs6pXsj41fgrELaH7DEVqVmsEbTfBPyoTAby+9dmdyb6hGS
         YGgZx1QVW9Rt+6dxZgwuZ3dUCJjYYbK59nOyPUjlGqJQ1iuKK4ZGTYLLdAs1TJc/xWLk
         kHvQ==
X-Gm-Message-State: APjAAAVLcGsibtkeeG5ibtgV5gg3RatR8QUnYDPIJA0cqb4O6s9Ye+E+
        ckPMFZjOUw46Mx3TTDT6V1MNi2jUmwlm
X-Google-Smtp-Source: APXvYqw9SkimWRID5FQXcj1l45ZV6jcaTiJPKFiWkGZ749B8KdpSNU0Ah5D32BeFFUpZuynM9OB9OISSi8Tw
X-Received: by 2002:a0c:ea90:: with SMTP id d16mr120555qvp.27.1553121246494;
 Wed, 20 Mar 2019 15:34:06 -0700 (PDT)
Date:   Wed, 20 Mar 2019 15:28:44 -0700
Message-Id: <20190320222844.134765-1-furquan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH] drivers/acpi: Clear status of an event before enabling it
From:   Furquan Shaikh <furquan@google.com>
To:     robert.moore@intel.com, erik.schmauss@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org
Cc:     rajatja@google.com, evgreen@google.com, dlaurie@google.com,
        furquan@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 18996f2db918 ("ACPICA: Events: Stop unconditionally
clearing ACPI IRQs during suspend/resume") was added to stop clearing
of event status bits unconditionally on suspend and resume paths. This
was done because of an issue
reported (https://bugzilla.kernel.org/show_bug.cgi?id=196249) where
lid status stays closed even on resume (which happens because event
status bits are cleared unconditionally on resume). Though this change
fixed the issue on suspend path, it introduced regressions on several
resume paths.

First regression was reported and fixed on S5 path by the following
change: commit fa85015c0d95 ("ACPICA: Clear status of all events when
entering S5"). Next regression was reported and fixed on all legacy
sleep paths by the commit f317c7dc12b7 ("ACPICA: Clear status of all
events when entering sleep states"). However, regression still exists
on S0ix sleep path since it does not follow the legacy sleep path.

In case of S0ix, events are enabled as part of device suspend path. If
status bits for the events are set when they are enabled, it could
result in premature wake from S0ix. This change ensures that status is
cleared for any event that is being enabled so that any stale events
are cleared out.

Signed-off-by: Furquan Shaikh <furquan@google.com>
---
 drivers/acpi/acpica/evgpe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 62d3aa74277b4..61455ab42fc87 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -81,8 +81,12 @@ acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
 
 	ACPI_FUNCTION_TRACE(ev_enable_gpe);
 
-	/* Enable the requested GPE */
+	/* Clear the GPE (of stale events) */
+	status = acpi_hw_clear_gpe(gpe_event_info);
+	if (ACPI_FAILURE(status))
+		return_ACPI_STATUS(status);
 
+	/* Enable the requested GPE */
 	status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
 	return_ACPI_STATUS(status);
 }
-- 
2.21.0.225.g810b269d1ac-goog

