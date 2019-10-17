Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4244ECE599
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 04:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6240214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 04:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mQJY8fRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407757AbfJQEMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 00:12:25 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45850 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407691AbfJQEMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 00:12:25 -0400
Received: by mail-io1-f65.google.com with SMTP id c25so1243099iot.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 21:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZzqdPppOqmZ7owdzuL7vxTFr6ZcenIPQ+cUypjsYJBg=;
        b=mQJY8fRgC8QygXRlAZYcoI2JQfO1ULEBuFZmc9AaaFY4UbsAiXtCwXJWkXannTU4A4
         QEf2Cl+BksR6GFrFSg0S5gtOm4HnILag8HNYzIbJt2G4xq+9P8XNBIM/kd61j/PTUyl0
         ZJISlimdDfQScCTn+qIlhOG0KdMZhFQRKUXUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZzqdPppOqmZ7owdzuL7vxTFr6ZcenIPQ+cUypjsYJBg=;
        b=oO571ttCZRmPHB1xHaIyMz0vyRtUYyBdq/XA+hlW2KapYBZSrU2gymU79GQ3nqLZcs
         QPw5p4FIruqoZZckBseHZisT4/VK8zaSPzYWyeJUSbtEZviEm5kq7T+4GdcmmsDbMyRm
         2891WTKuBgXHXB5NOz3zBEb8Xwjy4EmgBE3xoixXuZbAK+wSnzjq4JMoNdQcBdbTPS7z
         fbPFB4UB+8w/NZYoxYPCVNioxxmrTblXoEgzqefZbKWbdAMjTYV2Q8GfNrpCHG8aZXEj
         l6drSipo0gkjW+y2enBbAcuiCzFAxCIWaGak2cX44hka44d3puBholtvBggyMkCqbRKw
         FDzA==
X-Gm-Message-State: APjAAAW9AVmeujXvdOicBKHxtfY94b2zMOTFvCSjKpH389qRrkINQ70c
        XwkMBqAH2vOLoXyfBPqxv36nxoo6Cpw=
X-Google-Smtp-Source: APXvYqykH3FQFU9sZx5RlRUSRrsDU893EtFZGzq24MT4zpj1ZjtDul3QJw40tYIox47QSy8XeJwrMw==
X-Received: by 2002:a6b:908:: with SMTP id t8mr1028442ioi.129.1571285542467;
        Wed, 16 Oct 2019 21:12:22 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id k66sm349177iof.25.2019.10.16.21.12.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 21:12:21 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id w12so1248481iol.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 21:12:21 -0700 (PDT)
X-Received: by 2002:a6b:7715:: with SMTP id n21mr1090520iom.142.1571285541570;
 Wed, 16 Oct 2019 21:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191014154626.351-1-daniel.thompson@linaro.org> <20191014154626.351-6-daniel.thompson@linaro.org>
In-Reply-To: <20191014154626.351-6-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Oct 2019 21:12:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UYbC0zQHfW8XLfw0ipnjtccyh7EXPXsRnOA_MM-m3wbg@mail.gmail.com>
Message-ID: <CAD=FV=UYbC0zQHfW8XLfw0ipnjtccyh7EXPXsRnOA_MM-m3wbg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] kdb: Tweak escape handling for vi users
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 14, 2019 at 8:46 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently if sequences such as "\ehelp\r" are delivered to the console then
> the h gets eaten by the escape handling code. Since pressing escape
> becomes something of a nervous twitch for vi users (and that escape doesn't
> have much effect at a shell prompt) it is more helpful to emit the 'h' than
> the '\e'.
>
> We don't simply choose to emit the final character for all escape sequences
> since that will do odd things for unsupported escape sequences (in
> other words we retain the existing behaviour once we see '\e[').
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
