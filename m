Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C3BC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12A5208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkJr9A6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfEMTPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 15:15:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37403 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729234AbfEMTPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 15:15:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so441909wmo.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 12:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PxThcXQElVI91fi7m64BrSH6eJF9eKRKuatu0rpXtiA=;
        b=NkJr9A6BNcXWpAQOkQGs5yi+BsqG4+jd1NwObELbXnetvTywfesP6FGR7fRX8oN4p0
         F3gdptrv3yvWC9QgGz1NKXwpOEtuSMgPrF3FGNoyk6ASphdkzr5BKUUkZlKSNjWjhed2
         nXRSQTiaSCyXZfHbRh7s4dc49zOsKrV0xNgQckeadFVC1WOP3oxET0zuaRWiN9HQlDRU
         +K/00YfO8CFeQ3NSmR1AP5INJ5YoYe8TLzfVK27rKvoQ4JcQ4pRuHXofZulH48CH5UvG
         u7ptofrbRq4zsC5i2VomP9XnWae3DDw1bZ+cEAqXLCtbYfh+iLmUhaSAp5gOwMYhaopO
         AyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PxThcXQElVI91fi7m64BrSH6eJF9eKRKuatu0rpXtiA=;
        b=Mth/lmX6VfKgaQUfSNRMvOzA/eGi6u1kABsIuzuXBoC/kJ6SUxoatiCYW5KkhYu3ni
         thsnxyxWwwVHA1TcFKWx8Sd2sey1MHqRzPwzDM0TODxz0nwiMreBrfuoCQDtQVH+HZSm
         o29FO6U6hQ6SRdEXORIpnJuqeWaYDKxe7IS7JEwHyKqgh2woAKZEnSc9S7HfscXCI7+o
         TKjks8hYs0AMeRReGL05/SavulklZp+ySWasZNixtUd2eB1qKXXf87Ezgvy0ukc/fiXP
         IMAl3DB8SZcQXU6A5qImsBzmA0/yHSrqywSlPF08oZUfwAwb3GYUMdEQL6MFyfHh39ck
         bxqQ==
X-Gm-Message-State: APjAAAUkpbGcVv1oQt9T+n+HHW5bdS76CvKe5hJPLNbjQjd8K3a2pYE/
        pJNlHi/Pa10BKsc4ADlSFXsXFkI=
X-Google-Smtp-Source: APXvYqx4dIMN7CzriD9A4cTd7ina5RxiwjqvDU3bJ3Zr0XndeMDk3N+t9f84fF/FJMhCUYWcYz6yFQ==
X-Received: by 2002:a1c:1ad6:: with SMTP id a205mr4355150wma.80.1557774905276;
        Mon, 13 May 2019 12:15:05 -0700 (PDT)
Received: from avx2 ([46.53.253.112])
        by smtp.gmail.com with ESMTPSA id 4sm16264208wrf.61.2019.05.13.12.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 12:15:04 -0700 (PDT)
Date:   Mon, 13 May 2019 22:15:02 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     segoon@openwall.com, linux-kernel@vger.kernel.org
Subject: [PATCH] tweak LIST_POISON2 for better code generation on x86_64
Message-ID: <20190513191502.GA8492@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

list_del() poisoning can generate 2 64-bit immediate loads but it also
can generate one 64-bit immediate load and an addition:

	48 b8 00 01 00 00 00 00 ad de	movabs rax,0xdead000000000100
	48 89 47 58			mov    QWORD PTR [rdi+0x58],rax
	48 05 00 01 00 00   <=====>	add    rax,0x100
	48 89 47 60			mov    QWORD PTR [rdi+0x60],rax

However on x86_64 not all constants are equal: those within [-128, 127]
range can be added with shorter "add r64, imm32" instruction:

	48 b8 00 01 00 00 00 00 ad de	movabs rax,0xdead000000000100
	48 89 47 58			mov    QWORD PTR [rdi+0x58],rax
	48 83 c0 22	<======>	add    rax,0x22
	48 89 47 60			mov    QWORD PTR [rdi+0x60],rax

Patch saves 2 bytes per some LIST_POISON2 usage.

(Slightly disappointing) space savings on F29 x86_64 config:

	add/remove: 0/0 grow/shrink: 0/2164 up/down: 0/-5184 (-5184)
	Function                                     old     new   delta
	zstd_get_workspace                           548     546      -2
		...
	mlx4_delete_all_resources_for_slave         4826    4804     -22
	Total: Before=83304131, After=83298947, chg -0.01%

New constants are:

	0xdead000000000100
	0xdead000000000122

Note: LIST_POISON1 can't be changed to ...11 because something in page
allocator requires low bit unset.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/poison.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -21,7 +21,7 @@
  * non-initialized list entries.
  */
 #define LIST_POISON1  ((void *) 0x100 + POISON_POINTER_DELTA)
-#define LIST_POISON2  ((void *) 0x200 + POISON_POINTER_DELTA)
+#define LIST_POISON2  ((void *) 0x122 + POISON_POINTER_DELTA)
 
 /********** include/linux/timer.h **********/
 /*
