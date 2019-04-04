Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83F7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983CE20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kd5rMP1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfDDAdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:33:36 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:54149 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfDDAdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:33:33 -0400
Received: by mail-yw1-f74.google.com with SMTP id 68so723996ywb.20
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 17:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3FVj0Vux23rW7dwNJJDnKT59ZHynyqjKA3q4fn8QSso=;
        b=kd5rMP1Qtyn082YVhSc0Jd3M947vR51IQTEVj2AYZe7cP2NTWS4KxRVONQxH1eCAHY
         uvwAEXznChwulgOwt2Boe2ySEQwdCbPfh7kQoYHty5eAl3+zzx7niYRClw2AtT2KwaJb
         RuL2vZbSfNY58VDgVp1bDUeyn7GIHu0NUo/P4ytyqVubpRSETOMI0RRAe9HOmTbZmI5H
         7o5SSn0FVGFdJsLWtzQwd7sQ7dq5p2N0JmoExed3CG/CxjtgBgcvgRxnnhqCxmxa78X4
         G6ejZSklQZTk5KWaEsE7h/NVEBp/kgyj6aCo94XIBgZC03f4VTnaUttGivPPzWWz+eLm
         1I+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3FVj0Vux23rW7dwNJJDnKT59ZHynyqjKA3q4fn8QSso=;
        b=Er+fVQf71o/LDPjneiXEE5je5cVvESLlxeY0JFazJYYBYc6LUi0hi3Xpkr+ir7kwVF
         II1eZ5jN/1zoMpgiQSVEPtDYC11JQR19lDP5n1PTGuTf1JXfkXMS6xsTR7nfLZzcYkES
         oFyNL2ooO2R2jYM5tjKIo5MTEg2pxriI/CSchRVM6rOsneVcoa1dl3Tr6qBvmKdVsHmA
         UUDCjnCVN2Xm/0MA7jbwIRa1sGFBlIJ77Vy3kolKzEYxNCpQAGX141SDfwVQY0EJW2yu
         zNnaQAAnl1rH1SHezf6K1JdSf8V8YZ0C0B5lz8jYwBhSeRTnwd4FFB/NPyU9zWE/K3dB
         UJRw==
X-Gm-Message-State: APjAAAUKpkXdHBv15OD0SFzHGq+14/Gt+MJ0GTwPfwtC3pdA9mRaUrUZ
        2+OyTVm/DB05qO3tTyaES5PdUwQNAJh0h3kGBMdDtQ==
X-Google-Smtp-Source: APXvYqyZGsoXxZX57FRqjS/kHN1FpnBpF2J5zqs2Z8EsQnYwyHHmXX6YlOc5guWmnvzwM2l/s+CJmp3VLb/oN0k2lb/5jA==
X-Received: by 2002:a25:3d85:: with SMTP id k127mr784700yba.101.1554338012791;
 Wed, 03 Apr 2019 17:33:32 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:37 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-16-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 15/27] acpi: Disable ACPI table override if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Linn Crosetto <linn@hpe.com>,
        Matthew Garrett <mjg59@google.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linn Crosetto <linn@hpe.com>

From the kernel documentation (initrd_table_override.txt):

  If the ACPI_INITRD_TABLE_OVERRIDE compile option is true, it is possible
  to override nearly any ACPI table provided by the BIOS with an
  instrumented, modified one.

When lockdown is enabled, the kernel should disallow any unauthenticated
changes to kernel space.  ACPI tables contain code invoked by the kernel,
so do not allow ACPI tables to be overridden if the kernel is locked down.

Signed-off-by: Linn Crosetto <linn@hpe.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/tables.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 48eabb6c2d4f..0dc561210c86 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -531,6 +531,11 @@ void __init acpi_table_upgrade(void)
 	if (table_nr == 0)
 		return;
 
+	if (kernel_is_locked_down("ACPI table override", LOCKDOWN_INTEGRITY)) {
+		pr_notice("kernel is locked down, ignoring table override\n");
+		return;
+	}
+
 	acpi_tables_addr =
 		memblock_find_in_range(0, ACPI_TABLE_UPGRADE_MAX_PHYS,
 				       all_tables_size, PAGE_SIZE);
-- 
2.21.0.392.gf8f6787159e-goog

