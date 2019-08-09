Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5225DC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2038720C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="E/Vu0yrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406097AbfHIJ1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:27:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41927 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfHIJ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:27:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so94356813wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 02:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OLdmDC9KjK8wHYH/YMGOndzUePeH788tGhoJ+JIDrPM=;
        b=E/Vu0yrEkOThSq9wuddnkRFUhVX217tVcF3EL/LqSZyuKCRyKIxRjF9CXhrEEAHERj
         Q78KpXScVLFUeq0sJzV1UbMno/4roNOmcTPmtp6LDPxIEZxgoKmDFXbxJsW35JfksSg4
         up7eANYH6DWzkqrrxbbsvvQMy/Pmr+PbSKNtpjS795l/bRS6ltOGZHD40QmAaTSzoX8+
         qZrtihKBmIh/EeryTVirjIksEkj1jr2S4QJbSL+HBW6jt70MrpB1de5QbKFjISaqb2UA
         VuP7HE4kdZjsx0Mjv+N8fjLsV5esiL3mqw89fVOMfZRHQ8T0v9SKQZ4KA/eBMNA/5j1I
         NVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OLdmDC9KjK8wHYH/YMGOndzUePeH788tGhoJ+JIDrPM=;
        b=KQbOqmypac6zCvZrWMmDPTykiK6yYZTkaKAJU3lKh3A2G4VNX3XPqpXqp7WJWKrBOP
         37scYXCSbTzjeT5tsSg2o/k7lufmdAaySeizBwmrTNrsVpDFAsYsNupIfvcrlOn3Jqcw
         1dtYyoCncbZ8U7fF/yKK9roMVYG9j6/nV3tMzE7baOMlb8iRyxJ7Tve04v53aEDEFnTz
         FxMgKeUnPE6PSfzZPaVXPJmgrngDlOt37gT4/3VW2ddlP4WZiKNWG0GAg9ITVNMx8KpK
         REFHeTkvjCoJ+gV/lau/9JjWFMJ2Ay2kD+4/60uCYi+egRA3VPjY1zUuLBBxkwONBORQ
         F6pw==
X-Gm-Message-State: APjAAAUjziqlwDMj+C4kdVnJyKRFx9/n9nVc2cHz5NFU+1zkwBVRRJkw
        hmWueWHp98mxGfuVoooeqQSjxrLHqSObdvZjwuz30A==
X-Google-Smtp-Source: APXvYqxB1pzR3hxupojw9Egj6YewSb1YvyESNLOa/iAcw0xgJGG8uNiUTWLKLCG/1fQBkubFwECh5h4lkT0KrD5JV44=
X-Received: by 2002:adf:b1cb:: with SMTP id r11mr21389392wra.328.1565342818831;
 Fri, 09 Aug 2019 02:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190807122726.81544-1-anup.patel@wdc.com> <4a991aa3-154a-40b2-a37d-9ee4a4c7a2ca@redhat.com>
 <alpine.DEB.2.21.9999.1908071606560.13971@viisi.sifive.com>
 <df0638d9-e2f4-30f5-5400-9078bf9d1f99@redhat.com> <alpine.DEB.2.21.9999.1908081824500.21111@viisi.sifive.com>
 <2ea0c656-bd7e-ae79-1f8e-6b60374ccc6e@redhat.com> <CAAhSdy1Hn69CxERttqa39wWr1-EYJtUPSG7TZnavZQqnMOHUqA@mail.gmail.com>
 <97987944-b42f-4f51-acfb-f318b41875bc@redhat.com>
In-Reply-To: <97987944-b42f-4f51-acfb-f318b41875bc@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 9 Aug 2019 14:56:47 +0530
Message-ID: <CAAhSdy2-72mJWMyeBrOgp0m=FKRKdDOuj8aoyEwJcTG20tDUtg@mail.gmail.com>
Subject: Re: [PATCH v4 00/20] KVM RISC-V Support
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
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

On Fri, Aug 9, 2019 at 2:30 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 09/08/19 10:22, Anup Patel wrote:
> >> the L here should be kvm@vger.kernel.org.  arch/riscv/kvm/ files would
> >> still match RISC-V ARCHITECTURE and therefore
> >> linux-riscv@lists.infradead.org would be CCed.
> > In addition to above mentioned lists, we insist of having a separate
> > KVM RISC-V list which can be CCed for non-kernel patches for projects
> > such as QEMU, KVMTOOL, and Libvirt. This KVM RISC-V list can also
> > be used for general queries related to KVM RISCV.
>
> You can use kvm@vger.kernel.org for that, with CCs to the other
> appropriate list (qemu-devel, libvir-list, LKML, linux-riscv, etc.).
> But if you want to have kvm-riscv, go ahead and ask for it.
>
> In any case, you can send v5 with all R-b and Acked-by and a fixed
> MAINTAINERS entry (listing kvm@vger for now), and Paul will apply it.
> For 5.5 you can start sending patches to me, either for direct
> application to the KVM tree or as pull requests.

Sure, I will send v5 early next week.

Regards,
Anup
