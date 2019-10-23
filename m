Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95638CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65044214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyFVYm5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390455AbfJWMi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:38:56 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:45328 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732680AbfJWMiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:38:55 -0400
Received: by mail-il1-f195.google.com with SMTP id u1so18717581ilq.12;
        Wed, 23 Oct 2019 05:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HjfcC+LWRIyOsNxEHwYIpjkdYtQXmiWTIubUTXxO2eo=;
        b=RyFVYm5QcD/pDncnlALI3oYymUXhSlp+xSfaaBOUsTaRawqVrzjBGbEt/uSImBrYNQ
         v3NPD1GAmEm5Z58MfMXl/7vp6RAbNCRKwkcZlNJBrRnwHHhHHSKl++O1Dj/P6WHWXfgI
         4ChEbP2qVOr/+h+Ti971lfr8GPaUEH/UoWxJsH7nJra3NOJ9RlLi7ONqNmN/8OXytcAY
         xtaQdAk0fucOMD8gKtq+iVFoIzfVGGkb2yt1K36PwI7xR4dw499OOLKW+2TOpvWwBW/r
         U14/r2mJ1boN8AwJObH4CF+yuiGpf2ALMPs1jS4RJBBe096rtBlnS5LVeuXPEBGGbNFj
         vnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HjfcC+LWRIyOsNxEHwYIpjkdYtQXmiWTIubUTXxO2eo=;
        b=nekMdu0VZ1CuzMpTmMDfZjtMWd1hQ1ybaFui1doGPxNySAypAD8PIykAxEb7Qm1biJ
         YvH/35HxBInjjR2gCy72Q7KECdFarBW2fw8TqDXaN5/iWpZ42BThmR9nGpi1SRy0CyTW
         SN+F9v9P78jJidU6le4Mrvhl0t49U5PV9K3aSFSXYoEpP/6Yb3TRC4QPVKXdaxRMKMGe
         6V2hwItkGiyNj44VXzzhQe1576zXGq57wlWdfoFRK7EVm6yrN9MYRJOVvXsGGNeV1mwI
         sTIwfGWfVYXkTiDaHQJK2fRsX8MAwSQ85WzZrKuc0CadTlnurTPOFr3Kd4VW++Pu7RiK
         q2cg==
X-Gm-Message-State: APjAAAXJsvFOlmlonFYtqbwojp6K1EvkwAj9+ASdj29HlJgqyPoxXDiA
        9BdQZZUmRTo9tQ3qST99irTTPdjheM46VxrsSGI=
X-Google-Smtp-Source: APXvYqxtHmlkACdtW1f6pccY35u7IhqbrLYqUejRnnHxLMYHWGZo78EH3dBev8jkJ6/XmjTx1ZFvlCEPuVe1iPOQ6Vo=
X-Received: by 2002:a92:5c4f:: with SMTP id q76mr9669699ilb.158.1571834334838;
 Wed, 23 Oct 2019 05:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191002114626.12407-1-aford173@gmail.com> <1550E9D9-43ED-4345-A9AF-6D9F097FC64E@holtmann.org>
 <CAHCN7xKA9-K4uYU9oFW+A7ywc8TGixNa-yHJgL7uSTbyXnisTQ@mail.gmail.com>
In-Reply-To: <CAHCN7xKA9-K4uYU9oFW+A7ywc8TGixNa-yHJgL7uSTbyXnisTQ@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 23 Oct 2019 07:38:43 -0500
Message-ID: <CAHCN7xKAkYacV6qWuONVqRyJuODt2mNquTWAgEFb0NcjjqpnsA@mail.gmail.com>
Subject: Re: [PATCH] Revert "Bluetooth: hci_ll: set operational frequency earlier"
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam Ford <adam.ford@logicpd.com>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 12:57 PM Adam Ford <aford173@gmail.com> wrote:
>
> On Wed, Oct 16, 2019 at 1:36 PM Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > Hi Adam,
> >
> > > As nice as it would be to update firmware faster, that patch broke
> > > at least two different boards, an OMAP4+WL1285 based Motorola Droid
> > > 4, as reported by Sebasian Reichel and the Logic PD i.MX6Q +
> > > WL1837MOD.
> > >
> > > This reverts commit a2e02f38eff84f199c8e32359eb213f81f270047.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > patch has been applied to bluetooth-next tree.
>
> Any change this can get pushed upstream to stable?  (including 5.4?)
>

Marcel,  I have confirmed this revert also fixes a regression on my
omap36xx based device using a wl1283 Bluetooth.  At this point, I
believe we've identified at least 3 devices with regressions that this
revert fixes.

adam
> adam
> >
> > Regards
> >
> > Marcel
> >
