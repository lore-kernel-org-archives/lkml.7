Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035EFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B7720685
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JyfizXZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfC1TfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:35:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51187 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbfC1Tem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:34:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id z11so73770wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 12:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VZSQTQ1ZP4ZmuIHcXxYVuYkA6kF+7ceY+tTJP+fs9dA=;
        b=JyfizXZ5jMFVmhU5oTPLaxiFKORKEfxLz9XGyIkmVXkwhAr3usQVtcIOhhYzpmHM/J
         PkkEYCe3XLpPLln3/3j5AtL6/hhro1QcM+VxpxNrWmpjsrrwYlxggpoD6GXPDb4TEUht
         Xn6YtWKCg6aGH5A3mWqefXHYdeIRFE5C2aQcHI8F5b8VI4G8n3+7d0EaOTq3xpqvF1Zy
         0ZnCYjpmU31TNJAWmB/JnJCeSBbgq/uMmuinQHBwVsZ9I0HlKmVgGs1hQ+eNb9UJfK9P
         JeafZWIseM4ljxDoIw7v2DjEF4frcbDhlPv9zD0kUVpXj5Oca9FpCzIGfcGIDA5Js2EX
         Qdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VZSQTQ1ZP4ZmuIHcXxYVuYkA6kF+7ceY+tTJP+fs9dA=;
        b=TovNR6nWChreItIKdaZ35qlcJGnQq5r5RAK54BA28LrZoZu96ixnaSlzPA/X4FRWR3
         jXGQQuFPjqgGxTHos/8XZ6YCQCAdf9i/DJSvo8RDWDY5PIjCGTW6K1k+PUMk5QJs9hak
         fEOVnkAWkoN0G1V7Nyp+12eK69jZodIWufs1MoIvA0kD0lZaTLfmnzn/S8SIgncdYN6m
         9wARpNM1tH0VsPP8dsntDILCG7+hCLMeVxZYYazaPVpl+ASMmQM2QvQy9sV6PxY6HxV4
         7ISkqpHJIl9/BTbeE9ly0UJ6npIFybEAS4StpYrLS7OaFvlErxMhqxPpJULUw/SuAfEw
         H/tw==
X-Gm-Message-State: APjAAAUGNAcRlI4kD292l+5hU/v2Q5OGGYWZD8Wgo9EDG1fXxY69V/95
        sVanR5iwSfm0jsbol+88+w6iSvlXsMYmrA==
X-Google-Smtp-Source: APXvYqzweWjHBkNX1KWJbabxJgh1mCl8p+JpGU6tQYL8MI8eVygKPYRnpOeYY6Kx4RK8t6+x/hWgXQ==
X-Received: by 2002:a1c:eb14:: with SMTP id j20mr1150854wmh.32.1553801680174;
        Thu, 28 Mar 2019 12:34:40 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:dd62:8a50:1468:989d])
        by smtp.gmail.com with ESMTPSA id d6sm27739186wrx.62.2019.03.28.12.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 12:34:39 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/5] efifb: omit memory map check on legacy boot
Date:   Thu, 28 Mar 2019 20:34:26 +0100
Message-Id: <20190328193429.21373-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328193429.21373-1-ard.biesheuvel@linaro.org>
References: <20190328193429.21373-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 38ac0287b7f4 ("fbdev/efifb: Honour UEFI memory map attributes
when mapping the FB"), efifb_probe() checks its memory range via
efi_mem_desc_lookup(), and this leads to a spurious error message
"EFI_MEMMAP is not enabled" at every boot on KVM.  This is quite
annoying since the error message appears even if you set "quiet" boot
option.

Since this happens on legacy boot, which strangely enough exposes
a EFI framebuffer via screen_info, let's double check that we are
doing an EFI boot before attempting to access the EFI memory map.

Cc: Peter Jones <pjones@redhat.com>
Tested-by: Takashi Iwai <tiwai@suse.de>
Reported-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/video/fbdev/efifb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index ba906876cc45..9e529cc2b4ff 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -464,7 +464,8 @@ static int efifb_probe(struct platform_device *dev)
 	info->apertures->ranges[0].base = efifb_fix.smem_start;
 	info->apertures->ranges[0].size = size_remap;
 
-	if (!efi_mem_desc_lookup(efifb_fix.smem_start, &md)) {
+	if (efi_enabled(EFI_BOOT) &&
+	    !efi_mem_desc_lookup(efifb_fix.smem_start, &md)) {
 		if ((efifb_fix.smem_start + efifb_fix.smem_len) >
 		    (md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT))) {
 			pr_err("efifb: video memory @ 0x%lx spans multiple EFI memory regions\n",
-- 
2.20.1

