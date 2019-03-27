Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E55C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C272075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Rk6Bs+bZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbfC0IjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:39:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35950 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfC0Ii7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:38:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so15754088wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 01:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yWTdMO/u4KOiskJtQBGHbF6j2v2MoP1IZWeewOD5oUU=;
        b=Rk6Bs+bZmgRaisSLFc8nFs0apJ5prGC+gm0QebTOCIWTMT5G19UYvCHxxmrJhklIL6
         wio3/1fMTtIrwTjztKqOCMSduTaGYrowCiq3OjuR0Fyh2XlRi45Qja2oH/mYeOSgIfkg
         uAym3FIXdZU/f7zsxlTtOhPzHDyQbMXTtDsX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yWTdMO/u4KOiskJtQBGHbF6j2v2MoP1IZWeewOD5oUU=;
        b=YCxdLPNN+2OxQCSA55Y1/iDPbZ21Whu0s5SjXUZi2QY4CAedUpWW4PKP6d9HzvUMy9
         OFDzzaFoAW8lFmibvjg2CEWdAVNQDJeaJrt8dP9PoHxirkvq0KYi2eFqgwiYyrdSqOpE
         zxkVkgdvMogJ4Gn4Ur62uQ7ZUlrcRBNx15AHAxlGzYhskyeSYYuGWGWdZuqvFegOaPme
         rAj94Sp+5sInv8Eiss0gDgqUiIi3VlRyuz3LTbe0dvERDr23TmnRP/GWi890Xx9dfr0p
         g4glydjuPqEqNYHzA9h9XmAKxMrDK+r4QmqLmeYd6kKhqv62bLDGX2P4y9v8u2zESsea
         /7fw==
X-Gm-Message-State: APjAAAXI/diFIXIPXOtqwfAZs69SbtLWsyPAlkYWtLKS6wDXQfaNJdJU
        YPvyBWxsZRLPmRlJOnUjsfos7/gY6nA6jfH5+rRJ7g==
X-Google-Smtp-Source: APXvYqxgYtcGlMbOfnJs1AcQu4Zatx7WN4kazaWkSdamJCzsDnYtRT4xBdZOcS5qbufv9JEMtZXQZ3/Qv00/vMwEEWk=
X-Received: by 2002:a7b:cf2c:: with SMTP id m12mr7447073wmg.21.1553675937349;
 Wed, 27 Mar 2019 01:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <1551415936-30174-1-git-send-email-srinath.mannam@broadcom.com>
In-Reply-To: <1551415936-30174-1-git-send-email-srinath.mannam@broadcom.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Wed, 27 Mar 2019 14:08:46 +0530
Message-ID: <CABe79T5M3FJQed018aGfRhS7eLBbtmoO33mFP=K+xHgavto64Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add IPROC PCIe new features
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo/Bjorn,

Could you please help to review this patch series when you have time?
I believe I have addressed all your review comments.

Thanks,
Srinath.

On Fri, Mar 1, 2019 at 10:22 AM Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
>
> This patch set extends support of new IPROC PCIe host controller features
>  - Add CRS check using controller register status flags
>  - Add outbound window mapping configuration for 32-bit I/O region
>
> This patch set is based on Linux-5.0-rc2.
>
> Changes from v3:
>   - Addressed Lorenzo Pieralisi comments.
>
> Changes from v2:
>   - Based on Lorenzo Pieralisi comments, commit logs are expanded.
>
> Changes from v1:
>   - Addressed Bjorn Helgaas comments.
>   - Removed set order mode patch from patchset.
>
> Srinath Mannam (2):
>   PCI: iproc: Add CRS check in config read
>   PCI: iproc: Add outbound configuration for 32-bit I/O region
>
>  drivers/pci/controller/pcie-iproc.c | 44 +++++++++++++++++++++++++++++++++----
>  1 file changed, 40 insertions(+), 4 deletions(-)
>
> --
> 2.7.4
>
