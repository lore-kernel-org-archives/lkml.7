Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CA1C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6857521882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rs/P10EO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfGCIMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:12:41 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44810 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfGCIMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:12:40 -0400
Received: by mail-qk1-f196.google.com with SMTP id p144so1456832qke.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 01:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VjBFB/I0hlVew0sJZr7FphhS/ICkUfwzYUwEfGp+X9c=;
        b=rs/P10EOeN8DyI/Wg/AZ1DlAhfVcgzzCalE9Vh9lVZ9iYbq7Jsh26+b068r1jTkYCu
         9UM4aBR/8k/ZdDSMTmqUSSzooi/EJE6wcazITngYUVSrL+E7enwrQrSeCoMUKk1ixN+W
         K9ve+Y/ZUGvYAEM4zp4tm3cwzm6BqzE9dqolkYjEUuNR0cEYY5iU5KBU9LCNeY5BWzMZ
         hMF6PMR4U0+umNvC2E2/l6dDz92QxUN92vu6HnRT/AwAXCUmnCqs8lJnCxTrIhMdt4j0
         BfcqgN8ddIaqNA27/dpccsu2frGQrqjCw2fA977jir5UmHgjgr3hksh7O+zUG+nh7bOb
         FB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VjBFB/I0hlVew0sJZr7FphhS/ICkUfwzYUwEfGp+X9c=;
        b=PkkVOp9s831oz9HALlK5v0+AKIodaF/7gpSmXJSniTrlY2GUqseR9pOTxWRpSsqe3c
         823gtn/0c/DRx80YCoBSgtSbAfKX0TG2kKIvzbcesL8rlqRnSRkO8ONJS1z+xFXwbmRw
         +F8tWQYyZcJeU/NmFzlLJGoOo8hcUBS0hi5vMJ94e+BeN4QaTy0txjknjqqxSaimI3j1
         zQrOz8rIZAQLQVi9c2WGO5C4ksEIT5kkc5jB9BgDdJOtBmd49Xv5O+0+jaXY3oBtFQ5A
         Q+4T8Cg+eF2WWwuJYAd8v8GZvWY/bdimB7kotHOkiriFPr6XMoiH6NZthF3MXe8cmGEl
         kipg==
X-Gm-Message-State: APjAAAUK/Jq7Oo8ZODGvFrL6YxVroCWusi2qGL2sAjGO3TFqHCuw9IoK
        5vnXV7PlrqoQ7JyWtWeTMGOl89gZjWdqeonuqnfpwg==
X-Google-Smtp-Source: APXvYqzr8OCEiyef/ZkNtjl0SMgfPQYC1bswQpc5cBXmeylB8iVLKdFWMazq+fnPQ8raPNXy/tyZlYwpeBtzgp463F8=
X-Received: by 2002:a67:fd91:: with SMTP id k17mr18291390vsq.121.1562141559483;
 Wed, 03 Jul 2019 01:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190625201341.15865-1-sashal@kernel.org> <20190625201341.15865-2-sashal@kernel.org>
 <673dd30d03e8ed9825bb46ef21b2efef015f6f2a.camel@linux.intel.com>
 <20190626235653.GL7898@sasha-vm> <b688e845ccbe011c54b10043fbc3c0de8f0befc2.camel@linux.intel.com>
 <20190627133004.GA3757@apalos> <0893dc429d4c3f3b52d423f9e61c08a5012a7519.camel@linux.intel.com>
 <20190702142109.GA32069@apalos> <CY4PR21MB0279B99FB0097309ADE83809BCF80@CY4PR21MB0279.namprd21.prod.outlook.com>
 <20190703065813.GA12724@apalos>
In-Reply-To: <20190703065813.GA12724@apalos>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Wed, 3 Jul 2019 11:12:28 +0300
Message-ID: <CAC_iWjK2F13QxjuvqzqNLx00SiGz_FQ5X=MQxJyDev57bo3=LQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
To:     Thirupathaiah Annapureddy <thiruan@microsoft.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Microsoft Linux Kernel List <linux-kernel@microsoft.com>,
        "Bryan Kelly (CSI)" <bryankel@microsoft.com>,
        "tee-dev@lists.linaro.org" <tee-dev@lists.linaro.org>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        Joakim Bech <joakim.bech@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thirupathaiah,

(+Joakim)

On Wed, 3 Jul 2019 at 09:58, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Thirupathaiah,
> >
> > First of all, Thanks a lot for trying to test the driver.
> >
> np
>
> [...]
> > > I managed to do some quick testing in QEMU.
> > > Everything works fine when i build this as a module (using IBM's TPM 2.0
> > > TSS)
> > >
> > > - As module
> > > # insmod /lib/modules/5.2.0-rc1/kernel/drivers/char/tpm/tpm_ftpm_tee.ko
> > > # getrandom -by 8
> > > randomBytes length 8
> > > 23 b9 3d c3 90 13 d9 6b
> > >
> > > - Built-in
> > > # dmesg | grep optee
> > > ftpm-tee firmware:optee: ftpm_tee_probe:tee_client_open_session failed,
> > > err=ffff0008
> > This (0xffff0008) translates to TEE_ERROR_ITEM_NOT_FOUND.
> >
> > Where is fTPM TA located in the your test setup?
> > Is it stitched into TEE binary as an EARLY_TA or
> > Is it expected to be loaded during run-time with the help of user mode OP-TEE supplicant?
> >
> > My guess is that you are trying to load fTPM TA through user mode OP-TEE supplicant.
> > Can you confirm?
> I tried both
>

Ok apparently there was a failure with my built-in binary which i
didn't notice. I did a full rebuilt and checked the elf this time :)

Built as an earlyTA my error now is:
ftpm-tee firmware:optee: ftpm_tee_probe:tee_client_open_session
failed, err=ffff3024 (translates to TEE_ERROR_TARGET_DEAD)
Since you tested it on real hardware i guess you tried both
module/built-in. Which TEE version are you using?

Thanks
/Ilias
