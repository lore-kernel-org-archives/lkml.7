Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F80AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C6D208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="hHpBpD+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfLLCSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 21:18:30 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45523 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbfLLCS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 21:18:29 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so828979otp.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 18:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fPsu8XmzlYK8Y32ptaZLTsIwREbpto/xHjCbnxTIgwQ=;
        b=hHpBpD+jolyXkfvnd+Bw0vywrP0DCPLUgI2ACbOE2xZxt8vvxkZ3aG6AIWdf7cyFTF
         Z8w0WJEkiYZbZbqjciHdvUvMn3mBE9ONALf+pKjRX3Xzpy//aCDvfQFyqCYjiwEkWZmk
         AyFr8LRX7Ek+LInXFAcPEMifXMUcr1sEmGTKSCsTiE2PBEBFje3mmLb8hK30IWnc+wR1
         cr+fENqt8ryUl05GWGUQAP08hGFBcKQ0+rXLMdIPGlKZJ7cr3oVhte9sIoyUaKCdJAgx
         UcytK+eqnNpseRPMCM8MtNRHBQgGYJRpEJu2HD4sSQDQurlCBMI8/FbLGK5oQ13t0Lgc
         VMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fPsu8XmzlYK8Y32ptaZLTsIwREbpto/xHjCbnxTIgwQ=;
        b=X5A3mwVg4c4mKYA5u5FNi9dAyj8rl5nccSqZI+1HfAsnBzarix8ixrZlXR6WWApRwd
         peQC4mzd4VbJw10aczfO3/nlUWjuK75+qUx6VYM/m1kVrpN7d6keMX5YdKURPqYlqUsB
         9I0EjGXjvbIqeWB1mRUApGewZnus/XFmT4b6RzlZq8lexwW+K3GeiYFe6vEDrFiD7qkT
         cMO+3aNmV8ezmwmjiewFwdzOJizUANVCExqnbK9r/Oj9Mrt1EFGJ+FNFtCURz616vF8Z
         Sa4ptGgOtV6o3vosofYY8gWnEnkn4Ju2M3reXPs5y+EKHIaFuDwutgTQ7yWxAnFqzn+M
         lNZg==
X-Gm-Message-State: APjAAAVsNJ6dvvINWi+oLpotbalABAhlX8iddATIuZYUE9hBU7nnBYfF
        MlviEgVyBpAV3Voe0qDH5csLhRT9aaVb2KDzhXNvUA==
X-Google-Smtp-Source: APXvYqzwryCWAY6+cdtnheUjR8VU/s/FHdoPKfFKkJwCWIw+ekq+u0gj4D0WpI79MMEUyl/kYcj1karou9SKRNbisD4=
X-Received: by 2002:a9d:4789:: with SMTP id b9mr4976910otf.247.1576117108678;
 Wed, 11 Dec 2019 18:18:28 -0800 (PST)
MIME-Version: 1.0
References: <20191211231758.22263-1-jsnitsel@redhat.com> <20191211235455.24424-1-jsnitsel@redhat.com>
 <CAPcyv4j_FJ9teSyfodCjXs5Wz2Pj7BjqKX6Mx53OtPnVu0mjGA@mail.gmail.com>
In-Reply-To: <CAPcyv4j_FJ9teSyfodCjXs5Wz2Pj7BjqKX6Mx53OtPnVu0mjGA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 Dec 2019 18:18:17 -0800
Message-ID: <CAPcyv4jUz9X-eyf7M78dfS-7pzi4Xqs+LdpUSD=eoeQjd1kxug@mail.gmail.com>
Subject: Re: [PATCH v2] tpm_tis: reserve chip for duration of tpm_tis_core_init
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Bundy <christianbundy@fraction.io>,
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

On Wed, Dec 11, 2019 at 6:15 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Dec 11, 2019 at 3:56 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
> >
> > Instead of repeatedly calling tpm_chip_start/tpm_chip_stop when
> > issuing commands to the tpm during initialization, just reserve the
> > chip after wait_startup, and release it when we are ready to call
> > tpm_chip_register.
> >
> > Cc: Christian Bundy <christianbundy@fraction.io>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Peter Huewe <peterhuewe@gmx.de>
> > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > Cc: stable@vger.kernel.org
> > Cc: linux-integrity@vger.kernel.org
> > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
> > Fixes: 5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing IRQ's")
>
> Ugh, sorry, I guess this jinxed it. This patch does not address the
> IRQ storm on the platform I reported earlier.

Are the reverts making their way upstream?
