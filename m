Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C890EC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7AA21743
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OuTz5wvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731881AbfIEIRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 04:17:06 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46958 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730937AbfIEIRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 04:17:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id g19so1260252otg.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 01:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xPzSESc4AZSzOz8iuenGzI1AlT1OxyaOVK/bXB62NU=;
        b=OuTz5wvUQ35QYkpSKKPCxxQaaU1HK9r2e88MGLbbYqoqxReti2Duuk8kuS0KYSC1Ip
         pdHLMs7zhO419UJhHXlo+5eiLjxOlJzvBJvCkJ3krsKonpbm0VX4vie2pR8FyWB7NvC8
         xwNADNZ++jqxlZ73zV3Fv4RHQ1CtN/gCiJYwY6zC+I9oUFbUzixbhoF1ofdOq8nGsV/x
         zsdighpHoFIa+hFO9Gfuw4SI4cNG/br0SpICPLmLwP7JT0b8Rw1es+25pX61XTWttPNd
         pNvFwcXfQACkPtI8sYYB2mxINaHDTZiPwLrnEMjPnV1KdzshSBt/8xJLmUURA816hh65
         xaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xPzSESc4AZSzOz8iuenGzI1AlT1OxyaOVK/bXB62NU=;
        b=XDIm8UwLNyHxhlTc7uvTfWNWAkL11RxpARXh4f+miUc+NoPWc2ZoLfLqetz4uxJMJE
         dwz9KCBq07uWB0X6wUZwnqDFnApOD+9y/ccjqALCKsTm7lnhaPxkFv1d/V510w5Nexk3
         O/y/tmlswHx+4zgrjUf70iPhVgvzpxjuARXhNMBKYrEiepv7R2KCeOpYmbgrZVH3b0Nm
         ihTITPhwIPQPe0KYyVeLj5gkvFBEC4mWFDG5C00+yD20++aTnE5qQCtN87AqnSSro8zZ
         PddLlA2QDo/QfxXHMsBeF4MH/Eh5rvrrEs7H5xDlilDbQs7C6BFaDsPj9FfUWnAvYrNY
         F1CQ==
X-Gm-Message-State: APjAAAVm/QPJGb+UaL+NJVtpz0lEYqoYmVN/38GtRkr7gHBQNfDJOW2a
        i+5wlNp8GEcrQV3pM3/DLYSZvgsxuf2c10W2JQz/lg==
X-Google-Smtp-Source: APXvYqy24rjXe/FVSgFiU9SxJ4vZK2hJu//H06XcbxMiz2ueKtSmAR0GsP61bsSotW7CRw5je/6qibK/HvRFMTwLvZ0=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr1498113oti.135.1567671425605;
 Thu, 05 Sep 2019 01:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190904180736.29009-1-xypron.glpk@gmx.de> <86r24vrwyh.wl-maz@kernel.org>
In-Reply-To: <86r24vrwyh.wl-maz@kernel.org>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Thu, 5 Sep 2019 09:16:54 +0100
Message-ID: <CAFEAcA-mc6cLmRGdGNOBR0PC1f_VBjvTdAL6xYtKjApx3NoPgQ@mail.gmail.com>
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

On Thu, 5 Sep 2019 at 09:04, Marc Zyngier <maz@kernel.org> wrote:
> How can you tell that the access would fault? You have no idea at that
> stage (the kernel doesn't know about the MMIO ranges that userspace
> handles). All you know is that you're faced with a memory access that
> you cannot emulate in the kernel. Injecting a data abort at that stage
> is not something that the architecture allows.

To be fair, locking up the whole CPU (which is effectively
what the kvm_err/ENOSYS is going to do to the VM) isn't
something the architecture allows either :-)

> Of course, the best thing would be to actually fix the guest so that
> it doesn't use non-emulatable MMIO accesses. In general, that the sign
> of a bug in low-level accessors.

This is true, but the problem is that barfing out to userspace
makes it harder to debug the guest because it means that
the VM is immediately destroyed, whereas AIUI if we
inject some kind of exception then (assuming you're set up
to do kernel-debug via gdbstub) you can actually examine
the offending guest code with a debugger because at least
your VM is still around to inspect...

thanks
-- PMM
