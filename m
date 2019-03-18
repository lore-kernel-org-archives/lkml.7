Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A02DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA5B2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZBnkDSaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfCRXwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:52:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46838 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfCRXwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:52:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id s23so12344357pfe.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 16:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=knoGwR1xR7bLN1D5lJORYDM2nqlapCUSHZTd/MLXV0U=;
        b=ZBnkDSaRtwPe4a7p96VUbE8UCLVMkDaghByvxooKayPUYDaL8fvyWYFAJG4+0WUTy3
         1mKLBEaeD9IozEV/HKR/Z4VHnxAwyIqLfvdkMItSuQHZTDPInkWI/z4PvVrVUvOhprR/
         RumMT7qX18CiMuuWcel/z8JloQGEMF7/lImXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=knoGwR1xR7bLN1D5lJORYDM2nqlapCUSHZTd/MLXV0U=;
        b=ehxPCy2Juz7nz8zXKUArapU7zP8BSVg9Zr9+wB+CeYxdY8I5/zeU3gioXwifLe+cHd
         6k7Hxq4mkxuVHQPb7F+axV+N32fTDaVtqr00t+TfBt6BViBa42zU9Pwgk1jcOdGFb3HZ
         +Orn/cl7Q7fmFKnB4ewiU/pIoAuDB1mdIhWA0xJ5nUFL4zbGRYCYK6ULgqzXgzA5N1dG
         9dKUcBzgpm8DejSkj8lyeIuqNtCaQFjUCwHCOtmJZZHbrJBIQbz9ZwCFXWfXDubY3RGS
         o8jTnEwXaasl3HdBOXQNllX5YTZgswvtq0Jwb6DHmaNXgl5EbVMmo0QjsFr4QBAFMHv2
         rk4w==
X-Gm-Message-State: APjAAAVtaMVYkzgdNgHs/V+EAZH5VEj4BcB8Tb7W7TNJM250kxJjXMjq
        U7lZ1QHFxUPjqn8QqW2nyijZhw==
X-Google-Smtp-Source: APXvYqzoEnZ/B9lWC5rIQr1L3YAoHDjMfgcW1+xIn7VhvTnkFIJmisFGbik8vdiZ5MAFA8vldwBb/Q==
X-Received: by 2002:a62:4e8a:: with SMTP id c132mr21400068pfb.24.1552953140884;
        Mon, 18 Mar 2019 16:52:20 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id e8sm15134594pfn.103.2019.03.18.16.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 16:52:20 -0700 (PDT)
Date:   Mon, 18 Mar 2019 16:52:19 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     hpa@zytor.com
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] lib: Add shared copy of __lshrti3 from libgcc
Message-ID: <20190318235219.GL112750@google.com>
References: <CAG5bF+S6OvBnsaR6UpMCqjDR9_hMo6qRMHGiW+iCaRYQW4C3YA@mail.gmail.com>
 <20190318213113.GI112750@google.com>
 <25133BBA-9121-4B3A-865B-085BFC5F154C@zytor.com>
 <20190318221639.GK112750@google.com>
 <278CBEF0-9D09-4091-A630-73D912587383@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <278CBEF0-9D09-4091-A630-73D912587383@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 04:44:03PM -0700, hpa@zytor.com wrote:
