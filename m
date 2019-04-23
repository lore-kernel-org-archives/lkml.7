Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7570C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB08218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b1hQObae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfDWWzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:55:25 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46226 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfDWWzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:55:24 -0400
Received: by mail-ua1-f67.google.com with SMTP id v7so5355611uak.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oy9gRu5tzjedctRvDXLHCBGVczTjecsuLTfKQl6LfHg=;
        b=b1hQObaeVDMw80MAbV8W+/fKz8LqfoMCIv+khTmuW7BsJTFcibVxlClrjhFa4uAemE
         Fvdqa8doL9d4D13CUdiXeqac5kyBSVGApDnP9k+VGcjKU1C8rlDzxXoLaCky+CbE7wBO
         3aD7zJ8Ec4juxCAffZ6LrbEQEaLhLfu5E5RMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oy9gRu5tzjedctRvDXLHCBGVczTjecsuLTfKQl6LfHg=;
        b=kAd20pmZtxsx/tSWcIuCF/s2efRDV5BMsQ+xN5FS2N6eIew5qQ0q7xcDgowEdBoXjQ
         MNDtq0dUaPaGTpLzo0R/LMMoo0c3jESeklabQiEVk1xkQl/kh4H+qBIMFHW9gNtPHJIs
         IK6bGxK/A97q2pZlF6MLgQc57BGI/R1NOdTjwaoCGRd9GDejbo1K6tsXi+fMD2Gp3XS/
         EPip6Pepl8pKp+hAat4gjYpqVAKQhCMfG+nR70xlEdtG848GsYbwStJs5HVlBuvB4/Gy
         Ae6OHyMtVfv9KcGbGvFYVZVn6RtUWbCeGkm2DhRmibLktQ8jVfSZCj2WJ3LSFSRjSE8b
         u9GQ==
X-Gm-Message-State: APjAAAVNV2NRhQ4adB6rfKFdN/qzItsEZgz43U2TOcByKwrnQbYBXOGD
        XIRZIvFSybv3zL6VMAxNGQkoHLdVbN0=
X-Google-Smtp-Source: APXvYqwSvr2mFSWa5lny9vYlbPkGSLQRyXGA1WGFz5BrT7BjDwpkP4FQ8zBdMXJtjebF9OgPLRi3RQ==
X-Received: by 2002:ab0:73d3:: with SMTP id m19mr13764124uaq.46.1556060122804;
        Tue, 23 Apr 2019 15:55:22 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id l9sm2916908uae.1.2019.04.23.15.55.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:55:21 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id l22so5371795uao.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:55:20 -0700 (PDT)
X-Received: by 2002:a9f:2d88:: with SMTP id v8mr3856042uaj.2.1556060120319;
 Tue, 23 Apr 2019 15:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190415143821.GA46880@beast>
In-Reply-To: <20190415143821.GA46880@beast>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Apr 2019 15:55:07 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJmJLc41XDyaO3vSt=fPXLpph3m3TEtxAtdBiFMKqSrcA@mail.gmail.com>
Message-ID: <CAGXu5jJmJLc41XDyaO3vSt=fPXLpph3m3TEtxAtdBiFMKqSrcA@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: sysreg: make mrs_s and msr_s macros work with
 Clang and LTO
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Alex Matveev <alxmtvv@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 7:38 AM Kees Cook <keescook@chromium.org> wrote:
> +#define __msr_s(r, v)                                          \
> +       DEFINE_MSR_S                                            \
> +"      msr_s " __stringify(r) ", %x0\n"                        \
> +       UNDEFINE_MSR_S : : "rZ" (v)

BTW ... is "%x0" a typo here? Shouldn't this just be "%0"?

-- 
Kees Cook
