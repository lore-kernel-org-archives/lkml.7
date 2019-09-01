Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48401C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 15:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12EB0216C8
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 15:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZawCEt2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfIAPiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 11:38:16 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33336 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfIAPiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 11:38:15 -0400
Received: by mail-qk1-f196.google.com with SMTP id x134so340645qkb.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:in-reply-to:references:date:message-id:subject:to;
        bh=jCmxqEGUh8e6zNEKhQJ1OzteQZrlIaKkPuNQBE7sy4c=;
        b=ZawCEt2iORrRGfxIwVP1PihacwKFnbiJdYms2Xrx5m+jEwNIR/iAY8we6Wxq+oLFZI
         Dz9JnRVRA2NrkRutv8z2se/olSzT+T62pkN0An+cbOSr/KeaxFlqGBAtF5J0e972pNtC
         V7RzgKn1Ao52zsp3M96qAvqXm19sP5+Pv2IdptWxrSfsQ38nIRbDbu4qz/etcWNcjIcW
         8ZGAXbaBmehP6N9gj9NcO93GkT8PXnPdPvUjFvi73tCMzMoNjLhaUwbFenU3dxOfKt2d
         kWGWkYj3wYLTualUw9Dv1aaBIuPxylaiEfXmziPiJ67N+hhphvWdGsTs1p3FTApjYohS
         z6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:in-reply-to:references:date
         :message-id:subject:to;
        bh=jCmxqEGUh8e6zNEKhQJ1OzteQZrlIaKkPuNQBE7sy4c=;
        b=Krq5M2v48JJDJg+MjckoV4R1m8FK+I41WrxA5mjX6SKBiMKg9rZgitgDdf+n8C8GV3
         bu54yjtx0AxY1Gx35n13pD1mhZJqBZ3pBcIAepsfgwlocGIwQBDQKdXKZDP5GDeGaCdy
         4XNplYdqfbGM30d9nWXf5e0zCeeKWba24Yjzx4Jtan9AMeh2B+3hSTmxG4iSMsf7ND76
         g9gmxsfiN1MFYKDcz/yjMF9vUmHXzIVl/s/pWEY0IT71PPBqKTuQvFHDrZhlmYoBCoxw
         Ot2N88mW0UyKamoHi5EzDJAo45A35rZXJbM2k08K5U2kduZeBHRl93Bxm8Zp++IQw7UO
         iQTQ==
X-Gm-Message-State: APjAAAW80CUu2YSIJ0Ogk+Hdl8k88WrPZjGXG8qcLbE5P/vlTLfOH6gz
        mEFCAipIRUsGiFl2jy7H80yAuxNyeM0tiR+RcB2i25AmLvY=
X-Google-Smtp-Source: APXvYqzcx8OD6Rs7aGy61HSBZgWSECktLcjly5nC2sHE169i9afJ7w5R1oIdfNjhNJop2AL//pA3k/czYRFSzD57sxE=
MIME-Version: 1.0
X-Received: by 2002:ae9:ee06:: with SMTP id i6mr24363014qkg.496.1567352294500;
 Sun, 01 Sep 2019 08:38:14 -0700 (PDT)
Received: from 329980741037 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 1 Sep 2019 17:38:13 +0200
From:   John S Gruber <JohnSGruber@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20190731054627.5627-2-jhubbard@nvidia.com>
References: <20190731054627.5627-2-jhubbard@nvidia.com>
Date:   Sun, 1 Sep 2019 17:38:13 +0200
Message-ID: <CAPotdmTa-cAeTVkHkRWj0x27b0ME0X7=YMkfdGkBRoEk5zUw+w@mail.gmail.com>
Subject: [PATCH] x86/boot: Fix regression--secure boot info loss from
 bootparam sanitizing
To:     john.hubbard@gmail.com, bp@alien8.de, hpa@zytor.com,
        jhubbard@nvidia.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org,
        JohnSGruber@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "John S. Gruber" <JohnSGruber@gmail.com>

commit a90118c445cc ("x86/boot: Save fields explicitly, zero out everything
else") now zeros the secure boot information passed by the boot loader or
by the kernel's efi handover mechanism.

Include boot-params.secure_boot in the preserve field list.

Signed-off-by: John S. Gruber <JohnSGruber@gmail.com>
---

I noted a change in my computers between running signed 5.3-rc4 and 5.3-rc6
with signed kernels using the efi handoff protocol with grub. The kernel
log message "Secure boot enabled" becomes "Secure boot could not be
determined". The efi_main function in arch/x86/boot/compressed/eboot.c sets
this field early but it is subsequently zeroed by the above referenced commit
in the file arch/x86/include/asm/bootparam_utils.h

Applies to 5.3-rc6.

 arch/x86/include/asm/bootparam_utils.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/bootparam_utils.h
b/arch/x86/include/asm/bootparam_utils.h
index 9e5f3c7..981fe92 100644
--- a/arch/x86/include/asm/bootparam_utils.h
+++ b/arch/x86/include/asm/bootparam_utils.h
@@ -70,6 +70,7 @@ static void sanitize_boot_params(struct boot_params
*boot_params)
 			BOOT_PARAM_PRESERVE(eddbuf_entries),
 			BOOT_PARAM_PRESERVE(edd_mbr_sig_buf_entries),
 			BOOT_PARAM_PRESERVE(edd_mbr_sig_buffer),
+			BOOT_PARAM_PRESERVE(secure_boot),
 			BOOT_PARAM_PRESERVE(hdr),
 			BOOT_PARAM_PRESERVE(e820_table),
 			BOOT_PARAM_PRESERVE(eddbuf),
-- 
2.7.4
