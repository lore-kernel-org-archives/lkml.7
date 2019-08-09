Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B140C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665F420B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="btgHICFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437191AbfHIQjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:39:33 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40552 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437094AbfHIQjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:39:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id l15so77701103oth.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 09:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CikhgCxe5YHX0c3F28QN7MAGvPAtgLNBsm2uQo1hLD0=;
        b=btgHICFcCUxPl6D9I8cv8GHpDwrNnZfc0toIv36RpNA6sM6aRbW7JK+RL7MY7vx6cQ
         ulcmH6aZbBZ7PVYZRkbprh65Ce29zF+FlETeZck1Xe83EP9G+Qdu9A0J7DxlcUKWxKtH
         n1hcpUP6onuyWpBKc0ArYdjNP2ihj3W3NT/BzYZ05r4r39ufzzLEAEijCePWKjm0IhYi
         dwwmjTjfFuClvAyaGFaTcaIz0i8h9o3BqYcXcztpUXcZgSVVz7bVuAt39mryY0fPT/BN
         y8a51j/EZPgx1B4pZ+wD1Fvxlf3dC4UCYSsmEb5WTcDyL40t+VXkFs3n2FiCM6UjBavk
         QggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CikhgCxe5YHX0c3F28QN7MAGvPAtgLNBsm2uQo1hLD0=;
        b=YmYyHc2JPziHpjhYZP+6bdftyDdWRIBYkmaiffo70SvrRA/1mVtcWJqZFzpJZFBs9M
         f/3q5XnIb2zMmE1I8B4Je0Z3mSjhsqXEsKUguE4CUd96nzUkYRYsSIgsV0YKCGEwyMT1
         zODAoJEHfcUb4dFtiot7Uk/nruytarrk6+aTPvngm2/Gc+VZueZ300oXQp/KM1X7yqRK
         aD5rtr2ECJMReqAMGkSLKweHdup7ChemPET187QQIPatvjU2CH03QeuhBZCPmtFyKD7N
         AJSQEP1edK5gpTxZbJ9fqOEn18exH6dbUe4Di6m9PVTQq/m7+muu/KHbblKN0IiT5qFL
         sTmw==
X-Gm-Message-State: APjAAAWKvAkDmW3GN3EiELIMcc3GwLQx+Z1gluV+bwi3slCDw4P8AjbK
        1Bcyp6oKo7riaSdJTeIFYARCWwuPZim2aPzkiHQRYA==
X-Google-Smtp-Source: APXvYqxwLpoE/tc3o62UOQlp4MxHt/gGVuPES6o5jLGsvs8jO6hTe+N8rC2/0es03Xs8vz2GcFCsFP96KEZXcmGwrF8=
X-Received: by 2002:a02:c65a:: with SMTP id k26mr12576081jan.18.1565368771480;
 Fri, 09 Aug 2019 09:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <1565336051-31793-1-git-send-email-pbonzini@redhat.com> <20190809161937.GB10541@linux.intel.com>
In-Reply-To: <20190809161937.GB10541@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 9 Aug 2019 09:39:19 -0700
Message-ID: <CALMp9eT+biHFQDygxk4aNg2huP_DHG=BTPYnbmLsY9bfGcwi0g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add KVM x86 reviewers
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 9:19 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Fri, Aug 09, 2019 at 09:34:11AM +0200, Paolo Bonzini wrote:
> > This is probably overdone---KVM x86 has quite a few contributors that
> > usually review each other's patches, which is really helpful to me.
> > Formalize this by listing them as reviewers.  I am including people
> > with various expertise:
> >
> > - Joerg for SVM (with designated reviewers, it makes more sense to have
> > him in the main KVM/x86 stanza)
> >
> > - Sean for MMU and VMX
> >
> > - Jim for VMX
> >
> > - Vitaly for Hyper-V and possibly SVM
> >
> > - Wanpeng for LAPIC and paravirtualization.
> >
> > Please ack if you are okay with this arrangement, otherwise speak up.
> >
> > In other news, Radim is going to leave Red Hat soon.  However, he has
> > not been very much involved in upstream KVM development for some time,
> > and in the immediate future he is still going to help maintain kvm/queue
> > while I am on vacation.  Since not much is going to change, I will let
> > him decide whether he wants to keep the maintainer role after he leaves.
> >
> > Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Cc: Wanpeng Li <wanpengli@tencent.com>
> > Cc: Jim Mattson <jmattson@google.com>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
Acked-by: Jim Mattson <jmattson@google.com>
