Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B4CC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE822133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W7/HmZtA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfFNFhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 01:37:37 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:46364 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfFNFhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 01:37:37 -0400
Received: by mail-lj1-f178.google.com with SMTP id v24so1016114ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 22:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZNUHhspX/f3YOWEVEHKyyk596NYJqshHjg/vatkpxY=;
        b=W7/HmZtA2ueqgaDGdxDhZWvZWth1HioqPHWq3uv/ZfYeNDFiTuyQdPlIcFpcuu0z3o
         y6Uev4UXOG5e2S2Wthj/b5CuG5uoZNUQ41OGakG4dyH/tXfB2UroHg2Gx7hFqiJFMRhd
         gHQl567nnlSJFX9DFyvlw8RNWSWPh3lL/QzcclAHfQaZ7Hmb/dnSS3ruthZE4pMa5tAj
         qNEHjhma02SIf4fFrc/C/8hZTObaS9YJgPfGfLn6NshA2iWpqtI9/UJDjLUUosWLA3m2
         v6GAqT6YsvDPsMhcK6xY6KxkpITZc7duRiPE1DrBM6fXGlQ03o6X5Ga4vX7NpAEQzxLA
         ALsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZNUHhspX/f3YOWEVEHKyyk596NYJqshHjg/vatkpxY=;
        b=oGnMJ1LEwokmP6bKOBI6MJa68fV/8IbbjV0EYrTlHbkGXZ/BsdHIL660E+9wrfC1sb
         PePz6PclG2U9Tj4TJqgZ931n1EEr3ZOlKTyjsteBhI4aLelIT5nUjRzQtNiGP3qGLVU3
         YVTIUa6W2Y81Z4zL+XVHih3XrQjTlj+ybOLwUyQXGj4gBjXLddS6j/WP1+3t9WUtkpAN
         DKjxAL4YPlIq4+dPDJb2Evc1f7MLRsuHF48EYhtmHZmEWJheuPy8tum80s4O0C1JWh5j
         lp8Va17JI3LZ42y4lEhNsr6KQgy06X2qA8P47IXrVlStDPhiA3qy1bYmdaT3yYSA4g7K
         RlhA==
X-Gm-Message-State: APjAAAXLuXOm/2a2r4KtRibeHXw9CLWfXygsZ9+8Aa5I3tMnZhx+kStZ
        RzpdIw0b729j6aupniTDWzD4TcKRZ3xm8PCufc4Ccg==
X-Google-Smtp-Source: APXvYqyD8F4fw7/Bk2YoYfYuM4/Zn6eIcYSxGX5Muv3tuAEyNC1m3Hoxr0nrzGDdzQZYfXEpLZ8Y+RHbpI0YCi+CBR8=
X-Received: by 2002:a2e:63d9:: with SMTP id s86mr37708080lje.92.1560490655038;
 Thu, 13 Jun 2019 22:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
 <1560421833-27414-7-git-send-email-sumit.garg@linaro.org> <20190613153414.GG18488@linux.intel.com>
In-Reply-To: <20190613153414.GG18488@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 14 Jun 2019 11:07:23 +0530
Message-ID: <CAFA6WYP7qi_NBRUDBhcEAEzJY-iFvJdXqtCtgQxqAvPSXDjEng@mail.gmail.com>
Subject: Re: [RFC 6/7] doc: keys: Document usage of TEE based Trusted Keys
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>, corbet@lwn.net,
        dhowells@redhat.com, jejb@linux.ibm.com, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tee-dev@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019 at 21:04, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Jun 13, 2019 at 04:00:32PM +0530, Sumit Garg wrote:
> > Provide documentation for usage of TEE based Trusted Keys via existing
> > user-space "keyctl" utility. Also, document various use-cases.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> Sorry missed this patch. Anyway, I don't think we want multiple trusted
> keys subsystems. You have to fix the existing one if you care to get
> these changes in. There is no really other way around this.
>

I understand your point.

When I initially looked at trusted key implementation, it seemed to be
tightly coupled to use TPM device. So I implemented a parallel
implementation to get initial feedback (functionality-wise) on this
new approach.

I will work on abstraction of trusted key apis to use either approach.
But is it fine with you if I send if I send a separate RFC patch for
abstraction and later once reviewed I will incorporate that patch in
this patch-set.

It will be really helpful if you could help to test that abstraction
patch with a real TPM device as I doesn't posses one to test.

-Sumit

> /Jarkko