> On March 18, 2019 3:16:39 PM PDT, Matthias Kaehlcke <mka@chromium.org> wrote:
> >On Mon, Mar 18, 2019 at 02:50:44PM -0700, hpa@zytor.com wrote:
> >> On March 18, 2019 2:31:13 PM PDT, Matthias Kaehlcke
> ><mka@chromium.org> wrote:
> >> >On Fri, Mar 15, 2019 at 01:54:50PM -0700, Matthias Kaehlcke wrote:
> >> >> The compiler may emit calls to __lshrti3 from the compiler runtime
> >> >> library, which results in undefined references:
> >> >> 
> >> >> arch/x86/kvm/x86.o: In function `mul_u64_u64_shr':
> >> >>   include/linux/math64.h:186: undefined reference to `__lshrti3'
> >> >> 
> >> >> Add a copy of the __lshrti3 libgcc routine (from gcc v4.9.2).
> >> >> 
> >> >> Include the function for x86 builds with clang, which is the
> >> >> environment where the above error was observed.
> >> >> 
> >> >> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> >> >
> >> >With "Revert "kbuild: use -Oz instead of -Os when using clang"
> >> >(https://lore.kernel.org/patchwork/patch/1051932/) the above
> >> >error is fixed, a few comments inline for if the patch is
> >> >resurrected in the future because __lshrti3 is emitted in a
> >> >different context.
> >> >
> >> >> diff --git a/include/linux/libgcc.h b/include/linux/libgcc.h
> >> >> index 32e1e0f4b2d0..a71036471838 100644
> >> >> --- a/include/linux/libgcc.h
> >> >> +++ b/include/linux/libgcc.h
> >> >> @@ -22,15 +22,26 @@
> >> >>  #include <asm/byteorder.h>
> >> >> 
> >> >>  typedef int word_type __attribute__ ((mode (__word__)));
> >> >> +typedef int TItype __attribute__ ((mode (TI)));
> >> >
> >> >Consider using __int128 instead. Definition and use need a
> >> >'defined(__SIZEOF_INT128__)' guard  (similar for mode (TI)), since
> >> >these 128 bit types aren't supported on all platforms.
> >> >
> >> >>  #ifdef __BIG_ENDIAN
> >> >>  struct DWstruct {
> >> >>  	int high, low;
> >> >>  };
> >> >> +
> >> >> +struct DWstruct128 {
> >> >> +	long long high, low;
> >> >> +};
> >> >
> >> >This struct isn't needed, struct DWstruct can be used.
> >> >
> >> >> diff --git a/lib/lshrti3.c b/lib/lshrti3.c
> >> >> new file mode 100644
> >> >> index 000000000000..2d2123bb3030
> >> >> --- /dev/null
> >> >> +++ b/lib/lshrti3.c
> >> >> @@ -0,0 +1,31 @@
> >> >> +// SPDX-License-Identifier: GPL-2.0
> >> >> +
> >> >> +#include <linux/export.h>
> >> >> +#include <linux/libgcc.h>
> >> >> +
> >> >> +long long __lshrti3(long long u, word_type b)
> >> >
> >> >use TItype for input/output, which is what gcc does, though the
> >above
> >> >matches the interface in the documentation.
> >> >
> >> >> +{
> >> >> +	DWunion128 uu, w;
> >> >> +	word_type bm;
> >> >> +
> >> >> +	if (b == 0)
> >> >> +		return u;
> >> >> +
> >> >> +	uu.ll = u;
> >> >> +	bm = 64 - b;
> >> >> +
> >> >> +	if (bm <= 0) {
> >> >> +		w.s.high = 0;
> >> >> +		w.s.low = (unsigned long long) uu.s.high >> -bm;
> >> >
> >> >include <linux/types.h> and use u64 instead of unsigned long long.
> >> 
> >> Ok, now I'm really puzzled.
> >> 
> >> How could we need a 128-bit shift when the prototype only has 64 bits
> >of input?!
> >
> >Good question, this is the code from libgcc:
> >
> >TItype
> >__lshrti3 (TItype u, shift_count_type b)
> >{
> >  if (b == 0)
> >    return u;
> >
> >  const DWunion uu = {.ll = u};
> >  const shift_count_type bm = (8 * (8)) - b;
> >  DWunion w;
> >
> >  if (bm <= 0)
> >    {
> >      w.s.high = 0;
> >      w.s.low = (UDItype) uu.s.high >> -bm;
> >    }
> >  else
> >    {
> >      const UDItype carries = (UDItype) uu.s.high << bm;
> >
> >      w.s.high = (UDItype) uu.s.high >> b;
> >      w.s.low = ((UDItype) uu.s.low >> b) | carries;
> >    }
> >
> >  return w.ll;
> >}
> >
> >
> >My compiler knowledge is limited, my guess is that the function is a
> >generic implementation, and while a long long is 64-bit wide under
> >Linux it could be 128-bit on other platforms.
> 
> Yes, long long is just plain wrong.
> 
> How could we end up calling this function on 32 bits?!

We didn't, in this case the function is called in 64-bit code
(arch/x86/kvm/x86.o: In function `mul_u64_u64_shr'), for the 32-bit
vDSO it was __lshrdi3.
