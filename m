Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4D7C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4751F2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbfG3NTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:19:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45750 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730717AbfG3NTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:19:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so65730934wre.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 06:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4T+N5rDWzyUqBCwwe6XKAKGnNik0HfsnLC/oOFv9Yvo=;
        b=LbEzsL+HUcbVMLLH5cuq8osREhv7Jqm+21to5L03A+k+robuL3vh1Nvv5Y5uW43df8
         EelUIly/R604iITTLCT+GCUUDz7OS5vNMUPWocyZwJD2X6XYBfHtaxiTLmZAF7VwH4wS
         91nnoN3UGhWkPSK4KvZXI6DBtXOk/nsYcGua+demvEfLlc7gNcHKBC3euCu7oITZUVk5
         3/GN/bkIy7Ra0kTp8cMMk8leiStbI5INzIYnC2YqdQFM6bft9IO/StV4/FIJ3tLy0Ya1
         bPIfZa5xq5+VNTZ5np9TBI7YUGeFpkcaXDF2mDB1c/SqKimkhvGQes3sszabAJyQQDmw
         qBAw==
X-Gm-Message-State: APjAAAXeM4JFWxMB2Vwdle4dxThArhQSElFK2dBk4eTKAwOOo2p/2Azk
        EgAty9EEQRmZqXuEpcG/SLuppfi9t7Y=
X-Google-Smtp-Source: APXvYqxH5jMUMQZRjTvBj61yj3IX+c8QpeNllhHi+YlYGKDbWnFDORisbT652uSyoJl02SGXzGJpZw==
X-Received: by 2002:a5d:4212:: with SMTP id n18mr5731078wrq.261.1564492738582;
        Tue, 30 Jul 2019 06:18:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29d3:6123:6d5f:2c04? ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
        by smtp.gmail.com with ESMTPSA id a8sm51401838wma.31.2019.07.30.06.18.56
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 06:18:57 -0700 (PDT)
Subject: Re: [RFC PATCH 05/16] RISC-V: KVM: Implement VCPU interrupts and
 requests handling
To:     Anup Patel <anup@brainfault.org>
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
References: <20190729115544.17895-1-anup.patel@wdc.com>
 <20190729115544.17895-6-anup.patel@wdc.com>
 <9f9d09e5-49bc-f8e3-cfe1-bd5221e3b683@redhat.com>
 <CAAhSdy3JZVEEnPnssALaxvCsyznF=rt=7-d5J_OgQEJv6cPhxQ@mail.gmail.com>
 <66c4e468-7a69-31e7-778b-228908f0e737@redhat.com>
 <CAAhSdy3b-o6y1fsYi1iQcCN=9ZuC98TLCqjHCYAzOCx+N+_89w@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <828f01a9-2f11-34b6-7753-dc8fa7aa0d18@redhat.com>
Date:   Tue, 30 Jul 2019 15:18:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAAhSdy3b-o6y1fsYi1iQcCN=9ZuC98TLCqjHCYAzOCx+N+_89w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/19 14:45, Anup Patel wrote:
> Here's some text from RISC-V spec regarding SIP CSR:
> "software interrupt-pending (SSIP) bit in the sip register. A pending
> supervisor-level software interrupt can be cleared by writing 0 to the SSIP bit
> in sip. Supervisor-level software interrupts are disabled when the SSIE bit in
> the sie register is clear."
> 
> Without RISC-V hypervisor extension, the SIP is essentially a restricted
> view of MIP CSR. Also as-per above, S-mode SW can only write 0 to SSIP
> bit in SIP CSR whereas it can only be set by M-mode SW or some HW
> mechanism (such as S-mode CLINT).

But that's not what the spec says.  It just says (just before the
sentence you quoted):

   A supervisor-level software interrupt is triggered on the current
   hart by writing 1 to its supervisor software interrupt-pending (SSIP)
   bit in the sip register.

and it's not written anywhere that S-mode SW cannot write 1.  In fact
that text is even under sip, not under mip, so IMO there's no doubt that
S-mode SW _can_ write 1, and the hypervisor must operate accordingly.

In fact I'm sure that if Windows were ever ported to RISC-V, it would be
very happy to use that feature.  On x86, Intel even accelerated it
specifically for Microsoft. :)

Paolo
