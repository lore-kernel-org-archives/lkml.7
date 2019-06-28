Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C80C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAD1208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KZBLPQg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfF1R67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 13:58:59 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:50412 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfF1R67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nvwlS5cEOUMLkB+OhiPPpM/PP0fhgF6+Us0z9niErA0=; b=KZBLPQg0yuaGK05D9EFvOg8O6
        /VO2uZ7BTAY+eap/rHqsq20zusigPDhLwZdOZgY2S8MP3oiVJdWlxsBTpts6bp54KxfCK9qa373NG
        Y8pUHaduBn/pu+BJ5FZKgE32+FW50/mEQJComcAn6nX2zFTqEyvrv14WjDrTN7W655daMtR+q4zjp
        KINwlY0kzhhp2gSiTRjFz0Qi9Yp13U866ZLoaYO1z5gjnSr1fWBbaU+JqJJnluNEjhrNJRXTDWGnr
        UB0p89k+ITurKGjpv0aOLRvxPr1WlegmFNAbrwAMUEY0t0O7fXfhYDJ7iOQ/G16IOKDHislSnYnlD
        j2ogFiZaQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60106)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hgv8x-00024o-RA; Fri, 28 Jun 2019 18:58:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hgv8t-0001gS-E5; Fri, 28 Jun 2019 18:58:35 +0100
Date:   Fri, 28 Jun 2019 18:58:35 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Qiuyang Sun <sunqiuyang@huawei.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Eric Biggers <ebiggers@google.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] f2fs: fix 32-bit linking
Message-ID: <20190628175835.hwzfrgrtwphi6kka@shell.armlinux.org.uk>
References: <20190628104007.2721479-1-arnd@arndb.de>
 <20190628124422.GA9888@infradead.org>
 <CAK8P3a1jwPQvX6f+eMZLdnF2ZawDB9obF3hjk2P9RJxDr6HUQA@mail.gmail.com>
 <20190628131738.GA994@infradead.org>
 <CAK8P3a0t+vGge8uDOuwex6j+ddaUqovxCXoJOO8Ec3z6_brvsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0t+vGge8uDOuwex6j+ddaUqovxCXoJOO8Ec3z6_brvsg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 04:46:14PM +0200, Arnd Bergmann wrote:
> On Fri, Jun 28, 2019 at 3:17 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Fri, Jun 28, 2019 at 03:09:47PM +0200, Arnd Bergmann wrote:
> > > I came across this on arm-nommu (which disables
> > > CONFIG_CPU_SPECTRE) during randconfig testing.
> > >
> > > I don't see an easy way to add this in there, short of rewriting the
> > > whole __get_user_err() function. Any suggestions?
> >
> > Can't we just fall back to using copy_from_user with a little wrapper
> > that switches based on sizeof()?
> 
> I came up with something now. It's not pretty, but seems to satisfy the
> compiler. Not a proper patch yet, but let me know if you find a bug.

Have you checked what the behaviour is when "ptr" is a pointer to a
pointer?  I think you'll end up with a compiler warning for every
case, complaining about casting an unsigned long long to a pointer.

> 
> This might contain a double uaccess_save_and_enable/uaccess_restore,
> not sure how much we care about that.
> 
>      Arnd
> 
> index 7e0d2727c6b5..c21cdecadf26 100644
> --- a/arch/arm/include/asm/uaccess.h
> +++ b/arch/arm/include/asm/uaccess.h
> @@ -307,6 +307,7 @@ static inline void set_fs(mm_segment_t fs)
>  do {                                                                   \
>         unsigned long __gu_addr = (unsigned long)(ptr);                 \
>         unsigned long __gu_val;                                         \
> +       unsigned long long __gu_val8;                                   \
>         unsigned int __ua_flags;                                        \
>         __chk_user_ptr(ptr);                                            \
>         might_fault();                                                  \
> @@ -315,10 +316,13 @@ do {
>                          \
>         case 1: __get_user_asm_byte(__gu_val, __gu_addr, err);  break;  \
>         case 2: __get_user_asm_half(__gu_val, __gu_addr, err);  break;  \
>         case 4: __get_user_asm_word(__gu_val, __gu_addr, err);  break;  \
> +       case 8: __get_user_asm_dword(__gu_val8, __gu_addr, err);break;  \
>         default: (__gu_val) = __get_user_bad();                         \
>         }                                                               \
>         uaccess_restore(__ua_flags);                                    \
> -       (x) = (__typeof__(*(ptr)))__gu_val;                             \
> +       (x) = __builtin_choose_expr(sizeof(*(ptr)) == 8,                \
> +               (__typeof__(*(ptr)))__gu_val8,                          \
> +               (__typeof__(*(ptr)))__gu_val);                          \
>  } while (0)
> 
>  #define __get_user_asm(x, addr, err, instr)                    \
> @@ -373,6 +377,8 @@ do {
>                          \
>         __get_user_asm(x, addr, err, ldr)
>  #endif
> 
> +#define __get_user_asm_dword(x, addr, err)                     \
> +       do { err = raw_copy_from_user(&x, (void __user *)addr, 8) ?
> -EFAULT : 0; } while (0)
> 
>  #define __put_user_switch(x, ptr, __err, __fn)                         \
>         do {                                                            \
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
