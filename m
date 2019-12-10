Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ACAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 01:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7913720409
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 01:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bc1Zhe8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfLJBcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 20:32:24 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44939 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfLJBcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 20:32:24 -0500
Received: by mail-ed1-f66.google.com with SMTP id cm12so14467960edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 17:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UqpJfCF3D37VJfuOPskNhpW2JeHH9pFB4KOKdtTwdyQ=;
        b=bc1Zhe8iLIdRObEFSjlQQuOohVLEC8vKyYzA1AhMpnkg23ydBYOsTXGqxbFY2BnzZv
         sDJHcRuH1dvhGlYTlPEewsWKTo2ey87r/5x/TgaLjuTIdd98v3lyMyQ90PqM1ccoTEXM
         ez06WR/C+KGLRP5Kkh2nSd12PRi9jGaxnX7Q65kagz5nGUJxFc2j2cf33vOdjVgwCtsE
         SdeC3hWh4UqeV4QiaW7rfTJYI+mlbJ8V/4J7YDVC/EL4JK8XOZISzqQhgtbulLgWi+Ph
         X2sZAh3bFx7U1xwuf4u4XDsMeHYLQ4WXI/dOF2/7VmXvL9NXOo4AS3FMruNACmkup0PA
         LJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UqpJfCF3D37VJfuOPskNhpW2JeHH9pFB4KOKdtTwdyQ=;
        b=HrCZ6rcc/wQJab/QMyfzjDyavB/VS3TJJX+ue2HmNTz36AJw0RGwtBn0pWHsJiAsTx
         0q/j33FqaY6gRx9qSZt+JNjSle7BSGYsjaAHTGeShJ3m+bpAI6lD/t8Ak5oHZSD8Rzx8
         O+ZPsJTKtpHmuvKcR/Kqg5bpJgrOw7HkmmoPTGZlQMYY+ZelyuryYBei7RdE0P/O0zFy
         GuihH+AVW/auEdPvKZxvqu65No4wp1hbyWfFobxX7hjx+Qux94jLEdRpmGwuYKAV8qIj
         YtofFiHbk6hoEF2gUpAmfmj/KBUioncvNEWLMb2wqcmdudML+l1EESVeuVCw0k4utH77
         ENzQ==
X-Gm-Message-State: APjAAAXaKDww5t7HQFMTbIwF39Iz9SbisFhhjyGaWsVEt0tWxD2GIH4F
        juaAGwbAUYsMdxRqyVifg2nfwoGfsDgKZhEeTH8=
X-Google-Smtp-Source: APXvYqzoQKcEO+//0TtUd5SF6PyfOZAfzGEaD7PMtndDhtaaPIzXRivESHfO0JOWC2PfFXQDLLBG/Nu+5s9k46RmiOs=
X-Received: by 2002:aa7:d345:: with SMTP id m5mr36626481edr.149.1575941542654;
 Mon, 09 Dec 2019 17:32:22 -0800 (PST)
MIME-Version: 1.0
References: <20191206075209.18068-1-hslester96@gmail.com> <20191209162417.GD5483@sirena.org.uk>
 <CANhBUQ0zwQG-=C12v02cf5kfvJba=5_=0JkZA45DDhxOzTBY6A@mail.gmail.com> <20191209170030.GH5483@sirena.org.uk>
In-Reply-To: <20191209170030.GH5483@sirena.org.uk>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Tue, 10 Dec 2019 09:32:12 +0800
Message-ID: <CANhBUQ0-jEG2W=sby1SyPphxK3CSPinFF5zkLq9jsKCZM5hYjw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: cs42l42: add missed regulator_bulk_disable in
 remove and fix probe failure
To:     Mark Brown <broonie@kernel.org>
Cc:     Brian Austin <brian.austin@cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        James Schulman <james.schulman@cirrus.com>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 1:00 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Dec 10, 2019 at 12:52:30AM +0800, Chuhong Yuan wrote:
>
> > I have a question that what if CONFIG_PM is not defined?
> > Since I have met runtime PM before in the patch
> > a31eda65ba21 ("net: fec: fix clock count mis-match").
> > I learned there that in some cases CONFIG_PM is not defined so runtime PM
> > cannot take effect.
> > Therefore, undo operations should still exist in remove functions.
>
> There's also the case where runtime PM is there and the device is active
> at suspend - it's not that there isn't a problem, it's that we can't
> unconditionally do a disable because we don't know if there was a
> matching enable.  It'll need to be conditional on the runtime PM state.

How about adding a check like #ifndef CONFIG_PM?
I use this in an old version of the mentioned patch.
However, that is not accepted since it seems not symmetric with enable
in the probe.
But I don't find an explicit runtime PM call in the probe here so the
revision pattern of
("net: fec: fix clock count mis-match") seems not applicable.
So I think adding a check is acceptable here, at least it solves the problem.
