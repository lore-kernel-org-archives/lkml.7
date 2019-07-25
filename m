Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD9BC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41982238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VDI0sPuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389373AbfGYQlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:41:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35047 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388276AbfGYQlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:41:31 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so98671040ioo.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0jYRQRolIOxef42RRXDE4CTbs3UanGuMByQk3s/piz4=;
        b=VDI0sPuHjqypYIl5HpM6h1kYUk4Y2RJh/dbG/X72EJCzxpHFYTRdSq2JDQ1ZmzMCES
         k0DR4YyzNuL0LyG6w4UoWJpwI0UF9J3JBXondYEONoQVCATpfrL3LE3/bjUApHFzN2aJ
         S8j+5OojYRrZvNr+sOQLnsh+rlj//v+jcRWNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0jYRQRolIOxef42RRXDE4CTbs3UanGuMByQk3s/piz4=;
        b=J/cPWDdemTtgdyh4hyz+N4RvpVNf/cECEPj+YFSkw+93AXbijsz1kwv4tU4gl7SiiV
         TJs0jXqcJPqsiuzw+j8tnsb98l/o9v79ZWkNgKE2Mb7ybbIPv4XvkpOs1GOmwzSxbFo1
         xw1Oy7cLfW9FaSTsR4aIeJ1qMf+Qj7mCopdDltuT5ozgfoGJz8EREOkcYS5fL4Nb58JZ
         geDKJDoRHX5ouBfGaP7019DMK4kPiBHRjDwtPPXiB3Z5oe1UKTQXFyolYm/t8oKmO/5/
         D1qXCXxNJRYpD/F+X8xIrXPyytqLnYYnEcSNwLU+HeCGBuXFOcUQuA2lXBnplMNdimI+
         3xTQ==
X-Gm-Message-State: APjAAAXB7R+IhadOiN3t/cZk91quJJbcoi1fkHGHQTfkGqv1BREAxtGS
        U3dO03hFM8F7fhRhdx/IVoIJ78Q2Sno=
X-Google-Smtp-Source: APXvYqw7Q9itL2g94+K6Mljkx6GbBK0Ktlt5g8IB6hMJcrAlo4/uDnfA7msKRRqDeuYW6JukaH1+0A==
X-Received: by 2002:a5e:db02:: with SMTP id q2mr18047875iop.306.1564072890729;
        Thu, 25 Jul 2019 09:41:30 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id j25sm64987147ioj.67.2019.07.25.09.41.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 09:41:30 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id i10so98541331iol.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:41:30 -0700 (PDT)
X-Received: by 2002:a5d:885a:: with SMTP id t26mr29560419ios.218.1564072889706;
 Thu, 25 Jul 2019 09:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190725154730.80169-1-swboyd@chromium.org>
In-Reply-To: <20190725154730.80169-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 Jul 2019 09:41:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UZQEqNyJ_3Corx0iro-OB5E==d8qZCxgrMvvKon4yAxw@mail.gmail.com>
Message-ID: <CAD=FV=UZQEqNyJ_3Corx0iro-OB5E==d8qZCxgrMvvKon4yAxw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Check for unknown options with cc-option usage
 in Kconfig and clang
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Peter Smith <peter.smith@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 25, 2019 at 8:47 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> If the particular version of clang a user has doesn't enable
> -Werror=unknown-warning-option by default, even though it is the
> default[1], then make sure to pass the option to the Kconfig cc-option
> command so that testing options from Kconfig files works properly.
> Otherwise, depending on the default values setup in the clang toolchain
> we will silently assume options such as -Wmaybe-uninitialized are
> supported by clang, when they really aren't.
>
> A compilation issue only started happening for me once commit
> 589834b3a009 ("kbuild: Add -Werror=unknown-warning-option to
> CLANG_FLAGS") was applied on top of commit b303c6df80c9 ("kbuild:
> compute false-positive -Wmaybe-uninitialized cases in Kconfig"). This
> leads kbuild to try and test for the existence of the
> -Wmaybe-uninitialized flag with the cc-option command in
> scripts/Kconfig.include, and it doesn't see an error returned from the
> option test so it sets the config value to Y. Then the Makefile tries to
> pass the unknown option on the command line and
> -Werror=unknown-warning-option catches the invalid option and breaks the
> build. Before commit 589834b3a009 ("kbuild: Add
> -Werror=unknown-warning-option to CLANG_FLAGS") the build works fine,
> but any cc-option test of a warning option in Kconfig files silently
> evaluates to true, even if the warning option flag isn't supported on
> clang.
>
> Note: This doesn't change cc-option usages in Makefiles because those
> use a different rule that includes KBUILD_CFLAGS by default (see the
> __cc-option command in scripts/Kbuild.incluide). The KBUILD_CFLAGS
> variable already has the -Werror=unknown-warning-option flag set. Thanks
> to Doug for pointing out the different rule.
>
> [1] https://clang.llvm.org/docs/DiagnosticsReference.html#wunknown-warning-option
> Cc: Peter Smith <peter.smith@linaro.org>
> Cc: Nathan Chancellor <natechancellor@gmail.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Fixes: 589834b3a009 ("kbuild: Add -Werror=unknown-warning-option to
CLANG_FLAGS")
Reviewed-by: Douglas Anderson <dianders@chromium.org>
