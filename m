Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1D5C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF65320659
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLHGcfjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfKLBep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:34:45 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34893 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfKLBep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:34:45 -0500
Received: by mail-oi1-f193.google.com with SMTP id n16so13352613oig.2;
        Mon, 11 Nov 2019 17:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mez+pVB2aSRl3joTyHwJYr7P2LRTYTKys9tINZyr2/o=;
        b=nLHGcfjlNdBxuy9OP6XPSYsFhgZMGPmqolg/5EycwX81Ugcx11fDqho6CztizdBIqS
         MMezND70FGWWDPdNUCRC6L6GZR7lXjBBsQF2KCAVzOErToHOUK/dvFYk625crMVRRei9
         o9+SSSZJG2IKWoECw9Z7nP/e3ObaU06fq0hCq+Lws+uJJ4qaVDbtAdsKKp1dozrJY8k1
         7MszZZwapqMNlbPPKJ/56Axu3MaYHHIffKMpjTN8fgycuzCk/TuEpWiUHlm7OwljNLra
         GhNBtIU/aDlPVq9NLm2NCAg8ssiuQLOKX1opP58suaU37+yrRKwyl5IIzboSVt0J+pZP
         HT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mez+pVB2aSRl3joTyHwJYr7P2LRTYTKys9tINZyr2/o=;
        b=Kv3Lgl+txiRkiolHhZ362RME+AGLHRjxiuoh8TBpvFqLY6nG9DgvtZA89NhqYQt7q8
         65V3bsB4U0pLeGdEur6AJ9D/x8LTMQybeWtqoGjcR9XSNssZAVL8fTJEwxOaPlLkLvLa
         ktdwbOoIq+VAPtkWlgebCMVnHL4Zn+BasSjUFB9SuFqUEwrJWvxryaygB4YDdXYZZ1wI
         /7y92kqE/Z60g/8cZwjeYS63+Gm8eOW8qgnLCaqtUhol0zxUhpL2gsJIN6ROjxHU1yg7
         og1vPbt2YCmykP9c2bq6S1qIh3m/ACHLXuTJ/MaIVbRjw1tMzxEd9fJ1/g7pUDZ29Sx5
         G+7w==
X-Gm-Message-State: APjAAAXJWGM/dtb5xU5JR5vm2j2TBo4LIiGg/sDeinIXd9GVs8T0oTuz
        cC4Iv81pYuZf8G0eGiHCR1cSzG4YRObN3Mf0bKBWzg==
X-Google-Smtp-Source: APXvYqwJ3B/cGGQ6QoFrMaYL6Rg2bBM5c8aoJ9Ym8QZ5I3Y/0F6FYh3ltg2Nnu9FWl0BwsBMtMJamH/b5tRnnsQZi6U=
X-Received: by 2002:aca:5015:: with SMTP id e21mr1803688oib.174.1573522483255;
 Mon, 11 Nov 2019 17:34:43 -0800 (PST)
MIME-Version: 1.0
References: <1573283135-5502-1-git-send-email-wanpengli@tencent.com>
 <1573283135-5502-2-git-send-email-wanpengli@tencent.com> <7a526814-c44e-c188-fba4-c6fb97b88b71@redhat.com>
In-Reply-To: <7a526814-c44e-c188-fba4-c6fb97b88b71@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Tue, 12 Nov 2019 09:34:34 +0800
Message-ID: <CANRm+CyeH_qNs2oJPVT4Lnw9VB-+86QkLiLVy25OtK=k44CBsg@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: LAPIC: micro-optimize fixed mode ipi delivery
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2019 at 05:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 09/11/19 08:05, Wanpeng Li wrote:
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > After disabling mwait/halt/pause vmexits, RESCHEDULE_VECTOR and
> > CALL_FUNCTION_SINGLE_VECTOR etc IPI is one of the main remaining
> > cause of vmexits observed in product environment which can't be
> > optimized by PV IPIs. This patch is the follow-up on commit
> > 0e6d242eccdb (KVM: LAPIC: Micro optimize IPI latency), to optimize
> > redundancy logic before fixed mode ipi is delivered in the fast
> > path.
> >
> > - broadcast handling needs to go slow path, so the delivery mode repair
> >   can be delayed to before slow path.
>
> I agree with this part, but is the cost of the irq->shorthand check
> really measurable?

I can drop the second part for v2.

    Wanpeng
