Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F218C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0288D206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKL0hpgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405824AbfHIHgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 03:36:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34971 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405711AbfHIHgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 03:36:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id l14so1280605lje.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 00:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HXqS2DL68BnoaWC7BPpejArIxz6sqUi2fc/63WuQaUE=;
        b=QKL0hpgsd+0DNocYhr0sEvnxDUB9OXgs3iaJcewg/PpKtcZDd9q9ztHww7OdRd8K1x
         EsNY858u9uPhQWSOAVrxpmMIUu5KUzwaV3TsHkDCS1t3TCobq/9PGwCabM7oU8ARaMNf
         M8TmaT+8j2S7leYm4lrZuMoQyyDppVz5G/6gHWkJamj1HsNdShB8on/i+0uX0I6felNt
         seus2hiiiuYCV5cZO2OpOQTu+nPXKojbfezQmKNtqns0RTRELCP/y5WoSbMDbCsUQDL7
         xLOJABYKiF1x5K7QwK36deq4e1LaIpzb8TQQ9upjahFFRuEioMivr1TwvLkKnpeAgCfN
         PQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HXqS2DL68BnoaWC7BPpejArIxz6sqUi2fc/63WuQaUE=;
        b=f8ZhxsCM7Y0KdhIODmAnNefr2vJqgYU4quur6mzJieUFgasnlSFK8QrTc6dZ4dpiIW
         RZRM/Ye6HkrGoO5jQX5FQ2yM6ihu8CEoAbTjS5jXTg7GAhrnla8F26/lIx1OVWOgjkBs
         ZvbbEY9WNJfJ7DeY4svNXklWW4kXYE1v6NhTwk1zwXhR3hV1Et4tTyuxxCTbqwfKm+yj
         hYrh0o0j5lSDeq7qOTKa1rhQ4qQxguf0y2RFQe8UBc8BjWHD/aXN2yyD2EXJw1NyO6nT
         gyBZIStYo8ZjnSJmfXXOztfeYP48zb4hIGjgV9wtoBRhX/Css520LFz+gSDjstuxMnhP
         AvVA==
X-Gm-Message-State: APjAAAUwO14poPui9dfSNIVPS2QRJw4kEJNNsgCDzEvPKGDfvQleEsDV
        q2SugKrD61u+JYzCUx3yDueEC4MU8Eb5z1lAIExjTQ==
X-Google-Smtp-Source: APXvYqzeqLykT6zxNpcnNSzGlO76tabSwRrSF7hhpaCzhGrqiXaDTvhfTN7tkmBVUZHwxkSdgdismvv4yqPs8ykrJOo=
X-Received: by 2002:a2e:6e0c:: with SMTP id j12mr10467584ljc.123.1565336170583;
 Fri, 09 Aug 2019 00:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190808123140.25583-1-naresh.kamboju@linaro.org>
 <20190808151010.ktbqbfevgcs3bkjy@kamzik.brq.redhat.com> <b34e8232-ccfd-898c-49de-afef4168a165@redhat.com>
In-Reply-To: <b34e8232-ccfd-898c-49de-afef4168a165@redhat.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 9 Aug 2019 13:05:59 +0530
Message-ID: <CA+G9fYv7RZgm36fbQU5yH=58sX84TxgE93SneB_UhRsD1ivGhg@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: kvm: Adding config fragments
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Andrew Jones <drjones@redhat.com>, Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        sean.j.christopherson@intel.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019 at 21:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 08/08/19 17:10, Andrew Jones wrote:
> >>
> > What does the kselftests config file do? I was about to complain that this
> > would break compiling on non-x86 platforms, but 'make kselftest' and other
> > forms of invoking the build work fine on aarch64 even with this config
> > file. So is this just for documentation? If so, then its still obviously
> > wrong for non-x86 platforms. The only config that makes sense here is KVM.
> > If the other options need to be documented for x86, then should they get
> > an additional config file? tools/testing/selftests/kvm/x86_64/config?
>
> My understanding is that a config file fragment requires some kind of
> kconfig invocation to create a full .config file.  When you do that,
> unknown configurations are dropped silently.

You are right on this point. As you said, unknown configs getting dropped for
arm64 cross compilation.

- Naresh
