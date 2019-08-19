Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C158C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44AE42087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LctgZVBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfHSTgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:36:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39579 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfHSTgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:36:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id i63so549496wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 12:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=avD+mFYlLRhHip31YT9jTe2+g4CZ438qok9kWYIm/Lg=;
        b=LctgZVBpcZLMdLoRgzt+RYHH3QpCHSI+r0hhU4ALRyZmELsWQglNXjy5OTaAtDYtLc
         so+YtPCKh4EIdaBHLLUX2/ZUowEy8taauIMgSzKQGTLbXyxGkgDhOpQwJQ3HC+vi66vZ
         Z7d72DCMqvCxRrQY77+SUPknhdZGizPUlavTI9o9f+zE9pq4i23nY0gCywaBhhxwSQLQ
         mjbGoHAkWWhjO5H5Hl3xTjXB3S0BtARoruEeAxGZW0eIBYjiIktDm19Y7w4HUW4hpSSs
         9Re9Lh3M7Oq6r5lbQ+xQlogBN8GAiVqp5XwgLp2SjsARpvyNF8maiAD8fJWuvfz91qMH
         m1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=avD+mFYlLRhHip31YT9jTe2+g4CZ438qok9kWYIm/Lg=;
        b=UG/YkhPUwF7i/gTv18cVBdjU8VlSu4A277yi9z40oeGlMw961hCJdAyF86X2HqPTt8
         GjtUTO9hPY93GYfcNyex/s3Z02unR2vJ9TE/74snnxqtlOOKBmx8U55RXhBD290Y8Ebk
         mNlGHnVMA9C+ekZrkeQSROUbKTMj0KodwYmgKOXj6LrCB6EYn9aHhXLPDTbvM08ySh1g
         inUqF5FsHtC9omKrG/PhQTFREXFMnV4nHNCkv1ZeMC1kEKSzUSplfCFLYFUQEeBKMIga
         pm/r2Xg33EUOrPd1fkmMlreHz4eKlVtNRIYHVcilKrSmFRysq6vPnSpOnTxU4Bn/tSRi
         By7A==
X-Gm-Message-State: APjAAAWKf86b0G3UYYMrGR/xtEb3IIX2kXEAIyCbwhJjE/V8S/dCLZvY
        kQC8v99zp9rSGyA2mK1FrjAmPHAx
X-Google-Smtp-Source: APXvYqy58DTI+3r5fYpfA6g9C6MyEnTHM5CdJAVWVJTDlOrqocQhpdqP/HbBYxZO+OegPGRYxEysuw==
X-Received: by 2002:a7b:ce02:: with SMTP id m2mr9593499wmc.7.1566243410170;
        Mon, 19 Aug 2019 12:36:50 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f47:db00:69f9:84c:2cc6:baef? (p200300EA8F47DB0069F9084C2CC6BAEF.dip0.t-ipconnect.de. [2003:ea:8f47:db00:69f9:84c:2cc6:baef])
        by smtp.googlemail.com with ESMTPSA id l15sm12782894wru.56.2019.08.19.12.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 12:36:49 -0700 (PDT)
Subject: [PATCH v2 1/3] x86/irq: improve definition of VECTOR_SHUTDOWN et al
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <c81f3440-f4cc-65bc-66fd-abe9cb2ec318@gmail.com>
Message-ID: <146835e8-c086-4e85-7ece-bcba6795e6db@gmail.com>
Date:   Mon, 19 Aug 2019 21:34:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c81f3440-f4cc-65bc-66fd-abe9cb2ec318@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These values are used with IS_ERR(), so it's more intuitive to define
them like a standard PTR_ERR() of a negative errno.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/x86/include/asm/hw_irq.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index cbd97e22d..4154bc5f6 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -153,8 +153,8 @@ extern char irq_entries_start[];
 extern char spurious_entries_start[];
 
 #define VECTOR_UNUSED		NULL
-#define VECTOR_SHUTDOWN		((void *)~0UL)
-#define VECTOR_RETRIGGERED	((void *)~1UL)
+#define VECTOR_SHUTDOWN		((void *)-1L)
+#define VECTOR_RETRIGGERED	((void *)-2L)
 
 typedef struct irq_desc* vector_irq_t[NR_VECTORS];
 DECLARE_PER_CPU(vector_irq_t, vector_irq);
-- 
2.22.1


