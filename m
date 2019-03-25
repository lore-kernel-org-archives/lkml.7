Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1DBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA18D206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VrMauZb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbfCYWMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:12:03 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:41549 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731014AbfCYWKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:35 -0400
Received: by mail-oi1-f201.google.com with SMTP id p131so4448060oif.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Du3LfKxiyrtDY9MxBnvqQFXXPhu80u18vHOumdetHcI=;
        b=VrMauZb+eQPOvofd+xivyKVFEkCCOvSF8qKqadOua3cMjf6D5TrZT1WMbTz8H7OVz0
         DTdtIpcsVj9NOl3gcpVjzhO4mVKMyvI92hijoEdACD7E9B0Ji7wOX5LjuH7s6YD/i25P
         Oseo8bd0Gl1AQ3njPd9plNxAfzUIRFQuLezCj97MS32mNFhMUCza34R5bNPVl8F8ku/k
         41yAMHG6zWtWCIuprn6o8f+ymsKRLuicHupSUH3sSaBODUhbYI42er5M3Ti7yr9LLFVL
         z43jrgjDfO9c9rGNDsQh765vnzu8REms7ZS1bs87OebwLENhNYfJV+1Eb8FDrFtWYkch
         N5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Du3LfKxiyrtDY9MxBnvqQFXXPhu80u18vHOumdetHcI=;
        b=TZzm0IKSeBrcKmvngCoT5LDlQf1z/XJ8gV498SYBzrNQZIuj+MOl0RhrLKuOp6LRmG
         f9q0AcmdR+ifvRwD71Z4uC5jc3FE5xVt79z7MAjK1PTIpcFda9inaxxDKtXEXnW1nD62
         8YettQXbTfsDKVvUGBDL4hejZtlkjo4Mgw5/blAp/FsQQhAWTQL7j/Pdbgemk/N/whEZ
         sPQ5TTgh6AKgGCBqFQ+ie+/RXDgXEAjwRJhLZ/v79FNv3LEQoNzYmvNQDJfca2irmoEi
         LVMt4hFcLd33k4WZVsTkkf6D1Ofdyj8/V8Y1Dm1swppusqScbgwy0IBcPW4PEs0Atjmp
         yAIw==
X-Gm-Message-State: APjAAAVh9jIKBgj/pAV28JM3HXAJuvSS3rNag86dQnhyhlNM/LxMNUGi
        nSGknDKvOo3KLL/31HrYy3+RyZgBZOaABPg5qH5YWg==
X-Google-Smtp-Source: APXvYqxDupMpWfLNMtoM3g47UnWhv4hMiRU+qH/WEMXcvRbfp6XpdqUzUlhxxmt1k3IP1YQclBpCIBQB4OZ6Pn0WW24s5A==
X-Received: by 2002:aca:4103:: with SMTP id o3mr13576902oia.71.1553551834252;
 Mon, 25 Mar 2019 15:10:34 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:41 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-15-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 14/27] acpi: Ignore acpi_rsdp kernel param when the kernel has
 been locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Josh Boyer <jwboyer@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-acpi@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Boyer <jwboyer@redhat.com>

This option allows userspace to pass the RSDP address to the kernel, which
makes it possible for a user to modify the workings of hardware .  Reject
the option when the kernel is locked down.

Signed-off-by: Josh Boyer <jwboyer@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Dave Young <dyoung@redhat.com>
cc: linux-acpi@vger.kernel.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 drivers/acpi/osl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f29e427d0d1d..3e44cef7a0cd 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -194,7 +194,7 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 	acpi_physical_address pa;
 
 #ifdef CONFIG_KEXEC
-	if (acpi_rsdp)
+	if (acpi_rsdp && !kernel_is_locked_down("ACPI RSDP specification"))
 		return acpi_rsdp;
 #endif
 	pa = acpi_arch_get_root_pointer();
-- 
2.21.0.392.gf8f6787159e-goog

