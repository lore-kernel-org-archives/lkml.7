Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86CBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E81C2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OpcZij6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfCRVbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:31:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41680 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfCRVbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 17:31:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id d25so12136983pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 14:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=prKybN5sZfBvxBOuL9eOPh4Faqkcy2UYoDwlR1QrSqE=;
        b=OpcZij6XfefS/zIp6CoYfpTMXFVv3Av9wzggQWg/Bm2GPDkcALNVrl4amcL8b+5dcj
         BPaU001SnLTIGH+QR3/suGkyM+yQFMkDSVaHE/JPKmP6XiIiUHfH+9EKBxpGDhY1z0vw
         pErRMwo1hn6qpAEV9z+9IMfAaM312Ttq8p8no=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=prKybN5sZfBvxBOuL9eOPh4Faqkcy2UYoDwlR1QrSqE=;
        b=GYXuqIDeVsaZ46sdC1blItqEEKDaB7ZM1X29XQxK4CJCUZNWxqZjjMzLq/ZnzeeR32
         a4lybV9uCFbVVkzye8AxnlPXXXNQZIPGHMaq6rhaw8EkT60IrO5SzmYhLVKdocwU80K5
         X8nQnt4wI2OWnDHn6QuvsCo7Iok/vfJY6FiD52p5dJdntZ4BEERxeU4pTmQ3AscPLTNI
         zwWsiDWmkbldzdM+C8lpRCYHPso8o5IJfLdqQNedkt5blSM36vJstBxo/ZqPDkWkuuf9
         PMrrV9KnomVMxQX4Axtzm3ql4fhGONR8OQYMD2Gm7GFMuWQf9tF50j1XeModO9mOOJWm
         ZCmg==
X-Gm-Message-State: APjAAAVW/GImH2c5R0/lacjX3gBsQIP8epf2T09tJ/ql/iVuQ5VsHM7p
        dR5KHgwm/xYipUkHZRg19xEt4w==
X-Google-Smtp-Source: APXvYqz2bMAinLdsfvGSLC9d96xxhbdd3ccadqAVRXteeyCjaM4WXhZtBhp6CukCT39SwZgdRwFkFw==
X-Received: by 2002:a65:47cb:: with SMTP id f11mr19763137pgs.18.1552944675319;
        Mon, 18 Mar 2019 14:31:15 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id v9sm18523883pfg.130.2019.03.18.14.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 14:31:14 -0700 (PDT)
Date:   Mon, 18 Mar 2019 14:31:13 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] lib: Add shared copy of __lshrti3 from libgcc
Message-ID: <20190318213113.GI112750@google.com>
References: <CAG5bF+S6OvBnsaR6UpMCqjDR9_hMo6qRMHGiW+iCaRYQW4C3YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG5bF+S6OvBnsaR6UpMCqjDR9_hMo6qRMHGiW+iCaRYQW4C3YA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 01:54:50PM -0700, Matthias Kaehlcke wrote:
> The compiler may emit calls to __lshrti3 from the compiler runtime
> library, which results in undefined references:
> 
> arch/x86/kvm/x86.o: In function `mul_u64_u64_shr':
>   include/linux/math64.h:186: undefined reference to `__lshrti3'
> 
> Add a copy of the __lshrti3 libgcc routine (from gcc v4.9.2).
> 
> Include the function for x86 builds with clang, which is the
> environment where the above error was observed.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

With "Revert "kbuild: use -Oz instead of -Os when using clang"
(https://lore.kernel.org/patchwork/patch/1051932/) the above
error is fixed, a few comments inline for if the patch is
resurrected in the future because __lshrti3 is emitted in a
different context.

> diff --git a/include/linux/libgcc.h b/include/linux/libgcc.h
> index 32e1e0f4b2d0..a71036471838 100644
> --- a/include/linux/libgcc.h
> +++ b/include/linux/libgcc.h
> @@ -22,15 +22,26 @@
>  #include <asm/byteorder.h>
> 
>  typedef int word_type __attribute__ ((mode (__word__)));
> +typedef int TItype __attribute__ ((mode (TI)));

Consider using __int128 instead. Definition and use need a
'defined(__SIZEOF_INT128__)' guard  (similar for mode (TI)), since
these 128 bit types aren't supported on all platforms.

>  #ifdef __BIG_ENDIAN
>  struct DWstruct {
>  	int high, low;
>  };
> +
> +struct DWstruct128 {
> +	long long high, low;
> +};

This struct isn't needed, struct DWstruct can be used.

> diff --git a/lib/lshrti3.c b/lib/lshrti3.c
> new file mode 100644
> index 000000000000..2d2123bb3030
> --- /dev/null
> +++ b/lib/lshrti3.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/export.h>
> +#include <linux/libgcc.h>
> +
> +long long __lshrti3(long long u, word_type b)

use TItype for input/output, which is what gcc does, though the above
matches the interface in the documentation.

> +{
> +	DWunion128 uu, w;
> +	word_type bm;
> +
> +	if (b == 0)
> +		return u;
> +
> +	uu.ll = u;
> +	bm = 64 - b;
> +
> +	if (bm <= 0) {
> +		w.s.high = 0;
> +		w.s.low = (unsigned long long) uu.s.high >> -bm;

include <linux/types.h> and use u64 instead of unsigned long long.
