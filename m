Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC472C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 01:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52A12171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 01:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bTgJPRLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405421AbfHIBfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 21:35:40 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38062 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732796AbfHIBfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 21:35:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id d17so126709968oth.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 18:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=oT9+0FRk0XTKJRYl2Q4sGfwT0uvjls0OapEyGavcfH0=;
        b=bTgJPRLs2KrCeHGbSsBv9KpIvMO4o+oQxiwzpIwFpWL81l/u3yEfGm+OY2bjOE74R0
         9yYJw3nQi+IWuSeNzJUo1TO+upgefj8sw6thmlg87ONcHJ3BejfoutIAglkH2W1wIIzm
         41roYeNsXFspvh63xyi/HLeMW1uplON18rcefr8C4qTXVAdZ4fVmBYwo7wcmbvU7vJ1N
         vp2AVdy+3DnZW7iP3rOXxmt/us1b4gnH40TgQVxUcai+W8og/9GcqaEgP48JE/ttGIst
         PBl1Nr3HEwTHZ++nPN65TvwKesqbXB1Bgw3u07ro5xdvOsdOgWIEOrkOGNsEP3Z63dR/
         OAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=oT9+0FRk0XTKJRYl2Q4sGfwT0uvjls0OapEyGavcfH0=;
        b=rdIHKx60KmFlj7bnP7ZbRCwsTzhFOB37cPDAbxhzbJbHgEoUKih55HMGBb7x3FEtdu
         N2Ewy1dcLPMR12y73lYfJ6zoGjdTHAaXlx+wJkVwd8WHs28MS7nLFWOUZcrYaiV+zKlt
         CmkX5lhQEwUqpb/oFnLS8v4tsPbwYD8+eeuI7T1B049fNt1o7O9VphmsTmb3R0HBNcDj
         W1bW1j6f6NCpPMx8oDi0m2NE77OSL8Qhof/Eht5V10TSyQG98wprTfo7O7d872nSz/2r
         VSUHRbzeLvClftlyP5gTVLLf0HuLNBPnnnxKoyB9w0SeYfeegmXeCII4E9cZA/4S4pzt
         JfcQ==
X-Gm-Message-State: APjAAAXeb/zJDxMd8g1vYAKx1nS6de3t6ztCARRHB/tq8YgUneWi7E2E
        qRs1YZ+ftJh62vbF2zZGa8QEDQ==
X-Google-Smtp-Source: APXvYqz6ICJH3+/BdftjNoVT6B/6SpEFAG0akxiwAjeOkWh6cvUY64FsLO+6gp/jqLLJBXFNGB3+Kw==
X-Received: by 2002:a6b:641a:: with SMTP id t26mr18476138iog.3.1565314539454;
        Thu, 08 Aug 2019 18:35:39 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id z6sm2274953ioi.8.2019.08.08.18.35.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 18:35:38 -0700 (PDT)
Date:   Thu, 8 Aug 2019 18:35:38 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Paolo Bonzini <pbonzini@redhat.com>
cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup@brainfault.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/20] KVM RISC-V Support
In-Reply-To: <df0638d9-e2f4-30f5-5400-9078bf9d1f99@redhat.com>
Message-ID: <alpine.DEB.2.21.9999.1908081824500.21111@viisi.sifive.com>
References: <20190807122726.81544-1-anup.patel@wdc.com> <4a991aa3-154a-40b2-a37d-9ee4a4c7a2ca@redhat.com> <alpine.DEB.2.21.9999.1908071606560.13971@viisi.sifive.com> <df0638d9-e2f4-30f5-5400-9078bf9d1f99@redhat.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019, Paolo Bonzini wrote:

> However, for Linux releases after 5.4 I would rather get pull requests 
> for arch/riscv/kvm from Anup and Atish without involving the RISC-V 
> tree.  Of course, they or I will ask for your ack, or for a topic 
> branch, on the occasion that something touches files outside their 
> maintainership area.  This is how things are already being handled for 
> ARM, POWER and s390 and it allows me to handle conflicts in common KVM 
> files before they reach Linus; these are more common than conflicts in 
> arch files. If you have further questions on git and maintenance 
> workflows, just ask!

In principle, that's fine with me, as long as the arch/riscv maintainers 
and mailing lists are kept in the loop.  We already do something similar 
to this for the RISC-V BPF JIT.  However, I'd like this to be explicitly 
documented in the MAINTAINERS file, as it is for BPF.  It looks like it 
isn't for ARM, POWER, or S390, either looking at MAINTAINERS or 
spot-checking scripts/get_maintainer.pl:

$ scripts/get_maintainer.pl -f arch/s390/kvm/interrupt.c 
Christian Borntraeger <borntraeger@de.ibm.com> (supporter:KERNEL VIRTUAL MACHINE for s390 (KVM/s390))
Janosch Frank <frankja@linux.ibm.com> (supporter:KERNEL VIRTUAL MACHINE for s390 (KVM/s390))
David Hildenbrand <david@redhat.com> (reviewer:KERNEL VIRTUAL MACHINE for s390 (KVM/s390))
Cornelia Huck <cohuck@redhat.com> (reviewer:KERNEL VIRTUAL MACHINE for s390 (KVM/s390))
Heiko Carstens <heiko.carstens@de.ibm.com> (supporter:S390)
Vasily Gorbik <gor@linux.ibm.com> (supporter:S390)
linux-s390@vger.kernel.org (open list:KERNEL VIRTUAL MACHINE for s390 (KVM/s390))
linux-kernel@vger.kernel.org (open list)
$

Would you be willing to send a MAINTAINERS patch to formalize this 
practice?


- Paul
