Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD380C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D5F2166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nY8IF2S8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405903AbfHIHxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 03:53:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43427 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405797AbfHIHxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 03:53:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id y17so66698818ljk.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 00:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GqqiFOTILayCWP92aAvbU7rZYbJzYJq2hFWqssnZfow=;
        b=nY8IF2S8A3L3Vuay9KDIsTtuFYPZeeklDr8dKII6lyiCdYnIje0PkqQD6KT7a8QWHU
         4FUv3TSucrFG98xqdbHX/fz/oYdj+KcmhxIwu8wKAtss6gbGo71dbqGgeWzg90cnNTLd
         daAxPNFCgGaViq4pcXkR0d3YXrO3QvcYqJLrUvOmGL94qGQ59Qp7Xv4ryXeG5I2fMJ+M
         RYNGCai1CaOieNia2IDUnrL3GIqtVgZc/GqiIUa3v0hJ0AeNWaNOq2pWS/Vu4XzMDeyG
         iuvJ/pFULgifhSM/dP60F1hCYQ+lhZ8YerE+lgkMmWp/Rib29Nj7JqNyN1P8uIoH04Es
         rtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GqqiFOTILayCWP92aAvbU7rZYbJzYJq2hFWqssnZfow=;
        b=epfnrqdqffbOH5f/kau2f+2XoXW/suC73moLWAmLto3PUEs4WUGk516muXN/Qjfcgg
         anJyUNLuKJ5hCZveGPCpA0wDW3r08GbCefO9bwlvaXZ0R7CQpMYTsaJ+uRqkOeu+Zn/J
         Zj9zhbSnRzGhfAhlLFYDzVcwqHbLR5+kcbLBvqFW1/K6UAh/ppK498NMpj0Jl7pDasEH
         hgNVs6Co+eKNbffWIFWjEXQM9EMj9aHTPG5RyZbiLwKmvfA3NZKUbrSRgTZKgLbs2ijT
         C/RgV7fqHmBtmjTBU2PMmD38yIIuCXOtcvQF/rPOAbDwLZYds+o68k9Qp21arnNSKKm+
         2JUw==
X-Gm-Message-State: APjAAAWKiIb5/iYgbr2w36RgU/UGP0aB3NleXEZZjkz94bUu9MMbCUV1
        l5eLO5RPKchCSEo3UUhXrAJix4GbmAhDioPS826jow==
X-Google-Smtp-Source: APXvYqxFQuHM3xYJAfyF6kQS8ItALDrQIiaCIj4v6PZYeYPQwqRCeQNlySydBHuBNvEurL5a+9vQM3W8O0NVFX8Igw4=
X-Received: by 2002:a2e:87d0:: with SMTP id v16mr10709810ljj.24.1565337199321;
 Fri, 09 Aug 2019 00:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190809072415.29305-1-naresh.kamboju@linaro.org> <0a0e0563-aba7-e59c-1fbd-547126d404ed@redhat.com>
In-Reply-To: <0a0e0563-aba7-e59c-1fbd-547126d404ed@redhat.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 9 Aug 2019 13:23:08 +0530
Message-ID: <CA+G9fYt4QPjHtyoZUfe_tv+uT6yybHehymuDWBFHL-QH3K-PxA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] selftests: kvm: Adding config fragments
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        sean.j.christopherson@intel.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        Dan Rue <dan.rue@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Aug 2019 at 13:09, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 09/08/19 09:24, Naresh Kamboju wrote:
> > selftests kvm all test cases need pre-required kernel config for the
> > tests to get pass.
> >
> > CONFIG_KVM=y
> >
> > The KVM tests are skipped without these configs:
> >
> >         dev_fd = open(KVM_DEV_PATH, O_RDONLY);
> >         if (dev_fd < 0)
> >                 exit(KSFT_SKIP);
> >
> > Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> > ---
> >  tools/testing/selftests/kvm/config | 1 +
> >  1 file changed, 1 insertion(+)
> >  create mode 100644 tools/testing/selftests/kvm/config
> >
> > diff --git a/tools/testing/selftests/kvm/config b/tools/testing/selftests/kvm/config
> > new file mode 100644
> > index 000000000000..14f90d8d6801
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/config
> > @@ -0,0 +1 @@
> > +CONFIG_KVM=y
> >
>
> I think this is more complicated without a real benefit, so I'll merge v2.

With the recent changes to 'kselftest-merge' nested configs also get merged.
Please refer this below commit for more details.
---
commit 6d3db46c8e331908775b0135dc7d2e5920bf6d90
Author: Dan Rue <dan.rue@linaro.org>
Date:   Mon May 20 10:16:14 2019 -0500

    kbuild: teach kselftest-merge to find nested config files

    Current implementation of kselftest-merge only finds config files that
    are one level deep using `$(srctree)/tools/testing/selftests/*/config`.

    Often, config files are added in nested directories, and do not get
    picked up by kselftest-merge.

    Use `find` to catch all config files under
    `$(srctree)/tools/testing/selftests` instead.

    Signed-off-by: Dan Rue <dan.rue@linaro.org>
    Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

- Naresh
