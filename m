Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B353FC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8504B214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zl1FErqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbfH0RKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 13:10:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33500 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfH0RKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:10:04 -0400
Received: by mail-io1-f66.google.com with SMTP id z3so48094949iog.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 10:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VWy+77tTGQ3qconEzAmoj4+uuLcoy/9TvX983Ina+rM=;
        b=Zl1FErqaB3jbNeSprrVrlyXSV9r4KFM/wpcMJC6G1gl5QI6t5aoeAksIxoZk/ST/8w
         M2xQ3pxE+5XYp1mBX1jbV8kSZNyHMXB0mEta7Q9nWQFIrKOKvJYyIHJxjUd046259E/4
         96hZ1PaX2+Alx3QnrtGdBZc5c/yfKpnz/xlLvsBvzwRkJRJ+0YqkV8BwyEBYWQjzrbCp
         V/83rU8KkEdR5Gox/X7YL6LTLFeO9UE3/WBcbUB20DpX+bVL7wzz/TqYlKa9NeJxShhj
         P5F9Y+EakX8iDxGvmsJxf2o4td/H68DCjEnZblMjP/DFF+Ef0sGper6B0LcxEhvrYrI/
         f9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VWy+77tTGQ3qconEzAmoj4+uuLcoy/9TvX983Ina+rM=;
        b=tYo/cWjR+abh88aSEUYbs8KwzfwCgNn3okysvxRQ904nHrTgVmfm03I5pZBuyM3jtO
         EOKJHyuEDIn4qKScDJB8zahBSmdiYMhLKS3b8Lp9kqsslzbD2SCWNmz8Cn9Eg9IWcwUM
         OSCS3Ki2xWJTxpThkcz+yhBsyj8c76OJN5HdOKgu/yOrTU1a2K6qtpJxNLsQ3i5+NRDE
         EkWC2x7TwX/mFB3+cgo4cUqTwBtPLQ0kNER3IhVOSs1XgZW0kv4FQIEfRNrQCSL0HAXC
         m4RQ4H/GTXcQOtRSZT0eR3qTJKGLYiobWI1mX84ZDfoy09gDigzOYImSgBDgo6HJ7cih
         FIbg==
X-Gm-Message-State: APjAAAXsYxu3IxQWVUFlRErytaZ4AS+Q1R7GdkuN6zeQC0yaPPat66t0
        XYMxsO2SkXllxd4f56q194D5njuH7ywBP1H9c/L38g==
X-Google-Smtp-Source: APXvYqydZJJdDg7zCx6qi1x3O1YncYyjenMPMtVUmfPNf7dJ/ExTV6t1ON1PuV71zdFslPfPEZ6l+aBfWG4qPRt41M8=
X-Received: by 2002:a6b:4e14:: with SMTP id c20mr1664014iob.26.1566925803258;
 Tue, 27 Aug 2019 10:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190827160404.14098-1-vkuznets@redhat.com> <20190827160404.14098-2-vkuznets@redhat.com>
In-Reply-To: <20190827160404.14098-2-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 27 Aug 2019 10:09:52 -0700
Message-ID: <CALMp9eRqT1VpD25cp4yyr8oVLV8vzES_uki_Xuqs-_ghGsZy8A@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: x86: hyper-v: don't crash on KVM_GET_SUPPORTED_HV_CPUID
 when kvm_intel.nested is disabled
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

On Tue, Aug 27, 2019 at 9:04 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> If kvm_intel is loaded with nested=0 parameter an attempt to perform
> KVM_GET_SUPPORTED_HV_CPUID results in OOPS as nested_get_evmcs_version hook
> in kvm_x86_ops is NULL (we assign it in nested_vmx_hardware_setup() and
> this only happens in case nested is enabled).
>
> Check that kvm_x86_ops->nested_get_evmcs_version is not NULL before
> calling it. With this, we can remove the stub from svm as it is no
> longer needed.
>
> Fixes: e2e871ab2f02 ("x86/kvm/hyper-v: Introduce nested_get_evmcs_version() helper")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
