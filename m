Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF10C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 19:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F1820854
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 19:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567883895;
	bh=sXmEqe+gF7DQG/nO4tf+XPyNl6rsBfqXAl0wIiPFHDQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cnsW3GEHZjPfrSnRX/lD9ngAbm3Z1pJY8Hsp/9+9uEgCVX1psLkZ3lkN1XZSoCpzw
	 XtnNWwoltzf2IuDYhXpOu85NyIMPvQ8vNfR2V7R+FW0N2D0nc22SWCGEknUbSajSsL
	 Y2TXLkw3lkqGWI1vQ1DH7rIJ6EfVuuBvQN2Re0rw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403876AbfIGTSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 15:18:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35483 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfIGTSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 15:18:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id w6so7603792lfl.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 12:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XwVbZgJQjdxitsafoMUeKLcgUzEgG9R7QqVMwklal/s=;
        b=h72a+hFu/Zrtkr7IEOdoaFQVcAKgITVe4PwvPJrxmJNE0AHbgKbD9XjdcwnwjJAucH
         6BbnZQ/rTq8tDmpU7xCayzD/IZRN/j3J6NKokW/Y1049M+5VDRh0TebNf+ecwWON1Zne
         nWiWEyrt0FdOpg7OY9f91xiqkONTjPW6jhtsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XwVbZgJQjdxitsafoMUeKLcgUzEgG9R7QqVMwklal/s=;
        b=DcVtRG/us4Zhf/xhnocSky+sBm1YPHbUcIoVl3+LAelbc796BB1t2UozL520ZhmrOQ
         Pu7xjHkQXyqoqxo45xf/5DQus6YxASzZiw3dzlMOaJrt1JCkxktqTngbohMEYPZrg9FR
         zDTK5Q2FZjagI/bOcS97t8f/5I7+w2pfh5NAeaC0F13Twabx5lUpi1L0/GFE79bycGhd
         d7z8tvBMYhRmlFDgfKjVxCizuuIx72LoFg8H+7U5IICBNZFBt28iVvcLMQGy2Kif8Abn
         ShgsCkrH3acBH4xDToO/ejEesuRQG9oIpy08yGlZgQobE1fPB4uQE29Ihksb6bdo2PlX
         T00w==
X-Gm-Message-State: APjAAAVWExGX7lveQLMF+fuRDiWlYWUH4jEzQhG38hkpQVCfnbbCJSEM
        adZ80feBAMHw7RGmM6XeKQqncZoSGHQ=
X-Google-Smtp-Source: APXvYqxTkY6bbtMSKzF9PABTMxvvIG0dapysVToFfBMUKbhYjrttvpGzpMlTD6n3lLz2AaIFcaYiww==
X-Received: by 2002:a19:3f47:: with SMTP id m68mr10564190lfa.108.1567883891663;
        Sat, 07 Sep 2019 12:18:11 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id h19sm275667ljj.19.2019.09.07.12.18.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Sep 2019 12:18:10 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id q27so7557539lfo.10
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 12:18:10 -0700 (PDT)
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr10932128lfp.61.1567883889956;
 Sat, 07 Sep 2019 12:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wi_nBULUyO=OKtNBCZ+VSqdOcEiUeFqXTQY_D5ga5k4gQ@mail.gmail.com>
 <156785100521.13300.14461504732265570003@skylake-alporthouse-com>
 <alpine.DEB.2.21.1909071628420.1902@nanos.tec.linutronix.de>
 <156786727951.13300.15226856788926071603@skylake-alporthouse-com> <alpine.DEB.2.21.1909071657430.1902@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1909071657430.1902@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Sep 2019 12:17:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wikdDMYqhygJYkoWw7YxpGNx7O2kFRxbG91NNeFO7yu3w@mail.gmail.com>
Message-ID: <CAHk-=wikdDMYqhygJYkoWw7YxpGNx7O2kFRxbG91NNeFO7yu3w@mail.gmail.com>
Subject: Re: Linux 5.3-rc7
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Bandan Das <bsd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 7, 2019 at 8:00 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Ok let me find a testbox to figure out whats wrong there.

Honestly, it looks like we should just revert that commit, since we
never used to clear the LDR bits before either, and the bug it "fixes"
doesn't really seem to be a bug (well, it's a bug in KVM, but that's a
different thing).

And I wouldn't be at all surprised if it confuses some BIOS code.

We use the LDR bits ourselves in smp_get_logical_apicid(), and so
clearing them out seems entirely bogus.

At a guess, it's wakeup_cpu_via_init_nmi() that does that

                if (apic->dest_logical == APIC_DEST_LOGICAL)
                        id = cpu0_logical_apicid;
                else
                        id = apicid;

and now that we've cleared the APIC LDR bits, we no longer wake the
BSP. We send the NMI to the _old_ APIC ID, but we've overwritten it
with 0 when we put it to sleep, so now nothing happens.

I'm really not clear on why it's a good idea to clear the LDR bits on
shutdown, and commit 558682b52919 ("x86/apic: Include the LDR when
clearing out APIC registers") just looks pointless. And now it has
proven to break some machines.

So why wouldn't we just revert it?

                 Linus
