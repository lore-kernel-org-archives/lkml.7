Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BF9ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0044721924
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YCR1uF5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbfJIJNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:13:11 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45242 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730111AbfJIJNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:13:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id r134so1051963lff.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 02:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K78KklRog9ZZ5Yt/jTADpXsNBCoM5afXm2vhqmnA4XA=;
        b=YCR1uF5O0YeHaczq1oGjKyFOMgQl8W+XqfD8/pIZuPqSpsLclBdC6AoaBAB2hN54uY
         +bcUtbS/CqiQadb8OPyseWPFUC1X7A/6hqYKmW4Gx8KYNPbTFCgalKjKi4Qdvj012Z4f
         2YkaxQtEiNsLu9tDvCUvphFtvI+J719sgIRf2CwrRNo4r7kb9TmuQkq6kvfQlZ2M6rtl
         UzascCi0mh1Ifq9dVtCSjECY5iJyM/ULA3tcpspB3BosT3Hu8n2TBXTwncXSxUwWazAx
         jzKAD2Dq6zo2XuRXVFEoyWs4P2+Z6E4Eu3DuCZYETPBIyBz4qfy+YIHlT7x+3UpvSpWr
         sUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K78KklRog9ZZ5Yt/jTADpXsNBCoM5afXm2vhqmnA4XA=;
        b=pHqW/rK7SK4N4PvkgL35s/bhkMRSu2MnJNzPDPxmpvW5fC7IXpQ50qfC89gk/4q9TR
         93FXuXqCdONeBew9SI1+IVrgQQHNH+9RIAQt3bxDrYMTcxiuoSN6wBI9lZXb8X7ckDuw
         SCvbarslf848ajLQWSVRmOj2WFQKxadiCsGZNeZ6WSmmMgeitJ/EFIU7tq3KlWC8+ksh
         5zJzh8e0KxlbsYnv2cQyAMF4zp1hAffieV3dqg/gUblN6A4zuFLZoAJZ/o9YPPo9cNqL
         Huyiyu9g3OgzctjnPpfCLCbKOlislTQO0+aoxPzYKzPc2ksMIEumr2jw0HhNanjD7wGO
         UWCg==
X-Gm-Message-State: APjAAAVLDfkfnac+3ozgIbyJDSRluVcc6Ai22zcTygVq40ypYnzm9LtQ
        /NGVtMXzRn9oBf5OIyp0zrgZ04RaSRZ7pcgy0zdhUg==
X-Google-Smtp-Source: APXvYqxXSWot6LGbQcOddq5DeyXe6rXtpVH58kxOqwEXgboUiUy3V3ANm6291Eeup+zLJtZxza772BxT8V0iNc+6RXs=
X-Received: by 2002:a19:c505:: with SMTP id w5mr1408110lfe.115.1570612384646;
 Wed, 09 Oct 2019 02:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191004164059.10397-1-j.neuschaefer@gmx.net>
In-Reply-To: <20191004164059.10397-1-j.neuschaefer@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Oct 2019 11:12:52 +0200
Message-ID: <CACRpkdYBfmK0nb3m-RXbnSfCKHY5j2Fns2P8iiAUjN1qO8TruQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs: driver-api: Move bt8xxgpio to the gpio directory
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Michael Buesch <m@bues.ch>, Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 6:41 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

> Let's declutter Documentation/driver-api a bit.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Patch applied.

Yours,
Linus Walleij
