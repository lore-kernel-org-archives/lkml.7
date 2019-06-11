Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B33C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC52820896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="q0N6rI6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388887AbfFKM7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 08:59:16 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33689 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388178AbfFKM7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:59:16 -0400
Received: by mail-qk1-f196.google.com with SMTP id r6so7553967qkc.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 05:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X0ZB3LW3l30Fq0eOwrGscIyWdot13e1MeQG3Y4BlhhY=;
        b=q0N6rI6xhARKRcW6Ya2FCtkBiYjzUAzFSTkEgxxIZAOslEZXdFIboouN8T2LC+fVqj
         p+OzCD0cG1I1C0Wv02OYas/jyrfCTmwB6F89Ko3PmpNyaRqth1NmE+f387L9J0EhlZ0r
         GL9pBM0QFB07INgVruPAtqOxK0I2S2tckSjeFJSH2zR/zAyBTFueShoopRrI3T95vAc0
         oVmB2vUppb69fgPNR2yaPytyfCRbNGU82poMJwNjWdfRr9yUYZNOlKLgDkUA97uIUCdj
         6aOrK7K8cBCyF6xr+ji0TGCLOW3LgorhOzpIIV4UuUOYR0UBr6CK6ZTMkSe4do/gvzcd
         6xuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X0ZB3LW3l30Fq0eOwrGscIyWdot13e1MeQG3Y4BlhhY=;
        b=SbEw/1KwruuJ7xxrUzeSnIByGCuu/+69z2gqXBfS1XdCb6dYSHbeZ5HpT9v6ckSXev
         ituFSmS+QWmHv8qN65l324uQanhcDmjJoHxJkxVqdxzh1SPaTLUpr9VrndRrCJt++9XN
         L8O7jUWeDK3rATZs6IYRlXgq3R2L7EKMbFeb5vX7Ljs7aSuyRL6301qLF1UdKJHS9Bnk
         pLKCp0jD+vQ5/x1743deiWXEElKTbP3S31vK2+vWRSL/bBd6XerdugjCpjpuBPc9rsH1
         wdFvJ22S9ALeRto0mCKA65vHUze0XWZp3i9LsnkqydLDzuubCvC+AHiEBERlvM3fsnep
         bYsw==
X-Gm-Message-State: APjAAAWvJxXOOxVUW799NHsfort6L+0PjICJk12JQccyy7FP48Qztot2
        /qsgOIFjMm7781aMWh/RWoFLdw==
X-Google-Smtp-Source: APXvYqyxOhNnNCOs8XADBDrWeen6Tnrd9g5qOv0NJvTvU36OXp+4MZv4LtDtwKG4J3qnxgsJH23rfQ==
X-Received: by 2002:a37:97c5:: with SMTP id z188mr21521259qkd.5.1560257955516;
        Tue, 11 Jun 2019 05:59:15 -0700 (PDT)
Received: from ovpn-122-116.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s35sm7784608qts.10.2019.06.11.05.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jun 2019 05:59:14 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     ard.biesheuvel@linaro.org
Cc:     mjg59@google.com, linux-efi@vger.kernel.org, bsz@semihalf.com,
        jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] efi/tpm: fix a compilation warning
Date:   Tue, 11 Jun 2019 08:59:04 -0400
Message-Id: <20190611125904.1013-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next "tpm: Reserve the TPM final events table" [1] introduced
a compilation warning,

drivers/firmware/efi/tpm.c: In function 'efi_tpm_eventlog_init':
drivers/firmware/efi/tpm.c:80:10: warning: passing argument 1 of
'tpm2_calc_event_log_size' makes pointer from integer without a cast
[-Wint-conversion]
  tbl_size = tpm2_calc_event_log_size(efi.tpm_final_log
drivers/firmware/efi/tpm.c:19:43: note: expected 'void *' but argument
is of type 'long unsigned int'

Fix it by making a necessary cast for the argument 1 of
tpm2_calc_event_log_size().

[1] https://lore.kernel.org/linux-efi/20190520205501.177637-3-matthewgarrett@google.com/

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/firmware/efi/tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index 74d0cd1647b8..1d3f5ca3eaaf 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -75,7 +75,7 @@ int __init efi_tpm_eventlog_init(void)
 		goto out;
 	}
 
-	tbl_size = tpm2_calc_event_log_size(efi.tpm_final_log
+	tbl_size = tpm2_calc_event_log_size((void *)efi.tpm_final_log
 					    + sizeof(final_tbl->version)
 					    + sizeof(final_tbl->nr_events),
 					    final_tbl->nr_events,
-- 
2.20.1 (Apple Git-117)

