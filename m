Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5ACEC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A7721743
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mPxLMpoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfD3UZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 16:25:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38279 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfD3UZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:25:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so7369634pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 13:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cZbWR8UVfZ8GI/ZAitfCAp4Uvgb8pmAiiJi8Ym1dyi0=;
        b=mPxLMpoXrjW84+Q+dAXzwjWJ9L1mxjS352qOAnO+1VCFDzPfebz3qqp2pN4tHOfFLB
         9gPyAEyVAoUBTWi9vlizYePWV/gIED0jBojgBoKtfkl0THUjpDKUvk+cx9EAx2t+YQ8I
         i+CVzWSecEmDbyCzSu/GmIJE3TROPyjQc+hd/u/Wi1pSM9sf0nMrBb5itinoLOoJNW2S
         FBNpyGM1d8oMm58eSxSTVOO3Qi1vpAiPg0bXUOOSnzcRXhHymgOVxuYjdED9DhMpa6do
         PLdlvIUGLSOnOolrYC/RrfrHLkLkaPftYndaxR5NWQyMvdnJzaK0+J1TqWglKBwnXuIb
         NpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cZbWR8UVfZ8GI/ZAitfCAp4Uvgb8pmAiiJi8Ym1dyi0=;
        b=VL5kKkwu60Vv0T530mcZzzAYGfA0cqU0Ro5UARZ5ZQnwvYjLe15i1gwQv+00e67Qy1
         FE2N3COmuLbDS7T+qeE3n8cGNggk8F3R0JYeHB2oog+0Ss4OejuKloP6iUAtMZYATGpC
         i426iaQR2SREJ533QyYTrvh9QsaZzqBHH5NIvRei2FU/TmSZOsiYqr0DDTafQyQz/Yf+
         xiAvYoaKR2vppDTzt8VNNfc9alOJVkP7lAsk+JcsDbxv9mj+4b4iPiFXuHsA5RVdnNdx
         BvgtMDlfkLVQZmjnFmd/RfND6vPhNV5lbQDyayO7eDwuHj0QAdhurO868A8621A7uCfx
         r3OA==
X-Gm-Message-State: APjAAAWICP20NrpVsOuo68K779Y8bTU/dTCvT2E2WjdeKokYV+SEs8/H
        KVQfSSyaxezUVvyk0zDAJRRWZWAQySW9Z6U9GaAluQ==
X-Google-Smtp-Source: APXvYqwcrOTSBIpt8uvCRs55U+qx6snTYGoytm6Fw7QoPc1UUSu1WG0QFpUFlFgyfNfj7Pzb+675wZlbrF28unvbtZ0=
X-Received: by 2002:a63:4558:: with SMTP id u24mr65997972pgk.225.1556655900784;
 Tue, 30 Apr 2019 13:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190423204821.241925-1-ndesaulniers@google.com>
In-Reply-To: <20190423204821.241925-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 30 Apr 2019 13:24:49 -0700
Message-ID: <CAKwvOd=ws1D95ydQjGtK0U0KQ-5poyj8Oek5Yka6-cvtCdpJ-g@mail.gmail.com>
Subject: Re: [PATCH] ia64: require -Wl,--hash-style=sysv
To:     tony.luck@intel.com, fenghua.yu@intel.com
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 1:48 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Towards the goal of removing cc-ldoption, it seems that --hash-style=
> was added to binutils 2.17.50.0.2 in 2006. The minimal required version
> of binutils for the kernel according to
> Documentation/process/changes.rst is 2.20.
>
> Link: https://gcc.gnu.org/ml/gcc/2007-01/msg01141.html
> Cc: clang-built-linux@googlegroups.com
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/ia64/kernel/Makefile.gate | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/ia64/kernel/Makefile.gate b/arch/ia64/kernel/Makefile.gate
> index f53faf48b7ce..846867bff6d6 100644
> --- a/arch/ia64/kernel/Makefile.gate
> +++ b/arch/ia64/kernel/Makefile.gate
> @@ -11,7 +11,7 @@ quiet_cmd_gate = GATE    $@
>        cmd_gate = $(CC) -nostdlib $(GATECFLAGS_$(@F)) -Wl,-T,$(filter-out FORCE,$^) -o $@
>
>  GATECFLAGS_gate.so = -shared -s -Wl,-soname=linux-gate.so.1 \
> -                    $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
> +                    -Wl,--hash-style=sysv
>  $(obj)/gate.so: $(obj)/gate.lds $(obj)/gate.o FORCE
>         $(call if_changed,gate)
>
> --
> 2.21.0.593.g511ec345e18-goog
>

bumping for review

-- 
Thanks,
~Nick Desaulniers
