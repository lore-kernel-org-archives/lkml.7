Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E15C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EC8218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuUNTTR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfLRPI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:08:27 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45688 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfLRPI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:08:26 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so1087436pls.12;
        Wed, 18 Dec 2019 07:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O/Gc+Nk4cNpzcx2hTPtC5UA91cr7QkRAoGkZhjoba98=;
        b=XuUNTTR+Bu2rLHcBfVuIRId9B2MzsCQF/RCiW7UGzMo8S1CCFvzCeJu/cCqXY2gF3Z
         8uN+SlNxaMWN5XO2P0+VVEliyvh1lMqxSvorxCHzvrMpsz1rDXCAuW4N4viH6JyPaMKh
         6bvh70wcFUEtLHugk2Os8spnDmlKoPuo1xKnpYGNAyCMduKQeI+N8qyCQ/5E21QHWR6c
         zVagatbkJ/GTkBGRQ6/cAiUdVvgI0cEyFXJk6tMTOnWTVpOV3rz89wFb0rVBoWojwFzm
         XZ0qlCjcE96lKKj1qv6KGNvY+siu0GRojufEjmN4Id2PeVjoqRJtJy5eXmM7uwsRdsPH
         qw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/Gc+Nk4cNpzcx2hTPtC5UA91cr7QkRAoGkZhjoba98=;
        b=CBA+X62cO83inZRgTi+TV7N2CNVxHhanTHSR0wKHLCo46N7RGqy0nLc+I8pXiPjItG
         dgH3TvYNZKa546PctOiuXUtBlbGki2WcqVoCkx1Mx+RJvU2cs1cXV6PEZqbxGsm4qp6v
         q9YiARwF6vOh6KMudDFkTWOMaw5GkDpin+i+eKmp80m586CScWkqJVShXn5SX/uIYPP9
         IHMAHjv7hN1gYdB8qmFnDmOQ7JtUeYX5KMn86nrAFuzO+kyQijCRxc4iuXYKX01tLT2V
         HVfSkUaygRhlY1IIJAFyufRDy0OtwZqQ72tIMxTUvCgcToYuXhNnYw/hUR5zzcd9abX6
         GKlg==
X-Gm-Message-State: APjAAAVYL4H0plj/67OIiNsE2Yp4EkiE7qW9hhWLtbeEdF1N/aBnbWO0
        4dwvQ3rMg//sZEyLCExRLj3huwLwJyVQ8j15Aedkl+Xp
X-Google-Smtp-Source: APXvYqyMjxN7aSTmKOU9lPUYY/iVdbF3GF6BLMviv+qeEUyw+kvAG7vn1ONmiCDgg70PSgbR6aBkdCw9x/6zJE3Gq5I=
X-Received: by 2002:a17:902:6901:: with SMTP id j1mr3404514plk.18.1576681706038;
 Wed, 18 Dec 2019 07:08:26 -0800 (PST)
MIME-Version: 1.0
References: <20191217190604.638467-1-hdegoede@redhat.com> <CAHp75Vf8CDwW731uD4OMzB69P-D1AN3PzCMFBGGD4fvBFccpLg@mail.gmail.com>
 <92800c93-9d03-ab26-e71f-ce40df1ad3bc@redhat.com>
In-Reply-To: <92800c93-9d03-ab26-e71f-ce40df1ad3bc@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Dec 2019 17:08:15 +0200
Message-ID: <CAHp75Ve7wsd96yn97JihBq1QpLkKLtuhqKvcp-o8yeviCTvkwA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: hp-wmi: Make buffer for HPWMI_FEATURE2_QUERY
 128 bytes
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 1:18 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 18-12-2019 11:17, Andy Shevchenko wrote:
> > On Tue, Dec 17, 2019 at 9:06 PM Hans de Goede <hdegoede@redhat.com> wrote:

> > Fixes tag?
>
> The HPWMI_FEATURE2_QUERY call was introduced in 8a1513b4932, so I guess
> this should have a:
>
> Fixes: 8a1513b4932 ("hp-wmi: limit hotkey enable")
>
> Tag, shall I send a v2 with this, or can you add it while applying the patch?

I added it.

-- 
With Best Regards,
Andy Shevchenko
