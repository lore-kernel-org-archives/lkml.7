Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481EDC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 05:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A916206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 05:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573708529;
	bh=WigUSF3alcgcj3pSwFXkYJTAsdWSBKH1LxuGN0UIWDw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eAQblnLU/s7cnztOvDe0XPtZGaR6mCw52baTW5O6P8ueEDDbY7Jv/R6vVup980LPL
	 AGkzz14Zda4dv+4lz38wKbh1yz9g3rVoPjqRUcwn8aaGcyK/ZaPN3LmBxqMMp5sLz6
	 C18bfqF0BLvYEWdNKSIbXtX6++7EEFEU7kqn2XPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfKNFP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 00:15:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfKNFP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 00:15:28 -0500
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F0EA20706;
        Thu, 14 Nov 2019 05:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573708527;
        bh=WigUSF3alcgcj3pSwFXkYJTAsdWSBKH1LxuGN0UIWDw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hfgI9clc/bfFjOJFNB8C3UnyfZXN9St0vvpgPg/LyZdPTevrQKGiWvHgi+DnGBZaa
         ZYT84kVbh/eZSglzPmBmRMhXVUUXNHrsxH0co3c4tcKweJVZbfuqDHUDvczV5IEAu5
         OX7MG6Aqd2BpTIhh+V2DBODnIkR0Uwxqxi+myWC4=
Received: by mail-qv1-f51.google.com with SMTP id g18so1849816qvp.8;
        Wed, 13 Nov 2019 21:15:27 -0800 (PST)
X-Gm-Message-State: APjAAAXIWE/+YLTIwHJLQNqhGN9VtiMgJPwuIfVya+uMqa4SeW1seBw/
        OxkACUTqiFG53GEZ0O7Vc0cbWw/jjmLPqWG8Pvs=
X-Google-Smtp-Source: APXvYqwlPTIblvxl8u3zUhl8hD3W9ECXciROrFiU7RcbJjYQxah0YbroDoQ4zkxAaXhihEABx4qt8MPf48+py6OCV2g=
X-Received: by 2002:ad4:462d:: with SMTP id x13mr6475849qvv.105.1573708526559;
 Wed, 13 Nov 2019 21:15:26 -0800 (PST)
MIME-Version: 1.0
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk> <20191108130123.6839-31-linux@rasmusvillemoes.dk>
In-Reply-To: <20191108130123.6839-31-linux@rasmusvillemoes.dk>
From:   Timur Tabi <timur@kernel.org>
Date:   Wed, 13 Nov 2019 23:14:49 -0600
X-Gmail-Original-Message-ID: <CAOZdJXVQ_wQLK-4uutb2e6zOt0b8FBVY3qoWdoo4UM8p7=bV0A@mail.gmail.com>
Message-ID: <CAOZdJXVQ_wQLK-4uutb2e6zOt0b8FBVY3qoWdoo4UM8p7=bV0A@mail.gmail.com>
Subject: Re: [PATCH v4 30/47] serial: ucc_uart: factor out soft_uart initialization
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 7:03 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> -       /*
> -        * Determine if we need Soft-UART mode
> -        */
>         if (of_find_property(np, "soft-uart", NULL)) {
>                 dev_dbg(&ofdev->dev, "using Soft-UART mode\n");
>                 soft_uart = 1;
> +       } else {
> +               return 0;
>         }

How about:

if (!of_find_property(np, "soft-uart", NULL))
    return 0;

And I think you should be able to get rid of the "soft_uart" variable.
