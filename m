Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC14DC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 17:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898B124655
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 17:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YsJ6ggd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfLQR0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 12:26:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27575 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726191AbfLQR0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 12:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576603577;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=JhGEPIjSsI2VSpuvPhPcFvkVbdN2zCk8clg6xw3MloI=;
        b=YsJ6ggd/G37Hs/5LHmSDyW9ylj1154vuQIHJHVW5Hxta1Pq0XKJlwlWWHJboXlpxuXZX2b
        7X8l/S0tt8nTu7Fq0eUqpMOCraJ6fIRu0Bk+mKQctqbkP8jkiZmsdca9DzB7wr84AC6Muy
        zS3Ae0oUMKXVw1HDY1WF/Stq6x8UYi8=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-Oq7Kuw0oPQuNh5lwesdZhQ-1; Tue, 17 Dec 2019 12:26:16 -0500
X-MC-Unique: Oq7Kuw0oPQuNh5lwesdZhQ-1
Received: by mail-yb1-f200.google.com with SMTP id y127so9649408yba.19
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 09:26:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=JhGEPIjSsI2VSpuvPhPcFvkVbdN2zCk8clg6xw3MloI=;
        b=uTbFqn28vI8lXYrQ9EHdE2oinIlJMOr2wSqvoZit09XGRSouyX7pXq46QQDQ6W868R
         efHZ4UNdR7h7l7mwFgzvDBQV8yyEo9k97VXEYJLO2DAoymYJVlBPuAv3Xf8sbc6OkFN3
         Ks5ZoClUilAl2nYHXaNaEqGP7hQpQeDJgxB0vVWyXlozexXUYLLUs0C+Le5W6xYXXyb+
         tMVSe6MS76Gw0GH2u8unxAiClbvKoyfQM5IZPT4Df2Ab76mifjEXpQX7E1lmwzxyesfe
         sF+IXiWAq1IxeL2qFGaWNstxqKM2by/RD5g3fqD6mhexSoK+7W9jz5UH1NSrIkSMJ5C5
         WW5g==
X-Gm-Message-State: APjAAAVFe4smC34q21Tgxet7VwqQFmY8pQYvrRI6QDXSpckNp0qpeKxY
        0JgKy6oGf8gCDjMN6wGrVsGpjWUCkpo2kS52//J56MMMzBmfvPBPkK/YPmsOfD/Zc7EHaEGHNkk
        TsOuOHPo5osbzS78rni1xJu/m
X-Received: by 2002:a25:f0a:: with SMTP id 10mr25608043ybp.196.1576603574469;
        Tue, 17 Dec 2019 09:26:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqwDmC7V5LtArkYd5Wktr23Ul1nvyduPiQFSdqQohnh+fkE7SYSce96fOw7HJjezxJt0EkZh4A==
X-Received: by 2002:a25:f0a:: with SMTP id 10mr25608021ybp.196.1576603574213;
        Tue, 17 Dec 2019 09:26:14 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id k133sm9930453ywc.9.2019.12.17.09.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 09:26:13 -0800 (PST)
Date:   Tue, 17 Dec 2019 10:26:12 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm_tis: reserve chip for duration of
 tpm_tis_core_init
Message-ID: <20191217172612.5hxyt7w3wtbrkypm@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>, linux-integrity@vger.kernel.org
References: <20191211231758.22263-1-jsnitsel@redhat.com>
 <20191211235455.24424-1-jsnitsel@redhat.com>
 <5aef0fbe28ed23b963c53d61445b0bac6f108642.camel@linux.intel.com>
 <CAPcyv4h60z889bfbiwvVhsj6MxmOPiPY8ZuPB_skxkZx-N+OGw@mail.gmail.com>
 <20191217020022.knh7uxt4pn77wk5m@cantor>
 <CAPcyv4iepQup4bwMuWzq6r5gdx83hgYckUWFF7yF=rszjz3dtQ@mail.gmail.com>
 <5d0763334def7d7ae1e7cf931ef9b14184dce238.camel@linux.intel.com>
 <20191217171844.huqlj5csr262zkkk@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191217171844.huqlj5csr262zkkk@cantor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Dec 17 19, Jerry Snitselaar wrote:
>On Tue Dec 17 19, Jarkko Sakkinen wrote:
>>On Mon, 2019-12-16 at 18:14 -0800, Dan Williams wrote:
>>>On Mon, Dec 16, 2019 at 6:00 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>>>> On Mon Dec 16 19, Dan Williams wrote:
>>>> > On Mon, Dec 16, 2019 at 4:59 PM Jarkko Sakkinen
>>>> > <jarkko.sakkinen@linux.intel.com> wrote:
>>>> > > On Wed, 2019-12-11 at 16:54 -0700, Jerry Snitselaar wrote:
>>>> > > > Instead of repeatedly calling tpm_chip_start/tpm_chip_stop when
>>>> > > > issuing commands to the tpm during initialization, just reserve the
>>>> > > > chip after wait_startup, and release it when we are ready to call
>>>> > > > tpm_chip_register.
>>>> > > >
>>>> > > > Cc: Christian Bundy <christianbundy@fraction.io>
>>>> > > > Cc: Dan Williams <dan.j.williams@intel.com>
>>>> > > > Cc: Peter Huewe <peterhuewe@gmx.de>
>>>> > > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>> > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
>>>> > > > Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>>> > > > Cc: stable@vger.kernel.org
>>>> > > > Cc: linux-integrity@vger.kernel.org
>>>> > > > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
>>>> > > > Fixes: 5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing IRQ's")
>>>> > > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>>>> > >
>>>> > > I pushed to my master with minor tweaks and added my tags.
>>>> > >
>>>> > > Please check before I put it to linux-next.
>>>> >
>>>> > I don't see it yet here:
>>>> >
>>>> > http://git.infradead.org/users/jjs/linux-tpmdd.git/shortlog/refs/heads/master
>>>> >
>>>> > However, I wanted to make sure you captured that this does *not* fix
>>>> > the interrupt issue. I.e. make sure you remove the "Fixes:
>>>> > 5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing IRQ's")"
>>>> > tag.
>>>> >
>>>> > With that said, are you going to include the revert of:
>>>> >
>>>> > 1ea32c83c699 tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts
>>>>
>>>> Dan, with the above reverted do you still get the screaming interrupt?
>>>
>>>Yes, the screaming interrupt goes away, although it is replaced by
>>>these messages when the driver starts:
>>>
>>>[    3.725131] tpm_tis IFX0740:00: 2.0 TPM (device-id 0x1B, rev-id 16)
>>>[    3.725358] tpm tpm0: tpm_try_transmit: send(): error -5
>>>[    3.725359] tpm tpm0: [Firmware Bug]: TPM interrupt not working,
>>>polling instead
>>>
>>>If the choice is "error message + polled-mode" vs "pinning a cpu with
>>>interrupts" I'd accept the former, but wanted Jarkko with his
>>>maintainer hat to weigh in.
>>>
>>>Is there a simple sanity check I can run to see if the TPM is still
>>>operational in this state?
>>
>>What about T490S?
>>
>>/Jarkko
>>
>
>Hi Jarkko, I'm waiting to hear back from the t490s user, but I imagine
>it still has the problem as well.
>

It appears he is out of the office until January, so I doubt I will hear
anything back until then.

>Christian, were you able to try this patch and verify it still
>resolves the issue you were having with the kernel failing to get the
>timeouts and durations from the tpm?
>
>Thanks,
>Jerry

