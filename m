Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A588C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2F8229F9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NtCq+FPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfGZMKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 08:10:43 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35014 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfGZMKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:10:43 -0400
Received: by mail-vs1-f67.google.com with SMTP id u124so35941961vsu.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 05:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Hk/ddKDjoh3rwEJrDhaz3iODFHsGs5iANDx40FYTho=;
        b=NtCq+FPK94+cvz+LxBD1ik58Euv8pnMYGOB5sJi8/gCvTrdjnxQzLolpowpC9ijbye
         C59/PhPvLwAPBORN4l7mgwO+HQTjyloYV1GDx/oFwYaJv1XfXqW9k9eUqWz1HQfjtj34
         LZoMbu4mHtz2br0/8RyvDY/R80R4B4J+9YjaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Hk/ddKDjoh3rwEJrDhaz3iODFHsGs5iANDx40FYTho=;
        b=svPY770NhbXQakKjfBJfW1QqTn25wfnYz0qWPnNum7eD6aI+TJ6MJcM5vmgJLsYCkD
         PJg/YItRNvvg2jZoQ1E40opegmDMYXO4QOHzIk0+s88i7jMyIf5B5MjAj5QBhvIC3X+3
         RPn058/CxL1wR6QWmUu9NAB9R99vpF8gBHaeUSjV4yLF2dWI5t3uZnCz6yOxViObMcRO
         meaqCz0tDVi0t1NpjJnt7ChA6+sCl8oT2txFmzBvvYGdEjwYPAZFTt5Xb1TrNKI4HuP2
         dW0JnAyHadBupHVszBDypgrqHzUPQpmTIoq5Ag//EMVzwGuwdCOBEvuiohOQa82b8Xwe
         vBvg==
X-Gm-Message-State: APjAAAVInMSkOxoWoEfyfTRFDo/gZa3LtrT7EuX8T5zSIDUIUIO0TGyo
        IuJFhGJ/TANeJg4ccZrf0u8CUR0ElAJW9F4Muikzkg==
X-Google-Smtp-Source: APXvYqzvjy8zCiVZsbAMpzxFBmwdjzNDLhL/0NIc8p6K0jlM7GCFN0g706IM3lhQXZiAwJDLHY0z+t81Nwo+kvfoFcM=
X-Received: by 2002:a67:f7cd:: with SMTP id a13mr60241411vsp.163.1564143041404;
 Fri, 26 Jul 2019 05:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190726044202.26866-1-cychiang@chromium.org> <20190726111717.GB4902@sirena.org.uk>
In-Reply-To: <20190726111717.GB4902@sirena.org.uk>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Fri, 26 Jul 2019 20:10:15 +0800
Message-ID: <CAFv8NwLyTPXJ0x9F-wcGM-XFcCp+Nb1s96u9=_2xhs+=Q=E+fw@mail.gmail.com>
Subject: Re: [PATCH] Revert "ASoC: rockchip: i2s: Support mono capture"
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Heiko Stuebner <heiko@sntech.de>,
        Doug Anderson <dianders@chromium.org>,
        Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org,
        Matthias Kaehlcke <mka@chromium.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 7:17 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jul 26, 2019 at 12:42:02PM +0800, Cheng-Yi Chiang wrote:
> > This reverts commit db51707b9c9aeedd310ebce60f15d5bb006567e0.
> >
> > Previous discussion in
>
> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.
>
>
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.
Hi Mark,
Thank you for the reply.
Fixed the title and commit messages in v2.
