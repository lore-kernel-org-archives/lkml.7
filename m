Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F6EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8088A217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofSVl+bl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfH1QYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:24:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42676 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfH1QYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:24:37 -0400
Received: by mail-io1-f67.google.com with SMTP id e20so683486iob.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 09:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u1lLimGMYhfmCL3MKSeS32GLZr2shj1mXSQdp3B8730=;
        b=ofSVl+blw2/4lc/BpfotBwPm68T0GUBhYn2TVoo6BIKVGtOfIrFEKZK+pVGkY/id/v
         ApBscizv0pvB/os00gahz9wmDuYhvyhgHdpHtTjg67O3SsZexQvBNjhYQQzNP5vqzl+Y
         dk47lAClDeZDmUPm5Oko6rc1i+IwiSHtE4hewoKm2dLTdAqfmSQSqhNgpAHrzX9Ce/it
         dn3fDMrFnlrzDR6odgC13+w31g9sVRAqL2FBT+aLM0r99ae4Au+q1ulsCQRbYF4MV4vD
         RkLlQbA3fthbHRtpaUIa+qSgrs1ltTsqUvMO4hb5xa6gnrMdBYsgBkuKY9P2VQ6Uq7rI
         T2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u1lLimGMYhfmCL3MKSeS32GLZr2shj1mXSQdp3B8730=;
        b=mZgEiCNLFlvjOqMXvoGmEOoLx6ro9/cW7Nue4wc+Kng0Vg4ZC9LI4973JDgrZJsCIz
         Q1izey4XH/ybx/sije7i+r4BMH6LhfDUF6iygk3l9f+t1hBtJE1Ou8nWGCInUZOG9cGv
         gy8jUNiuJWgSJErCQ6kldsSiKS7R+9v4euc0MVEJP+YDEFzikcoZFQq9vsBAen15ENzd
         WFeIZWG2XSXjsTQy1zNZy9QfgW1EE64q137LAAB4IwukH9tQC4JO/HhL1+QWiHOwL5QO
         w7Wws2bdRe/sUOCy6OebkeUnQNX0QsY0PS60XHg/irZ6lk+RH6YjfstdWgSPgjUcpQ9A
         eWyg==
X-Gm-Message-State: APjAAAVsmQ9WdkGD4lhFd4OsaJ5guP7hkNK8/8uDT+W6XTueMrfqf1bD
        wlm+VK6TPRS8m/pu9bXDJLK7mFpmfJGHKjFPtRUGQQ==
X-Google-Smtp-Source: APXvYqy75W4ZP+4Mea96982CTuaW26M/54Xn2KLmojJRs1wlL52kL56BQ3O3f/OEsss37qyJsNrqN1tJKeeS8MGj0RM=
X-Received: by 2002:a5d:8f9a:: with SMTP id l26mr1849026iol.26.1567009475969;
 Wed, 28 Aug 2019 09:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190828075905.24744-1-vkuznets@redhat.com> <20190828075905.24744-3-vkuznets@redhat.com>
In-Reply-To: <20190828075905.24744-3-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 28 Aug 2019 09:24:23 -0700
Message-ID: <CALMp9eTB_yoYGoNQ5DP+XtVbM8fD21aSD+D6onaE7gCxJueqvw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] KVM: x86: announce KVM_CAP_HYPERV_ENLIGHTENED_VMCS
 support only when it is available
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 12:59 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> It was discovered that after commit 65efa61dc0d5 ("selftests: kvm: provide
> common function to enable eVMCS") hyperv_cpuid selftest is failing on AMD.
> The reason is that the commit changed _vcpu_ioctl() to vcpu_ioctl() in the
> test and this one can't fail.
>
> Instead of fixing the test is seems to make more sense to not announce
> KVM_CAP_HYPERV_ENLIGHTENED_VMCS support if it is definitely missing
> (on svm and in case kvm_intel.nested=0).
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
