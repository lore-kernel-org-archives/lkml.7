Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C64FC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248682133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VKNi1swU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfF1Fub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 01:50:31 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42058 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfF1Fua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 01:50:30 -0400
Received: by mail-lj1-f193.google.com with SMTP id t28so4701997lje.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 22:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbFBRaRExGspP5FBHqiodiH1th1SFCHyj3/EvKVMOx0=;
        b=VKNi1swUOq5lK8dq5fqpEDERV76IAnNdVZ5XZGkHh0446kzeu1AUrTBtfcWnqjwz7s
         CFLCv+VQfnCjIW21Uxjhk9kIItpOCpOBVaNjc4RN6PTb/zpOPrs2Jj7LcyAqecc21QRV
         2zT0yeebkvwCzjWi2Tq7+2u7CBR3i7VsePNdHChsH3C/xrJfBA9rwWPDAi8E7lXECpz8
         Q1nuzUYvZIvaVHYYNFAHG986q7tr+zKqYG229xXRcT4HSClajfzb3LUyrKnMstHdN24Y
         IWVk/TCCmQCNkoJVw/Yul28cipc8m3F/AL+0q4ind6UeYydAvf+v66mhP8+vCEXX70QX
         +NNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbFBRaRExGspP5FBHqiodiH1th1SFCHyj3/EvKVMOx0=;
        b=iIo/cB1qGdvETSSDkYaA3JVAQikJTMdNXQua87ACRjOojjG9Qt6OZLevinNG1rXDU4
         JXgQVBEz/mIGHara9JzWyKHA8Dddb9cHqlOaPhM8dv+uaPjwSLN/fpQYpPIaejsdNYPV
         zU9KPR74ckQKGX33nL9dcmB30b+CfWnS5Ejxli+K/loHR/mg3oAUt6yEGEZ4UX+HCFjm
         ZuBS7+wnOGeMTypVob84P0St3eeWy8L9VJz4EXZ+UYUECO9+K06XFsuK1/Fg9NbNvYSO
         vByV0t3DF0H+kiEDXHw0OWiqmsOtNJBXuK9NCY5bO4aFs0vGoqf3LwPzFeMYqFhkL0iq
         4R4A==
X-Gm-Message-State: APjAAAVwcXhRYP8ATd56Re8IQJZs03w/jzQIj6pQB70u3RpA4tcVKFPb
        RLx5sl9Sp6+PuTfj9XrM93EHL4ZEqmKn8U+nKclebw==
X-Google-Smtp-Source: APXvYqyEmJlYN3SMPXRrWfgX1NnF/P7C1CPVt4Z22T7CZtmDkBsqof9nh+eUEiF4lozTqMf3BR8KLe04tRokqvKZ1VQ=
X-Received: by 2002:a2e:4b12:: with SMTP id y18mr4842583lja.238.1561701027991;
 Thu, 27 Jun 2019 22:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190625201341.15865-1-sashal@kernel.org> <20190625201341.15865-2-sashal@kernel.org>
 <673dd30d03e8ed9825bb46ef21b2efef015f6f2a.camel@linux.intel.com>
 <20190626235653.GL7898@sasha-vm> <b688e845ccbe011c54b10043fbc3c0de8f0befc2.camel@linux.intel.com>
In-Reply-To: <b688e845ccbe011c54b10043fbc3c0de8f0befc2.camel@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 28 Jun 2019 11:20:16 +0530
Message-ID: <CAFA6WYM=YFec7rx6QSWtaZYeY8LrcjQ3bbMMtF0r6jbBaHX+Bw@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        Microsoft Linux Kernel List <linux-kernel@microsoft.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        "Bryan Kelly (CSI)" <bryankel@microsoft.com>,
        tee-dev@lists.linaro.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko and Sasha,

On Thu, 27 Jun 2019 at 18:47, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, 2019-06-26 at 19:56 -0400, Sasha Levin wrote:
> > > You've used so much on this so shouldn't this have that somewhat new
> > > co-developed-by tag? I'm also wondering can this work at all
> >
> > Honestly, I've just been massaging this patch more than "authoring" it.
> > If you feel strongly about it feel free to add a Co-authored patch with
> > my name, but in my mind this is just Thiru's work.
>
> This is just my subjective view but writing code is easier than making
> it work in the mainline in 99% of cases. If this patch was doing
> something revolutional, lets say a new outstanding scheduling algorithm,
> then I would think otherwise. It is not. You without question deserve
> both credit and also the blame (if this breaks everything) :-)
>
> > > process-wise if the original author of the patch is also the only tester
> > > of the patch?
> >
> > There's not much we can do about this... Linaro folks have tested this
> > without the fTPM firmware, so at the very least it won't explode for
> > everyone. If for some reason non-microsoft folks see issues then we can
> > submit patches on top to fix this, we're not just throwing this at you
> > and running away.
>
> So why any of those Linaro folks can't do it? I can add after tested-by
> tag parentheses something explaining that context of testing. It is
> reasonable given the circumstances.

Simply because the hardware I have (Developerbox) doesn't provide
enough flash space (as per current memory map) for this fTPM driver to
be loaded as early TA along with OP-TEE binary. So I can't get any
further point than sanity probe failure check for which I think a
tested-by won't be appropriate.

-Sumit

>
> I can also give an explanation in my next PR along the lines what you
> are saying. This would definitely work for me.
>
> /Jarkko
>
