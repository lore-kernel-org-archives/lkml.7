Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B95FC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A1020866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGLDjzc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfFNNjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:39:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46100 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbfFNNjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:39:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so2414210ljg.13;
        Fri, 14 Jun 2019 06:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AjTMOzs837XNR62T4NquNPdEGLL6y8lxVErfJyNIXO0=;
        b=pGLDjzc7PXeMDfAMruzk4ufkIzQ6Zvx4sSdb74pyHKqFYVimr7mzjX5QXMhpswfmHO
         fno0X2AWiFKZDRCmwfie8KF2Qq+c6FNPyFVtgQTzmJ4QD1ia5Y4NVnckG+xZ28CStngL
         LpLxNaYtFos4O+m/dFcYsfNPXFxjF3tL/MKMVxKnz5BDRGiq8luzWp0gK4URXWT0yPo7
         9Df741RyrovRWdYFnxviUdnT2TT6czcO2R6Tr2IXBaD3X/ypzxMUAsVfJRaYEHdHcQvd
         OYtex2qyA1rpGYBuC3CsK+VoH6sQqpmsAFWP/v/tVFMzqHZ0voqhndt/dOX7YoygV4Lv
         4siQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AjTMOzs837XNR62T4NquNPdEGLL6y8lxVErfJyNIXO0=;
        b=WWZQ8spcbvyxTopVpQ/YGLSV+6AFExhkKflEE4a44sqnTwcQqd7dsISY1RLa3MOKIf
         9v/djxocfns240JHLQ/PwshyfE72uUpew+WNNE+DlQ+FwdqlUxGKyceW9EmbDliJ4e3q
         KBXb/DHup4qRPMlWGFVilMjkGm75tQotuffby76GZk7JCunRXjXpSzBv3jteULydxiB2
         SV/YA0byB5GnRQVrGsvPGqUZEk7Gx9Y0FZsWBbb12RxTCy0eW2zyFSYb8GvHnbledBfJ
         ecLmleNnnCOoUbqtTOMTYWWghV6+D/R/bRhjyD3HmNzHUhpq5Wmzx22CUKdK62ck6JuK
         H02g==
X-Gm-Message-State: APjAAAUbH/XpbVfGgSsiiDFVtundyZEDJVdAiiYKFS8E7QAwKjhRShAC
        +YGc7/xjRfPWcejO6m7PpNfZvwwjxv8a4Mrcc/I=
X-Google-Smtp-Source: APXvYqyvVNdTlpd6Io5rnBknL56XP1TrwvTxhod1ZZP0mmr8JqFV9gxxk17cmUn+xEZj8AbjbG917FhYJq9W/JKnqVs=
X-Received: by 2002:a2e:970a:: with SMTP id r10mr31289953lji.115.1560519590606;
 Fri, 14 Jun 2019 06:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <1560513063-24995-1-git-send-email-robert.chiras@nxp.com>
 <1560513063-24995-3-git-send-email-robert.chiras@nxp.com> <CAOMZO5BAborMvk=4cgreWKX6rJjK-237me98dM1dDV53oUnExQ@mail.gmail.com>
 <1560518953.9328.31.camel@nxp.com>
In-Reply-To: <1560518953.9328.31.camel@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 14 Jun 2019 10:39:53 -0300
Message-ID: <CAOMZO5DcvKQPDhP468VSCfQkFy-7roKBkw7uqXxTMn9PTTgS+A@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH 2/2] drm/panel: Add support for Raydium RM67191
 panel driver
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 10:29 AM Robert Chiras <robert.chiras@nxp.com> wrote:

> The GPIO is active high, and the above sequence was received from the
> panel vendor in the following form:
>         SET_RESET_PIN(1);
>         MDELAY(10);
>         SET_RESET_PIN(0);
>         MDELAY(5);
>         SET_RESET_PIN(1);
>         MDELAY(20);
> I got rid of the first transition to high since seemed redundant.
> Also, according to the manual reference, the RSTB pin needs to be
> active high while operating the display.

That's exactly my point :-)

In normal operation the GPIO reset needs to be high.

During reset the GPIO reset needs to be low., which means that the
GPIO reset is "active low".

So you should invert both the dts and the driver to behave correctly.
