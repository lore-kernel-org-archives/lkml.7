Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B87C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091AC208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAqmR1eZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfGaR7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:59:51 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39996 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfGaR7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:59:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id m8so32916232lji.7;
        Wed, 31 Jul 2019 10:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aNRijp+cTPu7tG+bLIT1XlN5J+/qM79IIyt09eNd6hY=;
        b=ZAqmR1eZLTBi3vNW9AZmdo/KYKvn/Nxv8o+gLNgKf22x19kMol7U7Y7Z3R50DaRmWm
         s+DkcGpZwFQC580FJ+AX2DkSBENFW2GQk42vdw4Aod7zfR6tvZUX0AKkJPyYGsgZ8jQu
         7FvgiD/IX6X3jQ8g00xTTr7RUnhwDnUXkG+79oE7pFfbU1lSvTyV70+zYNCEUJL786nL
         NgqLnyoo0eWJPSxgs1gc1l91S1Kz/ocwfQkiGSb6d92zPjgOuFNw8epsadf3SNQpoIMD
         tEXwENeFFFsWFQ5jhFPZuCs+unwaqCjo4klG1IEb78kGooZZoS+jeb+0eM+YYbz4oGVK
         YhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNRijp+cTPu7tG+bLIT1XlN5J+/qM79IIyt09eNd6hY=;
        b=gHIyV8l9R82sBKTvAheo4pTgQ/Ln0RVbW3nV9nj1wbt4ALBQ8FRtEKJ9JPSFZFB94b
         iYQ7tftfykwGqA+sw2kY5K04G3CP+ilPJ6JAcA91a4f8fC23YUfFIiZP5+NuD6POs3DK
         McDTUrhXfCvNM1YBBivXTSRx9ouPBEWFtI+FhoXKVjNtCU7zDRr/KobEPRyccwiLoCrm
         zv7qQLZcV5wEnDc8Rt7fl58UFIWBti9l+NfBO6DDo9edpRbzc0fsFz/MqZVjdPB+NGHY
         3LEFmYk9oMQARdxPl2g1BX5XWvZEW+iV8wMQ82D1pwPKTfo+wswjjGCLgd+IQ7P/XrwT
         z6rg==
X-Gm-Message-State: APjAAAVgp7lscgxtGrECjRLM+MNTowDpBT3d+jNNnS1fbYidL3lnG281
        1eEapuj6YzJzV3oDPNu3BCFnqHvUH8kltZF1wy4=
X-Google-Smtp-Source: APXvYqycnbqijwzHTbQDpHhXHrX7zs1AsM7k0qebBLeKaeSeGLo/kTqTweH4TcuUWWZR3EkBGeb74IIqOj+U6k55ixY=
X-Received: by 2002:a2e:a311:: with SMTP id l17mr2125199lje.214.1564595987679;
 Wed, 31 Jul 2019 10:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 31 Jul 2019 14:59:59 -0300
Message-ID: <CAOMZO5BL1BO7XGNgwqZRRCeWNURemZEVzP26kVBacyw__0=RBA@mail.gmail.com>
Subject: Re: [PATCH v2 00/23] LPUART fixes and improvements
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-serial@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Wed, Jul 31, 2019 at 2:53 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Everyone:
>
> This series contains fixes/improvements to LPUART dirver I came up
> with recently as well as fixes picked up from Toradex and NXP Vybrid
> repos.
>
> Feedback is welcome!
>
> Changes since [v1]:

Greg has already applied some of these patches:
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/log/?h=tty-testing

Please rebase on his tree and send the remaining ones.

Thanks
