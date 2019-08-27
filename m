Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23267C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0555206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMfDUzq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfH0NB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:01:56 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37865 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfH0NBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:01:55 -0400
Received: by mail-io1-f68.google.com with SMTP id q22so46061493iog.4;
        Tue, 27 Aug 2019 06:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IznHIM7UUcW+U6jbG68Psd8PjmPl9stA3Rx33w0vCtU=;
        b=NMfDUzq/oGmjvEZQalfLkgJQ0KTEEHVUJ8inbz5dQ1VwCoy3DLaY7BGX7cRGP0uizY
         rbujxNQD2w94ycp9m0xbHsRyVFk20/aQsOHE2ArvRynyqFoTyMnSrvWvycBabbodMFEE
         ZTsl+hXBugp6Kd99FCcE4oZ65LEW4kIC4yIjbfnv8KqVofy+XDOqJAGLcOIuvIS8KKs0
         n9sGsaDOE3g7crd3d+LMCHl8u2qWpaWTHNPLk51Pk130nzq9MmVM9CE8aBRl1VI6lbHc
         zOn8wQS4mjr/deaoLhbJEUdPjIH2suuLIw3TXZyEEjmcfxM70fwyajMXQim50cIsfEij
         GE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IznHIM7UUcW+U6jbG68Psd8PjmPl9stA3Rx33w0vCtU=;
        b=N8B3SAvLJOgPzfMrtavHPROg+4dK9iXZ8fVWvq8cEX3sjzYnAHq0RL+N6XrNZcpmOf
         PoxLc6fDf4G95HPF9y/JRA15dQM4f/WVt93ZUYaXDFOO7RvAXS+cnMWqjzeMDORcIHp6
         k2afD3pvgmR/SaWMP933GeHU7gZEmC2DbW3KIg99diKQsBMKFR9kRMHLEMGI2fr3NwRo
         t26h/W7R82B+ngAYRMQkxiBWGd2joJlG5+wIIxjJLUepZ7hCWGgWM2ZQ0w181WHtNTdN
         V7gMsHGpD3helswZi9kHXu9QLQ/LY97gdtXohDepkso6QdJCChv9Y6BUExPa9n3xgC/v
         JtjA==
X-Gm-Message-State: APjAAAWj/fJ032tMA1IFUw4qn+5Bm2O0CJ31UtJuD832BnLtTcIRCA9H
        fEdefB5kb08cevZSN1LGSYteAycEoLeWNrJ6UbA=
X-Google-Smtp-Source: APXvYqx8kBnA5ruJH8OlJoI5fk/vdh4Qpj7WVCds4knz8N4LWkH4lMW3wUDEKrlB5gw870GmMKAgv2o+T+3BHJ9PSuM=
X-Received: by 2002:a02:9981:: with SMTP id a1mr23331194jal.17.1566910914814;
 Tue, 27 Aug 2019 06:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <1565086474-4461-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <20190806121612.GB4527@sirena.org.uk>
In-Reply-To: <20190806121612.GB4527@sirena.org.uk>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Tue, 27 Aug 2019 09:01:42 -0400
Message-ID: <CAC=U0a2VsdrjypcLQCJTROmbF9ojuJ2rA4Og7XXeR48LAjrArA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] spi: bcm-qspi: Make BSPI default mode
To:     Mark Brown <broonie@kernel.org>
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spi-nor controller defaults to BSPI mode. So its being put to its
default mode.


Kamal

On Tue, Aug 6, 2019 at 8:16 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Aug 06, 2019 at 03:44:34PM +0530, Rayagonda Kokatanur wrote:
> > Switch back to BSPI mode after MSPI operations (write and erase)
> > are completed. This change will keep qpsi in BSPI mode by default.
>
> Why?
