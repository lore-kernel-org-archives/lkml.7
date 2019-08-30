Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B2EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 04:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CFE2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 04:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ALInY0Cu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfH3Egf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 00:36:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44802 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfH3Ege (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 00:36:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id e24so5136435ljg.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 21:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pB+rGb0tWqsHi1eIDIKoLqLIFW12dRXmfWgM+te26nw=;
        b=ALInY0Cuh6sE9r14N2IRVle5WxABFqoqToXOgwRGgsjOcKV9iCprY1zwD8lAAxu0Zo
         iOK7DFOkXPvHfFzJmhm9G6YDncNSgtjCFXjAvEmxbvbZPT0MW7lazGTy29LAg290UvSP
         MlUlLBl6no5f/mWsgwMcDHcS0EGQNzyUBrziA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pB+rGb0tWqsHi1eIDIKoLqLIFW12dRXmfWgM+te26nw=;
        b=di4H3Xh53BpFLdcJJDEFVNJjmcR/vTCh7UAHqiU9P8CNnsUL3a21oAMiheqIWCxRQE
         oHUdoLvcuja/4J6PdUwuuDKxosdXq1qVGMl4t9uma29rDTpY1/VNKFQZnchUZASTzcBc
         Yt9OgMivqSvVEJr0QJJmm7VwebMZ8cYJowjcfZgsbcrJosVL6KQOXYiHyPj1jFFtUZVK
         YGKiaAM89HdWFJYmZ64EwALuQs75IjjQVOojn7/X8TjvJSi2bv0d9qDJwyRUhwMdbyB/
         lqvIhe9O5nWvi90rJtw/olOlKZ2FovSMWS8S9BdmWOem2Ce+1hAHubqYAO9qwgezBl5S
         9/bQ==
X-Gm-Message-State: APjAAAVDqIXjfMQtgLBwJfGxL/ay9TYtOrBjGTPEQYN8A6McuilAaSww
        BGyI+WIDaOVUuQryUS8otLJ0iHi0+Ycx12PS3kIkNA==
X-Google-Smtp-Source: APXvYqwBfehU7rkS2AIu4PFjA/1cfoTtyS5T5ZZilgxRzlBBqm02HIlVTCKIxRfILwMZrrJM2pFl66UjPKKhl0Hlmkk=
X-Received: by 2002:a05:651c:104a:: with SMTP id x10mr7062558ljm.238.1567139792623;
 Thu, 29 Aug 2019 21:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <1567052173-10256-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <20190829095907.GB4118@sirena.co.uk>
In-Reply-To: <20190829095907.GB4118@sirena.co.uk>
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Date:   Fri, 30 Aug 2019 10:06:21 +0530
Message-ID: <CAHO=5PG_rtONCLgOJCvUX7B=DENhow627xwXr3cQX_oOgmMmMw@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] spi: bcm-qspi: Make BSPI default mode
To:     Mark Brown <broonie@kernel.org>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 3:29 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Aug 29, 2019 at 09:46:13AM +0530, Rayagonda Kokatanur wrote:
> > The spi-nor controller defaults to BSPI mode, hence switch back
> > to its default mode after MSPI operations (write or erase)
> > are completed.
> >
> > Changes from V1:
> >  - Address code review comment from Mark Brown.
>
> As covered in submitting-patches.rst inter-version changelogs should go
> after the --- so they don't end up in git.

Thank you, I fixed it and sent patch v3 for review.
