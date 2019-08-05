Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B3CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941162086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="soqdUaOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfHEKIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 06:08:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53256 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfHEKIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:08:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so74150132wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 03:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbNFx4il0vCPP+D1Yz8x0vBctgaZ7/n1Iil30rI0v3c=;
        b=soqdUaOSralN5UpCSAB4aYas5NIxSdLzk1zgv+q/98sdZRE/Uio34RwJkvg1ux7XVs
         5poCzxjYX/nORxXWgj3xE0G83Bz7cFBvE1iIpyBVDkt78RiH8zefcLYFlr0F5jMCd1Ys
         zqaqJQGjdQgEXy5SvmyviyhLNfmFZ5R2Vus7q5cL4v/7rZmpzUkfesNqIBiKd+qA6ASm
         uS8eIqrPz9w1mhrcpTaemqzJWqMdIJQjzP3GuXWRLxnteiDrRBlZKwwPZAquJJGv20z0
         P9m/MxCTFRpkb64kjtVIL9zLa4hPiuJ+vlS9IEovo8tfKl8WuzZtEKHfGmN9d7eBZ9GS
         hh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbNFx4il0vCPP+D1Yz8x0vBctgaZ7/n1Iil30rI0v3c=;
        b=czC3SH5/I7pLu+0sMLf4UuoZ106+RA0So6r7oyIDNUQa0oioT4cFXo+i722IcWoOU6
         bWLSi4KamY7NxYSq6tkhAq7+Mjh/h+we72Ip6nOUnerVprvgp1bvRF53Zn0xDnl5g45U
         p7xWKbQvU6hkzoOGSzZMmuoDNfYYqtMnkfFRxUP4L3TXYd6/CmuBImuraEIf5mn5hJHZ
         3d7A2hdJxa8GnpFWVTfIQ3HjKg3c27lw1ZsXgubL6sFJlKewBVhuoHqqcpYjgTG0TSgg
         4h4Tb9KyLwaLcCduSMWokeDsMn0EXwpAJay84gaOWniq7jfERM2J5Bqu46zJ0lyUCBWV
         WhxA==
X-Gm-Message-State: APjAAAXZsCtZcku+di5FIXeMvceeaz6RrEPLM2gLj7lKpwE29J9fDZV4
        ThjgJ744N3HL/y5AtBn+qzW1wJdhNOtckSx9gY+RNw==
X-Google-Smtp-Source: APXvYqzl6kVeF2s9w7in3km5UbjnsJP2KDV81u1ARcFGpnOlD6I6q3QS6xKNc4B1wsWV/lZiflA7ohYpAdCiNvg9Bks=
X-Received: by 2002:a1c:cfc5:: with SMTP id f188mr16598754wmg.24.1564999730931;
 Mon, 05 Aug 2019 03:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190802074620.115029-1-anup.patel@wdc.com> <20190802074620.115029-13-anup.patel@wdc.com>
 <949b75ef-5ec6-cdfd-5d5d-5695f35bd20c@redhat.com>
In-Reply-To: <949b75ef-5ec6-cdfd-5d5d-5695f35bd20c@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 5 Aug 2019 15:38:39 +0530
Message-ID: <CAAhSdy33_2Qin5+VWp8AhG95DRu7+16fGgVC1Of=QOkNmCJjHg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 12/19] RISC-V: KVM: Implement stage2 page table programming
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 2, 2019 at 2:44 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 02/08/19 09:48, Anup Patel wrote:
> > +     hgatp |= (k->vmid.vmid << HGATP_VMID_SHIFT) & HGATP_VMID_MASK;
>
> This should use READ_ONCE.

Ahh, missed this one. I will update.

Regards,
Anup
