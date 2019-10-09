Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D8DECE58E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D18721835
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TIgenNV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfJIJPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:15:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41789 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfJIJPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:15:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id f5so1689658ljg.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 02:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xQdw4R3yd8uY4S0AtwkeNETH9sjE+3/5zjSKDJPgdeE=;
        b=TIgenNV5yjiuaPo8U4iDSsdkJpOwEyS2e7UUrQX2nTTWYVsQB4Htt02bvBiEe6BbQp
         i86i29qVWjmb/JPgBrJ6OER5+lvhqH6FgTCOs/IOqooN/OKMWpkug8tHGF+pyL5Lp7Cl
         UT5Rw/hlVPjaoO7C5CofjZQqsK4fkQP2kSrhekmXnPUOJMLpM9zI7Y7jFr3FEB6fYR6V
         ovsoIfeMEN8xPf5LltPze2Y4SuVcLJXYy/O2m39ul3t648SV1rsqMZ0Sz/cyBRniF5x7
         SJ/1Uk1aJNdvG42tH55iwL27WB+Fwtvr63zcOzLI/yereccG3BD8t0w3v97rZ7ntnAm5
         8/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xQdw4R3yd8uY4S0AtwkeNETH9sjE+3/5zjSKDJPgdeE=;
        b=LC+okllAN1jbzue2YJdBBLHTcA5xeRiYEM399QC4VUTBhfUA0tB8iDCLx/t26vzx4w
         pia4SyMdlpeEfucnyUuKOoP1F3cQWkRrJFzBl/Lw+YeouXCHQGHKoaxU6UnBCeLLeonA
         +iFlw1auOrr5KArIwuTNgZ3epvY31maapkTovdfi1qqyFViR587JyRZKF2eiFy4pMn3A
         rmBogmJapI/YPhnj9MdVHhA77oNk2NI7FnfF4mkwsqkHqCMIXWAOqDgGAxtx2BSSmDdJ
         igWsduwyJl7J4lJNo0tPz3BFhsnCJmefzvZAgsKttdYPp30tMBWbK6CC9/96cG6ZOPyT
         hmmQ==
X-Gm-Message-State: APjAAAV65YiYWRq6gqDyUA8dvWI5EgF2UwmAzXF5cdFoFsTuDWv+vsxp
        g/G5qt7GjoXpsAyvKj7UmINmvqiEWLHCxGLJAc7fdw==
X-Google-Smtp-Source: APXvYqycTPdHDVThk2pK4GG2ep2AmGYzjIumLcOCNe4xXDx0G71eKy3H+MRX39MjAYgpKolX5namsNiR8Yb4NF+D/Q8=
X-Received: by 2002:a2e:481a:: with SMTP id v26mr1567972lja.41.1570612499161;
 Wed, 09 Oct 2019 02:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191004164059.10397-1-j.neuschaefer@gmx.net> <20191004164059.10397-2-j.neuschaefer@gmx.net>
In-Reply-To: <20191004164059.10397-2-j.neuschaefer@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Oct 2019 11:14:47 +0200
Message-ID: <CACRpkdbxgqpQwLFGh1woq3cyY_Y=rBkkBafXJGW4_jtZae-42A@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs: driver-api: bt8xxgpio: Revive dead link
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

On Fri, Oct 4, 2019 at 6:42 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

> www.bu3sch.de has been unusable for several years, but the same
> information is available on bues.ch.
>
> Cc: Michael Buesch <m@bues.ch>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Patch applied.

Yours,
Linus Walleij
