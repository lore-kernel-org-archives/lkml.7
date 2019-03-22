Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADB5C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A454218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ifmqZX1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfCVH4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:56:52 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46924 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCVH4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 03:56:52 -0400
Received: by mail-io1-f66.google.com with SMTP id b9so961706iot.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 00:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kl1B+Ivc3PKE8hoZ+rXxR+ntuCueGNULslvt7Pmb2oI=;
        b=ifmqZX1tPPiMNpFENczDCPjKuTYRRkca3MZnukeCdbmUMCdE6LvqM4ym9J3njeoqGu
         7yxFPVfgu12Ik4ivsZ+lWJq7exygXLTBPijnHWugRQxLi+YjC9Z7vOODCUNNAOHnmZzv
         0iVWqM1W4yZo4QHrhyvYIutLWGGabwIJFa9/tMbNEiSHdpknl9G6J9WcXKhOcY4aKUvN
         Hc9OWVcCBVQDurmO++Qal0qA3tz0lRs2AUn3Wm+IMElEAzUcD0lBC93GeEz/+8cnPLTG
         N6I8fvzMzrPCDWeYlvxVr3SdT1jT3tdgtAjvNvAktilipyyPqZT1RfVQ8tP0U3Y8MkUR
         cktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kl1B+Ivc3PKE8hoZ+rXxR+ntuCueGNULslvt7Pmb2oI=;
        b=eJbJFl7/wRnz5cptqlTeS9YtNAW2bIh5YjL959BBPTgppoEZdh2wL+XR6N/KAdRSmB
         RTnU3/AIAimFjJdLY0cXhbgSopZ3oHx476e1aVi2JGoq8bCkQAotVEKzNIhLC2u3ntNc
         oha55H1GoqsoR+ZinqtlT9YsdY8Io7FOWXXMOqNz1DV33z9v6qaFhIedVEGf/Z3iAqVK
         /SJA8KI/yShIlPkdKZoQ4qRQa4fqw9Ycqg+MAJlZC+6khY+q7/FeeYJpiPltF/3le4a/
         ZYLtpyszWu9G+rY6P9aAHnv0kRVoHKHDfnHW9/ZIZLUQ13WHAgLjXd6VRqgDU961aS39
         9w5g==
X-Gm-Message-State: APjAAAUIf/nX751zBNeqRChauBMnYeVHe4xF7seZO3it+yHc8aOJbZuq
        YX5/iRzB1ZIW++7p2KTEe1Xo0RT2uiu+nDoLNJziWg==
X-Google-Smtp-Source: APXvYqwUme5xtdHv4AlR+suujBzCOLgYFRnxpvKNt4H0I10djQYsbBd1LrB4SPuHe+Dw6ZaDFDEmalMGQFVYAoziV2w=
X-Received: by 2002:a5e:9b17:: with SMTP id j23mr6291159iok.60.1553241411186;
 Fri, 22 Mar 2019 00:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190322062740.nrwfx2rvmt7lzotj@gondor.apana.org.au>
In-Reply-To: <20190322062740.nrwfx2rvmt7lzotj@gondor.apana.org.au>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 22 Mar 2019 08:56:39 +0100
Message-ID: <CAKv+Gu_mgyzqUCeb+wke--8Gn8YbjOb8jyrSgFr3-tcNP8ccEQ@mail.gmail.com>
Subject: Re: [PATCH 0/17] Add zinc using existing algorithm implementations
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        Martin Willi <martin@strongswan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2019 at 07:28, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Hi:
>
> In the interest of moving forward with wireguard, this patch
> series adds the zinc interface as submitted in
>
> https://patchwork.kernel.org/project/linux-crypto/list/?series=32507&state=*
>
> with the change that existing implementations of chacha20 and
> poly1305 are used instead of the new ones.  The use of the existing
> chacha20/poly1305 implementations does not involve any use of the
> crypto API or indirect function calls.  Only direct function calls
> are made into the underlying implementation.
>
> This should allow the wireguard code itself to proceed.  At the
> same time we can also move forward with replacing the existing
> implementations of chacha20 and/or poly1305 where appropriate.
>

Hi Herbert,

Let me reiterate some of my concerns with Zinc, which aren't really
addressed by your patches afaict.

- The way WireGuard uses crypto in the kernel is essentially a
layering violation - while we already have an asynchronous API that
implements ChaCha20Poly1305 in a way that WireGuard /could/ benefit
from, and while we even have support already for async accelerators
that implement it, the reluctance of Jason to work with the community
to fix the issues that he identified in the crypto API means that
WireGuard will not be able to use these, and is restricted to
synchronous software implementations. Saying accelerators will not
matter is a bit like saying there are no American soldiers in Iraq.
(Note that adding async interfaces to Zinc is not the right way to
deal with this IMO)
- I think it is fine to have a 'blessed' set of software crypto in the
kernel that we standardize on for internal use cases but WireGuard is
not one of them. Having two separate s/w crypto stacks is a problem,
and I don't think it helps to have a cute name either.
- I don't think Zinc changes should go through Greg's tree and have
separate maintainers - in fact, I am a bit concerned about the fact
that, after the last Zinc/WG submission in October, Jason has not
really interacted with the linux-crypto community at all, while at lot
of work was being done (especially by Eric) to address issues that he
helped identify. So letting Jason (and Samuel, who has not chimed in
at all, IIRC) maintain something that is relevant to crypto in the
kernel, but without a community and without involvement of the
linux-crypto maintainer is not acceptable to me. (In general, people
tend to join a community before being volunteered to maintain its
codebase)

I am among the people who really want to see WireGuard merged. But the
whole Zinc thing is an unnecessary distraction from getting the
existing crypto API fixed in places where it fails to support
WireGuard's use case, and that is a loss for WireGuard users as well
as the linux-crypto community.

-- 
Ard.
