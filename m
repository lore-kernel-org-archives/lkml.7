Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B205C3A59C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F77A2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C/Vg5Pbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732661AbfHON7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:59:09 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37185 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732477AbfHON7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:59:09 -0400
Received: by mail-lf1-f68.google.com with SMTP id c9so1713507lfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 06:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NEN7OlO6PsmXIW/8TrDuJXInacqxCs2vYJzFBFiDd3o=;
        b=C/Vg5PbbwVSUgAlnGNV6yX4Zg9x9BM3xaD1rxzbpZmrIyqRMncGMNTVQRTdTQGgV9w
         dj5jGqs13lpnytnccCDjOlXFdmaOODYchUzdsYNOrMvgmEXtlsR+3DUVmyLR8UFZ2OnJ
         JotNTYd+N+t+1PlL6ofleNDWk2+QGEAnrwa9p1vI2Ib4gucIi6Jc8enCv5oFHgnnAR52
         JSJcPDIDUXcS1arLfC3ygMWORHpkaT24alEGmB8V29N/gr6OklMCi6cVV+275NS51/Mn
         bJ13iGDF4AL1WquY0z3PL3cU2zppjqEhd09MAIopifw8sZG3e/xIhowTJqtFnyIK2McL
         +y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NEN7OlO6PsmXIW/8TrDuJXInacqxCs2vYJzFBFiDd3o=;
        b=IX4jQntEIvIFSlGVJ/ffuL288VQUgyiLsHUd4FFzepYLCtR6It/wq+qZUAiLmmnWm4
         MHvGIdWDSjF9mEaKM+hn42E/VUBhhdrctTQOV8mfN8zFBHhC24ORB2bDfyrAkaxFqT7U
         1vBnqb/2oK2T2czyhQBe6P52bXSdkCqWbqhBVm/nYE+G6od/mOKeaxubAxdo/ZTwqLZE
         Wf2otNPlFNFFyP6vwAA0iN6jh3wOPvMCRyliM5f+MRrzv+XyQneXthoYEMhM9qbArZvt
         O9/Z7x/y5qpzlKhdoPJuZd/sPQhakJPMvV3AT7L1nG7WBTsOq1ppXd6CRefKtySHih8a
         WDSg==
X-Gm-Message-State: APjAAAUmzj9XSUr1z94CcGphBuFf2O0BwztZ/QtGJR6YW/7pbCotpsXo
        HtQ5peafvWlHGNFKKREod9rCMs4vNmktIz4x5Nz/7Q==
X-Google-Smtp-Source: APXvYqzFZlMCZYJMKEX4UEYuYtAvcf7l/nZHdtCVXRR7a/KQaTx5HhKk5gCqP72LtFfVhYWlQwu9uHpau60MorzUfDc=
X-Received: by 2002:a19:6707:: with SMTP id b7mr2477107lfc.16.1565877546927;
 Thu, 15 Aug 2019 06:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190814165748.991235624@linuxfoundation.org> <aa683926-3df0-6f60-841a-7ea5a5e3566d@roeck-us.net>
In-Reply-To: <aa683926-3df0-6f60-841a-7ea5a5e3566d@roeck-us.net>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Thu, 15 Aug 2019 08:58:55 -0500
Message-ID: <CAEUSe78A6Cvt2irKzysfRSHubVxDaEGUVaLf2UF5EHzTeiOVOw@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/91] 4.19.67-stable review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, 15 Aug 2019 at 08:29, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 8/14/19 10:00 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.67 release.
> > There are 91 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri 16 Aug 2019 04:55:34 PM UTC.
> > Anything received after that time might be too late.
> >
>
> Building x86_64:tools/perf ... failed
> --------------
> Error log:
> Warning: arch/x86/include/asm/cpufeatures.h differs from kernel
> Warning: arch/x86/include/uapi/asm/kvm.h differs from kernel
>    PERF_VERSION =3D 4.9.189.ge000f87
> util/machine.c: In function =E2=80=98machine__create_module=E2=80=99:
> util/machine.c:1088:43: error: =E2=80=98size=E2=80=99 undeclared (first u=
se in this function); did you mean =E2=80=98die=E2=80=99?
>    if (arch__fix_module_text_start(&start, &size, name) < 0)
>                                             ^~~~
>                                             die
> util/machine.c:1088:43: note: each undeclared identifier is reported only=
 once for each function it appears in

We noticed this exact failure but not on 4.19. For us, 4.19's perf builds f=
ine.

On 4.9, perf failed with the error you described, as it looks like
it's missing 9ad4652b66f1 ("perf record: Fix wrong size in
perf_record_mmap for last kernel module"), though I have not verified
yet.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
