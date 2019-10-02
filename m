Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4159BC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1242086A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tdnoIcnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfJBRD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 13:03:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47094 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbfJBRD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:03:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id o18so20484744wrv.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 10:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4a/CPg2xqZ+b/NZpx616PMtohSxll231qGMOuYzcxWE=;
        b=tdnoIcnmIker0lvF0KY3CO60+cNs1URBTEXXNXeUHW2fshCRDEH9xmYdis8pb1fbyb
         vNRpKz04Fu+yWrCMZl4FUbI/pJEuRCInVKToqfVtof3VoXvgmrFZtNwmeBWMGXrl00xF
         FqVum7Wmu5DH4DDvKIL3nYWX00HsxNPaIzDN5jDm0hi91BB0lXTB58XpG5EYQ6fIvWns
         3YVbuJarZaqE5M9XLA0CmxLCQ7htEsQld6/RrO2fbgf84bF3w1DL/ozhBDdgqWWWOwyz
         NsAL2C7i/UyXnd35g6XPDzPh2xyrhVXOtrhyCG/WpIOwdMbI5nzYR9ztd3wtLNA46vQj
         HAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4a/CPg2xqZ+b/NZpx616PMtohSxll231qGMOuYzcxWE=;
        b=VT6w3bFtHsA38vmv+2X0dm2f0ZmjXnlEfCCDZIMbTsrza/3onblbS9bMLUtK1FVEfC
         Ku4Yeda3QiqjoDWPaqtOGQv/NIDZrzpKUtgzY5bOIixF+0VjLePESHohd/v4GDIblYyD
         pgVuJx3W9NSUVwOLuNtbUroNxGLz031Dr7k6WNVSjFikzIEGNTpMTUZrEmvSm6eBGGiZ
         hPxigNmxJ37HHamRzaFrx2K7PrURbTRFOSlbt9UFGzJLtOSg3mOficE3jV1aW6Q+FUZ8
         8v8EsbKseZQ45bH6GA92W0q79xNzPxnxdbjXPlKS6NApNcluXmYFndHiIcbRflS69Fdn
         9hBQ==
X-Gm-Message-State: APjAAAVOzclutW60vrywqRVk0HkoM5W7/JIOlr7ZwxaqU/HjgDCaiF9I
        9IGkFH0Ap10w70dyXCEjCvll3A==
X-Google-Smtp-Source: APXvYqzYraTwzohAp1cOr3JZijdPGRhdWNVm7YqHKQHJV7nNyafLy7wTF+k2v7yiQ67qhfcMavJB8Q==
X-Received: by 2002:adf:e849:: with SMTP id d9mr3616348wrn.358.1570035834376;
        Wed, 02 Oct 2019 10:03:54 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:f145:3252:fc29:76c9])
        by smtp.gmail.com with ESMTPSA id f18sm7085459wmh.43.2019.10.02.10.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 10:03:53 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Dave Young <dyoung@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>, Scott Talbert <swt@techie.net>
Subject: [PATCH 4/7] efi/tpm: don't traverse an event log with no events
Date:   Wed,  2 Oct 2019 18:59:01 +0200
Message-Id: <20191002165904.8819-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191002165904.8819-1-ard.biesheuvel@linaro.org>
References: <20191002165904.8819-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Jones <pjones@redhat.com>

When there are no entries to put into the final event log, some machines
will return the template they would have populated anyway.  In this case
the nr_events field is 0, but the rest of the log is just garbage.

This patch stops us from trying to iterate the table with
__calc_tpm2_event_size() when the number of events in the table is 0.

Fixes: c46f3405692d ("tpm: Reserve the TPM final events table")
Cc: linux-efi@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Peter Jones <pjones@redhat.com>
Tested-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Acked-by: Matthew Garrett <mjg59@google.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/tpm.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index 1d3f5ca3eaaf..b9ae5c6f9b9c 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -75,11 +75,16 @@ int __init efi_tpm_eventlog_init(void)
 		goto out;
 	}
 
-	tbl_size = tpm2_calc_event_log_size((void *)efi.tpm_final_log
-					    + sizeof(final_tbl->version)
-					    + sizeof(final_tbl->nr_events),
-					    final_tbl->nr_events,
-					    log_tbl->log);
+	tbl_size = 0;
+	if (final_tbl->nr_events != 0) {
+		void *events = (void *)efi.tpm_final_log
+				+ sizeof(final_tbl->version)
+				+ sizeof(final_tbl->nr_events);
+
+		tbl_size = tpm2_calc_event_log_size(events,
+						    final_tbl->nr_events,
+						    log_tbl->log);
+	}
 	memblock_reserve((unsigned long)final_tbl,
 			 tbl_size + sizeof(*final_tbl));
 	early_memunmap(final_tbl, sizeof(*final_tbl));
-- 
2.20.1

