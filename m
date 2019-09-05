Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9983C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE1F2145D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jMQkaaRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732890AbfIEI45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 04:56:57 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40291 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfIEI45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 04:56:57 -0400
Received: by mail-oi1-f193.google.com with SMTP id b80so1157969oii.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 01:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IaZJ01VOJ44Z6Y9Qs3oUQiygt2Sy6fVI1ZsDthTYEac=;
        b=jMQkaaRRxSCpAfa0GGbTxN8sdW3BCz1aSdR6b+EoXx/Ue0KZCOzdiDMjAbfR7+eunv
         kx6XBxSzt7twCIJybPMD0h4eaU9yCitmULNsKZtsM1dUaTLn0IRFZwSO/spnqaAIn/WK
         smp1BnN01ssm7CCtza47yOcSEOeIXZ1ZULlSTfRZOEsNqdrJ7B42GvgGl8dAkW5Gxttk
         u9esLSmQOOsONHcK/RUZ141vgbuInB0YtTAbMwB/kfkNXGOaqNn3qNIWIPfg6k2EvkkU
         XJaDvfUoQwhTXwEmZVrsd8airEaBOdhwLNIkte996VruPPflokhLzMWXcXhvYQ73j8Px
         FatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IaZJ01VOJ44Z6Y9Qs3oUQiygt2Sy6fVI1ZsDthTYEac=;
        b=oGrDXcSpOTs/QH1kp+44p4djkferyHWDDeKpxhMAjNatEnfvwqSk4vVRXXKWVI0lSi
         hHqsKA3ybOumhbMciklM+kVYerHiabItEwHSTkuYXYF8+o7H/5YEnzMoIVxX45zGfefy
         cGSyetwEibRjXWtVla2ksVuUOqvtz5pmw6qGUg834DmE18uQxgQgj1ZxyK3xgFL89Oxl
         6uz2Wa7+dIfRjnSeeHmk4XpnUR4aJHpGFfw6/luh7jlN7mqxLEvfHs7Om4vKfceV8KZu
         ZHE5b/pUK/vpa9vt9D28Vo9tPrGtKCE3Dy2sdVlBAiVmeDkt0boYJe7+RVzc6M3nA0KC
         Rqag==
X-Gm-Message-State: APjAAAVlLqjAu8QmrwsdS0mWNns2fNxP+FxMZiuMny1vgSv9m9A7PEkn
        W6dv+8rwcezhLlFuQtj8Zy+721R4/z6wz503m5h+RQ==
X-Google-Smtp-Source: APXvYqwoy7MTqB4H3mDdtS3aRDNvVJhhOoQARzpS77k98EfHG9CbyovynxJ3OmaOX9n7dO2thM4lg6LAw11dh4CzMMw=
X-Received: by 2002:aca:f54d:: with SMTP id t74mr1740404oih.170.1567673816212;
 Thu, 05 Sep 2019 01:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190904180736.29009-1-xypron.glpk@gmx.de> <86r24vrwyh.wl-maz@kernel.org>
 <CAFEAcA-mc6cLmRGdGNOBR0PC1f_VBjvTdAL6xYtKjApx3NoPgQ@mail.gmail.com> <86mufjrup7.wl-maz@kernel.org>
In-Reply-To: <86mufjrup7.wl-maz@kernel.org>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Thu, 5 Sep 2019 09:56:44 +0100
Message-ID: <CAFEAcA9qkqkOTqSVrhTpt-NkZSNXomSBNiWo_D6Kr=QKYRRf=w@mail.gmail.com>
Subject: Re: [PATCH 1/1] KVM: inject data abort if instruction cannot be decoded
To:     Marc Zyngier <maz@kernel.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019 at 09:52, Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 05 Sep 2019 09:16:54 +0100,
> Peter Maydell <peter.maydell@linaro.org> wrote:
> > This is true, but the problem is that barfing out to userspace
> > makes it harder to debug the guest because it means that
> > the VM is immediately destroyed, whereas AIUI if we
> > inject some kind of exception then (assuming you're set up
> > to do kernel-debug via gdbstub) you can actually examine
> > the offending guest code with a debugger because at least
> > your VM is still around to inspect...
>
> To Christoffer's point, I find the benefit a bit dubious. Yes, you get
> an exception, but the instruction that caused it may be completely
> legal (store with post-increment, for example), leading to an even
> more puzzled developer (that exception should never have been
> delivered the first place).

Right, but the combination of "host kernel prints a message
about an unsupported load/store insn" and "within-guest debug
dump/stack trace/etc" is much more useful than just having
"host kernel prints message" and "QEMU exits"; and it requires
about 3 lines of code change...

> I'm far more in favour of dumping the state of the access in the run
> structure (much like we do for a MMIO access) and let userspace do
> something about it (such as dumping information on the console or
> breaking). It could even inject an exception *if* the user has asked
> for it.

...whereas this requires agreement on a kernel-userspace API,
larger changes in the kernel, somebody to implement the userspace
side of things, and the user to update both the kernel and QEMU.
It's hard for me to see that the benefit here over the 3-line
approach really outweighs the extra effort needed. In practice
saying "we should do this" is saying "we're going to do nothing",
based on the historical record.

thanks
-- PMM
