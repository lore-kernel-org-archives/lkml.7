Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0263C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 11:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9434D20862
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 11:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldLaiCWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfEYL0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 07:26:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34497 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfEYL0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 07:26:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id f8so12392533wrt.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 04:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3Jmq85Hmw2WeX8gpf6pOoI0z6l9EWC+tkDaeefNI1o=;
        b=ldLaiCWcwfHAzZPNr/OkUNDMUtsFV81IstXNblmin3fdJrm4WBVKshRjXDYhIAQGBQ
         YY0iQMRNPSYJF6qcuAJkt7xpff8wZ0jJz5jlK+eHCCWOUNHE5hlTpG5KKUhAF2ecJSby
         GoqQ6l2PIL8dO7MkQqUO/BktFQiyWYqJJ/ZaAQZCLEdU9K/Lh4gVl5rPBxtOBAgB5JIR
         oHvWxA3a5EaoGbJ7eTpo9bY5gsLTmyqgGnErLbZwf1N+G0luqYe2ffMgu/2zwK6S8K27
         x9w9tWA7y6bRVWuj9YK2dCXCG08Vwv06MPwBnBldyvei5VDF+cmJ1Z3AiAXbLKLSeBEu
         u6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3Jmq85Hmw2WeX8gpf6pOoI0z6l9EWC+tkDaeefNI1o=;
        b=j6niKBlDHG8+hDfx5L9HEbvdnea/Fvdr52wNefUhsGWSQvyg0OB88P1EkUYBf8jAX8
         pmzJmm/NcPDQ0Z9pWqr7vBgD5FCyFnPs9xuZXFyk2SR4ZOHYF5lQOuv0gzhFU9X3JeZ+
         u0sVG4X7ew6VHw2D1WTkaw+WDpfWo1CKtqJf1EmbDYQW5udooodyZYsVUO6UJ3zWpi0k
         6KUdbK2JnemYfVStoIlj5PTmXzHOtaMvpiHe9kpBbBOvNmAjYj3Q6Bdm1SqnXIlzGyx8
         l6GdNRXgbMiZxCqseiAFmX3Lc3Ahf1/jkNx0lfYSygz9W2U6J2SNkVKQsDgtk3CL3EsN
         p4BA==
X-Gm-Message-State: APjAAAWHQoG9egW2vkoQ3pBd09fWYXTCsPPfngSdsMkrjZf5eAhx2Rms
        ervCqInfVmFCWLo0PW8iFN4PIg==
X-Google-Smtp-Source: APXvYqy+jHj17CyeDcnuuzBRgIjzq+0LH01TDDqXY29xxw4IQdwZmhUcOU+muNgW0OCl981nMxs5sQ==
X-Received: by 2002:adf:dc12:: with SMTP id t18mr6275253wri.61.1558783563569;
        Sat, 25 May 2019 04:26:03 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:3ccc:7074:9336:6a6e])
        by smtp.gmail.com with ESMTPSA id y16sm4942010wru.28.2019.05.25.04.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 04:26:02 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Gen Zhang <blackgod016574@gmail.com>,
        Rob Bradford <robert.bradford@intel.com>
Subject: [GIT PULL 0/2] EFI fixes for v5.2
Date:   Sat, 25 May 2019 13:25:57 +0200
Message-Id: <20190525112559.7917-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent

for you to fetch changes up to a7decd94d514721f8bf5da02e3ae66758b80603a:

  efi: Allow the number of EFI configuration tables entries to be zero (2019-05-25 13:10:50 +0200)

----------------------------------------------------------------
A pair of low priority EFI fixes for v5.2:
- deal with systems where EFI does not expose a single configuration table
- add missing handling for memory allocation failures to x86 old_map code

----------------------------------------------------------------
Gen Zhang (1):
      efi/x86: Add missing error handling to old_memmap 1:1 mapping code

Rob Bradford (1):
      efi: Allow the number of EFI configuration tables entries to be zero

 arch/x86/platform/efi/efi.c    | 2 ++
 arch/x86/platform/efi/efi_64.c | 9 ++++++---
 arch/x86/platform/efi/quirks.c | 3 +++
 drivers/firmware/efi/efi.c     | 3 +++
 4 files changed, 14 insertions(+), 3 deletions(-)
