Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC0CC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE942081E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gzPxF6Sb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgAFUSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:18:44 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43511 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgAFUSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:18:43 -0500
Received: by mail-io1-f68.google.com with SMTP id n21so48392205ioo.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 12:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hkwe6gCS0xXqcJJZW7uqlIoLqLcdTHhaPPV9HPAYJLA=;
        b=gzPxF6SbVaL+Q8f/0OUvPd4pGrCNyy3H+vkMlNxMyCFUACVPB22nhw7CW+mRIGgQ3f
         iC/gReQLeeGDSkKhUL37T9WNE1pL2ItXr276QwD6tCmTBAGhmLXzZTke6Rq8dBQPbOHq
         P5o62eK2UKq5jUxXseiTHaOP8geIypRCmKPQj6H9KHMS6YF57YEvwpqJXxoL5z6ZOBex
         Z9YIgLKj8/hR5kERIkkZaVIjpk1LMDFe3p+QzwUwunXpcu6N3vh4PfuAXJjn3a4nc4Xy
         RNBTgCyIIgQd5AcUrywwLVopwZUUIFlXZn4zuvAsYeWLWZRJcDncl4bs0NOmvEA3fG1Q
         Z0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hkwe6gCS0xXqcJJZW7uqlIoLqLcdTHhaPPV9HPAYJLA=;
        b=iDFOqAkQTH7O8MA8Se1X97I6VyRpNQu3Ad2h2sCeCIw1hZ6EHXLb4mAOYGtMqs7cwN
         9HfE/asByFFXYkw+ol0lxHFKAJYxZy9WPRZiuwjdpQX0bybz66w5N40lg8qwkClwrYl5
         ER0xycR41QiA5bCRiVnC1uDl4YEmrALuL3gPmnFc76uxkaJtzr8oLcofScMBgShlicfq
         heg4zsvbKmVBHQyKMW1Ms2e6Qz17khukxsr2NqHbjBdyopDSxFzQej7yRSLCaJy6efM/
         vYVcjCRRKtYQLrrnfCvfqKoDZKI3RYECJCVamF0DdYRyaBMJkrouUsclLL8X2k2l9q0l
         8sGQ==
X-Gm-Message-State: APjAAAVpAbOWGctOXSCEAh8xkggaFDf9iKwmaxZXC6HkUCgqt0x53mLn
        Mt1CAMbfRagw4DafVTHrcws9I8pktDeNiwvk48PLuw==
X-Google-Smtp-Source: APXvYqwB+24zHP/102YfQQE2qR7LjHh4cFem6VFU5fpXWOGl6aX54N0y+TTrv4usjFmDM3ZnakpCtAKCtgDHWQpd+Xo=
X-Received: by 2002:a5d:8cda:: with SMTP id k26mr45673841iot.26.1578341922908;
 Mon, 06 Jan 2020 12:18:42 -0800 (PST)
MIME-Version: 1.0
References: <20191211204753.242298-1-pomonis@google.com> <20191211204753.242298-9-pomonis@google.com>
In-Reply-To: <20191211204753.242298-9-pomonis@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 6 Jan 2020 12:18:31 -0800
Message-ID: <CALMp9eQmWB9WZaD=n5rTZEzWkjBx_emTn3zaVxk7YrwBGv2VrQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] KVM: x86: Protect MSR-based index computations
 in pmu.h from Spectre-v1/L1TF attacks
To:     Marios Pomonis <pomonis@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Finco <nifi@google.com>, Andrew Honig <ahonig@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 12:49 PM Marios Pomonis <pomonis@google.com> wrote:
>
> This fixes a Spectre-v1/L1TF vulnerability in the get_gp_pmc() and
> get_fixed_pmc() functions.
> They both contain index computations based on the (attacker-controlled)
> MSR number.
>
> Fixes: commit 25462f7f5295 ("KVM: x86/vPMU: Define kvm_pmu_ops to support vPMU function dispatch")
>
> Signed-off-by: Nick Finco <nifi@google.com>
> Signed-off-by: Marios Pomonis <pomonis@google.com>
> Reviewed-by: Andrew Honig <ahonig@google.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Jim Mattson <jmattson@google.com>
