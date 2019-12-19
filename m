Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB2BC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90AD24650
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTho/DVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfLSKIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:08:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56753 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726759AbfLSKII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576750087;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=l5IEbrYkGbA+uzv9F0SWz6YFiqb5Twn8DMBOAdSn76Y=;
        b=KTho/DViCc5AWl1AGQcI7ufSxZF4Ava155m0ykf6ynt5nHq2ddW+w/eHdRgySS0AWNjlv2
        4c6pFwhf8IvCwY15Fo8+4oN2/MICbPfCDq8oYovJmkQEcnVtrl6WuPrPD3jsYSHI29B+aK
        abFfNk77+TA5+UBT0pTdXa1bvOmwgN0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-LYut9MbhNLSAp9WcIvklOg-1; Thu, 19 Dec 2019 05:07:55 -0500
X-MC-Unique: LYut9MbhNLSAp9WcIvklOg-1
Received: by mail-qk1-f199.google.com with SMTP id a6so639565qkl.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 02:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=l5IEbrYkGbA+uzv9F0SWz6YFiqb5Twn8DMBOAdSn76Y=;
        b=hdOwNMqJvV1rClDXC2darqftIS10a6ETJd7uX6p94cCclOzBaAw33KNjadAex8lMQA
         +FII1G1wjFtNxDfTRP562aWgLFABYe8sflfT2ZKLl4fey+qQygMRGkhsArgR9x+0H/yf
         aqQZu+tWOERgQWVr8u8mI7Ngt6ictiSbwGxMyStyjEo8V9Pmwchjqqm8W5itHiIADzdh
         xmGCbqQ1aOkrPcRbk8FHkC9vO/SpXVIHtkAlg+UA5+2Ur+mBG9Az9+JRixJKCun1mF74
         qaryuC7rj7VwtYSUR1PIyfx5ZB3ByGbYHudcK98IZzOY5B68DLLuRfI91kQngqPU2Erw
         buyA==
X-Gm-Message-State: APjAAAVkwBCPFiKfIPqFh2PBxtcTGhRGwzpTAqNREKEEAlxnISnA+xvt
        fYwM0gKYyHOjUK70GHpKkoh1nDGsFxyfyzSAKKR+P7qNwSbeoUElH6soBDKuGD2/4D71woezvH/
        95C6HW/nHNSxP2HzOZ+AqbHtC
X-Received: by 2002:a05:6214:1150:: with SMTP id b16mr6773874qvt.71.1576750075526;
        Thu, 19 Dec 2019 02:07:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqzGQHlbLu28ChVwBf+PQOYB9WLnMKuof8pJdCAO3zkW4CCjNgvuJfhbmqigII0eHNeYPs9//A==
X-Received: by 2002:a05:6214:1150:: with SMTP id b16mr6773857qvt.71.1576750075235;
        Thu, 19 Dec 2019 02:07:55 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id w21sm1769397qth.17.2019.12.19.02.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 02:07:54 -0800 (PST)
Date:   Thu, 19 Dec 2019 03:07:47 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm_tis: reserve chip for duration of
 tpm_tis_core_init
Message-ID: <20191219100747.fhbqmzk7xby3tt3l@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Dan Williams <dan.j.williams@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
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
 <37f4ed0d6145dbe1e8724a5d05d0da82b593bf9c.camel@linux.intel.com>
 <CAPcyv4h8sK+geVvBb1534V9CgdvOnkpPeStV3B8Q1Qdve3is0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPcyv4h8sK+geVvBb1534V9CgdvOnkpPeStV3B8Q1Qdve3is0A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Dec 18 19, Dan Williams wrote:
