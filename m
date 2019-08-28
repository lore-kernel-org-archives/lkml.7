Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E060FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 05:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85622173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 05:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JxQ/DhDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfH1F2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 01:28:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44701 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfH1F2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 01:28:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id e24so1339454ljg.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 22:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wuD+47oBthIHQumcqd0YN679T72WGLTDD4hOsKbpLxE=;
        b=JxQ/DhDP05PNcJhHPHt2GrZ/B8VfZ53oE6THwxTahk32Tsn0TFdadeMPol+lFd4P1A
         ZSNr/mSN4jHxlMDbHl9zDZxG22Ec4vfh7ClgirOkCZvTjA6NTfc7GF6QpnMJoq3yf1Tf
         jZJPmiBUgmxrpi3fZHzpuAAhDEbJIGpkDmyqW77n0f4dC+Kdoog+2dPGysHFHolJFQYJ
         dKWrRA+dbT0VHyb3+C39xtvli41mc53RQaVl4B3RnrOVhuH3KUKlLJ1X9oNXIVZroUOV
         ysRIXcz2GlsRxWYVmoX0DOS+xB7rY3Uuf0nRqv9lrREvMrwVG+NiTKs3C3JiDAFCeUsa
         253w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wuD+47oBthIHQumcqd0YN679T72WGLTDD4hOsKbpLxE=;
        b=A+YF+OXS5CTkpfAnGeqI5g2k3KkiJ43OpOFGVC82OCNmpyuBEWN5xVGVB0ArPvc4tE
         AF2wpDkyyUckY1kkJtOQAYDsOXr10hQtL2pFZ+YrzsRu6+y7bojfKcWL7ZCteeHeCWJi
         zvwyocnxcUpEi5YnbGPnNIePQ5SxBwUqZ8YWQdE2YxBIHkuWA1hvZ9ageOvy778/pys7
         ag4r9RdVIuejAnOEZ9rLbHcuz50l+uVC5ZfsgjA/sJf6psjxOyUtlLweM7mx4eQ+XO6o
         06jFadwE0cW3W3E2vf8zz6ScsSyEZAp1o+AJkP66Pc+YrEj9JzI6yoGwu3XJ4sso71bN
         PQVg==
X-Gm-Message-State: APjAAAVo+g+JCQ0kgRuZa/YXLxK8zT94b5Jw4w52a/yAbwKGEqLh5Ov0
        zdmYDPbXnKxFwSDntyVcGQII0Urt3LAdw6+zI1w+4A==
X-Google-Smtp-Source: APXvYqzP6WVBc3SIpSbwvH+PA6Ta0a7UKTqmsXsZbvFWOoRZR8d2RevgeN/WfpPSOG2xP4CPkCq1nfyajuFEu/pawkk=
X-Received: by 2002:a2e:819:: with SMTP id 25mr987414lji.142.1566970102465;
 Tue, 27 Aug 2019 22:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <1566392345-15419-1-git-send-email-sumit.garg@linaro.org>
 <1566392345-15419-5-git-send-email-sumit.garg@linaro.org> <20190827141742.6qxowsigqolxaod4@linux.intel.com>
In-Reply-To: <20190827141742.6qxowsigqolxaod4@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 28 Aug 2019 10:58:11 +0530
Message-ID: <CAFA6WYPnoDoMWd=PT4mgXPhg1Wp0=AFDnWd_44UMP7sijXzAZA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] KEYS: trusted: move tpm2 trusted keys code
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

On Tue, 27 Aug 2019 at 19:47, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Aug 21, 2019 at 06:29:05PM +0530, Sumit Garg wrote:
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2004 IBM Corporation
> > + * Copyright (C) 2014 Intel Corporation
>
> Everything below can be dropped from this new file. Git has the most
> accurate authority information.
>
> I'm not sure why I added the authors-list in the first place to the
> header when I implemented these functions as none of those folks have
> contributed to this particular piece of work.
>
> > + * Authors:
> > + * Leendert van Doorn <leendert@watson.ibm.com>
> > + * Dave Safford <safford@watson.ibm.com>
> > + * Reiner Sailer <sailer@watson.ibm.com>
> > + * Kylene Hall <kjhall@us.ibm.com>
> > + *
> > + * Maintained by: <tpmdd-devel@lists.sourceforge.net>
> > + *
> > + * Trusted Keys code for TCG/TCPA TPM2 (trusted platform module).
> > + */
>
> To summarize, I think this would be sufficient:
>
> // SPDX-License-Identifier: GPL-2.0-only
> /*
>  * Copyright (C) 2004 IBM Corporation
>  * Copyright (C) 2014 Intel Corporation
>  */

Sounds good to me.

>
> I think there should never be such a rush that acronym could not be
> written with the correct spelling. I'm referring to 'tpm2' in the short
> summary.

So you mean to say we should use upper-case letters for 'TPM2' acronym?

> I'm sorry, I had to say it, just can't help myself with those
> kind of details :-) I can take care of fixing those once I apply these
> patches.
>
> You've done an awesome job. Thank you.
>

You are welcome.

> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>

Thanks for your review.

-Sumit

> Unfortunately I'm not yet sure if I have time to test these before going
> to Linux Plumbers but these would be anyway too close to the next merge
> window to be added to the v5.4 PR.
>
> /Jarkko
