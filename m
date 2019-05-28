Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F77C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24EF2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LVkQuv+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfE1K2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:28:32 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43863 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfE1K2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:28:32 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so2680443qka.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 03:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xz9jNowfVrFFO0jkhxu7a5SO0l+Nom3Gou3ZN0J7IBc=;
        b=LVkQuv+d4Z61jVunAcuoZBohB1dIA1Agnfvadw94zwI2iH3GEX56rrnbOXmuC8Cd9R
         DwFKjSQiWb7xDz/iDu/9PwmwsG4MnzJO9WV2NnpH0Ktg4LBopjzGKClOYbrC+TXMbdr2
         YknJlnHh3lIFmTYLr8J6FsfB19zBRr3tLjc5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xz9jNowfVrFFO0jkhxu7a5SO0l+Nom3Gou3ZN0J7IBc=;
        b=tv0H9b0rbEBq680qmUla+m0Ymvo2+t211QFiX1+/IZ3jNWhSBdDWLkq01Xkdgt3W43
         fwffe+3iVgsx03fAjmXElJPCefAdkE/Zz42DWtFK/qiqTInebZY3XdBGnpd2k4szMUbc
         SlO0lJ7lhhCR2gaMfu0mUf9Su0lgXS8knDEm6GOOOV98Plaa9viLq+/VfDAr4G5zGSHN
         zvsnKph55BlQYxHdhlz/v/ESE3HAN1KvbcubBy40JmN4cglOlFbai4wel5S7Dn9jqvuS
         McJ4L0LKwkL5m8w/ChqOTUb73rSMyIrrVB0EggQa9ZJd6mBFWJdIp7PsY/gKUceLZYBL
         zj6A==
X-Gm-Message-State: APjAAAW9UVC88xAhDvYft/dpoqV0FlaFBY9clmBKEbK0dNtGo6McIYdT
        obzxQ+SHkmzQrrjWzK/dmWMmSIHzOAvxG+Y8h75mTA==
X-Google-Smtp-Source: APXvYqwVkGxHWipHaEkBIORw+tvSgvbfu/oyWYIW/IKz+5lBhbE5lQGMv18OSrZexFtTZls92nSRw4gRnphaIp17YKk=
X-Received: by 2002:a0c:e849:: with SMTP id l9mr1816939qvo.3.1559039311418;
 Tue, 28 May 2019 03:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190521234148.64060-1-drinkcat@chromium.org> <11be5350-23db-6216-3c2b-1d8b161cac9b@yandex-team.ru>
In-Reply-To: <11be5350-23db-6216-3c2b-1d8b161cac9b@yandex-team.ru>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 28 May 2019 18:28:20 +0800
Message-ID: <CANMq1KDUCJhEKPSnjoCB=PyrvU3zF77miPC8Kqy2ttporMst8A@mail.gmail.com>
Subject: Re: [PATCH] scripts/decode_stacktrace: Look for modules with
 .ko.debug extension
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 4:38 PM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
>
> On 22.05.2019 2:41, Nicolas Boichat wrote:
> > In Chromium OS kernel builds, we split the debug information as
> > .ko.debug files, and that's what decode_stacktrace.sh needs to use.
> >
> > Relax objfile matching rule to allow any .ko* file to be matched.
> >
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > ---
> >   scripts/decode_stacktrace.sh | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
> > index bcdd45df3f5127a..c851c1eb16f9cf7 100755
> > --- a/scripts/decode_stacktrace.sh
> > +++ b/scripts/decode_stacktrace.sh
> > @@ -28,7 +28,7 @@ parse_symbol() {
> >               local objfile=${modcache[$module]}
> >       else
> >               [[ $modpath == "" ]] && return
> > -             local objfile=$(find "$modpath" -name $module.ko -print -quit)
> > +             local objfile=$(find "$modpath" -name $module.ko* -print -quit)
>
> Ok but should be quoted "$module.ko*" or escaped $module.ko\*

Thanks for noticing, will send a v2 right away.

> >               [[ $objfile == "" ]] && return
> >               modcache[$module]=$objfile
> >       fi
> >
