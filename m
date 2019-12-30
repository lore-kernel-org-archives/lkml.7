Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C8BC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 03:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0A82071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 03:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="mC8RgrJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfL3DKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 22:10:47 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43540 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfL3DKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 22:10:47 -0500
Received: by mail-ot1-f67.google.com with SMTP id p8so8154136oth.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 19:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=81fRmvyWTv5k/sEdvZr3Z/mRekQZD2TNFxEA5JN8n3A=;
        b=mC8RgrJtOgc8rzUx31JyYW7Afc0uU0dmZaffNviHyn4/1i1PlE7Wgb0GCVXIjGKN1n
         aHk40A46zhiGi2ifDG/6zdblfzGFwPzF50XwO3zoV1K8XH1r4o/I7JzOJA5Jr18b30qx
         05mvDjlBms7NBx29DEcxB18iQ9u8ynj/WDLyCHpMgn073+8qvoUleQxFIzqvCF0EHJ8G
         4GAe9AGTYkkkC0jbgWD9YyV+xwcoazkRGbnU16Jgt7smEy5Ov+/BhwYq0S1OwoVMtYwj
         xDfxVnrJz3rKFfL1RXQ+s5++r5Lgsf8nvQsFd7ZcvE97uhurnrnxaMgexsxL+XBCyN9L
         60hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81fRmvyWTv5k/sEdvZr3Z/mRekQZD2TNFxEA5JN8n3A=;
        b=nY+1G1StdY7GZwpyhk/cGvnSFtPQwGg0aivUw+8LlFg7w0VUds9MDIGz8X6Rx9yQuC
         2uqH7P3P8UlTLSE48+ANr9+lwahdEcHtCxtudCW5l0OB/0ZqaWTafML/q/mIaHHK1hxU
         Msr5z4H3D2cBt/RoRIPo9vcI0LqbL6FZvSEULNsL5dfsZlVBo32lN/LRGRS0mGOyXNMm
         3/kvboTPWsO4dxAZ8BXJZj42rbQnK96Gx7PanNrbux+fEbzBj+bSODEquoa84+OqJyiP
         jR4cIV9wBVo/Scye+hjZxYi34Tx11Aw4HeV0jCn+niN74DBtEqjWMdm7o8DJL1KkzRWS
         edfw==
X-Gm-Message-State: APjAAAU/ChKAlXz4qtU7O86NB8pzXAWKiQaGDCqiNCU4JD8hM4+28I1M
        zTIzSkvqcuZbItWvUnfmEIySyQ40IewVYXZ1cfPvQVCVdR0=
X-Google-Smtp-Source: APXvYqzJb+uB5liVLrHfYVKk67gMjY0PJ9sfI1BNzA+hrqawYhJ642k8YVlCYk/+pB5j9R7jBiNcCo2XAEgOZxWcOI8=
X-Received: by 2002:a9d:2c68:: with SMTP id f95mr72904555otb.33.1577675446489;
 Sun, 29 Dec 2019 19:10:46 -0800 (PST)
MIME-Version: 1.0
References: <20191227100825.75790-1-chiu@endlessm.com> <s5h4kxk6fkh.wl-tiwai@suse.de>
In-Reply-To: <s5h4kxk6fkh.wl-tiwai@suse.de>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Mon, 30 Dec 2019 11:12:46 +0800
Message-ID: <CAB4CAwd=DNOqsRDEB5tRtN7yUgkM6fXi3yy5-PzW=3cCx=_45A@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/realtek - Enable the bass speaker of ASUS UX431FLC
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, Kailang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>, tomas.espeleta@gmail.com,
        alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2019 at 4:05 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 27 Dec 2019 11:08:25 +0100,
> Chris Chiu wrote:
> >
> > ASUS reported that there's an bass speaker in addition to internal
> > speaker and it uses DAC 0x02. It was not enabled in the commit
> > 436e25505f34 ("ALSA: hda/realtek - Enable internal speaker of ASUS
> > UX431FLC") which only enables the amplifier for the front speaker.
> > This commit enables the bass speaker on top of the aforementioned
> > work to improve the acoustic experience.
> >
> > Signed-off-by: Chris Chiu <chiu@endlessm.com>
> > Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> > ---
> >
> > Notes:
> >   v2:
> >    - Use existing alc285_fixup_speaker2_to_dac1 instead of new fixup function
> >    - Correct the commit hash number in the commit message
> >    - Remove the redundant fixup ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC
>
> Could you rebase on the latest for-linus branch?  This patch isn't
> applied cleanly any longer.
>
>
> thanks,
>
> Takashi

Got it. I'll prepare a v3 to rebase on latest for-lnus.

Chris
