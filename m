Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFB6C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627B420643
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kvgyq/Ix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbfDDRYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:24:12 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41422 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfDDRYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:24:12 -0400
Received: by mail-io1-f66.google.com with SMTP id v10so2654196iom.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 10:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7MlZLJUnUYnXY4wXYphYrA0UP4CAsH1ZwE2V84axQ24=;
        b=Kvgyq/IxON3TOJZh57y0QXhw+lEtNZQYroJvyQ/3tq28mkBWMctD1oAlHuXeIBnFS+
         2wasRBlHtpSdwaByusNRP2jyhENkiJrGoL8nfsuxZT11j2/sP6VteM363o2Uzm1556X6
         fVkB4yp97CsqRG0hFU4HaCjkYjoktWCttJ3q/9kkPMUZ619FtpbTIvpfFfIw1VGHNM+F
         48oA4TcoonZrR7mE3iLrOwBk4pnBYyIMpq/30OMjlMf1teV2/7+zQNfxyCuRCK0Yc2Qc
         2J0HfNKztGl4w1CvBL/wcVxospoSZAzjhzUFG8Q1IgQPpVdGRBSmfPFrUpFQb8nxHuXa
         eizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7MlZLJUnUYnXY4wXYphYrA0UP4CAsH1ZwE2V84axQ24=;
        b=mNGy/H8qjFWLZQ1Ofi/IQxGazc5hQPChBk7Ky8OF9fwBPh4mlgQzA/ukWJfvh3Txnj
         v/rHa9Zh/M0oANeCbQcynHV3SVddG/aAgv+/dPNMwj6Dc9P/wQQBh5FCZ+byG/lB6aTE
         CWVemD4iPQDemRmZdy21cAqVmh06AkoRq41rsCRWw9zkFDSiRengkZ90X0vP/u6zGSeP
         qSJZvq+zJxuDt7cSjeeZeQS4YBvI7MRIoI407xUuzZiI+ExTT0uKoZSYL26kWTKcCkvg
         c4JaHRAp902U2bTrBJk3lCqLrRUBDH6/DMCtLgr5Ymfjqc5SdW8n0miK9CjeMEb37i+3
         RAmg==
X-Gm-Message-State: APjAAAV5T0sW3wURhHrD9lhfJyeOB97QBLdQy2R4J9JiOCr2Hbtnv3AF
        WMtlkTd9MVJzp2N8oo+Ca6zZNZ0e3kgt+5M8rAUVig==
X-Google-Smtp-Source: APXvYqzfmjGs87sD6VkhwMEWGK/axyZGbXKLwqJmISmP6yDBpa3SvzAEry4rNuJZFSQR0HkjyCf2ZdERSV2XLw4KWCg=
X-Received: by 2002:a6b:3106:: with SMTP id j6mr5445371ioa.147.1554398650709;
 Thu, 04 Apr 2019 10:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190402215556.257406-1-matthewgarrett@google.com>
 <20190402215556.257406-2-matthewgarrett@google.com> <CAKv+Gu_yPKjK64qDEWgyacvKcoXwivoi4tq35T=uNE0syRhm8w@mail.gmail.com>
In-Reply-To: <CAKv+Gu_yPKjK64qDEWgyacvKcoXwivoi4tq35T=uNE0syRhm8w@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 4 Apr 2019 10:23:59 -0700
Message-ID: <CACdnJusyj_eXi169ikNcfGG4HwVdNrxfd9LtRc-qYVaMbDDBTQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi: Fix cast to pointer from integer of different
 size in TPM log code
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        =?UTF-8?Q?Peter_H=C3=BCwe?= <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thiebaud Weksteen <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 5:54 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Wed, 3 Apr 2019 at 04:56, Matthew Garrett <matthewgarrett@google.com> wrote:
> >
> > 8bfcff4a6a1d9d7226bb63a7da758b82d9ab4373
>
> Which tree is this commit in?

Sorry, these are in the tpmdd-next tree.