>On Wed, Dec 18, 2019 at 3:07 PM Jarkko Sakkinen
><jarkko.sakkinen@linux.intel.com> wrote:
>>
>> On Tue, 2019-12-17 at 10:18 -0700, Jerry Snitselaar wrote:
>> > On Tue Dec 17 19, Jarkko Sakkinen wrote:
>> > > On Mon, 2019-12-16 at 18:14 -0800, Dan Williams wrote:
>> > > > On Mon, Dec 16, 2019 at 6:00 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>> > > > > On Mon Dec 16 19, Dan Williams wrote:
>> > > > > > On Mon, Dec 16, 2019 at 4:59 PM Jarkko Sakkinen
>> > > > > > <jarkko.sakkinen@linux.intel.com> wrote:
>> > > > > > > On Wed, 2019-12-11 at 16:54 -0700, Jerry Snitselaar wrote:
>> > > > > > > > Instead of repeatedly calling tpm_chip_start/tpm_chip_stop when
>> > > > > > > > issuing commands to the tpm during initialization, just reserve the
>> > > > > > > > chip after wait_startup, and release it when we are ready to call
>> > > > > > > > tpm_chip_register.
>> > > > > > > >
>> > > > > > > > Cc: Christian Bundy <christianbundy@fraction.io>
>> > > > > > > > Cc: Dan Williams <dan.j.williams@intel.com>
>> > > > > > > > Cc: Peter Huewe <peterhuewe@gmx.de>
>> > > > > > > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> > > > > > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> > > > > > > > Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> > > > > > > > Cc: stable@vger.kernel.org
>> > > > > > > > Cc: linux-integrity@vger.kernel.org
>> > > > > > > > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
>> > > > > > > > Fixes: 5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing IRQ's")
>> > > > > > > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> > > > > > >
>> > > > > > > I pushed to my master with minor tweaks and added my tags.
>> > > > > > >
>> > > > > > > Please check before I put it to linux-next.
>> > > > > >
>> > > > > > I don't see it yet here:
>> > > > > >
>> > > > > > http://git.infradead.org/users/jjs/linux-tpmdd.git/shortlog/refs/heads/master
>> > > > > >
>> > > > > > However, I wanted to make sure you captured that this does *not* fix
>> > > > > > the interrupt issue. I.e. make sure you remove the "Fixes:
>> > > > > > 5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing IRQ's")"
>> > > > > > tag.
>> > > > > >
>> > > > > > With that said, are you going to include the revert of:
>> > > > > >
>> > > > > > 1ea32c83c699 tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts
>> > > > >
>> > > > > Dan, with the above reverted do you still get the screaming interrupt?
>> > > >
>> > > > Yes, the screaming interrupt goes away, although it is replaced by
>> > > > these messages when the driver starts:
>> > > >
>> > > > [    3.725131] tpm_tis IFX0740:00: 2.0 TPM (device-id 0x1B, rev-id 16)
>> > > > [    3.725358] tpm tpm0: tpm_try_transmit: send(): error -5
>> > > > [    3.725359] tpm tpm0: [Firmware Bug]: TPM interrupt not working,
>> > > > polling instead
>> > > >
>> > > > If the choice is "error message + polled-mode" vs "pinning a cpu with
>> > > > interrupts" I'd accept the former, but wanted Jarkko with his
>> > > > maintainer hat to weigh in.
>> > > >
>> > > > Is there a simple sanity check I can run to see if the TPM is still
>> > > > operational in this state?
>> > >
>> > > What about T490S?
>> > >
>> > > /Jarkko
>> > >
>> >
>> > Hi Jarkko, I'm waiting to hear back from the t490s user, but I imagine
>> > it still has the problem as well.
>> >
>> > Christian, were you able to try this patch and verify it still
>> > resolves the issue you were having with the kernel failing to get the
>> > timeouts and durations from the tpm?
>>
>> Including those reverts would be a bogus change at this point.
>
>I'm failing to see how you arrived at that conclusion.
>
>> The fix that I already applied obviously fixes an issue even if
>> it does not fix all the issues.
>
>These patches take a usable system and make it unusable:
>
>1ea32c83c699 tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts
>5b359c7c4372 tpm_tis_core: Turn on the TPM before probing IRQ's
>
>...they need to be reverted, or the regression needs to be fixed, but
>asserting that you fixed something else unrelated does not help.
>

Reverting 1ea32c83c699 ("tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before
probing for interrupts") would at least allow people impacted by this
to boot their systems without disabling the tpm, or blacklisting the
module while we figure this out. From what I can tell the tpm_tis code
was operating in that state since 570a36097f30 ("tpm: drop 'irq' from
struct tpm_vendor_specific") until Stefan's patch.

Regards,
Jerry

