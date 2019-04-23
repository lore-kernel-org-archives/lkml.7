Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6441CC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D6421738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556045269;
	bh=ket1OMspX9R3zl6Qx5v01fnFNLhI6W1NQX4Gm5XsGts=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QMjMd/vsJBw/QyQpkn3u6gjhbIXb0iY4yTLu0WxCPSpalGRe5vxbq2UTXelUOoBbA
	 5+Si8RcKOGQ2r0z5/Zq3Ul1SgdQnDzTrV1VSKn0xonIXntAR/UKMwOQPbuA4EsWi/3
	 pSAJEMnHvJ6ZocfpHce8UHMtUANJWFnvnfMeQZ5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfDWSrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:47:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfDWSrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:47:48 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF9B021850
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 18:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556045267;
        bh=ket1OMspX9R3zl6Qx5v01fnFNLhI6W1NQX4Gm5XsGts=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mLvi2iBB1E8dkeQdNO8+2obcOrGOxLEBy+V8Nj7ye22AhOGa5d4jUPuLFc3y0DEU0
         qjvPuDWfafEQ+jH2idcOfbt5XSfaADNrVpEVEwVkQb5XoG4iPq+ZU1LYUGNV2zuOLG
         YgH41tmJrAFnkGy7LIbMQ4jRJiulenX4xPKs6T6g=
Received: by mail-wr1-f41.google.com with SMTP id a3so11939126wrx.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 11:47:46 -0700 (PDT)
X-Gm-Message-State: APjAAAXO5ZUTN3kzsVntrcms+aujaKCtzbZTQOKPS1q97IKDfUNeha8Q
        mglrWGnIVcdrXWXB2A3jzai9VOy8co/XDtPf4Rm0cw==
X-Google-Smtp-Source: APXvYqy9wgeBQNXeIag1wz2EFHXMIbZaQxkV7b2cZTmC7qh7R2UBL2UmqsGHIkr1JCDyZCYAY0pIU4PvF74CGFvFzPc=
X-Received: by 2002:a5d:4587:: with SMTP id p7mr11047795wrq.77.1556045265532;
 Tue, 23 Apr 2019 11:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAQwHRJL=3yD_7P2mMSVnwZbayww+dHC22+v4oTpMZv58w@mail.gmail.com>
In-Reply-To: <CAK7LNAQwHRJL=3yD_7P2mMSVnwZbayww+dHC22+v4oTpMZv58w@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 23 Apr 2019 11:47:34 -0700
X-Gmail-Original-Message-ID: <CALCETrVSM0vrMVr2y0ECAQ=tNGvBs=im2Kxongq-jvdzUBevbg@mail.gmail.com>
Message-ID: <CALCETrVSM0vrMVr2y0ECAQ=tNGvBs=im2Kxongq-jvdzUBevbg@mail.gmail.com>
Subject: Re: Does vdso_install attempt to re-compile objects under root privilege?
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 1:08 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi.
>
> I have a question about 'vdso_install'.
>
>
> In my understanding, vdso is embedded in the kernel.
> In addition, you can run 'make vdso_install'
> to install an unstripped version of vdso.
> (Mainly, debugging purpose?)
>
> By default, 'make vdso_install' will install it to
> /lib/modules/$(uname -r)/vdso/.
>
>
> Since that directly is owned by root,
> 'make vdso_install' could potentially be
> executed by root, isn't it?
>
>
> Currently, 'vdso_install' depends on vdso,
> so it may cause recompilation of objects
> in the source tree.

Hmm.  I suppose an alternative would be for vdso_install to fail if
the vdso isn't built?

What's the ideal outcome here?
