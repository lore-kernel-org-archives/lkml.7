Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF95C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762B622432
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QxgP7imn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfKSTAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 14:00:41 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39790 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfKSTAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 14:00:40 -0500
Received: by mail-io1-f67.google.com with SMTP id k1so24494739ioj.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 11:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0tlDOLamzXoB2txFi3bDr1lzl/uIOL5HoxDwsrMLE1Y=;
        b=QxgP7imn6TlYA7oi3x9pxhpZOtUUaToTMcAcmJRBH/dLvkCpP3EdF2QL5G4i2nA8DU
         Cq+DjhaOlof76EnZkWYD2y0d3NEa2cuX34uGwANcP8or0pu2JcTmaUh3imVEevFXQ0oU
         O897Np0pV2Lfk02x/PJCjyFa5f30yLGFkuqm4+nhsflv8PN6PWLoqmlsRWvdYL1oxSj4
         +Kk4EgtTSaAsd1+R6VwqACpKGRgTrKpWxfvCwfx8Rydm7W2xNXO6CWReFmqJ3/J3t3jT
         LaSgIxuo3K3zT6ApVC0ucLKXr6/Q4y/JkdQwvHRwoFYK92mXUVnopO42DcP5XeeHXX9g
         /7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0tlDOLamzXoB2txFi3bDr1lzl/uIOL5HoxDwsrMLE1Y=;
        b=EddnwmOjAv7RouEpWcNEyut12HGxEoR5ibOsO4tBLjFZ9rUroyoK9oH8jOtj9xPovO
         RcP0FRDhgH1KHZc1WnyjUrNJAMYRaVlwxKzilpXT844hIhIzAytxfBoo2dlo7QgHnUkH
         cuv4+7wWfZ8jpChPtBDSeZH6TGqxU4XRTdybbf7lOwjASWLF5wrs5+8b9rP7GMwO7El8
         gv0SrpOfqfuZjV+6BqOgdq2dS3R0+myE3TqrNf1B5RXqU2/xrnayJOj6TtcwWLL7a3Yn
         M7GIUaEiElZNMjdAtAoMx8UjrjtiQhEc0Bi3WBNFcJSvhX8ynMAYPLIADxA8bGJac7D1
         F3lQ==
X-Gm-Message-State: APjAAAWgr+G5Twcu9eBOYNon7NVlc7kNOYiu3+wA3bvwb9wKA3w6mrdx
        39Ldr2G5huda78WaL7YU5XpxLdZdgqZK+NITDh7AYDyd
X-Google-Smtp-Source: APXvYqxrjt4bI9Z0ev5yPYL85atGFtMdcQsDoCEeiQ6jKiUgcWy9z7waZeREcBFeRT8RtQahzj5rQTQXHIYn4AAp6Ck=
X-Received: by 2002:a6b:e016:: with SMTP id z22mr12327691iog.296.1574190039715;
 Tue, 19 Nov 2019 11:00:39 -0800 (PST)
MIME-Version: 1.0
References: <1574101067-5638-1-git-send-email-pbonzini@redhat.com> <1574101067-5638-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1574101067-5638-3-git-send-email-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 19 Nov 2019 11:00:28 -0800
Message-ID: <CALMp9eTzAFYt1wkXT+OEx=vNs0rrCvp=8XG8Jbwwaj3mSPPF+Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] KVM: x86: do not modify masked bits of shared MSRs
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 10:17 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> "Shared MSRs" are guest MSRs that are written to the host MSRs but
> keep their value until the next return to userspace.  They support
> a mask, so that some bits keep the host value, but this mask is
> only used to skip an unnecessary MSR write and the value written
> to the MSR is always the guest MSR.
>
> Fix this and, while at it, do not update smsr->values[slot].curr if
> for whatever reason the wrmsr fails.  This should only happen due to
> reserved bits, so the value written to smsr->values[slot].curr
> will not match when the user-return notifier and the host value will
> always be restored.  However, it is untidy and in rare cases this
> can actually avoid spurious WRMSRs on return to userspace.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
