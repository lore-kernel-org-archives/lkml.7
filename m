Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6117BC282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 05:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE692175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 05:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="DDHrHIG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfDWFEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 01:04:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34833 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDWFEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 01:04:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so6886755plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 22:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQF/GibJOWYoNi6DvMf3uTlLfCs4AKiZJg5TmKxfRJY=;
        b=DDHrHIG/SmOuTuzAhj0ntmbi3rgG812RvEv3fyd0ZSyPRBbSUjdChSjJaJ7+EbIAGT
         WmBGVV7CKHvUkjyS5KaTQBWTAIqAGKXkos/bhLzryK4pWfasLduBECoRdXantnlfSQvu
         fqGQefPgpOFk+9KeTfNmgmIMpMMuifwV/qdm+98BwrakTUt6PLd8eSNDiwiBo0LfLSF2
         3A8lYahumy53A6IIwaoxykmBeocmXYE0bZKYJYbgKKz+MVxlQcJpYT3xz32P/Y7uZ8er
         2OcCQ1cuRLn20ABPbmRKF9pgHTKgv5ijdKeTpFbD5wKM5+WXAASTisYTG8sphxUjTtiH
         rQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dQF/GibJOWYoNi6DvMf3uTlLfCs4AKiZJg5TmKxfRJY=;
        b=XShSsLydrAhGygPjzD+NZHhECsgZRmHmX0C6NomTokCUDzhd4ZvEy+SgIyIz/RrbGs
         MG0b4bnaZLO7qIqFfCaJ5/414NCpWM2ioxMWFMK9aORzu6fWGzFyVTTXNRmYe2flA+PX
         otN1AB4RPbUPz8KEI9wv7MFGSNQv5ZX0n2j26jb3mNs0zidawRSZq4c808Nq5xzIEpBF
         Ke3wu+t5WUR8zOJ+hRkWe99r+sQThNuhZNPb6zIT+IEhrTrac0cwBsDrAasnnK+7Y2bJ
         yh0eNyqQrbrPXPRIM0KeydwxZewz/Srdmk5OjBwPM1aNmToZto+daZ5g7CBlI656TE+k
         4ahQ==
X-Gm-Message-State: APjAAAXj3mS7gJ6ou7vbD8As+wciXnyCZYk4EyOy5d2sYcUziAHXpPx8
        VSEUr6no+KyLVF+tffIuyKbp4Q==
X-Google-Smtp-Source: APXvYqzimo7HeSXhBrtj+E4HAK6XTEONx9JKo4sSLoOcnvqSxsQW4pQnGVjhaM1+PLR21gcjwbterA==
X-Received: by 2002:a17:902:5a3:: with SMTP id f32mr21411731plf.82.1555995843782;
        Mon, 22 Apr 2019 22:04:03 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id f71sm25880669pfc.109.2019.04.22.22.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 22:04:03 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        len.brown@intel.com, rafael.j.wysocki@intel.com,
        linux@endlessm.com, hdegoede@redhat.com
Subject: [PATCH 2/2] x86/ioapic: avoid timer manipulation when IRQ0 timer is unavailable
Date:   Tue, 23 Apr 2019 13:03:54 +0800
Message-Id: <20190423050354.8025-2-drake@endlessm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190423050354.8025-1-drake@endlessm.com>
References: <20190423050354.8025-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New products based on Intel Apollo Lake are appearing where the HPET is
not present in ACPI, and the legacy 8254 PIT is "gated" by default in
the BIOS setup menu.

This leads an early boot "IO-APIC + timer doesn't work!" kernel panic
on a black screen (before the framebuffer is initialized).

Avoid the IO-APIC IRQ0 timer manipulation & verification on platforms
where the legacy IRQ0 timer has been determined as unavailable.

This fixes boot on Connex L1430 and Scope SN116PYA with default BIOS
settings.

Signed-off-by: Daniel Drake <drake@endlessm.com>
Link: https://lkml.kernel.org/r/CAD8Lp45fedoPLnK=UmUhhtkjy5u2h04sYKrx3U+m04U6FpVZ4A@mail.gmail.com
---
 arch/x86/kernel/apic/io_apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index ae46da48c07b..2d29c62abbcb 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2243,7 +2243,7 @@ void __init setup_IO_APIC(void)
 	sync_Arb_IDs();
 	setup_IO_APIC_irqs();
 	init_IO_APIC_traps();
-	if (nr_legacy_irqs())
+	if (global_clock_event && nr_legacy_irqs())
 		check_timer();
 
 	ioapic_initialized = 1;
-- 
2.19.1

