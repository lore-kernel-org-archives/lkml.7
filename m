Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C979C2D0C5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528D2214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="qTf8M7Um"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfLLCQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 21:16:03 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43130 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfLLCQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 21:16:03 -0500
Received: by mail-ot1-f68.google.com with SMTP id p8so833775oth.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 18:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bfZqzYbzlI4qJvFk+tQo2f1KM1Kh7iadCkXBQ7iIRwg=;
        b=qTf8M7UmPyeZzBaccuaHtvT3a/sakASiqOp2Z+RwIME8+PMqvWqfaLxv1lkXmdjHzF
         /3sSc6VfsgRQAXU76FlNdaDFyHOJP2tj83y6ExOhTtu7UhIBJkUtVkbAjbn5BZZCkW2Y
         Rs2gYms1yw3wy8BZ2c6fYkXZSaJ/YaSnANbT3E2mZ7ZDt2jnRI2T5vmZjRoxQfE4esaT
         iJgLv1sIKyfNikcEKZ2I1Ok81K8eBACmzvUEl4ia0pYCkXNae2aP7al4CVq+Cka0P7CK
         W+VP6KmmmTdg4UyTgg12psU2q3voShpwrdh3GPI4mdkCqk73pdlMIgJSni6I2qIu1oVc
         9DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfZqzYbzlI4qJvFk+tQo2f1KM1Kh7iadCkXBQ7iIRwg=;
        b=Xv/vyEnUMAZpy5qWb+W7rYi0eIm0Jx8dLGnzXnHObo4hDMyNrLzYHNPzpClFrXjFOc
         kDwHJmzbEIuuX01RWuMCGe7lMc3OZaGT6IXO/zQjZKMlHwJX/l0dQmnGdZvap8HZJOu8
         JYPH6w0yWU9bRP82I8CMr+7suEgwr/mtqE7XbyR6a2ZUJ2JVRIHKIP7PbYGJLcMqd7Wq
         rUKvqFEKEZPmSVgS+W8xJ8lGD5zHCmYbGZsN72lYn6DpOOPWl2TZ0Fp9Vs2tCl1YQ5ne
         SdJMt9c8b1N7Y1CEV/U05bVXftdixgN3xGInLrqy/dx5D1U76uKEzLOjREuOeiYF92Aq
         gTnA==
X-Gm-Message-State: APjAAAUGN/wzC1h+DIloPrzUZOq5IeKiqx2d2xTRnlJjl/CLxwunL/BM
        kd0PkegOkIEXTvv8AYLulTxZ0aLFcvJUZi/JtK0FtQ==
X-Google-Smtp-Source: APXvYqzxNRvK94jxtJxmhO0k8PrlKZLR+98P8FXxh7Ge4bTNkRznw0p+mDLpxvpfpV1N1afBe0yBfT6T0tHzFxUCQMA=
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr5252698otq.126.1576116962131;
 Wed, 11 Dec 2019 18:16:02 -0800 (PST)
MIME-Version: 1.0
References: <20191211231758.22263-1-jsnitsel@redhat.com> <20191211235455.24424-1-jsnitsel@redhat.com>
In-Reply-To: <20191211235455.24424-1-jsnitsel@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 Dec 2019 18:15:50 -0800
Message-ID: <CAPcyv4j_FJ9teSyfodCjXs5Wz2Pj7BjqKX6Mx53OtPnVu0mjGA@mail.gmail.com>
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

On Wed, Dec 11, 2019 at 3:56 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>
> Instead of repeatedly calling tpm_chip_start/tpm_chip_stop when
> issuing commands to the tpm during initialization, just reserve the
> chip after wait_startup, and release it when we are ready to call
> tpm_chip_register.
>
> Cc: Christian Bundy <christianbundy@fraction.io>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Cc: stable@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
> Fixes: 5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing IRQ's")

Ugh, sorry, I guess this jinxed it. This patch does not address the
IRQ storm on the platform I reported earlier.
