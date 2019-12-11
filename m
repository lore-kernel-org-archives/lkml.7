Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51185C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 23:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27493214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 23:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzZxNYP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfLKXtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 18:49:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24083 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726989AbfLKXtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 18:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576108188;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=eZ6Qbamhyp6RLhy20TpwKVCBIKcGB4S+juUY4aaY00E=;
        b=RzZxNYP374suPIvn1VvvPJJvBXLnvXgLBHsO3TQMV4uJSFD+FnCrG158WKyEfTqTS71ktH
        tDRUKyotfb4yAjFmOFSmaGSpkbO+F1C8Nwmg8RPRJd+BNF6nEqKBiObUq7/WyPNkRcz3jT
        AYV5estexCTN1IlPuCiOZRp/BqRk+zk=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-_EbgTpBhNKW__YKbENIfnA-1; Wed, 11 Dec 2019 18:49:47 -0500
X-MC-Unique: _EbgTpBhNKW__YKbENIfnA-1
Received: by mail-yb1-f199.google.com with SMTP id e11so386592ybn.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 15:49:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=eZ6Qbamhyp6RLhy20TpwKVCBIKcGB4S+juUY4aaY00E=;
        b=B9M7//ZZzBovHtj1Vz+D2bi4xH/ysu8QCBHbWKP3FM4Da/T/AX80rgkbEEacppROKG
         Mb6a9DCaqKRQUiuXpsxoyh1SbKoO/WkGjtzLNnHMJv7XcKnev49ls+W20lrg5eVGG15g
         RT7EYHa+mGPAKsVL+EqQDGdvfPeGIqHvMksWc8mj3N9Yy9Sz+T35nol3P+5nZoT66gFT
         8nnwWCpc3CtjK5nMiKCIsszMGaOemoDA957rFaxbNgetLIpIXcQUaj3YxchlXnk+RiwZ
         IRqgzoXnyh9Hv14pfiN9HwwJ09o4wCOTxbReP3OsWNzl4EucVSrq8y/IH6dhqsoo69Gg
         ZGJA==
X-Gm-Message-State: APjAAAXCEUMYumK2oYllmkd30emiyBLC0wA767dMgZ/4tAxoTSFN5QLT
        MHlLhDDkMzZ4vu6cwf9QoboutYAKr3eXWw1owlAYTNkDl17/ASjmGdeZfZPWnySZqtO7i2x5mn9
        VQkSskw9HFHepHI6ZPMY3G8s4
X-Received: by 2002:a25:4192:: with SMTP id o140mr2186054yba.70.1576108187112;
        Wed, 11 Dec 2019 15:49:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqxLClP3vQPgqPh+Fd3ZVpB9+8LETd8k7MLAJik00X30raCPVWSm3eDeNxxwc6b60J3biJil5w==
X-Received: by 2002:a25:4192:: with SMTP id o140mr2186040yba.70.1576108186854;
        Wed, 11 Dec 2019 15:49:46 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id x184sm1816777ywg.4.2019.12.11.15.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 15:49:46 -0800 (PST)
Date:   Wed, 11 Dec 2019 16:49:29 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: reserve chip for duration of tpm_tis_core_init
Message-ID: <20191211234929.in7mrh3wq4pkhvsm@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>, linux-integrity@vger.kernel.org
References: <20191211231758.22263-1-jsnitsel@redhat.com>
 <20191211232612.miaizaxxikhlgvfj@cantor>
 <CAPcyv4iwJoX6tVVBUc0dSwHUwsu2duoUFayOnAhDEd5SjYug8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPcyv4iwJoX6tVVBUc0dSwHUwsu2duoUFayOnAhDEd5SjYug8g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Dec 11 19, Dan Williams wrote:
>On Wed, Dec 11, 2019 at 3:27 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>>
>> On Wed Dec 11 19, Jerry Snitselaar wrote:
>> >Instead of repeatedly calling tpm_chip_start/tpm_chip_stop when
>> >issuing commands to the tpm during initialization, just reserve the
>> >chip after wait_startup, and release it when we are ready to call
>> >tpm_chip_register.
>> >
>> >Cc: Christian Bundy <christianbundy@fraction.io>
>> >Cc: Dan Williams <dan.j.williams@intel.com>
>> >Cc: Peter Huewe <peterhuewe@gmx.de>
>> >Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> >Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> >Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> >Cc: stable@vger.kernel.org
>> >Cc: linux-intergrity@vger.kernel.org
>>
>> Typo on the list address, do you want me to resend Jarkko?
>>
>> >Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
>> >Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> >---
>>
>> I did some initial testing with both a 1.2 device and a 2.0 device here.
>> Christian, can you verify that this still solves your timeouts problem
>> you were seeing? Dan, can you try this on the internal system with
>> the interrupt issues? I will see if I can get the t490s owner to run
>> it as well.
>
>Will do. I assume you'd also want to add 'Fixes: 5b359c7c4372
>("tpm_tis_core: Turn on the TPM before probing IRQ's")' if it works?
>

Yes. I'm not certain this deals with the interrupt issue though, so
didn't want to stick it on there yet. I guess it should go on there
anyways since it is replacing that code. I'll post a v2.

