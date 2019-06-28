Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A30AC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778232086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfF1Oqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 10:46:36 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37015 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfF1Oqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:46:35 -0400
Received: by mail-qt1-f193.google.com with SMTP id y57so6571788qtk.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 07:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ukm6QwjiR6v3c/fXg6msKYDD+XPWCXV7vWmtJTq9N64=;
        b=Kvzcd1sCuB2BOPjHnJeI4uvJhjNOD9fjXX5sDar/h9R/pytEhwW3UUaLzL6GII6yor
         J6H8j3kTH6CIrVZe6+fvbuzoGp0ipIT12tVcGk1V90aXax6zB0ZzXCf6Vxxty+rJm86/
         QyQvEfWD87rBDoVpSGoH9XC+MRSZ9vV720hcwHg6BdlvaWvjpvyTR9YBi46Iy+FSqxGl
         9FNhc0GEjSGF/tGwjSi8V7ZOXbU6sBVTt/qNqY5Kyl/SE6odIkPt4V8JqdnNx/2scChp
         ctg/6LhwsObCODus4P2ot+ulbYrUbI/XORnWg4IxWzGjDkcETg48uPfqK4NU/UDQGjgc
         V7mw==
X-Gm-Message-State: APjAAAU7xRF02AjReAWz1Rfhv4aFcrGBpqRaY87eJDBU44M4jAyk0qAm
        5ik3ekkFOW5Va7HWKrwIDUxecLtk1KD3kaXflN4=
X-Google-Smtp-Source: APXvYqxiaUSAuPM+A2aREImpYskXzz89M9yJIOi+OtsVZitkSsQckIsCjhrF38dp9elJ5g7LFRpNW3aVZW8X6qRP1qw=
X-Received: by 2002:a0c:b758:: with SMTP id q24mr8545628qve.45.1561733194702;
 Fri, 28 Jun 2019 07:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190628104007.2721479-1-arnd@arndb.de> <20190628124422.GA9888@infradead.org>
 <CAK8P3a1jwPQvX6f+eMZLdnF2ZawDB9obF3hjk2P9RJxDr6HUQA@mail.gmail.com> <20190628131738.GA994@infradead.org>
In-Reply-To: <20190628131738.GA994@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 28 Jun 2019 16:46:14 +0200
Message-ID: <CAK8P3a0t+vGge8uDOuwex6j+ddaUqovxCXoJOO8Ec3z6_brvsg@mail.gmail.com>
Subject: Re: [PATCH] f2fs: fix 32-bit linking
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Qiuyang Sun <sunqiuyang@huawei.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Eric Biggers <ebiggers@google.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 3:17 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Jun 28, 2019 at 03:09:47PM +0200, Arnd Bergmann wrote:
> > I came across this on arm-nommu (which disables
> > CONFIG_CPU_SPECTRE) during randconfig testing.
> >
> > I don't see an easy way to add this in there, short of rewriting the
> > whole __get_user_err() function. Any suggestions?
>
> Can't we just fall back to using copy_from_user with a little wrapper
> that switches based on sizeof()?

I came up with something now. It's not pretty, but seems to satisfy the
compiler. Not a proper patch yet, but let me know if you find a bug.

This might contain a double uaccess_save_and_enable/uaccess_restore,
not sure how much we care about that.

     Arnd

index 7e0d2727c6b5..c21cdecadf26 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -307,6 +307,7 @@ static inline void set_fs(mm_segment_t fs)
 do {                                                                   \
        unsigned long __gu_addr = (unsigned long)(ptr);                 \
        unsigned long __gu_val;                                         \
+       unsigned long long __gu_val8;                                   \
        unsigned int __ua_flags;                                        \
        __chk_user_ptr(ptr);                                            \
        might_fault();                                                  \
@@ -315,10 +316,13 @@ do {
                         \
        case 1: __get_user_asm_byte(__gu_val, __gu_addr, err);  break;  \
        case 2: __get_user_asm_half(__gu_val, __gu_addr, err);  break;  \
        case 4: __get_user_asm_word(__gu_val, __gu_addr, err);  break;  \
+       case 8: __get_user_asm_dword(__gu_val8, __gu_addr, err);break;  \
        default: (__gu_val) = __get_user_bad();                         \
        }                                                               \
        uaccess_restore(__ua_flags);                                    \
-       (x) = (__typeof__(*(ptr)))__gu_val;                             \
+       (x) = __builtin_choose_expr(sizeof(*(ptr)) == 8,                \
+               (__typeof__(*(ptr)))__gu_val8,                          \
+               (__typeof__(*(ptr)))__gu_val);                          \
 } while (0)

 #define __get_user_asm(x, addr, err, instr)                    \
@@ -373,6 +377,8 @@ do {
                         \
        __get_user_asm(x, addr, err, ldr)
 #endif

+#define __get_user_asm_dword(x, addr, err)                     \
+       do { err = raw_copy_from_user(&x, (void __user *)addr, 8) ?
-EFAULT : 0; } while (0)

 #define __put_user_switch(x, ptr, __err, __fn)                         \
        do {                                                            \
