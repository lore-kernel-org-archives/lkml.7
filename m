Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE26C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DAE208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFjHxYGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfHJIpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 04:45:36 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46718 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfHJIpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 04:45:36 -0400
Received: by mail-yb1-f194.google.com with SMTP id w196so8776570ybe.13;
        Sat, 10 Aug 2019 01:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4N2DP4l2LpXR0ja9/QlgTCxk89cb9ApRuW6Y7KL7/QM=;
        b=tFjHxYGsshA6uhC4ZyO8gQA5CGqOklLRWWxRbDw74L/pi+b9ttnCV0SxJXzM1GWIvS
         F9rYQq1hBhIsaxKOI08ZyaGxkadwK312OhWil5n/UwwkKSmadnu/olRJh1TePylAFF1P
         4ktVi+A2LsntpLrg+0r5GSjYQS6MoaBf5QcbFDhiWv7xJnDJnGAAFTUKJLcAwhajChY9
         OyZKinHBA6UhYKPjOgT2ZHjTfw/jp+Njsc09CGDN2oGgyuMarC1b8lJbRsvnx9Il0N93
         Q2aGmNoPzI8TmYFqu0vVtm5p9ZXDTei6QktQwpM52ZY7q5UI24kSvWdBmw3r3ttiWOfn
         PRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4N2DP4l2LpXR0ja9/QlgTCxk89cb9ApRuW6Y7KL7/QM=;
        b=e0jFvHJrt/Ei0HgtWqj5//2isnrkp+vyAXTitNstIFCReo/eYytWQlBOU+Qh3Eapj2
         6dDvh3A1IjSzqsiQYeloC6Ryo3QimUeNiQOTBiTiOBsOUIfg+bzhrWKr6Xyym3vIcmuT
         Pze5YCJ/shKbWejTHE8o5PGJm3TEPI7Sh5UVBP5t152VDcEubxTDjoyJRF5PIyW0Owq2
         pouUXcKgac/psoQ6mYFfgcDg97iLyVgzebtkqf5BG68JHD/xaU6RfRst67p6yr4fSEtx
         gYrzcRD6lF3tS+aibUmHP7neV7IzCmvHllivGgNvRNXHXVtDbDSu0QyJYsnXKFe3eILj
         f7gg==
X-Gm-Message-State: APjAAAULcyvAW4L7qXx95o9aAJXVAKaDBia8rDbMUM+mi2t30pbRlpur
        QwaAWjTCvj2X4zwt+RxT73+8vY74dQrJ9mkIbUc=
X-Google-Smtp-Source: APXvYqwYP1MVAOUz7wJvEpUhVTE97jzCm1T5VZgDMaOxdDC99C9zKxDOMpuB6Lus4uMwey10ooqmjZMMWn1jbSlbvgQ=
X-Received: by 2002:a25:9109:: with SMTP id v9mr17429940ybl.396.1565426734980;
 Sat, 10 Aug 2019 01:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190527200627.8635-1-peron.clem@gmail.com> <CAJiuCcfUhBxEr=o7VVpPROQZadQh7z1QC0SkWSYt-53Sj3H2qw@mail.gmail.com>
 <CAJiuCcc3_1jZWV7G3+fFQYRZ8b6qcAbnH+K6pkRvww6_D=OMAw@mail.gmail.com> <20190715193842.GC4503@sirena.org.uk>
In-Reply-To: <20190715193842.GC4503@sirena.org.uk>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 10 Aug 2019 10:45:23 +0200
Message-ID: <CAJiuCceYDnyxRLLLLy6Dn6DLTZ+NmSaUnoX1Vmzvgiy0XvF_Fw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Allwinner H6 SPDIF support
To:     Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry, I just discovered that the ASoC patches have been merged into
the broonie and linus tree in 5.3.

I'm still quite new in the sending of patches to the Kernel but
souldn't be a ack or a mail sent to warn the sender when the series
are accepted?

Should 5/6/7 patches be picked by Sunxi maintainer?

Thanks,
Cl=C3=A9ment





On Mon, 15 Jul 2019 at 21:38, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jul 15, 2019 at 09:21:01PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi,
> >
> > I'm missing ACK from ASoC Maintainers patch 2-3-4.
> >
> > It's really small paches, if you could have a look at it.
>
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.
>
> Sending content free pings adds to the mail volume (if they are seen at
> all) which is often the problem and since they can't be reviewed
> directly if something has gone wrong you'll have to resend the patches
> anyway, so sending again is generally a better approach though there are
> some other maintainers who like them - if in doubt look at how patches
> for the subsystem are normally handled.
