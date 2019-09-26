Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C05C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071142053B
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJN0hGEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfIZKek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:34:40 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34888 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfIZKej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:34:39 -0400
Received: by mail-oi1-f195.google.com with SMTP id x3so1654100oig.2;
        Thu, 26 Sep 2019 03:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXeaVOM54zatWXZ5qzke97zx1OY9L8LMNKUJXVt61MY=;
        b=iJN0hGEaZGRHJ14GvmbCNXnDrCoeeLx4fe97E/cpDmg6w2uGQYVipwWQqDd53JIdM+
         vs9jAiYVoa75JSlvm8LX50eorTh3fuKVoZQK9146Km+UNiu1sP1TYrwX/adpvXOoRzeC
         uV6qbVwBxWTTzt2DCMgXDc+m2Ct4L2+UkEOXjM2Gi06p3iU4lLDv0mQFwnDWcKttohpI
         0zvZa+xcT0Wj9KCR65w8hezyt5Zk3VH4oeDSe0/cIxM+T1NlG6+1etqtmijjV4BIGZfy
         jQy+Qa7Sy4KIOXDPrGWq+f9eSxOc6uvLgl5k37XtJop+H/Ir53uQGHN9ILVFmCQZm5FE
         WccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXeaVOM54zatWXZ5qzke97zx1OY9L8LMNKUJXVt61MY=;
        b=dqgWtOaUEaYmCDrUusk20S3VYFHIElT3iJvz2MmFzeVQ/jvbqmz8d1C+sYbQ40ZSFi
         R5XKaZSne5EjtFH+5X7cP1NGtzWvHZphzJX/lVrFBl+eTvn1qjFVbeZ2Tku0+v5Zeg1X
         7fqFstUYBBOuhJDUdCmj0CBO1YLxYPgWoPHEW+XJmBJ+QEDO4yFosad+GVKazYbFkR5J
         YzzM5a1/SlM4EnkZAgwVsdCz28bqev5FUmB04tXhBilKTMs7yTjCT9Evij+o3/WYrW3V
         VusQGfOyht+Efbb11079yOkMgsse8ePjNn9wSEIRRghWOrJ9LATYd5rlZb+CbBPVq1+g
         bU7A==
X-Gm-Message-State: APjAAAXNZl9d7gdjkmL4lEaxs4ve4abNwlQ9UPTwboJ6jIx7MkuLYfrI
        3VMVnJkPqjximAj3paNe9n8Dp3LEL+WtwEwc+Ag=
X-Google-Smtp-Source: APXvYqycDnwsock1UK2R5fmGlztj1V/5cvdqMfIleUEMrrjwaZhtHzAXaI7ImgqJE70hAfx6Lg8pEcoOlHvbMKtQJ8E=
X-Received: by 2002:a05:6808:8da:: with SMTP id k26mr2063957oij.5.1569494079433;
 Thu, 26 Sep 2019 03:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <1569459243-21950-1-git-send-email-wanpengli@tencent.com> <ea06c6bb-c6ff-ef34-55ca-c58cb77ed39e@redhat.com>
In-Reply-To: <ea06c6bb-c6ff-ef34-55ca-c58cb77ed39e@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Thu, 26 Sep 2019 18:34:26 +0800
Message-ID: <CANRm+CySCXpn=CUnfUYf+r4aAFOOVscryLQqDnYhTstb4Hv=Hw@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: LAPIC: Loose fluctuation filter for auto tune lapic_timer_advance_ns
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

On Thu, 26 Sep 2019 at 18:25, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 26/09/19 02:54, Wanpeng Li wrote:
> > -#define LAPIC_TIMER_ADVANCE_ADJUST_MIN 100
> > -#define LAPIC_TIMER_ADVANCE_ADJUST_MAX 5000
> > -#define LAPIC_TIMER_ADVANCE_ADJUST_INIT 1000
> > +#define LAPIC_TIMER_ADVANCE_EXPIRE_MIN       100
> > +#define LAPIC_TIMER_ADVANCE_EXPIRE_MAX       10000
> > +#define LAPIC_TIMER_ADVANCE_NS_INIT  1000
> > +#define LAPIC_TIMER_ADVANCE_NS_MAX     5000
>
> I think the old #define value is good.  What about:
>
> -#define LAPIC_TIMER_ADVANCE_ADJUST_MIN 100
> -#define LAPIC_TIMER_ADVANCE_ADJUST_MAX 5000
> -#define LAPIC_TIMER_ADVANCE_ADJUST_INIT 1000
> +#define LAPIC_TIMER_ADVANCE_ADJUST_MIN 100     /* clock cycles */
> +#define LAPIC_TIMER_ADVANCE_ADJUST_MAX 10000   /* clock cycles */
> +#define LAPIC_TIMER_ADVANCE_NS_INIT    1000
> +#define LAPIC_TIMER_ADVANCE_NS_MAX     5000

Looks good, I guess you can update the patch during apply. :)

    Wanpeng
