Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E52C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267F1208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VnEIalSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389898AbfHHNVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:21:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45465 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389843AbfHHNVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:21:51 -0400
Received: by mail-lf1-f67.google.com with SMTP id a30so3772167lfk.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 06:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yPRSbt/ERroXQ3CLHiXg6WnTxTB+hRN/pv9SKNLhs4Y=;
        b=VnEIalSfu0SZj1Vm/7X2ReQgboUTXdytq3Ju8ZMCLD0t3tVftiaZQuk+TGh7D/LUAa
         gaJaZK+auUmyKPLOORwZmJFQiOa1ihPZgxLYmqTdU8rB/57WqFu9TtOa5uA20I7UgE+3
         hlphlO0UxK7JErrmwkGtDe4+fieeQpbxTcEr9701DA3NfDdfJaSMaDWW6uMdHChjnTxs
         c7obhEnph33x5gT/xTjbhUcev8i0z9IHueN7LM/Nj0+821pA2r/BLVCjqtKE7qdaOENC
         ts+fBmh/V6Fk09XKlbD70WrSjLEs1MNWTmkYJYa4UFM30KkQvAf/nYNhcMDAvtHbjAzX
         tcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yPRSbt/ERroXQ3CLHiXg6WnTxTB+hRN/pv9SKNLhs4Y=;
        b=sHX9PtVljFxVq6cTP4ZZyKJ4Rl0KSCOm2vFt3oi7x5z24E7CrXWu8puSAcd3q4fmuX
         16aoG0YD7R65g88xE8f2Ggq//Hef4HYXwtvuTB5tBjpQb717BMymsvq/en0xnR98GPNr
         1SVcfwlwEgPdhb81HwO7fRSt8BGuNyZdoQCWVsO6YQMYK68rWK0v+/0dw4pnbuSbssR/
         6oaOTo/EpgUr1R05BzZ1vAcRc/FOkZMv/TlULA2u/VBxT0UYwyb29AP5j21QsNZMZfhb
         lCMRppls8g4zXWCA2zVn28wCabZvKpsiO8zAMKbAOx6LMK8lBueRObyiUM7JURlcl4fd
         qgUQ==
X-Gm-Message-State: APjAAAXMH8ld3F+lMRwDbg1C/FxTGvdWDx3rA0Yoa4KQmQQrqNoVU6ms
        T9UfP0z1S2ZgKCuk0IEOcW48dAdzKWxFZR4OFxV4KQ==
X-Google-Smtp-Source: APXvYqw4VebWjEwpo3i9J0LRc5h0s+ynpfKok3QYD7qKC4/j06X+QGgIcDtFC+QCcnhYJmwAPh6zR54jEVVZOZgyJm8=
X-Received: by 2002:ac2:4901:: with SMTP id n1mr9552721lfi.0.1565270510135;
 Thu, 08 Aug 2019 06:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <1565098640-12536-1-git-send-email-sumit.garg@linaro.org>
 <1565098640-12536-3-git-send-email-sumit.garg@linaro.org> <20190807190320.th4sbnsnmwb7myzx@linux.intel.com>
In-Reply-To: <20190807190320.th4sbnsnmwb7myzx@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 8 Aug 2019 18:51:38 +0530
Message-ID: <CAFA6WYN-6MpP2TZQEz49BmjSQiMSqghVFWRZCCY0o1UVad1AFw@mail.gmail.com>
Subject: Re: [RFC/RFT v3 2/3] KEYS: trusted: move tpm2 trusted keys code
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019 at 00:33, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Aug 06, 2019 at 07:07:19PM +0530, Sumit Garg wrote:
> > Move TPM2 trusted keys code to trusted keys subsystem.
>
> Missing a long description. The reason is that it is better consolidate
> all trusted keys code to a single location so that it can be maintained
> sanely and it should be stated here.

Sure will extend the description.

>
> > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> I would suggest adding at least two commits before this:
>
> - A commit that just exports tpm_buf stuff and TPM2 constants to
>   include/linux

Okay, will create a separate patch for this.

> - A commit that just changes the existing TPM 1.x trusted keys
>   code to use tpm_buf.

It seems to be a functional change which I think requires proper unit
testing. I am afraid that I don't posses a TPM device to test this and
also very less conversant with tpm_buf code.

So what I have done here is to rename existing TPM 1.x trusted keys
code to use tpm1_buf.

And I would be happy to integrate a tested patch if anyone familiar
could work on this.

-Sumit

>
> These should be before the current 1/3 commit.
>
> /Jarkko
