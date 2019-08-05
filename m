Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1693C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B6A2087B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="D9rI32Di"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfHEMNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:13:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53071 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbfHEMNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:13:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so74481729wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 05:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0wxhgVqa1i5HebLBuhj43emhxcpL4j6myhHfva4riI0=;
        b=D9rI32DitY/CLc62d2LYXuif0Sbwy/BVZgEu6va3gBgeD8+1ddHIfdW7ic1Zh2gEhq
         W44Qc3nNnlpInYGMKMRkxAcobDCOl3hPWqCvlhgC7zWJKahoO7xyygJx7raDpU3RdEHL
         9vMB9ahaW6qDtb29DKRiWz5r+OL6qvF+gUoOahe7ndwA6mWCAzaAuzjivLCFSWILYRVF
         jvGOFLNavph0BxW02G76lSInbZ60CNfUihG89FP99cZxyY2eZNJ8132Qz2EzW3pgj9Mj
         esX4XUebXFy3HmJ4zOxgr5B5FJn+vD5Vv9WbihVVGNAGfERb5klJIdJL86Tfaz2mIzne
         Xwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0wxhgVqa1i5HebLBuhj43emhxcpL4j6myhHfva4riI0=;
        b=R2R0fJ1Nj6ilzYvyPC0URYdgGMXwUqmO592+JgOJVyCDwMPb5qVeJJ5SezOsttSN41
         2EZ8KHnjyjUeJB2Sgl/W71/lpAdHgC6qaAPUMCu4q/hdwAXAgVXsjv0ELitIJPGlXUXJ
         b9n96IiN3vaX37m2fEtPIhX+9YTE/VFqg5k6S6Wo6YcjNxrNF/C58kLsCka+GMZyIhpr
         2yXcLUokWH6OdrnLYNaw9ta17pq39ofMLlknsMSx54mrB+vxgTlZYjyVcLeTenBJk7Nk
         N4Q9KNdpMMz4WdGISbUpG6xJmmkMTeNYIRzyeyjvbXWSUEbkLua2hjj6QbgrJeL5/dVp
         RN8Q==
X-Gm-Message-State: APjAAAUOEeS1jMa4f6DArWimC6zMafukJ2PjqB1vgk2PO70qtGodFfhF
        MaedmRXwfT0wS/UfuvsR1ygcVJQhPAxG5rjyalI=
X-Google-Smtp-Source: APXvYqzTS/w3xceeGnXPkz2ziZ/qExTBJtgjboccYQd7cdW0Ah42GE9a/wIpMA5BQWIqpCVbIOmkP50fin5L4WuSmpo=
X-Received: by 2002:a05:600c:254b:: with SMTP id e11mr17300244wma.171.1565007219377;
 Mon, 05 Aug 2019 05:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190802074620.115029-1-anup.patel@wdc.com> <20190802074620.115029-8-anup.patel@wdc.com>
 <edbed85f-f7ad-a240-1bef-75729b527a69@de.ibm.com> <CAAhSdy2PDSpTy1JEEC2LCB4ESvZHBbkVEZ2wqz-D2b7SKD5VSg@mail.gmail.com>
 <09417197-36e8-718f-f106-29466ef406e3@redhat.com>
In-Reply-To: <09417197-36e8-718f-f106-29466ef406e3@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 5 Aug 2019 17:43:27 +0530
Message-ID: <CAAhSdy1tfL6uLeXANzuZLidg9E-YTUfDQU7zxhBz1_AH+BvZaA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/19] RISC-V: KVM: Implement KVM_GET_ONE_REG/KVM_SET_ONE_REG
 ioctls
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Anup Patel <Anup.Patel@wdc.com>,
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

On Mon, Aug 5, 2019 at 5:31 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 05/08/19 13:56, Anup Patel wrote:
> > We will certainly explore sync_regs interface. Reducing exits to user-space
> > will definitely help.
>
> sync_regs does not reduce exits to userspace, it reduces ioctls from
> userspace but there is a real benefit only if userspace actually makes
> many syscalls for each vmexit.

Thanks, got it.

Regards,
Anup
