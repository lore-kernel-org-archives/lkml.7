Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10645C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A1320675
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="oQfAPhS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfEFWBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 18:01:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40593 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfEFWBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 18:01:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id h11so17055180wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 15:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=S4Twu03W52bharsa28deUvAOBFbVqsnVCRBal8T2tGY=;
        b=oQfAPhS9wEp2Hx/ijqq21cAV95YxIUG1647G9PtYOSSleuxp5mZrScRa0zZvp5VU5a
         MKpOxUKUJ7zc0ntu3c3cyDm+S2AyISixmVGEwzG8+712WgunfQdFhpi+PrGqToLcXv9M
         GEx2/yukVtl9b3MFysNmAE062B+zlYL3tnRlYu60m76PPeVPmnvBxvYGPqOEOcVKldQD
         O6c/oR9fPpE35S2TTRjoS87gDt1zR04cFNPUwmbnsY7WSNlD+V2B5Ui9PoXDS8mRqM/z
         w5GQuIEiH4OXDjZEq/qdJL6Qiqm/6SyMIUeVrXMglBGS+NSd7sChSMvfyS3tV9q0st7z
         exUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=S4Twu03W52bharsa28deUvAOBFbVqsnVCRBal8T2tGY=;
        b=U3wak11gihqKU/J8En0nbMGnBopydoA2LIZ4QCMNklplrSW7CryOakfjq9U3rbN22t
         Njyn4dPya9oOyODvfv0vcqJcg0cld4aA7vlmN3IZwCKjOLIbvI5qfvnZc0sNXs0r7OZQ
         NHgEbiYSmQWhug0ONsETjK3HpnFQtvCUBwaD5izUAOaDtUExYmaRFHHyyzPFPPcVyyT6
         0H1LXkDBtgnIcAMsIStx/XH8B3ACaXkfNdFL3wqNGhKc6RTCltoP4Bn7TDkCbesxtF4N
         ecwlbNdiLm9tdn+23EZU+fbzAM+21kILEtQ0H92cgnvGMtltR20IrE1AbwCqhNh+PL4R
         ruwQ==
X-Gm-Message-State: APjAAAVoTvjXrjNgihQCfMM/UHlmfuDZo9U/8oqwDzHKDQDbtTl2KwdY
        zMOdOuKzaE5A0CZ/rb1cxl3+bQ==
X-Google-Smtp-Source: APXvYqy5MXXJj5NCf5sMcy/cSoD/6qHnzdqSqPsgxOtiPAMAiNdH/g9i6I8ljAUKBnOc3rJYLLw3uw==
X-Received: by 2002:a1c:9ad8:: with SMTP id c207mr18282602wme.109.1557180066808;
        Mon, 06 May 2019 15:01:06 -0700 (PDT)
Received: from LAPTOP-V3S7NLPL (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id r2sm27752186wrr.65.2019.05.06.15.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 15:01:05 -0700 (PDT)
References: <673b885183fb64f1cbb3ed2387524077@natalenko.name>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        oss-drivers@netronome.com, linux-kernel@vger.kernel.org,
        xdp-newbies@vger.kernel.org, valdis@vt.edu
Subject: Re: [oss-drivers] netronome/nfp/bpf/jit.c cannot be build with -O3
In-reply-to: <673b885183fb64f1cbb3ed2387524077@natalenko.name>
Date:   Mon, 06 May 2019 23:01:03 +0100
Message-ID: <87mujzutsw.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


'Oleksandr Natalenko' via OSS Drivers writes:

> Hi.
>
> Obligatory disclaimer: building the kernel with -O3 is a non-standard 
> thing done via this patch [1], but I've asked people in #kernelnewbies, 
> and it was suggested that the issue should be still investigated.
>
> So, with v5.1 kernel release I cannot build the kernel with -O3 anymore. 
> It fails as shown below:

I guess it's because constant prop. Could you try the following change to
__emit_shift?

drivers/net/ethernet/netronome/nfp/bpf/jit.c
__emit_shift:331
-       if (sc == SHF_SC_L_SHF)
+       if (sc == SHF_SC_L_SHF && shift)
                shift = 32 - shift;

emit_shf_indir is passing "0" as shift to __emit_shift which will
eventually be turned into 32 and it was OK because we truncate to 5-bit,
but before truncation, it will overflow the shift mask.

Regards,
Jiong

>
> ===
>    CC      drivers/net/ethernet/netronome/nfp/bpf/jit.o
> In file included from ./include/asm-generic/bug.h:5,
>                   from ./arch/x86/include/asm/bug.h:83,
>                   from ./include/linux/bug.h:5,
>                   from drivers/net/ethernet/netronome/nfp/bpf/jit.c:6:
> In function ‘__emit_shf’,
>      inlined from ‘emit_shf.constprop’ at 
> drivers/net/ethernet/netronome/nfp/bpf/jit.c:364:2,
>      inlined from ‘shl_reg64_lt32_low’ at 
> drivers/net/ethernet/netronome/nfp/bpf/jit.c:379:2,
>      inlined from ‘shl_reg’ at 
> drivers/net/ethernet/netronome/nfp/bpf/jit.c:2506:2:
> ./include/linux/compiler.h:344:38: error: call to 
> ‘__compiletime_assert_341’ declared with attribute error: BUILD_BUG_ON 
> failed: (((0x001f0000000ULL) + (1ULL << 
> (__builtin_ffsll(0x001f0000000ULL) - 1))) & (((0x001f0000000ULL) + (1ULL 
> << (__builtin_ffsll(0x001f0000000ULL) - 1))) - 1)) != 0
>    _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>                                        ^
> ./include/linux/compiler.h:325:4: note: in definition of macro 
> ‘__compiletime_assert’
>      prefix ## suffix();    \
>      ^~~~~~
> ./include/linux/compiler.h:344:2: note: in expansion of macro 
> ‘_compiletime_assert’
>    _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>    ^~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:37: note: in expansion of macro 
> ‘compiletime_assert’
>   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                       ^~~~~~~~~~~~~~~~~~
> ./include/linux/bitfield.h:57:3: note: in expansion of macro 
> ‘BUILD_BUG_ON_MSG’
>     BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
>     ^~~~~~~~~~~~~~~~
> ./include/linux/bitfield.h:89:3: note: in expansion of macro 
> ‘__BF_FIELD_CHECK’
>     __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
>     ^~~~~~~~~~~~~~~~
> drivers/net/ethernet/netronome/nfp/bpf/jit.c:341:3: note: in expansion 
> of macro ‘FIELD_PREP’
>     FIELD_PREP(OP_SHF_SHIFT, shift) |
>     ^~~~~~~~~~
> make[1]: *** [scripts/Makefile.build:276: 
> drivers/net/ethernet/netronome/nfp/bpf/jit.o] Error 1
> make: *** [Makefile:1726: drivers/net/ethernet/netronome/nfp/bpf/jit.o] 
> Error 2
> ===
>
> Needless to say, with -O2 this file is built just fine. My compiler is:
>
> ===
> $ gcc --version
> gcc (GCC) 8.3.0
> Copyright (C) 2018 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is 
> NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR 
> PURPOSE.
> ===
>
> I had no issues with -O3 before, so, maybe, this deserves a peek.
>
> I'm open to testing patches and providing more info if needed.
>
> Thanks.
>
> [1] 
> https://gitlab.com/post-factum/pf-kernel/commit/7fef93015ff1776d08119ef3d057a9e9433954a9

