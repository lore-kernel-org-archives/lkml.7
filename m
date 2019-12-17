Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABE6C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8931720CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfLQA4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 19:56:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbfLQA4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 19:56:44 -0500
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A48BE206D3;
        Tue, 17 Dec 2019 00:56:42 +0000 (UTC)
Subject: Re: Build regressions/improvements in v5.5-rc2
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <20191216083658.21386-1-geert@linux-m68k.org>
 <CAMuHMdUaRdyRigwS+fdju1_PQCahONVFPKu0DbX6hhb7=JXmLA@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <cfc86b96-9d28-eebc-c7f7-1ed9a1e28458@linux-m68k.org>
Date:   Tue, 17 Dec 2019 10:56:39 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUaRdyRigwS+fdju1_PQCahONVFPKu0DbX6hhb7=JXmLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 16/12/19 6:49 pm, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Mon, Dec 16, 2019 at 9:38 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> Below is the list of build error/warning regressions/improvements in
>> v5.5-rc2[1] compared to v5.4[2].
> 
>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/d1eef1c619749b2a57e514a3fa67d9a516ffa919/ (all 232 configs)
>> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/219d54332a09e8d8741c1e1982f5eae56099de85/ (all 232 configs)
> 
>>    + /kisskb/src/arch/m68k/include/asm/string.h: warning: '__builtin_memcpy' forming offset [3, 4] is out of the bounds [0, 2] of object '__gu_val' with type 'short unsigned int' [-Warray-bounds]:  => 72:25
> 
> The upgrade from gcc 4.6.3 to 81.0 seems to have revealed a potential
> issue in get_user() in arch/m68k/include/asm/uaccess_no.h.
> 
>          #define get_user(x, ptr)                                        \
>          ({                                                              \
>              int __gu_err = 0;                                           \
>              typeof(x) __gu_val = 0;                                     \
>              ^^^^^^^^^
>              This is the type of the destination
> 
>              switch (sizeof(*(ptr))) {                                   \
>              case 1:                                                     \
>                  __get_user_asm(__gu_err, __gu_val, ptr, b, "=d");       \
>                  break;                                                  \
>              case 2:                                                     \
>                  __get_user_asm(__gu_err, __gu_val, ptr, w, "=r");       \
>                  break;                                                  \
>              case 4:                                                     \
>                  __get_user_asm(__gu_err, __gu_val, ptr, l, "=r");       \
>                  break;                                                  \
>              case 8:                                                     \
>                  memcpy((void *) &__gu_val, ptr, sizeof (*(ptr)));       \
>                  break;                                                  \
>              default:                                                    \
>                  __gu_val = 0;                                           \
>                  __gu_err = __get_user_bad();                            \
>                  break;                                                  \
>              }                                                           \
>              (x) = (typeof(*(ptr))) __gu_val;                            \
>              __gu_err;                                                   \
>          })
> 
> ext2_ioctl() calls this like
> 
>          unsigned short rsv_window_size;
>          if (get_user(rsv_window_size, (int __user *)arg)) { ... }
> 
> So a 32-bit value is being copied to an unsigned short value, leading
> to the warning (for the memcpy() in the non-taken "case 8" branch).
> 
> Fortunately the compiler emits a register move for this, so no real harm
> is done:
> 
>          | fs/ext2/ioctl.c:123:          if (get_user(rsv_window_size,
> (int __user *)arg))
>                  move.l 48(%sp),%a0      | arg,
>          #APP
>          | 123 "fs/ext2/ioctl.c" 1
>                  movel (%a0),%d2 | *arg.32_43, __gu_val
> 
> The corresponding code in arch/m68k/include/asm/uaccess_mm.h
> uses a temporary __gu_val of the right sized type based on the source
> type to avoid this.

Yeah, your right. I will put a change together to fix.

Regards
Greg

