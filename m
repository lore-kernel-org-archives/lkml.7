Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB0FC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26E12173E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbfEVVUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 17:20:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39476 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbfEVVUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:20:18 -0400
Received: by mail-qt1-f193.google.com with SMTP id y42so4250275qtk.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 14:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PLY+CCzT6G7iJEFJBPIdwtB7E513yqHwhuA32U3ib3M=;
        b=b2Vss0LRo5UJ5rnNq1qo8U2qGE/b/EohPq3TyGsUJ3BfWWfCp+7Td75D9fn3l5eIwv
         wKYzVQb7GZ4CffhKL/Cn5329X7GfiF4JtPnrCm4w5QawQOjHCiwAmADyubM5CVQCPoKl
         YDh0GScvABYx0BWTkZKm0CfgeBfWpojwBgYOm7Af7gRiUMrhVg4Zt+kU1EtAJliSUyqR
         qr5qP4xbZyoC9ku0baqmuamOVtGfpr35Yz0dl4OibLtuQI94ybS0f0nl643JqqfklTyr
         s2ijv8q3LCCcyhmrDgYlO7rLReXLCwf9+BUBgDRRJsA1unazkVcI55QXDXdMSHvw9XSU
         c/hw==
X-Gm-Message-State: APjAAAXI1a3llIDFBXOlPQDxg01XR24p1okyZnAEIA5ee1Sw1OLq8cZI
        Fgpm/vYYJADP6IX5WXK3D/vA+JGQKttKmTLgX2g=
X-Google-Smtp-Source: APXvYqwXie6/tZhn3C4BpBgyl8D93Wtqfnb2Q1JvEErclhEBWpspsuISvDK5zx3thIBKKQda8003GrBIAoQ7tjRZi2o=
X-Received: by 2002:ac8:2a05:: with SMTP id k5mr59259074qtk.304.1558560017048;
 Wed, 22 May 2019 14:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190520141047eucas1p2c6006d1ecfc3eb287b6b33d131f66180@eucas1p2.samsung.com>
 <1ab818ae-4d9f-d17a-f11f-7caaa5bf98bc@samsung.com>
In-Reply-To: <1ab818ae-4d9f-d17a-f11f-7caaa5bf98bc@samsung.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 May 2019 23:20:00 +0200
Message-ID: <CAK8P3a0wky-Km=PQO9=jN2kC0Zyy75LfD-1Kn5YHiEEV8ymZHQ@mail.gmail.com>
Subject: Re: [PATCH] misc: remove redundant 'default n' from Kconfig-s
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Eric Piel <eric.piel@tremplin-utc.net>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 4:10 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> 'default n' is the default value for any bool or tristate Kconfig
> setting so there is no need to write it explicitly.
>
> Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
> is not set' for visible symbols") the Kconfig behavior is the same
> regardless of 'default n' being present or not:
>
>     ...
>     One side effect of (and the main motivation for) this change is making
>     the following two definitions behave exactly the same:
>
>         config FOO
>                 bool
>
>         config FOO
>                 bool
>                 default n
>
>     With this change, neither of these will generate a
>     '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
>     That might make it clearer to people that a bare 'default n' is
>     redundant.
>     ...
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
