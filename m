Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFB7C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45FC21901
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vUglrC4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfGZHrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 03:47:04 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34851 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfGZHrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:47:04 -0400
Received: by mail-oi1-f193.google.com with SMTP id a127so39608819oii.2;
        Fri, 26 Jul 2019 00:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SbWcDwYKQdXVSb+eJSxGdWzD+NMuj2/p/3sqbKkjZgY=;
        b=vUglrC4OdE6Jg602zhTCsLq4EYS2vX1vwInm362QQeAwmTKhuPrv2ca360EJfMWPyw
         ur87HWiWNmpga2E9mtTr7TFUI7wkqx9FW0czOzsTGWqfBFpXqdSzg4kKjtMQXQYgI5ZJ
         ww+dVOTJGbcQBBUB8E3vTS8NJnVdF1/OH/2EEIrc3grC1u7EUeTS72POT6i1Coji8zgi
         yvP8ACNFiKyJATuLGL9tnKFxKfC5rmug0UV4SEPO/wgSRusWzonxsSOUgIKB9yNHB4Ez
         1TOw2UqpzAujzC7PXaO4utUTG0aCTGg0cOZ1ahn6vlVCTJMgWTPhTbVWMgNiQos0JPZF
         3Ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbWcDwYKQdXVSb+eJSxGdWzD+NMuj2/p/3sqbKkjZgY=;
        b=bN1VZdCq7tCQvbLz9LN4R6sauHM/V3yS/kCGk4jU89+7tCUdiglFqoCb4wwxMDuasf
         Jt/0/bYqSDd5jWgcZb/91g/SAXlqkwrK/dYx9BZPK6zapav+J0pr+xezbv1Kz6H4LqMk
         6FSctPHwOQoTXHZnm1X1MsPQdCvRQUGZrMFCAmtGgOExVwyVXzyVLqqGAfVT0Me7NhG1
         1iAf2NsTcJREWSydGhBfyKR916G8FXu5nEK9+t1K8b4T28Eiclr8TO78seOq5MSkdMeT
         VTPJm4Zit2az06GbdjnI11/4xR4ehGwQ9OYYdChk+5mivrSSRlntpl+R3cGTDJ8doWUw
         Z9Og==
X-Gm-Message-State: APjAAAXLBY42OLpDGmpEPmHEguHR5DtvzDyBgAY8FjyC04xEXcKaCwzm
        KX2SJcj9EfQxB0JtbUyCssB+8YuhFAZBtemmLW4=
X-Google-Smtp-Source: APXvYqxY9Gj95MBlN7NlxJqPeccq8SbON6L99ijd22FT0NtAVFVZ4DBNqP6jQOQ0BR4CH8SezFX9fJNF291p/lJcyUw=
X-Received: by 2002:aca:b9d4:: with SMTP id j203mr44850316oif.5.1564127223372;
 Fri, 26 Jul 2019 00:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <1564121417-29375-1-git-send-email-wanpengli@tencent.com>
 <CANRm+CzTJ6dCv=NSHLGV-uWdaES2F0T7PXgu0LXXEsBCJ8mxEA@mail.gmail.com> <alpine.DEB.2.21.1907260917340.1791@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907260917340.1791@nanos.tec.linutronix.de>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Fri, 26 Jul 2019 15:46:50 +0800
Message-ID: <CANRm+CxbLJv0ZoSA2_84B9Xe0nBOWwYrYN3jZFrmU6N5Zr+EkQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Use IPI shorthands in kvm guest when support
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Nadav Amit <namit@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 at 15:20, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, 26 Jul 2019, Wanpeng Li wrote:
> > On Fri, 26 Jul 2019 at 14:10, Wanpeng Li <kernellwp@gmail.com> wrote:
> > >  static void kvm_send_ipi_all(int vector)
> > >  {
> > > -       __send_ipi_mask(cpu_online_mask, vector);
> > > +       if (static_branch_likely(&apic_use_ipi_shorthand))
> > > +               orig_apic.send_IPI_allbutself(vector);
> >
> > Make a mistake here, just resend the patch.
>
> Please don't use [RESEND] if the patch is different. Use [PATCH v2].
>
> [RESEND] is used when you actually resend an unmodified patch, e.g. when
> the first submission was ignored for a longer time.

Will do for next time, I guess Paolo can still review the [RESEND] one
for this time to avoid my patch flush the mailing list. :)

Regards,
Wanpeng Li
