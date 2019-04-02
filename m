Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BE4C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39042084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AJO3IU5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbfDBPxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:53:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40393 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfDBPxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:53:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so17291921wre.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 08:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+zmX98tXbi+xY0zAH0xz9iVxstlsGr5BVN7FYTplPg=;
        b=AJO3IU5H8LYqrmSculMBB1AmkO3SfwVlMi2lm/9y1gbOsZOy3miNngzfZVXCfQo+e0
         8OKYNV2Na5WEjJVUwYbYX0NEkg8aSPgtLXItehpIej4WM1Ex+jn4RcIiQ3E+bDeH9lHd
         5orCz04DjsDM6IzfJY3lG9IvBMJKIoJVIAllU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+zmX98tXbi+xY0zAH0xz9iVxstlsGr5BVN7FYTplPg=;
        b=KHBSIhwX7lf1GrHFjy06zG4O8i2TDLRM3K1k4/FYrmy4i37jGmu2xHPYQwAb9a6Fhw
         AhYEU3aiMAsQ99wErw9228+TyUNUBzc8q3FoYnmCdX6LWGlKNgjSt4btODSW8rojjVeP
         B7Bx6WzYChQbHLtNfEICcgTZIIPK/bWWAw7Y1MopRkspXmSLYmv+v3L7gfjKA23WPvUl
         RTV8iPU1yGEsRabL5thgqwuJjMkdDugqtyCItBSRQ+uiHlz+/pGrxTGKNcJf1HZ4SxJ3
         R5UtjdzIEykv7Kg5XYVIt4vfvQnsak9/hV93hDND2ReGzeVyLhemKMWoQhAa7rk8a1xB
         tO1A==
X-Gm-Message-State: APjAAAVQFi+mL7nZ4iNKPuB1EuZNZQOX1CBy5O3mFPGH0Zlc8VPEmDro
        cwhd0v5VM6a7rKBkR1Uwjusi9riq83mxtYoPoVQShg==
X-Google-Smtp-Source: APXvYqxr6zRW3AOWeMwfJart5dDelVrMdQlBUAWF10IE4Dseut77e+Xyf6eruHcHipsxtXad3I2x5GYEm9NcjrpcdDw=
X-Received: by 2002:adf:eb84:: with SMTP id t4mr48722512wrn.100.1554220402591;
 Tue, 02 Apr 2019 08:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190401205519.34023-1-fletcherw@chromium.org>
 <20190401205519.34023-2-fletcherw@chromium.org> <20190402050637.GW2059@sirena.org.uk>
In-Reply-To: <20190402050637.GW2059@sirena.org.uk>
From:   Fletcher Woodruff <fletcherw@chromium.org>
Date:   Tue, 2 Apr 2019 09:52:56 -0600
Message-ID: <CAN-6NYYPL=W66vnnqbXK+LBFbuSnpqL8iv+h_x4G67PWFsMoKA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: rt5677: make ACPI property names match _DSD
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        alsa-devel@alsa-project.org, Ross Zwisler <zwisler@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 11:06 PM Mark Brown <broonie@kernel.org> wrote:
> On Mon, Apr 01, 2019 at 02:55:19PM -0600, Fletcher Woodruff wrote:
> > The rt5677 driver is using the wrong property names to read from ACPI.
> > Update the property names to match those from _DSD, so that the correct
> > GPIO pin numbers are read and that plug-detection works.
>
> > With this patch, plugging and unplugging the headphone jack switches
> > between headphones and speakers automatically.
>
> What makes you say that these properties are wrong?  Are you sure that
> this isn't just some other systems using different ACPI properties given
> the poor standardization for ACPI?  Your new ones look like they're DT
> properties pulled into ACPI while the existing ones look more idiomatic
> for ACPI.

The code to read those properties was originally added by commit 89128534f,
specifically to support the device I am trying to fix, the Chromebook
Pixel 2015.
Admittedly, it's possible some other device came along and matched these
property names since then, but I'm inclined to think we might be the only ones.

> It'd be fine to add your new DT style properties but this
> might break existing systems.

That said, I agree it would be safer to use the idiomatic ACPI names, and then
fall back to the DT style names if the idiomatic names fail. Does that sound
reasonable?
