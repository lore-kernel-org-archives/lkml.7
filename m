Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B50CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7902087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oIY21eev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389896AbfJ2PRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 11:17:41 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39688 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbfJ2PRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 11:17:40 -0400
Received: by mail-ot1-f65.google.com with SMTP id t8so3948567otl.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 08:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cDmTxZ1osFCfIaF88wG5v4tN82aHo/kA0Jhto522MkU=;
        b=oIY21eev8TtYqEmbGroODoPtxo7vW0MKwQtqj7TqY/Tee/kgbtwfjvurmoRKieGl7c
         nap6Be1ExiS8DvJS63MMpTrXpZuqKshdAfzk72ZjvlrQfiShWPtrxSmovaBXwe3Hv7hX
         hFN4oRUhhaHylNVSeWPUXhFZURoh2mixkiXsVxN09EAmAU1aoBpr4ofNHDV2fLj0HfvD
         jb/iW+4Zv73fYc+BL3e/wrOVJ1yvchDHy4pVbO7kP6g011xDcUY27MvgYHzH7IVo3toC
         meZG7ygs3PuCoXLKkZFl7z3aQwRjqvpKLUsfIKwGbzPoajcWErVAZ2SC3KGUrtQmeItB
         DjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cDmTxZ1osFCfIaF88wG5v4tN82aHo/kA0Jhto522MkU=;
        b=GTx12qB3bpy2tuM9LuMhRDbtmi+Nkhs0eyMwHCZi8TGaNuh0ksrRTQy5r063HhVRsH
         4TYmcRGljdgCrYxS5E9Va/1dwMSKGNtnC3NR3jVM8iunWhGPCVfeELs6Utl51CeWqUtC
         D7+sKISmXSdo3OkR0/FOfz6bJ9T0goPMuK+xfNdGe92nL5u8O3pQ7LVDLpoyMOwp1SCU
         pPZfpQDirLDqeIsHU8EeVHVM/AFVLWxIOtAvZqExUm5nTYPgDgUh17vJyIY9HxQevzpk
         4GHFUrTrSFb+CRijOrsVXCzAtpnotxjbgXhoCzKMySAcaWiZGOyM9JdGg3+mFL9s0Aav
         Jfdw==
X-Gm-Message-State: APjAAAWJVi5QzqW9oJ79+ADVgo+RV1/ByCmtZOwP2muSRtqcyiUGb/uM
        r/Uf/RJFw5VBhvPOKirJYKBvj/X0GEk+k2OrZQiLAw==
X-Google-Smtp-Source: APXvYqwLvojKCyiJfugYZMzlJa8BR/FxOnj795glZxJApB3gQmwfvP75yaYY3RhfxGaErRBvk4of+kw0ti3VR5LmtTo=
X-Received: by 2002:a9d:458a:: with SMTP id x10mr17682898ote.365.1572362259568;
 Tue, 29 Oct 2019 08:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191027203119.468466356@linuxfoundation.org>
In-Reply-To: <20191027203119.468466356@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 29 Oct 2019 20:47:28 +0530
Message-ID: <CA+G9fYs_89sbhvLFk2naMS+qUdc57w17dkoaCFw3eGWjgiYkPw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/49] 4.9.198-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019 at 02:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.198 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue 29 Oct 2019 08:27:02 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.198-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.198-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 263ebb72c5fa6a7c3f395976e20ed2828d82815c
git describe: v4.9.197-48-g263ebb72c5fa
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.197-48-g263ebb72c5fa


--=20
Linaro LKFT
https://lkft.linaro.org
