Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2568ECA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A1121734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ADFX2EB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfKAJec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 05:34:32 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40508 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbfKAJeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 05:34:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id f4so6783369lfk.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 02:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P2Wy+d6SJv+zW1h7gwcrJ9wMcc9z6tW4Pf7OV3vuzIM=;
        b=ADFX2EB5FnE/sL/t/2Vc3e3rF5fsiteBk+A1NMThui6yAi2ffh/Vfsjgbu7Q64wo//
         /ZbliqCo0dGLps5HIDxXXgS8YTSVHRxr64v7UdeaW8Qf2v3MIf0SEitoyEbRpK2+uOHa
         En0OqRHTtilLbQCkItdwdeHtmcVVfvRLXG8YLPaMGFGYo5ZxaMRtIYSxsXu8XGBcfHj1
         iSZwCHcfn4tEC5oOdZQn9ZMJXSZyTqUzXYwSX0L+ebBJ/jMT/clmdue5MBGMan58F22M
         7JtxmPGOYoJQ4ykrVOkiawCvP5XGhfk2BeCjFy/fju8i27uwEYR8I/i/6a1uJhu82shX
         zzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P2Wy+d6SJv+zW1h7gwcrJ9wMcc9z6tW4Pf7OV3vuzIM=;
        b=lAXBl/tB5VJrrcp4Xvsaw+8A4sbCPXP9ouP6QOgR2dV+/VmEF1X/lHVSG4cDNfC9r5
         SAqKJF1YsJph0A1gobupAtI6dS3f/dpUqnHGMh43ztKbqg4lcWbjCvLk9CR9b8byPhLR
         6KkQeJyQDoWA/DV/UpAj4XwFmVbWGD5qOvdEajMzJHOhdJpvj1J7TjDWYfG0V8iDJe/K
         Mek6HCIApdwEWVeQOfpXvz0QCgW5ivRrSBVSGfn8979vHj2SWUpb0hS8JQLVHx04rRH2
         2YddRBUyilhqJR7jhJkP7f23QL+iKVN49ETn/15g/a9vfshk7wlgRoipVD5qhN8si39k
         Zysw==
X-Gm-Message-State: APjAAAUL0n64MJPzrs4XUHQWggW7BrRkYGfqjExsW+r7ryXOC8Z9iX/+
        GwaGvF4sEoKL8SRy9Q1S6YzfR+v2BO4iJDec4zR+vw==
X-Google-Smtp-Source: APXvYqykFl40jxMDQlJMBgGfbD2FRHdfPvjdr0aHRQNEMjEwkimo+7UrmZo1Gp8KiXJ6RvnSoNWXnAaB8dvQSi7cRbs=
X-Received: by 2002:a05:6512:409:: with SMTP id u9mr6753625lfk.0.1572600869571;
 Fri, 01 Nov 2019 02:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <1572530323-14802-1-git-send-email-sumit.garg@linaro.org>
 <1572530323-14802-7-git-send-email-sumit.garg@linaro.org> <20191031214745.GG10507@linux.intel.com>
In-Reply-To: <20191031214745.GG10507@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 1 Nov 2019 15:04:18 +0530
Message-ID: <CAFA6WYMkE928v-v76gGtWmsS0PwRp-OHUtkS0+Ts4V6x0AKBqQ@mail.gmail.com>
Subject: Re: [Patch v3 6/7] doc: keys: Document usage of TEE based Trusted Keys
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>, dhowells@redhat.com,
        Jonathan Corbet <corbet@lwn.net>, jejb@linux.ibm.com,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Stuart Yoder <stuart.yoder@arm.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2019 at 03:17, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Oct 31, 2019 at 07:28:42PM +0530, Sumit Garg wrote:
> > Provide documentation for usage of TEE based Trusted Keys via existing
> > user-space "keyctl" utility. Also, document various use-cases.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> This is the most important commit in order for someone who don't deal
> that much with ARM TEE to get right.
>

I agree that documentation needs to be updated and your following
comments seems to be somewhat similar to comments from Mimi here [1].

> Until this commit is right, I don't
> unfortunately have much to say about other commits.

Isn't this statement contradicting with your earlier statement
regarding the right order would be to complete TEE patches review
first and then come up with documentation here [2]?

[1] https://lore.kernel.org/linux-integrity/1568025601.4614.253.camel@linux.ibm.com/
[2] https://lore.kernel.org/linux-integrity/20190909163643.qxmzpcggi567hmhv@linux.intel.com/

> Instead of making disjoint islands, you should edit trusted-encrypted.rst
> so that it describes commonalities and differences.
>
> What the document currently describes is the usage model. It could be a
> section of its own. In that you should describe first the common
> parameters and separetely the backend specific parametrs.
>
> From kernel internals (there could be a section with this name)  the
> document describe the key generation e.g. is the hardware used and how
> it is used, is there salting with krng and so forth.

BTW, here is the info regarding RNG provided by OP-TEE (an open-source
TEE implementation).

It's either direct output from hardware based RNG (if platform
supports one) [3] or a software based Fortuna CSPRNG (executing in
trusted environment) [4] which is seeded via multiple entropy sources
as described here [5].

Overall, I think salting this with krng sounds reasonable to address
single RNG source concern. So I would suggest to have a common wrapper
API that would do salting of trust source (TPM or TEE) RNG output with
krng.

[3] https://github.com/OP-TEE/optee_os/blob/master/core/crypto/rng_hw.c
[4] https://github.com/OP-TEE/optee_os/blob/master/core/crypto/rng_fortuna.c
[5] https://github.com/OP-TEE/optee_os/blob/master/core/include/crypto/crypto.h#L272

-Sumit

>
> /Jarkko
