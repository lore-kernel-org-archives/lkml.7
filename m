Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDAFECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C1A20663
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNSQmhS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbfJOU0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 16:26:42 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:37911 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfJOU0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:26:41 -0400
Received: by mail-qt1-f180.google.com with SMTP id j31so32579023qta.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 13:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GvhT2QXQ0GgfNEOJ+UXo4IMteX3tSISiPGXC9WqcO04=;
        b=RNSQmhS1SULpv8GZPCiu5asQAlQF6Idx3EhdWxGneLmOdNMY9oR8myuMsapb1DryrK
         JBD6v8okCUJuTqICjRdcFSYW1axwy9SxM+N0lWTx6tlO6SPJIcCz19WgfLDH/PiXDs88
         ozWURoS8goNos1zOqmD9OC2VT8ARi5cisOYuCuWxKln5eFQgkcEkOf0GGWawAijG2ZzB
         UKBxQ5Xj7mVy4DL0SGFNrROu0T4HRn0ookLg1iEIBE08ArG8ToWHPwViGxIzfVXTNXlo
         bSRxYFAzZJ/vm0edZXfUtkOSRC0I7tsOTSe+omVg/ruYNOINoAVUx9uPuTQSkFO0XNcd
         t9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GvhT2QXQ0GgfNEOJ+UXo4IMteX3tSISiPGXC9WqcO04=;
        b=SmfiToQOESlbE/i/Ufs+W6WUv/C5eB3JziJd6ljlBFBPMTdBv5txiY2IhD/XAyydvV
         JLlBFoYH/e66Z/58icJFtG+Sj+tQnpe3AiasWuhkScqusKBxj/liWFCEgZU7p+DLK3WJ
         nGIENkUhpZW9tPOi9wsiKQJ61c1VDjnKzgQmeS+XjL6BJCwrkBOtIDqx0iaR5hyEOD61
         p7pnImkaSZHDCnhEEe5Z+GFmvUmhpaicuV4e5yYd8bKjS5a+zPbRE6R8y/Gi0WT3dgzF
         PhzGc7bcSkqKPUXkEOQE0PYyXARfhJj+jXGVY+hJLudw47qbLVU5ZL/lk/imuyajOQ9e
         iwvQ==
X-Gm-Message-State: APjAAAV+zXAc1ogNzvKojxNNBRnDaTrLmj38f5yMtI0H8W6/Gvni+9xK
        XuGqzaX7hcojz80czia81t0=
X-Google-Smtp-Source: APXvYqwtYOxc82LyDC2x14XH4mC20IbSYpCrolbjZ14JzYy7i9d3lsO8aDajJqSlG0bphVKBySVxfQ==
X-Received: by 2002:ac8:6a06:: with SMTP id t6mr18025686qtr.169.1571171200885;
        Tue, 15 Oct 2019 13:26:40 -0700 (PDT)
Received: from rani ([2001:470:1f07:5f3:9e5c:8eff:fe50:ac29])
        by smtp.gmail.com with ESMTPSA id u43sm12322018qte.19.2019.10.15.13.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 13:26:40 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani>
Date:   Tue, 15 Oct 2019 16:26:38 -0400
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, "S, Shirish" <sshankar@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "yshuiv7@gmail.com" <yshuiv7@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Matthias Kaehlcke <mka@google.com>,
        "S, Shirish" <Shirish.S@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: AMDGPU and 16B stack alignment
Message-ID: <20191015202636.GA1671072@rani>
References: <CAKwvOdnDVe-dahZGnRtzMrx-AH_C+2Lf20qjFQHNtn9xh=Okzw@mail.gmail.com>
 <9e4d6378-5032-8521-13a9-d9d9519d07de@amd.com>
 <CAK8P3a3_Q15hKT=gyupb0FrPX1xV3tEBpVaYy1LF0kMUj2u8hw@mail.gmail.com>
 <CAKwvOdnLxm_tZ_qR1D-BE64Z3QaMC2h79ooobdRVAzmCD_2_Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdnLxm_tZ_qR1D-BE64Z3QaMC2h79ooobdRVAzmCD_2_Sg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 11:05:56AM -0700, Nick Desaulniers wrote:
> Hmmm...I would have liked to remove it outright, as it is an ABI
> mismatch that is likely to result in instability and non-fun-to-debug
> runtime issues in the future.  I suspect my patch does work for GCC
> 7.1+.  The question is: Do we want to either:
> 1. mark AMDGPU broken for GCC < 7.1, or
> 2. continue supporting it via stack alignment mismatch?
> 
> 2 is brittle, and may break at any point in the future, but if it's
> working for someone it does make me feel bad to outright disable it.
> What I'd image 2 looks like is (psuedo code in a Makefile):
> 
> if CC_IS_GCC && GCC_VERSION < 7.1:
>   set stack alignment to 16B and hope for the best
> 
> So my diff would be amended to keep the stack alignment flags, but
> only to support GCC < 7.1.  And that assumes my change compiles with
> GCC 7.1+. (Looks like it does for me locally with GCC 8.3, but I would
> feel even more confident if someone with hardware to test on and GCC
> 7.1+ could boot test).
> -- 
> Thanks,
> ~Nick Desaulniers

If we do keep it, would adding -mstackrealign make it more robust?
That's simple and will only add the alignment to functions that require
16-byte alignment (at least on gcc).

Alternative is to use
__attribute__((force_align_arg_pointer)) on functions that might be
called from 8-byte-aligned code.

It looks like -mstackrealign should work from gcc 5.3 onwards.
