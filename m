Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F2FC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 20:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA75A20659
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 20:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tvfmu6fN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKYUP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 15:15:29 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38472 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfKYUP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 15:15:29 -0500
Received: by mail-pj1-f66.google.com with SMTP id f7so7107828pjw.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 12:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XE60qzqDDu/QSjZjM0/sTKyHZau5FHQqXZ2FkpPYMQ4=;
        b=Tvfmu6fNo0X7N2hDoy1ZSL5LaOeluQOOtwT+s5EGjVd6BOcRLYs4xGowdfCdk51tO6
         AhMuMoJNLGPjiTx3JdosGUR4BFsD3dbMLWPgodWZYMtGvgXPtNVnwQH/VbpyP6sA3GqC
         skb5v6u+BoD56WLQ2UhJ0lzRcKLqv+uvyd553G3k7VZO8xO3IH81VyVziblEBh8hsyRW
         fBl0mYMeRIVesm+JZZB8iL8n1sr/ASSIuhO5/p2vPmUdO+g4TO0ypBpnF1vuKC90i+IG
         RkPNLrs5bZrJRNBh8fjBNm2oH4mnKvMyBLhpLH6pDqhZ34I3eubl5ETq0//t7QdHOgNE
         xGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XE60qzqDDu/QSjZjM0/sTKyHZau5FHQqXZ2FkpPYMQ4=;
        b=IUxCFcMCOv+9MPZ4DUAY4rcDcI4RIdoXGOppASjWpIFcEQOylKfboeDYbLzz8rijWH
         MFXMsepsTF6RWZggHwLTNzgdPgRB+YTVqP+BAP20rB/pD4sU1np5/D4E5Ien/8fI8zci
         pUUrxpaWgEVUeClCmh0F1edbJMEXSsNnKcHuXXfCZJytGScX+X2NFMnIYPSxr1boXzWC
         GrRbZqpPb4NuhipET8eifq1Vr3mgYIq8P/hV4e8q/Blwx8Wd0V5on5GML8jAMumKxDUb
         A9hc+aBBNZCrzqUonPwntedzbZL2Jr3k8lWGAE8MfAB6cr6PCLNJMz5UA2KRadvO/XJ4
         UXzw==
X-Gm-Message-State: APjAAAX8c61dy/rzz6fW1/+s8mqvCg9BMpiLZjlovS6A1yH7oaIwsbr1
        oPE71mA9egS3+FHaMI2GxNi97vQjG9E8MXWQ8JRvaw==
X-Google-Smtp-Source: APXvYqwZYrafkMC3y4LZBHlZmLbkinEnmRRGqd2iB0KYH6aoz+ch5bNaghIA+nnyiYgF9bK/LY57MupABQMOzzPNfv0=
X-Received: by 2002:a17:90a:be05:: with SMTP id a5mr1039257pjs.73.1574712928322;
 Mon, 25 Nov 2019 12:15:28 -0800 (PST)
MIME-Version: 1.0
References: <20191014025101.18567-1-natechancellor@gmail.com> <20191119045712.39633-1-natechancellor@gmail.com>
In-Reply-To: <20191119045712.39633-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Nov 2019 12:15:17 -0800
Message-ID: <CAKwvOd=3Ok8A8V30fccK5UzWFZ7zwG_zvGQV44S2BK4o2akbgw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] LLVM/Clang fixes for a few defconfigs
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,
Do you have feedback for Nathan? Rebasing these patches is becoming a
nuisance for our CI, and we would like to keep building PPC w/ Clang.

On Mon, Nov 18, 2019 at 8:57 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Hi all,
>
> This series includes a set of fixes for LLVM/Clang when building
> a few defconfigs (powernv, ppc44x, and pseries are the ones that our
> CI configuration tests [1]). The first patch fixes pseries_defconfig,
> which has never worked in mainline. The second and third patches fixes
> issues with all of these configs due to internal changes to LLVM, which
> point out issues with the kernel.
>
> These have been broken since July/August, it would be nice to get these
> reviewed and applied. Please let me know what I can do to get these
> applied soon so we can stop applying them out of tree.
>
> [1]: https://github.com/ClangBuiltLinux/continuous-integration
>
> Previous versions:
>
> v3: https://lore.kernel.org/lkml/20190911182049.77853-1-natechancellor@gmail.com/
>
> v4: https://lore.kernel.org/lkml/20191014025101.18567-1-natechancellor@gmail.com/
>
> Cheers,
> Nathan
>
>


-- 
Thanks,
~Nick Desaulniers
