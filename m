Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF06C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7032082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554915714;
	bh=J4QhhoaGEgYso2GebNmi1v9FAxsbeQ9dqPKaFD6blFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1lbnfeD/8Pw6u/mXRDSSdVChvaiZNVuMKBoJ1goLTyWwdijau6ZQR5PFfr0PHW9PC
	 K0NcRTfVAglmHQkZQu5HjWskjBNguwZLsS89GjaQKc4EyOD7Fm0totjWtL8SwSpngJ
	 Mn31fN0fOc0iVzQL0p0wcZyL9S0sIkj5vo5PHV9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfDJRBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:01:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727464AbfDJRBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:01:50 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAB3E217F9;
        Wed, 10 Apr 2019 17:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554915709;
        bh=J4QhhoaGEgYso2GebNmi1v9FAxsbeQ9dqPKaFD6blFI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FPqOm8AZ2hf3cmPDnYuAeiBDcrOodV0nCwCyb+llFfEWGpmh/Xv9H8JkS5zPfi/rr
         BqApg+oMNgSnMQRI8FatjepBL9Z4nS0sDKSBe5OhqmAgVeXlVZgE6me9MntCAF6kEd
         dkG/VhijLi3UYqwENy1XNaf/OdKZd+QERBSId7B8=
Received: by mail-qk1-f172.google.com with SMTP id b74so1660720qkg.9;
        Wed, 10 Apr 2019 10:01:49 -0700 (PDT)
X-Gm-Message-State: APjAAAUL7A9o5VmhL5qp1Ssf41OkwzvL8lk487+K2fqyjCm3IFbovYr5
        cfI5tlUBnZ9b6byoY098lnlF75vH2U9wYcevpA==
X-Google-Smtp-Source: APXvYqzXKHUjKSDyeXvIrSfxRtyP25a+1csuoK7we+bjKSxGUokyXu96BN7r8FlAUUNUzWCpvozXm5+/Er2HMJpfebo=
X-Received: by 2002:ae9:e313:: with SMTP id v19mr32538761qkf.153.1554915708880;
 Wed, 10 Apr 2019 10:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190409184958.7476-1-sashal@kernel.org> <20190409184958.7476-2-sashal@kernel.org>
 <CAL_JsqLXcY9VFuY8xZvek0ybUXetS27jL-PW0XGLSVQR3Nc5aw@mail.gmail.com> <20190410161949.GC11568@sasha-vm>
In-Reply-To: <20190410161949.GC11568@sasha-vm>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 10 Apr 2019 12:01:37 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ0p8MsFe2HnqVHvdGyz=6P7dV++xj1d1TTgcobsFqpjg@mail.gmail.com>
Message-ID: <CAL_JsqJ0p8MsFe2HnqVHvdGyz=6P7dV++xj1d1TTgcobsFqpjg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ftpm: dt-binding: add dts documentation for fTPM driver
To:     Sasha Levin <sashal@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        jgg@ziepe.ca, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 11:19 AM Sasha Levin <sashal@kernel.org> wrote:
>
> On Tue, Apr 09, 2019 at 04:18:29PM -0500, Rob Herring wrote:
> >On Tue, Apr 9, 2019 at 1:50 PM Sasha Levin <sashal@kernel.org> wrote:
> >>
> >> The parameters are similar to the ones used by IBM's vTPM and the
> >> various I2C tpm drivers.
> >
> >Bindings describe h/w (or firmware interfaces in this case), not drivers.
> >
> >>
> >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> >> ---
> >>  .../bindings/security/tpm/tpm_ftpm_tee.txt          | 13 +++++++++++++
> >>  .../devicetree/bindings/vendor-prefixes.txt         |  1 +
> >>  2 files changed, 14 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt b/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
> >> new file mode 100644
> >> index 000000000000..20fca67a56c4
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
> >> @@ -0,0 +1,13 @@
> >> +Required properties:
> >> +- compatible: should be "microsoft,ftpm"
> >> +- linux,sml-base: 64-bit base address of the reserved memory allocated
> >> +                 for the firmware event log
> >> +- linux,sml-size: size of the memory allocated for the firmware event log
> >
> >Firmware is defining linux specific properties? What if I want to run
> >BSD? We should use 'reg' here instead.
>
> This is based on already existing code that defines these names, see
> tpm_read_log_of() in drivers/char/tpm/eventlog/of.c .

BTW, that probably needs updating to handle endianness correctly.

> These properties were described similarily by other interfaces (see
> Documentation/devicetree/bindings/security/tpm/ibmvtpm.txt or
> Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt for example).
>
> We could rename them all if you'd like, I was just trying to follow the
> existing code.
>
> >What memory is used here? This should be under /reserved-memory if it
> >is part of "main" memory.
>
> That's my understanding, yes.
>
> >Really, I'd prefer to not see this in DT at all. Make the firmware
> >discoverable. Why repeat the mistakes of non-discoverable h/w in s/w
> >interfaces? OP-Tee at least has defined a mechanism to enumerate TEE
> >functions IIRC.
>
> Sadly the firmware already exists as-is on live hardware, there is a
> paper describing it back from 2016 and we're stuck having to support
> that.

Does the firmware depend on this binding or the DT just gets
statically populated with the address/size the firmware hardcodes? I'd
prefer not to propagate the IBM binding that we were kind of stuck
with. I had similar comments on it...

Are there other parts of the TEE firmware that need to be described in DT?

Rob
