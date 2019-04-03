Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DACC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F8920651
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hn5DMg+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfDCW10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:27:26 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35448 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDCW1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 18:27:25 -0400
Received: by mail-io1-f67.google.com with SMTP id p16so326278iod.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 15:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+3faNpmag6jYME5yNI69COYIz0d4qS337f0eaty0yLY=;
        b=Hn5DMg+qfhg8lnUXmQEgJ4eyGQRy86cBCVdOiz+SoR4bX8ULjx3usvppAd3U/Tjo+3
         pHcQLhA3s2MAgrAxsJP7GSq7JG6jMjmn4mjKyBEp/bGnUhoOwSeCwPTclx6LWkhYulrq
         SoU9wFkqFC1RrPQXHhojDrXTjLSQN+So9U3wt214BoVJ5XUbH4bQp44HLENcmeD4Mb3X
         qdL0djpsWoB7JX+T5M6PCzE9BbFqDSBCTtApX3wdEYLcOQPrAI6bORTgR2IpA6jHh8MT
         x6QCOhB3xdwb3cRgS2IhQ6tWhcf8Fn7ZIVFwQJWsgDGNEbeTqB6zPq7VypFgzQgg3Ss5
         o+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+3faNpmag6jYME5yNI69COYIz0d4qS337f0eaty0yLY=;
        b=LXST9gFjjhRpFIp64jEEVJX8UhrurbsB3eaeCw1MUuLKWJQVH17iGsh70s3L0WkoUx
         Vo+b0ECqQbr34mJDslXZvVebYdzHe+CBhBXBtowGEzJCG9Pf/xt8NUSVADeP5HQMdz7E
         HQrD9ZwhyE5azKntl45zlSv8wEh0+yubUh/ZQ671CEiH00MbG+ZClor5iYYGZ5+cmGXM
         XOeuxavuSgkfKL200CrRazG8WPi/NjnJuMagZRcAywkhTI3xM0rV45T4Gj62/EMqUFAn
         jD6WGHHATywSZZ4yIr7R7uEiiNMqy/j03W4ROAIqxYgBDPa6TFXU+tQ+CXxNQrdCo10E
         +4yQ==
X-Gm-Message-State: APjAAAXMnxLK+5sMXYD6dUhbQy44JMIbUm2V9Yu2rif8bGg7ABGMHlp7
        B2nX3R796OVQynYQcdYTm6CjRejmq72/ugkgvHSwrA==
X-Google-Smtp-Source: APXvYqyjaucmj870Vz9jHZPatpcn5T0LihCycvdCx7VILq9npP5A6ssDHW9qOcaFARXAimNtxuuxG36+qUImTOEY86c=
X-Received: by 2002:a5e:d514:: with SMTP id e20mr2067567iom.8.1554330444296;
 Wed, 03 Apr 2019 15:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190402181505.25037-1-cclaudio@linux.ibm.com>
 <CACdnJuumhkqTb4+1=QBiLmbW4xd3wW=MZu6Tj_KdaoTMhCN+Tg@mail.gmail.com>
 <4ce5e057-0702-b0d5-7bb2-cea5b22e2efa@linux.ibm.com> <CACdnJusBm93zwDqTXTx_QYsg1-aGUAAHm_qq8Lcx3TvGTxdmbg@mail.gmail.com>
 <2208f156-d441-3082-2f4c-8030c84ef788@linux.ibm.com>
In-Reply-To: <2208f156-d441-3082-2f4c-8030c84ef788@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 3 Apr 2019 15:27:13 -0700
Message-ID: <CACdnJuu8OqMrSs0esOmf=ro9n00aYEQ-nikAh6v6sk+YAQw4cQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Enabling secure boot on PowerNV systems
To:     Claudio Carvalho <cclaudio@linux.ibm.com>
Cc:     linuxppc-dev@ozlabs.org, linux-efi <linux-efi@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Nayna Jain <nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 4:31 PM Claudio Carvalho <cclaudio@linux.ibm.com> wrote:
>
>
> On 4/2/19 6:51 PM, Matthew Garrett wrote:
> > So you implement the full PK/KEK/db/dbx/dbt infrastructure, and
> > updates are signed in the same way?
>
> For the first version, our firmware will implement a simplistic PK, KEK and
> db infrastructure (without dbx and dbt) where only the Setup and User modes
> will be supported.

Not supporting dbx seems like a pretty significant shortcoming. How
are signatures meant to be revoked?

> PK, KEK and db updates will be signed the same way, that is, using
> userspace tooling like efitools in PowerNV. As for the authentication
> descriptors, only the EFI_VARIABLE_AUTHENTICATION_2 descriptor will be
> supported.

Is this API documented?

> > In that case we might be better off with a generic interface for this
> > purpose that we can expose on all platforms that implement a secure
> > boot key hierarchy. Having an efivarfs that doesn't allow the creation
> > of arbitrary attributes may break other existing userland
> > expectations.
> >
> For what it's worth, gsmi uses the efivars infrastructure for EFI-like
> variables.

My recollection is that at the time the Chromebook firmware still had
EFI underpinnings and the gsmi code was largely just an alternate
mechanism for calling into something that was fundamentally the EFI
variable store. With hindsight I don't think layering this was the
right move - we've adjusted the semantics of efivarfs on more than one
occasion to deal with the behaviour of real-world EFI platforms, and I
don't think it's helpful to end up in a situation where we're trying
to keep behaviour consistent among entirely different firmware
interfaces.

> What might a generic interface look like?  It would have to work for
> existing secure boot solutions - including EFI - which would seem to imply
> changes to userspace tools.

I think that depends on exactly what problem you're trying to solve.
Some aspects of the EFI secure boot design end up mirroring the
economics of the PC ecosystem rather than being inherently good design
goals, so it'd be helpful to know whether you're taking this solution
because you want the same three-level key infrastructure or because
that just leaves you compatible with the tooling.
