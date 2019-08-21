Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34528C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26A922DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c2w/mJle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfHUTrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:47:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42964 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729877AbfHUTrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:47:47 -0400
Received: by mail-io1-f67.google.com with SMTP id e20so7023277iob.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 12:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8+BtOM+3vO2u6/0CQmN1n87ARVo5K8I8VEywZXCtgLY=;
        b=c2w/mJlehUD6/LiHkmRwQFgU7A5T8czN5pnMMHJiQ/xEg9Bfn/NYZh7lMic93gbMii
         roHC5uqI1hHPWP9B+8A1EgMbfzWCAmDGuFTVG4/ix1xHsNitc9H2tcdMeoj5iLJ2GhuG
         fug4Ke+IbBjCWnnWzxDeQ5u158euo7zSklywVQvvw4M5fEJlzOBS2iyzl108r4I/pOqy
         NLi81+QohnyuhdgiCU7LNgAio1U2uxPMb91FIwxdXxEj1C2NC/+kLiyF0hopskiRUIpI
         R1nAefhp6Hj3IllDqukMdl+6VwXnTc0HYFbY7t093HRBB27QfLu0J+jU3kFnZ5wUU6fq
         qZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+BtOM+3vO2u6/0CQmN1n87ARVo5K8I8VEywZXCtgLY=;
        b=oNzaZBvCWphLMrcUtCPKiBBvCS+IavB8IgRGP4+QV8GKD/aB57e/lZqDH0MGPms1Jo
         pPuk7EQqN7Tghnv1fCfRGQbLjfGno5Jzsi/78V+Dmtn7kXMmzbfuSJ+v6WsqsH0D4+mG
         IGaCRbTwYpGOglcso+zw1CFTTKk++CYXbY/J0GmTMNHsmwTp3dHXQR4JL/pXMkXQEXkl
         YkgIHpGk0sEHUnAdLujwX8yAKw67NPGEh64M3rrZUVBBoe02VuwCWclerUfwS+WyJw4v
         TfPrWIRFNCW6bQviHsJw+xsEQTfWvAw/p9ExLixLExGtlfmXPSEVhJWypXXLVYqKfIal
         HwbA==
X-Gm-Message-State: APjAAAW6ZAIXwcmZwus1Q6v7jX8/C+Ib57LpzSrNNeuZ1sVgrZ6X4ee4
        VcpCm1Y/uZSoerH1Xlbs94lhegA+G+elIGGk8WKAKQ==
X-Google-Smtp-Source: APXvYqxmuM2Iy92v/ONpVWmMF8SZinCG9Ze+5FLH635jZ1tfongFVtR6v37dxy3ceftTRJo4MWkcs4spDIMONi1dr+s=
X-Received: by 2002:a02:c65a:: with SMTP id k26mr11780341jan.18.1566416866453;
 Wed, 21 Aug 2019 12:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <1566376002-17121-1-git-send-email-pbonzini@redhat.com> <1566376002-17121-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566376002-17121-3-git-send-email-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 21 Aug 2019 12:47:35 -0700
Message-ID: <CALMp9eS=qsrOE2yaJAFZK6VhFEtkx2vjCQkYa8UMjeWYDOQQgg@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: x86: always expose VIRT_SSBD to guests
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, jmattson@redhat.com,
        Eduardo Habkost <ehabkost@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 1:27 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Even though it is preferrable to use SPEC_CTRL (represented by
> X86_FEATURE_AMD_SSBD) instead of VIRT_SPEC, VIRT_SPEC is always
> supported anyway because otherwise it would be impossible to
> migrate from old to new CPUs.  Make this apparent in the
> result of KVM_GET_SUPPORTED_CPUID as well.
>
> While at it, reuse X86_FEATURE_* constants for the SVM leaf too.
>
> However, we need to hide the bit on Intel processors, so move
> the setting to svm_set_supported_cpuid.
>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
