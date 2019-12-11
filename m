Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054A3C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 23:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D079821556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 23:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ijN0BBii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfLKXax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 18:30:53 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44827 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfLKXaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 18:30:52 -0500
Received: by mail-oi1-f194.google.com with SMTP id d62so310109oia.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 15:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=u5EYBeY7DMUFDYGcRwf5OFQhhNuQnK3tgQ7xtLF/bL0=;
        b=ijN0BBiifrHOQUvBafavzPiAtfcjrHqSWNBtq7gCsmBw3lOMLU5xy2mEy+NAB2WCfZ
         QXMTvO+d2I6Tcn3VJk+x6SfqhAhnBHDF0hbU1WxTxKaOpnL+xUkp+jVe4Bvz+uoiHxH1
         auO0DvWjcmNwkom7gtlF7YZKxpBsil4zLgi+1bFXkDujDluhddarjR4cXvvLKBBq5W/j
         pB6KrFffB7ThG5i27LLkqbIzqGa04oovBm2zbwEOJR1eB4LFjCOD6hpRwf3+laE8R+eb
         AclMiFO+ekBDEy9Sarhe4JUZurtOoikzqnoJmc15XLfkfVRRvsumrut/YJ3t4O38ubix
         mmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=u5EYBeY7DMUFDYGcRwf5OFQhhNuQnK3tgQ7xtLF/bL0=;
        b=PVEKR4KZMNVffeiJ8gJOx5IKlnOjz3Kf5nbUyiyFUrVK7vZwl8ywfBD+v1cb0i1Bem
         N1FpprUtL1HBGdn96zX1dtXGEXMQ0HsEAO2ADCx/U4ofL3tO32VsVlpPQv0I9HW+oIzU
         gWKoEOu9VpKHhqyChlEwl95KJM4sjerjG4SVlxWrbA6caK1wGC9MBzmjzzi/+GMYKlnW
         dfgaDnohfXOEcH3Xz7U06fxyOCMbOct7RPb3Rmx92Whh9pwf3x93UOtrVHsNEYs6NxsB
         grG8Z4hZYkLy4KHHFC8sYkWHok4dI/XqhGTfIQnGk8V6v2e6hEeKtmRChh8Ml/MK5gXG
         VcGw==
X-Gm-Message-State: APjAAAXfjisFWB58rar00vrJ06V7nM6+Cwabkv/WuANNTNcqQi4fdijO
        y+s3ym2aw4iiDgTufwUyInD0C7LICTpfeWzjhmIyag==
X-Google-Smtp-Source: APXvYqyLZkYhBOvDF9PkIrrn7AL6acOwV56SY7wGTAM47hWUspRcfbKnDMcStIbXUHhF5Dvhm19L5lJjHK5XdwPeG34=
X-Received: by 2002:a05:6808:7da:: with SMTP id f26mr4285646oij.73.1576107051733;
 Wed, 11 Dec 2019 15:30:51 -0800 (PST)
MIME-Version: 1.0
References: <20191211231758.22263-1-jsnitsel@redhat.com> <20191211232612.miaizaxxikhlgvfj@cantor>
In-Reply-To: <20191211232612.miaizaxxikhlgvfj@cantor>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 Dec 2019 15:30:40 -0800
Message-ID: <CAPcyv4iwJoX6tVVBUc0dSwHUwsu2duoUFayOnAhDEd5SjYug8g@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis: reserve chip for duration of tpm_tis_core_init
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 3:27 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>
> On Wed Dec 11 19, Jerry Snitselaar wrote:
> >Instead of repeatedly calling tpm_chip_start/tpm_chip_stop when
> >issuing commands to the tpm during initialization, just reserve the
> >chip after wait_startup, and release it when we are ready to call
> >tpm_chip_register.
> >
> >Cc: Christian Bundy <christianbundy@fraction.io>
> >Cc: Dan Williams <dan.j.williams@intel.com>
> >Cc: Peter Huewe <peterhuewe@gmx.de>
> >Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >Cc: Jason Gunthorpe <jgg@ziepe.ca>
> >Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >Cc: stable@vger.kernel.org
> >Cc: linux-intergrity@vger.kernel.org
>
> Typo on the list address, do you want me to resend Jarkko?
>
> >Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
> >Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> >---
>
> I did some initial testing with both a 1.2 device and a 2.0 device here.
> Christian, can you verify that this still solves your timeouts problem
> you were seeing? Dan, can you try this on the internal system with
> the interrupt issues? I will see if I can get the t490s owner to run
> it as well.

Will do. I assume you'd also want to add 'Fixes: 5b359c7c4372
("tpm_tis_core: Turn on the TPM before probing IRQ's")' if it works?
