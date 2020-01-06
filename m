Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79633C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F45207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IgURydL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgAFUSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:18:07 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41934 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgAFUSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:18:06 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so46387119ioo.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 12:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HntsUTCq9EJcXqpEDDbtnISyYD528YUbA0G+2iMAdkg=;
        b=IgURydL7ZmFcZ617oC7Fzty/+XRo10VzsVQOERs0Cjc68xMclG93vGJdGKjPZ0ONzK
         nUW4Q1M5ML236KuMtdi9T6w6jc6mD8e8rnVpjVU/44csfaitVnF38N48GI/K83aswm8l
         t6lf1NzaEU3EyM3ZotPzTbogCuTL9Snt4I+2p5ebBfsrOS87g96DM9PiD4oCSxjm7wrC
         aA/1Mi41ualxuvZxsf804wyTaXZxwP6ki6w3Kl234GS89AjNjyzgtd0gYcVQ1ZOd8atg
         cdJ3ufjp22V6jMod2PKF01h8YZU98kpXg38ZA/l1DbdP5sV9BqjGlla0o2v5lrf5t25q
         6+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HntsUTCq9EJcXqpEDDbtnISyYD528YUbA0G+2iMAdkg=;
        b=FM8qxgNwj1nB1jLBTGlOOj+0QVLr3GAGa7+74x+SUrVHRvXGZNNcsNLeyIqq3jly6W
         mmvOYaja6EnzBDTU9P5+B13XNt/H6S0jdhdFy0UM+YGNGHTTCXUiZXP+OqPDizr9f0TY
         Wn38wKlg+Z4WiqbohRg+TRMq+2Mnk8lQObO5ux0SDIH0wcSW9B5tq8XX0T0HxEUntCio
         MxF0no6Huw7kayk/xVCq4gLk7GGtgvwoavq6fbixtCz/yLFmVnVQjidMc4Ym7aFNdlt1
         TXRgoreddtybnhAG2ImBZ9SfGyHGFNrcBeflIsD8Kgv5R4Lh+57uO9WzGMrlPekS6EMY
         ggag==
X-Gm-Message-State: APjAAAWxQkAwxbWTfKyFqyj0+VBDRv4dQB6rPFuKbSYcl/9N7oCAmtmr
        rAgqh41NF1jGsYqU6i3MRoW7af7mg5TiivInwvz61Q==
X-Google-Smtp-Source: APXvYqzdj0DXif/5YJj6CweBZv8KDa9rjRJILE7oJcw7GrLAu4IfLN+YndEbhWFFOAW1jcm3U9IjK2DrgvQEPZPOVRI=
X-Received: by 2002:a6b:740c:: with SMTP id s12mr30497900iog.108.1578341885911;
 Mon, 06 Jan 2020 12:18:05 -0800 (PST)
MIME-Version: 1.0
References: <20191211204753.242298-1-pomonis@google.com> <20191211204753.242298-7-pomonis@google.com>
In-Reply-To: <20191211204753.242298-7-pomonis@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 6 Jan 2020 12:17:55 -0800
Message-ID: <CALMp9eQNHf61n4uuiAKWaZbD4jBAj4hUVeBtbpJA4xi7=3E=cQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/13] KVM: x86: Protect kvm_lapic_reg_write() from
 Spectre-v1/L1TF attacks
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

On Wed, Dec 11, 2019 at 12:48 PM Marios Pomonis <pomonis@google.com> wrote:
>
> This fixes a Spectre-v1/L1TF vulnerability in kvm_lapic_reg_write().
> This function contains index computations based on the
> (attacker-controlled) MSR number.
>
> Fixes: commit 0105d1a52640 ("KVM: x2apic interface to lapic")
>
> Signed-off-by: Nick Finco <nifi@google.com>
> Signed-off-by: Marios Pomonis <pomonis@google.com>
> Reviewed-by: Andrew Honig <ahonig@google.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Jim Mattson <jmattson@google.com>
