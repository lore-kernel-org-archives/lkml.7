Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91B8C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7F321906
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJLxdzCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393515AbfIFNus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:50:48 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33544 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfIFNuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:50:46 -0400
Received: by mail-oi1-f193.google.com with SMTP id e12so4710317oie.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 06:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3zKBTNhIg8D+FIn0RZewf6I27LDWwbXRyiB+RiFIt4=;
        b=QJLxdzCmNOBoOEJcJvHLBetbvlrq02aheoBREc7Fpa35nydqJO0APfx6nad3lCVm28
         lJ1ZUe0/fJeQUUFgiMPPj6/fbcM9e7OjKrEc1QrYxG5ClkOdWLBjZFFcMIApdjWbuChA
         GwWqFB90O/OmPDWZFtpAJd0+ch2CJJJrMPGfYnCy8OENP1wN2b8V+IZ2aaVx5mHzHYo+
         C0QkvjyNgA22hfWbRziRRoMC+Uw8bf7qwZa9iRMstY4NRjAsqoN/eAs29FaHED5FZO7H
         9y7wj4KZNLMXXLh1zyjnoa+6KX/HQ1RXmCmVcjWUoO1zek/YPUj/3Er41Lu+SUg8DZJ2
         YJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3zKBTNhIg8D+FIn0RZewf6I27LDWwbXRyiB+RiFIt4=;
        b=i2zWHzttYUYjrYD1Iff1Lghif6zPiD2CKtw7yAhppREvqX4Z2B0Rh0KvGCIeUdRV+t
         3DqvyIOYC1p8Z5Lz9OBKKZxcXaV1LCW7troQVm9QSp8lhIpPtOnY6I28RGmAFr1b66ET
         2SlG1C8MV5wIapIIqcF0VZaxJFA2QVcQSRlnqouLV2dWN2W5CzADIw7Ev9Ow40ghq19z
         uC36wt3JaInnf61H4r3vMRG6g5x8kuhwDrDU2FTzU584EEiYmctVLVzeGRW4HCpygfmM
         kGqzn7wBE4tYvXF6AQq9vM/tlbTxvRl9L+Svsqo7amuFUlGU8lvdNLn89xE/EMgPodeL
         UiRQ==
X-Gm-Message-State: APjAAAVsj0U7tAvRXNMbb7369q63sfEiELoEWw6pOvgVveAAGJRgXcVu
        zeI+PrNVO732f7fTQzRb/BFzSdSa6LJbQo/gNi01WQ==
X-Google-Smtp-Source: APXvYqxmXHWpUWZdq9c0hrTTVJDwQytlmXVaK7yqoJ7V8pIYxhd7z8W2/IAM32BufSMj7tAhgV/7VotgrBEcuRvwPrQ=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr6690938oib.48.1567777845580;
 Fri, 06 Sep 2019 06:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190904180736.29009-1-xypron.glpk@gmx.de> <86r24vrwyh.wl-maz@kernel.org>
 <CAFEAcA-mc6cLmRGdGNOBR0PC1f_VBjvTdAL6xYtKjApx3NoPgQ@mail.gmail.com>
 <86mufjrup7.wl-maz@kernel.org> <CAFEAcA9qkqkOTqSVrhTpt-NkZSNXomSBNiWo_D6Kr=QKYRRf=w@mail.gmail.com>
 <20190905092223.GC4320@e113682-lin.lund.arm.com> <4b6662bd-56e4-3c10-3b65-7c90828a22f9@kernel.org>
 <20190906080033.GF4320@e113682-lin.lund.arm.com> <a58c5f76-641a-8381-2cf3-e52d139c4236@amazon.com>
 <20190906131252.GG4320@e113682-lin.lund.arm.com> <CAFEAcA9vwyhAN8uO8=PpaBkBXb0Of4G0jEij7nMrYcnJjSRVjg@mail.gmail.com>
 <28c5c021-7cb0-616b-4215-dd75242c16e6@amazon.com>
In-Reply-To: <28c5c021-7cb0-616b-4215-dd75242c16e6@amazon.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Fri, 6 Sep 2019 14:50:34 +0100
Message-ID: <CAFEAcA8HH-JeMLZ29h6GidDcLpb_oUHqoyEMJ0buo3hyTBj5jA@mail.gmail.com>
Subject: Re: [PATCH 1/1] KVM: inject data abort if instruction cannot be decoded
To:     Alexander Graf <graf@amazon.com>
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        kvmarm@lists.cs.columbia.edu,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2019 at 14:41, Alexander Graf <graf@amazon.com> wrote:
> On 06.09.19 15:31, Peter Maydell wrote:
> > (b) we try to reuse the code we already have that does TCG exception
> > injection, which might or might not be a design mistake, and
>
> That's probably a design mistake, correct :)

Well, conceptually it's not necessarily a bad idea, because
in both cases what we're doing is "change the system register
state (PC, ESR_EL1, ELR_EL1 etc) so that the CPU looks like
it's just taken an exception"; but some of what the
TCG code needs to do isn't necessary for KVM and all of it
was not written with the idea of KVM in mind at all...

thanks
-- PMM
