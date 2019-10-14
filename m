Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F08C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC1F20873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="piPpFXEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbfJNP4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:56:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46006 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730102AbfJNP4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:56:24 -0400
Received: by mail-pl1-f194.google.com with SMTP id u12so8177713pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 08:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ysKHeAWhWiDqGIO4lKEHL4zmOQ8xwTlvBSOxqXeT+Gg=;
        b=piPpFXEnmFYl2yN5xlBQ8v7jl+7es3ZESwSR23NsPFjmV+VSDOXWWzPfxkmdL5bPpI
         yxUz3Z//K3ZDelbiqMeDuDMpHXxUax1O6OeBwi0E9jYed6D7xqWrfkBbqfVNkW6e/Vbo
         HMUqA9aVLm6NH25Bk1mWbz22RvMIuTRjRoHIKO46oq7dW/bgMyZ5pN22PPv8C43YDdTx
         /QeE5zVtKwe63NL9k2LgAXCcAx+AVWKyKkxNHsO7fyG0l6WH15wEshK2jiwNJDk9x7oC
         o6A6NDynOkZRzaEb7dEfWYEtltI1XFyVLJYpsyNBdeC+PQ7i1OXwrAxiiJdh5BwK3PYs
         XKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ysKHeAWhWiDqGIO4lKEHL4zmOQ8xwTlvBSOxqXeT+Gg=;
        b=arEVCSTjBCSIct1C+q5fU5GEijSWkD4Atgdr2UWg1E4ePsuWE57juhHciTF4UlX+B2
         ZblNjH1bs1/JqlQV0ssytGBTY1ChJip7onUmpV3zUjb7VhgEm1yTt/oBIN6BaVdetaVZ
         pGWbFGWZznyT3b23EEhZ32eSM65lmugWB359X/ErjXsM90y3s+2mZMW7OWmflrl155C7
         H/A2edYZEIDgZqeA8usDiIPOsZb7WixRzJoVrzgpZ0R4hA0BsD23xb+fPP5qreYeft80
         Z/c++nspQC/fB7c3y/DpHcXDTasMCbGIwVwToFHX3M9v13TrrIEvr/ymnL5bNc8qPuRu
         82vA==
X-Gm-Message-State: APjAAAXKEFXyRsobg6Pla59db1FydMaSp94Q4u6IYDmtpsxHVhmEeeKw
        2Ak9UeYYWwGAhPhA3QZooMO4MEgiUPtQE3PJUYDVQw==
X-Google-Smtp-Source: APXvYqz/xhBeS3yRQP8QI+260d6U9shHcuPTuMGyKyNKNIVgIxg2p2GheW0ZfaMUeplnFXv2gl+6LVj7eNvm2RFQGS0=
X-Received: by 2002:a17:902:9b83:: with SMTP id y3mr30287723plp.179.1571068583499;
 Mon, 14 Oct 2019 08:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190911182049.77853-1-natechancellor@gmail.com>
 <20191014025101.18567-1-natechancellor@gmail.com> <20191014025101.18567-4-natechancellor@gmail.com>
 <20191014093501.GE28442@gate.crashing.org>
In-Reply-To: <20191014093501.GE28442@gate.crashing.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 14 Oct 2019 08:56:12 -0700
Message-ID: <CAKwvOdmcUT2A9FG0JD9jd0s=gAavRc_h+RLG6O3mBz4P1FfF8w@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] powerpc/prom_init: Use -ffreestanding to avoid a
 reference to bcmp
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 2:35 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Sun, Oct 13, 2019 at 07:51:01PM -0700, Nathan Chancellor wrote:
> > r374662 gives LLVM the ability to convert certain loops into a reference
> > to bcmp as an optimization; this breaks prom_init_check.sh:
>
> When/why does LLVM think this is okay?  This function has been removed
> from POSIX over a decade ago (and before that it always was marked as
> legacy).

Segher, do you have links for any of the above? If so, that would be
helpful to me. I'm arguing against certain transforms that assume that
one library function is faster than another, when such claims are
based on measurements from one stdlib implementation. (There's others
in the pipeline I'm not too thrilled about, too).

The rationale for why it was added was that memcmp takes a measurable
amount of time in Google's fleet, and most calls to memcmp don't care
about the position of the mismatch; bcmp is lower overhead (or at
least for our libc implementation, not sure about others).
-- 
Thanks,
~Nick Desaulniers
